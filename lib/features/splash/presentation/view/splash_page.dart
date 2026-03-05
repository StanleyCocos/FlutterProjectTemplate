import 'package:flutter/material.dart';

import '../../../../core/base/consumer_page.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_navigator.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerPageState<SplashPage, SplashViewModel> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await vm.init();
      if (!mounted) return;
      AppNavigator.pushReplacementNamed(vm.nextRoute);
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
