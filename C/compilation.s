	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 12, 1
	.globl	_add                    ; -- Begin function add
	.p2align	2
_add:                                   ; @add
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	str	w0, [sp, #12]
	str	w1, [sp, #8]
	ldr	w0, [sp, #12]
	ldr	w1, [sp, #8]
	add	w0, w0, w1
	str	w0, [sp, #4]
	ldr	w0, [sp, #4]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                   ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48             ; =48
	stp	x29, x30, [sp, #32]     ; 8-byte Folded Spill
	add	x29, sp, #32            ; =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	orr	w8, wzr, #0x1
	orr	w9, wzr, #0x4
	stur	wzr, [x29, #-4]
	stur	w0, [x29, #-8]
	str	x1, [sp, #16]
	mov	x0, x8
	mov	x1, x9
	bl	_add
	str	w0, [sp, #12]
	ldr	w8, [sp, #12]
                                        ; implicit-def: %lr
	mov	x30, x8
	mov	x10, sp
	str	x30, [x10]
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	mov	w8, #0
	str	w0, [sp, #8]            ; 4-byte Folded Spill
	mov	x0, x8
	ldp	x29, x30, [sp, #32]     ; 8-byte Folded Reload
	add	sp, sp, #48             ; =48
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"%d"


.subsections_via_symbols
