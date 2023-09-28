//           ******************************************************
//          **   Processor      : ATMEGA 32                       **
//         ***   Frequency      : 16MHz External Clock            ***
//        ****   AUTHOR         : Reza Adinepour                  ****
//        ****   Linkedin       : linkedin.com/reza_adinepour/    ****
//         ***   Student ID:    : 9814303                         ***
//          **   Github         : github.com/reza_adinepour/      **
//           ******************************************************



#include <mega32.h>
#include <delay.h>



void main(void)
{
    DDRA = 0xff;
    PORTA = 0x00;   
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0xff;
    PORTC = 0x00;
    
    DDRC = 0xff;
    PORTC = 0x00;



    while (1)
    {
        PORTA = 0xaa;
        delay_ms(100);
        PORTA = 0x55;
        delay_ms(100);
    }
}