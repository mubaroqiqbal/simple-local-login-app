import 'package:json_annotation/json_annotation.dart';
import 'package:majootestcase/models/home/i.dart';

part 'series.g.dart';

@JsonSerializable()
class Series {
  I? i;
  String? id;
  String? l;
  String? s;

  Series({this.i, this.id, this.l, this.s});

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);

  Map<dynamic, dynamic> toJson() => _$SeriesToJson(this);
}
