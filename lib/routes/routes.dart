import 'package:flutter/material.dart';
import 'package:flutter_products_app/screens/screens.dart';

getRoutes()
{
  return <String,WidgetBuilder>
  {
    'login'    : ( _ ) => const LoginScreen(),
    'home'     : ( _ ) => const HomeScreen(),
    'product'  : ( _ ) => const ProductScreen(),
    'register' : ( _ ) => const RegisterScreen(),
    'checking' : ( _ ) => const CheckAuthScreen()
  };
}