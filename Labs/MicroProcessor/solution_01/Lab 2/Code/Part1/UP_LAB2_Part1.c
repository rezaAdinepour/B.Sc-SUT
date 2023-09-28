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


#define on 1
#define off 0

#define TLLR PORTA.0
#define TLLY PORTA.1
#define TLLG PORTA.2  

#define TLRR PORTA.3
#define TLRY PORTA.4
#define TLRG PORTA.5
                       

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
        PORTA = 0x00;
        
        TLLG = TLRR = on; 
        delay_ms(8000);
        TLLG = off;
        
        TLLY = on;
        delay_ms(2000);
        TLLY = TLRR = off;
        
        TLLR = TLRY = on;
        delay_ms(2000);
        TLRY = off;
        
        TLRG = on;
        delay_ms(8000);
        TLRG = TLLR = off;
    }//end while
}//end main
