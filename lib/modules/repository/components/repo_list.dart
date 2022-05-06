import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gite/themes/app_colors.dart';

import '../repo_module.dart';

class RepoList extends StatefulWidget {
  const RepoList({Key? key}) : super(key: key);

  @override
  State<RepoList> createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepoBloc, RepoState>(builder: (context, state) {
      if (state is RepoStateInit && !context.read<RepoBloc>().onLoadMore) {
        return Center(
          child: Text('Please enter a term...'),
        );
      }

      if (state is RepoStateLoading && !context.read<RepoBloc>().onLoadMore) {
        return Center(
          child: CupertinoActivityIndicator(
            radius: 10,
            color: Colors.black,
          ),
        );
      }

      if (state is RepoStateLoaded) {
        if (state.repos.isEmpty) {
          return Center(
            child: Text('No data found...'),
          );
        } else {
          context.read<RepoBloc>().onLoadMore = false;
        }
      }

      if (state is RepoStateError) {
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
                !context.read<RepoBloc>().onLoadMore &&
                !context.read<RepoBloc>().onNavPage &&
                state is RepoStateLoaded) {
              context.read<RepoBloc>()
                ..onLoadMore = true
                ..add(LoadMoreRepo());
            }
          }),
        itemBuilder: (context, index) =>
            RepoItem(repoModel: context.read<RepoBloc>().repos[index]),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.dark,
        ),
        itemCount: context.read<RepoBloc>().repos.length,
      );
    }, listener: (context, state) {
      if (state is RepoStateLoaded &&
          state.repos.length == context.read<RepoBloc>().totalCount &&
          context.read<RepoBloc>().onLoadMore) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.dark.withOpacity(0.95),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'All data has been loaded...',
              style: TextStyle(
                color: AppColors.light,
              ),
            ),
          ),
        );
      }

      if (state is RepoStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.dark.withOpacity(0.9),
            content: Text(
              state.error,
              style: TextStyle(
                color: AppColors.light,
              ),
            ),
          ),
        );
        context.read<RepoBloc>().onLoadMore = false;
      }
      return;
    });
  }
}
