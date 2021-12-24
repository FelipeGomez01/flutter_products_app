import 'package:flutter/material.dart';
import 'package:flutter_products_app/routes/routes.dart';
import 'package:flutter_products_app/services/services.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ProductsService()),
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App'),
        ),
      ),
      scaffoldMessengerKey: NotificationsService.messengerKey,
      initialRoute: 'checking',
      routes: getRoutes(),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}
