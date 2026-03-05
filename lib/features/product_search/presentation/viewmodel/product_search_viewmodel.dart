import 'package:flutter/foundation.dart';

/// 商品搜索 ViewModel
/// 职责：
/// - 状态管理（搜索关键词、商品列表、分类筛选）
/// - 业务逻辑（搜索过滤、排序、分类切换）
/// ✅ 包含：状态管理、业务逻辑
/// ❌ 不包含：UI 操作（键盘、焦点、动画）
class ProductSearchViewModel extends ChangeNotifier {
  List<String> _allProducts = [
    'Apple iPhone 15',
    'Apple iPhone 15 Pro',
    'Apple iPhone 15 Pro Max',
    'Samsung Galaxy S24',
    'Samsung Galaxy S24 Ultra',
    'Xiaomi Mi 14',
    'Huawei Mate 60 Pro',
    'Xiaomi 13 Ultra',
    'OnePlus 11',
  ];

  List<String> _filteredProducts = [];
  String _searchQuery = '';
  String _selectedCategory = '全部';
  bool _loading = false;

  // Getters
  List<String> get products => _filteredProducts;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get loading => _loading;
  int get resultCount => _filteredProducts.length;

  /// 搜索商品
  /// 业务逻辑：过滤商品（支持大小写不敏感）
  void search(String query) {
    _loading = true;
    notifyListeners();

    final results = _allProducts
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();

    _filteredProducts = results;
    _searchQuery = query;

    _loading = false;
    notifyListeners();
  }

  /// 切换分类
  /// 业务逻辑：根据分类筛选商品
  void filterByCategory(String category) {
    _loading = true;
    notifyListeners();

    if (category == '全部') {
      _filteredProducts = List.from(_allProducts);
    } else {
      _filteredProducts = _allProducts.where((product) => product.contains(category)).toList();
    }

    _selectedCategory = category;
    _searchQuery = '';

    _loading = false;
    notifyListeners();
  }

  /// 清空搜索
  void clearSearch() {
    _filteredProducts = _allProducts;
    _searchQuery = '';
    _selectedCategory = '全部';
    _loading = false;
    notifyListeners();
  }

  /// 获取可用分类
  /// 数据操作：提取唯一分类标识
  List<String> get availableCategories {
    final categories = <String>['全部'];
    for (final product in _allProducts) {
      final parts = product.split(' ');
      if (parts.length > 1) {
        final category = parts[0];
        if (!categories.contains(category)) {
          categories.add(category);
        }
      }
    }
    return categories;
  }
}
