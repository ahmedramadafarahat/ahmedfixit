import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/firebase_options.dart';
import 'package:fixit/provider/provider.dart';
import 'package:fixit/src/app_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPrefrence;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  sharedPrefrence = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme:
                notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
            home: const AppRoot(),
          );
        },
      ),
    ),
  );
}

// class RunApp extends StatefulWidget {
//   const RunApp({super.key});

//   @override
//   State<RunApp> createState() => _RunAppState();
// }

// class _RunAppState extends State<RunApp> {
//   var auth = FirebaseAuth.instance;
//   var isLogin = false;
//   checkIfLogin() async {
//     auth.authStateChanges().listen((User? user) {
//       if (user != null) {
//         setState(() {
//           isLogin = true;
//         });
//       }
//     });
//   }

//   @override
//   void initState() {
//     checkIfLogin();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: isLogin ? const CurvedNavBar() : const AppRoot(),
//     );
//   }
// }
