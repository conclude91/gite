import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../themes/app_colors.dart';
import '../models/repo_model.dart';

class RepoItem extends StatelessWidget {
  const RepoItem({
    Key? key,
    required this.repoModel,
  }) : super(key: key);

  final RepoModel repoModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(repoModel.htmlUrl.toString());
        await launchUrl(uri);
      },
      child: SizedBox(
        height: 75,
        width: double.infinity,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: repoModel.owner!.avatarUrl.toString(),
                  placeholder: (context, url) => Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.dark,
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(
                      Icons.error_outline,
                      color: AppColors.dark,
                      size: 35,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: 3,
                          bottom: 3,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              repoModel.fullName.toString(),
                              style: TextStyle(
                                  fontSize: 15, color: AppColors.dark),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Languages : ' + repoModel.language.toString(),
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.dark),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Open issues : ' +
                                  repoModel.openIssuesCount.toString(),
                              style: TextStyle(
                                  fontSize: 11, color: AppColors.dark),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Forks count : ' +
                                  repoModel.forksCount.toString(),
                              style: TextStyle(
                                  fontSize: 11, color: AppColors.dark),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 25,
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: AppColors.dark,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
