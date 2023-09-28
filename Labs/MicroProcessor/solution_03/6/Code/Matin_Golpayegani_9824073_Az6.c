/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : Az6
Version : 
Date    : 4/10/2022
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
#include <stdio.h>
#include <delay.h>
#include <alcd.h>
#define delay(x) delay_ms(x)

int key();
int keypad();
int scaleTo360(int);
int deg=0;
void main(void)
{
char step[] = {12,9,3,6};
int k;
char d[13];
float phase=0;

// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=P Bit6=P Bit5=P Bit4=P Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(1<<PORTC7) | (1<<PORTC6) | (1<<PORTC5) | (1<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

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

lcd_gotoxy(5,0);
lcd_puts("Matin");
lcd_gotoxy(3,1);
lcd_puts("Golpayegani");
delay(1000);


while (1)
      {
      lcd_clear();
      lcd_puts("Enter Direction ");
      lcd_puts("Left -  Right +");  
      while(1){
      k = key();
      if(k==12){
        step[0]=12;step[1]=9;step[2]=3;step[3]=6;
        lcd_clear();
        lcd_puts("Left");
        break;
      }                       
      else if(k==15){
        step[0]=6;step[1]=3;step[2]=9;step[3]=12;
        lcd_clear();
        lcd_puts("Right"); 
        break;
      }
      } 
            
      delay(1000);
      lcd_gotoxy(0,0);          
      lcd_puts("angle(= for set)"); 
      deg = 0;
      while(k!=14){
        k = key();
        if(k!=14)
            deg*=10;
        if(!(k>=10 && k<=15)){
            deg+=k;
            /*lcd_gotoxy(0,1);*/lcd_putchar(k+48);           
        }
        while(PINC.4==0||PINC.5==0||PINC.6==0||PINC.7==0);      
      } 
      deg = scaleTo360(deg);
      lcd_clear();
      sprintf(d,"degree: %d",deg);
      lcd_puts(d);
      while(phase<deg){
        for(k=0;k<4 && phase<deg;k++){
            phase+=1.8;
            PORTD = step[k];
            delay(100);
        }
      }phase=0;
      lcd_clear();
      lcd_puts("End");
      lcd_gotoxy(0,1);
      lcd_puts(d);
      delay(2000);
      }
}


int key(){
int i,kp;
  for(i=0;;i++){
    PORTC = 0xff & ~(1<<i);
    delay(10);
    if(i==3)
        i=-1; 
    kp = keypad();
    if(kp>=0 && kp<=15){
        return kp;    
    }
  }
}

int keypad(){
    if(PINC.0 == 0 && PINC.4 == 0)
        return 7;
    else if(PINC.0 == 0 && PINC.5 == 0)
        return 8;
    else if(PINC.0 == 0 && PINC.6 == 0)
        return 9;
    else if(PINC.0 == 0 && PINC.7 == 0)
        return 10; //÷
    else if(PINC.1 == 0 && PINC.4 == 0)
        return 4;                      
    else if(PINC.1 == 0 && PINC.5 == 0)
        return 5;                
    else if(PINC.1 == 0 && PINC.6 == 0)
        return 6;                
    else if(PINC.1 == 0 && PINC.7 == 0)
        return 11; //×        
    else if(PINC.2 == 0 && PINC.4 == 0)
        return 1;
    else if(PINC.2 == 0 && PINC.5 == 0)
        return 2;
    else if(PINC.2 == 0 && PINC.6 == 0)
        return 3;                
    else if(PINC.2 == 0 && PINC.7 == 0)
        return 12; //-                     
    else if(PINC.3 == 0 && PINC.4 == 0)
        return 13; //on/c                    
    else if(PINC.3 == 0 && PINC.5 == 0)
        return 0;                
    else if(PINC.3 == 0 && PINC.6 == 0)
        return 14; //=              
    else if(PINC.3 == 0 && PINC.7 == 0)
        return 15; //+
    else
        return -1;
}

int scaleTo360(int x){
    if(x<360)
        return x;
    return scaleTo360(x-360);
}


















































//           ******************************************************
//          **   Processor      : ATMEGA 32                       **
//         ***   Frequency      : 8MHz External Clock             ***
//        ****   AUTHOR         : Reza Adinepour                  ****
//        ****   Linkedin       : linkedin.com/reza_adinepour/    ****
//         ***   Student ID:    : 9814303                         ***
//          **   Github         : github.com/reza_adinepour/      **
//           ******************************************************

#include <mega32.h>
#include <alcd.h>
#include <delay.h>
#include <stdio.h>


int key();
int keypad();
int scaleTo360(int);
int deg = 0;


char step[] = {12, 9, 3, 6};
int k;
char d[13];
float phase = 0;



void main(void)
{
    DDRA = 0x00;
    PORTA = 0x00;
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0x0f;
    PORTC = 0xf0;
    
    DDRD = 0xff;
    PORTD = 0x00;
    
    lcd_init(16);
    
    lcd_gotoxy(5, 0);
    lcd_puts("Reza");
    lcd_gotoxy(3, 1);
    lcd_puts("Adinepour");
    delay_ms(1000);

    while (1)
    {
        lcd_clear();
        lcd_puts("Enter Direction ");
        lcd_puts("Left -  Right +");  
        while(1)
        {
            k = key();
            if(k == 12)
            {
                step[0] = 12;
                step[1] = 9;
                step[2] = 3;
                step[3] = 6;
                lcd_clear();
                lcd_puts("Left");
                break;
            }                       
            else if(k == 15)
            {
                step[0] = 6;
                step[1] = 3;
                step[2] = 9;
                step[3] = 12;
                lcd_clear();
                lcd_puts("Right"); 
                break;
            }
        } 
            
        delay_ms(1000);
        lcd_gotoxy(0, 0);          
        lcd_puts("angle(= for set)"); 
        deg = 0;   
        
        while(k != 14)
        {
            k = key();
            if(k != 14)
                deg *= 10;
            if(!(k >= 10 && k <= 15))
            {
                deg += k;
                //lcd_gotoxy(0,1);
                lcd_putchar(k + 48);           
            }
            while(PINC.4 == 0 || PINC.5 == 0 || PINC.6 == 0 || PINC.7 == 0);      
        }
         
        deg = scaleTo360(deg);
        lcd_clear();
        sprintf(d, "degree: %d", deg);
        lcd_puts(d); 
        
        while(phase < deg)
        {
            for(k = 0; (k < 4 && phase < deg); k++)
            {
                phase += 1.8;
                PORTD = step[k];
                delay_ms(100);
            }
        }
        phase = 0;
        lcd_clear();
        lcd_puts("End");
        lcd_gotoxy(0, 1);
        lcd_puts(d);
        delay_ms(2000);
    }
}


int key()
{
    int i, kp;
    for(i = 0; ;i++)
    {
        PORTC = 0xff & ~(1 << i);
        delay_ms(10);
        if(i == 3)
            i =- 1; 
        kp = keypad();
        if(kp >= 0 && kp <= 15)
            return kp;    
    }
}



int keypad()
{
    if( (PINC.0 == 0) && (PINC.4 == 0) )
        return 7;
    else if( (PINC.0 == 0) && (PINC.5 == 0) )
        return 8;
    else if( (PINC.0 == 0) && (PINC.6 == 0) )
        return 9;
    else if( (PINC.0 == 0) && (PINC.7 == 0) )
        return 10; //÷
    else if( (PINC.1 == 0) && (PINC.4 == 0) )
        return 4;                      
    else if( (PINC.1 == 0) && (PINC.5 == 0) )
        return 5;                
    else if( (PINC.1 == 0) && (PINC.6 == 0) )
        return 6;                
    else if( (PINC.1 == 0) && (PINC.7 == 0) )
        return 11; //×        
    else if( (PINC.2 == 0) && (PINC.4 == 0) )
        return 1;
    else if( (PINC.2 == 0) && (PINC.5 == 0) )
        return 2;
    else if( (PINC.2 == 0) && (PINC.6 == 0) )
        return 3;                
    else if( (PINC.2 == 0) && (PINC.7 == 0) )
        return 12; //-                     
    else if( (PINC.3 == 0) && (PINC.4 == 0) )
        return 13; //on/c                    
    else if( (PINC.3 == 0) && (PINC.5 == 0) )
        return 0;                
    else if( (PINC.3 == 0) && (PINC.6 == 0) )
        return 14; //=              
    else if( (PINC.3 == 0) && (PINC.7 == 0) )
        return 15; //+
    else
        return -1;
}


int scaleTo360(int x)
{
    if(x < 360)
        return x;
    return scaleTo360(x - 360);
}