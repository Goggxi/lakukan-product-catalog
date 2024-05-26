import 'package:flutter_bloc/flutter_bloc.dart';

part 'paging_event.dart';
part 'paging_state.dart';

class PagingBloc extends Bloc<PagingEvent, PagingState> {
  PagingBloc() : super(PagingState.initial()) {
    on<PagingEvent>((event, emit) {});
  }
}
