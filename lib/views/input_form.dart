import 'package:flutter/material.dart';

class ExternalFurnitureForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  const ExternalFurnitureForm({
    super.key,
    required this.nameController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 30)),
        SizedBox(
          width: 300,
          child: TextField(
            controller: nameController,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                hintText: "Name"
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
            width: 300,
            child: TextField(
              controller: descriptionController,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Add Description"
              ),
            ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 30)),
      ],
    );
  }
}