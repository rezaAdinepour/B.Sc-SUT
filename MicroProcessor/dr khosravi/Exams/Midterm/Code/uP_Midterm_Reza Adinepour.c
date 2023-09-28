#include <mega32.h>
#include <delay.h>

unsigned char p = 127;

interrupt [TIM0_OVF] void timer1_ovf_isr(void)
{
    if(PINA.0 == 0 && PINA.1 == 0)
    {
        OCR0 = p;
    }
    if(PINA.1 == 0 && PINA.1 == 0)
    {
        OCR0 = p;
        p = 205;
        TCNT0 = 105;
    }
    
    TCNT1 = 105;       
}

void main(void)
{
    DDRA = 0x00;
    PORTA = 0xff;
    
    DDRB = 0xff;
    PORTB = 0x00;
    
    TCCR0=(1<<WGM00) | (1<<COM01) | (0<<COM00) | (1<<WGM01) | (0<<CS02) | (1<<CS01) | (1<<CS00);
    TCNT0=0x00;
    OCR0=0x00;

    
    TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);

#asm("sei")

    while (1)
    {
    }
}
