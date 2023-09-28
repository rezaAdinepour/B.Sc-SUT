/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 3/4/2022
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


void main(void)
{

char h = 0b10001001;
char e = 0b10000110;
char l = 0b11000111;
char p = 0b10001100;
int i;

// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);


while (1)
      {         
      PORTD = 1;
      PORTC = h;
      delay_ms(1000);

      for(i=0;i<50;i++){
        PORTD = 1;
        PORTC = h;
        delay_ms(10);
        PORTD = 2;
        PORTC = e;
        delay_ms(10);
      }

      for(i=0;i<33;i++){
        PORTD = 1;
        PORTC = h;
        delay_ms(10);
        PORTD = 2;
        PORTC = e;
        delay_ms(10);
        PORTD = 4;
        PORTC = l;
        delay_ms(10);
      }
      for(i=0;i<25;i++){
        PORTD = 1;
        PORTC = h;
        delay_ms(10);
        PORTD = 2;
        PORTC = e;
        delay_ms(10);
        PORTD = 4;
        PORTC = l;        
        delay_ms(10);
        PORTD = 8;
        PORTC = p;
        delay_ms(10);
      }
      for(i=0;i<33;i++){
        PORTD = 2;
        PORTC = e;
        delay_ms(10);
        PORTD = 4;
        PORTC = l;
        delay_ms(10);
        PORTD = 8;
        PORTC = p;
        delay_ms(10);
      }
      for(i=0;i<50;i++){
        PORTD = 4;
        PORTC = l;
        delay_ms(10);
        PORTD = 8;
        PORTC = p;
        delay_ms(10);
      }
      PORTD = 8;
      PORTC = p;
      delay_ms(1000);
                   
      }
}