import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<SplashViewModel>().init();
      if (!mounted) return;
      final nextRoute = context.read<SplashViewModel>().nextRoute;
      Navigator.of(context).pushReplacementNamed(nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
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
