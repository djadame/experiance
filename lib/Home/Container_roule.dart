

import 'package:experiance/Service/CallPhone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:experiance/Widget/Text/Big_text_dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:experiance/Widget/Size/Dimention.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widget/Text/Small_text.dart';
import '../shared-ui/List/popularlist/ArtList.dart';
import '../shared-ui/makecall.dart';




class Article extends StatefulWidget {
  const Article({Key? key}) : super(key: key);

  @override
  ArticleState createState() => ArticleState();
}

class ArticleState extends State<Article> {

  //final User? user = FirebaseAuth.instance.currentUser;
  String? user;
  // Effect for achieving dynamic scrolling effect
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.0;
  final double _height = Dimension.pageViewContainer;

  // Transition for achieving dynamic rolling effect
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        // print("la valour est:" + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _makePhoneCall(
      String phoneNumber
      ) async {
    //const phoneNumber = '+22893380145'; // Numéro de téléphone à appeler
    final Uri _url = Uri.parse('tel:$phoneNumber');
    if (await Permission.phone.request().isGranted){
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      } else {
        throw 'Impossible de passer l\'appel au numéro $phoneNumber';
      }
    }else{
      throw 'Permission refusée';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    String? num = '93380145';
    return Column(
      children: [
        SizedBox(
          // Background color of the rolling effect in red
          // color: Colors.redAccent,
          height: 320,
          child: PageView.builder(
            // Initialize the rolling effect here
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        // Large dots indicating the transition between pages
        SmoothPageIndicator(
          controller: pageController,
          count: 5,
          effect: SwapEffect(
            //size: Size.square(9.0),
            dotColor: Colors.orange.withOpacity(0.1),
          ),
        ),
        // Body starting from "Popular"
        const SizedBox(height: 10),

        //debut du body
        Container(
          margin: const EdgeInsets.only(left: 3, top: 3),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Big_Text(text: "Popular"),

                  const SizedBox(height: 30),
                  ],
              ),
             //const SizedBox(height: 30)

              //premier photo
              Container(
                height: Dimension.pageViewContainer,
                margin: const EdgeInsets.only(left: 11, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  //color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/R.jpeg"),
                  ),
                ),

              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimension.pageViewTextContainer,
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31),
                    color: Colors.white,
                    // Create the shadow on the white container of the photo
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 15, right: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Big_Text(text: "ODI RS8"),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            // Wrap(
                            //   children: List.generate(
                            //     5,
                            //         (index) {
                            //       return const Icon(
                            //         Icons.star,
                            //         color: Colors.green,
                            //         // color: AppColors.mainColor,
                            //         size: 15,
                            //       );
                            //     },
                            //   ),
                            // ),
                            const SizedBox(width: 10),
                            SmallText(text: "Prix:19M FR"),
                            const SizedBox(width: 10),

                            const SizedBox(width: 10),
                            SmallText(text: "Lieux:Lome"),
                          ],
                        ),
                        //const SizedBox(height: 20),
                        FloatingActionButton.extended(
                          onPressed: () => _makePhoneCall(num!),
                          icon: const Icon(Icons.call_end_outlined),
                          label: const Text('93380145'),
                          backgroundColor: Colors.indigoAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            //deusiee photo
              Container(
                height: Dimension.pageViewContainer,
                margin: const EdgeInsets.only(left: 11, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  //color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/TP1.jpeg"),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimension.pageViewTextContainer,
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31),
                    color: Colors.white,
                    // Create the shadow on the white container of the photo
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 15, right: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Big_Text(text: "ODI rS3"),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            // Wrap(
                            //   children: List.generate(
                            //     5,
                            //         (index) {
                            //       return const Icon(
                            //         Icons.star,
                            //         color: Colors.green,
                            //         // color: AppColors.mainColor,
                            //         size: 15,
                            //       );
                            //     },
                            //   ),
                            // ),
                            const SizedBox(width: 10),
                            SmallText(text: "Prix:9M FR"),
                            const SizedBox(width: 10),

                            const SizedBox(width: 10),
                            SmallText(text: "Lieux:Lome"),
                          ],
                        ),
                        //SmallText(text:"pour plus d'info contacter nous"),
                        //const SizedBox(height: 20),
                        FloatingActionButton.extended(
                          onPressed: () => _makePhoneCall(num!),
                          icon: const Icon(Icons.call_end_outlined),
                          label: const Text('93380145'),
                          backgroundColor: Colors.indigoAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            //troisieme photo
              Container(
                height: Dimension.pageViewContainer,
                margin: const EdgeInsets.only(left: 11, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  //color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/th.jpeg"),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimension.pageViewTextContainer,
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31),
                    color: Colors.white,
                    // Create the shadow on the white container of the photo
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 1, left: 15, right: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Big_Text(text: "2 lot "),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            // Wrap(
                            //   children: List.generate(
                            //     5,
                            //         (index) {
                            //       return const Icon(
                            //         Icons.star,
                            //         color: Colors.green,
                            //         // color: AppColors.mainColor,
                            //         size: 15,
                            //       );
                            //     },
                            //   ),
                            // ),
                            const SizedBox(width: 10),
                            SmallText(text: "Prix:25M de Fr"),
                            const SizedBox(width: 10),

                            const SizedBox(width: 10),
                            SmallText(text: "Lieux:Lome zanguera"),
                          ],
                        ),
                        //const SizedBox(height: 20),
                        FloatingActionButton.extended(
                          onPressed: () => _makePhoneCall(num!),
                          icon: const Icon(Icons.call_end_outlined),
                          label: const Text('93380145'),
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            //quartieme photo

              Container(
                height: Dimension.pageViewContainer,
                margin: const EdgeInsets.only(left: 11, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  //color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/TP.jpeg"),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimension.pageViewTextContainer,
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31),
                    color: Colors.white,
                    // Create the shadow on the white container of the photo
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 1, left: 15, right: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Big_Text(text: "VILLA"),
                        const SizedBox(height: 1),
                        Row(
                          children: [
                            // Wrap(
                            //   children: List.generate(
                            //     5,
                            //         (index) {
                            //       return const Icon(
                            //         Icons.star,
                            //         color: Colors.green,
                            //         // color: AppColors.mainColor,
                            //         size: 15,
                            //       );
                            //     },
                            //   ),
                            // ),
                            const SizedBox(width: 10),
                            SmallText(text: "Prix:"),
                            const SizedBox(width: 10),

                            const SizedBox(width: 10),
                            SmallText(text: "Lieu:Lome"),
                          ],
                        ),
                        //const SizedBox(height: 20),
                        FloatingActionButton.extended(
                          onPressed: () => _makePhoneCall(num!),
                          icon: const Icon(Icons.call_end_outlined),
                          label: const Text('93380145'),
                          backgroundColor: Colors.indigoAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),




            //ArtList(user: user!.uid)
],


    ),


    ),
    ]
    );


  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          Container(
            height: Dimension.pageViewContainer,
            margin: const EdgeInsets.only(left: 11, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/image/B1.jpg"),

              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31),
                color: Colors.white,
                // Create the shadow on the white container of the photo
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 5, left: 15, right: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Big_Text(text: "Contacter Nous"),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                                (index) {
                              return const Icon(
                                Icons.star,
                                color: Colors.green,
                                // color: AppColors.mainColor,
                                size: 15,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SmallText(text: "4.5"),
                        const SizedBox(width: 10),
                        SmallText(text: "1287"),
                        const SizedBox(width: 10),
                        SmallText(text: "comments"),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
