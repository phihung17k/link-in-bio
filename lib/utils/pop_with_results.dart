class PopWithResults<T> {
  final String? fromPage;
  final String? toPage;
  final T result;

  PopWithResults(
      {required this.fromPage, required this.toPage, required this.result});
}
