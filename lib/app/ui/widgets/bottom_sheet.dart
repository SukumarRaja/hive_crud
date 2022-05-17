import 'package:flutter/material.dart';
import 'package:hive_crud/app/controllers/crud_controller/crud_controller.dart';
import 'package:hive_crud/app/ui/widgets/common_textform_field.dart';

import 'common_button.dart';

commonBottomSheet(BuildContext context, index) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 15,
              left: 15,
              right: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonTextFormField(
                hintText: "name",
                labelText: "Name",
                keyboardType: TextInputType.text,
                controller: CrudController.to.name,
              ),
              CommonTextFormField(
                hintText: "email",
                labelText: "Email",
                keyboardType: TextInputType.text,
                controller: CrudController.to.email,
              ),
              CommonTextFormField(
                hintText: "phone",
                labelText: "Phone",
                keyboardType: TextInputType.phone,
                controller: CrudController.to.phone,
              ),
              CommonButton(
                text: index == null ? "Create New" : "Update",
                onPressed: () async {
                  if (index == null) {
                    CrudController.to.createData({
                      "name": CrudController.to.name.text,
                      "email": CrudController.to.email.text,
                      "phone": CrudController.to.phone.text,
                    });
                  }
                  if (index != null) {
                    CrudController.to.updateData(index, {
                      "name": CrudController.to.name.text,
                      "email": CrudController.to.email.text,
                      "phone": CrudController.to.phone.text,
                    });
                  }
                  index == null
                      ? CrudController.to.textFiledClear()
                      : const SizedBox();
                },
              )
            ],
          ),
        );
      });
}
