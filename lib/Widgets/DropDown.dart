import 'package:flutter/material.dart';

class DropdownTat extends StatefulWidget {
  DropdownTat(
      {super.key,
      required this.dropdownValue,
      required this.set,
      required this.onChanged});

  @override
  State<DropdownTat> createState() => _DropdownTatState();

  String dropdownValue;
  Set<String> set;
  final ValueChanged<String?> onChanged;
}

class _DropdownTatState extends State<DropdownTat> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        elevation: 50,
        autofocus: true,
        dropdownColor: Color.fromRGBO(222, 217, 217, 1),
        borderRadius: BorderRadius.circular(20),
        value: widget.dropdownValue,
        items: widget.set
            .map((e) => DropdownMenuItem(
                  value: e,
                  key: UniqueKey(),
                  child: Text(e),
                ))
            .toList(),
        onChanged: widget.onChanged);
  }
}
