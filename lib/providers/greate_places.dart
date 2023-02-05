import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatePlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path
      },
    );
  }

  Future<void> setAndFetchPlaces() async {
    final dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location: null,
            image: File(
              e['image'],
            ),
          ),
        )
        .toList(); //az imagnel egy uj fájlt keel nézni ezért tesszük bele file ba és az adatbázisban az elérési utat taroljuk
    //lista kolvasásánál id: e.id csak az sqflite map el dolgozik
  }
}
