import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gite/themes/app_colors.dart';

import '../issue_module.dart';

class IssueList extends StatefulWidget {
  const IssueList({Key? key}) : super(key: key);

  @override
  State<IssueList> createState() => _IssueListState();
}

class _IssueListState extends State<IssueList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IssueBloc, IssueState>(builder: (context, state) {
      if (state is IssueStateInit && !context.read<IssueBloc>().onLoadMore) {
        return Center(
          child: Text('Please enter a term...'),
        );
      }

      if (state is IssueStateLoading && !context.read<IssueBloc>().onLoadMore) {
        return Center(
          child: CupertinoActivityIndicator(
            radius: 10,
            color: Colors.black,
          ),
        );
      }

      if (state is IssueStateLoaded) {
        if (state.issues.isEmpty) {
          return Center(
            child: Text('No data found...'),
          );
        } else {
          context.read<IssueBloc>().onLoadMore = false;
        }
      }

      if (state is IssueStateError) {
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
                !context.read<IssueBloc>().onLoadMore &&
                !context.read<IssueBloc>().onNavPage &&
                state is IssueStateLoaded) {
              context.read<IssueBloc>()
                ..onLoadMore = true
                ..add(LoadMoreIssue());
            }
          }),
        itemBuilder: (context, index) =>
            IssueItem(issueModel: context.read<IssueBloc>().issues[index]),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.dark,
        ),
        itemCount: context.read<IssueBloc>().issues.length,
      );
    }, listener: (context, state) {
      if (state is IssueStateLoaded &&
          state.issues.length == context.read<IssueBloc>().totalCount &&
          context.read<IssueBloc>().onLoadMore) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.dark.withOpacity(0.95),
            behavior: SnackBarBehavior.floating,
            content: Text('All data has been loaded...'),
          ),
        );
      }

      if (state is IssueStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.dark.withOpacity(0.9),
            content: Text(state.error),
          ),
        );
        context.read<IssueBloc>().onLoadMore = false;
      }
      return;
    });
  }
}
