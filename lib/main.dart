import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/viewmodels/form_viewmodel.dart';
import 'package:timesheet/views/form.dart';
import 'viewmodels/signup_viewmodel.dart';
import 'viewmodels/login_viewmodel.dart';
import 'views/login.dart';
import 'views/signup.dart';

void main() {
  runApp( const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => FormViewModel()),

      ],
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login':(context) =>const Login(),
          '/signup':(context) =>const Signup(),
          '/form':(context) =>const FormView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

