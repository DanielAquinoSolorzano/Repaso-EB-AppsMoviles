import 'package:book_app/core/di/dependency_injection.dart';
import 'package:book_app/features/auth/presentation/login_page.dart';
import 'package:book_app/features/auth/presentation/login_view_model.dart';
import 'package:book_app/features/home/presentation/home_view_model.dart';
import 'package:book_app/features/home/presentation/read_list/read_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  setupDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<HomeViewModel>()),
        ChangeNotifierProvider(create: (context) => getIt<ReadListViewModel>()),
        BlocProvider(create: (context) => getIt<LoginViewModel>()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
