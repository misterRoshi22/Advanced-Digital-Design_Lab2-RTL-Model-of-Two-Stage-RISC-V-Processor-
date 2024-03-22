addi s0 x0 10
add t0 x0 x0
slli t1 t0 2
sw t0 0(t1)
addi t0 t0 1
bne t0 s0 -8
addi t6 x0 122
addi s0 x0 9
add t0 x0 x0
slli t1 t0 2
lw t2 0(t1)
lw t3 4(t1)
add t2 t2 t3
sw t2 4(t1)
addi t0 t0 1
bne t0 s0 -14
addi t2 x0 122
