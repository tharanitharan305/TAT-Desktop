import 'package:flutter/material.dart';

import 'Jobs.dart';

class IconGenerate {
  Icon GenerateJobIcon(String jobs) {
    Icon icon = Icon(Icons.key);
    switch (jobs) {
      case "select":
        icon = Icon(Icons.select_all_rounded);
        break;
      // TODO: Handle this case.
      case "Driver":
        icon = Icon(Icons.drive_eta_rounded);
        break;
      // TODO: Handle this case.
      case "Sales_Man":
        icon = Icon(Icons.pedal_bike_rounded);
        break;
      // TODO: Handle this case.
      case "All_Rounder":
        icon = Icon(Icons.person);
        break;
      // TODO: Handle this case.
      case "others":
        icon = Icon(Icons.man_2_rounded);
        break;
      // TODO: Handle this case.
    }
    return icon;
  }
}
