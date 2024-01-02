import 'package:flutter/material.dart';
import 'package:getx_hive_project/models/notes.dart';
import 'package:hive/hive.dart';

class DbFunctions {
  static const String boxname = "CRUD";
  static openBox() async => await Hive.openBox<Note>(boxname);
  static Box getBox() => Hive.box<Note>(boxname);
  static closeBox() async => await Hive.box(boxname).close();
}
