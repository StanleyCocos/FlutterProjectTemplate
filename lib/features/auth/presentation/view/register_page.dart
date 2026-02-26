import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/utils/validators.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
      body: Form(
        key: _formKey,
        child: ListenableBuilder(
          listenable: context.watch<RegisterViewModel>(),
          builder: (context, _) {
            final vm = context.read<RegisterViewModel>();
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: '昵称（选填）'),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: '注册',
                    loading: vm.loading,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await vm.register(
                        _emailController.text.trim(),
                        _passwordController.text,
                        _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
                      );
                      if (!context.mounted) return;
                      if (vm.error == null) {
                        Navigator.of(context).pushReplacementNamed(RouteNames.home);
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(RouteNames.login),
                    child: const Text('去登录'),
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
