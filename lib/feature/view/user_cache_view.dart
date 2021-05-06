import 'package:flutter/material.dart';

import '../../product/cache_manager.dart';
import '../model/user_model.dart';

class UserCacheView extends StatefulWidget {
  @override
  _UserCacheViewState createState() => _UserCacheViewState();
}

class _UserCacheViewState extends State<UserCacheView> {
  List<Data> items = CacheManager.instance.getCacheList<Data>(Data());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cache List'),
        actions: [buildIconButtonRemove()],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Text('${items[index].email}');
        },
      ),
    );
  }

  IconButton buildIconButtonRemove() {
    return IconButton(
      icon: Icon(Icons.remove_circle),
      onPressed: () async {
        await CacheManager.instance.removeAllCache<Data>();
        setState(() {
          items = CacheManager.instance.getCacheList<Data>(Data());
        });
      },
    );
  }
}
