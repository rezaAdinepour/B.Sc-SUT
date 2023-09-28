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

char step[] = {14, 12, 13, 9, 11, 3, 7, 6};
int i;

void main(void)
{
    DDRA = 0x00;
    PORTA = 0x01;
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0x0f;
    PORTC = 0x00;
    
    DDRD = 0xff;
    PORTD = 0x00;
    
    while (1)
    {
        if(PINA.0 == 1)
	    {
            for(i = 0; i < 8; i++)
		    {
                PORTC = step[i];
                delay_ms(1000);
            }
        }
        else if(PINA.0 == 0)
	    {
            for(i = 7; i >= 0; i--)
		    {
                PORTC = step[i];
                delay_ms(1000);
            } 
        }
	}
}