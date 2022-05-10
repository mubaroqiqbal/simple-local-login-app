// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      i: json['i'] == null ? null : I.fromJson(json['i'] as Map<String, dynamic>),
      id: json['id'] as String?,
      title: json['l'] as String?,
      q: json['q'] as String?,
      rank: json['rank'] as int?,
      s: json['s'] as String?,
      series: (json['v'] as List<dynamic>?)?.map((e) => Series.fromJson(e as Map<String, dynamic>)).toList(),
      vt: json['vt'] as int?,
      year: json['year'] as int?,
      yr: json['yr'] as String?,
    )..releaseYear = json['y'] as int?;

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'i': instance.i,
      'id': instance.id,
      'l': instance.title,
      'q': instance.q,
      'rank': instance.rank,
      's': instance.s,
      'v': instance.series,
      'vt': instance.vt,
      'year': instance.year,
      'yr': instance.yr,
      'y': instance.releaseYear,
    };
