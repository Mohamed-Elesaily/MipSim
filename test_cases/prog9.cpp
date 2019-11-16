#include<iostream>
using namespace std;
int fib(void){
    int n =8;
    int f1 = 1,f2 = -1;
    while(n !=0){
        f1 = f1 + f2;
        f2 = f1 - f2;
        n--;
    }
    return f1;
}
int main(){
    int a = fib();
    cout<<a<<endl;

	return 0;
	}
