# HeliOS Architecture Notes

These notes are for readers who want to inspect the kernel rather than only run
the demo. HeliOS is intentionally compact, so the full runtime path can be read
in one sitting.

## What Is Real

- Bare-metal RISC-V 64 target on QEMU `virt`, booted through OpenSBI.
- Explicit linker layout with the kernel loaded at `0x80200000`.
- Supervisor-mode trap handling for timer interrupts.
- Low-level context switching in RISC-V assembly.
- Kernel task table with saved register state, stack ownership, and scheduling
  metadata.
- Round-Robin scheduling with optional timer preemption.
- Shortest Job First scheduling with burst estimates.
- Dynamic stack allocation through a first-fit free-list allocator.
- Semaphores, mutexes, and a producer-consumer synchronization demo.
- QEMU smoke test wired into GitHub Actions.

## What Is Simplified

- No MMU or virtual memory.
- No filesystem.
- No user/kernel privilege boundary.
- No ELF loader or process address spaces.
- No SMP.
- Semaphore waits are cooperative busy-waits rather than blocking wait queues.

Those limits are deliberate. The repository is meant to make the core control
flow inspectable without asking the reader to reverse-engineer a large kernel.

## Boot Path

1. QEMU starts the `virt` machine and OpenSBI transfers control to the kernel.
2. `linker.ld` places the kernel at `0x80200000` and defines stack and heap
   regions.
3. `_start` in `boot/start.S` aligns the stack and calls `kmain`.
4. `kernel/kmain.c` initializes the task table, scheduler, idle task, shell
   task, trap vector, and timer.
5. The first `sched_yield()` switches from boot code into the task runtime.

## Interrupt and Scheduling Path

1. The SBI timer raises a supervisor timer interrupt.
2. `kernel/trap.c` increments `g_ticks`, schedules the next timer interrupt, and
   marks `need_resched`.
3. Workloads call `sched_maybe_yield_safe()` at safe points, or Round-Robin
   preemption requests a switch when the quantum expires.
4. `kernel/sched.c` picks the next ready task.
5. `ctx_switch` in `boot/start.S` saves the outgoing task context and restores
   the incoming one.

## File Reading Map

| Topic | Start Here | Why |
| --- | --- | --- |
| Boot and linker layout | `linker.ld`, `boot/start.S` | Load address, initial stack, context register layout |
| Kernel initialization | `kernel/kmain.c` | Exact order of runtime subsystem setup |
| Timer and traps | `drivers/timer.c`, `kernel/trap.c` | SBI timer calls and supervisor interrupt handling |
| Task model | `include/helios.h`, `kernel/task.c` | PCB structure, stacks, task lifecycle |
| Scheduling | `kernel/sched.c` | RR/SJF selection, preemption flag, metrics |
| Memory | `kernel/kmem.c` | First-fit allocation, splitting, coalescing |
| Synchronization | `kernel/sync.c`, `kernel/shell.c` | Semaphores, mutexes, producer-consumer demo |
| Observability | `kernel/shell.c`, `scripts/smoke.sh` | Commands and automated runtime checks |

## Experiments To Try

Run the kernel:

```bash
make clean && make -j
make run
```

Then try these shell sessions:

```text
about
ps
run cpu
run io
ps
sched preempt on
uptime
intstats
```

Compare scheduling behavior:

```text
sched rr
bench
sched sjf
bench
```

Inspect synchronization:

```text
pcdemo
meminfo
```

Run the automated check:

```bash
make smoke
```

## Good Next Extensions

- Replace cooperative semaphore waiting with scheduler-managed blocked queues.
- Add a small syscall boundary and user-mode task entry.
- Add Sv39 page-table setup and separate kernel/user mappings.
- Load a simple user program from a static in-memory image.
- Add scheduler unit tests around ready-queue edge cases.
- Emit benchmark output in a machine-readable format for regression tracking.
