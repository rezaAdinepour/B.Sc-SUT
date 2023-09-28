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

char step[4] = {12, 9, 3, 6};
int i;

void main(void)
{
    DDRA = 0x0f;
    PORTA = 0x00;
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0xff;
    PORTC = 0x00;
    
    DDRD = 0xff;
    PORTD = 0x00;
    
    while (1)
    { 
        for(i = 0; i < 4; i++)
        {
            PORTC = step[i];
            delay_ms(1000);
        }
    }
}