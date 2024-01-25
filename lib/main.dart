import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:point_of_sale/features/authentication/screens/sign_in_screen.dart';
import 'package:point_of_sale/features/dashboard/data_source/source/list_source.dart';
import 'package:point_of_sale/features/dashboard/domain/entity/product.dart';
import 'package:point_of_sale/features/dashboard/presentation/init_dashboard.dart';
import 'package:point_of_sale/features/dashboard/presentation/screens/home_screen.dart';
import 'package:point_of_sale/features/navigationbar/presentation/screen/bottom_navigation_bar.dart';
import 'package:point_of_sale/init_all.dart';
import 'package:point_of_sale/init_isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseStorageClient? client;
Supabase? supabase;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_KEY'];
  supabase =
      await Supabase.initialize(url: supabaseUrl!, anonKey: supabaseKey!);
  client = SupabaseStorageClient(
    '$supabaseUrl/storage/v1',
    {
      'Authorization': 'Bearer $supabaseKey',
    },
  );
  await IsarSingleton.initialize();
  // await addDummyData();
  await initAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // The Mandy red, light theme.
        theme: FlexThemeData.light(scheme: FlexScheme.purpleM3)
            .copyWith(useMaterial3: true),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.purpleM3)
            .copyWith(useMaterial3: true),
        // Use dark or light theme based on system setting.
        themeMode: ThemeMode.system,
        home: (supabase?.client.auth.currentSession != null)
            ? MyNavigationBar()
            : AuthenticationScreen());
  }
}
