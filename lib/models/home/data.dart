import 'package:json_annotation/json_annotation.dart';
import 'package:majootestcase/models/home/i.dart';
import 'package:majootestcase/models/home/series.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  I? i;
  String? id;
  @JsonKey(name: "l")
  String? title;
  String? q;
  int? rank;
  String? s;
  @JsonKey(name: "v")
  List<Series>? series;
  int? vt;
  int? year;
  String? yr;
  @JsonKey(name: "y")
  int? releaseYear;

  Data({this.i, this.id, this.title, this.q, this.rank, this.s, this.series, this.vt, this.year, this.yr, this.releaseYear});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<dynamic, dynamic> toJson() => _$DataToJson(this);
}
