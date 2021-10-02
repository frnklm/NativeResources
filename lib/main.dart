import 'package:flutter/material.dart';
import 'package:native_resources/providers/great_places.dart';
import 'package:native_resources/screens/place_form_screen.dart';
import 'package:native_resources/screens/places_list_screen.dart';
import 'package:native_resources/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Fotos',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.indigo,
            secondary: Colors.amber,
          ),
        ),
        routes: {
          AppRoutes.homeApp: (ctx) => const PlacesListScreen(),
          AppRoutes.placeForm: (ctx) => const PlaceFormScreen(),
        },
      ),
    );
  }
}
