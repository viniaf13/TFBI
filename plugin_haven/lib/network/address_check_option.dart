class ConnectionCheckOption {
  final Uri uri;
  final int port;
  final Duration timeout;

  ConnectionCheckOption({
    required this.uri,
    required this.port,
    required this.timeout,
  });
}
