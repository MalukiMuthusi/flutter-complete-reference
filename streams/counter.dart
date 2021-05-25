Stream<int> counterStream(int maxCount) async* {
  final delay = const Duration(seconds: 1);
  var count = 0;

  while (true) {
    if (count == maxCount) break;
    await Future.delayed(delay);
    yield ++count;
  }
}

main(List<String> args) async {
  const count = 10;
  await for (var c in counterStream(count)) {
    print(c);
  }
  print('emitted all ${count}');
}
