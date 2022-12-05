import 'package:cached_network_image/cached_network_image.dart';
import 'package:documentsuploader/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeImages extends StatefulWidget {
  String image = "";
  // String insideimage = "";
  String insidetext = "";
  Function() onTap;
  HomeImages({
    Key? key,
    required this.image,
    // required this.insideimage,
    required this.insidetext,
    required this.onTap,
  }) : super(key: key);

  @override
  State<HomeImages> createState() => _HomeImagesState();
}

class _HomeImagesState extends State<HomeImages> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 0,
                        offset: Offset(0, 5),
                      )
                    ]),
                    // color: Colors.red,
                    child:
                        // Center(
                        //   child: CachedNetworkImage(
                        //     height: 150,
                        //     width: 140,
                        //     imageUrl: widget.image,
                        //     placeholder: (context, url) => SizedBox(
                        //       height: 10,
                        //       width: 10,
                        //       child: CircularProgressIndicator(
                        //         color: Color(0xff00796B),
                        //       ),
                        //     ),
                        //     errorWidget: (context, url, error) => Icon(Icons.error),
                        //   ),
                        // ),
                        Image.network(
                      widget.image,
                      height: 150,
                      width: 140,
                    ),
                  ),
                  Column(
                    children: [
                      // Image.asset(widget.insideimage),
                      sizedBoxHeight10
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            height: 40,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                widget.insidetext,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
