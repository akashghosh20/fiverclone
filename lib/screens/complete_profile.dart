import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/screens/bottom_nav_controller.dart';
import 'package:mobile_app/widgets/custom_Button1.dart';
import 'package:mobile_app/widgets/myTextField.dart';

class CompleteProfile extends StatefulWidget {
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }
  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users");
    return _collectionRef.doc(currentUser!.email).update({
      "phone":_phoneController.text,
      "dob":_dobController.text,
      "gender":_genderController.text,
      "role":"seeker",
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavController()))
    ).catchError((error)=>Fluttertoast.showToast(msg: "something went wrong.$error "));
  }

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => BottomNavController()),);},
                      child: Text("Home",
                      style:TextStyle(color: Colors.black,fontSize: 20),),),
                  ],
                ),

                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Submit the form to continue.",
                  style:
                  TextStyle(fontSize: 22.sp, color: Colors.black87),
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
                myTextField("Enter your phone number",TextInputType.number,_phoneController),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  style:TextStyle(

                    color: Colors.black,
                  ),
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Bate of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  style:TextStyle(

                  color: Colors.black,
                ),
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color:Colors.black,
                    ),
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value,style:TextStyle(

                            color: Colors.black,
                          ),),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
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
                customButton("Continue",()=>sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

