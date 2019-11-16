#include<iostream>
using namespace std;
void main(){
int i = 7, j = 5 ,k =7;
if ( (i == j) || (i == k) )
 i++; 
else 
 j--; 
j = i + k ;
cout<<i<<'\t'<<j<<'\t'<<k<<endl;	
}