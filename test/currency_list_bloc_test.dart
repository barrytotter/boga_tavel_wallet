import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:travel_wallet/features/currency_list/bloc/currency_list_bloc.dart';
import 'package:travel_wallet/repositories/travel_wallet/travel_wallet.dart';
import 'dart:async';

class MockCurrencyRepository extends Mock
    implements AbstractCurrencyRepository {}

void main() {
  late MockCurrencyRepository mockRepository;
  late CurrencyListBloc currencyListBloc;

  final mockWallets = [
    const TravelWallet(
      name: 'Китайский юань',
      abbreviation: 'CNY',
      officialRate: 0.45,
    ),
    const TravelWallet(
      name: 'Казахстанский тенге',
      abbreviation: 'KZT',
      officialRate: 0.007,
    ),
  ];

  setUp(() {
    mockRepository = MockCurrencyRepository();
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<Talker>()) {
      getIt.registerSingleton<Talker>(Talker());
    }
    currencyListBloc = CurrencyListBloc(mockRepository);
  });

  tearDown(() {
    currencyListBloc.close();
  });

  group('CurrencyListBloc Tests', () {
    // --- ТЕСТ 1: Проверка базового состояния
    test('1. Начальное состояние Блока должно быть CurrencyListInitial', () {
      expect(currencyListBloc.state, isA<CurrencyListInitial>());
    });

    // --- ТЕСТ 2: Успешная загрузка данных
    blocTest<CurrencyListBloc, CurrencyListState>(
      '2. Должен эмитить [Loading, Loaded] при успешной загрузке из репозитория',
      build: () {
        when(
          () => mockRepository.getCurrencyRate(),
        ).thenAnswer((_) async => mockWallets);
        return currencyListBloc;
      },
      act: (bloc) => bloc.add(LoadCurrencyList()),
      expect: () => [
        isA<CurrencyListLoading>(),
        isA<CurrencyListLoaded>().having(
          (state) => state.currencyRates,
          'currencyRates',
          mockWallets,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.getCurrencyRate()).called(1);
      },
    );

    // --- ТЕСТ 3: Обработка ошибок сети
    blocTest<CurrencyListBloc, CurrencyListState>(
      '3. Должен эмитить [Loading, Error] если репозиторий выбросил исключение',
      build: () {
        // Имитируем падение интернета (DioException или Exception)
        when(
          () => mockRepository.getCurrencyRate(),
        ).thenThrow(Exception('No Internet'));
        return currencyListBloc;
      },
      act: (bloc) => bloc.add(LoadCurrencyList()),
      expect: () => [isA<CurrencyListLoading>(), isA<CurrencyListError>()],
    );

    // --- ТЕСТ 4: Проверка работы Completer
    test(
      '4. Должен завершать Completer после того, как данные загружены',
      () async {
        final completer = Completer<void>();

        when(
          () => mockRepository.getCurrencyRate(),
        ).thenAnswer((_) async => mockWallets);

        currencyListBloc.add(LoadCurrencyList(completer));

        await expectLater(completer.future, completes);
      },
    );

    // --- ТЕСТ 5: Проверка Equatable
    test(
      '5. Два состояния Loaded с одинаковыми данными должны быть равны друг другу',
      () {
        final stateA = CurrencyListLoaded(mockWallets);
        final stateB = CurrencyListLoaded(mockWallets);

        expect(stateA, equals(stateB));
      },
    );
  });
}
