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

unsigned char help[] = {0x89, 0x86, 0xc7, 0x8c}, i;

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
        for(i = 0; i < 25; i++)
        {
            PORTA = 0x01;
            PORTB = help[0];
            delay_ms(10);   
        
            PORTA = 0x02;
            PORTB = help[1];
            delay_ms(10);
        
            PORTA = 0x04;
            PORTB = help[2];
            delay_ms(10);
        
            PORTA = 0x08;
            PORTB = help[3];
            delay_ms(10);
        }
        PORTA = 0x00;
        delay_ms(1000);
    }
}