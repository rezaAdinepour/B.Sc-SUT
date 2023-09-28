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
#include <delay.h>
#include <stdio.h>


int key();
int keypad();
int scaleTo360(int);
int deg = 0;


char step[] = {12, 9, 3, 6};
int k;
char d[13];
float phase = 0;



void main(void)
{
    DDRA = 0x00;
    PORTA = 0x00;
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    DDRC = 0x0f;
    PORTC = 0xf0;
    
    DDRD = 0xff;
    PORTD = 0x00;
    
    lcd_init(16);
    
    lcd_gotoxy(5, 0);
    lcd_puts("Reza");
    lcd_gotoxy(3, 1);
    lcd_puts("Adinepour");
    delay_ms(1000);

    while (1)
    {
        lcd_clear();
        lcd_puts("Enter Direction ");
        lcd_puts("Left -  Right +");  
        while(1)
        {
            k = key();
            if(k == 12)
            {
                step[0] = 12;
                step[1] = 9;
                step[2] = 3;
                step[3] = 6;
                lcd_clear();
                lcd_puts("Left");
                break;
            }                       
            else if(k == 15)
            {
                step[0] = 6;
                step[1] = 3;
                step[2] = 9;
                step[3] = 12;
                lcd_clear();
                lcd_puts("Right"); 
                break;
            }
        } 
            
        delay_ms(1000);
        lcd_gotoxy(0, 0);          
        lcd_puts("angle(= for set)"); 
        deg = 0;   
        
        while(k != 14)
        {
            k = key();
            if(k != 14)
                deg *= 10;
            if(!(k >= 10 && k <= 15))
            {
                deg += k;
                //lcd_gotoxy(0,1);
                lcd_putchar(k + 48);           
            }
            while(PINC.4 == 0 || PINC.5 == 0 || PINC.6 == 0 || PINC.7 == 0);      
        }
         
        deg = scaleTo360(deg);
        lcd_clear();
        sprintf(d, "degree: %d", deg);
        lcd_puts(d); 
        
        while(phase < deg)
        {
            for(k = 0; (k < 4 && phase < deg); k++)
            {
                phase += 1.8;
                PORTD = step[k];
                delay_ms(100);
            }
        }
        phase = 0;
        lcd_clear();
        lcd_puts("End");
        lcd_gotoxy(0, 1);
        lcd_puts(d);
        delay_ms(2000);
    }
}


int key()
{
    int i, kp;
    for(i = 0; ;i++)
    {
        PORTC = 0xff & ~(1 << i);
        delay_ms(10);
        if(i == 3)
            i =- 1; 
        kp = keypad();
        if(kp >= 0 && kp <= 15)
            return kp;    
    }
}



int keypad()
{
    if( (PINC.0 == 0) && (PINC.4 == 0) )
        return 7;
    else if( (PINC.0 == 0) && (PINC.5 == 0) )
        return 8;
    else if( (PINC.0 == 0) && (PINC.6 == 0) )
        return 9;
    else if( (PINC.0 == 0) && (PINC.7 == 0) )
        return 10; //÷
    else if( (PINC.1 == 0) && (PINC.4 == 0) )
        return 4;                      
    else if( (PINC.1 == 0) && (PINC.5 == 0) )
        return 5;                
    else if( (PINC.1 == 0) && (PINC.6 == 0) )
        return 6;                
    else if( (PINC.1 == 0) && (PINC.7 == 0) )
        return 11; //×        
    else if( (PINC.2 == 0) && (PINC.4 == 0) )
        return 1;
    else if( (PINC.2 == 0) && (PINC.5 == 0) )
        return 2;
    else if( (PINC.2 == 0) && (PINC.6 == 0) )
        return 3;                
    else if( (PINC.2 == 0) && (PINC.7 == 0) )
        return 12; //-                     
    else if( (PINC.3 == 0) && (PINC.4 == 0) )
        return 13; //on/c                    
    else if( (PINC.3 == 0) && (PINC.5 == 0) )
        return 0;                
    else if( (PINC.3 == 0) && (PINC.6 == 0) )
        return 14; //=              
    else if( (PINC.3 == 0) && (PINC.7 == 0) )
        return 15; //+
    else
        return -1;
}


int scaleTo360(int x)
{
    if(x < 360)
        return x;
    return scaleTo360(x - 360);
}