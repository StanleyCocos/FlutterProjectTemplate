import 'package:flutter/foundation.dart';
import 'package:flutter_project_template/features/cart/domain/models/cart_item_model.dart';



/// 购物车 ViewModel
/// 职责：
/// - 状态管理（商品列表、总价）
/// - 业务逻辑（增减数量、删除商品、计算总价）
/// - 数据转换（商品操作）
/// ✅ 包含：状态管理、业务逻辑、数据操作
/// ❌ 不包含：UI 操作（显示、动画、Context 操作）
class CartViewModel extends ChangeNotifier {
  final List<CartItemModel> _items = [
    CartItemModel(id: '1', name: '商品A', price: 99.0, quantity: 1),
    CartItemModel(id: '2', name: '商品B', price: 199.0, quantity: 2),
    CartItemModel(id: '3', name: '商品C', price: 299.0, quantity: 1),
  ];

  // Getters
  List<CartItemModel> get items => _items;
  int get totalCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// 增加商品数量
  /// 业务逻辑：判断库存限制、最大数量等
  void increaseQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0 && _items[index].quantity < 99) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  /// 减少商品数量
  /// 业务逻辑：判断最小数量为 1
  void decreaseQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  /// 删除商品
  /// 业务逻辑：确认删除
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  /// 清空购物车
  /// 业务逻辑：确认清空
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// 获取指定商品数量
  /// 数据操作：查找和返回
  int getItemQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index < 0) return 0;
    return _items[index].quantity;
  }
}
