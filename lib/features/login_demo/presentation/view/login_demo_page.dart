import 'package:flutter/material.dart';

import '../../../../core/base/consumer_page.dart';
import '../../../../core/router/app_navigator.dart';
import '../viewmodel/login_demo_viewmodel.dart';

/// 登录页面 View
/// 职责：
/// - UI 展示（表单、loading、错误信息）
/// - 用户交互（输入、点击）
/// - UI 导航（登录成功跳转）
/// - UI 操作（显示提示）
/// ✅ 包含：UI 构建、用户交互、页面导航
/// ❌ 不包含：业务逻辑（验证规则在 ViewModel）
class LoginDemoPage extends StatefulWidget {
  const LoginDemoPage({super.key});

  @override
  State<LoginDemoPage> createState() => _LoginDemoPageState();
}

class _LoginDemoPageState extends ConsumerPageState<LoginDemoPage, LoginDemoViewModel> {
  @override
  void initState() {
    super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) => vm.clearForm());
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录示例')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 24),
          _buildErrorMessage(),
          _buildLoginButton(),
          _buildDemoButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: '邮箱',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: vm.updateEmail,
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      obscureText: vm.obscurePassword,
      decoration: InputDecoration(
        labelText: '密码',
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        suffixIcon: IconButton(
          icon: Icon(vm.obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: vm.togglePasswordVisibility,
        ),
      ),
      onChanged: vm.updatePassword,
    );
  }

  Widget _buildErrorMessage() {
    if (vm.error == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          vm.error!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: vm.loading ? null : () => _onLoginPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        child: vm.loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : const Text('登录'),
      ),
    );
  }

  Widget _buildDemoButton() {
    return TextButton(
      onPressed: () {
        vm.updateEmail('demo@example.com');
        vm.updatePassword('password');
      },
      child: const Text('填充测试账号'),
    );
  }

  void _onLoginPressed() async {
    await vm.login();
    if (vm.error == null && vm.user != null) {
      // UI 导航：登录成功
      AppNavigator.pushReplacementNamed('/home');
    }
  }
}
