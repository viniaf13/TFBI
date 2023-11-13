class PolicyLookupException implements Exception {
  PolicyLookupException({
    required this.errorMessage,
  });

  String errorMessage;

  @override
  String toString() {
    return 'PolicyLookupException: $errorMessage';
  }
}
