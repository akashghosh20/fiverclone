import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/const/AppColors.dart';
import 'package:mobile_app/screens/bottom_nav_pages/home.dart';
import 'package:mobile_app/screens/bottom_nav_pages/order.dart';
import 'package:mobile_app/screens/bottom_nav_pages/profile.dart';
import 'package:mobile_app/screens/bottom_nav_pages/profile_seeker.dart';
import 'package:mobile_app/screens/bottom_nav_pages/profile_worker.dart';
import 'package:mobile_app/screens/chatbot/chatbot.dart';
import 'package:mobile_app/screens/visitor/VisitorList.dart';
import 'package:mobile_app/screens/visitor/visitorhome.dart';

class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final List<Widget> _workerpages = [
    Home(),
    ChatBot(),
    Aggrement(),
    ProfileWorker(),
  ];
  final List<Widget> _completewithupdatepages = [
    Home(),
    ChatBot(),
    Aggrement(),
    ProfileSeeker(),
  ];
  final List<Widget> _completewithoutupdatepages = [
    VisitorHome(),
    ChatBot(),
    VisitorList(),
    Profile(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 3,
        title: Text(
          "Ywork",
          style: TextStyle(
            color: Color(0xff5B8BDF),
            fontSize: 50,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(offset: Offset(.5, .5), blurRadius: 5.0),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
        onTap: (index) {
          setState(() {
            print(index);
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          if (snapshot.hasData) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            if (data["role"] == "visitor") {
              return _completewithoutupdatepages[_currentIndex];
            } else if (data["role"] == "worker") {
              return _workerpages[_currentIndex];
            } else if (data["role"] == "seeker") {
              return _completewithupdatepages[_currentIndex];
            }
          }

          return Container();
        },
      ),
    );
  }
}
