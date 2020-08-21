import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_object_failure.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({@required String failValue}) =
      _InvalidEmail<T>;
  const factory ValueFailure.unSecurePassword({@required String failValue}) =
      _UnSecurePassword<T>;
  const factory ValueFailure.multiLine({@required String failValue}) =
      _MultiLine<T>;
}
