import 'package:book_app/core/di/dependency_injection.dart';
import 'package:book_app/features/home/presentation/catalog/catalog_view_model.dart';
import 'package:book_app/features/home/presentation/favorites/favorites_view_model.dart';
import 'package:book_app/features/main/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  setupDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<CatalogViewModel>()),
        ChangeNotifierProvider(create: (context) => getIt<FavoritesViewModel>()),
      ],
      child: MainApp(),
    )
  );  

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: MainPage()));
  }
}
