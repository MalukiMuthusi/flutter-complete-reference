import 'dart:io';
import 'dart:math';

Iterable<int> randomNumbers() sync* {
  final random = Random();
  for (var i = 0; i < 10; ++i) {
    sleep(Duration(seconds: 1));
    yield random.nextInt(100) + 1;
  }
}

main(List<String> args) {
  final random = randomNumbers();
  for (var i in random) {
    print(i);
  }
  print('all values emitted in synchronous stream generator');
}
