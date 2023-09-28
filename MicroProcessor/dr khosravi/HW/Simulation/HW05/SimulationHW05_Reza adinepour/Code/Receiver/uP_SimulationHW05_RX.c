#include <mega32.h>
#include <alcd.h>
#include <stdio.h>
#include <delay.h>


unsigned char cm;

void main(void)
{
    DDRA = 0x00;
    PORTA = 0x00;
    
    DDRB = 0x00;
    PORTB = 0x00;
    
    DDRC = 0x0ff;
    PORTC = 0x00;
    
    DDRD = 0x00;
    PORTD = 0x00;
    
    // USART initialization
    // Communication Parameters: 8 Data, 1 Stop, No Parity
    // USART Receiver: On
    // USART Transmitter: Off
    // USART Mode: Asynchronous
    // USART Baud Rate: 9600
    UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
    UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
    UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
    UBRRH=0x00;
    UBRRL=0x33;

    lcd_init(16);

    while (1)
    {
        cm = getchar();
        switch(cm)
        {
            case 'A':
                lcd_clear();
                lcd_putchar('A');
                PORTC = 0xff;
            break;
            
            case 'L':
                lcd_clear();
                lcd_putchar('L');
                PORTC = 0x00;
            break;
            
            case 'P':
                lcd_clear();
                lcd_putchar('P');
                cm = getchar();
                switch(cm)
                {
                    case 0:
                        lcd_putchar('0');
                        cm = getchar();
                        switch(cm)
                        {
                            case 'O':
                                lcd_putchar('O');
                                cm = getchar();
                                switch(cm)
                                {
                                    case 'N':
                                        lcd_putchar('N');
                                        PORTC.0 = 1;
                                    break;
                                    
                                    case 'F':
                                        lcd_putchar('F');
                                        PORTC.0 = 0;
                                    break;    
                                }
                            break;
                            
                            case 0:
                                lcd_putchar('B');
                                cm = getchar();
                                switch(cm)
                                {
                                    case 'L':
                                        lcd_putchar('L');
                                        while(cm == 'L')
                                        {
                                            PORTC.0 = 1;
                                            delay_ms(150);
                                            PORTC.0 = 0;
                                            delay_ms(150);    
                                        }
                                               
                                }
                            break;
                        }    
                    break;
                    
                    case 1:
                        lcd_putchar('1');
                        cm = getchar();
                            switch(cm)
                            {
                                case 'O':
                                    lcd_putchar('O');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'N':
                                            lcd_putchar('N');
                                            PORTC.1 = 1;
                                        break;
                                        
                                        case 'F':
                                            lcd_putchar('F');
                                            PORTC.1 = 0;
                                        break;
                                            
                                    }
                                break;
                                
                                case 0:
                                    lcd_putchar('B');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'L':
                                            lcd_putchar('L');
                                            while(cm == 'L')
                                            {
                                                PORTC.1 = 1;
                                                delay_ms(150);
                                                PORTC.1 = 0;
                                                delay_ms(150);    
                                            }       
                                    }
                                break;
                                
                                
                            }
                                
                    break;
                    
                    case 2:
                        lcd_putchar('2');
                        cm = getchar();
                            switch(cm)
                            {
                                case 'O':
                                    lcd_putchar('O');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'N':
                                            lcd_putchar('N');
                                            PORTC.2 = 1;
                                        break;
                                        
                                        case 'F':
                                            lcd_putchar('F');
                                            PORTC.2 = 0;
                                        break;    
                                    }
                                break;
                                
                                case 0: 
                                    lcd_putchar('B');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'L':
                                            lcd_putchar('L');
                                            while(cm == 'L')
                                            {
                                                PORTC.2 = 1;
                                                delay_ms(150);
                                                PORTC.2 = 0;
                                                delay_ms(150);    
                                            } 
                                        break;      
                                    }          
                            break;
                            }
                    case 3:
                        lcd_putchar('3');
                        cm = getchar();
                            switch(cm)
                            {
                                case 'O':
                                    lcd_putchar('O');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'N':
                                            lcd_putchar('N');
                                            PORTC.3= 1;
                                        break;
                                        
                                        case 'F':
                                            lcd_putchar('F');
                                            PORTC.3= 0;
                                        break;    
                                    }
                                break;
                                
                                case 0:
                                    lcd_putchar('B');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'L':
                                            lcd_putchar('L');
                                            while(cm == 'L')
                                            {
                                                PORTC.3 = 1;
                                                delay_ms(150);
                                                PORTC.3 = 0;
                                                delay_ms(150);    
                                            } 
                                        break;      
                                    }
                            }    
                    break;
                    
                    case 4:
                        lcd_putchar('4');
                        cm = getchar();
                            switch(cm)
                            {
                                case 'O':
                                    lcd_putchar('O');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'N':
                                            lcd_putchar('N');
                                            PORTC.4 = 1;
                                        break;
                                        
                                        case 'F':
                                            lcd_putchar('F');
                                            PORTC.4 = 0;
                                        break;    
                                    }
                                break;
                                
                                case 0:
                                    lcd_putchar('B');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'L':
                                            lcd_putchar('L');
                                            while(cm == 'L')
                                            {
                                                PORTC.4 = 1;
                                                delay_ms(150);
                                                PORTC.4 = 0;
                                                delay_ms(150);    
                                            } 
                                        break;      
                                    }
                            }
                    break;
                    
                    case 5: 
                        lcd_putchar('5');
                        cm = getchar();
                            switch(cm)
                            {
                                case 'O':
                                    lcd_putchar('O');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'N':
                                            lcd_putchar('N');
                                            PORTC.5 = 1;
                                        break;
                                        
                                        case 'F':
                                            lcd_putchar('F');
                                            PORTC.5 = 0;
                                        break;    
                                    }
                                break;
                                
                                case 0:
                                    lcd_putchar('B');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'L':
                                            lcd_putchar('L');
                                            while(cm == 'L')
                                            {
                                                PORTC.5 = 1;
                                                delay_ms(150);
                                                PORTC.5 = 0;
                                                delay_ms(150);    
                                            } 
                                        break;      
                                    }
                            }    
                    break;
                    
                    case 6:
                        lcd_putchar('6');
                        cm = getchar();
                            switch(cm)
                            {
                                case 'O':
                                    lcd_putchar('O');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'N':
                                            lcd_putchar('N');
                                            PORTC.6 = 1;
                                        break;
                                        
                                        case 'F':
                                            lcd_putchar('F');
                                            PORTC.6 = 0;
                                        break;    
                                    }
                                break;
                                
                                case 0:
                                    lcd_putchar('B');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'L':
                                            lcd_putchar('L');
                                            while(cm == 'L')
                                            {
                                                PORTC.6 = 6;
                                                delay_ms(150);
                                                PORTC.6 = 6;
                                                delay_ms(150);    
                                            } 
                                        break;      
                                    }
                            }    
                    break;
                    
                    case 7:
                        lcd_putchar('7');
                        cm = getchar();
                            switch(cm)
                            {
                                case 'O':
                                    lcd_putchar('O');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'N':
                                            lcd_putchar('N');
                                            PORTC.7 = 1;
                                        break;
                                        
                                        case 'F':
                                            lcd_putchar('F');
                                            PORTC.7 = 0;
                                        break;    
                                    }
                                break;
                                
                                case 0:
                                    lcd_putchar('B');
                                    cm = getchar();
                                    switch(cm)
                                    {
                                        case 'L':
                                            lcd_putchar('L');
                                            while(cm == 'L')
                                            {
                                                PORTC.7 = 1;
                                                delay_ms(150);
                                                PORTC.7 = 0;
                                                delay_ms(150);    
                                            }      
                                    }
                            }    
                    break;  
                }
            break;
            
            case 7:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 8:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 9:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 4:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 5:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 6:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 1:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 2:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 3:
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break; 
            
            case 'O':
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 'N':
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 'B':
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;
            
            case 'F':
                lcd_clear();
                lcd_puts("Invalid Command");
                delay_ms(2000);
                lcd_clear();
            
            break;          
        }//End Main Switch()    
    }//End While(1)
}//End Main()
