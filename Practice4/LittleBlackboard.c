#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

int main(int argc, char *argv[]) {
	int limit = atoi(argv[2]), current = 9;
	char id[25], name[25];
	char opt;
	bool keep = true;
	FILE *f = fopen("Datalog.txt", "w");
	while (current < limit && keep) {
		printf("Introduzca el nombre del alumno %d:\n", current);
		scanf("%s", &name);
		printf("Introduzca el ID del alumno %d:\n", current);
		scanf("%s", &id);
		fprintf(f, "Name: %s\tID: %s\n", name, id);
		printf("Desea continuar? [y/n]\n");
		scanf(" %c", &opt);
		keep = opt == 'y';
		current++;
	}
	fclose(f);
	return 0;
}

