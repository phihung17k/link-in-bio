import 'package:flutter_test/flutter_test.dart';
import 'package:link_in_bio/pages/sample_page.dart';

void main() {
  testWidgets('MyWidget has a title and message', (widgetTester) async {
    await widgetTester.pumpWidget(const MyWidget(title: 'T', message: 'M'));

    //Create Finders
    final Finder titleFinder = find.text('T');
    final Finder messageFinder = find.text('M');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
    //description='text "$text"';
    expect(titleFinder.description.split(" ")[1].replaceAll("\"", ""), "T");
    expect(messageFinder.description.split(" ")[1].replaceAll("\"", ""), "M");
  });
}
