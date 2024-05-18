import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/add_place.dart';
import './providers/places_provider.dart';
import './screens/places_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Places()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Great Places',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.blue,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(color: Colors.white)),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 0,
              ))),
          routes: {
            AddPlace.routeName: (context) => AddPlace(),
          },
          home: PlacesList()),
    );
  }
}
