import 'package:flutter_test/flutter_test.dart';
import 'package:bike_shopping/main.dart';

void main() {
  testWidgets('BikeApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BikeApp());
  });
}
