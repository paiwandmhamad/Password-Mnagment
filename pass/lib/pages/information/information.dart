import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class information extends StatefulWidget {
  const information({super.key});

  @override
  State<information> createState() => _informationState();
}

// ignore: camel_case_types
class _informationState extends State<information> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    var title = arguments['title'];
    var username = arguments['username'];
    var password = arguments['password'];
    var information = arguments['information'];
    var time = arguments['time'];
    var photo = arguments['photo'];

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 15),
                    height: 100,
                    width: 80,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 102, 8, 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)
                        ),),
                    child: Column(children: [
                      Text(DateFormat(DateFormat.ABBR_MONTH_DAY).format(time),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white)),
                      Text(DateFormat(DateFormat.HOUR24_MINUTE).format(time),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(DateFormat(DateFormat.YEAR).format(time),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white)),
                    ]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: SizedBox(
                  height: 210,
                  width: 210,
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(photo),
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Username or Email: $username',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Password: $password',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Information: $information',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ));
  }
}
