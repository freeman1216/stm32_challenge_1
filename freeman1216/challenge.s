.syntax unified

.extern __estack

.section .vectors,"a",%progbits
.type ivt, %object
 ivt:
    .word 0x40020800
    .word _reset

.size  ivt, .-ivt
.section .text
.thumb
.thumb_func
.global _reset
_reset:
    /*The idea is to use instructions to encode an address*/
    ldr.n r0, addr
    /*third bit in fc is set so we can just store the address as is to enable gpio*/
    str.n r0, [r0,#0x34]
addr:
    /*little endian so this is FC 37 in memory*/
    /*wraps and becomes negative which we use to construct a mask to toggle the bit*/
    adds r7,#0xFC
    /*little endian so this is 02 40 in memory*/
    ands r2,r0
    /*when loaded equals 0x400237FC*/
    /*pins are initilised in TOGGLED state so we just need to change the mode*/
    str.n r7,[sp]
    b addr
