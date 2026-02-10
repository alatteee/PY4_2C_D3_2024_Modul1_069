class CounterController {
  int _counter = 0;
  int _step = 1;
  final List<String> _history = [];

  int get value => _counter;
  int get step => _step;
  List<String> get history => _history;

  void setStep(int newValue) {
    _step = newValue;
  }

  void _addLog(String action) {
    String time = DateTime.now().toString().substring(11, 16);
    _history.insert(0, "$action pada jam $time");
    if (_history.length > 5) {
      _history.removeLast();
    }
  }

  void increment() {
    _counter += _step;
    _addLog("Tambah $_step");
  }

  void decrement() {
    if (_counter >= _step) {
      _counter -= _step;
      _addLog("Kurang $_step");
    } else {
      _counter = 0;
      _addLog("Reset ke 0");
    }
  }

  void reset() {
    _counter = 0;
    _addLog("Reset total");
  }
}