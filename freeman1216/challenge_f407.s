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
    /*bit 30 and bit 6 is set in the adress  so we can just shift it by 4 to get a mask*/
    /*added benefit is that we dont write to reserved bits*/
    lsrs r3,r0,#4
    str.n r3, [r0,#0x34]
    /*to get bit 26 set*/
    str.n r3, [sp]
dst1:
    /*steal sign bit*/
    asrs r1,r7,#20
    str.n r1, [sp,#20]
addr:
    /*little endian so this is FC 37 in memory*/
    /*wraps and becomes negative which we use to construct a mask to toggle the bit*/
    adds r7,#0xFC
    /*little endian so this is 02 40 in memory*/
    ands r2,r0
    /*when loaded equals 0x400237FC*/
    b dst1
