extension StringExtension on String {
  T? tryParse<T>() {
    return switch (T) {
      bool => bool.fromEnvironment(this) as T,
      int => int.tryParse(this) as T?,
      double => double.parse(this) as T,
      String => this as T,
      _ => null,
    };
  }
}
