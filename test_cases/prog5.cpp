#include<iostream>
using namespace std;
void main(){
    int i = 2;
	int A[3];
   switch (i) {
       case 0:   A[0] = -1;
	          break;
        case 1:  break;
        case 2:   A[2] = 1;
        default:  A[0] = -1;
                  break;
    }
	cout<<A[i]<<endl;
	
	
}