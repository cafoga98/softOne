import 'package:flutter/material.dart';
import 'package:softone/Countries/Ui/page.dart';

class MyRoutes{
  static const String ROUTE_COUNTRIES = "/countries";

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/countries':
        return MaterialPageRoute(builder: (_) => new VenuesPage());
      default:
        return MaterialPageRoute(builder: (_) => new VenuesPage());
    }
  }
}