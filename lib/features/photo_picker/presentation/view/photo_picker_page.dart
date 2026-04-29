import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../core/base/consumer_page.dart';
import '../viewmodel/photo_picker_viewmodel.dart';

class PhotoPickerPage extends StatefulWidget {
  const PhotoPickerPage({super.key});

  @override
  State<PhotoPickerPage> createState() => _PhotoPickerPageState();
}

class _PhotoPickerPageState extends ConsumerPageState<PhotoPickerPage, PhotoPickerViewModel> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Photo 测试'),
        actions: [
          if (vm.hasSelection)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: vm.clearSelection,
              tooltip: '清除选择',
            ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openPicker(context),
        tooltip: '选择图片',
        child: const Icon(Icons.photo_library),
      ),
    );
  }

  Widget _buildBody() {
    if (vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (vm.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              vm.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }

    if (!vm.hasSelection) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              '点击右下角按钮选择图片',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '支持 iOS 实时照片 (Live Photo)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: vm.selectedAssets.length,
      itemBuilder: (_, index) {
        final asset = vm.selectedAssets[index];
        return _buildAssetItem(asset);
      },
    );
  }

  Widget _buildAssetItem(AssetEntity asset) {
    return GestureDetector(
      onTap: () => _showAssetDetail(asset),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildAssetThumbnail(asset),
          if (vm.isLivePhoto(asset))
            _buildLivePhotoBadge(),
          _buildDeleteButton(asset),
        ],
      ),
    );
  }

  Widget _buildAssetThumbnail(AssetEntity asset) {
    return AssetEntityImage(
      asset,
      isOriginal: false,
      thumbnailSize: const ThumbnailSize(200, 200),
      fit: BoxFit.cover,
      loadingBuilder: (_, __, ___) {
        return Container(
          color: Colors.grey[200],
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        );
      },
    );
  }

  Widget _buildLivePhotoBadge() {
    return Positioned(
      top: 4,
      left: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'LIVE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(AssetEntity asset) {
    return Positioned(
      top: 4,
      right: 4,
      child: GestureDetector(
        onTap: () => vm.removeAsset(asset),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  void _openPicker(BuildContext context) async {
    try {
      final result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 9,
          requestType: RequestType.image,
        ),
      );

      if (result != null && mounted) {
        vm.setSelectedAssets(result);
      }
    } catch (e) {
      if (mounted) {
        _showError('选择图片失败: $e');
      }
    }
  }

  void _showAssetDetail(AssetEntity asset) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(vm.isLivePhoto(asset) ? 'Live Photo 详情' : '图片详情'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('类型', asset.type.toString()),
            _buildDetailItem('是否 Live Photo', vm.isLivePhoto(asset) ? '是' : '否'),
            _buildDetailItem('宽度', '${asset.width}'),
            _buildDetailItem('高度', '${asset.height}'),
            _buildDetailItem('时长', '${asset.duration}'),
            _buildDetailItem('创建时间', '${asset.createDateTime}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
