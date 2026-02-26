import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_project_template/app.dart';
import 'package:flutter_project_template/core/constants/app_constants.dart';

void main() {
  testWidgets('App 启动并显示 Splash', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text(AppConstants.appName), findsOneWidget);
  });
}
