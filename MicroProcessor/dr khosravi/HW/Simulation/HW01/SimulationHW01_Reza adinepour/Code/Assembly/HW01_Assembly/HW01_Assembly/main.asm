start:
    inc r16


	//////////////	Part a	//////////////

	/*ldi r17, 0xf0
	ldi r20, 0xa5
	add r20, r17*/


	//////////////	Part b	//////////////
	/*ldi r17, 0xca
	ldi r18, 0xf8
	ldi r19, 0x20
	ldi r20, 0x4b
	add r17, r18
	adc r19, r20
	sts 0x341, r17
	sts 0x342, r19*/


	//////////////	Part c	//////////////
	ldi r21, 0xf8
	ldi r22, 0xca 
	ldi r23, 0x20
	add r22, r21
	add r23, r22

	ldi r24, 0x20
	ldi r25, 0x4b
	ldi r26, 0x3d
	add r25, r24
	adc r26, r25

	sts 0x343, r23
	sts 0x344, r26


    rjmp start

