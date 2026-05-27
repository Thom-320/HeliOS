# 👀 QUÉ ESPERAR - Debug de Input

## 🎯 TEST 1 ACTIVO (AHORA)

### Compilado
```bash
make clean && make -j
```
✅ Ya está compilado

### Ejecutar
```bash
make run
```

---

## 📺 Salida Esperada

### Pantalla Inicial

```
OpenSBI v1.5.1
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

[... Platform info ...]

=== HeliOS UART Test ===
Test 1: Echo simple
Type characters (Ctrl+C to exit):

```

**El cursor debería estar parpadeando aquí** ←

---

## ⌨️ Ahora: Presiona Teclas

### Escenario A: FUNCIONA ✅

**TÚ PRESIONAS:** `h`

**PANTALLA MUESTRA:**
```
[got 0x68='h'] h
```

**TÚ PRESIONAS:** `e` `l` `p`

**PANTALLA MUESTRA:**
```
[got 0x68='h'] h[got 0x65='e'] e[got 0x6c='l'] l[got 0x70='p'] p
```

**Resultado:** ✅ UART FUNCIONA
**Siguiente paso:** TEST 2 (shell simple)

---

### Escenario B: NO FUNCIONA ❌

**TÚ PRESIONAS:** `h` `e` `l` `p`

**PANTALLA MUESTRA:**
```
[nada - cursor sigue parpadeando]
```

**Resultado:** ❌ UART NO recibe datos
**Posibles causas:**
1. QEMU no está enviando datos al UART
2. UART_BASE incorrecto
3. LSR.DR nunca se activa

**Debug adicional:**
```bash
# Verifica UART_BASE en device tree
make dtb
cat virt.dts | grep uart
```

---

### Escenario C: PARCIAL ⚠️

**TÚ PRESIONAS:** `h`

**PANTALLA MUESTRA:**
```
h
```

**Pero NO muestra:** `[got 0x68='h']`

**Resultado:** ⚠️ uart_putc funciona pero uart_getc tiene problema
**Causa:** Loop en uart_getc nunca encuentra LSR.DR = 1

---

## 🔬 Información de Diagnóstico

### Para Cada Escenario

**Dime EXACTAMENTE qué ves:**

1. ¿Ves la pantalla de OpenSBI? (Sí/No)
2. ¿Ves "=== HeliOS UART Test ==="? (Sí/No)
3. ¿Ves "Type characters (Ctrl+C to exit):"? (Sí/No)
4. Cuando presionas `h`:
   - [ ] No pasa nada
   - [ ] Aparece `h` solamente
   - [ ] Aparece `[got 0x68='h'] h`
   - [ ] Otro: _______________

5. Si presionas más teclas (`elp`), ¿pasa algo? (Sí/No/Qué)

---

## 🎯 EJECUTA ESTO AHORA

```bash
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"

# Ya está compilado, solo ejecuta:
make run

# Cuando veas "Type characters", presiona: h e l p
# Reporta EXACTAMENTE qué ves
```

---

## 📊 Tabla de Diagnóstico

| Qué Ves | Problema | Siguiente Paso |
|---------|----------|----------------|
| `[got 0x68='h'] h` | ✅ UART OK | TEST 2 |
| Solo `h` | uart_getc falla | Revisar LSR.DR |
| Nada | QEMU no envía datos | Verificar -serial stdio |
| Sistema se cuelga | Loop infinito | Revisar uart_getc_blocking |

---

## 🚀 Siguiente Paso Según Resultado

### Si TEST 1 Funciona (ves `[got ...]`)
```bash
cp kernel/kmain_test2.c kernel/kmain.c
make clean && make -j
make run
# Probar shell simple sin timer
```

### Si TEST 1 NO Funciona
Necesitamos:
1. Ver código exacto de uart_getc
2. Ver registros UART con GDB
3. Verificar device tree

---

**POR FAVOR, ejecuta `make run` AHORA y reporta qué ves cuando presionas `h`**

Responde con uno de estos:
- A) Veo `[got 0x68='h'] h` ✅
- B) Solo veo `h`
- C) No veo nada
- D) Otro: [describe]

**Esperando tu reporte...** 🔍

