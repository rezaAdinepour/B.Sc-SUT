//           ******************************************************
//          **   Processor      : ATMEGA 32                       **
//         ***   Frequency      : 8MHz External Clock             ***
//        ****   AUTHOR         : Reza Adinepour                  ****
//        ****   Linkedin       : linkedin.com/reza_adinepour/    ****
//         ***   Student ID:    : 9814303                         ***
//          **   Github         : github.com/reza_adinepour/      **
//           ******************************************************
#include <mega32.h>

void main(void)
{
    DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
    PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (1<<PORTA2) | (1<<PORTA1) | (1<<PORTA0);

    DDRD=(0<<DDD7) | (0<<DDD6) | (1<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
    PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

    TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
    TCCR1B=(0<<ICNC1) | (0<<ICES1) | (1<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (0<<CS10);
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x27;
    ICR1L=0x10;
    OCR1AH=0x02;
    OCR1AL=0xEE;
    OCR1BH=0x00;
    OCR1BL=0x00;

    while (1)
    {
      if(PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1)
        OCR1A = 0x02EE; // 0 deg
        
      else if(PINA.0 == 0 && PINA.1 == 1 && PINA.2 == 1)
        OCR1A = 0x036B; // 45 deg
      
      else if(PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1)
        OCR1A = 0x0271; // -45 deg
        
      else if(PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 0)
        OCR1A = 0x03E8; // 90 deg  
        
      else if(PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 1)
        OCR1A = 0x01F4; // -90 deg
    }
}
