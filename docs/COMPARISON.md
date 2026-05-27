# HeliOS vs matwate/OS

This document compares HeliOS with `matwate/OS` as of 2026-05-27.

## Verdict

HeliOS is the stronger operating-system project. `matwate/OS` has a more visual demo surface because it boots into VGA mode, handles mouse drawing, and runs an MNIST classifier. HeliOS is less flashy on first boot, but it implements more OS concepts and proves them through CI.

## Comparison Matrix

| Area | HeliOS | matwate/OS | Advantage |
| --- | --- | --- | --- |
| Architecture | RISC-V 64 on QEMU `virt`, S-mode | x86 32-bit protected mode | Tie: different targets |
| Boot path | OpenSBI + custom kernel entry | BIOS boot sector + protected-mode transition | Tie |
| Shell | Interactive shell with process, scheduler, memory, timer, sync commands | No shell; graphical app loop | HeliOS |
| Scheduling | RR, SJF, cooperative/preemptive switch | No task scheduler | HeliOS |
| Multitasking | Kernel tasks and context switching | Single application loop | HeliOS |
| Timer/traps | SBI timer, trap handler, tick accounting | No comparable scheduler timer/trap layer | HeliOS |
| Synchronization | Semaphores, mutexes, producer-consumer demo | Not present | HeliOS |
| Memory management | Free-list allocator with coalescing | Static/global buffers | HeliOS |
| CI | GitHub Actions builds and boots QEMU smoke test | No CI in upstream repo | HeliOS |
| Visual demo | Serial shell + web visualization | VGA drawing grid, mouse, MNIST inference | matwate/OS |
| ML demo | None in kernel | MNIST classifier with external weights | matwate/OS |
| Repo presentation | Description, topics, docs, quickstart, smoke test | Sparse metadata, no description/topics | HeliOS |

## Where HeliOS Wins

- It demonstrates core OS ideas: boot, traps, timer, scheduling, tasks, context switching, synchronization, and memory allocation.
- It is easier to grade and defend because behavior is exposed through shell commands and automated QEMU verification.
- It is more maintainable: source is separated by subsystem, with documented build/run/test entry points.

## Where matwate/OS Still Wins

- It has immediate visual impact: VGA mode, mouse input, and a hand-drawn digit classifier feel more interactive in a live demo.
- Its raw disk weight-loading path is a good demo of low-level block-device access.
- MNIST gives it a memorable "AI inside an OS" story.

## Practical Roadmap to Keep the Lead

1. Keep CI green with `make smoke` as the minimum proof of bootability.
2. Add a short terminal GIF or screenshot to the README to improve first-impression impact.
3. Add one small visual feature that fits HeliOS, such as an ANSI-style task monitor command, instead of porting a full graphics stack.
4. Keep HeliOS focused on OS fundamentals; do not chase a graphics/ML demo unless the course rubric rewards it.

## One-Sentence Positioning

`matwate/OS` is a strong visual bare-metal demo; HeliOS is the stronger operating-system project because it implements and verifies the core OS mechanisms behind a real scheduler-driven kernel.
