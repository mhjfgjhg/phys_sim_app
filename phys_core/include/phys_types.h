#ifndef PHYS_TYPES_H
#define PHYS_TYPES_H

// Состояние системы (то, что меняется)
typedef struct {
    double theta;    // Угол отклонения (рад)
    double omega;    // Угловая скорость (рад/с)
} PendulumState; // новый тип для конукретной модели

// Параметры системы (то, что настраивает пользователь)
typedef struct {
    double L;        // Длина нити (м)
    double m;        // Масса грузика (кг)
    double g;        // Ускорение свободного падения (м/с^2)
    double b;        // Коэффициент затухания (вязкость среды)
} PendulumParams;

// Функция, вычисляющая производные для физической модели
typedef void (*PhysicsModel)( // Тип указателя на функцию, вычисляющую производные
    const double *state, // Текущее состояние системы
    const void *params,  // Параметры системы
    double *deriv       // Производные
);

#endif