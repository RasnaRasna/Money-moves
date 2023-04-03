// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:money_management2/db/transaction/transaction_db.dart';

// import 'package:money_management2/models/category/category_model.dart';
// import 'package:money_management2/models/transactions/transaction_model.dart';
// import 'package:money_management2/OnbordingScreen/splash.dart';
// import 'package:money_management2/widgets/Homeone/Homeonet.dart';
// import 'package:money_management2/widgets/bottonm%20google/gbottom_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// int? isviewsd;
// Future<void> main() async {
//   // final obj1 = CategoryDB();
//   // final obj2 = CategoryDB();
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();

//   if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
//     Hive.registerAdapter(CategoryTypeAdapter());
//   }

//   if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
//     Hive.registerAdapter(CategoryModelAdapter());
//   }
// // Check if transactionModel box is open
//   if (!Hive.isBoxOpen(TRANSACTION_DB_NAME)) {
// // If not open, open the box
//     await Hive.openBox<transactionModel>(TRANSACTION_DB_NAME);
//   }
//   if (!Hive.isAdapterRegistered(transactionModelAdapter().typeId)) {
//     Hive.registerAdapter(transactionModelAdapter());
//   }
//   if (!Hive.isAdapterRegistered(SplashscreensAdapter().typeId)) {
//     Hive.registerAdapter(SplashscreensAdapter());
//     await Hive.openBox<Splashscreens>('Splashscreens');
//   }

//   // SharedPreferences prefs = await SharedPreferences.getInstance();
//   // isviewsd = prefs.getInt('isOnboarded');

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       // home: HomePage(),
//       home: const HomePage(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management2/OnbordingScreen/splash.dart';
import 'package:money_management2/models/category/category_model.dart';
import 'package:money_management2/models/transactions/transaction_model.dart';

int? isviewsd;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the CategoryTypeAdapter and CategoryModelAdapter
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  // Register the TransactionModelAdapter and open the transactionModel box
  Hive.registerAdapter(transactionModelAdapter());

  Hive.registerAdapter(SplashscreensAdapter());
  if (!Hive.isBoxOpen('Splashscreens')) {
    await Hive.openBox<Splashscreens>('Splashscreens');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
