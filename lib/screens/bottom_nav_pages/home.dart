import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/screens/bottom_nav_controller.dart';
import 'package:mobile_app/screens/bottom_nav_pages/applianceRepairView.dart';
import 'package:mobile_app/screens/bottom_nav_pages/cleaningView.dart';
import 'package:mobile_app/screens/bottom_nav_pages/delivaryView.dart';
import 'package:mobile_app/screens/bottom_nav_pages/electricianView.dart';
import 'package:mobile_app/screens/bottom_nav_pages/paintingView.dart';
import 'package:mobile_app/screens/bottom_nav_pages/plumberView.dart';
import 'package:mobile_app/screens/bottom_nav_pages/search.dart';
import 'package:mobile_app/widgets/onlytext.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCarouselImages();
  }

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      _carouselImages =
          qn.docs.map((doc) => doc["img-path"] as String).toList();
      print(_carouselImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 35.w),
                  child: Container(
                    width: 220.h,
                    decoration: BoxDecoration(
                      color: Colors.black12, // Set the desired background color
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the desired border radius
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 35.h,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.black,
                                    contentPadding: EdgeInsets.only(
                                        left: 15.0, bottom: 10.0),
                                    hintText: "Search",
                                    hintStyle: TextStyle(fontSize: 15.sp),
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SearchScreen();
                                    }));
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                height: 35,
                                width: 35,
                                child: Center(
                                  child:
                                      Icon(Icons.search, color: Colors.white),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SearchScreen();
                                }));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.w),
                      Container(
                        width: 90,
                        height: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff8f6f6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ElectricianView()));
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ywork-f7082.appspot.com/o/icon%2F327258607_2997568783883078_8994329590452305443_n-removebg-preview.png?alt=media&token=7c45aa8c-ae4f-4dd3-ab34-e651f2cbd507',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 90,
                        height: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff8f6f6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PlumberView()));
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ywork-f7082.appspot.com/o/icon%2Fplumber-atta-boy-plumbing-services-drain-tap-png-favpng-LXyLxRnQN3vJjbbAas3MmtxXf_t-removebg-preview.png?alt=media&token=9fd4ab32-56c1-45d1-a492-6557ad5362d5',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 90,
                        height: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff8f6f6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ApplianceRepair()));
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ywork-f7082.appspot.com/o/icon%2Fpngtree-master-refrigerator-repair-fix-worker-png-image_5617385-removebg-preview.png?alt=media&token=83793639-07ad-40c4-ac1f-96d8242b995f',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 40.w),
                      onlyText('Electrician'),
                      SizedBox(width: 30.w),
                      onlyText('Plumber'),
                      SizedBox(width: 25.w),
                      onlyText('Appliance Repair'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.w),
                      Container(
                        width: 90,
                        height: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff8f6f6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DeliveryView()));
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ywork-f7082.appspot.com/o/icon%2Fsmartphone-with-delivery-worker-using-face-mask-in-motorcycle-free-vector-removebg-preview.png?alt=media&token=9a96bf07-d193-46e2-aa52-96381be0706d',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 90,
                        height: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff8f6f6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CleaningView()));
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ywork-f7082.appspot.com/o/icon%2F678-6786164_house-cleaning-services-hd-png-download-removebg-preview.png?alt=media&token=d0f6ad75-8b42-4952-8829-014ac78d2e55',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 90,
                        height: 90,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfff8f6f6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PaintingView()));
                          },
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ywork-f7082.appspot.com/o/icon%2Fkisspng-painting-house-painter-and-decorator-cartoon-5b029a98dda9b6.8035387015268973049079-removebg-preview.png?alt=media&token=b147a343-b0bb-4764-966a-171382fd43c9',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 40.w),
                      onlyText('Delivery'),
                      SizedBox(width: 50.w),
                      onlyText('Cleaning'),
                      SizedBox(width: 40.w),
                      onlyText('Painting'),
                    ],
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  height: 220.h, // Set the desired height constraint
                  child: CarouselSlider(
                    items: _carouselImages
                        .map((item) => Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: Container(
                                margin: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
