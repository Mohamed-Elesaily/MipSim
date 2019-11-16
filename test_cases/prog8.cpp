#include<iostream>
using namespace std;
void swap (int v[], int k)
{
int temp;
temp = v[k];
v[k] = v[k+1];
v[k+1] = temp;
}
void main(){
	int v[2] = {5,7};
	int k = 0;
	swap(v,k);
	cout<<v[0]<<'\t'<<v[1]<<endl;
	}