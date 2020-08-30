# MIPS32 Single Cyle Cpu💻
This is a single cycle cpu based on MIPS32 with verilog.
- 36 MIPS instructions achieved
- assembly testbench dump hex txt in *code.txt*,
  contents are as follows:

```
main: addiu $1, $0,1
sll $2, $1,4
label6: addu $3, $2,$1
srl $4, $2,2
slti $25,$4,5
bgez $25,label1
subu $5, $3,$4
label7: sw $5, 20($0)
nor $6, $5,$2
or $7, $6,$3
xor $8, $7,$6
sw $8, 28($0)
beq $8, $3,label2
slt $9, $6,$7
label2: addiu $1, $0,8
lw $10,20($1)
bne $10,$5,label5
and $11,$2,$1
sw $11,28($1)
sw $4, 16($1)
label5: jal label3
label1: lui $12,12
srav $26,$12,$2
sllv $27,$26,$1
jalr $27
label3: sb $26,5($3)
sltu $13,$3,$3
bgtz $13,label6
sllv $14,$6,$4
sra $15,$14,2
srlv $16,$15,$1
blez $16,label7
srav $16,$15,$1
addiu $11,$0,140
bltz $16, label4
lw $28,3($10)
bne $28,$29,label8
sb $15,8($5)
lb $18,8($5)
lbu $19,8($5)
label4: sltiu $24,$15,0xFF
or $29,$12,$5
jr $11
label8: andi $20,$15,0xFF
ori $21,$15,0xFF
xori $22,$15,0xFF
j main
```


