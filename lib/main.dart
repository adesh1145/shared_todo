import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shareed_todo/core/constants/color_constants.dart';
import 'package:shareed_todo/presentation/repository/auth_repository.dart';
import 'package:shareed_todo/presentation/repository/todo_repository.dart';
import 'package:shareed_todo/presentation/view_model/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:shareed_todo/presentation/view_model/todo_provider.dart';

import 'core/config/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/view_model/auth_provider.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        Provider<AuthRepository>(create: (_) => AuthRepository()),
        Provider<TodoRepository>(create: (_) => TodoRepository()),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider<TodoProvider>(
          create: (context) => TodoProvider(
              context.read<TodoRepository>(), context.read<AuthProvider>()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.brandPrimaryDefault,
            ),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.intial,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
