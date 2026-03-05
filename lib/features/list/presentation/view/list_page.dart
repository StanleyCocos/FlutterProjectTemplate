import 'package:flutter/material.dart';

import '../../../../core/base/consumer_page.dart';
import '../../../../core/router/app_navigator.dart';
import '../../../../core/router/route_names.dart';
import '../viewmodel/list_viewmodel.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerPageState<ListPage, ListViewModel> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.loadData();
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('列表页'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (vm.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (vm.items.isEmpty) {
      return const Center(
        child: Text('暂无数据'),
      );
    }

    return ListView.builder(
      itemCount: vm.items.length,
      itemBuilder: (context, index) {
        final item = vm.items[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.description),
          onTap: () => _onItemTap(index),
        );
      },
    );
  }

  void _onItemTap(int index) {
    // UI 交互逻辑在 View 层处理
    if (index % 2 == 1) {
      AppNavigator.pushNamed(RouteNames.detail);
    } else {
      _showCustomDialog();
    }
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示'),
        content: const Text('您点击了偶数索引的项'),
        actions: [
          TextButton(
            onPressed: () => AppNavigator.pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
