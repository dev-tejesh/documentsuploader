import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../api/firebase_api.dart';
import '../../model/firebase_file.dart';

class ImagePage extends StatefulWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late FileInfo docFile;
  bool loading = true;
  getFile() async {
    docFile = await DefaultCacheManager().downloadFile(widget.file.url);
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    getFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isImage = [
      '.jpeg',
      '.jpg',
      '.png',
    ].any(widget.file.name.contains);
    print("checking" + widget.file.url);

    print(widget.file.url);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.file.name),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                await FirebaseApi.downloadFile(widget.file.ref);

                final snackBar = SnackBar(
                  content: Text('Downloaded ${widget.file.name}'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: isImage
            ? Image.network(
                widget.file.url,
                height: double.infinity,
                fit: BoxFit.cover,
              )
            : !loading
                ? PDFView(
                    filePath: docFile.file.path.toString(),
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    // onRender: (_pages) {
                    //   setState(() {
                    //     pages = _pages;
                    //     isReady = true;
                    //   });
                    // },
                    onError: (error) {
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      print('$page: ${error.toString()}');
                    },
                    // onViewCreated: (PDFViewController pdfViewController) {
                    //   _controller.complete(pdfViewController);
                    // },
                    // onPageChanged: (int page, int total) {
                    //   print('page change: $page/$total');
                    // },
                  )
                : Container(
                    child: CircularProgressIndicator(),
                  )
        // Center(
        //     child: Text(
        //       'Cannot be displayed',
        //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        );
  }
}
