/// An asynchronous generator producing 100 random numbers, one number per second.
//

import 'dart:math';

Stream<int> randomNumbers() async* {
  final random = Random(); // generator starts emitting values

  for (var i = 0; i < 100; ++i) {
    await Future.delayed(Duration(seconds: 1));
    yield random.nextInt(100) + 1;
    // we can add more yield statements to push values to the stream
  }
}

main(List<String> args) async {
  final stream = randomNumbers();
  await for (var value in stream) {
    print(value);
  }
  print('all values emitted');
}
