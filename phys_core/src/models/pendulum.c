#include "../../include/phys_types.h"
#include <math.h>

// Функция, вычисляющая производные для физической модели маятника
void pendulum_model(const double *state, const void *params, double *deriv) {
    double theta = state[0];
    double omega = state[1];
    const PendulumParams *p = (const PendulumParams*)params; // Указатель на параметры

    // 1. Изменение угла — это угловая скорость
    deriv[0] = omega;
    
    // 2. Уравнение маятника с затуханием:
    // omega' = -g/L * sin(theta) - b/m * omega
    deriv[1] = -(p->g / p->L) * sin(theta) - (p->b / p->m) * omega;
}