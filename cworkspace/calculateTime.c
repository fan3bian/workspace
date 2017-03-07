#include <stdio.h>
#include <time.h>
void main(){
//	clock_t begin = clock(); 
//	for (int i=0;i<10000;i++){
//		printf("number : d%",i); 
//	} 
//	clock_t end = clock(); 
//	double interval = (double)(end - begin) / CLOCKS_PER_SEC; 
//	printf("The interval is %d"); 
 	int i=8;
    printf("The raw value: i=%d\n", i);
    printf("++i=%d\n \n++i=%d ",++i);
    printf("++i=%d \n++i=%d \n--i=%d \n--i=%d\n",++i,++i,--i,--i);
} 
