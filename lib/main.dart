import 'package:barcode_scanner_flutter/controllers/home_controller.dart';
import 'package:barcode_scanner_flutter/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(HomeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

handleException({
  @required exception,
  @required stackTrace,
  @required String exceptionClass,
  @required String exceptionMsg,
}) {
  debugPrint('\n');
  debugPrint("========================================START OF EXCEPTION========================================");
  debugPrint("==================================================================================================");
  debugPrint('\n');
  debugPrint('$exceptionClass - $exceptionMsg: \n${exception.toString()}\n$stackTrace');
  debugPrint('\n');
  debugPrint("==================================================================================================");
  debugPrint("=========================================END OF EXCEPTION=========================================");
  debugPrint('\n');
}