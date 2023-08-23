extension HelperExtensions on String? {
  String? charAt(int index) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (index > this!.length) {
      return null;
    }
    if (index < 0) {
      return null;
    }
    return this!.split('')[index];
  }
}
