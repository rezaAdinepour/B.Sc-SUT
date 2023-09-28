reza adinepour - 9814303 - Elec3-HW04-Q1


***********************//models//***********************
.model	myNPN	npn		Is=1fA		Bf=100		Va=50v


**********************//devices//**********************
Vcc		100		0		5V
Iss		100		1		1mA
Q1		1		1		0		myNPN
Q2		2		1		0		myNPN
RL		100		2		10K

**********************//analysis//**********************
.op
.tran		1u		5m		start=0m
.ac			dec		50		1			10x
.print		ac		Icopy=par('I(2)')
.meas		ac		gain	max			V(2)

.option nomod
.end