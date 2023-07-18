import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/const/AppColors.dart';
import 'package:mobile_app/screens/complete_profile.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/screens/sharefeedback.dart';
import 'package:mobile_app/screens/support.dart';
import 'package:mobile_app/screens/visitor/visitor%20all%20i%20tem.dart';
import 'package:mobile_app/screens/worker_registration.dart';
import 'package:mobile_app/widgets/customButton.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? firstName;
  String? secondName;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchNameData();
  }

  Future<void> fetchNameData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        firstName = data["firstName"] as String;
        secondName = data["secondName"] as String;
        email = data["email"] as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
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
                    'Visitor Profile',
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
              if (firstName == null || secondName == null || email == null)
                CircularProgressIndicator() // Show CircularProgressIndicator while data is loading.
              else
                Column(
                  children: [
                    Text(
                      "Name : ${firstName} ${secondName}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email : $email",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customButton(
                      "Update to worker account",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return WorkerRegstration();
                          }),
                        );
                      },
                      0xffFCFCFC,
                      Colors.indigo,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customButton(
                      "Complete Profile",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CompleteProfile();
                          }),
                        );
                      },
                      0xffFCFCFC,
                      Colors.black54,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customButton(
                      "Edit Profile",
                      () {
                        Fluttertoast.showToast(
                            msg: 'Please Complete Profile First');
                      },
                      0xffFCFCFC,
                      Colors.black54,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customButton(
                      "All Services",
                      () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VisitorAllItems();
                        }));
                      },
                      0xffFCFCFC,
                      Colors.black54,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customButton(
                      "Support",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Support();
                          }),
                        );
                      },
                      0xffFCFCFC,
                      Colors.black54,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customButton(
                      "Share Feedback",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return shareFeedback();
                          }),
                        );
                      },
                      0xffFCFCFC,
                      Colors.black54,
                    ),
                    SizedBox(
                      height: 15,
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
                          },
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // The logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
