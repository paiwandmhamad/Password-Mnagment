import 'package:flutter/material.dart';
import 'package:pass/pages/Insert_Update/add.dart';
import 'package:pass/pages/home/home.dart';
import 'package:pass/pages/locked/lock.dart';
import 'package:pass/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/information/information.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const myapp()));
}

// ignore: camel_case_types
class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

// ignore: camel_case_types
class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return true; // Allow back button to pop the widget
      },
      child: MaterialApp(
        theme: Provider.of<ThemeProvider>(context).themeData,
        debugShowCheckedModeBanner: false,
        initialRoute: 'lock',
        routes: {
          'home': (context) => const home(),
          'add': (context) => const add(),
          'inf': (context) => const information(),
          'lock': (context) => const Lockscreen(),
        },
      ),
    );
  }
}
