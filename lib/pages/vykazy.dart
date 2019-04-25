import "package:flutter/material.dart";
import '../appbar.dart';
import '../drawer.dart';
import 'dart:convert';
import '../models/job.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class VykazyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VykazyPageState();
  }
}

class _VykazyPageState extends State<VykazyPage> {
  bool setuped = false;
  List<Job> jobs = new List<Job>();
  List<Job> jobsPrevious = new List<Job>();

  bool showPreviousJobs = false;

  @override
  Widget build(BuildContext context) {
    if (setuped == false) {
      getData();
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        drawer: MyDrawer(1),
        appBar: MyAppBar("Výkazy práce"),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 3.0,
              ),
            ]..addAll(getJobs()),
          ),
        ),
      );
    }
  }

  getJobs() {
    var data;
    data = <Widget>[Container()];

    for (int i = 0; i < jobs.length; i++) {
      Job c = jobs[i];

      data = data
        ..addAll(<Widget>[
          Card(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 7.0,
                ),
                Text(
                  c.type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  c.date,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  c.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.0,
          ),
        ]);
    }

    data = data
      ..addAll(<Widget>[
        SizedBox(
          height: 10.0,
        ),
      ]);

    return data;
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionID = prefs.getString('sessionID');

    if (sessionID == null || sessionID == "") {
      exit(0);
    }

    // 2018-11-01&dateTo=2018-11-30T23:59:59 - formát, který potřebuji

    DateTime now = DateTime.now();

    int year = now.year;
    int month = now.month;

    String yearS = year.toString();
    String monthS = month < 10 ? "0" + month.toString() : month.toString();

    String period = _getThisMonthString();
    String periodPrevious = _getPreviousMonthString();

    //stažení dat - tento měsíc
    http.Response response = await http.get(
        "https://testasistentka.azurewebsites.net/MobileApp/Dashboard/" +
            sessionID +
            "/History?" +
            period);

    //stažení dat - předchozí měsíc
    http.Response responsePrevious = await http.get(
        "https://testasistentka.azurewebsites.net/MobileApp/Dashboard/" +
            sessionID +
            "/History?" +
            periodPrevious);

    //zpracování dat - tento měsíc
    Map<String, dynamic> data = jsonDecode(response.body);

    List<dynamic> jobsData = data["ROOT"]["OA_ServiceRequest_ByBillingDate"];

    jobsData.forEach((e) {
      Map<String, dynamic> d = e;
      String description = d["Description"];
      String type = d["OA_ServiceDevice_Name"];
      String price = d["Price"].toString();
      String date = d["Date"];

      Job j = new Job(
          description: description, date: date, price: price, type: type);
      this.jobs.add(j);
    });

    //zpracování dat - předchozí měsíc
    Map<String, dynamic> dataPrevious = jsonDecode(responsePrevious.body);

    List<dynamic> jobsDataPrevious =
        dataPrevious["ROOT"]["OA_ServiceRequest_ByBillingDate"];

    jobsDataPrevious.forEach((e) {
      Map<String, dynamic> d = e;
      String description = d["Description"];
      String type = d["OA_ServiceDevice_Name"];
      String price = d["Price"].toString();
      String date = d["Date"];

      Job j = new Job(
          description: description, date: date, price: price, type: type);
      this.jobsPrevious.add(j);
    });

    setuped = true;

    setState(() {});
  }

  String _getThisMonthString(){
    //FORMÁT
    //2019-03-01

    String from, to;

    DateTime now = DateTime.now();

    int year = now.year;
    int month = now.month;

    String monthString = month < 10 ? ("0" + month.toString()) : month.toString();

    //FROM
    from = year.toString() + "-" + monthString + "-01";

    //TO
    var lastDate = new DateTime(year, month + 1, 0);
    String lastDayString = lastDate.day < 10 ? "0" + lastDate.day.toString() : lastDate.day.toString();
    to = year.toString() + "-" + monthString + "-" + lastDayString;

    print("THIS MONTH: " + from + " => " + to);

    from = "dateFrom=" + from + "T23:59:59";
    to = "dateTo=" + to + "T23:59:59";

    return from + "&" + to;
  }

  String _getPreviousMonthString(){
    //FORMÁT
    //2019-03-01

    String from, to;

    DateTime now = DateTime.now();

    int year = now.year;
    int month = now.month;

    if(month == 1){
      year = year - 1;

      //FROM
      from = year.toString() + "-12-01";

      //TO
      to = year.toString() + "-12-31";
    }else{
      month = month - 1;
      String monthString = month < 10 ? ("0" + month.toString()) : month.toString();

      //FROM
      from = year.toString() + "-" + monthString + "-01";

      //TO
      var lastDate = new DateTime(year, month + 1, 0);
      String lastDayString = lastDate.day < 10 ? "0" + lastDate.day.toString() : lastDate.day.toString();
      to = year.toString() + "-" + monthString + "-" + lastDayString;
    }

    print("PREVIOUS MONTH: " + from + " => " + to);

    from = "dateFrom=" + from + "T23:59:59";
    to = "dateTo=" + to + "T23:59:59";

    return from + "&" + to;
  }
}
