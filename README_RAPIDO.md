# uROS - Guía Rápida 🚀

## ¿Qué es uROS?

uROS es un mini sistema operativo para RISC-V 64 que corre en QEMU con:
- ✅ Shell interactiva
- ✅ Scheduler Round-Robin cooperativo/preemptivo
- ✅ Scheduler SJF
- ✅ Sistema de tareas/threads
- ✅ Timer, traps e interrupciones
- ✅ Semáforos, mutexes y demo productor-consumidor
- ✅ Free-list allocator
- ✅ Comandos de gestión

## Inicio Rápido (3 pasos)

### 1️⃣ Compilar
```bash
make clean && make -j
```

### 2️⃣ Ejecutar
```bash
make run
```

### 3️⃣ Probar Comandos
En el prompt `uROS>`, escribe:
```
help
ps
run cpu
run io
ps
sched rr
sched preempt on
uptime
meminfo
intstats
```

**Para salir**: Presiona `Ctrl+C`

## Demostración Automática

```bash
./scripts/demo.sh
```

## Comandos Disponibles

| Comando | Descripción |
|---------|-------------|
| `help` | Muestra ayuda |
| `ps` | Lista tareas/procesos |
| `run cpu` | Crea tarea CPU-bound |
| `run io` | Crea tarea I/O-bound |
| `kill <pid>` | Termina una tarea |
| `sched rr` | Cambia a Round-Robin |
| `sched sjf` | Cambia a SJF |
| `sched preempt on|off` | Activa/desactiva preemption por timer |
| `sleep <ticks>` | Espera N ticks |
| `pcdemo` | Demo productor-consumidor |
| `bench` | Ejecuta benchmark |
| `uptime` | Tiempo de ejecución |
| `meminfo` | Uso de memoria |
| `intstats` | Estado de interrupciones/timer |

## Verificación

Para verificar que todo funciona:
```bash
# Smoke test automatizado
make smoke
```

## Estado del Proyecto

✅ **FUNCIONAL** - Listo para demostración

**Características implementadas:**
- UART (consola)
- Printf
- Shell interactiva
- Tareas/threads
- Scheduler Round-Robin cooperativo/preemptivo
- Scheduler SJF
- Timer SBI a 100 Hz
- Semáforos y mutexes
- Free-list allocator
- Todos los comandos básicos y demos

**Limitaciones actuales:**
- Sin MMU/paging
- Sin sistema de archivos
- Todo corre en S-mode/kernel mode

## Archivos Importantes

- `kernel/kmain.c` - Punto de entrada
- `kernel/shell.c` - Shell interactiva
- `kernel/sched.c` - Scheduler
- `kernel/task.c` - Sistema de tareas
- `drivers/uart.c` - Driver de consola
- `scripts/run-qemu.sh` - Lanzador QEMU

## Debugging

Para ejecutar con GDB:
```bash
make run-gdb    # En una terminal
make gdb        # En otra terminal
```

## Soporte

Ver documentación completa en:
- `VERIFICATION.md` - Verificación detallada
- `RESUMEN_VERIFICACION.md` - Resumen completo
- `docs/README.md` - Documentación técnica

---

**¡Listo para usar!** 🎉
