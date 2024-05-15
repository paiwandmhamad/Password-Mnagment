import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pass/Database/note.dart';
import 'package:pass/Database/repository.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

// ignore: camel_case_types
class _addState extends State<add> {
  String selectedImagePath = '';
  String error = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController informationController = TextEditingController();
  String buttonName = 'ADD';
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (arguments['id'] != '') {
      titleController.text = arguments['title'];
      passwordController.text = arguments['password'];
      usernameController.text = arguments['username'];
      informationController.text = arguments['information'];
      selectedImagePath = arguments['photo'];
      buttonName = 'Update';
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Password managment"),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
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
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: titleController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Name App",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: usernameController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Username or Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: passwordController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: informationController,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: "Additional information",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        selectImage();
                                        setState(() {});
                                      },
                                      child: const Text(
                                          'Select image to background app')),
                                ),
                              ],
                            ),
                          )),
                      Text(
                        error,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 248, 2, 2),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              if (titleController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  usernameController.text.isEmpty ||
                                  informationController.text.isEmpty ||
                                  selectedImagePath =='') {
                                setState(() {
                                  error =
                                      'Check fields Make sure all fields are filled';
                                });
                              } else {
                                if (arguments['id'] != '') {
                                  updateNote() async {
                                    final note = Note(
                                        id: arguments['id'],
                                        title: titleController.text,
                                        password: passwordController.text,
                                        photo: selectedImagePath,
                                        username: usernameController.text,
                                        information: informationController.text,
                                        time: arguments['time']);
                                    
                                    NotesRepository.update(note: note);
                                    Navigator.pushNamed(context, 'home');
                                  }

                                  updateNote();
                                } else {
                                  insertNote() async {
                                    final note = Note(
                                        title: titleController.text,
                                        password: passwordController.text,
                                        photo: selectedImagePath,
                                        username: usernameController.text,
                                        information: informationController.text,
                                        time: DateTime.now());
                                    NotesRepository.insert(note: note);
                                    Navigator.pushNamed(context, 'home');
                                  }

                                  insertNote();
                                }
                              }
                            },
                            height: 50,
                            color: Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                buttonName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.orange.shade900,
                Colors.orange.shade800,
                Colors.orange.shade400
              ])),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 11, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() async {
                                selectedImagePath =
                                  await selectImageFromGallery();
                              });
                              
                              if (kDebugMode) {
                                print('Image_Path:-');
                              }
                              if (kDebugMode) {
                                print(selectedImagePath);
                              }
                              if (selectedImagePath != '') {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                setState(() {});
                              } 
                            },
                            child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SizedBox(
                                        width: 120,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/gallery.png',
                                              height: 70,
                                              width: 70,
                                            ),
                                            const Text('Gallery'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () async {
                              setState(() async {
                                selectedImagePath =
                                  await selectImageFromGallery();
                              });
                              if (kDebugMode) {
                                print('Image_Path:-');
                              }
                              if (kDebugMode) {
                                print(selectedImagePath);
                              }

                              if (selectedImagePath != '') {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                setState(() {});
                              }
                            },
                            child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SizedBox(
                                        width: 120,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/camera.png',
                                              height: 70,
                                              width: 70,
                                            ),
                                            const Text('Camera'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
