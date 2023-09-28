//           ******************************************************
//          **   Processor      : ATMEGA 32                       **
//         ***   Frequency      : 8MHz External Clock             ***
//        ****   AUTHOR         : Reza Adinepour                  ****
//        ****   Linkedin       : linkedin.com/reza_adinepour/    ****
//         ***   Student ID:    : 9814303                         ***
//          **   Github         : github.com/reza_adinepour/      **
//           ******************************************************


#include <mega16.h>
#include <delay.h>
#include <stdio.h>
#include <lcd.h>

#asm
   .equ __lcd_port=0x1B ;PORTA
#endasm

long int timer0_ov;
float freq;
//double freqkhz;
char lcd_buff[20];

interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
    timer0_ov ++;
}

void main(void)
{


    // Timer(s)/Counter(s) Interrupt(s) initialization
    TIMSK=0x01;

    // LCD module initialization
    lcd_init(16);

    while (1)
    {
          TCCR0=0x06;     // Start Timer T0 pin Falling Edge   00000110
          #asm("sei")     // Global enable interrupts
          delay_ms(1000);
          #asm("cli");    // Global disable interrupts

          freq = timer0_ov * 256 + TCNT0;

          if (freq < 1000)
          {
            sprintf(lcd_buff, "Freq=%3.0f", freq);
            lcd_clear();
            lcd_puts(lcd_buff);
            lcd_putsf(" Hz");
          }

          else
          {
            freq = freq / 1000;
            sprintf(lcd_buff, "Freq=%3.2f", freq);
            lcd_clear();
            lcd_puts(lcd_buff);
            lcd_putsf(" KHz");
          }

          TCCR0=0x00;    //Stopt Timer0
          timer0_ov=0;   //Prepare for next count
          TCNT0=0;       //Clear Timer0
      }
}