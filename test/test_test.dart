import 'package:test/test.dart';

// void main() {
//   group('Calculator', () {
//     test('Should sum two values', () {
//       // act
//       final result = sum(2, 3);
//       // assert
//       expect(result, 5);
//     });
//   });
// }

void main() {
  group('Calculator', () {
    // arrange
    const value1 = 2;
    const value2 = 3;

    test('Should sum two values', () {
      // arrange
      const expected = 5;
      // act
      final result = sum(value1, value2);
      // assert
      assertCorrectResult(expected, result);
    });
    test('Subtract two values', () {
      // arrange
      const expected = 1;
      // act
      final result = subtract(value2, value1);
      // assert
      assertCorrectResult(expected, result);
    });
  });
}

void assertCorrectResult(int value1, int value2) {
  return expect(value1, value2);
}

int sum(int a, int b) => a + b;
int subtract(int a, int b) => a - b;

// int sum(int a, int b) {
//   return a + b;
// }


