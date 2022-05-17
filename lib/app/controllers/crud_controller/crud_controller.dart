import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class CrudController extends GetxController {
  static CrudController get to => Get.put(CrudController());


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  List<Map<String, dynamic>> _items = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get items => _items;

  set items(List<Map<String, dynamic>> value) {
    _items = value;
  }

  final hiveCrud = Hive.box('hive_crud');

  textFiledClear(){
    name.text = "";
    email.text = "";
    phone.text = "";
  }

  getData() {
    final data = hiveCrud.keys.map((key) {
      final value = hiveCrud.get(key);
      return {
        "key": key,
        "name": value["name"],
        "email": value["email"],
        "phone": value["phone"]
      };
    }).toList();

    items = data.reversed.toList();
  }

  createData(Map<String, dynamic> newData) async {
    await hiveCrud.add(newData);
    getData();
  }

  Map<String, dynamic> readData(int key) {
    final item = hiveCrud.get(key);
    return item;
  }

  updateData(int itemKey, Map<String, dynamic> item) async {
    await hiveCrud.put(itemKey, item);
    getData();
  }

  deleteData(int itemKey) async {
    await hiveCrud.delete(itemKey);
    getData();

    Get.snackbar("Success", "Item has been deleted",
        snackPosition: SnackPosition.TOP);
  }


}
