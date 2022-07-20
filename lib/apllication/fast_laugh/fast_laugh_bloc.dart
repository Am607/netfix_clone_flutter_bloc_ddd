import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/downloads/model/downloads.dart';
import 'package:dartz/dartz.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  final IDownloadsRepo _downloadsRepo;
  FastLaughBloc(this._downloadsRepo) : super(FastLaughState.initial()) {
    on<_Initial>((event, emit) async {
      // initile emit
      emit(
        const FastLaughState(videoList: [], isLoading: true, isError: false),
      );
      final Either<MainFailure, List<Downloads>> downloadOption =
          await _downloadsRepo.getDownloadsImages();

      final stater = downloadOption.fold(
        (l) => const FastLaughState(
            videoList: [], isLoading: false, isError: true),
        (r) => FastLaughState(videoList: r, isLoading: false, isError: false),
      );

      emit(stater);
    });
  }
}
