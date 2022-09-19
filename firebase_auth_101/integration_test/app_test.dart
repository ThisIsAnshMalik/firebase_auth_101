import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_auth_101/view/auth/loginScreen.dart' as login;
import 'package:firebase_auth_101/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end-to-end test", () {
    testWidgets(
      "test the login screen",
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // find login email testfield
        final Finder loginEmail = find.byKey(const Key("login_email_key"));

        // find password testfield
        final Finder loginPassword =
            find.byKey(const Key("login_password_key"));

        // find the login button
        final Finder loginButton = find.byKey(const Key("login_button_key"));

        // enter an email on loginEmail text field
        await tester.enterText(loginEmail, "testno5@gmail.com");
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();

        // enter an password on password test field
        await tester.enterText(loginPassword, "testno5");
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();

        // tap the login button
        await tester.tap(loginButton);
        await Future.delayed(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      },
    );
  });
}
