#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	int l = atoi(argv[3]), w = atoi(argv[5]), res;
	if (strcmp(argv[1], "-a") == 0) {
		printf("area = ");
		res = l * w;
	} else if (strcmp(argv[1], "-p") == 0) {
		res = (2 * l) + (2 * w);
		printf("perimeter = ");
	}
	printf("%d\n", res);
	return 0;
}
