import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gite/themes/app_colors.dart';

import '../user_module.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(builder: (context, state) {
      if (state is UserStateInit && !context.read<UserBloc>().onLoadMore) {
        return Center(
          child: Text('Please enter a term...'),
        );
      }

      if (state is UserStateLoading && !context.read<UserBloc>().onLoadMore) {
        return Center(
          child: CupertinoActivityIndicator(
            radius: 10,
            color: Colors.black,
          ),
        );
      }

      if (state is UserStateLoaded) {
        if (state.users.isEmpty) {
          return Center(
            child: Text('No data found...'),
          );
        } else {
          context.read<UserBloc>().onLoadMore = false;
        }
      }

      if (state is UserStateError) {
        return Center(
          child: Text(state.error),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent &&
                !context.read<UserBloc>().onLoadMore &&
                !context.read<UserBloc>().onNavPage &&
                state is UserStateLoaded) {
              context.read<UserBloc>()
                ..onLoadMore = true
                ..add(LoadMoreUser());
            }
          }),
        itemBuilder: (context, index) =>
            UserItem(userModel: context.read<UserBloc>().users[index]),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.dark,
        ),
        itemCount: context.read<UserBloc>().users.length,
      );
    }, listener: (context, state) {
      if (state is UserStateLoaded &&
          state.users.length == context.read<UserBloc>().totalCount &&
          context.read<UserBloc>().onLoadMore) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.dark.withOpacity(0.95),
            behavior: SnackBarBehavior.floating,
            content: Text('All data has been loaded...'),
          ),
        );
      }

      if (state is UserStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.dark.withOpacity(0.9),
            content: Text(state.error),
          ),
        );
        context.read<UserBloc>().onLoadMore = false;
      }
      return;
    });
  }
}
