import 'package:expense_tracker_app/services/theme_helper.dart';
import 'package:expense_tracker_app/views/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _storage = GetStorage();
  late String name;
  late String user_img_path;

  bool? isSwitched;
  void updateProfile() {
    name = _storage.read('name');
    user_img_path = _storage.read('user_img_path');
  }

  @override
  void initState() {
    // TODO: implement initState
    updateProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.light
        ? isSwitched = false
        : isSwitched = true;

    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 76),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 33,
                            backgroundImage: AssetImage(user_img_path),
                          ),
                          SizedBox(width: 10), // Adjust as needed
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xff91919F),
                                ),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color(0xff161719)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile(
                                      name: name,
                                    ))).then((value) => setState(() {
                              updateProfile();
                            }));
                      },
                      child: Image(
                          image:
                              Theme.of(context).brightness == Brightness.light
                                  ? AssetImage('assets/edit.png')
                                  : AssetImage('assets/edit-light.png')),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 47,
              ),
              Container(
                width: screenWidth,
                // height: 286,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xff1F1F1F),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color(0xffEEE5FF)
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Image(
                                    image: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AssetImage('assets/moon.png')
                                        : AssetImage('assets/sun.png')),
                              ),
                              SizedBox(width: 9),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? "Dark Mode"
                                          : "Light Mode",
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Color(0xff292B2D)
                                            : Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Switch(
                              value: isSwitched!,
                              onChanged: (bool value) {
                                ThemeServices().SwitchTheme();
                                setState(() {
                                  isSwitched = value;
                                });
                              })
                        ],
                      ),
                    ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 17, vertical: 13),
                    //   decoration: BoxDecoration(
                    //     border: Border(
                    //       top: BorderSide(
                    //           color: const Color.fromARGB(31, 227, 109, 109),
                    //           width: 2.0),
                    //       bottom: BorderSide(
                    //           color: const Color.fromARGB(31, 227, 109, 109),
                    //           width: 2.0),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 60,
                    //         height: 60,
                    //         decoration: BoxDecoration(
                    //           color: Theme.of(context).brightness ==
                    //                   Brightness.light
                    //               ? Color(0xffEEE5FF)
                    //               : Colors.black,
                    //           borderRadius: BorderRadius.circular(16),
                    //         ),
                    //         child:
                    //             Image(image: AssetImage('assets/settings.png')),
                    //       ),
                    //       SizedBox(width: 9),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 4),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Settings",
                    //               style: TextStyle(
                    //                 color: Theme.of(context).brightness ==
                    //                         Brightness.light
                    //                     ? Color(0xff292B2D)
                    //                     : Colors.white,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 17, vertical: 13),
                    //   decoration: BoxDecoration(
                    //     border: Border(
                    //       bottom: BorderSide(
                    //           color: const Color.fromARGB(31, 227, 109, 109),
                    //           width: 2.0),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 60,
                    //         height: 60,
                    //         decoration: BoxDecoration(
                    //           color: Theme.of(context).brightness ==
                    //                   Brightness.light
                    //               ? Color(0xffEEE5FF)
                    //               : Colors.black,
                    //           borderRadius: BorderRadius.circular(16),
                    //         ),
                    //         child:
                    //             Image(image: AssetImage('assets/upload.png')),
                    //       ),
                    //       SizedBox(width: 9),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 4),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Export Data",
                    //               style: TextStyle(
                    //                 color: Theme.of(context).brightness ==
                    //                         Brightness.light
                    //                     ? Color(0xff292B2D)
                    //                     : Colors.white,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
