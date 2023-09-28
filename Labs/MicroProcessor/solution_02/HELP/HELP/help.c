/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 2/15/2020
Author  : 
Company : 
Comments: 


Chip type               : ATmega8535
Program type            : Application
AVR Core Clock frequency: 4.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 128
*******************************************************/

#include <mega8535.h>
#include <delay.h>
// Declare your global variables here

void main(void)
{
unsigned char HELP[]={0x89, 0x86, 0xC7, 0x8C};
unsigned char seven[]={0x01, 0x02, 0x04, 0x08};
int i=0;
int j=0;
bit flag=0;

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

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
           if (i==0){  
               PORTA=0x01; 
               PORTB=HELP[0];
               delay_ms(1000);
               i=1;
               }
           
           if (i==1){
               PORTA=0x01; 
               PORTB=HELP[0];
               delay_us(100);
               j++;
               PORTA=0x02;
               PORTB=HELP[1];
               delay_us(100);
               j++;
               
               if (j==10000){ 
                    i=2;
                    j=0;      
               }}
            
            if (i==2){
               PORTA=0x01; 
               PORTB=HELP[0];
               delay_us(100);
               j++;
               
               PORTA=0x02;
               PORTB=HELP[1];
               delay_us(100);
               j++;       
               
               PORTA=0x04;
               PORTB=HELP[2];
               delay_us(100);
               j++;
               
                if (j==10000){ 
                    i=3;
                    j=0;      
               }
               
            }  
            
             if (i==3){
               PORTA=0x01; 
               PORTB=HELP[0];
               delay_us(100);
               j++;
               
               PORTA=0x02;
               PORTB=HELP[1];
               delay_us(100);
               j++;       
               
               PORTA=0x04;
               PORTB=HELP[2];
               delay_us(100);
               j++;
               
               PORTA=0x08;
               PORTB=HELP[3];
               delay_us(100);
               j++;
               
               if (j==10000){ 
                    i=4;
                    j=0;      
               }
              
              
            }
            
             if (i==4){
             
               PORTA=0x02;
               PORTB=HELP[1];
               delay_us(100);
               j++;       
               
               PORTA=0x04;
               PORTB=HELP[2];
               delay_us(100);
               j++;
               
               PORTA=0x08;
               PORTB=HELP[3];
               delay_us(100);
               j++;
               
               if (j==10000){ 
                    i=5;
                    j=0;      
               }
           
            } 
            
             if (i==5){ 
               
               PORTA=0x04;
               PORTB=HELP[2];
               delay_us(100);
               j++;
               
               PORTA=0x08;
               PORTB=HELP[3];
               delay_us(100);
               j++;
               
               if (j==10000){ 
                    i=6;
                    j=0;      
               }
              
            }
            
             if (i==6){
               
               PORTA=0x08;
               PORTB=HELP[3];
               delay_ms(0100);
               i=0;
               j=0;
              
            }       
            
          
      }
}
