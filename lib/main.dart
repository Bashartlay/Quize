import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests_system/config/git_it.dart';
import 'package:tests_system/screens/name_registration_page.dart';
import 'package:tests_system/screens/the_tests.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}

Future<void> init() async {
  GetIt.I.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  await GetIt.I.isReady<SharedPreferences>();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I.isReady<SharedPreferences>(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          final prefs = GetIt.I<SharedPreferences>();
          final name = prefs.getString('name');
          final password = prefs.getString('password');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: (name == null || password == null)
                ? NameRegistrationPage()
                : TheTests(),
          );
        }
      },
    );
  }
}
