class PagingEntity<T> {
  final List<T> list;
  final int total;
  final int skip;
  final int limit;

  PagingEntity({
    required this.list,
    required this.total,
    required this.skip,
    required this.limit,
  });
}
