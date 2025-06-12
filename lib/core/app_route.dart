import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/dependencies_injection.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  root("/"),
  splash("/splash"),
  settings("/settings"),
  appVersion("/app-version"),
  // Auth Page
  login("/auth/login"),
  register("/auth/register"),
  forgotPassword("/auth/forgot-password"),

  // Navbar
  home("/homes"),
  instructions("/instructions"),
  navbar("/navbar"),
  notes("/notes"),
  profile("/profile"),

  // Camera
  camera("/camera"),
  cameraPreview("/camera/preview"),
  photoPreview("/photo/preview"),
  imageEditor("/image/editor"),

  // User
  users("/users"),
  userProfile("/user/profile"),
  changePassword("/user/profile/change-password"),
  updateProfile("/user/profile/update"),
  userDetail("/user/detail"),
  ;

  const Routes(this.path);

  final String path;
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRoute {
  static late BuildContext context;

  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final navBarItems = [
    NavBarItem(
      path: Routes.home.path,
      name: Routes.home.name,
      widget: const SizedBox(),
      icon: SvgImages.icMenuHome,
    ),
    NavBarItem(
      path: Routes.instructions.path,
      name: Routes.instructions.name,
      widget: const SizedBox(),
      icon: SvgImages.icMenuHome,
    ),
    NavBarItem(
      path: Routes.navbar.path,
      name: Routes.navbar.name,
      widget: const SizedBox(),
      icon: SvgImages.icMenuHome,
    ),
    NavBarItem(
      path: Routes.notes.path,
      name: Routes.notes.name,
      widget: const SizedBox(),
      icon: SvgImages.icMenuHome,
    ),
    NavBarItem(
      path: Routes.profile.path,
      name: Routes.profile.name,
      widget: const SizedBox(),
      icon: SvgImages.icMenuHome,
    ),
  ];

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splash.path,
        name: Routes.splash.name,
        builder: (_, __) => SplashPage(),
      ),
      GoRoute(
        path: Routes.appVersion.path,
        name: Routes.appVersion.name,
        builder: (_, __) => const AppVersionPage(),
      ),
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        redirect: (_, __) => Routes.users.path,
      ),
      GoRoute(
        path: Routes.login.path,
        name: Routes.login.name,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.register.path,
        name: Routes.register.name,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<RegisterCubit>(),
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        path: Routes.users.path,
        name: Routes.users.name,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<UserListCubit>()
            ..fetchUserList(
              const GetUserListParams(),
            ),
          child: const UserListPage(),
        ),
      ),
      GoRoute(
        path: Routes.settings.path,
        name: Routes.settings.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => const SettingsPage(),
      ),
      GoRoute(
        path: Routes.camera.path,
        name: Routes.camera.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final Map<String, bool>? args = state.extra as Map<String, bool>?;
          if (args == null) {
            return const CameraPage();
          } else {
            final bool isSelfie = args['isSelfie']!;
            final bool enableFlipCamera = args['enableFlipCamera']!;

            return CameraPage(
              isSelfie: isSelfie,
              isEnableFlipCamera: enableFlipCamera,
            );
          }
        },
      ),
      GoRoute(
        path: Routes.imageEditor.path,
        name: Routes.imageEditor.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final Uint8List? args = state.extra as Uint8List?;

          return ImageEditorWidget(imageBytes: args!);
        },
      ),
      GoRoute(
        path: Routes.cameraPreview.path,
        name: Routes.cameraPreview.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;
          return CameraPreviewPage(
            image: args!["file"] as Uint8List,
            isWithWatermark: args["isWithWatermark"] as bool,
          );
        },
      ),
      GoRoute(
        path: Routes.photoPreview.path,
        name: Routes.photoPreview.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final Map<String, dynamic>? args =
              state.extra as Map<String, dynamic>?;

          return PhotoViewer(
            isFromNetwork: args!['isFromNetwork'] as bool,
            imagePath: args['imagePath'] as String,
            imageBytes: args['imageBytes'] == null
                ? null
                : args['imageBytes'] as Uint8List,
          );
        },
      ),
      GoRoute(
        path: Routes.userProfile.path,
        name: Routes.userProfile.name,
        builder: (_, __) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ProfilePictureCubit>(),
            ),
            BlocProvider(
              create: (_) => sl<UserProfileCubit>()..fetchUserProfile(),
            ),
          ],
          child: const UserProfilePage(),
        ),
      ),
      GoRoute(
        path: Routes.changePassword.path,
        name: Routes.changePassword.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<PasswordCubit>(),
            ),
            BlocProvider(
              create: (_) => sl<ChangePasswordCubit>(),
            ),
          ],
          child: const ChangePasswordPage(),
        ),
      ),
      GoRoute(
        path: Routes.updateProfile.path,
        name: Routes.updateProfile.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final UserDataEntity? profile = state.extra as UserDataEntity?;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<UpdateProfileCubit>(),
              ),
            ],
            child: UpdateProfilePage(profile: profile!),
          );
        },
      ),
      GoRoute(
        path: Routes.userDetail.path,
        name: Routes.userDetail.name,
        builder: (_, state) {
          final int? userId = state.extra as int?;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => sl<UserDetailCubit>()
                  ..fetchUserDetail(
                    GetUserDetailParams(
                      id: userId!.toString(),
                    ),
                  ),
              ),
            ],
            child: UserDetailPage(userId: userId!),
          );
        },
      ),
      GoRoute(
        path: Routes.forgotPassword.path,
        name: Routes.forgotPassword.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<ForgotPasswordCubit>(),
            ),
          ],
          child: const ForgotPasswordPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<MainCubit>(),
              ),
            ],
            child: MainPage(
              navigationShell: navigationShell,
              navBarItems: navBarItems,
            ),
          );
        },
        branches: <StatefulShellBranch>[
          for (final item in navBarItems)
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: <RouteBase>[
                GoRoute(
                  path: item.path,
                  name: item.name,
                  pageBuilder: (_, __) => CustomTransitionPage(
                    child: item.widget,
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity:
                            animation.drive(CurveTween(curve: Curves.ease)),
                        child: child,
                      );
                    },
                  ),
                  routes: item.routes,
                ),
              ],
            ),
        ],
      ),
    ],
    initialLocation: Routes.splash.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
    // redirect: (_, GoRouterState state) {
    //   final bool isLoginPage = state.matchedLocation == Routes.login.path;
    //
    //   ///  Check if not login
    //   ///  if current page is login page we don't need to direct user
    //   ///  but if not we must direct user to login page
    //   if (!((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
    //       false)) {
    //     if (isLoginPage) {
    //       return null;
    //     }
    //     return Routes.login.path;
    //   }
    //
    //   /// Check if already login and in login page
    //   /// we should direct user to main page
    //   if (isLoginPage &&
    //       ((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
    //           false)) {
    //     return Routes.root.path;
    //   }
    //
    //   /// No direct
    //   return null;
    // },
  );
}
