#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

#define BUFFER_SIZE 256

int findLenghtOfInput(char *buf);
int isExit(char *buf);
int readFromConsole(char *buf, int bufSize);


int main(int argc, char *argv[]){
	char buf[BUFFER_SIZE];
	int shouldRun = 1;
	int index = 0;
	while(shouldRun){
		if (gets(buf, BUFFER_SIZE) > 0 && !isExit(buf)){
			printf(0, "Entered argument from command line was : ");
			int length = findLenghtOfInput(buf);
			for (index = 0; index < length; index++){
				printf(0, "%c", buf[index]);
			}
		}
		else {
			shouldRun = 0;
			printf(0, "Exiting prog ...\n");

		}
	}

	return 123;
}

int readFromConsole(char *buf, int bufSize){
	memset(buf, 0, bufSize);
	gets(buf, bufSize);
	if(buf[0] == 0) // EOF
		return -1;
	return 1;
}

int findLenghtOfInput(char *buf){
	int length = 0;
	while (buf[length] != '\0'){
		length++;
	}
	return length;
}

int isExit(char *buf){
	if (buf[0] == 'e' && buf[1] == 'x' && buf[2] == 'i' && buf[3] == 't'){
		return 1;
	}
	return 0;
}
