import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pass/Database/dblouk.dart';
import 'package:pass/Database/note.dart';

class Lockscreen extends StatefulWidget {
  const Lockscreen({super.key});

  @override
  State<Lockscreen> createState() => _LockscreenState();
}

class _LockscreenState extends State<Lockscreen> {
  TextEditingController passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController RpasswordController = TextEditingController();
  String error1 = '';
  String error2 = '';
  String pass = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Password managment")),
          automaticallyImplyLeading: false,
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                      child: Text(
                    "Welcome<3",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                const SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            Expanded(
                              child: FutureBuilder(
                                  future: lockDb.getlock(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        for (var lock in snapshot.data!) {
                                          pass = lock.password;
                                        }
                                        if (snapshot.data == null ||
                                            snapshot.data.isEmpty) {
                                          return Column(
                                            children: <Widget>[
                                              FadeInUp(
                                                  duration: const Duration(
                                                      milliseconds: 1400),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      225,
                                                                      95,
                                                                      27,
                                                                      .3),
                                                              blurRadius: 20,
                                                              offset:
                                                                  Offset(0, 10))
                                                        ]),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(20,
                                                                  10, 10, 10),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200))),
                                                          child: TextField(
                                                            controller:
                                                                passwordController,
                                                            cursorColor:
                                                                Colors.black,
                                                            obscureText: true,
                                                            decoration: const InputDecoration(
                                                                hintText:
                                                                    "Create password",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(20,
                                                                  10, 10, 10),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200))),
                                                          child: TextField(
                                                            controller:
                                                                RpasswordController,
                                                            obscureText: true,
                                                            decoration: const InputDecoration(
                                                                hintText:
                                                                    "r-password",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              FadeInUp(
                                                duration: const Duration(
                                                    milliseconds: 1400),
                                                child: Text(
                                                  error1,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 248, 2, 2),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              FadeInUp(
                                                  duration: const Duration(
                                                      milliseconds: 1600),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      if (RpasswordController
                                                              .text.isEmpty ||
                                                          passwordController
                                                              .text.isEmpty ||
                                                          passwordController
                                                                  .text !=
                                                              RpasswordController
                                                                  .text) {
                                                        setState(() {
                                                          error1 ='Check fields Make sure all fields are filled';
                                                        });
                                                      } else {
                                                        if (passwordController.text.length <4) {
                                                          error1 ='password most be more than 4 characters..';
                                                        } else {
                                                          insertlouk() async {
                                                            final lock = Lock(
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                            );
                                                            lockDb.insertlock(
                                                                lock: lock);
                                                          }

                                                          insertlouk();
                                                          setState(() {
                                                            pass = "";
                                                          });
                                                        }
                                                      }
                                                    },
                                                    height: 50,
                                                    color: Colors.orange[900],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "ADD",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )),
                                              const Expanded(
                                                child: SizedBox(
                                                  height: 30,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          );
                                        }
                                        return Column(
                                          children: <Widget>[
                                            FadeInUp(
                                                duration: const Duration(
                                                    milliseconds: 1400),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color:
                                                                Color.fromRGBO(
                                                                    225,
                                                                    95,
                                                                    27,
                                                                    .3),
                                                            blurRadius: 20,
                                                            offset:
                                                                Offset(0, 10))
                                                      ]),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 10, 10, 10),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200))),
                                                        child: TextField(
                                                          controller: passwordController,
                                                          obscureText: true,
                                                          cursorColor:
                                                              Colors.black,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                          decoration: const InputDecoration(
                                                              hintText:
                                                                  "Enter Password",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            FadeInUp(
                                              duration: const Duration(
                                                  milliseconds: 1400),
                                              child: Text(
                                                error2,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 248, 2, 2),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            FadeInUp(
                                                duration: const Duration(
                                                    milliseconds: 1600),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    if (passwordController
                                                            .text !=
                                                        pass) {
                                                      setState(() {
                                                        error2 =
                                                            'Chek password.....';
                                                      });
                                                    } else {
                                                      Navigator.pushNamed(
                                                          context, 'home');
                                                    }
                                                  },
                                                  height: 50,

                                                  color: Theme.of(context).colorScheme.secondary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:BorderRadius.circular(50),
                                                  ),
                                                  // decoration: BoxDecoration(
                                                  // ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Login",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )),
                                            const Expanded(
                                              child: SizedBox(
                                                height: 30,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        );
                                      }
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
