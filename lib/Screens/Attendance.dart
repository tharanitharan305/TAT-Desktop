import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tat_win/Widgets/AttendanceCard.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  var attendanceList = [];
  void setup() async {
    final list = await Firestore.instance.collection('Attendance').get();
    setState(() {
      attendanceList = list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: CarouselSlider(
            items: [
              ...attendanceList
                  .map((e) => AttendanceCard(
                        image: e['image url'],
                        name: e['name'],
                        time: e['time'].toString(),
                        date: e['date'],
                        status: e['status'],
                        email: e['User'],
                      ))
                  .toList()
            ],
            options: CarouselOptions(),
          ),
        ),
      ),
    );
  }
}
