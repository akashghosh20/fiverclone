import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/screens/bottom_nav_controller.dart';
import 'package:mobile_app/widgets/custom_Button1.dart';
import 'package:mobile_app/widgets/myTextField.dart';

class shareFeedback extends StatefulWidget {
  @override
  _shareFeedbackState createState() => _shareFeedbackState();
}

class _shareFeedbackState extends State<shareFeedback> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _feedbackController = TextEditingController();

  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("sharefeedback");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "feedback":_feedbackController.text,

    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavController())),
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
                      child: Text("⬅",
                        style:TextStyle(color: Colors.black,fontSize: 20),),),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Share your feed back .",
                  style:
                  TextStyle(fontSize: 28.sp, color: Colors.black54),
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
                myTextField("enter your name",TextInputType.text,_nameController),
                myTextField("Share your feedback here",TextInputType.text,_feedbackController),
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

