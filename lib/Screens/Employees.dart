import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tat_windows/Firebase/NewOrder.dart';
import 'package:tat_windows/Screens/EmployeeView.dart';
import 'package:tat_windows/Widgets/IconGEnerae.dart';
import 'package:tat_windows/Widgets/Jobs.dart';

class Employe {
  Employe(
      {required this.email,
      required this.name,
      required this.daysOfPresent,
      required this.monthlyMaxSale,
      required this.monthlyMaxSaleShop,
      required this.monthlySales,
      required this.noOfDaysPresent,
      required this.overAllSales,
      required this.job});
  String? name;
  String? email;
  double? overAllSales;
  double? monthlySales;
  Map daysOfPresent;
  int? noOfDaysPresent;
  double? monthlyMaxSale;
  String? monthlyMaxSaleShop;
  String job;
}

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class TempEmploye {
  TempEmploye({required this.name, required this.email, required this.jobs});
  String name;
  String email;
  String jobs;
}

class _EmployeesState extends State<Employees> {
  late Employe employe;
  late List<TempEmploye> nameList;
  bool isWorking = false;
  setup() async {
    setState(() {
      isWorking = true;
    });
    final tempNames = await Firestore.instance.collection('Employees').get();
    List<TempEmploye> templist = [];
    for (int i = 0; i < tempNames.length; i++) {
      templist.add(TempEmploye(
          name: tempNames[i]['UserName'],
          email: tempNames[i]['email'],
          jobs: tempNames[i]["Job"]));
    }
    setState(() {
      nameList = templist;
    });
    setState(() {
      isWorking = false;
    });
  }

  Widget Profiles() {
    return Column(
      children: [
        ...nameList.map((e) => ProfileCard(e.name, e.email, e.jobs)).toList()
      ],
    );
  }

  Widget ProfileCard(String userName, String email, String job) {
    return GestureDetector(
      onTap: () async {
        employe = await NewOrder().getEmployee(userName,
            DateTime.now().month.toString(), DateTime.now().year.toString());
        Get.to(() => EmployeeView(employe: employe));
      },
      child: Card(
        elevation: 10,
        color: Color.fromRGBO(241, 228, 218, 1),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(249, 245, 245, 1),
                    radius: 50,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    userName,
                    style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    email,
                    style: GoogleFonts.lexend(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      height: 60, child: IconGenerate().GenerateJobIcon(job)))
            ],
          ),
        ),
      ),
    );
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
        body: Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Column(
        children: [
          if (isWorking) Center(child: CircularProgressIndicator()),
          if (!isWorking) Profiles()
        ],
      )),
    ));
  }
}
