.syntax unified

.extern __estack

.section .text
.thumb
.thumb_func
.global _reset
_reset:
    /*The idea is to use instructions to encode an address*/
    /*when loaded to sp on boot equals 0x400237FC*/
    adds r7,#0xFC
    ands r2,r0
    /*0x00000005 points to this instruction and placement is the  reset vector in mem since 0x08000000 is mapped to 0x0 by defaut*/
    /*makes the program undebuggable lol and 0x0800 is lsls r0,r0,#32 which is an illegal shift */
    /*0x0005*/
    lsls r5,r0,#0
    /*0x0000*/
    lsls r0,r0,#0
    /*produce gpio addr */
    subs.w r0,sp,0x3000
    /*0xFC at the end (bit 2 set)*/
    str.n r0, [sp,#0x34]
    /*pins are initilised in TOGGLED state so we just need to change the mode*/
    str.n r7,[r0,#4]
    b.n _reset
