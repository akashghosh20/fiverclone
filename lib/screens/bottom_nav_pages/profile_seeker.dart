import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/const/AppColors.dart';
import 'package:mobile_app/model/user_model.dart';
import 'package:mobile_app/screens/bottom_nav_pages/See%20all%20items.dart';
import 'package:mobile_app/screens/bottom_nav_pages/profile_worker.dart';
import 'package:mobile_app/screens/complete_profile.dart';
import 'package:mobile_app/screens/creatrservice.dart';
import 'package:mobile_app/screens/edit_profile.dart';
import 'package:mobile_app/screens/login_screen.dart';
import 'package:mobile_app/screens/sharefeedback.dart';
import 'package:mobile_app/screens/support.dart';
import 'package:mobile_app/screens/userservicelist.dart';
import 'package:mobile_app/screens/worker_registration.dart';
import 'package:mobile_app/widgets/customButton.dart';


class ProfileSeeker extends StatefulWidget {
  const ProfileSeeker({super.key});

  @override
  State<ProfileSeeker> createState() => _ProfileSeekerState();
}

class _ProfileSeekerState extends State<ProfileSeeker>
{

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
                  Text('Seekers Profile ',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Text("Name : ${loggedInUser.firstName} ${loggedInUser.secondName}",
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
              customButton("Update to worker account ",(){
                Navigator.push(context, MaterialPageRoute(builder: (context){return WorkerRegstration();}));
              },0xffFCFCFC,AppColors.deep_orange,),
              SizedBox(
                height: 15,
              ),

              customButton("Edit Profile ",(){
                Navigator.push(context, MaterialPageRoute(builder: (context){return EditProfile();}));
              },0xffFCFCFC,Colors.black54,),
              SizedBox(
                height: 15,
              ),

              customButton("All Service ",(){
                Navigator.push(context, MaterialPageRoute(builder: (context){return AllItems();}));
              },0xffFCFCFC,Colors.black54,),

              SizedBox(
                height: 15,
              ),
              customButton("Support ",(){
                Navigator.push(context, MaterialPageRoute(builder: (context){return Support();}));
              },0xffFCFCFC,Colors.black54,),
              SizedBox(
                height: 15,
              ),
              customButton("Share Feedback ",(){
                Navigator.push(context, MaterialPageRoute(builder: (context){return shareFeedback();}));
              },0xffFCFCFC,Colors.black54,),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 100,
              ),


              Row(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  ActionChip(
                      backgroundColor: AppColors.deep_orange,
                      label: Text("Logout",style: TextStyle(
                        color: Colors.white,
                      ),),
                      onPressed: () {
                        logout(context);
                      }),
                ],
              )

            ],
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
