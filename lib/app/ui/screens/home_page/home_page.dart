import 'package:flutter/material.dart';
import 'package:hive_crud/app/controllers/crud_controller/crud_controller.dart';

import '../../widgets/bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CrudController.to.items.isEmpty
          ? const Center(child: Text("No Data Found"))
          : ListView.builder(
              // the list of items
              itemCount: CrudController.to.items.length,
              itemBuilder: (_, index) {
                final currentItem = CrudController.to.items[index];
                return Card(
                  color: Colors.orange.shade100,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                      title: Text(currentItem['name']),
                      subtitle: Text(currentItem['quantity'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit button
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  showForm(context, currentItem['key'])),
                          // Delete button
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => CrudController.to
                                .deleteData(currentItem['key']),
                          ),
                        ],
                      )),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  showForm(BuildContext context, int? index) {
    if (index != null) {
      final existingData = CrudController.to.items
          .firstWhere((element) => element['key'] == index);

      CrudController.to.name.text = existingData['name'];
      CrudController.to.phone.text = existingData['phone'];
      CrudController.to.email.text = existingData['email'];
    }

    commonBottomSheet(context, index);
  }
}
