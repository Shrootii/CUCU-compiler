int i= 2+3;
//int a;
int a;

int func(int k);
/*initialize*/

int math(int a, int b, int c){
    return a+b*c;
}

int func (int k){
    k = math(2,3,5);
    return k;
}
