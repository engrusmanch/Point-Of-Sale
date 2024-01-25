import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/features/authentication/screens/verify_phone_screen.dart';
import 'package:point_of_sale/features/navigationbar/presentation/screen/bottom_navigation_bar.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: // Create a Email sign-in/sign-up form
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: // Create a Email sign-in/sign-up form
            SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
          onSignInComplete: (response) {
            // do something, for example: navigate('home');
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyNavigationBar()));
          },
          onSignUpComplete: (response) {
            // do something, for example: navigate("wait_for_email");
          },
          metadataFields: [
            MetaDataField(
              prefixIcon: const Icon(Icons.person),
              label: 'Username',
              key: 'username',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter something';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
