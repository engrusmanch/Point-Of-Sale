import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:point_of_sale/features/navigationbar/presentation/screen/bottom_navigation_bar.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class VerifyPhone extends StatelessWidget {
  const VerifyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone Number"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SupaVerifyPhone(
          onSuccess: (response) => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyNavigationBar())),
        ),
      ),
    );
  }
}
