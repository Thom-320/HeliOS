# 🖥️ INSTRUCCIONES - Problema de Terminal

## 🎯 Lo Que Dice Codex

**Codex reporta que el sistema FUNCIONA para él:**
```
HeliOS> uptime
Uptime: 0.0 seconds (0 ticks)
HeliOS> sleep 20
Sleeping for 20 ticks...
Done sleeping
HeliOS> uptime
Uptime: 0.20 seconds (20 ticks)
```

**Pero para ti no funciona.** Esto sugiere un problema de **configuración de terminal**, no del código.

---

## 🔧 SOLUCIONES A PROBAR

### Solución 1: Terminal Nueva y Limpia

1. **Cierra** la terminal actual completamente
2. **Abre** una terminal completamente nueva
3. Ejecuta:

```bash
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"
./test_directo.sh
```

4. Cuando veas `HeliOS>`:
   - **Haz clic** en la ventana para darle foco
   - **Escribe** `help` muy despacio
   - **Presiona** Enter

---

### Solución 2: Resetear Terminal

```bash
reset
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"
./scripts/run-qemu.sh
```

---

### Solución 3: Stty Raw

Antes de ejecutar, configura el terminal:

```bash
stty raw -echo
./scripts/run-qemu.sh
# Para salir: Ctrl+A luego X
# Luego: stty sane
```

---

### Solución 4: Probar en iTerm2 o Terminal Diferente

Si usas macOS Terminal, prueba con:
- iTerm2
- Alacritty
- Kitty

---

## 🎯 DIAGNÓSTICO

### Si Codex Ve Esto

Funcionando:
```
HeliOS> help
Available commands:
...
HeliOS> uptime
Uptime: 0.20 seconds
```

### Y Tú Ves Esto:

```
HeliOS> [no acepta teclas]
```

**Entonces el problema es:**
- ❌ NO es el código (Codex lo probó)
- ✅ ES la configuración de tu terminal

---

## 🔬 TEST DE TERMINAL

### Prueba Esto

En una terminal nueva:

```bash
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"

# Test 1: ¿QEMU funciona en general?
echo "test" | qemu-system-riscv64 -version

# Test 2: ¿La terminal recibe input?
cat > /tmp/test.txt
# Escribe algo y Ctrl+D
cat /tmp/test.txt

# Test 3: ¿QEMU con -serial stdio?
echo "help" | timeout 5 ./scripts/run-qemu.sh
```

---

## 💡 POSIBLES CAUSAS

### 1. Terminal en Modo Bloqueado
Algún proceso anterior dejó el terminal en modo raw o bloqueado.

**Fix:** `reset` o abrir terminal nueva

### 2. QEMU No Tiene Foco
QEMU está corriendo pero la ventana no tiene el foco del teclado.

**Fix:** Hacer clic en la ventana, presionar Enter

### 3. Multiplexor (tmux/screen)
Si estás en tmux o screen, puede haber conflicto con prefijos de comando.

**Fix:** Sal de tmux/screen, usa terminal directa

### 4. Teclado en Otro Layout
Si tu teclado está en español/latino, puede haber mapeo incorrecto.

**Fix:** Cambiar a teclado US temporalmente

---

## 🎯 ACCIÓN INMEDIATA

### PASO 1: Terminal Completamente Nueva

1. Cierra TODO (QEMU, terminales, todo)
2. Abre Terminal.app nueva
3. Ejecuta:

```bash
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"
make
./scripts/run-qemu.sh
```

4. **Cuando veas `HeliOS>`:**
   - Haz clic en la ventana
   - Presiona `h` `e` `l` `p` `Enter` MUY DESPACIO
   - Observa si ves ALGO

### PASO 2: Si Sigue Sin Funcionar

Ejecuta esto y pégame la salida:

```bash
stty -a
echo $TERM
locale
```

---

## 📝 REPORTE PARA CODEX

Si después de probar con terminal nueva sigue sin funcionar, pega esta info:

1. **OS:** macOS versión
2. **Terminal:** Terminal.app / iTerm2 / otro
3. **stty -a:** [salida completa]
4. **$TERM:** [valor]
5. **¿Funciona con `cat`?:** [sí/no]
6. **¿Ves eco cuando escribes en TEST 1?:** [sí/no]

---

## 🚀 PRÓXIMO PASO

**AHORA:** Abre una terminal completamente nueva y ejecuta `./test_directo.sh`

**Reporta:** ¿Funciona? ¿Qué ves exactamente?

El código está correcto (Codex lo verificó). El problema parece estar en cómo tu terminal interactúa con QEMU.

**No te rindas - estamos muy cerca!** 💪

