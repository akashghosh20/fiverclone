import 'package:flutter/material.dart';
import 'package:mobile_app/screens/bottom_nav_controller.dart';


class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support>  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => BottomNavController()),);},
                    child: Text("⬅",
                      style:TextStyle(color: Colors.black,fontSize: 20),),),
                ],
              ),
              SizedBox(
                height: 200,
              ),
              Text(
                "Contact with us.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email: mahadihasanarif071@gmail.com",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We will rech out via email soon ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Stay with Ywork",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Thank You",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }


}

