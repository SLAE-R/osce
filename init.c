// init: The initial user-level program

#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

char *argv[] = { "sh", 0 };

int
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n");
    sleep(10);
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
      exit(EXIT_STATUS_OK);
    }
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit(EXIT_STATUS_OK);
    }
    while((wpid=wait(0)) >= 0 && wpid != pid)
      printf(1, "zombie! pid =%d\n", pid);
  }
}
