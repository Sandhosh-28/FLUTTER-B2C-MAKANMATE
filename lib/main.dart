import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'Const/approute.dart';
import 'Const/colors.dart';
import 'locator/locator.dart';

Future<void> main() async {
  // setupDependencies();
  // runApp( MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: MyColors.primaryCustom,
//         appBarTheme: AppBarTheme(
//             elevation: 1,
//             toolbarHeight: 70,
//             color: MyColors.appBarTheme,
//             iconTheme: const IconThemeData(color: MyColors.black),
//             titleTextStyle: TextStyle(
//               fontFamily: MyFont.myFont,
//               fontWeight: FontWeight.w900,
//               fontSize: 20,
//               color: MyColors.black,
//             )),
//       ),
//       initialRoute: Routes.walkthroughScreen1,
//       // initialRoute: Routes.loginScreen,
//       getPages: pages,
//     );
//   }
// }



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PDFViewerPage(),
    );
  }
}

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late String _localPath;
  late String _pdfPath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initPath();
  }

  // Initialize the directory path where the downloaded file will be saved
  Future<void> _initPath() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _localPath = directory.path;
      _pdfPath = '$_localPath/sample.pdf';
    });
  }

  // Download PDF file
  Future<void> _downloadPDF() async {
    setState(() {
      _isLoading = true;
    });
    final url = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"; // Replace with your PDF file URL
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: _localPath,
      fileName: "sample.pdf",
      showNotification: true,
      openFileFromNotification: true,
    );

    FlutterDownloader.registerCallback((id, status, progress) {
      if (status == DownloadTaskStatus.complete) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pdfPath == null
          ? Center(child: Text("PDF not downloaded yet"))
          : PDFView(
        filePath: _pdfPath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageSnap: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _downloadPDF,
        child: Icon(Icons.download),
      ),
    );
  }
}