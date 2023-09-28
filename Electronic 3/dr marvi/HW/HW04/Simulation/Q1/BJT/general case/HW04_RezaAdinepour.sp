reza adinepour - 9814303 - Elec3-HW04-Q1


***********************//models//***********************
.model	myNPN	npn		Is=1fA		Bf=100v		Va=50



**********************//devices//**********************

vcc		100		0		1.8V
vin		1		5		ac=1	sin		0V		1mV		1K
vbe		5		0		0.6V
vb		4		0		1.2V
Q1		3		1		0		myNPN
Q2		6		4		3		myNPN
CL		6		0		10pF
RL		100		6		1K


**********************//analysis//**********************
.op
.tran		1u		5m		start=0m
.ac			dec		50		1			10x
.print		ac		Gain=par('V(6)')
.meas		ac		gain	max			V(6)
.meas		ac		fu		when		V(6)=1
.pz			v(6)	Vin	

.option nomod
.end
