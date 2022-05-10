import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/ui/view/home/home_screen.dart';
import 'package:majootestcase/ui/view/auth/login_page.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlocCubit>(
          create: (_) => AuthBlocCubit()..fetchHistoryLogin(),
        ),
        BlocProvider<HomeBlocCubit>(
          create: (_) => HomeBlocCubit()..fetchingData("game"),
          child: HomeScreen(),
        ),
      ],
      child: MaterialApp(
        title: 'Majoo Test Case',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
