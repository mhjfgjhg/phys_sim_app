import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../generated/phys_core_bindings.dart'; // Твой файл от ffigen
import 'pendulum_data.dart';

// 1. Загружаем библиотеку
final dylib = ffi.DynamicLibrary.open('libphys_core.so');
final bindings = PhysCoreBindings(dylib);

// 2. Провайдеры для Riverpod
final paramsProvider = StateProvider<DartPendulumParams>(
  (ref) => const DartPendulumParams(),
);

final pendulumProvider = NotifierProvider<PendulumNotifier, DartPendulumState>(
  () {
    return PendulumNotifier();
  },
);

// 3. Сам контроллер
class PendulumNotifier extends Notifier<DartPendulumState> {
  @override
  DartPendulumState build() {
    return const DartPendulumState(
      theta: 1.0,
      omega: 0.0,
    ); // Начальный угол ~57 градусов
  }

  void tick(double dt) {
    final params = ref.read(paramsProvider);

    // Выделяем память под C-структуры
    final pState = calloc<PendulumState>();
    final pParams = calloc<PendulumParams>();

    try {
      // Заполняем данные
      pState.ref.theta = state.theta;
      pState.ref.omega = state.omega;

      pParams.ref.L = params.L;
      pParams.ref.m = params.m;
      pParams.ref.g = params.g;
      pParams.ref.b = params.b;

      // ВЫЗЫВАЕМ C-ЯДРО
      bindings.step_pendulum(pState, pParams, dt);

      // Обновляем состояние во Flutter
      state = DartPendulumState(
        theta: pState.ref.theta,
        omega: pState.ref.omega,
      );
    } finally {
      // Обязательно освобождаем память, иначе будет утечка!
      calloc.free(pState);
      calloc.free(pParams);
    }
  }
}
