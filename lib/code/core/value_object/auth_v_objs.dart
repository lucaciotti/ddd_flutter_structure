import 'package:dartz/dartz.dart';
import 'package:ddd_flutter_structure/code/core/failure/value_object_failure.dart';
import 'package:ddd_flutter_structure/code/core/value_object/validator/string_validator.dart';
import 'package:ddd_flutter_structure/code/core/value_object/value_object_abstract.dart';

class EmailAddress extends ValueObject {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}
