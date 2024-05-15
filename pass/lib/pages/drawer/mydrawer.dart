import 'package:flutter/material.dart';
import 'package:pass/Database/note.dart';
import 'package:pass/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:pass/Database/dblouk.dart';

// ignore: camel_case_types
class mydrawer extends StatefulWidget {
  const mydrawer({super.key});

  @override
  State<mydrawer> createState() => _mydrawerState();
}

TextEditingController passwordController = TextEditingController();
TextEditingController rpasswordController = TextEditingController();
String error1 = '';

// ignore: camel_case_types
class _mydrawerState extends State<mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: ListTile(
            title: const Text("Mode"),
            onTap:
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
            subtitle: const Text("used to light and darck mode"),
            leading: const Icon(Icons.dark_mode),
            isThreeLine: true,
            dense: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: const Text("Change password"),
            onTap: changePassword,
            subtitle: const Text("use change password"),
            leading: const Icon(Icons.password),
            isThreeLine: true,
            dense: true,
          ),
        ),
      ]),
    );
  }

  Future changePassword() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 300,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        'Change Password...',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(error1),
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                            hintText: "New Password",
                            hintStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: rpasswordController,
                        decoration: const InputDecoration(
                          hintText: "r-Password",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (rpasswordController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            passwordController.text !=
                                rpasswordController.text ||
                                passwordController.text.length < 4) {
                          setState(() {
                            passwordController.text = '';
                            rpasswordController.text = '';
                          });
                        } else {
                            updatelock() async {
                              final lock = Lock(
                                id: 1,
                                password: passwordController.text,
                              );
                              lockDb.updatelock(lock: lock);
                            }

                            updatelock();
                            passwordController.text = '';
                            rpasswordController.text = '';
                            Navigator.pushNamed(context, 'lock');
                        }
                      },
                      height: 40,
                      color: const Color.fromARGB(255, 24, 24, 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
