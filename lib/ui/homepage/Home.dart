import 'package:documentsuploader/ui/homepage/sidedrawer.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Documents Uploader"),
        backgroundColor: const Color(0xff00796B),
      ),
      drawer: sideDrawer(),
      body: Column(
        children: [
          Text('hello'),
        ],
      ),
    );
  }
}
