import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/screens/bottom_nav_controller.dart';
import 'package:mobile_app/screens/bottom_nav_pages/search.dart';
import 'package:mobile_app/screens/bottom_nav_pages/profile.dart';
import 'package:mobile_app/widgets/custom_Button1.dart';
import 'package:mobile_app/widgets/myTextField.dart';

class CreateService extends StatefulWidget {
  @override
  _CreateServiceState createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  TextEditingController _detailsserviceController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  List<String> category = [
    "Electrician",
    "Plumber",
    "appliancerepair",
    "delivery",
    "cleaning",
    "painting"
  ];

// ...

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("user_service");

    try {
      await _collectionRef.doc(currentUser!.email).update({
        "detailsservice": _detailsserviceController.text,
        "category": _categoryController.text,
        "title": _titleController.text,
        "location": _locationController.text,
        "mobileno": _phoneNumberController.text,
      });

      Fluttertoast.showToast(msg: "Your service is created");

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => BottomNavController()));
    } catch (error) {
      Fluttertoast.showToast(msg: "Something went wrong: $error");
    }
  }

  Future add_service_list() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUserc = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Worker_service");
    return _collectionRef
        .doc(currentUserc!.email)
        .collection("service_items")
        .doc()
        .set({
      "detailsservice": _detailsserviceController.text,
      "category": _categoryController.text,
      "title": _titleController.text,
      "location": _locationController.text,
      "mobileno": _phoneNumberController.text,
    });
  }

  // ------------------------------------ Map ---------------------------------------

  @override
  void initState() {
    setState(() {});

    super.initState();
  }

  CollectionReference pids =
      FirebaseFirestore.instance.collection('ambulanceService');

  final String loading = "Loading";

  @override
  Widget build(BuildContext context) {
    Function LocationName;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BottomNavController()),
                        );
                      },
                      child: Text(
                        "⬅",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Submit the form to continue.",
                  style: TextStyle(fontSize: 22.sp, color: Colors.black54),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                myTextField("Describe your service here ", TextInputType.text,
                    _detailsserviceController),
                SizedBox(
                  height: 15.h,
                ),
                myTextField("Enter your service title ", TextInputType.text,
                    _titleController),
                SizedBox(
                  height: 15.h,
                ),
                myTextField("Enter your Location ", TextInputType.text,
                    _locationController),
                SizedBox(
                  height: 15.h,
                ),
                myTextField("Enter your phone number ", TextInputType.number,
                    _phoneNumberController),

                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: _categoryController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Choose your service type",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    prefixIcon: DropdownButton<String>(
                      items: category.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _categoryController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),

                // elevated button
                ElevatedButton(
                  onPressed: () {
                    return sendUserDataToDB() & add_service_list();
                  },
                  child: Text("Continue"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    // foregroundColor: Color(textcolorvalue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
