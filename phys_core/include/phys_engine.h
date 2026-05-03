#include "phys_types.h"

__attribute__((visibility("default"))) // Экспортируем функцию
__attribute__ ((used)) // Указываем, что функция должна быть включена в бинарный файл
void step_pendulum(PendulumState *current, PendulumParams *p, double dt); // Шаг симуляции для маятника