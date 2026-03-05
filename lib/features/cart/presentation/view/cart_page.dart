import 'package:flutter/material.dart';

import '../../../../core/base/consumer_page.dart';
import '../viewmodel/cart_viewmodel.dart';

/// 购物车页面 View
/// 职责：
/// - UI 展示（商品列表、数量、价格）
/// - 用户交互（加减数量、删除）
/// ✅ 包含：UI 构建、用户交互
/// ❌ 不包含：业务逻辑（数量限制、总价计算在 ViewModel）
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerPageState<CartPage, CartViewModel> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车示例'),
        actions: [
          if (vm.totalCount > 0)
            TextButton(
              onPressed: vm.clearCart,
              child: const Text('清空'),
            ),
        ],
      ),
      body: vm.items.isEmpty
          ? const Center(child: Text('购物车为空'))
          : _buildCartItems(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildCartItems() {
    return ListView.separated(
      itemCount: vm.items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = vm.items[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(item.quantity.toString()),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          title: Text(item.name),
          subtitle: Text('¥${item.price.toStringAsFixed(2)} × ${item.quantity} = ¥${item.totalPrice.toStringAsFixed(2)}'),
          trailing: _buildItemActions(item),
        );
      },
    );
  }

  Widget _buildItemActions(CartItemModel item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () => vm.removeItem(item.id),
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => vm.decreaseQuantity(item.id),
          iconSize: 20,
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => vm.increaseQuantity(item.id),
          iconSize: 20,
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('共 ${vm.totalCount} 件'),
          Text('合计: ¥${vm.totalPrice.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
