import 'package:documentsuploader/model/firebase_file.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatefulWidget {
  final FirebaseFile file;
  const PdfViewer({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
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
    return Scaffold(
      appBar: appbar('Document'),
      body: !loading
          ? PDFView(
              filePath: docFile.file.path.toString(),
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xff00796B),
              ),
            ),
    );
  }
}
