import 'package:flutter/material.dart';

class DetailsRowView extends StatelessWidget {
  final String field;
  final String value;

  const DetailsRowView({
    super.key,
    required this.field,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 8,
              child: Text("$field: $value", style: const TextStyle(fontSize: 20)
              ),
            ),
            const Spacer(flex: 1),
          ]),
      const Padding(padding: EdgeInsets.only(top: 20)),
      ]);
    }
}