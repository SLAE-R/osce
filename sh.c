// Shell.

#include "types.h"
#include "user.h"
#include "fcntl.h"
#include "stat.h"

// Parsed command representation
#define EXEC  1
#define REDIR 2
#define PIPE  3
#define LIST  4
#define BACK  5

#define MAXARGS 10
#define FOREGROUND	1
#define BACKGROUND	2


struct job *getJob(int jobId , int inputFd, char* buf);
struct jobprocess *getProcess(int pid);
void addProcessToJob(struct job *job , int pid);
struct job *clearJobList(struct job *head);
struct jobprocess *clearZombieProcesses(struct jobprocess *head);
struct job *findForegroundJob(struct job *head);
struct job *findJobById(struct job *head , int pid);
void printAllJobs(struct job * head);


static char *states[] = {
	  [UNUSED]    "UNUSED",
	  [EMBRYO]    "EMBRYO",
	  [SLEEPING]  "SLEEP",
	  [RUNNABLE]  "RUNNABLE",
	  [RUNNING]   "RUNNING",
	  [ZOMBIE]    "ZOMBIE"
};

struct job{
	int id;
	struct job *nextjob;
	struct jobprocess *headOfProcesses;
	int jobInFd;
	int type;
	char* cmd;
};

struct jobprocess{
	int pid;
	struct jobprocess *nextProcess;
};

struct cmd {
  int type;
};

struct execcmd {
  int type;
  char *argv[MAXARGS];
  char *eargv[MAXARGS];
};

struct redircmd {
  int type;
  struct cmd *cmd;
  char *file;
  char *efile;
  int mode;
  int fd;
};

struct pipecmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct listcmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct backcmd {
  int type;
  struct cmd *cmd;
};

int fork1(void);  // Fork but panics on failure.
void panic(char*);
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd , int fdToShell)
{
  int p[2];
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit(EXIT_STATUS_OK);
  
  switch(cmd->type){
  default:
    panic("runcmd");

  case EXEC:
	  if (fork1() == 0){
		 ecmd = (struct execcmd*)cmd;
		 if(ecmd->argv[0] == 0)
		   exit(EXIT_STATUS_OK);
		 char buf[sizeof(int)];
		 int pid = getpid();
		 strcpy(buf , (char*)&pid);
		 write(fdToShell , buf, strlen(buf));
		 close(fdToShell);

		 exec(ecmd->argv[0], ecmd->argv);
		 printf(2, "exec %s failed\n", ecmd->argv[0]);
	  }
	  close(fdToShell);
	  wait(0);
     break;

   case REDIR:
     rcmd = (struct redircmd*)cmd;
     close(rcmd->fd);
     if(open(rcmd->file, rcmd->mode) < 0){
       printf(2, "open %s failed\n", rcmd->file);
       exit(EXIT_STATUS_OK);
     }
     runcmd(rcmd->cmd,fdToShell);
     break;

   case LIST:
     lcmd = (struct listcmd*)cmd;
     if(fork1() == 0)
       runcmd(lcmd->left,fdToShell);
     wait(0);
     runcmd(lcmd->right,fdToShell);
     break;

   case PIPE:
     pcmd = (struct pipecmd*)cmd;
     if(pipe(p) < 0)
       panic("pipe");
     if(fork1() == 0){
       close(1);
       dup(p[1]);
       close(p[0]);
       close(p[1]);
       runcmd(pcmd->left,fdToShell);
     }
     if(fork1() == 0){
       close(0);
       dup(p[0]);
       close(p[0]);
       close(p[1]);
       runcmd(pcmd->right,fdToShell);
     }
     close(p[0]);
     close(p[1]);
     close(fdToShell);
     wait(0);

     wait(0);
     break;

   case BACK:
     bcmd = (struct backcmd*)cmd;
//     if (fork1() == 0)
    	 runcmd(bcmd->cmd,fdToShell);
//     close(fdToShell);
     break;
  }
  exit(EXIT_STATUS_OK);
}

int
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}

int
main(void)
{
  static char buf[100];
  int fd;
  struct job *jobsHead = 0;
  struct job *foregroungJob = 0;

  int jobCount = 0;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
	 jobsHead = clearJobList(jobsHead);
	 foregroungJob = findForegroundJob(jobsHead);

	if (foregroungJob != 0){
		//TODO pass to pipe entered data
		printf(1, "Received INPUT = %s" , buf);
		write(foregroungJob->jobInFd , buf, strlen(buf));
		continue;
	}

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }

    if(buf[0] == 'j' && buf[1] == 'o' && buf[2] == 'b' && buf[3] == 's'){
    	printAllJobs(jobsHead);
    	continue;
    }

    if(buf[0] == 'f' && buf[1] == 'g' && buf[2] == ' '){
        buf[strlen(buf)-1] = 0;  // chop \n
        int pid = atoi(buf + 3);
        struct job *findedJob = findJobById(jobsHead , pid);
        findedJob->type = FOREGROUND;
    	continue;
    }

    if(buf[0] == 'f' && buf[1] == 'g'){
        jobsHead->type = FOREGROUND;
    	continue;
    }

	int jobPids[2],jobInput[2];

	if(pipe(jobPids) < 0)
	  panic("jobPids error");

	if(pipe(jobInput) < 0)
	  panic("jobInput error");

	jobCount++;
	struct job *newJob = getJob(jobCount , jobInput[1], buf);
	struct cmd *newcmd = parsecmd(buf);

	if (newcmd->type == BACK){
		newJob->type = BACKGROUND;
	}


	if(jobsHead == 0){
		jobsHead = newJob;
	}
	else {
		newJob->nextjob = jobsHead;
		jobsHead = newJob;
	}

	if(fork1() == 0)
	{
		close(0);
		dup(jobInput[0]);

		close(jobInput[0]);
		close(jobInput[1]);
		close(jobPids[0]);

		runcmd(newcmd , jobPids[1]);
	}
	else{
		close(jobInput[0]);
		close(jobPids[1]);

		char pidBuf[sizeof(int)];
		while (read(jobPids[0] , pidBuf , sizeof(pidBuf)) > 0 ){
			int recievedPid = (int)*pidBuf;
			addProcessToJob(newJob , recievedPid);
		}
		close(jobPids[0]);
	}
	//wait(0);
  }
  exit(EXIT_STATUS_OK);
}


void printAllJobs(struct job * head){
	struct job* currentJob = head;
	if (head == 0) {
		printf(2, "There are no jobs\n");
		return;
	}
	while (currentJob!=0){
		struct jobprocess* currentProc = currentJob->headOfProcesses;
		printf(2, "Job %d: %s", currentJob->id, currentJob->cmd);
		while (currentProc != 0 ){
			struct procstat stat;
			if (pstat(currentProc->pid, &stat) == 0){
				printf(2, "%d: %s %d %d %s\n", currentProc->pid, stat.name, stat.sz, stat.nofile, states[stat.state]);
			}
			currentProc = currentProc->nextProcess;
		}
		currentJob = currentJob->nextjob;
	}
	return;
}

void addProcessToJob(struct job *job , int pid){
	struct jobprocess *newProcess = getProcess(pid);
	newProcess->nextProcess = job->headOfProcesses;
	job->headOfProcesses = newProcess;

	printf(1, "Added process id = %d to Job id = %d\n", newProcess->pid, job->id);

}

struct job *findJobById(struct job *head , int pid){
	struct job* currentJob = head;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
		if (currentJob->id == pid){
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return currentJob;
}

struct job *findForegroundJob(struct job *head){
	struct job* currentJob = head;
	struct job* foregroundJob = 0;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
		if (currentJob->type == FOREGROUND){
			foregroundJob = currentJob;
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return foregroundJob;
}

struct job *clearJobList(struct job *head){
	printf(1, "---->>>> Entering clearJobs\n");

	if (head == 0){
		return head;
	}

	struct job *currentJob = head;
	struct job *newHead = 0;
	struct job *foregroundJob = 0;

	while (newHead == 0 && currentJob != 0){
		struct job *temp = currentJob->nextjob;
		currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
		if (currentJob->headOfProcesses == 0){
			printf(1, "deleting job id = %d\n", currentJob->id );

			free(currentJob->cmd);
			printf(1, "command deleted from head search\n" );

			free(currentJob);
		}
		else {
			newHead = currentJob;
			printf(1, "new Head Jobs id = %d\n", newHead->id );

			if (currentJob->type == FOREGROUND){
				foregroundJob = currentJob;
				printf(1, "Foreground job id = %d\n", foregroundJob->id);

			}
		}
		currentJob = temp;
	}

	if(newHead != 0){
		currentJob = newHead->nextjob;
		struct job *prevJob = newHead;

		while (currentJob != 0){
			currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
			if (currentJob->headOfProcesses == 0){
				prevJob->nextjob = currentJob->nextjob;

				printf(1, "deleting job id = %d\n", currentJob->id );

				free(currentJob->cmd);
				printf(1, "command deleted\n" );

				free(currentJob);
				printf(1, "job deleted after command deleted\n" );

				if (prevJob->nextjob != 0){
					currentJob = prevJob->nextjob->nextjob;
				}
				else {
					currentJob = 0;
				}
			}
			else {
				prevJob = currentJob;
				currentJob = currentJob->nextjob;
				if (prevJob->type == FOREGROUND){
					foregroundJob = prevJob;
					printf(1, "Foreground job id = %d\n", foregroundJob->id);

				}
			}
		}
	}
	return newHead;

}

struct jobprocess *clearZombieProcesses(struct jobprocess *head){
	struct jobprocess *currentProcess = head;
	struct jobprocess *newHead = 0;

	if (head == 0){
		return head;
	}

	while (newHead == 0  && currentProcess != 0){
		struct jobprocess *temp = currentProcess->nextProcess;
		struct procstat stat;

		if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
			printf(1, "deleting process id = %d\n", currentProcess->pid );
			free(currentProcess);
		}
		else {
			newHead = currentProcess;
		}
		printf(1, "current = temp ,  pointer to temp = %p\n", temp );

		currentProcess = temp;
	}

	if(newHead != 0){
		currentProcess = newHead->nextProcess;
		struct jobprocess *prevProcess = newHead;

		while (currentProcess != 0){
			struct procstat stat;

			if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
				prevProcess->nextProcess = currentProcess->nextProcess;

				printf(1, " --- deleting process id = %d\n", currentProcess->pid );

				free(currentProcess);
				currentProcess = prevProcess->nextProcess->nextProcess;
			}
			else {
				prevProcess = currentProcess;
				currentProcess = currentProcess->nextProcess;
			}
		}
	}
	return newHead;
}


struct job *getJob(int jobId , int inputFd, char* buf){
	struct job *newJob;

	newJob = malloc(sizeof(*newJob));
	memset(newJob, 0, sizeof(*newJob));
	newJob->id = jobId;
	newJob->nextjob = 0;// NULL
	newJob->headOfProcesses = 0; //NULL
	newJob->jobInFd = inputFd ;
	newJob->type = FOREGROUND;

	newJob->cmd = malloc(strlen(buf));
	strcpy(newJob->cmd, buf);
	printf(1, "Created new job id = %d\n", newJob->id);

	return newJob;
}

struct jobprocess *getProcess(int pid){
	struct jobprocess *newProcess;

	newProcess = malloc(sizeof(*newProcess));
	memset(newProcess, 0, sizeof(*newProcess));
	newProcess->pid = pid;
	newProcess->nextProcess = 0;

	return newProcess;
}

void
panic(char *s)
{
  printf(2, "%s\n", s);
  exit(EXIT_STATUS_OK);
}

int
fork1(void)
{
  int pid;
  
  pid = fork();
  if(pid == -1)
    panic("fork");
  return pid;
}

//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
  cmd->cmd = subcmd;
  cmd->file = file;
  cmd->efile = efile;
  cmd->mode = mode;
  cmd->fd = fd;
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
  cmd->cmd = subcmd;
  return (struct cmd*)cmd;
}
//PAGEBREAK!
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
  case '|':
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
}

struct cmd *parseline(char**, char*);
struct cmd *parsepipe(char**, char*);
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
  int i;
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    nulterminate(pcmd->left);
    nulterminate(pcmd->right);
    break;
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
