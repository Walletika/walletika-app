class ProcessState {
  bool _isRunning = false;

  bool get isRunning => _isRunning;

  bool run() {
    if (isRunning) return false;

    _isRunning = true;
    return true;
  }

  void finished() => _isRunning = false;
}
