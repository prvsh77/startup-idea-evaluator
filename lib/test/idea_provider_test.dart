import 'package:flutter_test/flutter_test.dart';
import 'package:startup_idea_evaluator/providers/idea_provider.dart';

void main() {
  group('Idea Provider Tests', () {
    test('Initial state is empty', () {
      final provider = IdeaProvider();
      expect(provider.ideas, isEmpty);
    });
  });
}
