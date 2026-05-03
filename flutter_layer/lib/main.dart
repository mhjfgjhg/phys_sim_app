import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/logic/pendulum_notifier.dart';
import 'src/ui/pendulum_painter.dart';

void main() {
  runApp(
    // Оборачиваем приложение в ProviderScope для работы Riverpod
    const ProviderScope(child: PhysicsApp()),
  );
}

class PhysicsApp extends StatelessWidget {
  const PhysicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const SimulationScreen(),
    );
  }
}

class SimulationScreen extends ConsumerStatefulWidget {
  const SimulationScreen({super.key});

  @override
  ConsumerState<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends ConsumerState<SimulationScreen>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Duration _lastTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    // Создаем цикл обновления привязанный к FPS монитора
    _ticker = createTicker((elapsed) {
      if (_lastTime == Duration.zero) {
        _lastTime = elapsed;
        return;
      }

      // Вычисляем реальный dt (обычно около 0.016 сек для 60 FPS)
      final dt = (elapsed - _lastTime).inMicroseconds / 1000000.0;
      _lastTime = elapsed;

      // Делаем шаг симуляции (можно сделать фиксированный dt для точности математики)
      ref.read(pendulumProvider.notifier).tick(0.016);
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pendulumProvider);
    final params = ref.watch(paramsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Физика: Маятник')),
      body: Column(
        children: [
          // Зона симуляции
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black87,
              child: CustomPaint(
                painter: PendulumPainter(
                  theta: state.theta,
                  lengthMeters: params.L,
                ),
              ),
            ),
          ),

          // Панель управления
          Container(
            padding: const EdgeInsets.all(24),
            color: Colors.grey[900],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Затухание среды (b): ${params.b.toStringAsFixed(2)}'),
                Slider(
                  value: params.b,
                  min: 0.0,
                  max: 2.0,
                  onChanged: (val) {
                    ref.read(paramsProvider.notifier).state = params.copyWith(
                      b: val,
                    );
                  },
                ),
                Text('Длина нити (L): ${params.L.toStringAsFixed(2)} м'),
                Slider(
                  value: params.L,
                  min: 0.5,
                  max: 4.0,
                  onChanged: (val) {
                    ref.read(paramsProvider.notifier).state = params.copyWith(
                      L: val,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
