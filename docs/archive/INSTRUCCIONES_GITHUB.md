# 📦 Instrucciones para Subir a GitHub

> **NOTA:** Solo ejecuta esto cuando estés listo para subir el proyecto

---

## 🎯 Paso 1: Preparar el Repositorio Local

```bash
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"

# 1. Inicializar git
git init
git branch -M main

# 2. Verificar .gitignore (ya está creado)
cat .gitignore

# 3. Asegurar permisos de ejecución en scripts
chmod +x scripts/*.sh

# 4. Agregar todos los archivos
git add .

# 5. Primer commit
git commit -m "HeliOS: Mini OS educativo RISC-V 64

- Boot con OpenSBI en QEMU virt
- Shell interactiva con 10+ comandos
- Sistema de tareas con context switching
- Scheduler Round-Robin cooperativo
- Driver UART NS16550A
- Gestión de memoria con free-list allocator
- Printf implementado
- Demo automática lista

Ready for demo and evaluation."
```

---

## 🌐 Paso 2: Crear Repositorio en GitHub

### Opción A: GitHub CLI (Recomendado)

```bash
# 1. Autenticar (si no lo has hecho)
gh auth login

# 2. Crear repo público y push
gh repo create helios-riscv64 --public --source=. --remote=origin --push
```

### Opción B: Manualmente en GitHub.com

1. Ve a https://github.com/new
2. Repository name: `helios-riscv64`
3. Description: `Mini OS educativo para RISC-V 64 con shell, multitasking y scheduler RR`
4. Public
5. NO agregues README, .gitignore, o license (ya los tienes)
6. Click "Create repository"

Luego en la terminal:
```bash
git remote add origin https://github.com/TU_USUARIO/helios-riscv64.git
git push -u origin main
```

---

## 👤 Paso 3: Verificar Autoría

### Opción A: En la Web

1. Ve a tu repo en GitHub
2. Settings → Collaborators
3. Confirma que solo `Thom-320` tenga permisos de administración/escritura

### Opción B: Con GitHub CLI

```bash
# Reemplaza con los usuarios reales
gh repo collab add simonUsername --permission push
gh repo collab add mariapaulaUsername --permission push
```

---

## 🔒 Paso 4: Proteger la Rama Main

1. Ve a tu repo → Settings → Branches
2. Click "Add branch protection rule"
3. Branch name pattern: `main`
4. Configuración recomendada:
   - ✅ Require a pull request before merging
   - ✅ Require approvals: 1
   - ✅ Require status checks to pass before merging
5. Save changes

---

## 🌿 Paso 5: Estrategia de Ramas

### Ramas por Persona

```bash
# Rama principal de trabajo
git checkout -b thomas/scheduler-bench
```

### Workflow Recomendado

1. **Crear rama** para tu feature
   ```bash
   git checkout -b nombre/descripcion
   ```

2. **Hacer cambios y commits**
   ```bash
   git add .
   git commit -m "Descripción clara"
   ```

3. **Push a GitHub**
   ```bash
   git push origin nombre/descripcion
   ```

4. **Crear Pull Request** en GitHub
   - Describe los cambios
   - Asigna reviewer (otro miembro del equipo)

5. **Review y Merge**
   - El reviewer aprueba
   - Merge a `main`

---

## 🏷️ Paso 6: Crear Release (Opcional)

Cuando el proyecto esté completamente terminado:

```bash
# 1. Crear tag
git tag -a v1.0.0 -m "Release inicial: Demo completo RR + Shell + UART"

# 2. Push tag
git push origin v1.0.0

# 3. Crear release en GitHub
gh release create v1.0.0 \
  --title "HeliOS v1.0.0 - Demo Ready" \
  --notes "Primera versión completa con:
- Shell interactiva funcional
- Sistema de tareas con context switching
- Scheduler Round-Robin cooperativo
- 10+ comandos implementados
- Demo automática
- Documentación completa

Ready for demonstration and evaluation."
```

---

## ✅ Paso 7: Verificar CI (GitHub Actions)

El archivo `.github/workflows/build.yml` ya está creado. Una vez que hagas push:

1. Ve a tu repo → Actions
2. Deberías ver el workflow "build" ejecutándose
3. Verifica que compile correctamente

Si falla:
- Revisa los logs en Actions
- Asegúrate de que todos los archivos están en el repo

---

## 📋 Issues Sugeridos para el Equipo

Crea estos issues en GitHub para organizar el trabajo:

### Issue 1: [infra] Agregar target `demo-fast`
```
Crear target en Makefile que ejecute la demo automáticamente sin timeout.

Comando: `make demo-fast`

Responsable: Thomas
```

### Issue 2: [doc] Screenshot/gif de la shell
```
Agregar captura de pantalla o GIF mostrando:
- help
- ps
- run cpu
- run io
- meminfo

Incluir en README.md

Responsable: Thomas
```

### Issue 3: [kernel] Documentar plan B cooperativo
```
Describir en docs/ cómo funciona el scheduling cooperativo:
- need_resched flag
- sched_maybe_yield_safe()
- Puntos de yield seghelios

Responsable: Thomas
```

### Issue 4: [sched] Validar métricas de bench
```
Verificar fórmulas de:
- Wait time
- Turnaround time
- Throughput

Formatear tabla alineada.

Responsable: Thomas
```

### Issue 5: [debug] Guía completa de GDB
```
Documentar en docs/README.md:
- make run-gdb
- Comandos GDB útiles
- Breakpoints comunes
- Ejemplos de debugging

Responsable: Thomas
```

### Issue 6: [feature] Comando uptime mejorado
```
Agregar `uptime -v` que muestre:
- Tick rate (Hz)
- Quantum actual
- Modo scheduler actual
- Número de context switches

Responsable: Thomas
```

---

## 🎓 Instrucciones para Tu Equipo

Una vez que el repo esté en GitHub, comparte esto con tu equipo:

```markdown
# Cómo trabajar en HeliOS

## Setup inicial
```bash
git clone https://github.com/TU_USUARIO/helios-riscv64.git
cd helios-riscv64
make clean && make -j
make run
```

## Workflow
1. Crea tu rama: `git checkout -b tunombre/descripcion`
2. Haz cambios
3. Commit: `git commit -am "Descripción"`
4. Push: `git push origin tunombre/descripcion`
5. Crea Pull Request en GitHub
6. Espera review y merge

## Reglas
- ✅ NUNCA hagas push directo a `main`
- ✅ SIEMPRE crea Pull Request
- ✅ Asigna reviewer (otro miembro)
- ✅ Espera aprobación antes de mergear
- ✅ Prueba que compile antes de push: `make clean && make`
```

---

## 📝 README.md en GitHub

El `README.md` principal ya está optimizado para GitHub con:
- ✅ Badges (RISC-V, QEMU, License)
- ✅ Secciones claras
- ✅ Ejemplos de código
- ✅ Enlaces a documentación
- ✅ Instrucciones de uso
- ✅ Lista de colaboradores

---

## 🎉 ¡Listo!

Cuando ejecutes estos pasos, tu proyecto estará:
- ✅ En GitHub con control de versiones
- ✅ Con CI/CD configurado
- ✅ Listo para colaboración
- ✅ Protegido con branch protection
- ✅ Con documentación completa

**No olvides:**
- Compartir el link del repo con tu equipo
- Crear los issues sugeridos
- Verificar que el CI pasa

---

## 🚀 Comando Completo (Copia y Pega)

```bash
cd "/Users/thom/Library/Mobile Documents/com~apple~CloudDocs/Universidad/OS/mini-os"

# Init y commit
git init
git branch -M main
git add .
git commit -m "HeliOS: Mini OS educativo RISC-V 64 - Initial commit"

# Crear repo y push (GitHub CLI)
gh repo create helios-riscv64 --public --source=. --remote=origin --push

# O manualmente:
# git remote add origin https://github.com/TU_USUARIO/helios-riscv64.git
# git push -u origin main

# Agregar colaboradores (reemplaza usernames)
# gh repo collab add simonUsername --permission push
# gh repo collab add mariapaulaUsername --permission push

# Crear tag y release
git tag -a v1.0.0 -m "Release inicial: Demo completo"
git push origin v1.0.0
gh release create v1.0.0 --generate-notes

echo "✅ ¡Repo creado exitosamente!"
```

---

**¡Cuando estés listo, ejecuta estos comandos y tendrás tu proyecto en GitHub!** 🎉
