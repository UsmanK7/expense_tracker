import 'dart:ffi';

import 'package:expense_tracker_app/resources/genderbutton.dart';
import 'package:expense_tracker_app/resources/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class EditProfile extends StatefulWidget {
  String name;
  
  EditProfile({super.key, required this.name});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isMaleSelected = true;

  final _storage = GetStorage();
  late TextEditingController _controller;

  void _selectGender(bool isMale) {
    setState(() {
      isMaleSelected = isMale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xff9B59B6),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: screenHeight / 3.45,
              width: screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image(
                                  width: 100,
                                  image: isMaleSelected == true
                                      ? AssetImage("assets/male.png")
                                      : AssetImage("assets/female.png")),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  height: screenHeight / 1.4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Color(0xff121212),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 56,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Color(0xff1F1F1F),
                                borderRadius: BorderRadius.circular(16),
                                border: Border(
                                  top: BorderSide(
                                      color: const Color.fromARGB(
                                          31, 227, 109, 109),
                                      width: 2.0),
                                  bottom: BorderSide(
                                      color: const Color.fromARGB(
                                          31, 227, 109, 109),
                                      width: 2.0),
                                  left: BorderSide(
                                      color: const Color.fromARGB(
                                          31, 227, 109, 109),
                                      width: 2.0),
                                  right: BorderSide(
                                      color: const Color.fromARGB(
                                          31, 227, 109, 109),
                                      width: 2.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  maxLength: 10,
                                  
                                  controller: _controller,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.name = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff91919F)),
                                      hintText: "Enter your Name",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Choose your Gender"),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _selectGender(true);
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          decoration: BoxDecoration(
                                            color: isMaleSelected
                                                ? Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? myblue
                                                    : Color(0xff7F3DFF)
                                                : Colors.grey,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              bottomLeft: Radius.circular(8.0),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Center(
                                            child: Text(
                                              'Male',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _selectGender(false);
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          decoration: BoxDecoration(
                                            color: isMaleSelected
                                                ? Colors.grey
                                                : Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? myblue
                                                    : Color(0xff7F3DFF),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(8.0),
                                              bottomRight: Radius.circular(8.0),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Center(
                                            child: Text(
                                              'Female',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _storage.write('name', _controller.text);
                            String user_img_path = isMaleSelected == true
                                ? "assets/male.png"
                                : "assets/female.png";
                            _storage.write('user_img_path', user_img_path);
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 56,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Color(0xff95AEEE)
                                  : Color(0xff7F3DFF),
                            ),
                            child: Center(
                                child: Text("Edit",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
