#include <stdio.h>
void main() {

	int n;
	while (~scanf("%d",&n)) {//~位运算：取反 
	int stockValue = 1;//股票价值初始值=1
	int fallDay = 3;//股票下跌的日期
	int fallInterval =3;//股票下跌日期的间隔
		if(n==1) {
			printf("%d\n",stockValue);
		} else {
			int i;
			for(i=2; i<=n; i++) {
				if(i==fallDay) {
					stockValue--;
					fallDay+=fallInterval;
					fallInterval++;
				} else {
					stockValue++;
				}
			}
			printf("%d\n",stockValue);
		}

	}
}
