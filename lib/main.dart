import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'modules/issue/issue_module.dart';
import 'modules/repository/repo_module.dart';
import 'modules/user/user_module.dart';
import 'pages/home_page.dart';
import 'routes/app_routes.dart';
import 'themes/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => Gite(),
    ),
  );
}

class Gite extends StatelessWidget {
  const Gite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: UserRepository(
              UserCache(),
              UserClient(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => RepoBloc(
            repoRepository: RepoRepository(
              RepoCache(),
              RepoClient(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => IssueBloc(
            issueRepository: IssueRepository(
              IssueCache(),
              IssueClient(),
            ),
          ),
        ),
      ],
      child: GetMaterialApp(
        initialRoute: AppRoutes.home,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        getPages: [
          GetPage(
            name: AppRoutes.home,
            page: () => HomePage(),
          )
        ],
      ),
    );
  }
}
