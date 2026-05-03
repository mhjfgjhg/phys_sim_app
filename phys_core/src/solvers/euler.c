#include "../../include/phys_types.h"

// Функция реализации метода Эйлера
void euler_step(
    double *state, // Текущее состояние системы
    int size, // Размер состояния
    const void *params,  // Параметры системы
    double dt, // Шаг по времени
    PhysicsModel model // Функция, вычисляющая производные
){
    double deriv[size]; // Массив для хранения производных
    model(state, params, deriv);
    for (int i = 0; i < size; i++) {
        state[i] += deriv[i] * dt;
    }
}