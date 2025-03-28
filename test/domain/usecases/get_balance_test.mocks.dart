// Mocks generated by Mockito 5.4.4 from annotations
// in moonrider_task/test/domain/usecases/get_balance_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:moonrider_task/core/error/failures.dart' as _i5;
import 'package:moonrider_task/domain/entities/coin_balance.dart' as _i6;
import 'package:moonrider_task/domain/entities/transaction.dart' as _i7;
import 'package:moonrider_task/domain/repositories/reward_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RewardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRewardRepository extends _i1.Mock implements _i3.RewardRepository {
  MockRewardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CoinBalance>> getCurrentBalance() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentBalance,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.CoinBalance>>.value(
            _FakeEither_0<_i5.Failure, _i6.CoinBalance>(
          this,
          Invocation.method(
            #getCurrentBalance,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.CoinBalance>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> updateBalance(int? amount) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateBalance,
          [amount],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #updateBalance,
            [amount],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> addTransaction(
          _i7.Transaction? transaction) =>
      (super.noSuchMethod(
        Invocation.method(
          #addTransaction,
          [transaction],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #addTransaction,
            [transaction],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.Transaction>>>
      getTransactionHistory() => (super.noSuchMethod(
            Invocation.method(
              #getTransactionHistory,
              [],
            ),
            returnValue: _i4
                .Future<_i2.Either<_i5.Failure, List<_i7.Transaction>>>.value(
                _FakeEither_0<_i5.Failure, List<_i7.Transaction>>(
              this,
              Invocation.method(
                #getTransactionHistory,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, List<_i7.Transaction>>>);
}
