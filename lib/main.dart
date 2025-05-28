import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Tactical Comms',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.green[700],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.green[700]),
          ),
          colorScheme: ColorScheme.dark(
            primary: Colors.green[700]!,
            secondary: Colors.green[700]!,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.green[700]),
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green[700]!),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return authProvider.isAuthenticated
        ? const DashboardScreen()
        : Builder(
            builder: (context) => LoginScreen(),
          );
  }
}