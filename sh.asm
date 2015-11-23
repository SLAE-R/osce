
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd , int fdToShell)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 38             	sub    $0x38,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 0a                	jne    16 <runcmd+0x16>
    exit(EXIT_STATUS_OK);
       c:	83 ec 0c             	sub    $0xc,%esp
       f:	6a 01                	push   $0x1
      11:	e8 68 17 00 00       	call   177e <exit>
  
  switch(cmd->type){
      16:	8b 45 08             	mov    0x8(%ebp),%eax
      19:	8b 00                	mov    (%eax),%eax
      1b:	83 f8 05             	cmp    $0x5,%eax
      1e:	77 09                	ja     29 <runcmd+0x29>
      20:	8b 04 85 08 1d 00 00 	mov    0x1d08(,%eax,4),%eax
      27:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      29:	83 ec 0c             	sub    $0xc,%esp
      2c:	68 dc 1c 00 00       	push   $0x1cdc
      31:	e8 12 0c 00 00       	call   c48 <panic>
      36:	83 c4 10             	add    $0x10,%esp

  case EXEC:
	  if (fork1() == 0){
      39:	e8 2f 0c 00 00       	call   c6d <fork1>
      3e:	85 c0                	test   %eax,%eax
      40:	0f 85 97 00 00 00    	jne    dd <runcmd+0xdd>
		 ecmd = (struct execcmd*)cmd;
      46:	8b 45 08             	mov    0x8(%ebp),%eax
      49:	89 45 f4             	mov    %eax,-0xc(%ebp)
		 if(ecmd->argv[0] == 0)
      4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4f:	8b 40 04             	mov    0x4(%eax),%eax
      52:	85 c0                	test   %eax,%eax
      54:	75 0a                	jne    60 <runcmd+0x60>
		   exit(EXIT_STATUS_OK);
      56:	83 ec 0c             	sub    $0xc,%esp
      59:	6a 01                	push   $0x1
      5b:	e8 1e 17 00 00       	call   177e <exit>
		 char buf[sizeof(int)];
		 int pid = getpid();
      60:	e8 99 17 00 00       	call   17fe <getpid>
      65:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		 strcpy(buf , (char*)&pid);
      68:	83 ec 08             	sub    $0x8,%esp
      6b:	8d 45 d4             	lea    -0x2c(%ebp),%eax
      6e:	50                   	push   %eax
      6f:	8d 45 d8             	lea    -0x28(%ebp),%eax
      72:	50                   	push   %eax
      73:	e8 d6 14 00 00       	call   154e <strcpy>
      78:	83 c4 10             	add    $0x10,%esp
		 write(fdToShell , buf, strlen(buf));
      7b:	83 ec 0c             	sub    $0xc,%esp
      7e:	8d 45 d8             	lea    -0x28(%ebp),%eax
      81:	50                   	push   %eax
      82:	e8 36 15 00 00       	call   15bd <strlen>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	83 ec 04             	sub    $0x4,%esp
      8d:	50                   	push   %eax
      8e:	8d 45 d8             	lea    -0x28(%ebp),%eax
      91:	50                   	push   %eax
      92:	ff 75 0c             	pushl  0xc(%ebp)
      95:	e8 04 17 00 00       	call   179e <write>
      9a:	83 c4 10             	add    $0x10,%esp
		 close(fdToShell);
      9d:	83 ec 0c             	sub    $0xc,%esp
      a0:	ff 75 0c             	pushl  0xc(%ebp)
      a3:	e8 fe 16 00 00       	call   17a6 <close>
      a8:	83 c4 10             	add    $0x10,%esp

		 exec(ecmd->argv[0], ecmd->argv);
      ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
      ae:	8d 50 04             	lea    0x4(%eax),%edx
      b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
      b4:	8b 40 04             	mov    0x4(%eax),%eax
      b7:	83 ec 08             	sub    $0x8,%esp
      ba:	52                   	push   %edx
      bb:	50                   	push   %eax
      bc:	e8 f5 16 00 00       	call   17b6 <exec>
      c1:	83 c4 10             	add    $0x10,%esp
		 printf(2, "exec %s failed\n", ecmd->argv[0]);
      c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c7:	8b 40 04             	mov    0x4(%eax),%eax
      ca:	83 ec 04             	sub    $0x4,%esp
      cd:	50                   	push   %eax
      ce:	68 e3 1c 00 00       	push   $0x1ce3
      d3:	6a 02                	push   $0x2
      d5:	e8 21 18 00 00       	call   18fb <printf>
      da:	83 c4 10             	add    $0x10,%esp
	  }
	  close(fdToShell);
      dd:	83 ec 0c             	sub    $0xc,%esp
      e0:	ff 75 0c             	pushl  0xc(%ebp)
      e3:	e8 be 16 00 00       	call   17a6 <close>
      e8:	83 c4 10             	add    $0x10,%esp
	  wait(0);
      eb:	83 ec 0c             	sub    $0xc,%esp
      ee:	6a 00                	push   $0x0
      f0:	e8 91 16 00 00       	call   1786 <wait>
      f5:	83 c4 10             	add    $0x10,%esp
     break;
      f8:	e9 fa 01 00 00       	jmp    2f7 <runcmd+0x2f7>

   case REDIR:
     rcmd = (struct redircmd*)cmd;
      fd:	8b 45 08             	mov    0x8(%ebp),%eax
     100:	89 45 f0             	mov    %eax,-0x10(%ebp)
     close(rcmd->fd);
     103:	8b 45 f0             	mov    -0x10(%ebp),%eax
     106:	8b 40 14             	mov    0x14(%eax),%eax
     109:	83 ec 0c             	sub    $0xc,%esp
     10c:	50                   	push   %eax
     10d:	e8 94 16 00 00       	call   17a6 <close>
     112:	83 c4 10             	add    $0x10,%esp
     if(open(rcmd->file, rcmd->mode) < 0){
     115:	8b 45 f0             	mov    -0x10(%ebp),%eax
     118:	8b 50 10             	mov    0x10(%eax),%edx
     11b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     11e:	8b 40 08             	mov    0x8(%eax),%eax
     121:	83 ec 08             	sub    $0x8,%esp
     124:	52                   	push   %edx
     125:	50                   	push   %eax
     126:	e8 93 16 00 00       	call   17be <open>
     12b:	83 c4 10             	add    $0x10,%esp
     12e:	85 c0                	test   %eax,%eax
     130:	79 23                	jns    155 <runcmd+0x155>
       printf(2, "open %s failed\n", rcmd->file);
     132:	8b 45 f0             	mov    -0x10(%ebp),%eax
     135:	8b 40 08             	mov    0x8(%eax),%eax
     138:	83 ec 04             	sub    $0x4,%esp
     13b:	50                   	push   %eax
     13c:	68 f3 1c 00 00       	push   $0x1cf3
     141:	6a 02                	push   $0x2
     143:	e8 b3 17 00 00       	call   18fb <printf>
     148:	83 c4 10             	add    $0x10,%esp
       exit(EXIT_STATUS_OK);
     14b:	83 ec 0c             	sub    $0xc,%esp
     14e:	6a 01                	push   $0x1
     150:	e8 29 16 00 00       	call   177e <exit>
     }
     runcmd(rcmd->cmd,fdToShell);
     155:	8b 45 f0             	mov    -0x10(%ebp),%eax
     158:	8b 40 04             	mov    0x4(%eax),%eax
     15b:	83 ec 08             	sub    $0x8,%esp
     15e:	ff 75 0c             	pushl  0xc(%ebp)
     161:	50                   	push   %eax
     162:	e8 99 fe ff ff       	call   0 <runcmd>
     167:	83 c4 10             	add    $0x10,%esp
     break;
     16a:	e9 88 01 00 00       	jmp    2f7 <runcmd+0x2f7>

   case LIST:
     lcmd = (struct listcmd*)cmd;
     16f:	8b 45 08             	mov    0x8(%ebp),%eax
     172:	89 45 ec             	mov    %eax,-0x14(%ebp)
     if(fork1() == 0)
     175:	e8 f3 0a 00 00       	call   c6d <fork1>
     17a:	85 c0                	test   %eax,%eax
     17c:	75 15                	jne    193 <runcmd+0x193>
       runcmd(lcmd->left,fdToShell);
     17e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     181:	8b 40 04             	mov    0x4(%eax),%eax
     184:	83 ec 08             	sub    $0x8,%esp
     187:	ff 75 0c             	pushl  0xc(%ebp)
     18a:	50                   	push   %eax
     18b:	e8 70 fe ff ff       	call   0 <runcmd>
     190:	83 c4 10             	add    $0x10,%esp
     wait(0);
     193:	83 ec 0c             	sub    $0xc,%esp
     196:	6a 00                	push   $0x0
     198:	e8 e9 15 00 00       	call   1786 <wait>
     19d:	83 c4 10             	add    $0x10,%esp
     runcmd(lcmd->right,fdToShell);
     1a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1a3:	8b 40 08             	mov    0x8(%eax),%eax
     1a6:	83 ec 08             	sub    $0x8,%esp
     1a9:	ff 75 0c             	pushl  0xc(%ebp)
     1ac:	50                   	push   %eax
     1ad:	e8 4e fe ff ff       	call   0 <runcmd>
     1b2:	83 c4 10             	add    $0x10,%esp
     break;
     1b5:	e9 3d 01 00 00       	jmp    2f7 <runcmd+0x2f7>

   case PIPE:
     pcmd = (struct pipecmd*)cmd;
     1ba:	8b 45 08             	mov    0x8(%ebp),%eax
     1bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
     if(pipe(p) < 0)
     1c0:	83 ec 0c             	sub    $0xc,%esp
     1c3:	8d 45 dc             	lea    -0x24(%ebp),%eax
     1c6:	50                   	push   %eax
     1c7:	e8 c2 15 00 00       	call   178e <pipe>
     1cc:	83 c4 10             	add    $0x10,%esp
     1cf:	85 c0                	test   %eax,%eax
     1d1:	79 10                	jns    1e3 <runcmd+0x1e3>
       panic("pipe");
     1d3:	83 ec 0c             	sub    $0xc,%esp
     1d6:	68 03 1d 00 00       	push   $0x1d03
     1db:	e8 68 0a 00 00       	call   c48 <panic>
     1e0:	83 c4 10             	add    $0x10,%esp
     if(fork1() == 0){
     1e3:	e8 85 0a 00 00       	call   c6d <fork1>
     1e8:	85 c0                	test   %eax,%eax
     1ea:	75 4f                	jne    23b <runcmd+0x23b>
       close(1);
     1ec:	83 ec 0c             	sub    $0xc,%esp
     1ef:	6a 01                	push   $0x1
     1f1:	e8 b0 15 00 00       	call   17a6 <close>
     1f6:	83 c4 10             	add    $0x10,%esp
       dup(p[1]);
     1f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1fc:	83 ec 0c             	sub    $0xc,%esp
     1ff:	50                   	push   %eax
     200:	e8 f1 15 00 00       	call   17f6 <dup>
     205:	83 c4 10             	add    $0x10,%esp
       close(p[0]);
     208:	8b 45 dc             	mov    -0x24(%ebp),%eax
     20b:	83 ec 0c             	sub    $0xc,%esp
     20e:	50                   	push   %eax
     20f:	e8 92 15 00 00       	call   17a6 <close>
     214:	83 c4 10             	add    $0x10,%esp
       close(p[1]);
     217:	8b 45 e0             	mov    -0x20(%ebp),%eax
     21a:	83 ec 0c             	sub    $0xc,%esp
     21d:	50                   	push   %eax
     21e:	e8 83 15 00 00       	call   17a6 <close>
     223:	83 c4 10             	add    $0x10,%esp
       runcmd(pcmd->left,fdToShell);
     226:	8b 45 e8             	mov    -0x18(%ebp),%eax
     229:	8b 40 04             	mov    0x4(%eax),%eax
     22c:	83 ec 08             	sub    $0x8,%esp
     22f:	ff 75 0c             	pushl  0xc(%ebp)
     232:	50                   	push   %eax
     233:	e8 c8 fd ff ff       	call   0 <runcmd>
     238:	83 c4 10             	add    $0x10,%esp
     }
     if(fork1() == 0){
     23b:	e8 2d 0a 00 00       	call   c6d <fork1>
     240:	85 c0                	test   %eax,%eax
     242:	75 4f                	jne    293 <runcmd+0x293>
       close(0);
     244:	83 ec 0c             	sub    $0xc,%esp
     247:	6a 00                	push   $0x0
     249:	e8 58 15 00 00       	call   17a6 <close>
     24e:	83 c4 10             	add    $0x10,%esp
       dup(p[0]);
     251:	8b 45 dc             	mov    -0x24(%ebp),%eax
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	50                   	push   %eax
     258:	e8 99 15 00 00       	call   17f6 <dup>
     25d:	83 c4 10             	add    $0x10,%esp
       close(p[0]);
     260:	8b 45 dc             	mov    -0x24(%ebp),%eax
     263:	83 ec 0c             	sub    $0xc,%esp
     266:	50                   	push   %eax
     267:	e8 3a 15 00 00       	call   17a6 <close>
     26c:	83 c4 10             	add    $0x10,%esp
       close(p[1]);
     26f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     272:	83 ec 0c             	sub    $0xc,%esp
     275:	50                   	push   %eax
     276:	e8 2b 15 00 00       	call   17a6 <close>
     27b:	83 c4 10             	add    $0x10,%esp
       runcmd(pcmd->right,fdToShell);
     27e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     281:	8b 40 08             	mov    0x8(%eax),%eax
     284:	83 ec 08             	sub    $0x8,%esp
     287:	ff 75 0c             	pushl  0xc(%ebp)
     28a:	50                   	push   %eax
     28b:	e8 70 fd ff ff       	call   0 <runcmd>
     290:	83 c4 10             	add    $0x10,%esp
     }
     close(p[0]);
     293:	8b 45 dc             	mov    -0x24(%ebp),%eax
     296:	83 ec 0c             	sub    $0xc,%esp
     299:	50                   	push   %eax
     29a:	e8 07 15 00 00       	call   17a6 <close>
     29f:	83 c4 10             	add    $0x10,%esp
     close(p[1]);
     2a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     2a5:	83 ec 0c             	sub    $0xc,%esp
     2a8:	50                   	push   %eax
     2a9:	e8 f8 14 00 00       	call   17a6 <close>
     2ae:	83 c4 10             	add    $0x10,%esp
     close(fdToShell);
     2b1:	83 ec 0c             	sub    $0xc,%esp
     2b4:	ff 75 0c             	pushl  0xc(%ebp)
     2b7:	e8 ea 14 00 00       	call   17a6 <close>
     2bc:	83 c4 10             	add    $0x10,%esp
     wait(0);
     2bf:	83 ec 0c             	sub    $0xc,%esp
     2c2:	6a 00                	push   $0x0
     2c4:	e8 bd 14 00 00       	call   1786 <wait>
     2c9:	83 c4 10             	add    $0x10,%esp

     wait(0);
     2cc:	83 ec 0c             	sub    $0xc,%esp
     2cf:	6a 00                	push   $0x0
     2d1:	e8 b0 14 00 00       	call   1786 <wait>
     2d6:	83 c4 10             	add    $0x10,%esp
     break;
     2d9:	eb 1c                	jmp    2f7 <runcmd+0x2f7>

   case BACK:
     bcmd = (struct backcmd*)cmd;
     2db:	8b 45 08             	mov    0x8(%ebp),%eax
     2de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
//     if (fork1() == 0)
    	 runcmd(bcmd->cmd,fdToShell);
     2e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     2e4:	8b 40 04             	mov    0x4(%eax),%eax
     2e7:	83 ec 08             	sub    $0x8,%esp
     2ea:	ff 75 0c             	pushl  0xc(%ebp)
     2ed:	50                   	push   %eax
     2ee:	e8 0d fd ff ff       	call   0 <runcmd>
     2f3:	83 c4 10             	add    $0x10,%esp
//     close(fdToShell);
     break;
     2f6:	90                   	nop
  }
  exit(EXIT_STATUS_OK);
     2f7:	83 ec 0c             	sub    $0xc,%esp
     2fa:	6a 01                	push   $0x1
     2fc:	e8 7d 14 00 00       	call   177e <exit>

00000301 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     301:	55                   	push   %ebp
     302:	89 e5                	mov    %esp,%ebp
     304:	83 ec 08             	sub    $0x8,%esp
  //printf(2, "$ ");
  memset(buf, 0, nbuf);
     307:	8b 45 0c             	mov    0xc(%ebp),%eax
     30a:	83 ec 04             	sub    $0x4,%esp
     30d:	50                   	push   %eax
     30e:	6a 00                	push   $0x0
     310:	ff 75 08             	pushl  0x8(%ebp)
     313:	e8 cc 12 00 00       	call   15e4 <memset>
     318:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     31b:	83 ec 08             	sub    $0x8,%esp
     31e:	ff 75 0c             	pushl  0xc(%ebp)
     321:	ff 75 08             	pushl  0x8(%ebp)
     324:	e8 08 13 00 00       	call   1631 <gets>
     329:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     32c:	8b 45 08             	mov    0x8(%ebp),%eax
     32f:	0f b6 00             	movzbl (%eax),%eax
     332:	84 c0                	test   %al,%al
     334:	75 07                	jne    33d <getcmd+0x3c>
    return -1;
     336:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     33b:	eb 05                	jmp    342 <getcmd+0x41>
  return 0;
     33d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     342:	c9                   	leave  
     343:	c3                   	ret    

00000344 <main>:

int
main(void)
{
     344:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     348:	83 e4 f0             	and    $0xfffffff0,%esp
     34b:	ff 71 fc             	pushl  -0x4(%ecx)
     34e:	55                   	push   %ebp
     34f:	89 e5                	mov    %esp,%ebp
     351:	51                   	push   %ecx
     352:	83 ec 44             	sub    $0x44,%esp
  static char buf[100];
  int fd;
  struct job *jobsHead = 0;
     355:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  struct job *foregroungJob = 0;
     35c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

  int jobCount = 0;
     363:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     36a:	eb 16                	jmp    382 <main+0x3e>
    if(fd >= 3){
     36c:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
     370:	7e 10                	jle    382 <main+0x3e>
      close(fd);
     372:	83 ec 0c             	sub    $0xc,%esp
     375:	ff 75 e8             	pushl  -0x18(%ebp)
     378:	e8 29 14 00 00       	call   17a6 <close>
     37d:	83 c4 10             	add    $0x10,%esp
      break;
     380:	eb 1b                	jmp    39d <main+0x59>
  struct job *foregroungJob = 0;

  int jobCount = 0;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     382:	83 ec 08             	sub    $0x8,%esp
     385:	6a 02                	push   $0x2
     387:	68 20 1d 00 00       	push   $0x1d20
     38c:	e8 2d 14 00 00       	call   17be <open>
     391:	83 c4 10             	add    $0x10,%esp
     394:	89 45 e8             	mov    %eax,-0x18(%ebp)
     397:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     39b:	79 cf                	jns    36c <main+0x28>
      break;
    }
  }

  // Read and run input commands.
  printf(2, "$ ");
     39d:	83 ec 08             	sub    $0x8,%esp
     3a0:	68 28 1d 00 00       	push   $0x1d28
     3a5:	6a 02                	push   $0x2
     3a7:	e8 4f 15 00 00       	call   18fb <printf>
     3ac:	83 c4 10             	add    $0x10,%esp

  while(getcmd(buf, sizeof(buf)) >= 0){
     3af:	e9 6c 03 00 00       	jmp    720 <main+0x3dc>
	 jobsHead = clearJobList(jobsHead);
     3b4:	83 ec 0c             	sub    $0xc,%esp
     3b7:	ff 75 f4             	pushl  -0xc(%ebp)
     3ba:	e8 91 05 00 00       	call   950 <clearJobList>
     3bf:	83 c4 10             	add    $0x10,%esp
     3c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	 foregroungJob = findForegroundJob(jobsHead);
     3c5:	83 ec 0c             	sub    $0xc,%esp
     3c8:	ff 75 f4             	pushl  -0xc(%ebp)
     3cb:	e8 39 05 00 00       	call   909 <findForegroundJob>
     3d0:	83 c4 10             	add    $0x10,%esp
     3d3:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (foregroungJob != 0){
     3d6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     3da:	74 2f                	je     40b <main+0xc7>
		//TODO pass to pipe entered data
		write(foregroungJob->jobInFd , buf, strlen(buf));
     3dc:	83 ec 0c             	sub    $0xc,%esp
     3df:	68 00 24 00 00       	push   $0x2400
     3e4:	e8 d4 11 00 00       	call   15bd <strlen>
     3e9:	83 c4 10             	add    $0x10,%esp
     3ec:	89 c2                	mov    %eax,%edx
     3ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3f1:	8b 40 0c             	mov    0xc(%eax),%eax
     3f4:	83 ec 04             	sub    $0x4,%esp
     3f7:	52                   	push   %edx
     3f8:	68 00 24 00 00       	push   $0x2400
     3fd:	50                   	push   %eax
     3fe:	e8 9b 13 00 00       	call   179e <write>
     403:	83 c4 10             	add    $0x10,%esp
		continue;
     406:	e9 15 03 00 00       	jmp    720 <main+0x3dc>
	}

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     40b:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     412:	3c 63                	cmp    $0x63,%al
     414:	75 72                	jne    488 <main+0x144>
     416:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     41d:	3c 64                	cmp    $0x64,%al
     41f:	75 67                	jne    488 <main+0x144>
     421:	0f b6 05 02 24 00 00 	movzbl 0x2402,%eax
     428:	3c 20                	cmp    $0x20,%al
     42a:	75 5c                	jne    488 <main+0x144>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     42c:	83 ec 0c             	sub    $0xc,%esp
     42f:	68 00 24 00 00       	push   $0x2400
     434:	e8 84 11 00 00       	call   15bd <strlen>
     439:	83 c4 10             	add    $0x10,%esp
     43c:	83 e8 01             	sub    $0x1,%eax
     43f:	c6 80 00 24 00 00 00 	movb   $0x0,0x2400(%eax)
      if(chdir(buf+3) < 0)
     446:	83 ec 0c             	sub    $0xc,%esp
     449:	68 03 24 00 00       	push   $0x2403
     44e:	e8 9b 13 00 00       	call   17ee <chdir>
     453:	83 c4 10             	add    $0x10,%esp
     456:	85 c0                	test   %eax,%eax
     458:	79 17                	jns    471 <main+0x12d>
        printf(2, "cannot cd %s\n", buf+3);
     45a:	83 ec 04             	sub    $0x4,%esp
     45d:	68 03 24 00 00       	push   $0x2403
     462:	68 2b 1d 00 00       	push   $0x1d2b
     467:	6a 02                	push   $0x2
     469:	e8 8d 14 00 00       	call   18fb <printf>
     46e:	83 c4 10             	add    $0x10,%esp
	  printf(2, "$ ");
     471:	83 ec 08             	sub    $0x8,%esp
     474:	68 28 1d 00 00       	push   $0x1d28
     479:	6a 02                	push   $0x2
     47b:	e8 7b 14 00 00       	call   18fb <printf>
     480:	83 c4 10             	add    $0x10,%esp
      continue;
     483:	e9 98 02 00 00       	jmp    720 <main+0x3dc>
    }

    if(buf[0] == 'j' && buf[1] == 'o' && buf[2] == 'b' && buf[3] == 's'){
     488:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     48f:	3c 6a                	cmp    $0x6a,%al
     491:	75 46                	jne    4d9 <main+0x195>
     493:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     49a:	3c 6f                	cmp    $0x6f,%al
     49c:	75 3b                	jne    4d9 <main+0x195>
     49e:	0f b6 05 02 24 00 00 	movzbl 0x2402,%eax
     4a5:	3c 62                	cmp    $0x62,%al
     4a7:	75 30                	jne    4d9 <main+0x195>
     4a9:	0f b6 05 03 24 00 00 	movzbl 0x2403,%eax
     4b0:	3c 73                	cmp    $0x73,%al
     4b2:	75 25                	jne    4d9 <main+0x195>
    	printAllJobs(jobsHead);
     4b4:	83 ec 0c             	sub    $0xc,%esp
     4b7:	ff 75 f4             	pushl  -0xc(%ebp)
     4ba:	e8 1d 03 00 00       	call   7dc <printAllJobs>
     4bf:	83 c4 10             	add    $0x10,%esp
    	printf(2, "$ ");
     4c2:	83 ec 08             	sub    $0x8,%esp
     4c5:	68 28 1d 00 00       	push   $0x1d28
     4ca:	6a 02                	push   $0x2
     4cc:	e8 2a 14 00 00       	call   18fb <printf>
     4d1:	83 c4 10             	add    $0x10,%esp
    	continue;
     4d4:	e9 47 02 00 00       	jmp    720 <main+0x3dc>
    }

    if(buf[0] == 'f' && buf[1] == 'g' && buf[2] == ' '){
     4d9:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     4e0:	3c 66                	cmp    $0x66,%al
     4e2:	75 78                	jne    55c <main+0x218>
     4e4:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     4eb:	3c 67                	cmp    $0x67,%al
     4ed:	75 6d                	jne    55c <main+0x218>
     4ef:	0f b6 05 02 24 00 00 	movzbl 0x2402,%eax
     4f6:	3c 20                	cmp    $0x20,%al
     4f8:	75 62                	jne    55c <main+0x218>
        buf[strlen(buf)-1] = 0;  // chop \n
     4fa:	83 ec 0c             	sub    $0xc,%esp
     4fd:	68 00 24 00 00       	push   $0x2400
     502:	e8 b6 10 00 00       	call   15bd <strlen>
     507:	83 c4 10             	add    $0x10,%esp
     50a:	83 e8 01             	sub    $0x1,%eax
     50d:	c6 80 00 24 00 00 00 	movb   $0x0,0x2400(%eax)
        int pid = atoi(buf + 3);
     514:	83 ec 0c             	sub    $0xc,%esp
     517:	68 03 24 00 00       	push   $0x2403
     51c:	e8 cb 11 00 00       	call   16ec <atoi>
     521:	83 c4 10             	add    $0x10,%esp
     524:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        struct job *findedJob = findJobById(jobsHead , pid);
     527:	83 ec 08             	sub    $0x8,%esp
     52a:	ff 75 e4             	pushl  -0x1c(%ebp)
     52d:	ff 75 f4             	pushl  -0xc(%ebp)
     530:	e8 9b 03 00 00       	call   8d0 <findJobById>
     535:	83 c4 10             	add    $0x10,%esp
     538:	89 45 e0             	mov    %eax,-0x20(%ebp)
        findedJob->type = FOREGROUND;
     53b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     53e:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
        printf(2, "$ ");
     545:	83 ec 08             	sub    $0x8,%esp
     548:	68 28 1d 00 00       	push   $0x1d28
     54d:	6a 02                	push   $0x2
     54f:	e8 a7 13 00 00       	call   18fb <printf>
     554:	83 c4 10             	add    $0x10,%esp
    	continue;
     557:	e9 c4 01 00 00       	jmp    720 <main+0x3dc>
    }

    if(buf[0] == 'f' && buf[1] == 'g'){
     55c:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     563:	3c 66                	cmp    $0x66,%al
     565:	75 2c                	jne    593 <main+0x24f>
     567:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     56e:	3c 67                	cmp    $0x67,%al
     570:	75 21                	jne    593 <main+0x24f>
        jobsHead->type = FOREGROUND;
     572:	8b 45 f4             	mov    -0xc(%ebp),%eax
     575:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
        printf(2, "$ ");
     57c:	83 ec 08             	sub    $0x8,%esp
     57f:	68 28 1d 00 00       	push   $0x1d28
     584:	6a 02                	push   $0x2
     586:	e8 70 13 00 00       	call   18fb <printf>
     58b:	83 c4 10             	add    $0x10,%esp
    	continue;
     58e:	e9 8d 01 00 00       	jmp    720 <main+0x3dc>
    }

	int jobPids[2],jobInput[2];

	if(pipe(jobPids) < 0)
     593:	83 ec 0c             	sub    $0xc,%esp
     596:	8d 45 cc             	lea    -0x34(%ebp),%eax
     599:	50                   	push   %eax
     59a:	e8 ef 11 00 00       	call   178e <pipe>
     59f:	83 c4 10             	add    $0x10,%esp
     5a2:	85 c0                	test   %eax,%eax
     5a4:	79 10                	jns    5b6 <main+0x272>
	  panic("jobPids error");
     5a6:	83 ec 0c             	sub    $0xc,%esp
     5a9:	68 39 1d 00 00       	push   $0x1d39
     5ae:	e8 95 06 00 00       	call   c48 <panic>
     5b3:	83 c4 10             	add    $0x10,%esp

	if(pipe(jobInput) < 0)
     5b6:	83 ec 0c             	sub    $0xc,%esp
     5b9:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     5bc:	50                   	push   %eax
     5bd:	e8 cc 11 00 00       	call   178e <pipe>
     5c2:	83 c4 10             	add    $0x10,%esp
     5c5:	85 c0                	test   %eax,%eax
     5c7:	79 10                	jns    5d9 <main+0x295>
	  panic("jobInput error");
     5c9:	83 ec 0c             	sub    $0xc,%esp
     5cc:	68 47 1d 00 00       	push   $0x1d47
     5d1:	e8 72 06 00 00       	call   c48 <panic>
     5d6:	83 c4 10             	add    $0x10,%esp

	jobCount++;
     5d9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	struct job *newJob = getJob(jobCount , jobInput[1], buf);
     5dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
     5e0:	83 ec 04             	sub    $0x4,%esp
     5e3:	68 00 24 00 00       	push   $0x2400
     5e8:	50                   	push   %eax
     5e9:	ff 75 f0             	pushl  -0x10(%ebp)
     5ec:	e8 85 05 00 00       	call   b76 <getJob>
     5f1:	83 c4 10             	add    $0x10,%esp
     5f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
	struct cmd *newcmd = parsecmd(buf);
     5f7:	83 ec 0c             	sub    $0xc,%esp
     5fa:	68 00 24 00 00       	push   $0x2400
     5ff:	e8 bd 09 00 00       	call   fc1 <parsecmd>
     604:	83 c4 10             	add    $0x10,%esp
     607:	89 45 d8             	mov    %eax,-0x28(%ebp)

	if (newcmd->type == BACK){
     60a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     60d:	8b 00                	mov    (%eax),%eax
     60f:	83 f8 05             	cmp    $0x5,%eax
     612:	75 0a                	jne    61e <main+0x2da>
		newJob->type = BACKGROUND;
     614:	8b 45 dc             	mov    -0x24(%ebp),%eax
     617:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
	}


	if(jobsHead == 0){
     61e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     622:	75 08                	jne    62c <main+0x2e8>
		jobsHead = newJob;
     624:	8b 45 dc             	mov    -0x24(%ebp),%eax
     627:	89 45 f4             	mov    %eax,-0xc(%ebp)
     62a:	eb 0f                	jmp    63b <main+0x2f7>
	}
	else {
		newJob->nextjob = jobsHead;
     62c:	8b 45 dc             	mov    -0x24(%ebp),%eax
     62f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     632:	89 50 04             	mov    %edx,0x4(%eax)
		jobsHead = newJob;
     635:	8b 45 dc             	mov    -0x24(%ebp),%eax
     638:	89 45 f4             	mov    %eax,-0xc(%ebp)
	}

	if(fork1() == 0)
     63b:	e8 2d 06 00 00       	call   c6d <fork1>
     640:	85 c0                	test   %eax,%eax
     642:	75 5d                	jne    6a1 <main+0x35d>
	{
		close(0);
     644:	83 ec 0c             	sub    $0xc,%esp
     647:	6a 00                	push   $0x0
     649:	e8 58 11 00 00       	call   17a6 <close>
     64e:	83 c4 10             	add    $0x10,%esp
		dup(jobInput[0]);
     651:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     654:	83 ec 0c             	sub    $0xc,%esp
     657:	50                   	push   %eax
     658:	e8 99 11 00 00       	call   17f6 <dup>
     65d:	83 c4 10             	add    $0x10,%esp

		close(jobInput[0]);
     660:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     663:	83 ec 0c             	sub    $0xc,%esp
     666:	50                   	push   %eax
     667:	e8 3a 11 00 00       	call   17a6 <close>
     66c:	83 c4 10             	add    $0x10,%esp
		close(jobInput[1]);
     66f:	8b 45 c8             	mov    -0x38(%ebp),%eax
     672:	83 ec 0c             	sub    $0xc,%esp
     675:	50                   	push   %eax
     676:	e8 2b 11 00 00       	call   17a6 <close>
     67b:	83 c4 10             	add    $0x10,%esp
		close(jobPids[0]);
     67e:	8b 45 cc             	mov    -0x34(%ebp),%eax
     681:	83 ec 0c             	sub    $0xc,%esp
     684:	50                   	push   %eax
     685:	e8 1c 11 00 00       	call   17a6 <close>
     68a:	83 c4 10             	add    $0x10,%esp

		runcmd(newcmd , jobPids[1]);
     68d:	8b 45 d0             	mov    -0x30(%ebp),%eax
     690:	83 ec 08             	sub    $0x8,%esp
     693:	50                   	push   %eax
     694:	ff 75 d8             	pushl  -0x28(%ebp)
     697:	e8 64 f9 ff ff       	call   0 <runcmd>
     69c:	83 c4 10             	add    $0x10,%esp
     69f:	eb 63                	jmp    704 <main+0x3c0>
	}
	else{
		close(jobInput[0]);
     6a1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     6a4:	83 ec 0c             	sub    $0xc,%esp
     6a7:	50                   	push   %eax
     6a8:	e8 f9 10 00 00       	call   17a6 <close>
     6ad:	83 c4 10             	add    $0x10,%esp
		close(jobPids[1]);
     6b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
     6b3:	83 ec 0c             	sub    $0xc,%esp
     6b6:	50                   	push   %eax
     6b7:	e8 ea 10 00 00       	call   17a6 <close>
     6bc:	83 c4 10             	add    $0x10,%esp

		char pidBuf[sizeof(int)];
		while (read(jobPids[0] , pidBuf , sizeof(pidBuf)) > 0 ){
     6bf:	eb 1b                	jmp    6dc <main+0x398>
			int recievedPid = (int)*pidBuf;
     6c1:	0f b6 45 c0          	movzbl -0x40(%ebp),%eax
     6c5:	0f be c0             	movsbl %al,%eax
     6c8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			addProcessToJob(newJob , recievedPid);
     6cb:	83 ec 08             	sub    $0x8,%esp
     6ce:	ff 75 d4             	pushl  -0x2c(%ebp)
     6d1:	ff 75 dc             	pushl  -0x24(%ebp)
     6d4:	e8 c9 01 00 00       	call   8a2 <addProcessToJob>
     6d9:	83 c4 10             	add    $0x10,%esp
	else{
		close(jobInput[0]);
		close(jobPids[1]);

		char pidBuf[sizeof(int)];
		while (read(jobPids[0] , pidBuf , sizeof(pidBuf)) > 0 ){
     6dc:	8b 45 cc             	mov    -0x34(%ebp),%eax
     6df:	83 ec 04             	sub    $0x4,%esp
     6e2:	6a 04                	push   $0x4
     6e4:	8d 55 c0             	lea    -0x40(%ebp),%edx
     6e7:	52                   	push   %edx
     6e8:	50                   	push   %eax
     6e9:	e8 a8 10 00 00       	call   1796 <read>
     6ee:	83 c4 10             	add    $0x10,%esp
     6f1:	85 c0                	test   %eax,%eax
     6f3:	7f cc                	jg     6c1 <main+0x37d>
			int recievedPid = (int)*pidBuf;
			addProcessToJob(newJob , recievedPid);
		}
		close(jobPids[0]);
     6f5:	8b 45 cc             	mov    -0x34(%ebp),%eax
     6f8:	83 ec 0c             	sub    $0xc,%esp
     6fb:	50                   	push   %eax
     6fc:	e8 a5 10 00 00       	call   17a6 <close>
     701:	83 c4 10             	add    $0x10,%esp

	}

	if (newcmd->type == BACK)
     704:	8b 45 d8             	mov    -0x28(%ebp),%eax
     707:	8b 00                	mov    (%eax),%eax
     709:	83 f8 05             	cmp    $0x5,%eax
     70c:	75 12                	jne    720 <main+0x3dc>
		  printf(2, "$ ");
     70e:	83 ec 08             	sub    $0x8,%esp
     711:	68 28 1d 00 00       	push   $0x1d28
     716:	6a 02                	push   $0x2
     718:	e8 de 11 00 00       	call   18fb <printf>
     71d:	83 c4 10             	add    $0x10,%esp
  }

  // Read and run input commands.
  printf(2, "$ ");

  while(getcmd(buf, sizeof(buf)) >= 0){
     720:	83 ec 08             	sub    $0x8,%esp
     723:	6a 64                	push   $0x64
     725:	68 00 24 00 00       	push   $0x2400
     72a:	e8 d2 fb ff ff       	call   301 <getcmd>
     72f:	83 c4 10             	add    $0x10,%esp
     732:	85 c0                	test   %eax,%eax
     734:	0f 89 7a fc ff ff    	jns    3b4 <main+0x70>
	if (newcmd->type == BACK)
		  printf(2, "$ ");

	//wait(0);
  }
  deleteJobList(jobsHead);
     73a:	83 ec 0c             	sub    $0xc,%esp
     73d:	ff 75 f4             	pushl  -0xc(%ebp)
     740:	e8 0d 00 00 00       	call   752 <deleteJobList>
     745:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
     748:	83 ec 0c             	sub    $0xc,%esp
     74b:	6a 01                	push   $0x1
     74d:	e8 2c 10 00 00       	call   177e <exit>

00000752 <deleteJobList>:
}


void deleteJobList(struct job * head){
     752:	55                   	push   %ebp
     753:	89 e5                	mov    %esp,%ebp
     755:	83 ec 18             	sub    $0x18,%esp
	struct job* currentJob = head;
     758:	8b 45 08             	mov    0x8(%ebp),%eax
     75b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job* tempJob = 0;
     75e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	if (head == 0) {
     765:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     769:	75 02                	jne    76d <deleteJobList+0x1b>
		return;
     76b:	eb 6d                	jmp    7da <deleteJobList+0x88>
	}
	while (currentJob!=0){
     76d:	eb 64                	jmp    7d3 <deleteJobList+0x81>
		struct jobprocess* currentProc = currentJob->headOfProcesses;
     76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     772:	8b 40 08             	mov    0x8(%eax),%eax
     775:	89 45 f0             	mov    %eax,-0x10(%ebp)
		struct jobprocess* tempProc = 0;
     778:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		while (currentProc != 0 ){
     77f:	eb 1d                	jmp    79e <deleteJobList+0x4c>
			tempProc = currentProc->nextProcess;
     781:	8b 45 f0             	mov    -0x10(%ebp),%eax
     784:	8b 40 04             	mov    0x4(%eax),%eax
     787:	89 45 e8             	mov    %eax,-0x18(%ebp)
			free(currentProc);
     78a:	83 ec 0c             	sub    $0xc,%esp
     78d:	ff 75 f0             	pushl  -0x10(%ebp)
     790:	e8 f6 12 00 00       	call   1a8b <free>
     795:	83 c4 10             	add    $0x10,%esp
			currentProc = tempProc;
     798:	8b 45 e8             	mov    -0x18(%ebp),%eax
     79b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		return;
	}
	while (currentJob!=0){
		struct jobprocess* currentProc = currentJob->headOfProcesses;
		struct jobprocess* tempProc = 0;
		while (currentProc != 0 ){
     79e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7a2:	75 dd                	jne    781 <deleteJobList+0x2f>
			tempProc = currentProc->nextProcess;
			free(currentProc);
			currentProc = tempProc;
		}
		tempJob = currentJob->nextjob;
     7a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a7:	8b 40 04             	mov    0x4(%eax),%eax
     7aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(currentJob->cmd);
     7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b0:	8b 40 14             	mov    0x14(%eax),%eax
     7b3:	83 ec 0c             	sub    $0xc,%esp
     7b6:	50                   	push   %eax
     7b7:	e8 cf 12 00 00       	call   1a8b <free>
     7bc:	83 c4 10             	add    $0x10,%esp
		free(currentJob);
     7bf:	83 ec 0c             	sub    $0xc,%esp
     7c2:	ff 75 f4             	pushl  -0xc(%ebp)
     7c5:	e8 c1 12 00 00       	call   1a8b <free>
     7ca:	83 c4 10             	add    $0x10,%esp
		currentJob = tempJob;
     7cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job* currentJob = head;
	struct job* tempJob = 0;
	if (head == 0) {
		return;
	}
	while (currentJob!=0){
     7d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7d7:	75 96                	jne    76f <deleteJobList+0x1d>
		tempJob = currentJob->nextjob;
		free(currentJob->cmd);
		free(currentJob);
		currentJob = tempJob;
	}
	return;
     7d9:	90                   	nop
}
     7da:	c9                   	leave  
     7db:	c3                   	ret    

000007dc <printAllJobs>:

void printAllJobs(struct job * head){
     7dc:	55                   	push   %ebp
     7dd:	89 e5                	mov    %esp,%ebp
     7df:	53                   	push   %ebx
     7e0:	83 ec 34             	sub    $0x34,%esp
	struct job* currentJob = head;
     7e3:	8b 45 08             	mov    0x8(%ebp),%eax
     7e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (head == 0) {
     7e9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     7ed:	75 17                	jne    806 <printAllJobs+0x2a>
		printf(2, "There are no jobs\n");
     7ef:	83 ec 08             	sub    $0x8,%esp
     7f2:	68 56 1d 00 00       	push   $0x1d56
     7f7:	6a 02                	push   $0x2
     7f9:	e8 fd 10 00 00       	call   18fb <printf>
     7fe:	83 c4 10             	add    $0x10,%esp
		return;
     801:	e9 97 00 00 00       	jmp    89d <printAllJobs+0xc1>
	}
	while (currentJob!=0){
     806:	e9 87 00 00 00       	jmp    892 <printAllJobs+0xb6>
		struct jobprocess* currentProc = currentJob->headOfProcesses;
     80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80e:	8b 40 08             	mov    0x8(%eax),%eax
     811:	89 45 f0             	mov    %eax,-0x10(%ebp)
		printf(2, "Job %d: %s", currentJob->id, currentJob->cmd);
     814:	8b 45 f4             	mov    -0xc(%ebp),%eax
     817:	8b 50 14             	mov    0x14(%eax),%edx
     81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81d:	8b 00                	mov    (%eax),%eax
     81f:	52                   	push   %edx
     820:	50                   	push   %eax
     821:	68 69 1d 00 00       	push   $0x1d69
     826:	6a 02                	push   $0x2
     828:	e8 ce 10 00 00       	call   18fb <printf>
     82d:	83 c4 10             	add    $0x10,%esp
		while (currentProc != 0 ){
     830:	eb 51                	jmp    883 <printAllJobs+0xa7>
			struct procstat stat;
			if (pstat(currentProc->pid, &stat) == 0){
     832:	8b 45 f0             	mov    -0x10(%ebp),%eax
     835:	8b 00                	mov    (%eax),%eax
     837:	83 ec 08             	sub    $0x8,%esp
     83a:	8d 55 d4             	lea    -0x2c(%ebp),%edx
     83d:	52                   	push   %edx
     83e:	50                   	push   %eax
     83f:	e8 da 0f 00 00       	call   181e <pstat>
     844:	83 c4 10             	add    $0x10,%esp
     847:	85 c0                	test   %eax,%eax
     849:	75 2f                	jne    87a <printAllJobs+0x9e>
				printf(2, "%d: %s %d %d %s\n", currentProc->pid, stat.name, stat.sz, stat.nofile, states[stat.state]);
     84b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     84e:	8b 1c 85 c8 23 00 00 	mov    0x23c8(,%eax,4),%ebx
     855:	8b 4d e8             	mov    -0x18(%ebp),%ecx
     858:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     85b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     85e:	8b 00                	mov    (%eax),%eax
     860:	83 ec 04             	sub    $0x4,%esp
     863:	53                   	push   %ebx
     864:	51                   	push   %ecx
     865:	52                   	push   %edx
     866:	8d 55 d4             	lea    -0x2c(%ebp),%edx
     869:	52                   	push   %edx
     86a:	50                   	push   %eax
     86b:	68 74 1d 00 00       	push   $0x1d74
     870:	6a 02                	push   $0x2
     872:	e8 84 10 00 00       	call   18fb <printf>
     877:	83 c4 20             	add    $0x20,%esp
			}
			currentProc = currentProc->nextProcess;
     87a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     87d:	8b 40 04             	mov    0x4(%eax),%eax
     880:	89 45 f0             	mov    %eax,-0x10(%ebp)
		return;
	}
	while (currentJob!=0){
		struct jobprocess* currentProc = currentJob->headOfProcesses;
		printf(2, "Job %d: %s", currentJob->id, currentJob->cmd);
		while (currentProc != 0 ){
     883:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     887:	75 a9                	jne    832 <printAllJobs+0x56>
			if (pstat(currentProc->pid, &stat) == 0){
				printf(2, "%d: %s %d %d %s\n", currentProc->pid, stat.name, stat.sz, stat.nofile, states[stat.state]);
			}
			currentProc = currentProc->nextProcess;
		}
		currentJob = currentJob->nextjob;
     889:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88c:	8b 40 04             	mov    0x4(%eax),%eax
     88f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job* currentJob = head;
	if (head == 0) {
		printf(2, "There are no jobs\n");
		return;
	}
	while (currentJob!=0){
     892:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     896:	0f 85 6f ff ff ff    	jne    80b <printAllJobs+0x2f>
			}
			currentProc = currentProc->nextProcess;
		}
		currentJob = currentJob->nextjob;
	}
	return;
     89c:	90                   	nop
}
     89d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8a0:	c9                   	leave  
     8a1:	c3                   	ret    

000008a2 <addProcessToJob>:

void addProcessToJob(struct job *job , int pid){
     8a2:	55                   	push   %ebp
     8a3:	89 e5                	mov    %esp,%ebp
     8a5:	83 ec 18             	sub    $0x18,%esp
	struct jobprocess *newProcess = getProcess(pid);
     8a8:	83 ec 0c             	sub    $0xc,%esp
     8ab:	ff 75 0c             	pushl  0xc(%ebp)
     8ae:	e8 56 03 00 00       	call   c09 <getProcess>
     8b3:	83 c4 10             	add    $0x10,%esp
     8b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	newProcess->nextProcess = job->headOfProcesses;
     8b9:	8b 45 08             	mov    0x8(%ebp),%eax
     8bc:	8b 50 08             	mov    0x8(%eax),%edx
     8bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c2:	89 50 04             	mov    %edx,0x4(%eax)
	job->headOfProcesses = newProcess;
     8c5:	8b 45 08             	mov    0x8(%ebp),%eax
     8c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8cb:	89 50 08             	mov    %edx,0x8(%eax)
}
     8ce:	c9                   	leave  
     8cf:	c3                   	ret    

000008d0 <findJobById>:

struct job *findJobById(struct job *head , int pid){
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	83 ec 10             	sub    $0x10,%esp
	struct job* currentJob = head;
     8d6:	8b 45 08             	mov    0x8(%ebp),%eax
     8d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (head == 0) {
     8dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     8e0:	75 05                	jne    8e7 <findJobById+0x17>
		return head;
     8e2:	8b 45 08             	mov    0x8(%ebp),%eax
     8e5:	eb 20                	jmp    907 <findJobById+0x37>
	}
	while (currentJob != 0){
     8e7:	eb 15                	jmp    8fe <findJobById+0x2e>
		if (currentJob->id == pid){
     8e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ec:	8b 00                	mov    (%eax),%eax
     8ee:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8f1:	75 02                	jne    8f5 <findJobById+0x25>
			break;
     8f3:	eb 0f                	jmp    904 <findJobById+0x34>
		}
		currentJob = currentJob->nextjob;
     8f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f8:	8b 40 04             	mov    0x4(%eax),%eax
     8fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
struct job *findJobById(struct job *head , int pid){
	struct job* currentJob = head;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
     8fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     902:	75 e5                	jne    8e9 <findJobById+0x19>
		if (currentJob->id == pid){
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return currentJob;
     904:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     907:	c9                   	leave  
     908:	c3                   	ret    

00000909 <findForegroundJob>:

struct job *findForegroundJob(struct job *head){
     909:	55                   	push   %ebp
     90a:	89 e5                	mov    %esp,%ebp
     90c:	83 ec 10             	sub    $0x10,%esp
	struct job* currentJob = head;
     90f:	8b 45 08             	mov    0x8(%ebp),%eax
     912:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct job* foregroundJob = 0;
     915:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	if (head == 0) {
     91c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     920:	75 05                	jne    927 <findForegroundJob+0x1e>
		return head;
     922:	8b 45 08             	mov    0x8(%ebp),%eax
     925:	eb 27                	jmp    94e <findForegroundJob+0x45>
	}
	while (currentJob != 0){
     927:	eb 1c                	jmp    945 <findForegroundJob+0x3c>
		if (currentJob->type == FOREGROUND){
     929:	8b 45 fc             	mov    -0x4(%ebp),%eax
     92c:	8b 40 10             	mov    0x10(%eax),%eax
     92f:	83 f8 01             	cmp    $0x1,%eax
     932:	75 08                	jne    93c <findForegroundJob+0x33>
			foregroundJob = currentJob;
     934:	8b 45 fc             	mov    -0x4(%ebp),%eax
     937:	89 45 f8             	mov    %eax,-0x8(%ebp)
			break;
     93a:	eb 0f                	jmp    94b <findForegroundJob+0x42>
		}
		currentJob = currentJob->nextjob;
     93c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     93f:	8b 40 04             	mov    0x4(%eax),%eax
     942:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct job* currentJob = head;
	struct job* foregroundJob = 0;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
     945:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     949:	75 de                	jne    929 <findForegroundJob+0x20>
			foregroundJob = currentJob;
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return foregroundJob;
     94b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     94e:	c9                   	leave  
     94f:	c3                   	ret    

00000950 <clearJobList>:

struct job *clearJobList(struct job *head){
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	83 ec 18             	sub    $0x18,%esp
	if (head == 0){
     956:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     95a:	75 08                	jne    964 <clearJobList+0x14>
		return head;
     95c:	8b 45 08             	mov    0x8(%ebp),%eax
     95f:	e9 21 01 00 00       	jmp    a85 <clearJobList+0x135>
	}

	struct job *currentJob = head;
     964:	8b 45 08             	mov    0x8(%ebp),%eax
     967:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job *newHead = 0;
     96a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	while (newHead == 0 && currentJob != 0){
     971:	eb 5b                	jmp    9ce <clearJobList+0x7e>
		struct job *temp = currentJob->nextjob;
     973:	8b 45 f4             	mov    -0xc(%ebp),%eax
     976:	8b 40 04             	mov    0x4(%eax),%eax
     979:	89 45 e8             	mov    %eax,-0x18(%ebp)
		currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
     97c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     97f:	8b 40 08             	mov    0x8(%eax),%eax
     982:	83 ec 0c             	sub    $0xc,%esp
     985:	50                   	push   %eax
     986:	e8 fc 00 00 00       	call   a87 <clearZombieProcesses>
     98b:	83 c4 10             	add    $0x10,%esp
     98e:	89 c2                	mov    %eax,%edx
     990:	8b 45 f4             	mov    -0xc(%ebp),%eax
     993:	89 50 08             	mov    %edx,0x8(%eax)
		if (currentJob->headOfProcesses == 0){
     996:	8b 45 f4             	mov    -0xc(%ebp),%eax
     999:	8b 40 08             	mov    0x8(%eax),%eax
     99c:	85 c0                	test   %eax,%eax
     99e:	75 22                	jne    9c2 <clearJobList+0x72>
			free(currentJob->cmd);
     9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a3:	8b 40 14             	mov    0x14(%eax),%eax
     9a6:	83 ec 0c             	sub    $0xc,%esp
     9a9:	50                   	push   %eax
     9aa:	e8 dc 10 00 00       	call   1a8b <free>
     9af:	83 c4 10             	add    $0x10,%esp
			free(currentJob);
     9b2:	83 ec 0c             	sub    $0xc,%esp
     9b5:	ff 75 f4             	pushl  -0xc(%ebp)
     9b8:	e8 ce 10 00 00       	call   1a8b <free>
     9bd:	83 c4 10             	add    $0x10,%esp
     9c0:	eb 06                	jmp    9c8 <clearJobList+0x78>
		}
		else {
			newHead = currentJob;
     9c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		}
		currentJob = temp;
     9c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	}

	struct job *currentJob = head;
	struct job *newHead = 0;

	while (newHead == 0 && currentJob != 0){
     9ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9d2:	75 06                	jne    9da <clearJobList+0x8a>
     9d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     9d8:	75 99                	jne    973 <clearJobList+0x23>
			newHead = currentJob;
		}
		currentJob = temp;
	}

	if(newHead != 0){
     9da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9de:	0f 84 9e 00 00 00    	je     a82 <clearJobList+0x132>
		currentJob = newHead->nextjob;
     9e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9e7:	8b 40 04             	mov    0x4(%eax),%eax
     9ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
		struct job *prevJob = newHead;
     9ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f0:	89 45 ec             	mov    %eax,-0x14(%ebp)

		while (currentJob != 0){
     9f3:	e9 80 00 00 00       	jmp    a78 <clearJobList+0x128>
			currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
     9f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fb:	8b 40 08             	mov    0x8(%eax),%eax
     9fe:	83 ec 0c             	sub    $0xc,%esp
     a01:	50                   	push   %eax
     a02:	e8 80 00 00 00       	call   a87 <clearZombieProcesses>
     a07:	83 c4 10             	add    $0x10,%esp
     a0a:	89 c2                	mov    %eax,%edx
     a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0f:	89 50 08             	mov    %edx,0x8(%eax)
			if (currentJob->headOfProcesses == 0){
     a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a15:	8b 40 08             	mov    0x8(%eax),%eax
     a18:	85 c0                	test   %eax,%eax
     a1a:	75 4d                	jne    a69 <clearJobList+0x119>
				prevJob->nextjob = currentJob->nextjob;
     a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a1f:	8b 50 04             	mov    0x4(%eax),%edx
     a22:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a25:	89 50 04             	mov    %edx,0x4(%eax)
				free(currentJob->cmd);
     a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2b:	8b 40 14             	mov    0x14(%eax),%eax
     a2e:	83 ec 0c             	sub    $0xc,%esp
     a31:	50                   	push   %eax
     a32:	e8 54 10 00 00       	call   1a8b <free>
     a37:	83 c4 10             	add    $0x10,%esp
				free(currentJob);
     a3a:	83 ec 0c             	sub    $0xc,%esp
     a3d:	ff 75 f4             	pushl  -0xc(%ebp)
     a40:	e8 46 10 00 00       	call   1a8b <free>
     a45:	83 c4 10             	add    $0x10,%esp
				if (prevJob->nextjob != 0){
     a48:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a4b:	8b 40 04             	mov    0x4(%eax),%eax
     a4e:	85 c0                	test   %eax,%eax
     a50:	74 0e                	je     a60 <clearJobList+0x110>
					currentJob = prevJob->nextjob->nextjob;
     a52:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a55:	8b 40 04             	mov    0x4(%eax),%eax
     a58:	8b 40 04             	mov    0x4(%eax),%eax
     a5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     a5e:	eb 18                	jmp    a78 <clearJobList+0x128>
				}
				else {
					currentJob = 0;
     a60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a67:	eb 0f                	jmp    a78 <clearJobList+0x128>
				}
			}
			else {
				prevJob = currentJob;
     a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a6c:	89 45 ec             	mov    %eax,-0x14(%ebp)
				currentJob = currentJob->nextjob;
     a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a72:	8b 40 04             	mov    0x4(%eax),%eax
     a75:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if(newHead != 0){
		currentJob = newHead->nextjob;
		struct job *prevJob = newHead;

		while (currentJob != 0){
     a78:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a7c:	0f 85 76 ff ff ff    	jne    9f8 <clearJobList+0xa8>
				prevJob = currentJob;
				currentJob = currentJob->nextjob;
			}
		}
	}
	return newHead;
     a82:	8b 45 f0             	mov    -0x10(%ebp),%eax

}
     a85:	c9                   	leave  
     a86:	c3                   	ret    

00000a87 <clearZombieProcesses>:

struct jobprocess *clearZombieProcesses(struct jobprocess *head){
     a87:	55                   	push   %ebp
     a88:	89 e5                	mov    %esp,%ebp
     a8a:	83 ec 58             	sub    $0x58,%esp
	struct jobprocess *currentProcess = head;
     a8d:	8b 45 08             	mov    0x8(%ebp),%eax
     a90:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct jobprocess *newHead = 0;
     a93:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	if (head == 0){
     a9a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     a9e:	75 08                	jne    aa8 <clearZombieProcesses+0x21>
		return head;
     aa0:	8b 45 08             	mov    0x8(%ebp),%eax
     aa3:	e9 cc 00 00 00       	jmp    b74 <clearZombieProcesses+0xed>
	}

	while (newHead == 0  && currentProcess != 0){
     aa8:	eb 46                	jmp    af0 <clearZombieProcesses+0x69>
		struct jobprocess *temp = currentProcess->nextProcess;
     aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aad:	8b 40 04             	mov    0x4(%eax),%eax
     ab0:	89 45 e8             	mov    %eax,-0x18(%ebp)
		struct procstat stat;

		if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
     ab3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab6:	8b 00                	mov    (%eax),%eax
     ab8:	83 ec 08             	sub    $0x8,%esp
     abb:	8d 55 cc             	lea    -0x34(%ebp),%edx
     abe:	52                   	push   %edx
     abf:	50                   	push   %eax
     ac0:	e8 59 0d 00 00       	call   181e <pstat>
     ac5:	83 c4 10             	add    $0x10,%esp
     ac8:	85 c0                	test   %eax,%eax
     aca:	78 08                	js     ad4 <clearZombieProcesses+0x4d>
     acc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     acf:	83 f8 05             	cmp    $0x5,%eax
     ad2:	75 10                	jne    ae4 <clearZombieProcesses+0x5d>
			free(currentProcess);
     ad4:	83 ec 0c             	sub    $0xc,%esp
     ad7:	ff 75 f4             	pushl  -0xc(%ebp)
     ada:	e8 ac 0f 00 00       	call   1a8b <free>
     adf:	83 c4 10             	add    $0x10,%esp
     ae2:	eb 06                	jmp    aea <clearZombieProcesses+0x63>
		}
		else {
			newHead = currentProcess;
     ae4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		}
		currentProcess = temp;
     aea:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aed:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if (head == 0){
		return head;
	}

	while (newHead == 0  && currentProcess != 0){
     af0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     af4:	75 06                	jne    afc <clearZombieProcesses+0x75>
     af6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     afa:	75 ae                	jne    aaa <clearZombieProcesses+0x23>
			newHead = currentProcess;
		}
		currentProcess = temp;
	}

	if(newHead != 0){
     afc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     b00:	74 6f                	je     b71 <clearZombieProcesses+0xea>
		currentProcess = newHead->nextProcess;
     b02:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b05:	8b 40 04             	mov    0x4(%eax),%eax
     b08:	89 45 f4             	mov    %eax,-0xc(%ebp)
		struct jobprocess *prevProcess = newHead;
     b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b0e:	89 45 ec             	mov    %eax,-0x14(%ebp)

		while (currentProcess != 0){
     b11:	eb 58                	jmp    b6b <clearZombieProcesses+0xe4>
			struct procstat stat;

			if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
     b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b16:	8b 00                	mov    (%eax),%eax
     b18:	83 ec 08             	sub    $0x8,%esp
     b1b:	8d 55 b0             	lea    -0x50(%ebp),%edx
     b1e:	52                   	push   %edx
     b1f:	50                   	push   %eax
     b20:	e8 f9 0c 00 00       	call   181e <pstat>
     b25:	83 c4 10             	add    $0x10,%esp
     b28:	85 c0                	test   %eax,%eax
     b2a:	78 08                	js     b34 <clearZombieProcesses+0xad>
     b2c:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b2f:	83 f8 05             	cmp    $0x5,%eax
     b32:	75 28                	jne    b5c <clearZombieProcesses+0xd5>
				prevProcess->nextProcess = currentProcess->nextProcess;
     b34:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b37:	8b 50 04             	mov    0x4(%eax),%edx
     b3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b3d:	89 50 04             	mov    %edx,0x4(%eax)
				free(currentProcess);
     b40:	83 ec 0c             	sub    $0xc,%esp
     b43:	ff 75 f4             	pushl  -0xc(%ebp)
     b46:	e8 40 0f 00 00       	call   1a8b <free>
     b4b:	83 c4 10             	add    $0x10,%esp
				currentProcess = prevProcess->nextProcess->nextProcess;
     b4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b51:	8b 40 04             	mov    0x4(%eax),%eax
     b54:	8b 40 04             	mov    0x4(%eax),%eax
     b57:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b5a:	eb 0f                	jmp    b6b <clearZombieProcesses+0xe4>
			}
			else {
				prevProcess = currentProcess;
     b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5f:	89 45 ec             	mov    %eax,-0x14(%ebp)
				currentProcess = currentProcess->nextProcess;
     b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b65:	8b 40 04             	mov    0x4(%eax),%eax
     b68:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if(newHead != 0){
		currentProcess = newHead->nextProcess;
		struct jobprocess *prevProcess = newHead;

		while (currentProcess != 0){
     b6b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b6f:	75 a2                	jne    b13 <clearZombieProcesses+0x8c>
				prevProcess = currentProcess;
				currentProcess = currentProcess->nextProcess;
			}
		}
	}
	return newHead;
     b71:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b74:	c9                   	leave  
     b75:	c3                   	ret    

00000b76 <getJob>:


struct job *getJob(int jobId , int inputFd, char* buf){
     b76:	55                   	push   %ebp
     b77:	89 e5                	mov    %esp,%ebp
     b79:	83 ec 18             	sub    $0x18,%esp
	struct job *newJob;

	newJob = malloc(sizeof(*newJob));
     b7c:	83 ec 0c             	sub    $0xc,%esp
     b7f:	6a 18                	push   $0x18
     b81:	e8 46 10 00 00       	call   1bcc <malloc>
     b86:	83 c4 10             	add    $0x10,%esp
     b89:	89 45 f4             	mov    %eax,-0xc(%ebp)
	memset(newJob, 0, sizeof(*newJob));
     b8c:	83 ec 04             	sub    $0x4,%esp
     b8f:	6a 18                	push   $0x18
     b91:	6a 00                	push   $0x0
     b93:	ff 75 f4             	pushl  -0xc(%ebp)
     b96:	e8 49 0a 00 00       	call   15e4 <memset>
     b9b:	83 c4 10             	add    $0x10,%esp
	newJob->id = jobId;
     b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba1:	8b 55 08             	mov    0x8(%ebp),%edx
     ba4:	89 10                	mov    %edx,(%eax)
	newJob->nextjob = 0;// NULL
     ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba9:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	newJob->headOfProcesses = 0; //NULL
     bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb3:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	newJob->jobInFd = inputFd ;
     bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbd:	8b 55 0c             	mov    0xc(%ebp),%edx
     bc0:	89 50 0c             	mov    %edx,0xc(%eax)
	newJob->type = FOREGROUND;
     bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc6:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
	newJob->cmd = malloc(strlen(buf));
     bcd:	83 ec 0c             	sub    $0xc,%esp
     bd0:	ff 75 10             	pushl  0x10(%ebp)
     bd3:	e8 e5 09 00 00       	call   15bd <strlen>
     bd8:	83 c4 10             	add    $0x10,%esp
     bdb:	83 ec 0c             	sub    $0xc,%esp
     bde:	50                   	push   %eax
     bdf:	e8 e8 0f 00 00       	call   1bcc <malloc>
     be4:	83 c4 10             	add    $0x10,%esp
     be7:	89 c2                	mov    %eax,%edx
     be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bec:	89 50 14             	mov    %edx,0x14(%eax)
	strcpy(newJob->cmd, buf);
     bef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf2:	8b 40 14             	mov    0x14(%eax),%eax
     bf5:	83 ec 08             	sub    $0x8,%esp
     bf8:	ff 75 10             	pushl  0x10(%ebp)
     bfb:	50                   	push   %eax
     bfc:	e8 4d 09 00 00       	call   154e <strcpy>
     c01:	83 c4 10             	add    $0x10,%esp
	return newJob;
     c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c07:	c9                   	leave  
     c08:	c3                   	ret    

00000c09 <getProcess>:

struct jobprocess *getProcess(int pid){
     c09:	55                   	push   %ebp
     c0a:	89 e5                	mov    %esp,%ebp
     c0c:	83 ec 18             	sub    $0x18,%esp
	struct jobprocess *newProcess;

	newProcess = malloc(sizeof(*newProcess));
     c0f:	83 ec 0c             	sub    $0xc,%esp
     c12:	6a 08                	push   $0x8
     c14:	e8 b3 0f 00 00       	call   1bcc <malloc>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	memset(newProcess, 0, sizeof(*newProcess));
     c1f:	83 ec 04             	sub    $0x4,%esp
     c22:	6a 08                	push   $0x8
     c24:	6a 00                	push   $0x0
     c26:	ff 75 f4             	pushl  -0xc(%ebp)
     c29:	e8 b6 09 00 00       	call   15e4 <memset>
     c2e:	83 c4 10             	add    $0x10,%esp
	newProcess->pid = pid;
     c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c34:	8b 55 08             	mov    0x8(%ebp),%edx
     c37:	89 10                	mov    %edx,(%eax)
	newProcess->nextProcess = 0;
     c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	return newProcess;
     c43:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c46:	c9                   	leave  
     c47:	c3                   	ret    

00000c48 <panic>:

void
panic(char *s)
{
     c48:	55                   	push   %ebp
     c49:	89 e5                	mov    %esp,%ebp
     c4b:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     c4e:	83 ec 04             	sub    $0x4,%esp
     c51:	ff 75 08             	pushl  0x8(%ebp)
     c54:	68 85 1d 00 00       	push   $0x1d85
     c59:	6a 02                	push   $0x2
     c5b:	e8 9b 0c 00 00       	call   18fb <printf>
     c60:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
     c63:	83 ec 0c             	sub    $0xc,%esp
     c66:	6a 01                	push   $0x1
     c68:	e8 11 0b 00 00       	call   177e <exit>

00000c6d <fork1>:
}

int
fork1(void)
{
     c6d:	55                   	push   %ebp
     c6e:	89 e5                	mov    %esp,%ebp
     c70:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     c73:	e8 fe 0a 00 00       	call   1776 <fork>
     c78:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     c7b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     c7f:	75 10                	jne    c91 <fork1+0x24>
    panic("fork");
     c81:	83 ec 0c             	sub    $0xc,%esp
     c84:	68 89 1d 00 00       	push   $0x1d89
     c89:	e8 ba ff ff ff       	call   c48 <panic>
     c8e:	83 c4 10             	add    $0x10,%esp
  return pid;
     c91:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c94:	c9                   	leave  
     c95:	c3                   	ret    

00000c96 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     c96:	55                   	push   %ebp
     c97:	89 e5                	mov    %esp,%ebp
     c99:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     c9c:	83 ec 0c             	sub    $0xc,%esp
     c9f:	6a 54                	push   $0x54
     ca1:	e8 26 0f 00 00       	call   1bcc <malloc>
     ca6:	83 c4 10             	add    $0x10,%esp
     ca9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     cac:	83 ec 04             	sub    $0x4,%esp
     caf:	6a 54                	push   $0x54
     cb1:	6a 00                	push   $0x0
     cb3:	ff 75 f4             	pushl  -0xc(%ebp)
     cb6:	e8 29 09 00 00       	call   15e4 <memset>
     cbb:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc1:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     cc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     cca:	c9                   	leave  
     ccb:	c3                   	ret    

00000ccc <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     ccc:	55                   	push   %ebp
     ccd:	89 e5                	mov    %esp,%ebp
     ccf:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     cd2:	83 ec 0c             	sub    $0xc,%esp
     cd5:	6a 18                	push   $0x18
     cd7:	e8 f0 0e 00 00       	call   1bcc <malloc>
     cdc:	83 c4 10             	add    $0x10,%esp
     cdf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     ce2:	83 ec 04             	sub    $0x4,%esp
     ce5:	6a 18                	push   $0x18
     ce7:	6a 00                	push   $0x0
     ce9:	ff 75 f4             	pushl  -0xc(%ebp)
     cec:	e8 f3 08 00 00       	call   15e4 <memset>
     cf1:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf7:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d00:	8b 55 08             	mov    0x8(%ebp),%edx
     d03:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     d06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d09:	8b 55 0c             	mov    0xc(%ebp),%edx
     d0c:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     d0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d12:	8b 55 10             	mov    0x10(%ebp),%edx
     d15:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d1b:	8b 55 14             	mov    0x14(%ebp),%edx
     d1e:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     d21:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d24:	8b 55 18             	mov    0x18(%ebp),%edx
     d27:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     d2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d2d:	c9                   	leave  
     d2e:	c3                   	ret    

00000d2f <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     d2f:	55                   	push   %ebp
     d30:	89 e5                	mov    %esp,%ebp
     d32:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     d35:	83 ec 0c             	sub    $0xc,%esp
     d38:	6a 0c                	push   $0xc
     d3a:	e8 8d 0e 00 00       	call   1bcc <malloc>
     d3f:	83 c4 10             	add    $0x10,%esp
     d42:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     d45:	83 ec 04             	sub    $0x4,%esp
     d48:	6a 0c                	push   $0xc
     d4a:	6a 00                	push   $0x0
     d4c:	ff 75 f4             	pushl  -0xc(%ebp)
     d4f:	e8 90 08 00 00       	call   15e4 <memset>
     d54:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5a:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d63:	8b 55 08             	mov    0x8(%ebp),%edx
     d66:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     d69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d6c:	8b 55 0c             	mov    0xc(%ebp),%edx
     d6f:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     d72:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d75:	c9                   	leave  
     d76:	c3                   	ret    

00000d77 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     d77:	55                   	push   %ebp
     d78:	89 e5                	mov    %esp,%ebp
     d7a:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     d7d:	83 ec 0c             	sub    $0xc,%esp
     d80:	6a 0c                	push   $0xc
     d82:	e8 45 0e 00 00       	call   1bcc <malloc>
     d87:	83 c4 10             	add    $0x10,%esp
     d8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     d8d:	83 ec 04             	sub    $0x4,%esp
     d90:	6a 0c                	push   $0xc
     d92:	6a 00                	push   $0x0
     d94:	ff 75 f4             	pushl  -0xc(%ebp)
     d97:	e8 48 08 00 00       	call   15e4 <memset>
     d9c:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da2:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     da8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dab:	8b 55 08             	mov    0x8(%ebp),%edx
     dae:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db4:	8b 55 0c             	mov    0xc(%ebp),%edx
     db7:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dbd:	c9                   	leave  
     dbe:	c3                   	ret    

00000dbf <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     dbf:	55                   	push   %ebp
     dc0:	89 e5                	mov    %esp,%ebp
     dc2:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     dc5:	83 ec 0c             	sub    $0xc,%esp
     dc8:	6a 08                	push   $0x8
     dca:	e8 fd 0d 00 00       	call   1bcc <malloc>
     dcf:	83 c4 10             	add    $0x10,%esp
     dd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     dd5:	83 ec 04             	sub    $0x4,%esp
     dd8:	6a 08                	push   $0x8
     dda:	6a 00                	push   $0x0
     ddc:	ff 75 f4             	pushl  -0xc(%ebp)
     ddf:	e8 00 08 00 00       	call   15e4 <memset>
     de4:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     de7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dea:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df3:	8b 55 08             	mov    0x8(%ebp),%edx
     df6:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     df9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dfc:	c9                   	leave  
     dfd:	c3                   	ret    

00000dfe <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     dfe:	55                   	push   %ebp
     dff:	89 e5                	mov    %esp,%ebp
     e01:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     e04:	8b 45 08             	mov    0x8(%ebp),%eax
     e07:	8b 00                	mov    (%eax),%eax
     e09:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     e0c:	eb 04                	jmp    e12 <gettoken+0x14>
    s++;
     e0e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     e12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e15:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e18:	73 1e                	jae    e38 <gettoken+0x3a>
     e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e1d:	0f b6 00             	movzbl (%eax),%eax
     e20:	0f be c0             	movsbl %al,%eax
     e23:	83 ec 08             	sub    $0x8,%esp
     e26:	50                   	push   %eax
     e27:	68 e0 23 00 00       	push   $0x23e0
     e2c:	e8 cd 07 00 00       	call   15fe <strchr>
     e31:	83 c4 10             	add    $0x10,%esp
     e34:	85 c0                	test   %eax,%eax
     e36:	75 d6                	jne    e0e <gettoken+0x10>
    s++;
  if(q)
     e38:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e3c:	74 08                	je     e46 <gettoken+0x48>
    *q = s;
     e3e:	8b 45 10             	mov    0x10(%ebp),%eax
     e41:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e44:	89 10                	mov    %edx,(%eax)
  ret = *s;
     e46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e49:	0f b6 00             	movzbl (%eax),%eax
     e4c:	0f be c0             	movsbl %al,%eax
     e4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     e52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e55:	0f b6 00             	movzbl (%eax),%eax
     e58:	0f be c0             	movsbl %al,%eax
     e5b:	83 f8 29             	cmp    $0x29,%eax
     e5e:	7f 14                	jg     e74 <gettoken+0x76>
     e60:	83 f8 28             	cmp    $0x28,%eax
     e63:	7d 28                	jge    e8d <gettoken+0x8f>
     e65:	85 c0                	test   %eax,%eax
     e67:	0f 84 96 00 00 00    	je     f03 <gettoken+0x105>
     e6d:	83 f8 26             	cmp    $0x26,%eax
     e70:	74 1b                	je     e8d <gettoken+0x8f>
     e72:	eb 3c                	jmp    eb0 <gettoken+0xb2>
     e74:	83 f8 3e             	cmp    $0x3e,%eax
     e77:	74 1a                	je     e93 <gettoken+0x95>
     e79:	83 f8 3e             	cmp    $0x3e,%eax
     e7c:	7f 0a                	jg     e88 <gettoken+0x8a>
     e7e:	83 e8 3b             	sub    $0x3b,%eax
     e81:	83 f8 01             	cmp    $0x1,%eax
     e84:	77 2a                	ja     eb0 <gettoken+0xb2>
     e86:	eb 05                	jmp    e8d <gettoken+0x8f>
     e88:	83 f8 7c             	cmp    $0x7c,%eax
     e8b:	75 23                	jne    eb0 <gettoken+0xb2>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     e8d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     e91:	eb 71                	jmp    f04 <gettoken+0x106>
  case '>':
    s++;
     e93:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     e97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e9a:	0f b6 00             	movzbl (%eax),%eax
     e9d:	3c 3e                	cmp    $0x3e,%al
     e9f:	75 0d                	jne    eae <gettoken+0xb0>
      ret = '+';
     ea1:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     ea8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     eac:	eb 56                	jmp    f04 <gettoken+0x106>
     eae:	eb 54                	jmp    f04 <gettoken+0x106>
  default:
    ret = 'a';
     eb0:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     eb7:	eb 04                	jmp    ebd <gettoken+0xbf>
      s++;
     eb9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ec3:	73 3c                	jae    f01 <gettoken+0x103>
     ec5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ec8:	0f b6 00             	movzbl (%eax),%eax
     ecb:	0f be c0             	movsbl %al,%eax
     ece:	83 ec 08             	sub    $0x8,%esp
     ed1:	50                   	push   %eax
     ed2:	68 e0 23 00 00       	push   $0x23e0
     ed7:	e8 22 07 00 00       	call   15fe <strchr>
     edc:	83 c4 10             	add    $0x10,%esp
     edf:	85 c0                	test   %eax,%eax
     ee1:	75 1e                	jne    f01 <gettoken+0x103>
     ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ee6:	0f b6 00             	movzbl (%eax),%eax
     ee9:	0f be c0             	movsbl %al,%eax
     eec:	83 ec 08             	sub    $0x8,%esp
     eef:	50                   	push   %eax
     ef0:	68 e6 23 00 00       	push   $0x23e6
     ef5:	e8 04 07 00 00       	call   15fe <strchr>
     efa:	83 c4 10             	add    $0x10,%esp
     efd:	85 c0                	test   %eax,%eax
     eff:	74 b8                	je     eb9 <gettoken+0xbb>
      s++;
    break;
     f01:	eb 01                	jmp    f04 <gettoken+0x106>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     f03:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     f04:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     f08:	74 08                	je     f12 <gettoken+0x114>
    *eq = s;
     f0a:	8b 45 14             	mov    0x14(%ebp),%eax
     f0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f10:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     f12:	eb 04                	jmp    f18 <gettoken+0x11a>
    s++;
     f14:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     f18:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f1b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f1e:	73 1e                	jae    f3e <gettoken+0x140>
     f20:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f23:	0f b6 00             	movzbl (%eax),%eax
     f26:	0f be c0             	movsbl %al,%eax
     f29:	83 ec 08             	sub    $0x8,%esp
     f2c:	50                   	push   %eax
     f2d:	68 e0 23 00 00       	push   $0x23e0
     f32:	e8 c7 06 00 00       	call   15fe <strchr>
     f37:	83 c4 10             	add    $0x10,%esp
     f3a:	85 c0                	test   %eax,%eax
     f3c:	75 d6                	jne    f14 <gettoken+0x116>
    s++;
  *ps = s;
     f3e:	8b 45 08             	mov    0x8(%ebp),%eax
     f41:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f44:	89 10                	mov    %edx,(%eax)
  return ret;
     f46:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     f49:	c9                   	leave  
     f4a:	c3                   	ret    

00000f4b <peek>:

int
peek(char **ps, char *es, char *toks)
{
     f4b:	55                   	push   %ebp
     f4c:	89 e5                	mov    %esp,%ebp
     f4e:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     f51:	8b 45 08             	mov    0x8(%ebp),%eax
     f54:	8b 00                	mov    (%eax),%eax
     f56:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     f59:	eb 04                	jmp    f5f <peek+0x14>
    s++;
     f5b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     f5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f62:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f65:	73 1e                	jae    f85 <peek+0x3a>
     f67:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f6a:	0f b6 00             	movzbl (%eax),%eax
     f6d:	0f be c0             	movsbl %al,%eax
     f70:	83 ec 08             	sub    $0x8,%esp
     f73:	50                   	push   %eax
     f74:	68 e0 23 00 00       	push   $0x23e0
     f79:	e8 80 06 00 00       	call   15fe <strchr>
     f7e:	83 c4 10             	add    $0x10,%esp
     f81:	85 c0                	test   %eax,%eax
     f83:	75 d6                	jne    f5b <peek+0x10>
    s++;
  *ps = s;
     f85:	8b 45 08             	mov    0x8(%ebp),%eax
     f88:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f8b:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     f8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f90:	0f b6 00             	movzbl (%eax),%eax
     f93:	84 c0                	test   %al,%al
     f95:	74 23                	je     fba <peek+0x6f>
     f97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f9a:	0f b6 00             	movzbl (%eax),%eax
     f9d:	0f be c0             	movsbl %al,%eax
     fa0:	83 ec 08             	sub    $0x8,%esp
     fa3:	50                   	push   %eax
     fa4:	ff 75 10             	pushl  0x10(%ebp)
     fa7:	e8 52 06 00 00       	call   15fe <strchr>
     fac:	83 c4 10             	add    $0x10,%esp
     faf:	85 c0                	test   %eax,%eax
     fb1:	74 07                	je     fba <peek+0x6f>
     fb3:	b8 01 00 00 00       	mov    $0x1,%eax
     fb8:	eb 05                	jmp    fbf <peek+0x74>
     fba:	b8 00 00 00 00       	mov    $0x0,%eax
}
     fbf:	c9                   	leave  
     fc0:	c3                   	ret    

00000fc1 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     fc1:	55                   	push   %ebp
     fc2:	89 e5                	mov    %esp,%ebp
     fc4:	53                   	push   %ebx
     fc5:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     fc8:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fcb:	8b 45 08             	mov    0x8(%ebp),%eax
     fce:	83 ec 0c             	sub    $0xc,%esp
     fd1:	50                   	push   %eax
     fd2:	e8 e6 05 00 00       	call   15bd <strlen>
     fd7:	83 c4 10             	add    $0x10,%esp
     fda:	01 d8                	add    %ebx,%eax
     fdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     fdf:	83 ec 08             	sub    $0x8,%esp
     fe2:	ff 75 f4             	pushl  -0xc(%ebp)
     fe5:	8d 45 08             	lea    0x8(%ebp),%eax
     fe8:	50                   	push   %eax
     fe9:	e8 61 00 00 00       	call   104f <parseline>
     fee:	83 c4 10             	add    $0x10,%esp
     ff1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     ff4:	83 ec 04             	sub    $0x4,%esp
     ff7:	68 8e 1d 00 00       	push   $0x1d8e
     ffc:	ff 75 f4             	pushl  -0xc(%ebp)
     fff:	8d 45 08             	lea    0x8(%ebp),%eax
    1002:	50                   	push   %eax
    1003:	e8 43 ff ff ff       	call   f4b <peek>
    1008:	83 c4 10             	add    $0x10,%esp
  if(s != es){
    100b:	8b 45 08             	mov    0x8(%ebp),%eax
    100e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1011:	74 26                	je     1039 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
    1013:	8b 45 08             	mov    0x8(%ebp),%eax
    1016:	83 ec 04             	sub    $0x4,%esp
    1019:	50                   	push   %eax
    101a:	68 8f 1d 00 00       	push   $0x1d8f
    101f:	6a 02                	push   $0x2
    1021:	e8 d5 08 00 00       	call   18fb <printf>
    1026:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
    1029:	83 ec 0c             	sub    $0xc,%esp
    102c:	68 9e 1d 00 00       	push   $0x1d9e
    1031:	e8 12 fc ff ff       	call   c48 <panic>
    1036:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
    1039:	83 ec 0c             	sub    $0xc,%esp
    103c:	ff 75 f0             	pushl  -0x10(%ebp)
    103f:	e8 e9 03 00 00       	call   142d <nulterminate>
    1044:	83 c4 10             	add    $0x10,%esp
  return cmd;
    1047:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    104a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    104d:	c9                   	leave  
    104e:	c3                   	ret    

0000104f <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
    104f:	55                   	push   %ebp
    1050:	89 e5                	mov    %esp,%ebp
    1052:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
    1055:	83 ec 08             	sub    $0x8,%esp
    1058:	ff 75 0c             	pushl  0xc(%ebp)
    105b:	ff 75 08             	pushl  0x8(%ebp)
    105e:	e8 99 00 00 00       	call   10fc <parsepipe>
    1063:	83 c4 10             	add    $0x10,%esp
    1066:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
    1069:	eb 23                	jmp    108e <parseline+0x3f>
    gettoken(ps, es, 0, 0);
    106b:	6a 00                	push   $0x0
    106d:	6a 00                	push   $0x0
    106f:	ff 75 0c             	pushl  0xc(%ebp)
    1072:	ff 75 08             	pushl  0x8(%ebp)
    1075:	e8 84 fd ff ff       	call   dfe <gettoken>
    107a:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
    107d:	83 ec 0c             	sub    $0xc,%esp
    1080:	ff 75 f4             	pushl  -0xc(%ebp)
    1083:	e8 37 fd ff ff       	call   dbf <backcmd>
    1088:	83 c4 10             	add    $0x10,%esp
    108b:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    108e:	83 ec 04             	sub    $0x4,%esp
    1091:	68 a5 1d 00 00       	push   $0x1da5
    1096:	ff 75 0c             	pushl  0xc(%ebp)
    1099:	ff 75 08             	pushl  0x8(%ebp)
    109c:	e8 aa fe ff ff       	call   f4b <peek>
    10a1:	83 c4 10             	add    $0x10,%esp
    10a4:	85 c0                	test   %eax,%eax
    10a6:	75 c3                	jne    106b <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    10a8:	83 ec 04             	sub    $0x4,%esp
    10ab:	68 a7 1d 00 00       	push   $0x1da7
    10b0:	ff 75 0c             	pushl  0xc(%ebp)
    10b3:	ff 75 08             	pushl  0x8(%ebp)
    10b6:	e8 90 fe ff ff       	call   f4b <peek>
    10bb:	83 c4 10             	add    $0x10,%esp
    10be:	85 c0                	test   %eax,%eax
    10c0:	74 35                	je     10f7 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
    10c2:	6a 00                	push   $0x0
    10c4:	6a 00                	push   $0x0
    10c6:	ff 75 0c             	pushl  0xc(%ebp)
    10c9:	ff 75 08             	pushl  0x8(%ebp)
    10cc:	e8 2d fd ff ff       	call   dfe <gettoken>
    10d1:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
    10d4:	83 ec 08             	sub    $0x8,%esp
    10d7:	ff 75 0c             	pushl  0xc(%ebp)
    10da:	ff 75 08             	pushl  0x8(%ebp)
    10dd:	e8 6d ff ff ff       	call   104f <parseline>
    10e2:	83 c4 10             	add    $0x10,%esp
    10e5:	83 ec 08             	sub    $0x8,%esp
    10e8:	50                   	push   %eax
    10e9:	ff 75 f4             	pushl  -0xc(%ebp)
    10ec:	e8 86 fc ff ff       	call   d77 <listcmd>
    10f1:	83 c4 10             	add    $0x10,%esp
    10f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    10f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10fa:	c9                   	leave  
    10fb:	c3                   	ret    

000010fc <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
    10fc:	55                   	push   %ebp
    10fd:	89 e5                	mov    %esp,%ebp
    10ff:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
    1102:	83 ec 08             	sub    $0x8,%esp
    1105:	ff 75 0c             	pushl  0xc(%ebp)
    1108:	ff 75 08             	pushl  0x8(%ebp)
    110b:	e8 ec 01 00 00       	call   12fc <parseexec>
    1110:	83 c4 10             	add    $0x10,%esp
    1113:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
    1116:	83 ec 04             	sub    $0x4,%esp
    1119:	68 a9 1d 00 00       	push   $0x1da9
    111e:	ff 75 0c             	pushl  0xc(%ebp)
    1121:	ff 75 08             	pushl  0x8(%ebp)
    1124:	e8 22 fe ff ff       	call   f4b <peek>
    1129:	83 c4 10             	add    $0x10,%esp
    112c:	85 c0                	test   %eax,%eax
    112e:	74 35                	je     1165 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
    1130:	6a 00                	push   $0x0
    1132:	6a 00                	push   $0x0
    1134:	ff 75 0c             	pushl  0xc(%ebp)
    1137:	ff 75 08             	pushl  0x8(%ebp)
    113a:	e8 bf fc ff ff       	call   dfe <gettoken>
    113f:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
    1142:	83 ec 08             	sub    $0x8,%esp
    1145:	ff 75 0c             	pushl  0xc(%ebp)
    1148:	ff 75 08             	pushl  0x8(%ebp)
    114b:	e8 ac ff ff ff       	call   10fc <parsepipe>
    1150:	83 c4 10             	add    $0x10,%esp
    1153:	83 ec 08             	sub    $0x8,%esp
    1156:	50                   	push   %eax
    1157:	ff 75 f4             	pushl  -0xc(%ebp)
    115a:	e8 d0 fb ff ff       	call   d2f <pipecmd>
    115f:	83 c4 10             	add    $0x10,%esp
    1162:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    1165:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1168:	c9                   	leave  
    1169:	c3                   	ret    

0000116a <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    116a:	55                   	push   %ebp
    116b:	89 e5                	mov    %esp,%ebp
    116d:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    1170:	e9 b6 00 00 00       	jmp    122b <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
    1175:	6a 00                	push   $0x0
    1177:	6a 00                	push   $0x0
    1179:	ff 75 10             	pushl  0x10(%ebp)
    117c:	ff 75 0c             	pushl  0xc(%ebp)
    117f:	e8 7a fc ff ff       	call   dfe <gettoken>
    1184:	83 c4 10             	add    $0x10,%esp
    1187:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
    118a:	8d 45 ec             	lea    -0x14(%ebp),%eax
    118d:	50                   	push   %eax
    118e:	8d 45 f0             	lea    -0x10(%ebp),%eax
    1191:	50                   	push   %eax
    1192:	ff 75 10             	pushl  0x10(%ebp)
    1195:	ff 75 0c             	pushl  0xc(%ebp)
    1198:	e8 61 fc ff ff       	call   dfe <gettoken>
    119d:	83 c4 10             	add    $0x10,%esp
    11a0:	83 f8 61             	cmp    $0x61,%eax
    11a3:	74 10                	je     11b5 <parseredirs+0x4b>
      panic("missing file for redirection");
    11a5:	83 ec 0c             	sub    $0xc,%esp
    11a8:	68 ab 1d 00 00       	push   $0x1dab
    11ad:	e8 96 fa ff ff       	call   c48 <panic>
    11b2:	83 c4 10             	add    $0x10,%esp
    switch(tok){
    11b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b8:	83 f8 3c             	cmp    $0x3c,%eax
    11bb:	74 0c                	je     11c9 <parseredirs+0x5f>
    11bd:	83 f8 3e             	cmp    $0x3e,%eax
    11c0:	74 26                	je     11e8 <parseredirs+0x7e>
    11c2:	83 f8 2b             	cmp    $0x2b,%eax
    11c5:	74 43                	je     120a <parseredirs+0xa0>
    11c7:	eb 62                	jmp    122b <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    11c9:	8b 55 ec             	mov    -0x14(%ebp),%edx
    11cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11cf:	83 ec 0c             	sub    $0xc,%esp
    11d2:	6a 00                	push   $0x0
    11d4:	6a 00                	push   $0x0
    11d6:	52                   	push   %edx
    11d7:	50                   	push   %eax
    11d8:	ff 75 08             	pushl  0x8(%ebp)
    11db:	e8 ec fa ff ff       	call   ccc <redircmd>
    11e0:	83 c4 20             	add    $0x20,%esp
    11e3:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    11e6:	eb 43                	jmp    122b <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    11e8:	8b 55 ec             	mov    -0x14(%ebp),%edx
    11eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11ee:	83 ec 0c             	sub    $0xc,%esp
    11f1:	6a 01                	push   $0x1
    11f3:	68 01 02 00 00       	push   $0x201
    11f8:	52                   	push   %edx
    11f9:	50                   	push   %eax
    11fa:	ff 75 08             	pushl  0x8(%ebp)
    11fd:	e8 ca fa ff ff       	call   ccc <redircmd>
    1202:	83 c4 20             	add    $0x20,%esp
    1205:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1208:	eb 21                	jmp    122b <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    120a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    120d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1210:	83 ec 0c             	sub    $0xc,%esp
    1213:	6a 01                	push   $0x1
    1215:	68 01 02 00 00       	push   $0x201
    121a:	52                   	push   %edx
    121b:	50                   	push   %eax
    121c:	ff 75 08             	pushl  0x8(%ebp)
    121f:	e8 a8 fa ff ff       	call   ccc <redircmd>
    1224:	83 c4 20             	add    $0x20,%esp
    1227:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    122a:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    122b:	83 ec 04             	sub    $0x4,%esp
    122e:	68 c8 1d 00 00       	push   $0x1dc8
    1233:	ff 75 10             	pushl  0x10(%ebp)
    1236:	ff 75 0c             	pushl  0xc(%ebp)
    1239:	e8 0d fd ff ff       	call   f4b <peek>
    123e:	83 c4 10             	add    $0x10,%esp
    1241:	85 c0                	test   %eax,%eax
    1243:	0f 85 2c ff ff ff    	jne    1175 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
    1249:	8b 45 08             	mov    0x8(%ebp),%eax
}
    124c:	c9                   	leave  
    124d:	c3                   	ret    

0000124e <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
    124e:	55                   	push   %ebp
    124f:	89 e5                	mov    %esp,%ebp
    1251:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    1254:	83 ec 04             	sub    $0x4,%esp
    1257:	68 cb 1d 00 00       	push   $0x1dcb
    125c:	ff 75 0c             	pushl  0xc(%ebp)
    125f:	ff 75 08             	pushl  0x8(%ebp)
    1262:	e8 e4 fc ff ff       	call   f4b <peek>
    1267:	83 c4 10             	add    $0x10,%esp
    126a:	85 c0                	test   %eax,%eax
    126c:	75 10                	jne    127e <parseblock+0x30>
    panic("parseblock");
    126e:	83 ec 0c             	sub    $0xc,%esp
    1271:	68 cd 1d 00 00       	push   $0x1dcd
    1276:	e8 cd f9 ff ff       	call   c48 <panic>
    127b:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    127e:	6a 00                	push   $0x0
    1280:	6a 00                	push   $0x0
    1282:	ff 75 0c             	pushl  0xc(%ebp)
    1285:	ff 75 08             	pushl  0x8(%ebp)
    1288:	e8 71 fb ff ff       	call   dfe <gettoken>
    128d:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
    1290:	83 ec 08             	sub    $0x8,%esp
    1293:	ff 75 0c             	pushl  0xc(%ebp)
    1296:	ff 75 08             	pushl  0x8(%ebp)
    1299:	e8 b1 fd ff ff       	call   104f <parseline>
    129e:	83 c4 10             	add    $0x10,%esp
    12a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
    12a4:	83 ec 04             	sub    $0x4,%esp
    12a7:	68 d8 1d 00 00       	push   $0x1dd8
    12ac:	ff 75 0c             	pushl  0xc(%ebp)
    12af:	ff 75 08             	pushl  0x8(%ebp)
    12b2:	e8 94 fc ff ff       	call   f4b <peek>
    12b7:	83 c4 10             	add    $0x10,%esp
    12ba:	85 c0                	test   %eax,%eax
    12bc:	75 10                	jne    12ce <parseblock+0x80>
    panic("syntax - missing )");
    12be:	83 ec 0c             	sub    $0xc,%esp
    12c1:	68 da 1d 00 00       	push   $0x1dda
    12c6:	e8 7d f9 ff ff       	call   c48 <panic>
    12cb:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    12ce:	6a 00                	push   $0x0
    12d0:	6a 00                	push   $0x0
    12d2:	ff 75 0c             	pushl  0xc(%ebp)
    12d5:	ff 75 08             	pushl  0x8(%ebp)
    12d8:	e8 21 fb ff ff       	call   dfe <gettoken>
    12dd:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
    12e0:	83 ec 04             	sub    $0x4,%esp
    12e3:	ff 75 0c             	pushl  0xc(%ebp)
    12e6:	ff 75 08             	pushl  0x8(%ebp)
    12e9:	ff 75 f4             	pushl  -0xc(%ebp)
    12ec:	e8 79 fe ff ff       	call   116a <parseredirs>
    12f1:	83 c4 10             	add    $0x10,%esp
    12f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
    12f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    12fa:	c9                   	leave  
    12fb:	c3                   	ret    

000012fc <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
    12fc:	55                   	push   %ebp
    12fd:	89 e5                	mov    %esp,%ebp
    12ff:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    1302:	83 ec 04             	sub    $0x4,%esp
    1305:	68 cb 1d 00 00       	push   $0x1dcb
    130a:	ff 75 0c             	pushl  0xc(%ebp)
    130d:	ff 75 08             	pushl  0x8(%ebp)
    1310:	e8 36 fc ff ff       	call   f4b <peek>
    1315:	83 c4 10             	add    $0x10,%esp
    1318:	85 c0                	test   %eax,%eax
    131a:	74 16                	je     1332 <parseexec+0x36>
    return parseblock(ps, es);
    131c:	83 ec 08             	sub    $0x8,%esp
    131f:	ff 75 0c             	pushl  0xc(%ebp)
    1322:	ff 75 08             	pushl  0x8(%ebp)
    1325:	e8 24 ff ff ff       	call   124e <parseblock>
    132a:	83 c4 10             	add    $0x10,%esp
    132d:	e9 f9 00 00 00       	jmp    142b <parseexec+0x12f>

  ret = execcmd();
    1332:	e8 5f f9 ff ff       	call   c96 <execcmd>
    1337:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
    133a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    133d:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
    1340:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
    1347:	83 ec 04             	sub    $0x4,%esp
    134a:	ff 75 0c             	pushl  0xc(%ebp)
    134d:	ff 75 08             	pushl  0x8(%ebp)
    1350:	ff 75 f0             	pushl  -0x10(%ebp)
    1353:	e8 12 fe ff ff       	call   116a <parseredirs>
    1358:	83 c4 10             	add    $0x10,%esp
    135b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
    135e:	e9 88 00 00 00       	jmp    13eb <parseexec+0xef>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    1363:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1366:	50                   	push   %eax
    1367:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    136a:	50                   	push   %eax
    136b:	ff 75 0c             	pushl  0xc(%ebp)
    136e:	ff 75 08             	pushl  0x8(%ebp)
    1371:	e8 88 fa ff ff       	call   dfe <gettoken>
    1376:	83 c4 10             	add    $0x10,%esp
    1379:	89 45 e8             	mov    %eax,-0x18(%ebp)
    137c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1380:	75 05                	jne    1387 <parseexec+0x8b>
      break;
    1382:	e9 82 00 00 00       	jmp    1409 <parseexec+0x10d>
    if(tok != 'a')
    1387:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
    138b:	74 10                	je     139d <parseexec+0xa1>
      panic("syntax");
    138d:	83 ec 0c             	sub    $0xc,%esp
    1390:	68 9e 1d 00 00       	push   $0x1d9e
    1395:	e8 ae f8 ff ff       	call   c48 <panic>
    139a:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
    139d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    13a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13a6:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
    13aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
    13ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13b0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13b3:	83 c1 08             	add    $0x8,%ecx
    13b6:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
    13ba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
    13be:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    13c2:	7e 10                	jle    13d4 <parseexec+0xd8>
      panic("too many args");
    13c4:	83 ec 0c             	sub    $0xc,%esp
    13c7:	68 ed 1d 00 00       	push   $0x1ded
    13cc:	e8 77 f8 ff ff       	call   c48 <panic>
    13d1:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
    13d4:	83 ec 04             	sub    $0x4,%esp
    13d7:	ff 75 0c             	pushl  0xc(%ebp)
    13da:	ff 75 08             	pushl  0x8(%ebp)
    13dd:	ff 75 f0             	pushl  -0x10(%ebp)
    13e0:	e8 85 fd ff ff       	call   116a <parseredirs>
    13e5:	83 c4 10             	add    $0x10,%esp
    13e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    13eb:	83 ec 04             	sub    $0x4,%esp
    13ee:	68 fb 1d 00 00       	push   $0x1dfb
    13f3:	ff 75 0c             	pushl  0xc(%ebp)
    13f6:	ff 75 08             	pushl  0x8(%ebp)
    13f9:	e8 4d fb ff ff       	call   f4b <peek>
    13fe:	83 c4 10             	add    $0x10,%esp
    1401:	85 c0                	test   %eax,%eax
    1403:	0f 84 5a ff ff ff    	je     1363 <parseexec+0x67>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
    1409:	8b 45 ec             	mov    -0x14(%ebp),%eax
    140c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    140f:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
    1416:	00 
  cmd->eargv[argc] = 0;
    1417:	8b 45 ec             	mov    -0x14(%ebp),%eax
    141a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    141d:	83 c2 08             	add    $0x8,%edx
    1420:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
    1427:	00 
  return ret;
    1428:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    142b:	c9                   	leave  
    142c:	c3                   	ret    

0000142d <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    142d:	55                   	push   %ebp
    142e:	89 e5                	mov    %esp,%ebp
    1430:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    1433:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1437:	75 0a                	jne    1443 <nulterminate+0x16>
    return 0;
    1439:	b8 00 00 00 00       	mov    $0x0,%eax
    143e:	e9 e4 00 00 00       	jmp    1527 <nulterminate+0xfa>
  
  switch(cmd->type){
    1443:	8b 45 08             	mov    0x8(%ebp),%eax
    1446:	8b 00                	mov    (%eax),%eax
    1448:	83 f8 05             	cmp    $0x5,%eax
    144b:	0f 87 d3 00 00 00    	ja     1524 <nulterminate+0xf7>
    1451:	8b 04 85 00 1e 00 00 	mov    0x1e00(,%eax,4),%eax
    1458:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    145a:	8b 45 08             	mov    0x8(%ebp),%eax
    145d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
    1460:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1467:	eb 14                	jmp    147d <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
    1469:	8b 45 f0             	mov    -0x10(%ebp),%eax
    146c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    146f:	83 c2 08             	add    $0x8,%edx
    1472:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
    1476:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    1479:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    147d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1480:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1483:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
    1487:	85 c0                	test   %eax,%eax
    1489:	75 de                	jne    1469 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
    148b:	e9 94 00 00 00       	jmp    1524 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    1490:	8b 45 08             	mov    0x8(%ebp),%eax
    1493:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
    1496:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1499:	8b 40 04             	mov    0x4(%eax),%eax
    149c:	83 ec 0c             	sub    $0xc,%esp
    149f:	50                   	push   %eax
    14a0:	e8 88 ff ff ff       	call   142d <nulterminate>
    14a5:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    14a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14ab:	8b 40 0c             	mov    0xc(%eax),%eax
    14ae:	c6 00 00             	movb   $0x0,(%eax)
    break;
    14b1:	eb 71                	jmp    1524 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    14b3:	8b 45 08             	mov    0x8(%ebp),%eax
    14b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
    14b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14bc:	8b 40 04             	mov    0x4(%eax),%eax
    14bf:	83 ec 0c             	sub    $0xc,%esp
    14c2:	50                   	push   %eax
    14c3:	e8 65 ff ff ff       	call   142d <nulterminate>
    14c8:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
    14cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14ce:	8b 40 08             	mov    0x8(%eax),%eax
    14d1:	83 ec 0c             	sub    $0xc,%esp
    14d4:	50                   	push   %eax
    14d5:	e8 53 ff ff ff       	call   142d <nulterminate>
    14da:	83 c4 10             	add    $0x10,%esp
    break;
    14dd:	eb 45                	jmp    1524 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    14df:	8b 45 08             	mov    0x8(%ebp),%eax
    14e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
    14e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14e8:	8b 40 04             	mov    0x4(%eax),%eax
    14eb:	83 ec 0c             	sub    $0xc,%esp
    14ee:	50                   	push   %eax
    14ef:	e8 39 ff ff ff       	call   142d <nulterminate>
    14f4:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
    14f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14fa:	8b 40 08             	mov    0x8(%eax),%eax
    14fd:	83 ec 0c             	sub    $0xc,%esp
    1500:	50                   	push   %eax
    1501:	e8 27 ff ff ff       	call   142d <nulterminate>
    1506:	83 c4 10             	add    $0x10,%esp
    break;
    1509:	eb 19                	jmp    1524 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    150b:	8b 45 08             	mov    0x8(%ebp),%eax
    150e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
    1511:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1514:	8b 40 04             	mov    0x4(%eax),%eax
    1517:	83 ec 0c             	sub    $0xc,%esp
    151a:	50                   	push   %eax
    151b:	e8 0d ff ff ff       	call   142d <nulterminate>
    1520:	83 c4 10             	add    $0x10,%esp
    break;
    1523:	90                   	nop
  }
  return cmd;
    1524:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1527:	c9                   	leave  
    1528:	c3                   	ret    

00001529 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1529:	55                   	push   %ebp
    152a:	89 e5                	mov    %esp,%ebp
    152c:	57                   	push   %edi
    152d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    152e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1531:	8b 55 10             	mov    0x10(%ebp),%edx
    1534:	8b 45 0c             	mov    0xc(%ebp),%eax
    1537:	89 cb                	mov    %ecx,%ebx
    1539:	89 df                	mov    %ebx,%edi
    153b:	89 d1                	mov    %edx,%ecx
    153d:	fc                   	cld    
    153e:	f3 aa                	rep stos %al,%es:(%edi)
    1540:	89 ca                	mov    %ecx,%edx
    1542:	89 fb                	mov    %edi,%ebx
    1544:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1547:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    154a:	5b                   	pop    %ebx
    154b:	5f                   	pop    %edi
    154c:	5d                   	pop    %ebp
    154d:	c3                   	ret    

0000154e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    154e:	55                   	push   %ebp
    154f:	89 e5                	mov    %esp,%ebp
    1551:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1554:	8b 45 08             	mov    0x8(%ebp),%eax
    1557:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    155a:	90                   	nop
    155b:	8b 45 08             	mov    0x8(%ebp),%eax
    155e:	8d 50 01             	lea    0x1(%eax),%edx
    1561:	89 55 08             	mov    %edx,0x8(%ebp)
    1564:	8b 55 0c             	mov    0xc(%ebp),%edx
    1567:	8d 4a 01             	lea    0x1(%edx),%ecx
    156a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    156d:	0f b6 12             	movzbl (%edx),%edx
    1570:	88 10                	mov    %dl,(%eax)
    1572:	0f b6 00             	movzbl (%eax),%eax
    1575:	84 c0                	test   %al,%al
    1577:	75 e2                	jne    155b <strcpy+0xd>
    ;
  return os;
    1579:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    157c:	c9                   	leave  
    157d:	c3                   	ret    

0000157e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    157e:	55                   	push   %ebp
    157f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1581:	eb 08                	jmp    158b <strcmp+0xd>
    p++, q++;
    1583:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1587:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    158b:	8b 45 08             	mov    0x8(%ebp),%eax
    158e:	0f b6 00             	movzbl (%eax),%eax
    1591:	84 c0                	test   %al,%al
    1593:	74 10                	je     15a5 <strcmp+0x27>
    1595:	8b 45 08             	mov    0x8(%ebp),%eax
    1598:	0f b6 10             	movzbl (%eax),%edx
    159b:	8b 45 0c             	mov    0xc(%ebp),%eax
    159e:	0f b6 00             	movzbl (%eax),%eax
    15a1:	38 c2                	cmp    %al,%dl
    15a3:	74 de                	je     1583 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    15a5:	8b 45 08             	mov    0x8(%ebp),%eax
    15a8:	0f b6 00             	movzbl (%eax),%eax
    15ab:	0f b6 d0             	movzbl %al,%edx
    15ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    15b1:	0f b6 00             	movzbl (%eax),%eax
    15b4:	0f b6 c0             	movzbl %al,%eax
    15b7:	29 c2                	sub    %eax,%edx
    15b9:	89 d0                	mov    %edx,%eax
}
    15bb:	5d                   	pop    %ebp
    15bc:	c3                   	ret    

000015bd <strlen>:

uint
strlen(char *s)
{
    15bd:	55                   	push   %ebp
    15be:	89 e5                	mov    %esp,%ebp
    15c0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    15c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    15ca:	eb 04                	jmp    15d0 <strlen+0x13>
    15cc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    15d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
    15d3:	8b 45 08             	mov    0x8(%ebp),%eax
    15d6:	01 d0                	add    %edx,%eax
    15d8:	0f b6 00             	movzbl (%eax),%eax
    15db:	84 c0                	test   %al,%al
    15dd:	75 ed                	jne    15cc <strlen+0xf>
    ;
  return n;
    15df:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15e2:	c9                   	leave  
    15e3:	c3                   	ret    

000015e4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    15e4:	55                   	push   %ebp
    15e5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    15e7:	8b 45 10             	mov    0x10(%ebp),%eax
    15ea:	50                   	push   %eax
    15eb:	ff 75 0c             	pushl  0xc(%ebp)
    15ee:	ff 75 08             	pushl  0x8(%ebp)
    15f1:	e8 33 ff ff ff       	call   1529 <stosb>
    15f6:	83 c4 0c             	add    $0xc,%esp
  return dst;
    15f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15fc:	c9                   	leave  
    15fd:	c3                   	ret    

000015fe <strchr>:

char*
strchr(const char *s, char c)
{
    15fe:	55                   	push   %ebp
    15ff:	89 e5                	mov    %esp,%ebp
    1601:	83 ec 04             	sub    $0x4,%esp
    1604:	8b 45 0c             	mov    0xc(%ebp),%eax
    1607:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    160a:	eb 14                	jmp    1620 <strchr+0x22>
    if(*s == c)
    160c:	8b 45 08             	mov    0x8(%ebp),%eax
    160f:	0f b6 00             	movzbl (%eax),%eax
    1612:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1615:	75 05                	jne    161c <strchr+0x1e>
      return (char*)s;
    1617:	8b 45 08             	mov    0x8(%ebp),%eax
    161a:	eb 13                	jmp    162f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    161c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1620:	8b 45 08             	mov    0x8(%ebp),%eax
    1623:	0f b6 00             	movzbl (%eax),%eax
    1626:	84 c0                	test   %al,%al
    1628:	75 e2                	jne    160c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    162a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    162f:	c9                   	leave  
    1630:	c3                   	ret    

00001631 <gets>:

char*
gets(char *buf, int max)
{
    1631:	55                   	push   %ebp
    1632:	89 e5                	mov    %esp,%ebp
    1634:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1637:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    163e:	eb 44                	jmp    1684 <gets+0x53>
    cc = read(0, &c, 1);
    1640:	83 ec 04             	sub    $0x4,%esp
    1643:	6a 01                	push   $0x1
    1645:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1648:	50                   	push   %eax
    1649:	6a 00                	push   $0x0
    164b:	e8 46 01 00 00       	call   1796 <read>
    1650:	83 c4 10             	add    $0x10,%esp
    1653:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1656:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    165a:	7f 02                	jg     165e <gets+0x2d>
      break;
    165c:	eb 31                	jmp    168f <gets+0x5e>
    buf[i++] = c;
    165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1661:	8d 50 01             	lea    0x1(%eax),%edx
    1664:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1667:	89 c2                	mov    %eax,%edx
    1669:	8b 45 08             	mov    0x8(%ebp),%eax
    166c:	01 c2                	add    %eax,%edx
    166e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1672:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1674:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1678:	3c 0a                	cmp    $0xa,%al
    167a:	74 13                	je     168f <gets+0x5e>
    167c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1680:	3c 0d                	cmp    $0xd,%al
    1682:	74 0b                	je     168f <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1684:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1687:	83 c0 01             	add    $0x1,%eax
    168a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    168d:	7c b1                	jl     1640 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    168f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1692:	8b 45 08             	mov    0x8(%ebp),%eax
    1695:	01 d0                	add    %edx,%eax
    1697:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    169a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    169d:	c9                   	leave  
    169e:	c3                   	ret    

0000169f <stat>:

int
stat(char *n, struct stat *st)
{
    169f:	55                   	push   %ebp
    16a0:	89 e5                	mov    %esp,%ebp
    16a2:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    16a5:	83 ec 08             	sub    $0x8,%esp
    16a8:	6a 00                	push   $0x0
    16aa:	ff 75 08             	pushl  0x8(%ebp)
    16ad:	e8 0c 01 00 00       	call   17be <open>
    16b2:	83 c4 10             	add    $0x10,%esp
    16b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    16b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16bc:	79 07                	jns    16c5 <stat+0x26>
    return -1;
    16be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    16c3:	eb 25                	jmp    16ea <stat+0x4b>
  r = fstat(fd, st);
    16c5:	83 ec 08             	sub    $0x8,%esp
    16c8:	ff 75 0c             	pushl  0xc(%ebp)
    16cb:	ff 75 f4             	pushl  -0xc(%ebp)
    16ce:	e8 03 01 00 00       	call   17d6 <fstat>
    16d3:	83 c4 10             	add    $0x10,%esp
    16d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    16d9:	83 ec 0c             	sub    $0xc,%esp
    16dc:	ff 75 f4             	pushl  -0xc(%ebp)
    16df:	e8 c2 00 00 00       	call   17a6 <close>
    16e4:	83 c4 10             	add    $0x10,%esp
  return r;
    16e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    16ea:	c9                   	leave  
    16eb:	c3                   	ret    

000016ec <atoi>:

int
atoi(const char *s)
{
    16ec:	55                   	push   %ebp
    16ed:	89 e5                	mov    %esp,%ebp
    16ef:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    16f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    16f9:	eb 25                	jmp    1720 <atoi+0x34>
    n = n*10 + *s++ - '0';
    16fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
    16fe:	89 d0                	mov    %edx,%eax
    1700:	c1 e0 02             	shl    $0x2,%eax
    1703:	01 d0                	add    %edx,%eax
    1705:	01 c0                	add    %eax,%eax
    1707:	89 c1                	mov    %eax,%ecx
    1709:	8b 45 08             	mov    0x8(%ebp),%eax
    170c:	8d 50 01             	lea    0x1(%eax),%edx
    170f:	89 55 08             	mov    %edx,0x8(%ebp)
    1712:	0f b6 00             	movzbl (%eax),%eax
    1715:	0f be c0             	movsbl %al,%eax
    1718:	01 c8                	add    %ecx,%eax
    171a:	83 e8 30             	sub    $0x30,%eax
    171d:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1720:	8b 45 08             	mov    0x8(%ebp),%eax
    1723:	0f b6 00             	movzbl (%eax),%eax
    1726:	3c 2f                	cmp    $0x2f,%al
    1728:	7e 0a                	jle    1734 <atoi+0x48>
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
    172d:	0f b6 00             	movzbl (%eax),%eax
    1730:	3c 39                	cmp    $0x39,%al
    1732:	7e c7                	jle    16fb <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1734:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1737:	c9                   	leave  
    1738:	c3                   	ret    

00001739 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1739:	55                   	push   %ebp
    173a:	89 e5                	mov    %esp,%ebp
    173c:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    173f:	8b 45 08             	mov    0x8(%ebp),%eax
    1742:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1745:	8b 45 0c             	mov    0xc(%ebp),%eax
    1748:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    174b:	eb 17                	jmp    1764 <memmove+0x2b>
    *dst++ = *src++;
    174d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1750:	8d 50 01             	lea    0x1(%eax),%edx
    1753:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1756:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1759:	8d 4a 01             	lea    0x1(%edx),%ecx
    175c:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    175f:	0f b6 12             	movzbl (%edx),%edx
    1762:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1764:	8b 45 10             	mov    0x10(%ebp),%eax
    1767:	8d 50 ff             	lea    -0x1(%eax),%edx
    176a:	89 55 10             	mov    %edx,0x10(%ebp)
    176d:	85 c0                	test   %eax,%eax
    176f:	7f dc                	jg     174d <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1771:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1774:	c9                   	leave  
    1775:	c3                   	ret    

00001776 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1776:	b8 01 00 00 00       	mov    $0x1,%eax
    177b:	cd 40                	int    $0x40
    177d:	c3                   	ret    

0000177e <exit>:
SYSCALL(exit)
    177e:	b8 02 00 00 00       	mov    $0x2,%eax
    1783:	cd 40                	int    $0x40
    1785:	c3                   	ret    

00001786 <wait>:
SYSCALL(wait)
    1786:	b8 03 00 00 00       	mov    $0x3,%eax
    178b:	cd 40                	int    $0x40
    178d:	c3                   	ret    

0000178e <pipe>:
SYSCALL(pipe)
    178e:	b8 04 00 00 00       	mov    $0x4,%eax
    1793:	cd 40                	int    $0x40
    1795:	c3                   	ret    

00001796 <read>:
SYSCALL(read)
    1796:	b8 05 00 00 00       	mov    $0x5,%eax
    179b:	cd 40                	int    $0x40
    179d:	c3                   	ret    

0000179e <write>:
SYSCALL(write)
    179e:	b8 10 00 00 00       	mov    $0x10,%eax
    17a3:	cd 40                	int    $0x40
    17a5:	c3                   	ret    

000017a6 <close>:
SYSCALL(close)
    17a6:	b8 15 00 00 00       	mov    $0x15,%eax
    17ab:	cd 40                	int    $0x40
    17ad:	c3                   	ret    

000017ae <kill>:
SYSCALL(kill)
    17ae:	b8 06 00 00 00       	mov    $0x6,%eax
    17b3:	cd 40                	int    $0x40
    17b5:	c3                   	ret    

000017b6 <exec>:
SYSCALL(exec)
    17b6:	b8 07 00 00 00       	mov    $0x7,%eax
    17bb:	cd 40                	int    $0x40
    17bd:	c3                   	ret    

000017be <open>:
SYSCALL(open)
    17be:	b8 0f 00 00 00       	mov    $0xf,%eax
    17c3:	cd 40                	int    $0x40
    17c5:	c3                   	ret    

000017c6 <mknod>:
SYSCALL(mknod)
    17c6:	b8 11 00 00 00       	mov    $0x11,%eax
    17cb:	cd 40                	int    $0x40
    17cd:	c3                   	ret    

000017ce <unlink>:
SYSCALL(unlink)
    17ce:	b8 12 00 00 00       	mov    $0x12,%eax
    17d3:	cd 40                	int    $0x40
    17d5:	c3                   	ret    

000017d6 <fstat>:
SYSCALL(fstat)
    17d6:	b8 08 00 00 00       	mov    $0x8,%eax
    17db:	cd 40                	int    $0x40
    17dd:	c3                   	ret    

000017de <link>:
SYSCALL(link)
    17de:	b8 13 00 00 00       	mov    $0x13,%eax
    17e3:	cd 40                	int    $0x40
    17e5:	c3                   	ret    

000017e6 <mkdir>:
SYSCALL(mkdir)
    17e6:	b8 14 00 00 00       	mov    $0x14,%eax
    17eb:	cd 40                	int    $0x40
    17ed:	c3                   	ret    

000017ee <chdir>:
SYSCALL(chdir)
    17ee:	b8 09 00 00 00       	mov    $0x9,%eax
    17f3:	cd 40                	int    $0x40
    17f5:	c3                   	ret    

000017f6 <dup>:
SYSCALL(dup)
    17f6:	b8 0a 00 00 00       	mov    $0xa,%eax
    17fb:	cd 40                	int    $0x40
    17fd:	c3                   	ret    

000017fe <getpid>:
SYSCALL(getpid)
    17fe:	b8 0b 00 00 00       	mov    $0xb,%eax
    1803:	cd 40                	int    $0x40
    1805:	c3                   	ret    

00001806 <sbrk>:
SYSCALL(sbrk)
    1806:	b8 0c 00 00 00       	mov    $0xc,%eax
    180b:	cd 40                	int    $0x40
    180d:	c3                   	ret    

0000180e <sleep>:
SYSCALL(sleep)
    180e:	b8 0d 00 00 00       	mov    $0xd,%eax
    1813:	cd 40                	int    $0x40
    1815:	c3                   	ret    

00001816 <uptime>:
SYSCALL(uptime)
    1816:	b8 0e 00 00 00       	mov    $0xe,%eax
    181b:	cd 40                	int    $0x40
    181d:	c3                   	ret    

0000181e <pstat>:
SYSCALL(pstat)
    181e:	b8 16 00 00 00       	mov    $0x16,%eax
    1823:	cd 40                	int    $0x40
    1825:	c3                   	ret    

00001826 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1826:	55                   	push   %ebp
    1827:	89 e5                	mov    %esp,%ebp
    1829:	83 ec 18             	sub    $0x18,%esp
    182c:	8b 45 0c             	mov    0xc(%ebp),%eax
    182f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1832:	83 ec 04             	sub    $0x4,%esp
    1835:	6a 01                	push   $0x1
    1837:	8d 45 f4             	lea    -0xc(%ebp),%eax
    183a:	50                   	push   %eax
    183b:	ff 75 08             	pushl  0x8(%ebp)
    183e:	e8 5b ff ff ff       	call   179e <write>
    1843:	83 c4 10             	add    $0x10,%esp
}
    1846:	c9                   	leave  
    1847:	c3                   	ret    

00001848 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1848:	55                   	push   %ebp
    1849:	89 e5                	mov    %esp,%ebp
    184b:	53                   	push   %ebx
    184c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    184f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1856:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    185a:	74 17                	je     1873 <printint+0x2b>
    185c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1860:	79 11                	jns    1873 <printint+0x2b>
    neg = 1;
    1862:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1869:	8b 45 0c             	mov    0xc(%ebp),%eax
    186c:	f7 d8                	neg    %eax
    186e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1871:	eb 06                	jmp    1879 <printint+0x31>
  } else {
    x = xx;
    1873:	8b 45 0c             	mov    0xc(%ebp),%eax
    1876:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1879:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1880:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1883:	8d 41 01             	lea    0x1(%ecx),%eax
    1886:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1889:	8b 5d 10             	mov    0x10(%ebp),%ebx
    188c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    188f:	ba 00 00 00 00       	mov    $0x0,%edx
    1894:	f7 f3                	div    %ebx
    1896:	89 d0                	mov    %edx,%eax
    1898:	0f b6 80 ee 23 00 00 	movzbl 0x23ee(%eax),%eax
    189f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    18a3:	8b 5d 10             	mov    0x10(%ebp),%ebx
    18a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18a9:	ba 00 00 00 00       	mov    $0x0,%edx
    18ae:	f7 f3                	div    %ebx
    18b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18b7:	75 c7                	jne    1880 <printint+0x38>
  if(neg)
    18b9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18bd:	74 0e                	je     18cd <printint+0x85>
    buf[i++] = '-';
    18bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c2:	8d 50 01             	lea    0x1(%eax),%edx
    18c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
    18c8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    18cd:	eb 1d                	jmp    18ec <printint+0xa4>
    putc(fd, buf[i]);
    18cf:	8d 55 dc             	lea    -0x24(%ebp),%edx
    18d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d5:	01 d0                	add    %edx,%eax
    18d7:	0f b6 00             	movzbl (%eax),%eax
    18da:	0f be c0             	movsbl %al,%eax
    18dd:	83 ec 08             	sub    $0x8,%esp
    18e0:	50                   	push   %eax
    18e1:	ff 75 08             	pushl  0x8(%ebp)
    18e4:	e8 3d ff ff ff       	call   1826 <putc>
    18e9:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    18ec:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    18f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18f4:	79 d9                	jns    18cf <printint+0x87>
    putc(fd, buf[i]);
}
    18f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    18f9:	c9                   	leave  
    18fa:	c3                   	ret    

000018fb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    18fb:	55                   	push   %ebp
    18fc:	89 e5                	mov    %esp,%ebp
    18fe:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1901:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1908:	8d 45 0c             	lea    0xc(%ebp),%eax
    190b:	83 c0 04             	add    $0x4,%eax
    190e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1911:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1918:	e9 59 01 00 00       	jmp    1a76 <printf+0x17b>
    c = fmt[i] & 0xff;
    191d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1920:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1923:	01 d0                	add    %edx,%eax
    1925:	0f b6 00             	movzbl (%eax),%eax
    1928:	0f be c0             	movsbl %al,%eax
    192b:	25 ff 00 00 00       	and    $0xff,%eax
    1930:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1933:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1937:	75 2c                	jne    1965 <printf+0x6a>
      if(c == '%'){
    1939:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    193d:	75 0c                	jne    194b <printf+0x50>
        state = '%';
    193f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1946:	e9 27 01 00 00       	jmp    1a72 <printf+0x177>
      } else {
        putc(fd, c);
    194b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    194e:	0f be c0             	movsbl %al,%eax
    1951:	83 ec 08             	sub    $0x8,%esp
    1954:	50                   	push   %eax
    1955:	ff 75 08             	pushl  0x8(%ebp)
    1958:	e8 c9 fe ff ff       	call   1826 <putc>
    195d:	83 c4 10             	add    $0x10,%esp
    1960:	e9 0d 01 00 00       	jmp    1a72 <printf+0x177>
      }
    } else if(state == '%'){
    1965:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1969:	0f 85 03 01 00 00    	jne    1a72 <printf+0x177>
      if(c == 'd'){
    196f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1973:	75 1e                	jne    1993 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1975:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1978:	8b 00                	mov    (%eax),%eax
    197a:	6a 01                	push   $0x1
    197c:	6a 0a                	push   $0xa
    197e:	50                   	push   %eax
    197f:	ff 75 08             	pushl  0x8(%ebp)
    1982:	e8 c1 fe ff ff       	call   1848 <printint>
    1987:	83 c4 10             	add    $0x10,%esp
        ap++;
    198a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    198e:	e9 d8 00 00 00       	jmp    1a6b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1993:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1997:	74 06                	je     199f <printf+0xa4>
    1999:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    199d:	75 1e                	jne    19bd <printf+0xc2>
        printint(fd, *ap, 16, 0);
    199f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19a2:	8b 00                	mov    (%eax),%eax
    19a4:	6a 00                	push   $0x0
    19a6:	6a 10                	push   $0x10
    19a8:	50                   	push   %eax
    19a9:	ff 75 08             	pushl  0x8(%ebp)
    19ac:	e8 97 fe ff ff       	call   1848 <printint>
    19b1:	83 c4 10             	add    $0x10,%esp
        ap++;
    19b4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    19b8:	e9 ae 00 00 00       	jmp    1a6b <printf+0x170>
      } else if(c == 's'){
    19bd:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    19c1:	75 43                	jne    1a06 <printf+0x10b>
        s = (char*)*ap;
    19c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19c6:	8b 00                	mov    (%eax),%eax
    19c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    19cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    19cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19d3:	75 07                	jne    19dc <printf+0xe1>
          s = "(null)";
    19d5:	c7 45 f4 18 1e 00 00 	movl   $0x1e18,-0xc(%ebp)
        while(*s != 0){
    19dc:	eb 1c                	jmp    19fa <printf+0xff>
          putc(fd, *s);
    19de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e1:	0f b6 00             	movzbl (%eax),%eax
    19e4:	0f be c0             	movsbl %al,%eax
    19e7:	83 ec 08             	sub    $0x8,%esp
    19ea:	50                   	push   %eax
    19eb:	ff 75 08             	pushl  0x8(%ebp)
    19ee:	e8 33 fe ff ff       	call   1826 <putc>
    19f3:	83 c4 10             	add    $0x10,%esp
          s++;
    19f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    19fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19fd:	0f b6 00             	movzbl (%eax),%eax
    1a00:	84 c0                	test   %al,%al
    1a02:	75 da                	jne    19de <printf+0xe3>
    1a04:	eb 65                	jmp    1a6b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1a06:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1a0a:	75 1d                	jne    1a29 <printf+0x12e>
        putc(fd, *ap);
    1a0c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a0f:	8b 00                	mov    (%eax),%eax
    1a11:	0f be c0             	movsbl %al,%eax
    1a14:	83 ec 08             	sub    $0x8,%esp
    1a17:	50                   	push   %eax
    1a18:	ff 75 08             	pushl  0x8(%ebp)
    1a1b:	e8 06 fe ff ff       	call   1826 <putc>
    1a20:	83 c4 10             	add    $0x10,%esp
        ap++;
    1a23:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1a27:	eb 42                	jmp    1a6b <printf+0x170>
      } else if(c == '%'){
    1a29:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1a2d:	75 17                	jne    1a46 <printf+0x14b>
        putc(fd, c);
    1a2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a32:	0f be c0             	movsbl %al,%eax
    1a35:	83 ec 08             	sub    $0x8,%esp
    1a38:	50                   	push   %eax
    1a39:	ff 75 08             	pushl  0x8(%ebp)
    1a3c:	e8 e5 fd ff ff       	call   1826 <putc>
    1a41:	83 c4 10             	add    $0x10,%esp
    1a44:	eb 25                	jmp    1a6b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1a46:	83 ec 08             	sub    $0x8,%esp
    1a49:	6a 25                	push   $0x25
    1a4b:	ff 75 08             	pushl  0x8(%ebp)
    1a4e:	e8 d3 fd ff ff       	call   1826 <putc>
    1a53:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1a56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a59:	0f be c0             	movsbl %al,%eax
    1a5c:	83 ec 08             	sub    $0x8,%esp
    1a5f:	50                   	push   %eax
    1a60:	ff 75 08             	pushl  0x8(%ebp)
    1a63:	e8 be fd ff ff       	call   1826 <putc>
    1a68:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1a6b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1a72:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a76:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7c:	01 d0                	add    %edx,%eax
    1a7e:	0f b6 00             	movzbl (%eax),%eax
    1a81:	84 c0                	test   %al,%al
    1a83:	0f 85 94 fe ff ff    	jne    191d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1a89:	c9                   	leave  
    1a8a:	c3                   	ret    

00001a8b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a8b:	55                   	push   %ebp
    1a8c:	89 e5                	mov    %esp,%ebp
    1a8e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1a91:	8b 45 08             	mov    0x8(%ebp),%eax
    1a94:	83 e8 08             	sub    $0x8,%eax
    1a97:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a9a:	a1 6c 24 00 00       	mov    0x246c,%eax
    1a9f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1aa2:	eb 24                	jmp    1ac8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1aa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aa7:	8b 00                	mov    (%eax),%eax
    1aa9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1aac:	77 12                	ja     1ac0 <free+0x35>
    1aae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ab1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ab4:	77 24                	ja     1ada <free+0x4f>
    1ab6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ab9:	8b 00                	mov    (%eax),%eax
    1abb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1abe:	77 1a                	ja     1ada <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ac0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ac3:	8b 00                	mov    (%eax),%eax
    1ac5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1ac8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1acb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ace:	76 d4                	jbe    1aa4 <free+0x19>
    1ad0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ad3:	8b 00                	mov    (%eax),%eax
    1ad5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ad8:	76 ca                	jbe    1aa4 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ada:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1add:	8b 40 04             	mov    0x4(%eax),%eax
    1ae0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1ae7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1aea:	01 c2                	add    %eax,%edx
    1aec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aef:	8b 00                	mov    (%eax),%eax
    1af1:	39 c2                	cmp    %eax,%edx
    1af3:	75 24                	jne    1b19 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1af5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1af8:	8b 50 04             	mov    0x4(%eax),%edx
    1afb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1afe:	8b 00                	mov    (%eax),%eax
    1b00:	8b 40 04             	mov    0x4(%eax),%eax
    1b03:	01 c2                	add    %eax,%edx
    1b05:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b08:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b0e:	8b 00                	mov    (%eax),%eax
    1b10:	8b 10                	mov    (%eax),%edx
    1b12:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b15:	89 10                	mov    %edx,(%eax)
    1b17:	eb 0a                	jmp    1b23 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1b19:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b1c:	8b 10                	mov    (%eax),%edx
    1b1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b21:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1b23:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b26:	8b 40 04             	mov    0x4(%eax),%eax
    1b29:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1b30:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b33:	01 d0                	add    %edx,%eax
    1b35:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b38:	75 20                	jne    1b5a <free+0xcf>
    p->s.size += bp->s.size;
    1b3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b3d:	8b 50 04             	mov    0x4(%eax),%edx
    1b40:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b43:	8b 40 04             	mov    0x4(%eax),%eax
    1b46:	01 c2                	add    %eax,%edx
    1b48:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b4b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1b4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b51:	8b 10                	mov    (%eax),%edx
    1b53:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b56:	89 10                	mov    %edx,(%eax)
    1b58:	eb 08                	jmp    1b62 <free+0xd7>
  } else
    p->s.ptr = bp;
    1b5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b5d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1b60:	89 10                	mov    %edx,(%eax)
  freep = p;
    1b62:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b65:	a3 6c 24 00 00       	mov    %eax,0x246c
}
    1b6a:	c9                   	leave  
    1b6b:	c3                   	ret    

00001b6c <morecore>:

static Header*
morecore(uint nu)
{
    1b6c:	55                   	push   %ebp
    1b6d:	89 e5                	mov    %esp,%ebp
    1b6f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1b72:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1b79:	77 07                	ja     1b82 <morecore+0x16>
    nu = 4096;
    1b7b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1b82:	8b 45 08             	mov    0x8(%ebp),%eax
    1b85:	c1 e0 03             	shl    $0x3,%eax
    1b88:	83 ec 0c             	sub    $0xc,%esp
    1b8b:	50                   	push   %eax
    1b8c:	e8 75 fc ff ff       	call   1806 <sbrk>
    1b91:	83 c4 10             	add    $0x10,%esp
    1b94:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1b97:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1b9b:	75 07                	jne    1ba4 <morecore+0x38>
    return 0;
    1b9d:	b8 00 00 00 00       	mov    $0x0,%eax
    1ba2:	eb 26                	jmp    1bca <morecore+0x5e>
  hp = (Header*)p;
    1ba4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bad:	8b 55 08             	mov    0x8(%ebp),%edx
    1bb0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1bb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bb6:	83 c0 08             	add    $0x8,%eax
    1bb9:	83 ec 0c             	sub    $0xc,%esp
    1bbc:	50                   	push   %eax
    1bbd:	e8 c9 fe ff ff       	call   1a8b <free>
    1bc2:	83 c4 10             	add    $0x10,%esp
  return freep;
    1bc5:	a1 6c 24 00 00       	mov    0x246c,%eax
}
    1bca:	c9                   	leave  
    1bcb:	c3                   	ret    

00001bcc <malloc>:

void*
malloc(uint nbytes)
{
    1bcc:	55                   	push   %ebp
    1bcd:	89 e5                	mov    %esp,%ebp
    1bcf:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1bd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd5:	83 c0 07             	add    $0x7,%eax
    1bd8:	c1 e8 03             	shr    $0x3,%eax
    1bdb:	83 c0 01             	add    $0x1,%eax
    1bde:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1be1:	a1 6c 24 00 00       	mov    0x246c,%eax
    1be6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1be9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bed:	75 23                	jne    1c12 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1bef:	c7 45 f0 64 24 00 00 	movl   $0x2464,-0x10(%ebp)
    1bf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf9:	a3 6c 24 00 00       	mov    %eax,0x246c
    1bfe:	a1 6c 24 00 00       	mov    0x246c,%eax
    1c03:	a3 64 24 00 00       	mov    %eax,0x2464
    base.s.size = 0;
    1c08:	c7 05 68 24 00 00 00 	movl   $0x0,0x2468
    1c0f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c12:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c15:	8b 00                	mov    (%eax),%eax
    1c17:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c1d:	8b 40 04             	mov    0x4(%eax),%eax
    1c20:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1c23:	72 4d                	jb     1c72 <malloc+0xa6>
      if(p->s.size == nunits)
    1c25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c28:	8b 40 04             	mov    0x4(%eax),%eax
    1c2b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1c2e:	75 0c                	jne    1c3c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c33:	8b 10                	mov    (%eax),%edx
    1c35:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c38:	89 10                	mov    %edx,(%eax)
    1c3a:	eb 26                	jmp    1c62 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c3f:	8b 40 04             	mov    0x4(%eax),%eax
    1c42:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1c45:	89 c2                	mov    %eax,%edx
    1c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c4a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c50:	8b 40 04             	mov    0x4(%eax),%eax
    1c53:	c1 e0 03             	shl    $0x3,%eax
    1c56:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1c59:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c5c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1c5f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1c62:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c65:	a3 6c 24 00 00       	mov    %eax,0x246c
      return (void*)(p + 1);
    1c6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c6d:	83 c0 08             	add    $0x8,%eax
    1c70:	eb 3b                	jmp    1cad <malloc+0xe1>
    }
    if(p == freep)
    1c72:	a1 6c 24 00 00       	mov    0x246c,%eax
    1c77:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1c7a:	75 1e                	jne    1c9a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1c7c:	83 ec 0c             	sub    $0xc,%esp
    1c7f:	ff 75 ec             	pushl  -0x14(%ebp)
    1c82:	e8 e5 fe ff ff       	call   1b6c <morecore>
    1c87:	83 c4 10             	add    $0x10,%esp
    1c8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1c8d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c91:	75 07                	jne    1c9a <malloc+0xce>
        return 0;
    1c93:	b8 00 00 00 00       	mov    $0x0,%eax
    1c98:	eb 13                	jmp    1cad <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ca3:	8b 00                	mov    (%eax),%eax
    1ca5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1ca8:	e9 6d ff ff ff       	jmp    1c1a <malloc+0x4e>
}
    1cad:	c9                   	leave  
    1cae:	c3                   	ret    
