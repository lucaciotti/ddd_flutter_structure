import 'package:ddd_flutter_structure/code/core/failure/value_object_failure.dart';

/// When a Failure can't be handleled no more
/// App Throws [UnexpectedValueError] containing the [ValueFailure]
class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;
  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}
