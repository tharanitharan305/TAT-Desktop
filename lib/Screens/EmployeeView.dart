import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:tat_win/Screens/Employees.dart';

class EmployeeView extends StatelessWidget {
  EmployeeView({super.key, required this.employe});
  Employe employe;

  Widget AttendanceView(Map map) {
    print(map);
    var status = map.values.toList();
    return Row(
      children: [
        for (int i = 1; i <= map.length; i++)
          ...{
            Text(
              " $i ".toString(),
              style: GoogleFonts.lexend(
                  color: map[i.toString()]
                      ? Colors.greenAccent
                      : Colors.redAccent),
            )
          }.toList()
      ],
    );
  }

  Widget view() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromRGBO(241, 228, 218, 1),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Name : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.name!,
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Email : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.email!,
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Over All Sales : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.overAllSales!.toString(),
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Job : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.job!.toString(),
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "No of Days Worked : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.noOfDaysPresent!.toString(),
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Monthly sales : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.monthlySales!.toString(),
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Mothly Max Sale : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.monthlyMaxSale.toString(),
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Monthly Max Sale Shop : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Text(
                employe.monthlyMaxSaleShop!,
                style: GoogleFonts.lexend(),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Days Present This Month : ",
                style: GoogleFonts.lexend(fontWeight: FontWeight.bold),
              ),
              Expanded(child: AttendanceView(employe.daysOfPresent))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          employe.name!,
          style: GoogleFonts.lexend(),
        ),
      ),
      body: view(),
    );
  }
}
