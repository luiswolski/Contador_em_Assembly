.cseg
.org 0x00
rjmp reset
.org 0x08
rjmp INT0_vect

dig:.db 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111

.equ meuPTR_low = 0x00
.equ meuPTR_high = 0x02


reset:
sbi PINC, 0
ldi r17, 0b00000010
sts PCICR, r17
ldi r17, 0b00000001
sts PCMSK1, r17
sei		; Global Enable Interrupt				


loop:
	ldi r26, meuPTR_low
	ldi r27, meuPTR_high
	ldi r16, 0b00111111 ;0 em binario sendo carregado em r16
	st X+, r16  ;Movnedo os dados de r16 para o registrador X+
	ldi r16, 0b00000110 ;1
	st X+, r16
	ldi r16, 0b01011011 ;2
	st X+, r16
	ldi r16, 0b01001111 ;3
	st X+, r16
	ldi r16, 0b01100110 ;4
	st X+, r16
	ldi r16, 0b01101101 ;5
	st X+, r16
	ldi r16, 0b01111101 ;6
	st X+, r16
	ldi r16, 0b00000111 ;7
	st X+, r16
	ldi r16, 0b01111111 ;8
	st X+, r16
	ldi r16, 0b01101111 ;9
	st X+, r16

	ldi r16, 0x7F
	out DDRB, r16;DDRB porta de saida
	out DDRD, r16;DDRD porta de saida
	ldi r16, 0; zerando r16 e r20
	ldi r20, 0
	mov r26, r16
	ld r17, X
	out PORTB, r17
	mov r26, r20
	ld r17, X
	out PORTD, r17
	call delay
	inc r16
	cpi r16, 0x0A; compara caso tenha chegado a 10d
	brne loop
	ldi r16, 0
	inc r20
	cpi r20, 0x0A
	brne loop
	ldi r20, 0
	rjmp loop

delay:
	ldi r21, 94
	ldi r22, 100
	ldi r23, 33
loop_delay:
	dec r21
	brne loop_delay
	ldi r21, 100
	dec r22
	brne loop_delay
	ldi r22, 100
	dec r23
	brne loop_delay
	ret

INT0_vect:
	nop
	inc r18
	out PORTC, r18
	ret
