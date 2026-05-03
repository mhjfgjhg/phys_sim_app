#include "../include/phys_engine.h"

// Декларируем внутренние функции, чтобы компилятор не ругался::

extern void euler_step(double*, int, const void*, double, PhysicsModel);
extern void pendulum_model(const double*, const void*, double*);

// Функция шага симуляции для маятника
void step_pendulum(PendulumState *current, PendulumParams *p, double dt) {
    // 1. Упаковываем состояние в сырой массив
    double state_arr[2] = { current->theta, current->omega };
    
    // 2. Отдаем в универсальный решатель
    euler_step(state_arr, 2, p, dt, pendulum_model);
    
    // 3. Обновляем состояние на месте
    current->theta = state_arr[0];
    current->omega = state_arr[1];
}