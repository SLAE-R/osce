#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
//#include "procstat.h"


int
main(int argc, char *argv[])
{
   struct procstat p_stat;
   int pid = getpid();
   if (argc > 1) {
      pid = atoi(argv[1]);
   }
   if (pstat(pid,&p_stat) == -1) {
      printf(1,"BALAGAN! %s\n",argv[1]);
   } else {
     printf(1,p_stat.name);
     printf(1,"\nSize: %d\nNum of files: %d\nState value: %d\nPID: %d\n",p_stat.sz,p_stat.nofile,p_stat.state,pid);

   }

   exit(0);
}
