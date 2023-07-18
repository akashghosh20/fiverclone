import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/screens/bottom_nav_pages/constants.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  late Stream<QuerySnapshot> studentsStream;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    studentsStream = FirebaseFirestore.instance
        .collection("user_service")
        .where(
          "category",
          isGreaterThanOrEqualTo: inputText.toString(),
        )
        .snapshots();

    _textEditingController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      inputText = _textEditingController.text;
    });
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

        final List<Map<String, dynamic>> storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
        }).toList();

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
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      child: const Text(
                        'Services List ',
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
                        border: Border.all(color: kAppBlue, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller:
                                  _textEditingController, // Set the TextEditingController
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: storedocs.length,
                              itemBuilder: (context, index) {
                                var item = storedocs[index];
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
                                            color: Color.fromARGB(
                                                255, 241, 240, 240),
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
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Raleway',
                                                ),
                                              ),
                                              Text(
                                                item['title'],
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: kAppBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Raleway',
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Description:',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Raleway',
                                                ),
                                              ),
                                              Text(
                                                item['detailsservice'],
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 17,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Raleway',
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Category:',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Raleway',
                                                ),
                                              ),
                                              Text(
                                                item['category'],
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
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
                                                      _callNumber(
                                                          item['mobileno']);
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
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "seeker_service");

                                                      try {
                                                        await _collectionRef
                                                            .doc(currentUser!
                                                                .email)
                                                            .collection(
                                                                "service_items")
                                                            .doc()
                                                            .set({
                                                          "detailsservice": item[
                                                              'detailsservice'],
                                                          "category":
                                                              item['category'],
                                                          "title":
                                                              item['title'],
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
                              },
                            ),
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
      },
    );
  }
}
