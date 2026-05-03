#ifndef PHYS_FFI_H
#define PHYS_FFI_H

// Явное определение структур для FFI
typedef struct {
    double theta;    // Угол отклонения (рад)
    double omega;    // Угловая скорость (рад/с)
} PendulumState;

typedef struct {
    double L;        // Длина нити (м)
    double m;        // Масса грузика (кг)
    double g;        // Ускорение свободного падения (м/с^2)
    double b;        // Коэффициент затухания (вязкость среды)
} PendulumParams;

// Функция для FFI
void step_pendulum(PendulumState *current, PendulumParams *p, double dt);

#endif // PHYS_FFI_H
