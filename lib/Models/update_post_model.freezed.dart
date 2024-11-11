// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePost _$UpdatePostFromJson(Map<String, dynamic> json) {
  return _UpdatePost.fromJson(json);
}

/// @nodoc
mixin _$UpdatePost {
  String? get text => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  /// Serializes this UpdatePost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePostCopyWith<UpdatePost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePostCopyWith<$Res> {
  factory $UpdatePostCopyWith(
          UpdatePost value, $Res Function(UpdatePost) then) =
      _$UpdatePostCopyWithImpl<$Res, UpdatePost>;
  @useResult
  $Res call({String? text, String? imageUrl, DateTime? date});
}

/// @nodoc
class _$UpdatePostCopyWithImpl<$Res, $Val extends UpdatePost>
    implements $UpdatePostCopyWith<$Res> {
  _$UpdatePostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? imageUrl = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePostImplCopyWith<$Res>
    implements $UpdatePostCopyWith<$Res> {
  factory _$$UpdatePostImplCopyWith(
          _$UpdatePostImpl value, $Res Function(_$UpdatePostImpl) then) =
      __$$UpdatePostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, String? imageUrl, DateTime? date});
}

/// @nodoc
class __$$UpdatePostImplCopyWithImpl<$Res>
    extends _$UpdatePostCopyWithImpl<$Res, _$UpdatePostImpl>
    implements _$$UpdatePostImplCopyWith<$Res> {
  __$$UpdatePostImplCopyWithImpl(
      _$UpdatePostImpl _value, $Res Function(_$UpdatePostImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? imageUrl = freezed,
    Object? date = freezed,
  }) {
    return _then(_$UpdatePostImpl(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePostImpl implements _UpdatePost {
  const _$UpdatePostImpl({this.text, this.imageUrl, this.date});

  factory _$UpdatePostImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePostImplFromJson(json);

  @override
  final String? text;
  @override
  final String? imageUrl;
  @override
  final DateTime? date;

  @override
  String toString() {
    return 'UpdatePost(text: $text, imageUrl: $imageUrl, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePostImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, imageUrl, date);

  /// Create a copy of UpdatePost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePostImplCopyWith<_$UpdatePostImpl> get copyWith =>
      __$$UpdatePostImplCopyWithImpl<_$UpdatePostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePostImplToJson(
      this,
    );
  }
  
  @override
  Map<String, dynamic> toSQLite() {
    // TODO: implement toSQLite
    throw UnimplementedError();
  }
}

abstract class _UpdatePost implements UpdatePost {
  const factory _UpdatePost(
      {final String? text,
      final String? imageUrl,
      final DateTime? date}) = _$UpdatePostImpl;

  factory _UpdatePost.fromJson(Map<String, dynamic> json) =
      _$UpdatePostImpl.fromJson;

  @override
  String? get text;
  @override
  String? get imageUrl;
  @override
  DateTime? get date;

  /// Create a copy of UpdatePost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePostImplCopyWith<_$UpdatePostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
