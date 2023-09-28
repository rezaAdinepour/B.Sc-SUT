#include <mega32.h>
//#include <alcd.h>
#include <delay.h>
#include <stdio.h>



unsigned char code[17], i, flag = 0;


interrupt [EXT_INT0] void ext_int0_isr(void)
{
    if(flag == 0)
    {
        code[i] = PINA & 0x0f;
        switch(code[i])
        {
            case 0: 
                code[i] = 7;
                //lcd_putchar('7');
                putchar(code[i]);
            break;
            case 1: 
                code[i] = 4;
                //lcd_putchar('4');
                putchar(code[i]);
            break;
            case 2: 
                code[i] = 1;   
                //lcd_putchar('1');
                putchar(code[i]);
            break;
            case 3:
                code[i] = 'F';   
                //lcd_putchar('F');
                putchar(code[i]);
            break;
            case 4: 
                code[i] = 8;
                //lcd_putchar('8');
                putchar(code[i]);
            break;
            case 5: 
                code[i] = 5;  
                //lcd_putchar('5');
                putchar(code[i]);
            break;
            case 6: 
                code[i] = 2;
                //lcd_putchar('2');
                putchar(code[i]);
            break;
            case 7: 
                code[i] = 0;
                //lcd_putchar('0');
                putchar(code[i]);
            break;
            case 8: 
                code[i] = 9; 
                //lcd_putchar('9');
                putchar(code[i]);
            break;
            case 9: 
                code[i] = 6;
                //lcd_putchar('6');
                putchar(code[i]);
            break;
            case 10: 
                code[i] = 3;
                //lcd_putchar('3');
                putchar(code[i]);
            break;
            case 11: 
                code[i] = 'N';
                //lcd_putchar('N');
                putchar(code[i]);
            break;
            case 12: 
                code[i] = 'A';
                //lcd_putchar('A');
                putchar(code[i]);
            break;
            case 13: 
                code[i] = 'L';
                //lcd_putchar('L');
                putchar(code[i]);
            break;
            case 14: 
                code[i] = 'P';
                //lcd_putchar('P');
                putchar(code[i]);
            break;
            case 15: 
                code[i] = 'O';
                //lcd_putchar('O');
                putchar(code[i]); 
        }
        i++;
    }
        
}

#include <stdio.h>

void main(void)
{
    

    // External Interrupt(s) initialization
    // INT0: On
    // INT0 Mode: Falling Edge
    // INT1: Off
    // INT2: Off
    GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);
    MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
    MCUCSR=(0<<ISC2);
    GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);

    // USART initialization
    // Communication Parameters: 8 Data, 1 Stop, No Parity
    // USART Receiver: Off
    // USART Transmitter: On
    // USART Mode: Asynchronous
    // USART Baud Rate: 9600
    UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
    UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
    UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
    UBRRH=0x00;
    UBRRL=0x33;

    //lcd_init(16);

    #asm("sei")

    while (1)
    {
        if(i == 17)
        {
            i = 0;
            flag = 1;
            //lcd_clear();
            delay_ms(5000);
            flag = 0;
        }
    }
}
