#include <mega32.h>
#include <delay.h>

#define btn0 PINA.0
#define btn1 PINA.1
#define TLLR PORTB.0
#define TLLY PORTB.1
#define TLLG PORTB.2
#define TLRR PORTB.3
#define TLRY PORTB.4
#define TLRG PORTB.5
#define on 1
#define off 0

unsigned char p = 0x73;

void main(void)
{
    DDRA = 0x00;
    PORTA = 0xff;
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0xff;
    PORTC = 0x00;
    
    DDRD = 0xff;
    PORTD = 0x00;
    

    while (1)
    {
        
        if((btn0 == 1) && (btn1 == 1))
        {
            PORTC = p;
            PORTB = 0x00;
            PORTD = 0x00; 
        }
                        
        else if((btn0 == 0) && (btn1 == 1))
        {
            PORTC = 0x00;
            TLLG = TLRR = on;
            delay_ms(6000);
            TLLG = TLRR = off;
            TLLY = TLRY = on;
            delay_ms(1000);
            TLLY = TLRY = off;
            TLLR = TLRG = on;
            delay_ms(4000);
            TLLR = TLRG = off;
            
        }
        else if((btn0 == 1) && (btn1 == 0))
        {
            PORTC = 0x00;
            TLLG = TLRR = on;
            delay_ms(5000);
            TLLG = TLRR = off;
            TLLY = TLRY = on;
            delay_ms(1000);
            TLLY = TLRY = off;
            TLLR = TLRG = on;
            delay_ms(5000);
            TLLR = TLRG = off;       
        }
        else if((btn0 == 0) && (btn1 == 0))
        {
            TLLR = TLRY = on;
            delay_ms(500);
            TLLR = TLRY = off;
            delay_ms(500);
        }
    }//End main()
}//End While()
