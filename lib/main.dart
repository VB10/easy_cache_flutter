import 'package:flutter/material.dart';

import 'feature/view/user_view.dart';
import 'product/cache_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.instance.initPrefences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: UserView(),
    );
  }
}
