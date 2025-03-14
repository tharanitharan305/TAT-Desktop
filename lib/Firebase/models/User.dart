import 'package:latlong2/latlong.dart';

import '../../Widgets/Jobs.dart';

class TatUser {
  String userName;
  String userEmail;
  Jobs jobType;
  double overAllSales;
  int daysOfPresent;
  LatLng? location;
  TatUser({
    required this.userName,
    required this.userEmail,
    required this.location,
    required this.daysOfPresent,
    required this.jobType,
    required this.overAllSales,
  });
  Map<String, dynamic> toMap() {
    return {"User name": userName, "User email": userEmail};
  }

  factory TatUser.fromMap(Map<String, dynamic> map) {
    return TatUser(
      userName: map["User name"] ?? "Unknown",
      userEmail: map["User email"] ?? "Not Available",
      jobType: Jobs.values.firstWhere(
        (e) => e.toString() == map["Job type"],
        orElse: () => Jobs.select, // Handle missing job type
      ),
      overAllSales: (map["Overall Sales"] ?? 0.0).toDouble(),
      daysOfPresent: map["Days Present"] ?? 0,
      location: map["Location"] != null
          ? LatLng(map["Location"]["lat"], map["Location"]["lng"])
          : null, // Restoring location
    );
  }
}
