

import 'package:freezed_annotation/freezed_annotation.dart';
part 'main_failure.freezed.dart';

// fenvt for crating event
@freezed
class MainFailure with _$MainFailure{
  const factory MainFailure.clientFailure() = _ClientFailure;
  const factory MainFailure.serverFailure() = _ServerFailure;

  
}