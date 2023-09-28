/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : Az2
Version : 
Date    : 2/24/2022
Author  : Matin Golpayegani
Company : 
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32.h>
#include <delay.h>

// Declare your global variables here

void main(void)
{


// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

PORTC = 0xff;

while (1)
      {
      PORTC.0 = 0;
      PORTC.3 = 0;
      delay_ms(8000);
      PORTC.3 = 1;
      PORTC.4 = 0;
      delay_ms(2000);
      PORTC.0 = 1;
      PORTC.4 = 1;
      
      PORTC.5 = 0;
      PORTC.2 = 0;
      delay_ms(8000);
      PORTC.2 = 1;
      PORTC.1 = 0;
      delay_ms(2000);
      PORTC.5 = 1;
      PORTC.1 = 1;

      }
}
