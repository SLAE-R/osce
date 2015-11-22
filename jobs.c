#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int main(int argc, char *argv[]){
	printf(2, "Executing JOBS \n");

	struct backgroundjob *head = 0;

	if (argc > 0) {
	//	argptr(0, (char**)&head, sizeof(head));
		printf(1, "Received pointer is : %p\n", head);
	//	printf(1, "Received jobId is : %d\n", head->backgroundjob);
	}
	else {
		printf(1, "No Arguments\n");
	}

	return 123;
}

