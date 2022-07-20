import 'package:freezed_annotation/freezed_annotation.dart';

part 'downloads.freezed.dart';
part 'downloads.g.dart';
//! to generate the model fjson
// !to generate the DataClass fdata!
// ptf for freezed import and pts for geneatation
// flutter pub run build_runner watch --delete-conflicting-outputs

@freezed
class Downloads with _$Downloads {
  const factory Downloads({
    @JsonKey(name: 'poster_path') required String? posterPath,
    required String? title,
  }) = _Downloads;

  factory Downloads.fromJson(Map<String, dynamic> json) =>
      _$DownloadsFromJson(json);
}
