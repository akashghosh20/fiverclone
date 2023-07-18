import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/screens/bottom_nav_pages/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";

  _callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.black),
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("user_service")
                          .where("category",
                              isGreaterThanOrEqualTo: inputText.toLowerCase())
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Something went wrong"),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Text("Loading"),
                          );
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Card(
                              color: Color.fromARGB(255, 241, 240, 240),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 241, 240, 240),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Title:",
                                            style: TextStyle(
                                              color: kAppBlue,
                                              fontSize: 20,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          Text(
                                            data['title'],
                                            style: TextStyle(
                                              fontSize: 22,
                                              decoration: TextDecoration.none,
                                              color: kAppBlue,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Description:',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          Text(
                                            data['detailsservice'],
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Category:',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          Text(
                                            data['category'],
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  _callNumber(data['mobileno']);
                                                },
                                                child: Text("Call Now"),
                                              ),
                                              SizedBox(width: 20),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  final FirebaseAuth _auth =
                                                      FirebaseAuth.instance;
                                                  var currentUser =
                                                      _auth.currentUser;

                                                  CollectionReference
                                                      _collectionRef =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "seeker_service");

                                                  try {
                                                    await _collectionRef
                                                        .doc(currentUser!.email)
                                                        .collection(
                                                            "service_items")
                                                        .doc()
                                                        .set({
                                                      "detailsservice": data[
                                                          'detailsservice'],
                                                      "category":
                                                          data['category'],
                                                      "title": data['title'],
                                                    });

                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Your service is Add");
                                                  } catch (error) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Something went wrong: $error");
                                                  }
                                                },
                                                child: Text("Hirer"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
