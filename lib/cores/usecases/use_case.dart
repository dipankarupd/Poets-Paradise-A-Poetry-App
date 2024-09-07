import 'package:fpdart/fpdart.dart';
import 'package:poets_paradise/cores/utils/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
