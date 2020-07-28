import 'dart:async';

import 'package:Atlezz/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash page finish', (tester) async {
    final handle = tester.ensureSemantics();

    final controller = StreamController<double>();
    await tester.pumpWidget(MaterialApp(
      home: SplashPage(
        initializeStream: () => controller.stream,
      ),
    ));
    controller.add(0);
    expect(
        tester.getSemantics(find.byType(CircularProgressIndicator)),
        matchesSemantics(
          value: '0%',
          textDirection: TextDirection.ltr,
        ));
    controller.add(0.5);
    await tester.pump();
    expect(
        tester.getSemantics(find.byType(CircularProgressIndicator)),
        matchesSemantics(
          value: '50%',
          textDirection: TextDirection.ltr,
        ));
    handle.dispose();
  });
}
