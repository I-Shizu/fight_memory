// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$CreatePostToJson(CreatePost instance) =>
    <String, dynamic>{
      'text': instance.text,
      'date': instance.date.toIso8601String(),
      'imageUrl': instance.imageUrl,
    };

_$CreatePostImpl _$$CreatePostImplFromJson(Map<String, dynamic> json) =>
    _$CreatePostImpl(
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$CreatePostImplToJson(_$CreatePostImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'date': instance.date.toIso8601String(),
      'imageUrl': instance.imageUrl,
    };
