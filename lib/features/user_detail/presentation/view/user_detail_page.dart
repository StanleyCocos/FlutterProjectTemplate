import 'package:flutter/material.dart';

import '../../../../core/base/consumer_page.dart';
import '../viewmodel/user_detail_viewmodel.dart';

/// 用户详情页面 View
/// 职责：
/// - UI 展示（用户信息表单）
/// - 用户交互（编辑、保存）
/// ✅ 包含：UI 构建、用户交互
/// ❌ 不包含：业务逻辑（验证、保存在 ViewModel）
class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends ConsumerPageState<UserDetailPage, UserDetailViewModel> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户详情'),
        actions: [
          if (vm.editing)
            TextButton(
              onPressed: vm.cancelEditing,
              child: const Text('取消'),
            ),
          if (vm.editing)
            TextButton(
              onPressed: vm.saveUser,
              child: const Text('保存'),
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameField(),
          const SizedBox(height: 16),
          _buildEmailField(),
          const SizedBox(height: 16),
          if (!vm.editing) _buildActionButton(),
          if (vm.editing) _buildEditForm(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: '用户名',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      controller: TextEditingController(text: vm.user.name),
      enabled: vm.editing,
      onChanged: (value) => vm.editedName = value,
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: '邮箱',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      controller: TextEditingController(text: vm.user.email),
      enabled: vm.editing,
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => vm.startEditing(),
        child: const Text('编辑'),
      ),
    );
  }

  Widget _buildEditForm() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: '新用户名',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            onChanged: (value) => vm.editedName = value,
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () => vm.saveUser(),
            child: const Text('保存'),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    vm.cancelEditing();
    super.dispose();
  }
}
