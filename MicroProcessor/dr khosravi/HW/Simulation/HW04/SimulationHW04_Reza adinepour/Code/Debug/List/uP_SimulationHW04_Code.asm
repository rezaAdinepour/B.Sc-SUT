
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _hour=R5
	.DEF _minute=R4
	.DEF _second=R7
	.DEF _day=R6
	.DEF _month=R9
	.DEF _year=R8
	.DEF _i=R11
	.DEF _mode=R10
	.DEF _state=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x1E,0x0
	.DB  0x0,0x8,0x7A,0x0

_0x3:
	.DB  0x3F,0x6,0x5B,0x4F,0x66,0x6D,0x7D,0x7
	.DB  0x7F,0x6F

__GLOBAL_INI_TBL:
	.DW  0x08
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x0A
	.DW  _digit
	.DW  _0x3*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;#include <mega32.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;#define display PORTC
;#define com PORTD
;#define display_calendar PORTA
;#define calendar_com PORTB
;#define set_time PINB.6
;#define set PINB.7
;#define rest_second PIND.7
;#define set_cal PIND.6
;#define on 0
;#define off 1
;
;
;
;unsigned char digit[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F}, hour = 0, minute = 0, second = 0 ...

	.DSEG
;unsigned char i = 0, mode = 122;
;
;enum st
;{
;    live_time,
;    set_hour,
;    set_minute,
;    set_calendar
;}state;
;
;
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0020 {

	.CSEG
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R30
	IN   R30,SREG
; 0000 0021     i++;
	INC  R11
; 0000 0022 }
	OUT  SREG,R30
	LD   R30,Y+
	RETI
; .FEND
;
;void main(void)
; 0000 0025 {
_main:
; .FSTART _main
; 0000 0026 
; 0000 0027     DDRA = 0xff;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 0028     PORTA = 0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0029 
; 0000 002A     DDRB = 0xff;
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 002B     PORTB = 0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 002C 
; 0000 002D     DDRC = 0xff;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 002E     PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 002F 
; 0000 0030     DDRD = 0xff;
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 0031     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0032 
; 0000 0033     // Timer/Counter 0 initialization
; 0000 0034     // Clock source: System Clock
; 0000 0035     // Clock value: 31.250 kHz
; 0000 0036     // Mode: Normal top=0xFF
; 0000 0037     // OC0 output: Disconnected
; 0000 0038     // Timer Period: 8.192 ms
; 0000 0039     TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (0<<CS00);
	LDI  R30,LOW(4)
	OUT  0x33,R30
; 0000 003A     TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 003B     OCR0=0x00;
	OUT  0x3C,R30
; 0000 003C 
; 0000 003D     // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 003E     TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(1)
	OUT  0x39,R30
; 0000 003F 
; 0000 0040 
; 0000 0041 
; 0000 0042 // Global enable interrupts
; 0000 0043 #asm("sei")
	sei
; 0000 0044 
; 0000 0045 
; 0000 0046     while (1)
_0x4:
; 0000 0047     {
; 0000 0048         //========== display calendar ==========
; 0000 0049         display_calendar = digit[year / 10];
	MOV  R26,R8
	RCALL SUBOPT_0x0
; 0000 004A         calendar_com = 0xfe; //1111 1110
	LDI  R30,LOW(254)
	RCALL SUBOPT_0x1
; 0000 004B         delay_us(250);
; 0000 004C         calendar_com = 0xff;
; 0000 004D         display_calendar = digit[year % 10];
	MOV  R26,R8
	RCALL SUBOPT_0x2
; 0000 004E         calendar_com = 0xfd; //1111 1101
	LDI  R30,LOW(253)
	RCALL SUBOPT_0x1
; 0000 004F         delay_us(250);
; 0000 0050         calendar_com = 0xff;
; 0000 0051 
; 0000 0052         display_calendar = digit[month / 10];
	MOV  R26,R9
	RCALL SUBOPT_0x0
; 0000 0053         calendar_com = 0xfb; //1111 1011
	LDI  R30,LOW(251)
	RCALL SUBOPT_0x1
; 0000 0054         delay_us(250);
; 0000 0055         calendar_com = 0xff;
; 0000 0056         display_calendar = digit[month % 10];
	MOV  R26,R9
	RCALL SUBOPT_0x2
; 0000 0057         calendar_com = 0xf7; //1111 0111
	LDI  R30,LOW(247)
	RCALL SUBOPT_0x1
; 0000 0058         delay_us(250);
; 0000 0059         calendar_com = 0xff;
; 0000 005A 
; 0000 005B         display_calendar = digit[day / 10];
	MOV  R26,R6
	RCALL SUBOPT_0x0
; 0000 005C         calendar_com = 0xef; //1110 1111
	LDI  R30,LOW(239)
	RCALL SUBOPT_0x1
; 0000 005D         delay_us(250);
; 0000 005E         calendar_com = 0xff;
; 0000 005F         display_calendar = digit[day % 10];
	MOV  R26,R6
	RCALL SUBOPT_0x2
; 0000 0060         calendar_com = 0xdf; //1101 1111
	LDI  R30,LOW(223)
	RCALL SUBOPT_0x1
; 0000 0061         delay_us(250);
; 0000 0062         calendar_com = 0xff;
; 0000 0063 
; 0000 0064         //========== display time ==========
; 0000 0065         display = digit[hour / 10];
	MOV  R26,R5
	RCALL SUBOPT_0x3
; 0000 0066         com = 0xfe; //1111 1110
	LDI  R30,LOW(254)
	RCALL SUBOPT_0x4
; 0000 0067         delay_us(250);
; 0000 0068         com = 0xff;
; 0000 0069         display = digit[hour % 10];
	MOV  R26,R5
	RCALL SUBOPT_0x5
; 0000 006A         com = 0xfd; //1111 1101
	LDI  R30,LOW(253)
	RCALL SUBOPT_0x4
; 0000 006B         delay_us(250);
; 0000 006C         com = 0xff;
; 0000 006D 
; 0000 006E         display = digit[minute / 10];
	MOV  R26,R4
	RCALL SUBOPT_0x3
; 0000 006F         com = 0xfb; //1111 1011
	LDI  R30,LOW(251)
	RCALL SUBOPT_0x4
; 0000 0070         delay_us(250);
; 0000 0071         com = 0xff;
; 0000 0072         display = digit[minute % 10];
	MOV  R26,R4
	RCALL SUBOPT_0x5
; 0000 0073         com = 0xf7; //1111 0111
	LDI  R30,LOW(247)
	RCALL SUBOPT_0x4
; 0000 0074         delay_us(250);
; 0000 0075         com = 0xff;
; 0000 0076 
; 0000 0077         display = digit[second / 10];
	MOV  R26,R7
	RCALL SUBOPT_0x3
; 0000 0078         com = 0xef; //1110 1111
	LDI  R30,LOW(239)
	RCALL SUBOPT_0x4
; 0000 0079         delay_us(250);
; 0000 007A         com = 0xff;
; 0000 007B         display = digit[second % 10];
	MOV  R26,R7
	RCALL SUBOPT_0x5
; 0000 007C         com = 0xdf; //1101 1111
	LDI  R30,LOW(223)
	RCALL SUBOPT_0x4
; 0000 007D         delay_us(250);
; 0000 007E         com = 0xff;
; 0000 007F 
; 0000 0080         switch(state)
	MOV  R30,R13
	LDI  R31,0
; 0000 0081         {
; 0000 0082             case live_time:
	SBIW R30,0
	BRNE _0xA
; 0000 0083                 if(i > mode) //1000ms / 8.192ms = 122
	CP   R10,R11
	BRSH _0xB
; 0000 0084                 {
; 0000 0085                     i = 0;
	CLR  R11
; 0000 0086                     second++;
	INC  R7
; 0000 0087                     if(second > 59)
	LDI  R30,LOW(59)
	CP   R30,R7
	BRSH _0xC
; 0000 0088                     {
; 0000 0089                         second = 0;
	CLR  R7
; 0000 008A                         minute++;
	INC  R4
; 0000 008B                         if(minute > 59)
	CP   R30,R4
	BRSH _0xD
; 0000 008C                         {
; 0000 008D                             minute = 0;
	CLR  R4
; 0000 008E                             hour++;
	INC  R5
; 0000 008F                             if(hour > 12)
	LDI  R30,LOW(12)
	CP   R30,R5
	BRSH _0xE
; 0000 0090                             {
; 0000 0091                                 hour = minute = second = 0;
	LDI  R30,LOW(0)
	MOV  R7,R30
	MOV  R4,R30
	MOV  R5,R30
; 0000 0092                                 day++;
	INC  R6
; 0000 0093                                 if(day > 30)
	LDI  R30,LOW(30)
	CP   R30,R6
	BRSH _0xF
; 0000 0094                                 {
; 0000 0095                                     day = 0;
	CLR  R6
; 0000 0096                                     month++;
	INC  R9
; 0000 0097                                     if(month > 12)
	LDI  R30,LOW(12)
	CP   R30,R9
	BRSH _0x10
; 0000 0098                                     {
; 0000 0099                                         month = 0;
	CLR  R9
; 0000 009A                                         year++;
	INC  R8
; 0000 009B                                     }
; 0000 009C                                 }
_0x10:
; 0000 009D 
; 0000 009E                             }
_0xF:
; 0000 009F 
; 0000 00A0                         }
_0xE:
; 0000 00A1                     }
_0xD:
; 0000 00A2                 }
_0xC:
; 0000 00A3                 if(set_time == 0)
_0xB:
	SBIC 0x16,6
	RJMP _0x11
; 0000 00A4                 {
; 0000 00A5                     while(set_time == 0);
_0x12:
	SBIS 0x16,6
	RJMP _0x12
; 0000 00A6                     state = set_hour;
	LDI  R30,LOW(1)
	MOV  R13,R30
; 0000 00A7                 }
; 0000 00A8                 if(set == 0)
_0x11:
	SBIC 0x16,7
	RJMP _0x15
; 0000 00A9                 {
; 0000 00AA                     while(set == 0);
_0x16:
	SBIS 0x16,7
	RJMP _0x16
; 0000 00AB                     mode = 1;
	LDI  R30,LOW(1)
	MOV  R10,R30
; 0000 00AC                 }
; 0000 00AD                 if(rest_second == 0)
_0x15:
	SBIC 0x10,7
	RJMP _0x19
; 0000 00AE                 {
; 0000 00AF                     while(rest_second == 0);
_0x1A:
	SBIS 0x10,7
	RJMP _0x1A
; 0000 00B0                     second = 0;
	CLR  R7
; 0000 00B1                 }
; 0000 00B2                 if(set_cal == 0)
_0x19:
	SBIC 0x10,6
	RJMP _0x1D
; 0000 00B3                 {
; 0000 00B4                     while(set_calendar == 0);
; 0000 00B5                     state = set_calendar;
	LDI  R30,LOW(3)
	MOV  R13,R30
; 0000 00B6                 }
; 0000 00B7             break;
_0x1D:
	RJMP _0x9
; 0000 00B8 
; 0000 00B9             case set_hour:
_0xA:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x21
; 0000 00BA                 if(set_time == 0)
	SBIC 0x16,6
	RJMP _0x22
; 0000 00BB                 {
; 0000 00BC                     while(set_time == 0);
_0x23:
	SBIS 0x16,6
	RJMP _0x23
; 0000 00BD                     hour++;
	INC  R5
; 0000 00BE                     if(hour > 23)
	LDI  R30,LOW(23)
	CP   R30,R5
	BRSH _0x26
; 0000 00BF                         hour = 0;
	CLR  R5
; 0000 00C0                 }
_0x26:
; 0000 00C1                 if(set == 0)
_0x22:
	SBIC 0x16,7
	RJMP _0x27
; 0000 00C2                 {
; 0000 00C3                     while(set == 0);
_0x28:
	SBIS 0x16,7
	RJMP _0x28
; 0000 00C4                     state = set_minute;
	LDI  R30,LOW(2)
	MOV  R13,R30
; 0000 00C5                 }
; 0000 00C6             break;
_0x27:
	RJMP _0x9
; 0000 00C7 
; 0000 00C8             case set_minute:
_0x21:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2B
; 0000 00C9                 if(set_time == 0)
	SBIC 0x16,6
	RJMP _0x2C
; 0000 00CA                 {
; 0000 00CB                     while(set_time == 0);
_0x2D:
	SBIS 0x16,6
	RJMP _0x2D
; 0000 00CC                     minute++;
	INC  R4
; 0000 00CD                     if(minute > 59)
	LDI  R30,LOW(59)
	CP   R30,R4
	BRSH _0x30
; 0000 00CE                         minute = 0;
	CLR  R4
; 0000 00CF                 }
_0x30:
; 0000 00D0                 if(set == 0)
_0x2C:
	SBIC 0x16,7
	RJMP _0x31
; 0000 00D1                 {
; 0000 00D2                     while(set == 0);
_0x32:
	SBIS 0x16,7
	RJMP _0x32
; 0000 00D3                     state = live_time;
	CLR  R13
; 0000 00D4                     mode = 122;
	LDI  R30,LOW(122)
	MOV  R10,R30
; 0000 00D5                 }
; 0000 00D6             break;
_0x31:
	RJMP _0x9
; 0000 00D7 
; 0000 00D8             case set_calendar:
_0x2B:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x9
; 0000 00D9                 if(set_cal == 0)
	SBIC 0x10,6
	RJMP _0x36
; 0000 00DA                 {
; 0000 00DB                     while(set_cal == 0);
_0x37:
	SBIS 0x10,6
	RJMP _0x37
; 0000 00DC                     year++;
	INC  R8
; 0000 00DD                     if(year > 99)
	LDI  R30,LOW(99)
	CP   R30,R8
	BRSH _0x3A
; 0000 00DE                         year = 0;
	CLR  R8
; 0000 00DF                 }
_0x3A:
; 0000 00E0 
; 0000 00E1                 if(set_time == 0)
_0x36:
	SBIC 0x16,6
	RJMP _0x3B
; 0000 00E2                 {
; 0000 00E3                     while(set_time == 0);
_0x3C:
	SBIS 0x16,6
	RJMP _0x3C
; 0000 00E4                     month++;
	INC  R9
; 0000 00E5                     if(month > 12)
	LDI  R30,LOW(12)
	CP   R30,R9
	BRSH _0x3F
; 0000 00E6                         month = 0;
	CLR  R9
; 0000 00E7                 }
_0x3F:
; 0000 00E8                 if(set == 0)
_0x3B:
	SBIC 0x16,7
	RJMP _0x40
; 0000 00E9                 {
; 0000 00EA                     while(set == 0);
_0x41:
	SBIS 0x16,7
	RJMP _0x41
; 0000 00EB                     day++;
	INC  R6
; 0000 00EC                     if(day > 30)
	LDI  R30,LOW(30)
	CP   R30,R6
	BRSH _0x44
; 0000 00ED                         day = 0;
	CLR  R6
; 0000 00EE                 }
_0x44:
; 0000 00EF                 if(rest_second == 0)
_0x40:
	SBIC 0x10,7
	RJMP _0x45
; 0000 00F0                 {
; 0000 00F1                     while(rest_second == 0);
_0x46:
	SBIS 0x10,7
	RJMP _0x46
; 0000 00F2                     state = live_time;
	CLR  R13
; 0000 00F3                     mode = 122;
	LDI  R30,LOW(122)
	MOV  R10,R30
; 0000 00F4                 }
; 0000 00F5         }//End Switch()
_0x45:
_0x9:
; 0000 00F6     }//End while()
	RJMP _0x4
; 0000 00F7 }//End main()
_0x49:
	RJMP _0x49
; .FEND
;
;
;
;
;
;
;/*
;void mux_6digit_sevenSeg_display(void)
;{
;    unsigned char k;
;    for(k = 0; k < 100; k++)
;    {
;        display = digit[hour / 10];
;        com = 0xfe; //1111 1110
;        delay_us(250);
;        com = 0xff;
;        display = digit[hour % 10];
;        com = 0xfd; //1111 1101
;        delay_us(250);
;        com = 0xff;
;
;        display = digit[minute / 10];
;        com = 0xfb; //1111 1011
;        delay_us(250);
;        com = 0xff;
;        display = digit[minute % 10];
;        com = 0xf7; //1111 0111
;        delay_us(250);
;        com = 0xff;
;
;        display = digit[second / 10];
;        com = 0xef; //1110 1111
;        delay_us(250);
;        com = 0xff;
;        display = digit[second % 10];
;        com = 0xdf; //1101 1111
;        delay_us(250);
;        com = 0xff;
;    }
;}
;*/

	.DSEG
_digit:
	.BYTE 0xA

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x0:
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	SUBI R30,LOW(-_digit)
	SBCI R31,HIGH(-_digit)
	LD   R30,Z
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x1:
	OUT  0x18,R30
	__DELAY_USW 500
	LDI  R30,LOW(255)
	OUT  0x18,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x2:
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	SUBI R30,LOW(-_digit)
	SBCI R31,HIGH(-_digit)
	LD   R30,Z
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x3:
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	SUBI R30,LOW(-_digit)
	SBCI R31,HIGH(-_digit)
	LD   R30,Z
	OUT  0x15,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x4:
	OUT  0x12,R30
	__DELAY_USW 500
	LDI  R30,LOW(255)
	OUT  0x12,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x5:
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	SUBI R30,LOW(-_digit)
	SBCI R31,HIGH(-_digit)
	LD   R30,Z
	OUT  0x15,R30
	RET


	.CSEG
__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

;END OF CODE MARKER
__END_OF_CODE:
