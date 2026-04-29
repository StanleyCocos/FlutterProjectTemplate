import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PhotoPickerViewModel extends ChangeNotifier {
  final List<AssetEntity> _selectedAssets = [];
  List<AssetEntity> get selectedAssets => List.unmodifiable(_selectedAssets);

  bool get hasSelection => _selectedAssets.isNotEmpty;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// 打开资源选择器（需要在 View 层调用）
  Future<void> openPicker() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 这个方法需要在 View 层调用，传入 BuildContext
      // ViewModel 只负责管理状态
      throw Exception('请在 View 层调用 AssetPicker.pickAssets');
    } catch (e) {
      _errorMessage = '选择图片失败: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 设置选中的资源列表
  void setSelectedAssets(List<AssetEntity> assets) {
    _selectedAssets.clear();
    _selectedAssets.addAll(assets);
    _errorMessage = null;
    notifyListeners();
  }

  /// 清除选择
  void clearSelection() {
    _selectedAssets.clear();
    _errorMessage = null;
    notifyListeners();
  }

  /// 删除选中的资源
  void removeAsset(AssetEntity asset) {
    _selectedAssets.remove(asset);
    notifyListeners();
  }

  /// 获取资源的缩略图数据
  Future<Uint8List?> getThumbnailData(AssetEntity asset, {int width = 100, int height = 100}) async {
    try {
      return await asset.thumbnailDataWithSize(
        ThumbnailSize(width, height),
        quality: 90,
      );
    } catch (e) {
      if (kDebugMode) {
        print('获取缩略图失败: $e');
      }
      return null;
    }
  }

  /// 获取资源的数据（用于显示）
  Future<File?> getFile(AssetEntity asset) async {
    try {
      return await asset.file;
    } catch (e) {
      if (kDebugMode) {
        print('获取文件失败: $e');
      }
      return null;
    }
  }

  /// 检查是否为 Live Photo
  bool isLivePhoto(AssetEntity asset) {
    return asset.type == AssetType.image && asset.isLivePhoto;
  }
}
