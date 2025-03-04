import 'package:chatboat/Servieces/auth_serviece.dart';
import 'package:chatboat/Servieces/database_service.dart';
import 'package:chatboat/Servieces/media_serviece.dart';
import 'package:chatboat/firebase_options.dart';
import 'package:chatboat/ui/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Initialize GetIt
final GetIt sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register services with GetIt
  setupLocator();

  runApp(const MyApp());
}

void setupLocator() {
  sl.registerLazySingleton<DatabaseService>(() => DatabaseService());

  sl.registerLazySingleton<MediaService>(() => MediaService());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBoat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
