addi t0 x0 11
addi t1 x0 22
addi t2 x0 33
addi a0 x0 5
addi a1 x0 7
jal 8
addi a0 x0 0
addi a1 x0 1
jal 2
j 38
addi sp sp -12
sw t0 8(sp)
sw t1 4(sp)
sw t2 0(sp)
add t0 x0 x0
addi t0 t0 0
slli a0 a0 2
slli a1 a1 2
add a0 a0 t0
add a1 a1 t0
lw t1 0(a0)
lw t2 0(a1)
sw t1 0(a1)
sw t2 0(a0)
lw t2 0(sp)
lw t1 4(sp)
lw t0 8(sp)
addi sp sp 12
jalr x0 0 ra
addi s0 s0 122
	
	
	
	
