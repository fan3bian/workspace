#include <stdio.h>
void main() {

	int n;
	while (~scanf("%d",&n)) {//~λ���㣺ȡ�� 
	int stockValue = 1;//��Ʊ��ֵ��ʼֵ=1
	int fallDay = 3;//��Ʊ�µ�������
	int fallInterval =3;//��Ʊ�µ����ڵļ��
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
