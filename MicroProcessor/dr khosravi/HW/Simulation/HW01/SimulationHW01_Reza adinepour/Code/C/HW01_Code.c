#include <mega32.h>
#include <delay.h>


#define oneLED PORTC.5
#define LED0 PORTB.0
#define LED1 PORTB.1
#define LED2 PORTB.2
#define LED3 PORTB.3
#define LED4 PORTB.4
#define LED5 PORTB.5
#define LED6 PORTB.6
#define LED7 PORTB.7
#define btn0 PINA.0
#define btn1 PINA.1
#define btn2 PINA.2
#define btn3 PINA.3
#define btn4 PINA.4
#define btn5 PINA.5
#define btn6 PINA.6
#define btn7 PINA.7
#define on 1
#define off 0


unsigned char t1 = 0, flag = 0;

void main(void)
{

    DDRA = 0x00;
    PORTA = 0xff;
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0xff;
    PORTC = 0x00;

    while (1)
    {
        oneLED = on;
        delay_ms(100);
        oneLED = off;
        delay_ms(100);
        t1++;
        if(flag == 0)
        {
            if(btn0 == 0)
            {
                flag = 1;
                t1 = 0;
                LED0 = ~LED0;
            }
            
            if(btn1 == 0)
            {
                flag = 1;
                t1 = 0;
                LED1 = ~LED1;
            }
            if(btn2 == 0)
            {
                flag = 1;
                t1 = 0;
                LED2 = ~LED2;
            }
            if(btn3 == 0)
            {
                flag = 1;
                t1 = 0;
                LED3 = ~LED3;
            }
            if(btn4 == 0)
            {
                flag = 1;
                t1 = 0;
                LED4 = ~LED4;
            }
            if(btn5 == 0)
            {
                flag = 1;
                t1 = 0;
                LED5 = ~LED5;
            }
            if(btn6 == 0)
            {
                flag = 1;
                t1 = 0;
                LED6 = ~LED6;
            }
            if(btn7 == 0)
            {
                flag = 1;
                t1 = 0;
                LED7 = ~LED7;
            }
        }
        else
        {
            if(t1 > 1)
            {
                flag = 0;
            }
        }
        
    }//End while(1)
    
}//End main()
