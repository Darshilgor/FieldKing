import 'package:field_king/packages/config.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String fileName;
  final VoidCallback onSend;

  const PdfPreviewScreen({
    Key? key,
    required this.fileName,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Preview")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.picture_as_pdf, size: 100, color: Colors.red),
          SizedBox(height: 20),
          Text(fileName, style: TextStyle(fontSize: 18)),
          SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: onSend,
            icon: Icon(Icons.send),
            label: Text("Send PDF"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              backgroundColor: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
