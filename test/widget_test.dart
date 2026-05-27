import 'package:flutter_test/flutter_test.dart';

import 'package:soma/app/app.dart';
import 'package:soma/shared/widgets/logo_soma.dart';

void main() {
  testWidgets('Soma opens splash and navigates to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SomaApp());

    expect(find.byType(LogoSoma), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Entrar'), findsOneWidget);
  });
}
