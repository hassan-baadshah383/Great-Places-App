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
          ),
          routes: {
            AddPlace.routeName: (context) => AddPlace(),
          },
          home: PlacesList()),
    );
  }
}
