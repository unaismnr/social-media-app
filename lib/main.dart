import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sm_app/controllers/auth_bloc/auth_bloc.dart';
import 'package:sm_app/firebase_options.dart';
import 'package:sm_app/utils/color_consts.dart';
import 'package:sm_app/view/chats/chat_screen.dart';
import 'package:sm_app/view/feeds/feed_screen.dart';
import 'package:sm_app/view/log_and_sign/login_screen.dart';
import 'package:sm_app/view/main/main_screen.dart';
import 'package:sm_app/view/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
        ],
        child: MaterialApp(
          title: 'SM App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: mainBlue,
            ),
            useMaterial3: false,
          ),
          home: MainScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
