import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/screens/bottom_nav_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController ?_firstnameController;
  TextEditingController ?_secondnameController;
  TextEditingController ?_phoneController;


  setDataToTextField(data){
    return  Column(
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
        TextFormField(style:TextStyle(

          color: Colors.black,
        ),
          controller: _firstnameController = TextEditingController(text: data['firstName']),
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(style:TextStyle(

          color: Colors.black,
        ),
          controller: _secondnameController = TextEditingController(text: data['secondName']),
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(style:TextStyle(

        color: Colors.black,
    ),keyboardType: TextInputType.number,
          controller: _phoneController = TextEditingController(text: data['phone']),
        ),
        SizedBox(
          height: 15.h,
        ),
        ElevatedButton(onPressed: ()=>updateData(), child: Text("Update"))
      ],
    );
  }

  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "firstName":_firstnameController!.text,
          "secondName": _secondnameController!.text,
          "phone":_phoneController!.text,
        }
    ).then((value) =>Fluttertoast.showToast(msg: "Updated Successful"),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return setDataToTextField(data);
          },

        ),
      )
      ),
    );
  }
}
