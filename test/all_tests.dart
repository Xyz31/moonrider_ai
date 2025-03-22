import 'package:flutter_test/flutter_test.dart';
// Import all test files here
import 'core/error/failures_test.dart' as failures_test;
import 'data/models/coin_balance_model_test.dart' as coin_balance_model_test;
import 'data/models/transaction_model_test.dart' as transaction_model_test;
import 'data/repositories/reward_repository_impl_test.dart' as reward_repository_impl_test;
import 'domain/entities/coin_balance_test.dart' as coin_balance_test;
import 'domain/entities/transaction_test.dart' as transaction_test;
import 'domain/usecases/get_balance_test.dart' as get_balance_test;
import 'domain/usecases/scratch_card_usecase_test.dart' as scratch_card_usecase_test;
void main() {
  // This file can be used to run all tests at once
  group('All Tests', () {
    failures_test.main();
    coin_balance_model_test.main();
    transaction_model_test.main();
    reward_repository_impl_test.main();
    coin_balance_test.main();
    transaction_test.main();
    get_balance_test.main();
    scratch_card_usecase_test.main();
  });
}
