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


void main(void)
{
    lcd_init(16);
    lcd_gotoxy(0, 0); 
    lcd_puts("reza adinepour");
    lcd_gotoxy(0, 1);
    lcd_puts("9814303"); 

    while (1)
    {
    
    }
}
