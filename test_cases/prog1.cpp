//c code
#include <iostream>
using namespace std;
void main(){
    int A[11];
	int i = 10;
	A[i/2] = 10;
    A[i] = A[i/2] + 1;
    A[i+1] = -1;
	cout<<A[i/2]<<'\t'<<A[i]<<'\t'<<A[i+1]<<endl;
}