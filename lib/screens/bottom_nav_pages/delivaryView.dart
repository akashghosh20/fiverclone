import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/screens/bottom_nav_pages/constants.dart';

class DeliveryView extends StatefulWidget {
  DeliveryView({Key? key}) : super(key: key);
  @override
  _DeliveryViewState createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
      .collection('service_items')
      .where('category', isEqualTo: 'delivery')
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  _callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return  Scaffold(
            body: SafeArea(


              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: double.infinity,
                          child: const Text(
                            'Services',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              border: Border.all(
                                  color: Colors.lightBlue,
                                  width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(5)))),
                      SingleChildScrollView(
                        child: Container(
                          color: const Color.fromARGB(255, 241, 240, 240),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              for (var i = 0; i < storedocs.length; i++) ...[
                                Container(
                                  color: Color.fromARGB(255, 241, 240, 240),
                                  alignment: Alignment.center,
                                  height: 250,
                                  margin: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                              margin: const EdgeInsets.all(10.0),
                                              height: 320,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(255, 241, 240, 240),),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Title    :   ",
                                                        style: TextStyle(
                                                          color: kAppBlue,
                                                          fontSize: 20,
                                                          decoration:
                                                          TextDecoration.none,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily: 'Raleway',
                                                        ),
                                                      ),
                                                      Text(
                                                        storedocs[i]['title'],
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          decoration:
                                                          TextDecoration.none,
                                                          color: kAppBlue,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontFamily: 'Raleway',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          'Description   :    ',
                                                          style: TextStyle(
                                                            decoration:
                                                            TextDecoration.none,
                                                            fontSize: 17,
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily: 'Raleway',
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          storedocs[i]
                                                          ['detailsservice'],
                                                          style: TextStyle(
                                                            decoration:
                                                            TextDecoration.none,
                                                            fontSize: 17,
                                                            color: Color.fromARGB(
                                                                255, 0, 0, 0),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily: 'Raleway',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          'Category :    ',
                                                          style: TextStyle(
                                                            decoration:
                                                            TextDecoration.none,
                                                            fontSize: 17,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontFamily: 'Raleway',
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          storedocs[i]['category'],
                                                          style: TextStyle(
                                                            decoration:
                                                            TextDecoration.none,
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.normal,
                                                            fontFamily: 'Raleway',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                            new BoxDecoration(
                                                              color: Color(0xffb7b7b7),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      15)),
                                                            ),
                                                            child: TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                    fixedSize:
                                                                    const Size(
                                                                        100,
                                                                        15)),
                                                                onPressed: () {
                                                                  _callNumber(
                                                                      storedocs[i][
                                                                      'mobileno']);
                                                                },
                                                                child: Text(
                                                                  "Call Now",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                )),
                                                          ),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Container(
                                                            decoration:
                                                            new BoxDecoration(
                                                              color: Color(0xffb7b7b7),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      15)),
                                                            ),
                                                            child: TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                    fixedSize:
                                                                    const Size(
                                                                        100,
                                                                        15)),
                                                                onPressed: () async  {
                                                                  final FirebaseAuth _auth = FirebaseAuth.instance;
                                                                  var currentUser = _auth.currentUser;

                                                                  CollectionReference _collectionRef = FirebaseFirestore.instance.collection("seeker_service");


                                                                  try {
                                                                    await _collectionRef.doc(currentUser!.email)
                                                                        .collection("service_items")
                                                                        .doc()
                                                                        .set({
                                                                      "detailsservice": storedocs[i]['detailsservice'],
                                                                      "category": storedocs[i]['category'],
                                                                      "title": storedocs[i]['title'],
                                                                    });

                                                                    Fluttertoast.showToast(msg: "Your service is Add");
                                                                  } catch (error) {
                                                                    Fluttertoast.showToast(msg: "Something went wrong: $error");
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "Hirer",
                                                                  style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          flex: 2,
                                        ),
                                      ]),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          );
        });
  }
}
