import 'package:documentsuploader/ui/items/documents.dart';
import 'package:documentsuploader/utils/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class sideDrawer extends StatelessWidget {
  sideDrawer({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            // ignore: sort_child_properties_last
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 300,
                    child: Center(
                      child: Text(
                        user.email.toString()[0].toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff33691E),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  sizedBoxHeight10,
                  Text(
                    user.email.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              color: Color(0xff009688),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.drive_folder_upload_outlined),
              title: const Text('Documents'),
              onTap: () {
                Get.to(Documents());
              }),
          ListTile(
            leading: const Icon(Icons.file_present),
            title: const Text('Presentations'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Pictures'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {FirebaseAuth.instance.signOut()},
          ),
        ],
      ),
    );
  }
}
