import 'package:flutter/material.dart';

import '../../../../core/base/consumer_page.dart';
import '../../../../core/router/app_navigator.dart';
import '../../../../core/router/route_names.dart';
import '../viewmodel/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerPageState<HomePage, HomeViewModel> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(),
        actions: [
          TextButton(
            onPressed: () => AppNavigator.pushReplacementNamed(RouteNames.login),
            child: const Text('退出'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '${vm.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => AppNavigator.pushNamed(RouteNames.photoPicker),
              icon: const Icon(Icons.photo_library),
              label: const Text('Live Photo 测试'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: vm.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTitle() => Text('Count: ${vm.counter}');
}
