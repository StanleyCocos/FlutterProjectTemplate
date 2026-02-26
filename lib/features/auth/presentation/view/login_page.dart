import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/utils/validators.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Form(
        key: _formKey,
        child: ListenableBuilder(
          listenable: context.watch<LoginViewModel>(),
          builder: (context, _) {
            final vm = context.read<LoginViewModel>();
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (vm.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        vm.error!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: '邮箱'),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: '密码'),
                    obscureText: true,
                    validator: (v) => Validators.required(v, '密码'),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: '登录',
                    loading: vm.loading,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await vm.login(
                        _emailController.text.trim(),
                        _passwordController.text,
                      );
                      if (!context.mounted) return;
                      if (vm.error == null) {
                        Navigator.of(context).pushReplacementNamed(RouteNames.home);
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.register),
                    child: const Text('去注册'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
