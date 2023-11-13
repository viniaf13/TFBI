class InsufficientSpaceException implements Exception {
  InsufficientSpaceException({required this.message});
  String message;

  @override
  String toString() {
    return 'InsufficientSpaceException: $message';
  }
}
