import 'package:flutter/material.dart';
import 'package:flutter_products_app/screens/screens.dart';

getRoutes()
{
  return <String,WidgetBuilder>
  {
    'login' : ( _ ) => LoginScreen(),
    'home' : ( _ ) => HomeScreen(),
    'product' : ( _ ) => ProductScreen()
  };
}