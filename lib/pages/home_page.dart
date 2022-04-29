import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/visibility.dart' as visi;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gite/modules/issue/issue_module.dart';

import '../components/app_icon_button.dart';
import '../modules/repository/repo_module.dart';
import '../modules/user/user_module.dart';
import '../themes/app_colors.dart';
import '../values/app_dimens.dart';
import '../values/app_localize.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isExpanded = false;
  bool _isSwitched = false;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'users';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchController.addListener(() {
      if (_isSwitched) {
        setState(() {
          _isSwitched = false;
        });
      }
      if (_selectedCategory == 'users') {
        context.read<UserBloc>().onNavPage = false;
        context.read<UserBloc>().add(
              UserTextChanged(
                text: _searchController.text,
              ),
            );
      }
      if (_selectedCategory == 'repos') {
        context.read<RepoBloc>().onNavPage = false;
        context.read<RepoBloc>().add(
              RepoTextChanged(
                text: _searchController.text,
              ),
            );
      }
      if (_selectedCategory == 'issues') {
        context.read<IssueBloc>().onNavPage = false;
        context.read<IssueBloc>().add(
              IssueTextChanged(
                text: _searchController.text,
              ),
            );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<IssueBloc, IssueState>(
        builder: (context, issueState) => BlocBuilder<RepoBloc, RepoState>(
          builder: (context, repoState) => BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) => SafeArea(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalize.appName,
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColors.dark,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: AppDimens.appbarHeight,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 5,
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.disable,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.disable),
                                  ),
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: AppColors.dark),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      widthFactor: 1,
                                      heightFactor: 10,
                                      child: Icon(
                                        Icons.search,
                                        color: AppColors.dark,
                                      ),
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: AppColors.dark),
                                cursorHeight: 18,
                                textAlignVertical: TextAlignVertical.bottom,
                              ),
                            ),
                            SizedBox(width: 5),
                            AppIconButton(
                              icon: (_isExpanded)
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              onPressed: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                      visi.Visibility(
                        visible: _isExpanded,
                        child: Container(
                          height: AppDimens.appbarHeight,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: 15,
                            top: 3,
                            bottom: 3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.redAccent,
                                        Colors.blueAccent,
                                        Colors.purpleAccent
                                      ]),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: DropdownButton(
                                        value: _selectedCategory,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text("Users"),
                                            value: "users",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Repos"),
                                            value: "repos",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Issues"),
                                            value: "issues",
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedCategory =
                                                value.toString();
                                            if (_isSwitched) {
                                              _isSwitched = false;
                                            }
                                            if (_selectedCategory == 'users') {
                                              context
                                                  .read<UserBloc>()
                                                  .onNavPage = false;
                                              context.read<UserBloc>().add(
                                                    UserTextChanged(
                                                      text: _searchController
                                                          .text,
                                                    ),
                                                  );
                                            }
                                            if (_selectedCategory == 'repos') {
                                              context
                                                  .read<RepoBloc>()
                                                  .onNavPage = false;
                                              context.read<RepoBloc>().add(
                                                    RepoTextChanged(
                                                        text: _searchController
                                                            .text),
                                                  );
                                            }
                                            if (_selectedCategory == 'issues') {
                                              context
                                                  .read<IssueBloc>()
                                                  .onNavPage = false;
                                              context.read<IssueBloc>().add(
                                                    IssueTextChanged(
                                                        text: _searchController
                                                            .text),
                                                  );
                                            }
                                          });
                                        },
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.light),
                                        dropdownColor:
                                            AppColors.dark.withOpacity(0.95),
                                        iconEnabledColor: AppColors.light,
                                        elevation: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Switch(
                                value: _isSwitched,
                                onChanged: (value) {
                                  if (_selectedCategory == 'users') {
                                    if (userState is UserStateLoaded) {
                                      if (context
                                          .read<UserBloc>()
                                          .users
                                          .isNotEmpty) {
                                        setState(() {
                                          _isSwitched = value;
                                          context.read<UserBloc>().onNavPage =
                                              _isSwitched;
                                          context.read<UserBloc>().add(
                                                UserTextChanged(
                                                  text: _searchController.text,
                                                ),
                                              );
                                        });
                                      }
                                    }
                                  }
                                  if (_selectedCategory == 'repos') {
                                    if (repoState is RepoStateLoaded) {
                                      if (context
                                          .read<RepoBloc>()
                                          .repos
                                          .isNotEmpty) {
                                        setState(() {
                                          _isSwitched = value;
                                          context.read<RepoBloc>().onNavPage =
                                              _isSwitched;
                                          context.read<RepoBloc>().add(
                                                RepoTextChanged(
                                                  text: _searchController.text,
                                                ),
                                              );
                                        });
                                      }
                                    }
                                  }
                                  if (_selectedCategory == 'issues') {
                                    if (issueState is IssueStateLoaded) {
                                      if (context
                                          .read<IssueBloc>()
                                          .issues
                                          .isNotEmpty) {
                                        setState(() {
                                          _isSwitched = value;
                                          context.read<IssueBloc>().onNavPage =
                                              _isSwitched;
                                          context.read<IssueBloc>().add(
                                                IssueTextChanged(
                                                  text: _searchController.text,
                                                ),
                                              );
                                        });
                                      }
                                    }
                                  }
                                },
                                activeColor: AppColors.light,
                                activeTrackColor: AppColors.accent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            left: AppDimens.paddingPage,
                            right: AppDimens.paddingPage,
                          ),
                          margin: EdgeInsets.only(
                            bottom: _isSwitched ? AppDimens.appbarHeight : 0,
                          ),
                          child: (_selectedCategory == 'users')
                              ? UserList()
                              : (_selectedCategory == 'repos')
                                  ? RepoList()
                                  : IssueList(),
                        ),
                      ),
                    ],
                  ),
                  visi.Visibility(
                    visible: _isSwitched,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: AppDimens.appbarHeight,
                        width: double.infinity,
                        color: AppColors.dark.withOpacity(0.85),
                        child: Stack(
                          children: [
                            if (_selectedCategory == 'users')
                              if (context.read<UserBloc>().page != 1)
                                AppIconButton(
                                  icon: Icons.keyboard_arrow_left_rounded,
                                  onPressed: () {
                                    if (userState is UserStateLoaded) {
                                      context
                                          .read<UserBloc>()
                                          .add(UserNavChanged(nav: 'prev'));
                                    }
                                  },
                                  size: 50,
                                  color: AppColors.light,
                                ),
                            if (_selectedCategory == 'repos')
                              if (context.read<RepoBloc>().page != 1)
                                AppIconButton(
                                  icon: Icons.keyboard_arrow_left_rounded,
                                  onPressed: () {
                                    if (repoState is RepoStateLoaded) {
                                      context
                                          .read<RepoBloc>()
                                          .add(RepoNavChanged(nav: 'prev'));
                                    }
                                  },
                                  size: 50,
                                  color: AppColors.light,
                                ),
                            if (_selectedCategory == 'issues')
                              if (context.read<IssueBloc>().page != 1)
                                AppIconButton(
                                  icon: Icons.keyboard_arrow_left_rounded,
                                  onPressed: () {
                                    if (issueState is IssueStateLoaded) {
                                      context
                                          .read<IssueBloc>()
                                          .add(IssueNavChanged(nav: 'prev'));
                                    }
                                  },
                                  size: 50,
                                  color: AppColors.light,
                                ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                (_selectedCategory == 'users')
                                    ? context.read<UserBloc>().page.toString() +
                                        ' of ' +
                                        context
                                            .read<UserBloc>()
                                            .totalPage
                                            .toString()
                                    : (_selectedCategory == 'repos')
                                        ? context
                                                .read<RepoBloc>()
                                                .page
                                                .toString() +
                                            ' of ' +
                                            context
                                                .read<RepoBloc>()
                                                .totalPage
                                                .toString()
                                        : context
                                                .read<IssueBloc>()
                                                .page
                                                .toString() +
                                            ' of ' +
                                            context
                                                .read<IssueBloc>()
                                                .totalPage
                                                .toString(),
                                style: TextStyle(
                                  color: AppColors.light,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            if (_selectedCategory == 'users')
                              if (context.read<UserBloc>().page <
                                  context.read<UserBloc>().totalPage)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: AppIconButton(
                                    icon: Icons.keyboard_arrow_right_rounded,
                                    onPressed: () {
                                      if (userState is UserStateLoaded) {
                                        context
                                            .read<UserBloc>()
                                            .add(UserNavChanged(nav: 'next'));
                                      }
                                    },
                                    size: 50,
                                    color: AppColors.light,
                                  ),
                                ),
                            if (_selectedCategory == 'repos')
                              if (context.read<RepoBloc>().page <
                                  context.read<RepoBloc>().totalPage)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: AppIconButton(
                                    icon: Icons.keyboard_arrow_right_rounded,
                                    onPressed: () {
                                      if (repoState is RepoStateLoaded) {
                                        context
                                            .read<RepoBloc>()
                                            .add(RepoNavChanged(nav: 'next'));
                                      }
                                    },
                                    size: 50,
                                    color: AppColors.light,
                                  ),
                                ),
                            if (_selectedCategory == 'issues')
                              if (context.read<IssueBloc>().page <
                                  context.read<IssueBloc>().totalPage)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: AppIconButton(
                                    icon: Icons.keyboard_arrow_right_rounded,
                                    onPressed: () {
                                      if (issueState is IssueStateLoaded) {
                                        context
                                            .read<IssueBloc>()
                                            .add(IssueNavChanged(nav: 'next'));
                                      }
                                    },
                                    size: 50,
                                    color: AppColors.light,
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
