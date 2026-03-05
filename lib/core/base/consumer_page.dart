import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 基于 Provider 的页面 State 基类
///
/// 封装 ViewModel 的自动监听和注入，简化页面代码。
/// State 只需实现 buildPage，build 自动处理。
///
/// 使用示例:
/// ```dart
/// class HomePage extends StatefulWidget {
///   const HomePage({super.key});
///
///   @override
///   State<HomePage> createState() => _HomePageState();
/// }
///
/// class _HomePageState extends ConsumerPageState<HomePage, HomeViewModel> {
///   @override
///   Widget buildPage(BuildContext context) {
///     return Scaffold(
///       body: Text('${vm.counter}'),
///       floatingActionButton: FloatingActionButton(
///         onPressed: vm.increment,
///       ),
///     );
///   }
///
///   Widget _buildTitle() => Text('Count: ${vm.counter}');
/// }
/// ```
abstract class ConsumerPageState<W extends StatefulWidget, T extends ChangeNotifier>
    extends State<W> {
  /// 当前 ViewModel，自动注入
  late final T vm;

  @override
  Widget build(BuildContext context) {
    vm = context.watch<T>();
    return buildPage(context);
  }

  /// 子类只需实现此方法，vm 已自动注入
  Widget buildPage(BuildContext context);

  /// 获取 ViewModel（不监听变化）
  T read(BuildContext context) => context.read<T>();
}
