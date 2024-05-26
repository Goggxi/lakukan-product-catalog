part of 'paging_bloc.dart';

enum PagingStatus { initial, loading, loaded, error }

class PagingState<T> {
  final List<T> items;
  final int currentPage;
  final bool hasMoreData;
  final PagingStatus status;

  const PagingState({
    required this.items,
    required this.currentPage,
    required this.hasMoreData,
    required this.status,
  });

  PagingState<T> copyWith({
    List<T>? items,
    int? currentPage,
    bool? hasMoreData,
    PagingStatus? status,
  }) {
    return PagingState(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      status: status ?? this.status,
    );
  }

  static PagingState initial() {
    return const PagingState(
      items: [],
      currentPage: 1,
      hasMoreData: true,
      status: PagingStatus.initial,
    );
  }

  PagingState<T> reset() {
    return const PagingState(
      items: [],
      currentPage: 1,
      hasMoreData: true,
      status: PagingStatus.initial,
    );
  }

  PagingState<T> loading() {
    return copyWith(status: PagingStatus.loading);
  }
}
