import 'package:json_annotation/json_annotation.dart';
import 'package:majootestcase/models/home/data.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: "d")
  List<Data> data;
  @JsonKey(name: "q")
  String? query;
  int? v;

  MovieResponse({this.data = const <Data>[], this.query, this.v});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);

  Map<dynamic, dynamic> toJson() => _$MovieResponseToJson(this);
}
