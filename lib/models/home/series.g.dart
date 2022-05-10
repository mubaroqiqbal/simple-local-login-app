// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Series _$SeriesFromJson(Map<String, dynamic> json) => Series(
      i: json['i'] == null
          ? null
          : I.fromJson(json['i'] as Map<String, dynamic>),
      id: json['id'] as String?,
      l: json['l'] as String?,
      s: json['s'] as String?,
    );

Map<String, dynamic> _$SeriesToJson(Series instance) => <String, dynamic>{
      'i': instance.i,
      'id': instance.id,
      'l': instance.l,
      's': instance.s,
    };
