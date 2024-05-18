import 'package:flutter/material.dart';
import 'package:native_features_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import '../screens/add_place.dart';
import '../providers/places_provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Places'), actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              }),
              icon: const Icon(Icons.add))
        ]),
        body: FutureBuilder(
            future: Provider.of<Places>(context, listen: false).fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<Places>(
                  child: const Center(
                    child: Text('No any place yet. Add some!'),
                  ),
                  builder: (context, places, ch) => places.allPlaces.isEmpty
                      ? ch!
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Card(
                                  elevation: 5,
                                  color: Colors.grey[200],
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                            places.allPlaces[index].image)),
                                    title: Text(places.allPlaces[index].title),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => PlaceDetail(
                                            places.allPlaces[index].id),
                                      ));
                                    },
                                  ));
                            },
                            itemCount: places.allPlaces.length,
                          ),
                        ),
                );
              }
            }));
  }
}
