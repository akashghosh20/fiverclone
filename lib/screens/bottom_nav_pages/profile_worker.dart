import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/const/AppColors.dart';
import 'package:mobile_app/model/user_model.dart';
import 'package:mobile_app/screens/bottom_nav_pages/See%20all%20items.dart';
import 'package:mobile_app/screens/bottom_nav_pages/profile_seeker.dart';
import 'package:mobile_app/screens/bottom_nav_pages/serviceList.dart';
import 'package:mobile_app/screens/creatrservice.dart';
import 'package:mobile_app/screens/edit_profile.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/screens/sharefeedback.dart';
import 'package:mobile_app/screens/support.dart';
import 'package:mobile_app/widgets/customButton.dart';

class ProfileWorker extends StatefulWidget {
  const ProfileWorker({super.key});

  @override
  State<ProfileWorker> createState() => _ProfileWorkerState();
}

class _ProfileWorkerState extends State<ProfileWorker> {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      ((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileSeeker(),
          )));
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Worker Profile',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (loggedInUser.firstName == null ||
                    loggedInUser.secondName == null ||
                    loggedInUser.email == null)
                  CircularProgressIndicator()
                else
                  Text(
                      "Name : ${loggedInUser.firstName} ${loggedInUser.secondName}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      )),
                SizedBox(
                  height: 15,
                ),
                Text("Email : ${loggedInUser.email}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                customButton(
                  "Edit Profile ",
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditProfile();
                    }));
                  },
                  0xffFCFCFC,
                  Colors.black54,
                ),
                SizedBox(
                  height: 15,
                ),
                customButton(
                  "Create Service  ",
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateService();
                    }));
                  },
                  0xffFCFCFC,
                  Colors.black54,
                ),
                SizedBox(
                  height: 15,
                ),
                customButton(
                  "All Service ",
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AllItems();
                    }));
                  },
                  0xffFCFCFC,
                  Colors.black54,
                ),
                SizedBox(
                  height: 15,
                ),
                customButton(
                  "Service List  ",
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ServiceList();
                    }));
                  },
                  0xffFCFCFC,
                  Colors.black54,
                ),
                SizedBox(
                  height: 15,
                ),
                customButton(
                  "Support ",
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Support();
                    }));
                  },
                  0xffFCFCFC,
                  Colors.black54,
                ),
                SizedBox(
                  height: 15,
                ),
                customButton(
                  "Share Feedback ",
                  () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return shareFeedback();
                    }));
                  },
                  0xffFCFCFC,
                  Colors.black54,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ActionChip(
                        backgroundColor: AppColors.deep_orange,
                        label: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          logout(context);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
