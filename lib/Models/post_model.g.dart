// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'localId': instance.localId,
      'text': instance.text,
      'date': instance.date.toIso8601String(),
      'imageUrl': instance.imageUrl,
    };

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      localId: (json['localId'] as num?)?.toInt(),
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'text': instance.text,
      'date': instance.date.toIso8601String(),
      'imageUrl': instance.imageUrl,
    };
