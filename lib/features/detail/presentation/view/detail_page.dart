import 'package:flutter/material.dart';

import '../../../../core/router/app_navigator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppNavigator.pop(),
        ),
        title: const Text('详情页'),
      ),
      body: const Center(
        child: Text('这是详情页'),
      ),
    );
  }
}
