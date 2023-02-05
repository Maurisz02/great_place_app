import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/greate_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greate Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlace>(context,
                listen:
                    false) //amig várunk erre addig circular ha már nem várunk mutassa a listát
            .setAndFetchPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatePlace>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlace, ch) => greatPlace.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (ctx, i) => Container(
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlace.items[i].image),
                            ),
                            title: Text(greatPlace.items[i].title),
                            onTap: () {
                              //go to deail page
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
