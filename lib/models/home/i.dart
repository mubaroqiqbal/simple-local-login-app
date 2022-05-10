import 'package:json_annotation/json_annotation.dart';

part 'i.g.dart';

@JsonSerializable()
class I {
  int? height;
  String? imageUrl;
  int? width;

  I({
    this.height,
    this.imageUrl,
    this.width,
  });

  factory I.fromJson(Map<String, dynamic> json) => _$IFromJson(json);

  Map<dynamic, dynamic> toJson() => _$IToJson(this);
}
