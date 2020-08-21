import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_structure/code/core/failure/value_object_failure.dart';
import 'package:ddd_flutter_structure/code/core/value_object/validator/string_validator.dart';
import 'package:ddd_flutter_structure/code/core/value_object/value_object_abstract.dart';

class StringSingleLine extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  factory StringSingleLine(String input) {
    assert(input != null);
    return StringSingleLine._(validateSingleLine(input));
  }
  const StringSingleLine._(this.value);
}
