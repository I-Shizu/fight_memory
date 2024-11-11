// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$UpdatePostToJson(UpdatePost instance) =>
    <String, dynamic>{
      'text': instance.text,
      'imageUrl': instance.imageUrl,
      'date': instance.date?.toIso8601String(),
    };

_$UpdatePostImpl _$$UpdatePostImplFromJson(Map<String, dynamic> json) =>
    _$UpdatePostImpl(
      text: json['text'] as String?,
      imageUrl: json['imageUrl'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$UpdatePostImplToJson(_$UpdatePostImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'imageUrl': instance.imageUrl,
      'date': instance.date?.toIso8601String(),
    };
