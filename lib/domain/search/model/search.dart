import 'package:json_annotation/json_annotation.dart';
part 'search.g.dart';

@JsonSerializable(explicitToJson: true)
class Search {
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;
  List<Result>? result;

  Search({
    this.totalPages,
    required this.totalResults,
    this.result,
  });


  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}


@JsonSerializable()
class Result {
  String? id;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey(name: 'poster_path')
  String? posterPath;

  Result({
    this.id,
    this.originalTitle,
    this.posterPath,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}



