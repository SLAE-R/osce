#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int main(int argc, char *argv[]){
	//int send_exit;
	int status;
	status = 7;

	//send_exit = 5;
	if (fork()==0){
		//exit(send_exit);
	}
	else
	{
		wait(&status);
		printf(1,"status_is: %d \n",status);
	}
	return 9;
}
