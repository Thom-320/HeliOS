# 🔍 INSTRUCCIONES DE VERIFICACIÓN INMEDIATA

## ⚡ HAZLO AHORA (5 minutos)

### Paso 1: Abrir Terminal

Abre una nueva ventana de terminal.

### Paso 2: Ir al Directorio

```bash
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"
```

### Paso 3: Compilar

```bash
make clean && make -j
```

**Esperado:** Compilación exitosa sin errores

### Paso 4: Ejecutar

```bash
make run
```

**Esperado:** Verás el banner de OpenSBI y luego:
```
HeliOS (rv64gc, QEMU virt) - console ready
ticks=0
Initializing task system...
Initializing scheduler...
Creating idle task...
Initializing timer...
Initializing trap handling...
System initialized, starting shell...
HeliOS>
```

### Paso 5: AHORA - Con TU Teclado

**IMPORTANTE:** No uses scripts. Escribe directamente con el teclado.

#### Test 1: help
Escribe: `h` `e` `l` `p` y presiona `Enter`

**¿Ves la lista de comandos?**
- ✅ SÍ → Continúa con Test 2
- ❌ NO → Ve a "Solución Alternativa" abajo

#### Test 2: uptime  
Escribe: `u` `p` `t` `i` `m` `e` y presiona `Enter`

**¿Ves algo como "Uptime: X.XX seconds"?**
- ✅ SÍ → El timer funciona!
- ❌ NO → Anota lo que ves

#### Test 3: uptime de nuevo (después de esperar)
Espera 3 segundos.
Escribe: `uptime` y presiona `Enter`

**¿Los ticks aumentaron?**
- ✅ SÍ → Timer funcionando correctamente!
- ❌ NO → Timer no está incrementando

#### Test 4: ps
Escribe: `ps` y presiona `Enter`

**¿Ves la tabla de tareas?**
- ✅ SÍ → Sistema de tareas funciona
- ❌ NO → Anota el error

#### Test 5: pcdemo
Escribe: `pcdemo` y presiona `Enter`

**¿Ves alternancia Producer/Consumer?**
- ✅ SÍ → ¡SINCRONIZACIÓN FUNCIONA! 🎉
- ❌ NO → Anota lo que pasa

---

## 🔧 Solución Alternativa (Si No Acepta Entrada)

Si el sistema muestra el prompt pero no acepta entrada con el teclado:

### Opción A: Deshabilitar Preemption por Defecto

1. Edita `include/config.h`:
```c
#define CONFIG_PREEMPT 0  // ← Cambiar a 0
```

2. Recompila y ejecuta:
```bash
make clean && make -j
make run
```

3. Prueba escribir de nuevo

### Opción B: Verificar con Modo GDB

```bash
# Terminal 1:
make run-gdb

# Terminal 2:
make gdb
(gdb) break uart_gets
(gdb) continue
# Luego en Terminal 1, escribe algo
```

---

## 📊 Qué Reportar

Por favor, dame esta información:

### Cuando ejecutas `make run`:

1. **¿Ves el prompt `HeliOS>`?**
   - [ ] Sí
   - [ ] No

2. **¿Puedes escribir con el teclado?**
   - [ ] Sí, veo eco de caracteres
   - [ ] No, no pasa nada
   - [ ] Veo caracteres pero comando no ejecuta

3. **Si escribes `help` y Enter, ¿qué pasa?**
   - [ ] Muestra lista de comandos ✅
   - [ ] No pasa nada
   - [ ] Error
   - [ ] Otro: __________

4. **Si escribes `uptime`, ¿qué muestra?**
   - [ ] Uptime: X.XX seconds (X ticks)
   - [ ] Uptime: 0.0 seconds (0 ticks)
   - [ ] No responde
   - [ ] Error

5. **Después de esperar 3 segundos y escribir `uptime` de nuevo:**
   - [ ] Los ticks aumentaron ✅
   - [ ] Siguen en 0
   - [ ] No funciona

---

## 🎯 Escenarios y Soluciones

### Escenario A: Todo Funciona
```
✅ Prompt visible
✅ Acepta entrada
✅ help funciona
✅ uptime muestra ticks
✅ Ticks aumentan
```
→ **¡PERFECTO! Procede con pcdemo**

### Escenario B: Prompt visible pero no acepta entrada
```
✅ Prompt visible
❌ No acepta entrada del teclado
```
→ **Solución:** Cambia `CONFIG_PREEMPT 0` y recompila

### Escenario C: uptime da 0 siempre
```
✅ Acepta comandos
❌ uptime siempre 0
```
→ **Causa:** Timer no incrementa
→ **Debug:** Verificar trap_init() se llamó

### Escenario D: Sistema se cuelga
```
❌ No llega a HeliOS>
```
→ **Causa:** Problema en init
→ **Solución:** Verificar orden de init en kmain.c

---

## 🚀 Próximo Paso

**AHORA:** Ejecuta `make run` y prueba con tu teclado.

**LUEGO:** Reporta qué funciona y qué no.

**DESPUÉS:** Implementaremos `kfree` y gestión de memoria mejorada.

---

## 📝 Formato de Reporte

```
Ejecuté: make run

1. Prompt visible: [SÍ/NO]
2. Acepta entrada: [SÍ/NO]
3. help funciona: [SÍ/NO]
4. uptime muestra ticks: [SÍ/NO]
5. Ticks aumentan: [SÍ/NO]
6. pcdemo funciona: [SÍ/NO]

Comentarios adicionales:
[Tu experiencia]
```

---

**Por favor, ejecuta esto AHORA y reporta los resultados.** 🎯

