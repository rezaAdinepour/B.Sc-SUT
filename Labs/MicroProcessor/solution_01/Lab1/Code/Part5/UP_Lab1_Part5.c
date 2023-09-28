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

unsigned int i = 0x01;
unsigned char flag = 0;


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
        if(flag == 0)
        {
            PORTA |= i;
            delay_ms(200);
            i <<= 1;
            if(i >= 255)
            {
                flag = 1;
                i = 0xff; 
            }
                
        }
        if(flag == 1)
        { 
            PORTA &= i; 
            i >>= 1;
            delay_ms(200);
            if(i <= 0)
            {
                flag = 0;
                i = 0x01;  
            }     
        }
    }
}