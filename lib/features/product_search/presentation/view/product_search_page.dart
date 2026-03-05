import 'package:flutter/material.dart';

import '../../../../core/base/consumer_page.dart';
import '../viewmodel/product_search_viewmodel.dart';

/// 商品搜索页面 View
/// 职责：
/// - UI 展示（搜索框、分类标签、商品列表）
/// - 用户交互（输入搜索、切换分类）
/// ✅ 包含：UI 构建、用户交互
/// ❌ 不包含：业务逻辑（搜索过滤、分类筛选在 ViewModel）
class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends ConsumerPageState<ProductSearchPage, ProductSearchViewModel> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('商品搜索示例')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchBar(),
        const SizedBox(height: 16),
        _buildCategories(),
        const SizedBox(height: 16),
        Expanded(
          child: vm.loading
              ? const Center(child: CircularProgressIndicator())
              : _buildProductList(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: '搜索商品...',
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        onChanged: vm.search,
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: vm.availableCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = vm.availableCategories[index];
          final isSelected = vm.selectedCategory == category;
          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                vm.filterByCategory(category);
              }
            },
            selectedColor: isSelected ? Colors.white : null,
          );
        },
      ),
    );
  }

  Widget _buildProductList() {
    if (vm.products.isEmpty) {
      return const Center(child: Text('暂无商品'));
    }

    return ListView.separated(
      itemCount: vm.products.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final product = vm.products[index];
        return ListTile(
          leading: const Icon(Icons.smartphone),
          title: Text(
            product,
            style: vm.searchQuery.isNotEmpty
                ? const TextStyle(color: Colors.orange)
                : null,
          ),
        );
      },
    );
  }
}
