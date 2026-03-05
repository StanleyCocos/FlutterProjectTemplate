import 'package:flutter/foundation.dart';

class ListViewModel extends ChangeNotifier {
  List<ItemData> _items = [];
  bool _loading = false;

  List<ItemData> get items => _items;
  bool get loading => _loading;

  Future<void> loadData() async {
    _loading = true;
    notifyListeners();

    // 模拟网络请求延迟3秒
    await Future.delayed(const Duration(seconds: 3));

    _items = List.generate(10, (index) => ItemData(
          id: index,
          title: 'Item ${index + 1}',
          description: 'This is the description for item ${index + 1}',
        ));

    _loading = false;
    notifyListeners();
  }
}

class ItemData {
  final int id;
  final String title;
  final String description;

  ItemData({
    required this.id,
    required this.title,
    required this.description,
  });
}
