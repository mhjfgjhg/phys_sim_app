class DartPendulumState {
  final double theta;
  final double omega;

  const DartPendulumState({required this.theta, required this.omega});
}

class DartPendulumParams {
  final double L; // Длина (в метрах)
  final double m; // Масса
  final double g; // Гравитация
  final double b; // Затухание

  const DartPendulumParams({
    this.L = 2.0,
    this.m = 1.0,
    this.g = 9.81,
    this.b = 0.5,
  });

  DartPendulumParams copyWith({double? L, double? m, double? g, double? b}) {
    return DartPendulumParams(
      L: L ?? this.L,
      m: m ?? this.m,
      g: g ?? this.g,
      b: b ?? this.b,
    );
  }
}
