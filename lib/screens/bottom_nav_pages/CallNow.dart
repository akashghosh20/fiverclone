import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  _callNumber() async {
    const number = '01841911105'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/inimages/logob.png"),
          SizedBox(
            height: 50,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 0, 0),
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            child: TextButton(
                style: TextButton.styleFrom(fixedSize: const Size(180, 50)),
                onPressed: () {
                  {
                    _callNumber();
                  }
                },
                child: Text(
                  "কল করুন",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
