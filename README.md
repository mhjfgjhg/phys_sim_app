Описание проекта в целом
Архитектурная диаграмма (высокоуровневая)
Стек технологий
Как собрать и запустить
Ссылки на документацию компонентов

# PHYSICAL SIMULATIOM APP
Это приложение - сборник физических моделей, их симуляции и аналитические решения.
Решил делать на Flutter из-за мальтиплатформенности и на C из-за простоты легкости и простоты интеграции в Flutter.

```mermaid
graph TB
    UI["📱 Flutter UI<br/>Material App"]
    STATE["🔄 State Management<br/>Riverpod Providers"]
    FFI["🔗 FFI Bridge<br/>Native Binding"]
    ENGINE["⚙️ Physics Engine<br/>C Library"]
    SOLVERS["📊 Numerical Solvers<br/>Euler, RK4"]
    
    UI -->|user input| STATE
    STATE -->|step_pendulum| FFI
    FFI -->|dlopen| ENGINE
    ENGINE -->|solve| SOLVERS
    SOLVERS -->|θ, ω| ENGINE
    ENGINE -->|return state| FFI
    FFI -->|DartType| STATE
    STATE -->|notify| UI
    
    style UI fill:#4a90e2
    style STATE fill:#7b68ee
    style FFI fill:#ff6b6b
    style ENGINE fill:#f5a623
    style SOLVERS fill:#50e3c2
```