//           ******************************************************
//          **   Processor      : ATMEGA 32                       **
//         ***   Frequency      : 8MHz External Clock             ***
//        ****   AUTHOR         : Reza Adinepour                  ****
//        ****   Linkedin       : linkedin.com/reza_adinepour/    ****
//         ***   Student ID:    : 9814303                         ***
//          **   Github         : github.com/reza_adinepour/      **
//           ******************************************************

#include <mega32.h>
#include <delay.h>


unsigned char i = 0x01;


void main(void)
{
    DDRA = 0xff;
    PORTA = 0x00;  
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0xff;
    PORTC = 0x00;
    
    DDRD = 0xff;
    PORTD = 0x00;

    while (1)
    { 
        PORTA = i;
        delay_ms(100);
        i <<= 1;
        i = i == 0? 1: i;
    }
}