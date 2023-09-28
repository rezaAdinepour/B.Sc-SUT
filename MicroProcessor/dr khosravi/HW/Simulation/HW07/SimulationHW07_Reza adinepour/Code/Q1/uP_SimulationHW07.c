#include <mega32.h>
#include <i2c.h>
#include <alcd.h>
#include <stdio.h>
#include <delay.h>


unsigned int i = 210;
unsigned char str[2], j = 0, k = 0, e, z = 0, setPass, correctPass[4], code[4], flag = 2;



void byteWrite(unsigned char deviceAddres, unsigned int addres, unsigned char data)
{
    unsigned char lowAddres, highAddres;
    lowAddres = addres;
    highAddres = (addres >> 8);
    deviceAddres <<= 1;
    i2c_start();
    i2c_write(deviceAddres);
    i2c_write(highAddres);
    i2c_write(lowAddres);
    i2c_write(data);
    i2c_stop();
    delay_ms(10);  
}


unsigned char randomRead(unsigned char deviceAddres, unsigned int addres)
{
    unsigned char lowAddres, highAddres, read;
    lowAddres = addres;
    highAddres = (addres >> 8);
    deviceAddres <<= 1;
    i2c_start();
    i2c_write(deviceAddres);
    i2c_write(highAddres);
    i2c_write(lowAddres);
    i2c_start();
    i2c_write(deviceAddres | 1);
    read = i2c_read(0);
    i2c_stop();
    delay_ms(10);
    return read;  
}


interrupt [EXT_INT0] void ext_int0_isr(void)
{
    if(setPass == 0)
    {
        correctPass[j] = PINC & 0x0f;
        switch(correctPass[j])
        {
            case 0: 
                correctPass[j] = 7;
                lcd_putchar('7');
                break;
            case 1: 
                correctPass[j] = 4;
                lcd_putchar('4');
                break;
            case 2: 
                correctPass[j] = 1;
                lcd_putchar('1');
                break;
            case 3: 
                correctPass[j] = 0;
                lcd_putchar('0');
                break;
            case 4: 
                correctPass[j] = 8;
                lcd_putchar('8');
                break;
            case 5: 
                correctPass[j] = 5;
                lcd_putchar('5');
                break;
            case 6: 
                correctPass[j] = 2;
                lcd_putchar('2');
                break;
            case 7: 
                correctPass[j] = 0;
                lcd_putchar('0');
                break;
            case 8: 
                correctPass[j] = 9;
                lcd_putchar('9');
                break;
            case 9: 
                correctPass[j] = 6;
                lcd_putchar('6');
                break;
            case 10: 
                correctPass[j] = 3;
                lcd_putchar('3');
                break;
            case 11: 
                correctPass[j] = '=';
                lcd_putchar('=');
                break;
            case 12: 
                correctPass[j] = '/';
                lcd_putchar('/');
                break;
            case 13: 
                correctPass[j] = '*';
                lcd_putchar('*');
                break;
            case 14: 
                correctPass[j] = '-';
                lcd_putchar('-');
                break;
            case 15: 
                correctPass[j] = '+';
                lcd_putchar('+'); 
        }
        j++;
    } 
        
    if(flag == 0)
    {
        code[k] = PINC & 0x0f;
        switch(code[k])
        {
            case 0: 
                code[k] = 7;
                lcd_putchar('7');
                break;
            case 1: 
                code[k] = 4;
                lcd_putchar('4');
                break;
            case 2: 
                code[k] = 1;
                lcd_putchar('1');
                break;
            case 3:
                code[k] = 0;
                lcd_putchar('0');
                break;
            case 4: 
                code[k] = 8;
                lcd_putchar('8');
                break;
            case 5: 
                code[k] = 5;
                lcd_putchar('5');
                break;
            case 6: 
                code[k] = 2;
                lcd_putchar('2');
                break;
            case 7: 
                code[k] = 0;
                lcd_putchar('0');
                break;
            case 8: 
                code[k] = 9;
                lcd_putchar('9');
                break;
            case 9: 
                code[k] = 6;
                lcd_putchar('6');
                break;
            case 10: 
                code[k] = 3;
                lcd_putchar('3');
                break;
            case 11: 
                code[k] = '=';
                lcd_putchar('=');
                break;
            case 12: 
                code[k] = '/';
                lcd_putchar('/');
                break;
            case 13: 
                code[k] = '*';
                lcd_putchar('*');
                break;
            case 14: 
                code[k] = '-';
                lcd_putchar('-');
                break;
            case 15: 
                code[k] = '+';
                lcd_putchar('+'); 
        }
            k++;
    }
}

void main(void)
{
    DDRA = 0x00;
    PORTA = 0x00; 
    
    DDRB = 0x00;
    PORTB = 0x00;
    
    DDRC = 0x00;
    PORTC = 0x00;
    
    DDRD = 0x00;
    PORTD = 0x00;

    // External Interrupt(s) initialization
    // INT0: On
    // INT0 Mode: Falling Edge
    // INT1: Off
    // INT2: Off
    GICR|=(0<<INT1) | (1<<INT0) | (0<<INT2);
    MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
    MCUCSR=(0<<ISC2);
    GIFR=(0<<INTF1) | (1<<INTF0) | (0<<INTF2);

    // Bit-Banged I2C Bus initialization
    // I2C Port: PORTA
    // I2C SDA bit: 1
    // I2C SCL bit: 0
    // Bit Rate: 100 kHz
    // Note: I2C settings are specified in the
    // Project|Configure|C Compiler|Libraries|I2C menu.
    i2c_init();

    lcd_init(16);

    #asm("sei")
    
    
    for(i = 210; i <= 213; i++)
    {
        byteWrite(0x50, i, 0);   
    }  
    
    if((randomRead(0x50, 210) == 0) &&  (randomRead(0x50, 211) == 0) && (randomRead(0x50, 212) == 0) && (randomRead(0x50, 213) == 0))
    {
        setPass = 0;   
        lcd_gotoxy(0, 0);
        lcd_putsf("Welcome");
        lcd_gotoxy(0, 1);
        lcd_putsf("SetPassword:");
    }
    

    while (1)
    {
        if(j == 4)
        {          
            j = 0;
            setPass = 1;
            byteWrite(0x50, 210, correctPass[0]);
            byteWrite(0x50, 211, correctPass[1]);
            byteWrite(0x50, 212, correctPass[2]);
            byteWrite(0x50, 213, correctPass[3]);
            lcd_clear();
            lcd_gotoxy(0, 0);
            lcd_putsf("Verify Password");
            delay_ms(3000);
            lcd_clear();
            lcd_gotoxy(1, 0);
            lcd_putsf("Enter Password:");
            flag = 0;   
        }
        if(k == 4)
        {
            k = 0;
            flag = 1;
            if( (code[0] == randomRead(0x50, 210)) && (code[1] == randomRead(0x50, 211)) && (code[2] == randomRead(0x50, 212)) && (code[3] == randomRead(0x50, 213)) )
            {
                lcd_gotoxy(0, 1);
                lcd_putsf("Login Succeeded!");
                delay_ms(3000);
                lcd_clear();
                lcd_gotoxy(1, 0);
                lcd_putsf("Enter Password:");
                flag = 0;
            }
            else
            {
                lcd_gotoxy(0, 1);
                lcd_putsf("Login Failed!");
                delay_ms(3000);
                lcd_clear();
                lcd_gotoxy(1, 0);
                lcd_putsf("Enter Password:");
                flag = 0;
                z++;
                if(z == 3)
                {
                    z = 0;
                    lcd_clear();
                    lcd_gotoxy(0, 0);
                    lcd_puts("SystemLocked!");
                    for(e = 10; e > 0; e--)
                    {
                        flag = 1;
                        lcd_gotoxy(14, 0);
                        sprintf(str, "%2d", e);
                        lcd_puts(str);
                        delay_ms(1000);    
                    }
                    lcd_clear();
                    lcd_gotoxy(1, 0);
                    lcd_putsf("Enter Password:");
                    flag = 0;
                }
            }
            
        }
    }//End While(1)
}//End main()
