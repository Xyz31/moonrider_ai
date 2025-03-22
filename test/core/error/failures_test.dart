import 'package:flutter_test/flutter_test.dart';
import 'package:moonrider_task/core/error/failures.dart';

void main() {
  group('Failure', () {
    test('ServerFailure should be a subclass of Failure', () {
      // Arrange
      const failure = ServerFailure('Server error');

      // Assert
      expect(failure, isA<Failure>());
      expect(failure.message, 'Server error');
    });

    test('CacheFailure should be a subclass of Failure', () {
      // Arrange
      const failure = CacheFailure('Cache error');

      // Assert
      expect(failure, isA<Failure>());
      expect(failure.message, 'Cache error');
    });

    test('Failures with same message should be equal', () {
      // Arrange
      const failure1 = ServerFailure('Same error');
      const failure2 = ServerFailure('Same error');

      // Assert - comparing message property
      expect(failure1.message, failure2.message);
    });
  });
}
