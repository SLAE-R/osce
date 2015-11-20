#ifndef PROCSTAT
#define PROCSTAT
enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };
struct procstat {
	char name[16];	// process name
	uint sz;		// size of memory
	uint nofile;	// amount of open file descriptors
	enum procstate state;	// process state
};
#endif
