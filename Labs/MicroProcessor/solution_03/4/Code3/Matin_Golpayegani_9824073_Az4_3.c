/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : LCD
Version : 
Date    : 3/9/2022
Author  : Matin Golpayegani
Company : 
Comments: 
Az4_3


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32.h>
#include <delay.h>
// Alphanumeric LCD functions
#include <alcd.h>

// Declare your global variables here

void main(void)
{
char s[] = "God";
int i,j;

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 0
// RD - PORTA Bit 1
// EN - PORTA Bit 2
// D4 - PORTA Bit 4
// D5 - PORTA Bit 5
// D6 - PORTA Bit 6
// D7 - PORTA Bit 7
// Characters/line: 16
lcd_init(16);

while (1)
      {
      lcd_gotoxy(1,0);
      lcd_puts("In the name of");
      
      for(i=0;i<3;i++){
        for(j=0;j<=8-i;j++){
            lcd_gotoxy(j-1,1);
            lcd_putchar(' ');
            lcd_gotoxy(j,1);
            lcd_putchar(s[2-i]);
            delay_ms(50);    
        }
      }
      delay_ms(1000);
      for(i=0;i<3;i++){
        for(j=9-i;j<=16;j++){
            lcd_gotoxy(j-1,1);
            lcd_putchar(' ');
            lcd_gotoxy(j,1);
            lcd_putchar(s[2-i]);
            delay_ms(50);    
        }
      }
      
      delay_ms(1000);
      }  
}
