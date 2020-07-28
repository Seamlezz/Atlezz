import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'helpers/initialize.dart';
import 'pages/splash_page.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(AtlezzApp());
}

FirebaseAnalytics analytics = FirebaseAnalytics();

class AtlezzApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Atlezz",
      home: SplashPage(
        initializeStream: initializeApplication,
      ),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.redAccent,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.redAccent,
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
