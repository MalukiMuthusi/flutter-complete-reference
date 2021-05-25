import 'dart:async';
import 'dart:math';

/// generate random numbers
class RandomStream {
  final int maxValue;
  static final _random = Random();
  Timer? _timer;
  late int _currentCount;
  late StreamController<int> _controller;

  RandomStream({
    this.maxValue = 100,
  }) {
    this._currentCount = 0;
    _controller = StreamController(
      onCancel: _stopTimer,
      onResume: _startStream,
      onPause: _stopTimer,
      onListen: _startStream,
    );
  }

// used to subscribe to the stream
  Stream<int> get stream => _controller.stream;

  // start emitting values after each second
  void _startStream() {
    _timer = Timer.periodic(const Duration(seconds: 1), _runStream);
    _currentCount = 0;
  }

  // stop the time anc close the stream/unsubscribe
  void _stopTimer() {
    _timer?.cancel();
    _controller.close();
  }

  // emit values
  void _runStream(Timer timer) {
    _currentCount++;
    _controller.add(_random.nextInt(maxValue));
    if (_currentCount == maxValue) {
      _stopTimer();
    }
  }
}

main(List<String> args) async {
  // subscribe to the stream
  final stream = RandomStream().stream;

  // sleep for 2 seconds
  await Future.delayed(const Duration(seconds: 2));

  // print values emitted by the stream generator
  final subscriber1 = stream.listen((int random) {
    print(random);
  });

  // sleep for 5 seconds
  //
  // in the background the stream generator is generating values
  await Future.delayed(const Duration(seconds: 5));

  // cancel subscription
  subscriber1.cancel();
  print('subscriber1 unsubscribed');
}
