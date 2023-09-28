
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
	.DEF _cm=R5
	.DEF __lcd_x=R4
	.DEF __lcd_y=R7
	.DEF __lcd_maxx=R6

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

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x0:
	.DB  0x49,0x6E,0x76,0x61,0x6C,0x69,0x64,0x20
	.DB  0x43,0x6F,0x6D,0x6D,0x61,0x6E,0x64,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x10
	.DW  _0xE1
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+16
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+32
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+48
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+64
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+80
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+96
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+112
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+128
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+144
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+160
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+176
	.DW  _0x0*2

	.DW  0x10
	.DW  _0xE1+192
	.DW  _0x0*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

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
;#include <alcd.h>
;#include <stdio.h>
;#include <delay.h>
;
;
;unsigned char cm;
;
;void main(void)
; 0000 000A {

	.CSEG
_main:
; .FSTART _main
; 0000 000B     DDRA = 0x00;
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 000C     PORTA = 0x00;
	OUT  0x1B,R30
; 0000 000D 
; 0000 000E     DDRB = 0x00;
	OUT  0x17,R30
; 0000 000F     PORTB = 0x00;
	OUT  0x18,R30
; 0000 0010 
; 0000 0011     DDRC = 0x0ff;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0000 0012     PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0013 
; 0000 0014     DDRD = 0x00;
	OUT  0x11,R30
; 0000 0015     PORTD = 0x00;
	OUT  0x12,R30
; 0000 0016 
; 0000 0017     // USART initialization
; 0000 0018     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0019     // USART Receiver: On
; 0000 001A     // USART Transmitter: Off
; 0000 001B     // USART Mode: Asynchronous
; 0000 001C     // USART Baud Rate: 9600
; 0000 001D     UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	OUT  0xB,R30
; 0000 001E     UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(16)
	OUT  0xA,R30
; 0000 001F     UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0020     UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0021     UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 0022 
; 0000 0023     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 0024 
; 0000 0025     while (1)
_0x3:
; 0000 0026     {
; 0000 0027         cm = getchar();
	CALL SUBOPT_0x0
; 0000 0028         switch(cm)
; 0000 0029         {
; 0000 002A             case 'A':
	CPI  R30,LOW(0x41)
	LDI  R26,HIGH(0x41)
	CPC  R31,R26
	BRNE _0x9
; 0000 002B                 lcd_clear();
	CALL _lcd_clear
; 0000 002C                 lcd_putchar('A');
	LDI  R26,LOW(65)
	CALL _lcd_putchar
; 0000 002D                 PORTC = 0xff;
	LDI  R30,LOW(255)
	OUT  0x15,R30
; 0000 002E             break;
	RJMP _0x8
; 0000 002F 
; 0000 0030             case 'L':
_0x9:
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0xA
; 0000 0031                 lcd_clear();
	CALL _lcd_clear
; 0000 0032                 lcd_putchar('L');
	LDI  R26,LOW(76)
	CALL _lcd_putchar
; 0000 0033                 PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0034             break;
	RJMP _0x8
; 0000 0035 
; 0000 0036             case 'P':
_0xA:
	CPI  R30,LOW(0x50)
	LDI  R26,HIGH(0x50)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0xB
; 0000 0037                 lcd_clear();
	CALL _lcd_clear
; 0000 0038                 lcd_putchar('P');
	LDI  R26,LOW(80)
	CALL SUBOPT_0x1
; 0000 0039                 cm = getchar();
; 0000 003A                 switch(cm)
; 0000 003B                 {
; 0000 003C                     case 0:
	SBIW R30,0
	BRNE _0xF
; 0000 003D                         lcd_putchar('0');
	LDI  R26,LOW(48)
	CALL SUBOPT_0x1
; 0000 003E                         cm = getchar();
; 0000 003F                         switch(cm)
; 0000 0040                         {
; 0000 0041                             case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0x13
; 0000 0042                                 lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 0043                                 cm = getchar();
; 0000 0044                                 switch(cm)
; 0000 0045                                 {
; 0000 0046                                     case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0x17
; 0000 0047                                         lcd_putchar('N');
	LDI  R26,LOW(78)
	CALL _lcd_putchar
; 0000 0048                                         PORTC.0 = 1;
	SBI  0x15,0
; 0000 0049                                     break;
	RJMP _0x16
; 0000 004A 
; 0000 004B                                     case 'F':
_0x17:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x16
; 0000 004C                                         lcd_putchar('F');
	LDI  R26,LOW(70)
	CALL _lcd_putchar
; 0000 004D                                         PORTC.0 = 0;
	CBI  0x15,0
; 0000 004E                                     break;
; 0000 004F                                 }
_0x16:
; 0000 0050                             break;
	RJMP _0x12
; 0000 0051 
; 0000 0052                             case 0:
_0x13:
	SBIW R30,0
	BRNE _0x12
; 0000 0053                                 lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 0054                                 cm = getchar();
; 0000 0055                                 switch(cm)
; 0000 0056                                 {
; 0000 0057                                     case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0x20
; 0000 0058                                         lcd_putchar('L');
	LDI  R26,LOW(76)
	CALL _lcd_putchar
; 0000 0059                                         while(cm == 'L')
_0x22:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0x24
; 0000 005A                                         {
; 0000 005B                                             PORTC.0 = 1;
	SBI  0x15,0
; 0000 005C                                             delay_ms(150);
	CALL SUBOPT_0x2
; 0000 005D                                             PORTC.0 = 0;
	CBI  0x15,0
; 0000 005E                                             delay_ms(150);
	CALL SUBOPT_0x2
; 0000 005F                                         }
	RJMP _0x22
_0x24:
; 0000 0060 
; 0000 0061                                 }
_0x20:
; 0000 0062                             break;
; 0000 0063                         }
_0x12:
; 0000 0064                     break;
	RJMP _0xE
; 0000 0065 
; 0000 0066                     case 1:
_0xF:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x29
; 0000 0067                         lcd_putchar('1');
	LDI  R26,LOW(49)
	CALL SUBOPT_0x1
; 0000 0068                         cm = getchar();
; 0000 0069                             switch(cm)
; 0000 006A                             {
; 0000 006B                                 case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0x2D
; 0000 006C                                     lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 006D                                     cm = getchar();
; 0000 006E                                     switch(cm)
; 0000 006F                                     {
; 0000 0070                                         case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0x31
; 0000 0071                                             lcd_putchar('N');
	LDI  R26,LOW(78)
	CALL _lcd_putchar
; 0000 0072                                             PORTC.1 = 1;
	SBI  0x15,1
; 0000 0073                                         break;
	RJMP _0x30
; 0000 0074 
; 0000 0075                                         case 'F':
_0x31:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x30
; 0000 0076                                             lcd_putchar('F');
	LDI  R26,LOW(70)
	CALL _lcd_putchar
; 0000 0077                                             PORTC.1 = 0;
	CBI  0x15,1
; 0000 0078                                         break;
; 0000 0079 
; 0000 007A                                     }
_0x30:
; 0000 007B                                 break;
	RJMP _0x2C
; 0000 007C 
; 0000 007D                                 case 0:
_0x2D:
	SBIW R30,0
	BRNE _0x2C
; 0000 007E                                     lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 007F                                     cm = getchar();
; 0000 0080                                     switch(cm)
; 0000 0081                                     {
; 0000 0082                                         case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0x3A
; 0000 0083                                             lcd_putchar('L');
	LDI  R26,LOW(76)
	CALL _lcd_putchar
; 0000 0084                                             while(cm == 'L')
_0x3C:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0x3E
; 0000 0085                                             {
; 0000 0086                                                 PORTC.1 = 1;
	SBI  0x15,1
; 0000 0087                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0088                                                 PORTC.1 = 0;
	CBI  0x15,1
; 0000 0089                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 008A                                             }
	RJMP _0x3C
_0x3E:
; 0000 008B                                     }
_0x3A:
; 0000 008C                                 break;
; 0000 008D 
; 0000 008E 
; 0000 008F                             }
_0x2C:
; 0000 0090 
; 0000 0091                     break;
	RJMP _0xE
; 0000 0092 
; 0000 0093                     case 2:
_0x29:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x43
; 0000 0094                         lcd_putchar('2');
	LDI  R26,LOW(50)
	CALL SUBOPT_0x1
; 0000 0095                         cm = getchar();
; 0000 0096                             switch(cm)
; 0000 0097                             {
; 0000 0098                                 case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0x47
; 0000 0099                                     lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 009A                                     cm = getchar();
; 0000 009B                                     switch(cm)
; 0000 009C                                     {
; 0000 009D                                         case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0x4B
; 0000 009E                                             lcd_putchar('N');
	LDI  R26,LOW(78)
	CALL _lcd_putchar
; 0000 009F                                             PORTC.2 = 1;
	SBI  0x15,2
; 0000 00A0                                         break;
	RJMP _0x4A
; 0000 00A1 
; 0000 00A2                                         case 'F':
_0x4B:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x4A
; 0000 00A3                                             lcd_putchar('F');
	LDI  R26,LOW(70)
	CALL _lcd_putchar
; 0000 00A4                                             PORTC.2 = 0;
	CBI  0x15,2
; 0000 00A5                                         break;
; 0000 00A6                                     }
_0x4A:
; 0000 00A7                                 break;
	RJMP _0x46
; 0000 00A8 
; 0000 00A9                                 case 0:
_0x47:
	SBIW R30,0
	BRNE _0x46
; 0000 00AA                                     lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 00AB                                     cm = getchar();
; 0000 00AC                                     switch(cm)
; 0000 00AD                                     {
; 0000 00AE                                         case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0x54
; 0000 00AF                                             lcd_putchar('L');
	LDI  R26,LOW(76)
	RCALL _lcd_putchar
; 0000 00B0                                             while(cm == 'L')
_0x56:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0x58
; 0000 00B1                                             {
; 0000 00B2                                                 PORTC.2 = 1;
	SBI  0x15,2
; 0000 00B3                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 00B4                                                 PORTC.2 = 0;
	CBI  0x15,2
; 0000 00B5                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 00B6                                             }
	RJMP _0x56
_0x58:
; 0000 00B7                                         break;
; 0000 00B8                                     }
_0x54:
; 0000 00B9                             break;
; 0000 00BA                             }
_0x46:
; 0000 00BB                     case 3:
	RJMP _0x5D
_0x43:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x5E
_0x5D:
; 0000 00BC                         lcd_putchar('3');
	LDI  R26,LOW(51)
	CALL SUBOPT_0x1
; 0000 00BD                         cm = getchar();
; 0000 00BE                             switch(cm)
; 0000 00BF                             {
; 0000 00C0                                 case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0x62
; 0000 00C1                                     lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 00C2                                     cm = getchar();
; 0000 00C3                                     switch(cm)
; 0000 00C4                                     {
; 0000 00C5                                         case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0x66
; 0000 00C6                                             lcd_putchar('N');
	LDI  R26,LOW(78)
	RCALL _lcd_putchar
; 0000 00C7                                             PORTC.3= 1;
	SBI  0x15,3
; 0000 00C8                                         break;
	RJMP _0x65
; 0000 00C9 
; 0000 00CA                                         case 'F':
_0x66:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x65
; 0000 00CB                                             lcd_putchar('F');
	LDI  R26,LOW(70)
	RCALL _lcd_putchar
; 0000 00CC                                             PORTC.3= 0;
	CBI  0x15,3
; 0000 00CD                                         break;
; 0000 00CE                                     }
_0x65:
; 0000 00CF                                 break;
	RJMP _0x61
; 0000 00D0 
; 0000 00D1                                 case 0:
_0x62:
	SBIW R30,0
	BRNE _0x61
; 0000 00D2                                     lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 00D3                                     cm = getchar();
; 0000 00D4                                     switch(cm)
; 0000 00D5                                     {
; 0000 00D6                                         case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0x6F
; 0000 00D7                                             lcd_putchar('L');
	LDI  R26,LOW(76)
	RCALL _lcd_putchar
; 0000 00D8                                             while(cm == 'L')
_0x71:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0x73
; 0000 00D9                                             {
; 0000 00DA                                                 PORTC.3 = 1;
	SBI  0x15,3
; 0000 00DB                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 00DC                                                 PORTC.3 = 0;
	CBI  0x15,3
; 0000 00DD                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 00DE                                             }
	RJMP _0x71
_0x73:
; 0000 00DF                                         break;
; 0000 00E0                                     }
_0x6F:
; 0000 00E1                             }
_0x61:
; 0000 00E2                     break;
	RJMP _0xE
; 0000 00E3 
; 0000 00E4                     case 4:
_0x5E:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x78
; 0000 00E5                         lcd_putchar('4');
	LDI  R26,LOW(52)
	CALL SUBOPT_0x1
; 0000 00E6                         cm = getchar();
; 0000 00E7                             switch(cm)
; 0000 00E8                             {
; 0000 00E9                                 case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0x7C
; 0000 00EA                                     lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 00EB                                     cm = getchar();
; 0000 00EC                                     switch(cm)
; 0000 00ED                                     {
; 0000 00EE                                         case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0x80
; 0000 00EF                                             lcd_putchar('N');
	LDI  R26,LOW(78)
	RCALL _lcd_putchar
; 0000 00F0                                             PORTC.4 = 1;
	SBI  0x15,4
; 0000 00F1                                         break;
	RJMP _0x7F
; 0000 00F2 
; 0000 00F3                                         case 'F':
_0x80:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x7F
; 0000 00F4                                             lcd_putchar('F');
	LDI  R26,LOW(70)
	RCALL _lcd_putchar
; 0000 00F5                                             PORTC.4 = 0;
	CBI  0x15,4
; 0000 00F6                                         break;
; 0000 00F7                                     }
_0x7F:
; 0000 00F8                                 break;
	RJMP _0x7B
; 0000 00F9 
; 0000 00FA                                 case 0:
_0x7C:
	SBIW R30,0
	BRNE _0x7B
; 0000 00FB                                     lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 00FC                                     cm = getchar();
; 0000 00FD                                     switch(cm)
; 0000 00FE                                     {
; 0000 00FF                                         case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0x89
; 0000 0100                                             lcd_putchar('L');
	LDI  R26,LOW(76)
	RCALL _lcd_putchar
; 0000 0101                                             while(cm == 'L')
_0x8B:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0x8D
; 0000 0102                                             {
; 0000 0103                                                 PORTC.4 = 1;
	SBI  0x15,4
; 0000 0104                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0105                                                 PORTC.4 = 0;
	CBI  0x15,4
; 0000 0106                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0107                                             }
	RJMP _0x8B
_0x8D:
; 0000 0108                                         break;
; 0000 0109                                     }
_0x89:
; 0000 010A                             }
_0x7B:
; 0000 010B                     break;
	RJMP _0xE
; 0000 010C 
; 0000 010D                     case 5:
_0x78:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x92
; 0000 010E                         lcd_putchar('5');
	LDI  R26,LOW(53)
	CALL SUBOPT_0x1
; 0000 010F                         cm = getchar();
; 0000 0110                             switch(cm)
; 0000 0111                             {
; 0000 0112                                 case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0x96
; 0000 0113                                     lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 0114                                     cm = getchar();
; 0000 0115                                     switch(cm)
; 0000 0116                                     {
; 0000 0117                                         case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0x9A
; 0000 0118                                             lcd_putchar('N');
	LDI  R26,LOW(78)
	RCALL _lcd_putchar
; 0000 0119                                             PORTC.5 = 1;
	SBI  0x15,5
; 0000 011A                                         break;
	RJMP _0x99
; 0000 011B 
; 0000 011C                                         case 'F':
_0x9A:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x99
; 0000 011D                                             lcd_putchar('F');
	LDI  R26,LOW(70)
	RCALL _lcd_putchar
; 0000 011E                                             PORTC.5 = 0;
	CBI  0x15,5
; 0000 011F                                         break;
; 0000 0120                                     }
_0x99:
; 0000 0121                                 break;
	RJMP _0x95
; 0000 0122 
; 0000 0123                                 case 0:
_0x96:
	SBIW R30,0
	BRNE _0x95
; 0000 0124                                     lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 0125                                     cm = getchar();
; 0000 0126                                     switch(cm)
; 0000 0127                                     {
; 0000 0128                                         case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0xA3
; 0000 0129                                             lcd_putchar('L');
	LDI  R26,LOW(76)
	RCALL _lcd_putchar
; 0000 012A                                             while(cm == 'L')
_0xA5:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0xA7
; 0000 012B                                             {
; 0000 012C                                                 PORTC.5 = 1;
	SBI  0x15,5
; 0000 012D                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 012E                                                 PORTC.5 = 0;
	CBI  0x15,5
; 0000 012F                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0130                                             }
	RJMP _0xA5
_0xA7:
; 0000 0131                                         break;
; 0000 0132                                     }
_0xA3:
; 0000 0133                             }
_0x95:
; 0000 0134                     break;
	RJMP _0xE
; 0000 0135 
; 0000 0136                     case 6:
_0x92:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0xAC
; 0000 0137                         lcd_putchar('6');
	LDI  R26,LOW(54)
	CALL SUBOPT_0x1
; 0000 0138                         cm = getchar();
; 0000 0139                             switch(cm)
; 0000 013A                             {
; 0000 013B                                 case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0xB0
; 0000 013C                                     lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 013D                                     cm = getchar();
; 0000 013E                                     switch(cm)
; 0000 013F                                     {
; 0000 0140                                         case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0xB4
; 0000 0141                                             lcd_putchar('N');
	LDI  R26,LOW(78)
	RCALL _lcd_putchar
; 0000 0142                                             PORTC.6 = 1;
	SBI  0x15,6
; 0000 0143                                         break;
	RJMP _0xB3
; 0000 0144 
; 0000 0145                                         case 'F':
_0xB4:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0xB3
; 0000 0146                                             lcd_putchar('F');
	LDI  R26,LOW(70)
	RCALL _lcd_putchar
; 0000 0147                                             PORTC.6 = 0;
	CBI  0x15,6
; 0000 0148                                         break;
; 0000 0149                                     }
_0xB3:
; 0000 014A                                 break;
	RJMP _0xAF
; 0000 014B 
; 0000 014C                                 case 0:
_0xB0:
	SBIW R30,0
	BRNE _0xAF
; 0000 014D                                     lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 014E                                     cm = getchar();
; 0000 014F                                     switch(cm)
; 0000 0150                                     {
; 0000 0151                                         case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0xBD
; 0000 0152                                             lcd_putchar('L');
	LDI  R26,LOW(76)
	RCALL _lcd_putchar
; 0000 0153                                             while(cm == 'L')
_0xBF:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0xC1
; 0000 0154                                             {
; 0000 0155                                                 PORTC.6 = 6;
	SBI  0x15,6
; 0000 0156                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0157                                                 PORTC.6 = 6;
	SBI  0x15,6
; 0000 0158                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0159                                             }
	RJMP _0xBF
_0xC1:
; 0000 015A                                         break;
; 0000 015B                                     }
_0xBD:
; 0000 015C                             }
_0xAF:
; 0000 015D                     break;
	RJMP _0xE
; 0000 015E 
; 0000 015F                     case 7:
_0xAC:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0xE
; 0000 0160                         lcd_putchar('7');
	LDI  R26,LOW(55)
	CALL SUBOPT_0x1
; 0000 0161                         cm = getchar();
; 0000 0162                             switch(cm)
; 0000 0163                             {
; 0000 0164                                 case 'O':
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0xCA
; 0000 0165                                     lcd_putchar('O');
	LDI  R26,LOW(79)
	CALL SUBOPT_0x1
; 0000 0166                                     cm = getchar();
; 0000 0167                                     switch(cm)
; 0000 0168                                     {
; 0000 0169                                         case 'N':
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0xCE
; 0000 016A                                             lcd_putchar('N');
	LDI  R26,LOW(78)
	RCALL _lcd_putchar
; 0000 016B                                             PORTC.7 = 1;
	SBI  0x15,7
; 0000 016C                                         break;
	RJMP _0xCD
; 0000 016D 
; 0000 016E                                         case 'F':
_0xCE:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0xCD
; 0000 016F                                             lcd_putchar('F');
	LDI  R26,LOW(70)
	RCALL _lcd_putchar
; 0000 0170                                             PORTC.7 = 0;
	CBI  0x15,7
; 0000 0171                                         break;
; 0000 0172                                     }
_0xCD:
; 0000 0173                                 break;
	RJMP _0xC9
; 0000 0174 
; 0000 0175                                 case 0:
_0xCA:
	SBIW R30,0
	BRNE _0xC9
; 0000 0176                                     lcd_putchar('B');
	LDI  R26,LOW(66)
	CALL SUBOPT_0x1
; 0000 0177                                     cm = getchar();
; 0000 0178                                     switch(cm)
; 0000 0179                                     {
; 0000 017A                                         case 'L':
	CPI  R30,LOW(0x4C)
	LDI  R26,HIGH(0x4C)
	CPC  R31,R26
	BRNE _0xD7
; 0000 017B                                             lcd_putchar('L');
	LDI  R26,LOW(76)
	RCALL _lcd_putchar
; 0000 017C                                             while(cm == 'L')
_0xD9:
	LDI  R30,LOW(76)
	CP   R30,R5
	BRNE _0xDB
; 0000 017D                                             {
; 0000 017E                                                 PORTC.7 = 1;
	SBI  0x15,7
; 0000 017F                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0180                                                 PORTC.7 = 0;
	CBI  0x15,7
; 0000 0181                                                 delay_ms(150);
	CALL SUBOPT_0x2
; 0000 0182                                             }
	RJMP _0xD9
_0xDB:
; 0000 0183                                     }
_0xD7:
; 0000 0184                             }
_0xC9:
; 0000 0185                     break;
; 0000 0186                 }
_0xE:
; 0000 0187             break;
	RJMP _0x8
; 0000 0188 
; 0000 0189             case 7:
_0xB:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0xE0
; 0000 018A                 lcd_clear();
	RCALL _lcd_clear
; 0000 018B                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,0
	RJMP _0xEF
; 0000 018C                 delay_ms(2000);
; 0000 018D                 lcd_clear();
; 0000 018E 
; 0000 018F             break;
; 0000 0190 
; 0000 0191             case 8:
_0xE0:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0xE2
; 0000 0192                 lcd_clear();
	RCALL _lcd_clear
; 0000 0193                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,16
	RJMP _0xEF
; 0000 0194                 delay_ms(2000);
; 0000 0195                 lcd_clear();
; 0000 0196 
; 0000 0197             break;
; 0000 0198 
; 0000 0199             case 9:
_0xE2:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0xE3
; 0000 019A                 lcd_clear();
	RCALL _lcd_clear
; 0000 019B                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,32
	RJMP _0xEF
; 0000 019C                 delay_ms(2000);
; 0000 019D                 lcd_clear();
; 0000 019E 
; 0000 019F             break;
; 0000 01A0 
; 0000 01A1             case 4:
_0xE3:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xE4
; 0000 01A2                 lcd_clear();
	RCALL _lcd_clear
; 0000 01A3                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,48
	RJMP _0xEF
; 0000 01A4                 delay_ms(2000);
; 0000 01A5                 lcd_clear();
; 0000 01A6 
; 0000 01A7             break;
; 0000 01A8 
; 0000 01A9             case 5:
_0xE4:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0xE5
; 0000 01AA                 lcd_clear();
	RCALL _lcd_clear
; 0000 01AB                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,64
	RJMP _0xEF
; 0000 01AC                 delay_ms(2000);
; 0000 01AD                 lcd_clear();
; 0000 01AE 
; 0000 01AF             break;
; 0000 01B0 
; 0000 01B1             case 6:
_0xE5:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0xE6
; 0000 01B2                 lcd_clear();
	RCALL _lcd_clear
; 0000 01B3                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,80
	RJMP _0xEF
; 0000 01B4                 delay_ms(2000);
; 0000 01B5                 lcd_clear();
; 0000 01B6 
; 0000 01B7             break;
; 0000 01B8 
; 0000 01B9             case 1:
_0xE6:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xE7
; 0000 01BA                 lcd_clear();
	RCALL _lcd_clear
; 0000 01BB                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,96
	RJMP _0xEF
; 0000 01BC                 delay_ms(2000);
; 0000 01BD                 lcd_clear();
; 0000 01BE 
; 0000 01BF             break;
; 0000 01C0 
; 0000 01C1             case 2:
_0xE7:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xE8
; 0000 01C2                 lcd_clear();
	RCALL _lcd_clear
; 0000 01C3                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,112
	RJMP _0xEF
; 0000 01C4                 delay_ms(2000);
; 0000 01C5                 lcd_clear();
; 0000 01C6 
; 0000 01C7             break;
; 0000 01C8 
; 0000 01C9             case 3:
_0xE8:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xE9
; 0000 01CA                 lcd_clear();
	RCALL _lcd_clear
; 0000 01CB                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,128
	RJMP _0xEF
; 0000 01CC                 delay_ms(2000);
; 0000 01CD                 lcd_clear();
; 0000 01CE 
; 0000 01CF             break;
; 0000 01D0 
; 0000 01D1             case 'O':
_0xE9:
	CPI  R30,LOW(0x4F)
	LDI  R26,HIGH(0x4F)
	CPC  R31,R26
	BRNE _0xEA
; 0000 01D2                 lcd_clear();
	RCALL _lcd_clear
; 0000 01D3                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,144
	RJMP _0xEF
; 0000 01D4                 delay_ms(2000);
; 0000 01D5                 lcd_clear();
; 0000 01D6 
; 0000 01D7             break;
; 0000 01D8 
; 0000 01D9             case 'N':
_0xEA:
	CPI  R30,LOW(0x4E)
	LDI  R26,HIGH(0x4E)
	CPC  R31,R26
	BRNE _0xEB
; 0000 01DA                 lcd_clear();
	RCALL _lcd_clear
; 0000 01DB                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,160
	RJMP _0xEF
; 0000 01DC                 delay_ms(2000);
; 0000 01DD                 lcd_clear();
; 0000 01DE 
; 0000 01DF             break;
; 0000 01E0 
; 0000 01E1             case 'B':
_0xEB:
	CPI  R30,LOW(0x42)
	LDI  R26,HIGH(0x42)
	CPC  R31,R26
	BRNE _0xEC
; 0000 01E2                 lcd_clear();
	RCALL _lcd_clear
; 0000 01E3                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,176
	RJMP _0xEF
; 0000 01E4                 delay_ms(2000);
; 0000 01E5                 lcd_clear();
; 0000 01E6 
; 0000 01E7             break;
; 0000 01E8 
; 0000 01E9             case 'F':
_0xEC:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x8
; 0000 01EA                 lcd_clear();
	RCALL _lcd_clear
; 0000 01EB                 lcd_puts("Invalid Command");
	__POINTW2MN _0xE1,192
_0xEF:
	RCALL _lcd_puts
; 0000 01EC                 delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	CALL _delay_ms
; 0000 01ED                 lcd_clear();
	RCALL _lcd_clear
; 0000 01EE 
; 0000 01EF             break;
; 0000 01F0         }//End Main Switch()
_0x8:
; 0000 01F1     }//End While(1)
	RJMP _0x3
; 0000 01F2 }//End Main()
_0xEE:
	RJMP _0xEE
; .FEND

	.DSEG
_0xE1:
	.BYTE 0xD0
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

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x18
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x18,R30
	__DELAY_USB 13
	SBI  0x18,3
	__DELAY_USB 13
	CBI  0x18,3
	__DELAY_USB 13
	RJMP _0x2080001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x2080001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R4,Y+1
	LDD  R7,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x3
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x3
	LDI  R30,LOW(0)
	MOV  R7,R30
	MOV  R4,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	CP   R4,R6
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R7
	MOV  R26,R7
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	RJMP _0x2080001
_0x2000007:
_0x2000004:
	INC  R4
	SBI  0x18,1
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x18,1
	RJMP _0x2080001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x17
	ORI  R30,LOW(0xF0)
	OUT  0x17,R30
	SBI  0x17,3
	SBI  0x17,1
	SBI  0x17,2
	CBI  0x18,3
	CBI  0x18,1
	CBI  0x18,2
	LDD  R6,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	CALL SUBOPT_0x4
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET
; .FEND
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

	.CSEG
_getchar:
; .FSTART _getchar
getchar0:
     sbis usr,rxc
     rjmp getchar0
     in   r30,udr
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
__base_y_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 26 TIMES, CODE SIZE REDUCTION:72 WORDS
SUBOPT_0x0:
	CALL _getchar
	MOV  R5,R30
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 25 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x1:
	CALL _lcd_putchar
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(150)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
