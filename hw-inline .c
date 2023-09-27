#include <stdio.h>
unsigned int shld5(unsigned int a, unsigned int b);

int main(){
    unsigned int a,b;
    scanf("%u %u",&a,&b);
    printf("%u\n",shld5(a,b));
    return 0;
}

unsigned int shld5(unsigned int a, unsigned int b){
    unsigned int result;    
    asm(
        "shl $5,%%eax\n\t"
        "movb $32,%%cl\n\t"
        "movb $5,%%dl\n\t"
        "subb %%dl,%%cl\n\t"
        "shr %%cl,%%ebx\n\t"
        "orl %%ebx,%%eax\n\t"
        :"=a"(result)
        :"a"(a),"b"(b)
        :"edx","ecx"
    );
    return result;
}