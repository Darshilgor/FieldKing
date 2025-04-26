import 'dart:io';

import 'package:field_king/packages/config.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPreviewScreen extends StatelessWidget {
  final File file;
  final VoidCallback onSend;

  const PdfPreviewScreen({
    Key? key,
    required this.file,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.path.split('/').last),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: onSend,
          ),
        ],
      ),
      body: PDFView(
        filePath: file.path,
      ),
    );
  }
}
