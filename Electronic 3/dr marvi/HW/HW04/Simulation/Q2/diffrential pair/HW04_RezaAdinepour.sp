reza adinepour - 9814303 - Elec3-HW04-Q1


*******************************//mosfet model//*******************************

.model		Ynmos		nmos		level=1		vto=0.7		gamma=0.45		phi=0.9		nsub=9e14		ld=0.08e-6		uo=350		lambda=0.1		tox=9e-9	pb=0.9		cj=0.56e-3	cjsw=0.35e-11	mj=0.45		mjsw=0.2	cgdo=0.4e-9		js=1.0e-8
.model		Ypmos		pmos		level=1		vto=-0.8	gamma=0.4		phi=0.8		nsub=5e14		ld=0.09e-6		uo=100		lambda=0.2		tox=9e-9	pb=0.9		cj=0.94e-3	cjsw=0.32e-11	mj=0.5		mjsw=0.3	cgdo=0.3e-9		js=0.5e-8



**********************//devices//**********************
VDD		100		0		5V
Vin		11		0		ac=1		sin		0		50n		1K
Eip		1		0		11			0		0.5
Ein		2		0		11			0	   -0.5
Eout	12		0		7			6		1

Iss		3		0		1mA

M1		6		4		3			0		Ynmos		w=360u		l=0.18u		
M2		7		5		3			0		Ynmos		w=360u		l=0.18u

RD1		100		6		10K
RD2		100		7		10K
Rsp		1		4		1K
Rsn		2		5		1K


*******************************//analysis//*******************************
.op
.tran		1u		5m		start=0m
.ac			dec		50		1			10x
.probe		ac		Gain=par('V(12)')
.print		ac		Gain=par('V(12)')
.meas		ac		gain	max			V(12)
.meas		ac		fu		when		V(12)=1
.pz			v(12)	Vin	

.option nomod
.end
