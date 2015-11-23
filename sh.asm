
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
      11:	e8 f8 17 00 00       	call   180e <exit>
  
  switch(cmd->type){
      16:	8b 45 08             	mov    0x8(%ebp),%eax
      19:	8b 00                	mov    (%eax),%eax
      1b:	83 f8 05             	cmp    $0x5,%eax
      1e:	77 09                	ja     29 <runcmd+0x29>
      20:	8b 04 85 98 1d 00 00 	mov    0x1d98(,%eax,4),%eax
      27:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      29:	83 ec 0c             	sub    $0xc,%esp
      2c:	68 6c 1d 00 00       	push   $0x1d6c
      31:	e8 a2 0c 00 00       	call   cd8 <panic>
      36:	83 c4 10             	add    $0x10,%esp

  case EXEC:
	  if (fork1() == 0){
      39:	e8 bf 0c 00 00       	call   cfd <fork1>
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
      5b:	e8 ae 17 00 00       	call   180e <exit>
		 char buf[sizeof(int)];
		 int pid = getpid();
      60:	e8 29 18 00 00       	call   188e <getpid>
      65:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		 strcpy(buf , (char*)&pid);
      68:	83 ec 08             	sub    $0x8,%esp
      6b:	8d 45 d4             	lea    -0x2c(%ebp),%eax
      6e:	50                   	push   %eax
      6f:	8d 45 d8             	lea    -0x28(%ebp),%eax
      72:	50                   	push   %eax
      73:	e8 66 15 00 00       	call   15de <strcpy>
      78:	83 c4 10             	add    $0x10,%esp
		 write(fdToShell , buf, strlen(buf));
      7b:	83 ec 0c             	sub    $0xc,%esp
      7e:	8d 45 d8             	lea    -0x28(%ebp),%eax
      81:	50                   	push   %eax
      82:	e8 c6 15 00 00       	call   164d <strlen>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	83 ec 04             	sub    $0x4,%esp
      8d:	50                   	push   %eax
      8e:	8d 45 d8             	lea    -0x28(%ebp),%eax
      91:	50                   	push   %eax
      92:	ff 75 0c             	pushl  0xc(%ebp)
      95:	e8 94 17 00 00       	call   182e <write>
      9a:	83 c4 10             	add    $0x10,%esp
		 close(fdToShell);
      9d:	83 ec 0c             	sub    $0xc,%esp
      a0:	ff 75 0c             	pushl  0xc(%ebp)
      a3:	e8 8e 17 00 00       	call   1836 <close>
      a8:	83 c4 10             	add    $0x10,%esp

		 exec(ecmd->argv[0], ecmd->argv);
      ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
      ae:	8d 50 04             	lea    0x4(%eax),%edx
      b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
      b4:	8b 40 04             	mov    0x4(%eax),%eax
      b7:	83 ec 08             	sub    $0x8,%esp
      ba:	52                   	push   %edx
      bb:	50                   	push   %eax
      bc:	e8 85 17 00 00       	call   1846 <exec>
      c1:	83 c4 10             	add    $0x10,%esp
		 printf(2, "exec %s failed\n", ecmd->argv[0]);
      c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c7:	8b 40 04             	mov    0x4(%eax),%eax
      ca:	83 ec 04             	sub    $0x4,%esp
      cd:	50                   	push   %eax
      ce:	68 73 1d 00 00       	push   $0x1d73
      d3:	6a 02                	push   $0x2
      d5:	e8 b1 18 00 00       	call   198b <printf>
      da:	83 c4 10             	add    $0x10,%esp
	  }
	  close(fdToShell);
      dd:	83 ec 0c             	sub    $0xc,%esp
      e0:	ff 75 0c             	pushl  0xc(%ebp)
      e3:	e8 4e 17 00 00       	call   1836 <close>
      e8:	83 c4 10             	add    $0x10,%esp
	  wait(0);
      eb:	83 ec 0c             	sub    $0xc,%esp
      ee:	6a 00                	push   $0x0
      f0:	e8 21 17 00 00       	call   1816 <wait>
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
     10d:	e8 24 17 00 00       	call   1836 <close>
     112:	83 c4 10             	add    $0x10,%esp
     if(open(rcmd->file, rcmd->mode) < 0){
     115:	8b 45 f0             	mov    -0x10(%ebp),%eax
     118:	8b 50 10             	mov    0x10(%eax),%edx
     11b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     11e:	8b 40 08             	mov    0x8(%eax),%eax
     121:	83 ec 08             	sub    $0x8,%esp
     124:	52                   	push   %edx
     125:	50                   	push   %eax
     126:	e8 23 17 00 00       	call   184e <open>
     12b:	83 c4 10             	add    $0x10,%esp
     12e:	85 c0                	test   %eax,%eax
     130:	79 23                	jns    155 <runcmd+0x155>
       printf(2, "open %s failed\n", rcmd->file);
     132:	8b 45 f0             	mov    -0x10(%ebp),%eax
     135:	8b 40 08             	mov    0x8(%eax),%eax
     138:	83 ec 04             	sub    $0x4,%esp
     13b:	50                   	push   %eax
     13c:	68 83 1d 00 00       	push   $0x1d83
     141:	6a 02                	push   $0x2
     143:	e8 43 18 00 00       	call   198b <printf>
     148:	83 c4 10             	add    $0x10,%esp
       exit(EXIT_STATUS_OK);
     14b:	83 ec 0c             	sub    $0xc,%esp
     14e:	6a 01                	push   $0x1
     150:	e8 b9 16 00 00       	call   180e <exit>
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
     175:	e8 83 0b 00 00       	call   cfd <fork1>
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
     198:	e8 79 16 00 00       	call   1816 <wait>
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
     1c7:	e8 52 16 00 00       	call   181e <pipe>
     1cc:	83 c4 10             	add    $0x10,%esp
     1cf:	85 c0                	test   %eax,%eax
     1d1:	79 10                	jns    1e3 <runcmd+0x1e3>
       panic("pipe");
     1d3:	83 ec 0c             	sub    $0xc,%esp
     1d6:	68 93 1d 00 00       	push   $0x1d93
     1db:	e8 f8 0a 00 00       	call   cd8 <panic>
     1e0:	83 c4 10             	add    $0x10,%esp
     if(fork1() == 0){
     1e3:	e8 15 0b 00 00       	call   cfd <fork1>
     1e8:	85 c0                	test   %eax,%eax
     1ea:	75 4f                	jne    23b <runcmd+0x23b>
       close(1);
     1ec:	83 ec 0c             	sub    $0xc,%esp
     1ef:	6a 01                	push   $0x1
     1f1:	e8 40 16 00 00       	call   1836 <close>
     1f6:	83 c4 10             	add    $0x10,%esp
       dup(p[1]);
     1f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1fc:	83 ec 0c             	sub    $0xc,%esp
     1ff:	50                   	push   %eax
     200:	e8 81 16 00 00       	call   1886 <dup>
     205:	83 c4 10             	add    $0x10,%esp
       close(p[0]);
     208:	8b 45 dc             	mov    -0x24(%ebp),%eax
     20b:	83 ec 0c             	sub    $0xc,%esp
     20e:	50                   	push   %eax
     20f:	e8 22 16 00 00       	call   1836 <close>
     214:	83 c4 10             	add    $0x10,%esp
       close(p[1]);
     217:	8b 45 e0             	mov    -0x20(%ebp),%eax
     21a:	83 ec 0c             	sub    $0xc,%esp
     21d:	50                   	push   %eax
     21e:	e8 13 16 00 00       	call   1836 <close>
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
     23b:	e8 bd 0a 00 00       	call   cfd <fork1>
     240:	85 c0                	test   %eax,%eax
     242:	75 4f                	jne    293 <runcmd+0x293>
       close(0);
     244:	83 ec 0c             	sub    $0xc,%esp
     247:	6a 00                	push   $0x0
     249:	e8 e8 15 00 00       	call   1836 <close>
     24e:	83 c4 10             	add    $0x10,%esp
       dup(p[0]);
     251:	8b 45 dc             	mov    -0x24(%ebp),%eax
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	50                   	push   %eax
     258:	e8 29 16 00 00       	call   1886 <dup>
     25d:	83 c4 10             	add    $0x10,%esp
       close(p[0]);
     260:	8b 45 dc             	mov    -0x24(%ebp),%eax
     263:	83 ec 0c             	sub    $0xc,%esp
     266:	50                   	push   %eax
     267:	e8 ca 15 00 00       	call   1836 <close>
     26c:	83 c4 10             	add    $0x10,%esp
       close(p[1]);
     26f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     272:	83 ec 0c             	sub    $0xc,%esp
     275:	50                   	push   %eax
     276:	e8 bb 15 00 00       	call   1836 <close>
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
     29a:	e8 97 15 00 00       	call   1836 <close>
     29f:	83 c4 10             	add    $0x10,%esp
     close(p[1]);
     2a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     2a5:	83 ec 0c             	sub    $0xc,%esp
     2a8:	50                   	push   %eax
     2a9:	e8 88 15 00 00       	call   1836 <close>
     2ae:	83 c4 10             	add    $0x10,%esp
     close(fdToShell);
     2b1:	83 ec 0c             	sub    $0xc,%esp
     2b4:	ff 75 0c             	pushl  0xc(%ebp)
     2b7:	e8 7a 15 00 00       	call   1836 <close>
     2bc:	83 c4 10             	add    $0x10,%esp
     wait(0);
     2bf:	83 ec 0c             	sub    $0xc,%esp
     2c2:	6a 00                	push   $0x0
     2c4:	e8 4d 15 00 00       	call   1816 <wait>
     2c9:	83 c4 10             	add    $0x10,%esp

     wait(0);
     2cc:	83 ec 0c             	sub    $0xc,%esp
     2cf:	6a 00                	push   $0x0
     2d1:	e8 40 15 00 00       	call   1816 <wait>
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
     2fc:	e8 0d 15 00 00       	call   180e <exit>

00000301 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     301:	55                   	push   %ebp
     302:	89 e5                	mov    %esp,%ebp
     304:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     307:	83 ec 08             	sub    $0x8,%esp
     30a:	68 b0 1d 00 00       	push   $0x1db0
     30f:	6a 02                	push   $0x2
     311:	e8 75 16 00 00       	call   198b <printf>
     316:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     319:	8b 45 0c             	mov    0xc(%ebp),%eax
     31c:	83 ec 04             	sub    $0x4,%esp
     31f:	50                   	push   %eax
     320:	6a 00                	push   $0x0
     322:	ff 75 08             	pushl  0x8(%ebp)
     325:	e8 4a 13 00 00       	call   1674 <memset>
     32a:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     32d:	83 ec 08             	sub    $0x8,%esp
     330:	ff 75 0c             	pushl  0xc(%ebp)
     333:	ff 75 08             	pushl  0x8(%ebp)
     336:	e8 86 13 00 00       	call   16c1 <gets>
     33b:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     33e:	8b 45 08             	mov    0x8(%ebp),%eax
     341:	0f b6 00             	movzbl (%eax),%eax
     344:	84 c0                	test   %al,%al
     346:	75 07                	jne    34f <getcmd+0x4e>
    return -1;
     348:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     34d:	eb 05                	jmp    354 <getcmd+0x53>
  return 0;
     34f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     354:	c9                   	leave  
     355:	c3                   	ret    

00000356 <main>:

int
main(void)
{
     356:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     35a:	83 e4 f0             	and    $0xfffffff0,%esp
     35d:	ff 71 fc             	pushl  -0x4(%ecx)
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	51                   	push   %ecx
     364:	83 ec 44             	sub    $0x44,%esp
  static char buf[100];
  int fd;
  struct job *jobsHead = 0;
     367:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  struct job *foregroungJob = 0;
     36e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

  int jobCount = 0;
     375:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     37c:	eb 16                	jmp    394 <main+0x3e>
    if(fd >= 3){
     37e:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
     382:	7e 10                	jle    394 <main+0x3e>
      close(fd);
     384:	83 ec 0c             	sub    $0xc,%esp
     387:	ff 75 e8             	pushl  -0x18(%ebp)
     38a:	e8 a7 14 00 00       	call   1836 <close>
     38f:	83 c4 10             	add    $0x10,%esp
      break;
     392:	eb 1b                	jmp    3af <main+0x59>
  struct job *foregroungJob = 0;

  int jobCount = 0;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     394:	83 ec 08             	sub    $0x8,%esp
     397:	6a 02                	push   $0x2
     399:	68 b3 1d 00 00       	push   $0x1db3
     39e:	e8 ab 14 00 00       	call   184e <open>
     3a3:	83 c4 10             	add    $0x10,%esp
     3a6:	89 45 e8             	mov    %eax,-0x18(%ebp)
     3a9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     3ad:	79 cf                	jns    37e <main+0x28>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     3af:	e9 24 03 00 00       	jmp    6d8 <main+0x382>
	 jobsHead = clearJobList(jobsHead);
     3b4:	83 ec 0c             	sub    $0xc,%esp
     3b7:	ff 75 f4             	pushl  -0xc(%ebp)
     3ba:	e8 cc 04 00 00       	call   88b <clearJobList>
     3bf:	83 c4 10             	add    $0x10,%esp
     3c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	 foregroungJob = findForegroundJob(jobsHead);
     3c5:	83 ec 0c             	sub    $0xc,%esp
     3c8:	ff 75 f4             	pushl  -0xc(%ebp)
     3cb:	e8 74 04 00 00       	call   844 <findForegroundJob>
     3d0:	83 c4 10             	add    $0x10,%esp
     3d3:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (foregroungJob != 0){
     3d6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     3da:	74 46                	je     422 <main+0xcc>
		//TODO pass to pipe entered data
		printf(1, "Received INPUT = %s" , buf);
     3dc:	83 ec 04             	sub    $0x4,%esp
     3df:	68 00 26 00 00       	push   $0x2600
     3e4:	68 bb 1d 00 00       	push   $0x1dbb
     3e9:	6a 01                	push   $0x1
     3eb:	e8 9b 15 00 00       	call   198b <printf>
     3f0:	83 c4 10             	add    $0x10,%esp
		write(foregroungJob->jobInFd , buf, strlen(buf));
     3f3:	83 ec 0c             	sub    $0xc,%esp
     3f6:	68 00 26 00 00       	push   $0x2600
     3fb:	e8 4d 12 00 00       	call   164d <strlen>
     400:	83 c4 10             	add    $0x10,%esp
     403:	89 c2                	mov    %eax,%edx
     405:	8b 45 ec             	mov    -0x14(%ebp),%eax
     408:	8b 40 0c             	mov    0xc(%eax),%eax
     40b:	83 ec 04             	sub    $0x4,%esp
     40e:	52                   	push   %edx
     40f:	68 00 26 00 00       	push   $0x2600
     414:	50                   	push   %eax
     415:	e8 14 14 00 00       	call   182e <write>
     41a:	83 c4 10             	add    $0x10,%esp
		continue;
     41d:	e9 b6 02 00 00       	jmp    6d8 <main+0x382>
	}

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     422:	0f b6 05 00 26 00 00 	movzbl 0x2600,%eax
     429:	3c 63                	cmp    $0x63,%al
     42b:	75 65                	jne    492 <main+0x13c>
     42d:	0f b6 05 01 26 00 00 	movzbl 0x2601,%eax
     434:	3c 64                	cmp    $0x64,%al
     436:	75 5a                	jne    492 <main+0x13c>
     438:	0f b6 05 02 26 00 00 	movzbl 0x2602,%eax
     43f:	3c 20                	cmp    $0x20,%al
     441:	75 4f                	jne    492 <main+0x13c>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     443:	83 ec 0c             	sub    $0xc,%esp
     446:	68 00 26 00 00       	push   $0x2600
     44b:	e8 fd 11 00 00       	call   164d <strlen>
     450:	83 c4 10             	add    $0x10,%esp
     453:	83 e8 01             	sub    $0x1,%eax
     456:	c6 80 00 26 00 00 00 	movb   $0x0,0x2600(%eax)
      if(chdir(buf+3) < 0)
     45d:	83 ec 0c             	sub    $0xc,%esp
     460:	68 03 26 00 00       	push   $0x2603
     465:	e8 14 14 00 00       	call   187e <chdir>
     46a:	83 c4 10             	add    $0x10,%esp
     46d:	85 c0                	test   %eax,%eax
     46f:	79 1c                	jns    48d <main+0x137>
        printf(2, "cannot cd %s\n", buf+3);
     471:	83 ec 04             	sub    $0x4,%esp
     474:	68 03 26 00 00       	push   $0x2603
     479:	68 cf 1d 00 00       	push   $0x1dcf
     47e:	6a 02                	push   $0x2
     480:	e8 06 15 00 00       	call   198b <printf>
     485:	83 c4 10             	add    $0x10,%esp
      continue;
     488:	e9 4b 02 00 00       	jmp    6d8 <main+0x382>
     48d:	e9 46 02 00 00       	jmp    6d8 <main+0x382>
    }

    if(buf[0] == 'j' && buf[1] == 'o' && buf[2] == 'b' && buf[3] == 's'){
     492:	0f b6 05 00 26 00 00 	movzbl 0x2600,%eax
     499:	3c 6a                	cmp    $0x6a,%al
     49b:	75 34                	jne    4d1 <main+0x17b>
     49d:	0f b6 05 01 26 00 00 	movzbl 0x2601,%eax
     4a4:	3c 6f                	cmp    $0x6f,%al
     4a6:	75 29                	jne    4d1 <main+0x17b>
     4a8:	0f b6 05 02 26 00 00 	movzbl 0x2602,%eax
     4af:	3c 62                	cmp    $0x62,%al
     4b1:	75 1e                	jne    4d1 <main+0x17b>
     4b3:	0f b6 05 03 26 00 00 	movzbl 0x2603,%eax
     4ba:	3c 73                	cmp    $0x73,%al
     4bc:	75 13                	jne    4d1 <main+0x17b>
    	printAllJobs(jobsHead);
     4be:	83 ec 0c             	sub    $0xc,%esp
     4c1:	ff 75 f4             	pushl  -0xc(%ebp)
     4c4:	e8 33 02 00 00       	call   6fc <printAllJobs>
     4c9:	83 c4 10             	add    $0x10,%esp
    	continue;
     4cc:	e9 07 02 00 00       	jmp    6d8 <main+0x382>
    }

    if(buf[0] == 'f' && buf[1] == 'g' && buf[2] == ' '){
     4d1:	0f b6 05 00 26 00 00 	movzbl 0x2600,%eax
     4d8:	3c 66                	cmp    $0x66,%al
     4da:	75 66                	jne    542 <main+0x1ec>
     4dc:	0f b6 05 01 26 00 00 	movzbl 0x2601,%eax
     4e3:	3c 67                	cmp    $0x67,%al
     4e5:	75 5b                	jne    542 <main+0x1ec>
     4e7:	0f b6 05 02 26 00 00 	movzbl 0x2602,%eax
     4ee:	3c 20                	cmp    $0x20,%al
     4f0:	75 50                	jne    542 <main+0x1ec>
        buf[strlen(buf)-1] = 0;  // chop \n
     4f2:	83 ec 0c             	sub    $0xc,%esp
     4f5:	68 00 26 00 00       	push   $0x2600
     4fa:	e8 4e 11 00 00       	call   164d <strlen>
     4ff:	83 c4 10             	add    $0x10,%esp
     502:	83 e8 01             	sub    $0x1,%eax
     505:	c6 80 00 26 00 00 00 	movb   $0x0,0x2600(%eax)
        int pid = atoi(buf + 3);
     50c:	83 ec 0c             	sub    $0xc,%esp
     50f:	68 03 26 00 00       	push   $0x2603
     514:	e8 63 12 00 00       	call   177c <atoi>
     519:	83 c4 10             	add    $0x10,%esp
     51c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        struct job *findedJob = findJobById(jobsHead , pid);
     51f:	83 ec 08             	sub    $0x8,%esp
     522:	ff 75 e4             	pushl  -0x1c(%ebp)
     525:	ff 75 f4             	pushl  -0xc(%ebp)
     528:	e8 de 02 00 00       	call   80b <findJobById>
     52d:	83 c4 10             	add    $0x10,%esp
     530:	89 45 e0             	mov    %eax,-0x20(%ebp)
        findedJob->type = FOREGROUND;
     533:	8b 45 e0             	mov    -0x20(%ebp),%eax
     536:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
    	continue;
     53d:	e9 96 01 00 00       	jmp    6d8 <main+0x382>
    }

    if(buf[0] == 'f' && buf[1] == 'g'){
     542:	0f b6 05 00 26 00 00 	movzbl 0x2600,%eax
     549:	3c 66                	cmp    $0x66,%al
     54b:	75 1a                	jne    567 <main+0x211>
     54d:	0f b6 05 01 26 00 00 	movzbl 0x2601,%eax
     554:	3c 67                	cmp    $0x67,%al
     556:	75 0f                	jne    567 <main+0x211>
        jobsHead->type = FOREGROUND;
     558:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55b:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
    	continue;
     562:	e9 71 01 00 00       	jmp    6d8 <main+0x382>
    }

	int jobPids[2],jobInput[2];

	if(pipe(jobPids) < 0)
     567:	83 ec 0c             	sub    $0xc,%esp
     56a:	8d 45 cc             	lea    -0x34(%ebp),%eax
     56d:	50                   	push   %eax
     56e:	e8 ab 12 00 00       	call   181e <pipe>
     573:	83 c4 10             	add    $0x10,%esp
     576:	85 c0                	test   %eax,%eax
     578:	79 10                	jns    58a <main+0x234>
	  panic("jobPids error");
     57a:	83 ec 0c             	sub    $0xc,%esp
     57d:	68 dd 1d 00 00       	push   $0x1ddd
     582:	e8 51 07 00 00       	call   cd8 <panic>
     587:	83 c4 10             	add    $0x10,%esp

	if(pipe(jobInput) < 0)
     58a:	83 ec 0c             	sub    $0xc,%esp
     58d:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     590:	50                   	push   %eax
     591:	e8 88 12 00 00       	call   181e <pipe>
     596:	83 c4 10             	add    $0x10,%esp
     599:	85 c0                	test   %eax,%eax
     59b:	79 10                	jns    5ad <main+0x257>
	  panic("jobInput error");
     59d:	83 ec 0c             	sub    $0xc,%esp
     5a0:	68 eb 1d 00 00       	push   $0x1deb
     5a5:	e8 2e 07 00 00       	call   cd8 <panic>
     5aa:	83 c4 10             	add    $0x10,%esp

	jobCount++;
     5ad:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	struct job *newJob = getJob(jobCount , jobInput[1], buf);
     5b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
     5b4:	83 ec 04             	sub    $0x4,%esp
     5b7:	68 00 26 00 00       	push   $0x2600
     5bc:	50                   	push   %eax
     5bd:	ff 75 f0             	pushl  -0x10(%ebp)
     5c0:	e8 29 06 00 00       	call   bee <getJob>
     5c5:	83 c4 10             	add    $0x10,%esp
     5c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
	struct cmd *newcmd = parsecmd(buf);
     5cb:	83 ec 0c             	sub    $0xc,%esp
     5ce:	68 00 26 00 00       	push   $0x2600
     5d3:	e8 79 0a 00 00       	call   1051 <parsecmd>
     5d8:	83 c4 10             	add    $0x10,%esp
     5db:	89 45 d8             	mov    %eax,-0x28(%ebp)

	if (newcmd->type == BACK){
     5de:	8b 45 d8             	mov    -0x28(%ebp),%eax
     5e1:	8b 00                	mov    (%eax),%eax
     5e3:	83 f8 05             	cmp    $0x5,%eax
     5e6:	75 0a                	jne    5f2 <main+0x29c>
		newJob->type = BACKGROUND;
     5e8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     5eb:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
	}


	if(jobsHead == 0){
     5f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5f6:	75 08                	jne    600 <main+0x2aa>
		jobsHead = newJob;
     5f8:	8b 45 dc             	mov    -0x24(%ebp),%eax
     5fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     5fe:	eb 0f                	jmp    60f <main+0x2b9>
	}
	else {
		newJob->nextjob = jobsHead;
     600:	8b 45 dc             	mov    -0x24(%ebp),%eax
     603:	8b 55 f4             	mov    -0xc(%ebp),%edx
     606:	89 50 04             	mov    %edx,0x4(%eax)
		jobsHead = newJob;
     609:	8b 45 dc             	mov    -0x24(%ebp),%eax
     60c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	}

	if(fork1() == 0)
     60f:	e8 e9 06 00 00       	call   cfd <fork1>
     614:	85 c0                	test   %eax,%eax
     616:	75 5d                	jne    675 <main+0x31f>
	{
		close(0);
     618:	83 ec 0c             	sub    $0xc,%esp
     61b:	6a 00                	push   $0x0
     61d:	e8 14 12 00 00       	call   1836 <close>
     622:	83 c4 10             	add    $0x10,%esp
		dup(jobInput[0]);
     625:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     628:	83 ec 0c             	sub    $0xc,%esp
     62b:	50                   	push   %eax
     62c:	e8 55 12 00 00       	call   1886 <dup>
     631:	83 c4 10             	add    $0x10,%esp

		close(jobInput[0]);
     634:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     637:	83 ec 0c             	sub    $0xc,%esp
     63a:	50                   	push   %eax
     63b:	e8 f6 11 00 00       	call   1836 <close>
     640:	83 c4 10             	add    $0x10,%esp
		close(jobInput[1]);
     643:	8b 45 c8             	mov    -0x38(%ebp),%eax
     646:	83 ec 0c             	sub    $0xc,%esp
     649:	50                   	push   %eax
     64a:	e8 e7 11 00 00       	call   1836 <close>
     64f:	83 c4 10             	add    $0x10,%esp
		close(jobPids[0]);
     652:	8b 45 cc             	mov    -0x34(%ebp),%eax
     655:	83 ec 0c             	sub    $0xc,%esp
     658:	50                   	push   %eax
     659:	e8 d8 11 00 00       	call   1836 <close>
     65e:	83 c4 10             	add    $0x10,%esp

		runcmd(newcmd , jobPids[1]);
     661:	8b 45 d0             	mov    -0x30(%ebp),%eax
     664:	83 ec 08             	sub    $0x8,%esp
     667:	50                   	push   %eax
     668:	ff 75 d8             	pushl  -0x28(%ebp)
     66b:	e8 90 f9 ff ff       	call   0 <runcmd>
     670:	83 c4 10             	add    $0x10,%esp
     673:	eb 63                	jmp    6d8 <main+0x382>
	}
	else{
		close(jobInput[0]);
     675:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     678:	83 ec 0c             	sub    $0xc,%esp
     67b:	50                   	push   %eax
     67c:	e8 b5 11 00 00       	call   1836 <close>
     681:	83 c4 10             	add    $0x10,%esp
		close(jobPids[1]);
     684:	8b 45 d0             	mov    -0x30(%ebp),%eax
     687:	83 ec 0c             	sub    $0xc,%esp
     68a:	50                   	push   %eax
     68b:	e8 a6 11 00 00       	call   1836 <close>
     690:	83 c4 10             	add    $0x10,%esp

		char pidBuf[sizeof(int)];
		while (read(jobPids[0] , pidBuf , sizeof(pidBuf)) > 0 ){
     693:	eb 1b                	jmp    6b0 <main+0x35a>
			int recievedPid = (int)*pidBuf;
     695:	0f b6 45 c0          	movzbl -0x40(%ebp),%eax
     699:	0f be c0             	movsbl %al,%eax
     69c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			addProcessToJob(newJob , recievedPid);
     69f:	83 ec 08             	sub    $0x8,%esp
     6a2:	ff 75 d4             	pushl  -0x2c(%ebp)
     6a5:	ff 75 dc             	pushl  -0x24(%ebp)
     6a8:	e8 15 01 00 00       	call   7c2 <addProcessToJob>
     6ad:	83 c4 10             	add    $0x10,%esp
	else{
		close(jobInput[0]);
		close(jobPids[1]);

		char pidBuf[sizeof(int)];
		while (read(jobPids[0] , pidBuf , sizeof(pidBuf)) > 0 ){
     6b0:	8b 45 cc             	mov    -0x34(%ebp),%eax
     6b3:	83 ec 04             	sub    $0x4,%esp
     6b6:	6a 04                	push   $0x4
     6b8:	8d 55 c0             	lea    -0x40(%ebp),%edx
     6bb:	52                   	push   %edx
     6bc:	50                   	push   %eax
     6bd:	e8 64 11 00 00       	call   1826 <read>
     6c2:	83 c4 10             	add    $0x10,%esp
     6c5:	85 c0                	test   %eax,%eax
     6c7:	7f cc                	jg     695 <main+0x33f>
			int recievedPid = (int)*pidBuf;
			addProcessToJob(newJob , recievedPid);
		}
		close(jobPids[0]);
     6c9:	8b 45 cc             	mov    -0x34(%ebp),%eax
     6cc:	83 ec 0c             	sub    $0xc,%esp
     6cf:	50                   	push   %eax
     6d0:	e8 61 11 00 00       	call   1836 <close>
     6d5:	83 c4 10             	add    $0x10,%esp
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     6d8:	83 ec 08             	sub    $0x8,%esp
     6db:	6a 64                	push   $0x64
     6dd:	68 00 26 00 00       	push   $0x2600
     6e2:	e8 1a fc ff ff       	call   301 <getcmd>
     6e7:	83 c4 10             	add    $0x10,%esp
     6ea:	85 c0                	test   %eax,%eax
     6ec:	0f 89 c2 fc ff ff    	jns    3b4 <main+0x5e>
		}
		close(jobPids[0]);
	}
	//wait(0);
  }
  exit(EXIT_STATUS_OK);
     6f2:	83 ec 0c             	sub    $0xc,%esp
     6f5:	6a 01                	push   $0x1
     6f7:	e8 12 11 00 00       	call   180e <exit>

000006fc <printAllJobs>:
}


void printAllJobs(struct job * head){
     6fc:	55                   	push   %ebp
     6fd:	89 e5                	mov    %esp,%ebp
     6ff:	53                   	push   %ebx
     700:	83 ec 34             	sub    $0x34,%esp
	struct job* currentJob = head;
     703:	8b 45 08             	mov    0x8(%ebp),%eax
     706:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (head == 0) {
     709:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     70d:	75 17                	jne    726 <printAllJobs+0x2a>
		printf(2, "There are no jobs\n");
     70f:	83 ec 08             	sub    $0x8,%esp
     712:	68 fa 1d 00 00       	push   $0x1dfa
     717:	6a 02                	push   $0x2
     719:	e8 6d 12 00 00       	call   198b <printf>
     71e:	83 c4 10             	add    $0x10,%esp
		return;
     721:	e9 97 00 00 00       	jmp    7bd <printAllJobs+0xc1>
	}
	while (currentJob!=0){
     726:	e9 87 00 00 00       	jmp    7b2 <printAllJobs+0xb6>
		struct jobprocess* currentProc = currentJob->headOfProcesses;
     72b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72e:	8b 40 08             	mov    0x8(%eax),%eax
     731:	89 45 f0             	mov    %eax,-0x10(%ebp)
		printf(2, "Job %d: %s", currentJob->id, currentJob->cmd);
     734:	8b 45 f4             	mov    -0xc(%ebp),%eax
     737:	8b 50 14             	mov    0x14(%eax),%edx
     73a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     73d:	8b 00                	mov    (%eax),%eax
     73f:	52                   	push   %edx
     740:	50                   	push   %eax
     741:	68 0d 1e 00 00       	push   $0x1e0d
     746:	6a 02                	push   $0x2
     748:	e8 3e 12 00 00       	call   198b <printf>
     74d:	83 c4 10             	add    $0x10,%esp
		while (currentProc != 0 ){
     750:	eb 51                	jmp    7a3 <printAllJobs+0xa7>
			struct procstat stat;
			if (pstat(currentProc->pid, &stat) == 0){
     752:	8b 45 f0             	mov    -0x10(%ebp),%eax
     755:	8b 00                	mov    (%eax),%eax
     757:	83 ec 08             	sub    $0x8,%esp
     75a:	8d 55 d4             	lea    -0x2c(%ebp),%edx
     75d:	52                   	push   %edx
     75e:	50                   	push   %eax
     75f:	e8 4a 11 00 00       	call   18ae <pstat>
     764:	83 c4 10             	add    $0x10,%esp
     767:	85 c0                	test   %eax,%eax
     769:	75 2f                	jne    79a <printAllJobs+0x9e>
				printf(2, "%d: %s %d %d %s\n", currentProc->pid, stat.name, stat.sz, stat.nofile, states[stat.state]);
     76b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     76e:	8b 1c 85 b0 25 00 00 	mov    0x25b0(,%eax,4),%ebx
     775:	8b 4d e8             	mov    -0x18(%ebp),%ecx
     778:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     77b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77e:	8b 00                	mov    (%eax),%eax
     780:	83 ec 04             	sub    $0x4,%esp
     783:	53                   	push   %ebx
     784:	51                   	push   %ecx
     785:	52                   	push   %edx
     786:	8d 55 d4             	lea    -0x2c(%ebp),%edx
     789:	52                   	push   %edx
     78a:	50                   	push   %eax
     78b:	68 18 1e 00 00       	push   $0x1e18
     790:	6a 02                	push   $0x2
     792:	e8 f4 11 00 00       	call   198b <printf>
     797:	83 c4 20             	add    $0x20,%esp
			}
			currentProc = currentProc->nextProcess;
     79a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     79d:	8b 40 04             	mov    0x4(%eax),%eax
     7a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		return;
	}
	while (currentJob!=0){
		struct jobprocess* currentProc = currentJob->headOfProcesses;
		printf(2, "Job %d: %s", currentJob->id, currentJob->cmd);
		while (currentProc != 0 ){
     7a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7a7:	75 a9                	jne    752 <printAllJobs+0x56>
			if (pstat(currentProc->pid, &stat) == 0){
				printf(2, "%d: %s %d %d %s\n", currentProc->pid, stat.name, stat.sz, stat.nofile, states[stat.state]);
			}
			currentProc = currentProc->nextProcess;
		}
		currentJob = currentJob->nextjob;
     7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ac:	8b 40 04             	mov    0x4(%eax),%eax
     7af:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job* currentJob = head;
	if (head == 0) {
		printf(2, "There are no jobs\n");
		return;
	}
	while (currentJob!=0){
     7b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7b6:	0f 85 6f ff ff ff    	jne    72b <printAllJobs+0x2f>
			}
			currentProc = currentProc->nextProcess;
		}
		currentJob = currentJob->nextjob;
	}
	return;
     7bc:	90                   	nop
}
     7bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7c0:	c9                   	leave  
     7c1:	c3                   	ret    

000007c2 <addProcessToJob>:

void addProcessToJob(struct job *job , int pid){
     7c2:	55                   	push   %ebp
     7c3:	89 e5                	mov    %esp,%ebp
     7c5:	83 ec 18             	sub    $0x18,%esp
	struct jobprocess *newProcess = getProcess(pid);
     7c8:	83 ec 0c             	sub    $0xc,%esp
     7cb:	ff 75 0c             	pushl  0xc(%ebp)
     7ce:	e8 c6 04 00 00       	call   c99 <getProcess>
     7d3:	83 c4 10             	add    $0x10,%esp
     7d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	newProcess->nextProcess = job->headOfProcesses;
     7d9:	8b 45 08             	mov    0x8(%ebp),%eax
     7dc:	8b 50 08             	mov    0x8(%eax),%edx
     7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e2:	89 50 04             	mov    %edx,0x4(%eax)
	job->headOfProcesses = newProcess;
     7e5:	8b 45 08             	mov    0x8(%ebp),%eax
     7e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7eb:	89 50 08             	mov    %edx,0x8(%eax)

	printf(1, "Added process id = %d to Job id = %d\n", newProcess->pid, job->id);
     7ee:	8b 45 08             	mov    0x8(%ebp),%eax
     7f1:	8b 10                	mov    (%eax),%edx
     7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f6:	8b 00                	mov    (%eax),%eax
     7f8:	52                   	push   %edx
     7f9:	50                   	push   %eax
     7fa:	68 2c 1e 00 00       	push   $0x1e2c
     7ff:	6a 01                	push   $0x1
     801:	e8 85 11 00 00       	call   198b <printf>
     806:	83 c4 10             	add    $0x10,%esp

}
     809:	c9                   	leave  
     80a:	c3                   	ret    

0000080b <findJobById>:

struct job *findJobById(struct job *head , int pid){
     80b:	55                   	push   %ebp
     80c:	89 e5                	mov    %esp,%ebp
     80e:	83 ec 10             	sub    $0x10,%esp
	struct job* currentJob = head;
     811:	8b 45 08             	mov    0x8(%ebp),%eax
     814:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (head == 0) {
     817:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     81b:	75 05                	jne    822 <findJobById+0x17>
		return head;
     81d:	8b 45 08             	mov    0x8(%ebp),%eax
     820:	eb 20                	jmp    842 <findJobById+0x37>
	}
	while (currentJob != 0){
     822:	eb 15                	jmp    839 <findJobById+0x2e>
		if (currentJob->id == pid){
     824:	8b 45 fc             	mov    -0x4(%ebp),%eax
     827:	8b 00                	mov    (%eax),%eax
     829:	3b 45 0c             	cmp    0xc(%ebp),%eax
     82c:	75 02                	jne    830 <findJobById+0x25>
			break;
     82e:	eb 0f                	jmp    83f <findJobById+0x34>
		}
		currentJob = currentJob->nextjob;
     830:	8b 45 fc             	mov    -0x4(%ebp),%eax
     833:	8b 40 04             	mov    0x4(%eax),%eax
     836:	89 45 fc             	mov    %eax,-0x4(%ebp)
struct job *findJobById(struct job *head , int pid){
	struct job* currentJob = head;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
     839:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     83d:	75 e5                	jne    824 <findJobById+0x19>
		if (currentJob->id == pid){
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return currentJob;
     83f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     842:	c9                   	leave  
     843:	c3                   	ret    

00000844 <findForegroundJob>:

struct job *findForegroundJob(struct job *head){
     844:	55                   	push   %ebp
     845:	89 e5                	mov    %esp,%ebp
     847:	83 ec 10             	sub    $0x10,%esp
	struct job* currentJob = head;
     84a:	8b 45 08             	mov    0x8(%ebp),%eax
     84d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct job* foregroundJob = 0;
     850:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	if (head == 0) {
     857:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     85b:	75 05                	jne    862 <findForegroundJob+0x1e>
		return head;
     85d:	8b 45 08             	mov    0x8(%ebp),%eax
     860:	eb 27                	jmp    889 <findForegroundJob+0x45>
	}
	while (currentJob != 0){
     862:	eb 1c                	jmp    880 <findForegroundJob+0x3c>
		if (currentJob->type == FOREGROUND){
     864:	8b 45 fc             	mov    -0x4(%ebp),%eax
     867:	8b 40 10             	mov    0x10(%eax),%eax
     86a:	83 f8 01             	cmp    $0x1,%eax
     86d:	75 08                	jne    877 <findForegroundJob+0x33>
			foregroundJob = currentJob;
     86f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     872:	89 45 f8             	mov    %eax,-0x8(%ebp)
			break;
     875:	eb 0f                	jmp    886 <findForegroundJob+0x42>
		}
		currentJob = currentJob->nextjob;
     877:	8b 45 fc             	mov    -0x4(%ebp),%eax
     87a:	8b 40 04             	mov    0x4(%eax),%eax
     87d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct job* currentJob = head;
	struct job* foregroundJob = 0;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
     880:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     884:	75 de                	jne    864 <findForegroundJob+0x20>
			foregroundJob = currentJob;
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return foregroundJob;
     886:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     889:	c9                   	leave  
     88a:	c3                   	ret    

0000088b <clearJobList>:

struct job *clearJobList(struct job *head){
     88b:	55                   	push   %ebp
     88c:	89 e5                	mov    %esp,%ebp
     88e:	83 ec 28             	sub    $0x28,%esp
	printf(1, "---->>>> Entering clearJobs\n");
     891:	83 ec 08             	sub    $0x8,%esp
     894:	68 52 1e 00 00       	push   $0x1e52
     899:	6a 01                	push   $0x1
     89b:	e8 eb 10 00 00       	call   198b <printf>
     8a0:	83 c4 10             	add    $0x10,%esp

	if (head == 0){
     8a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     8a7:	75 08                	jne    8b1 <clearJobList+0x26>
		return head;
     8a9:	8b 45 08             	mov    0x8(%ebp),%eax
     8ac:	e9 03 02 00 00       	jmp    ab4 <clearJobList+0x229>
	}

	struct job *currentJob = head;
     8b1:	8b 45 08             	mov    0x8(%ebp),%eax
     8b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job *newHead = 0;
     8b7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	struct job *foregroundJob = 0;
     8be:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

	while (newHead == 0 && currentJob != 0){
     8c5:	e9 c6 00 00 00       	jmp    990 <clearJobList+0x105>
		struct job *temp = currentJob->nextjob;
     8ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cd:	8b 40 04             	mov    0x4(%eax),%eax
     8d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
     8d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d6:	8b 40 08             	mov    0x8(%eax),%eax
     8d9:	83 ec 0c             	sub    $0xc,%esp
     8dc:	50                   	push   %eax
     8dd:	e8 d4 01 00 00       	call   ab6 <clearZombieProcesses>
     8e2:	83 c4 10             	add    $0x10,%esp
     8e5:	89 c2                	mov    %eax,%edx
     8e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ea:	89 50 08             	mov    %edx,0x8(%eax)
		if (currentJob->headOfProcesses == 0){
     8ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f0:	8b 40 08             	mov    0x8(%eax),%eax
     8f3:	85 c0                	test   %eax,%eax
     8f5:	75 4c                	jne    943 <clearJobList+0xb8>
			printf(1, "deleting job id = %d\n", currentJob->id );
     8f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8fa:	8b 00                	mov    (%eax),%eax
     8fc:	83 ec 04             	sub    $0x4,%esp
     8ff:	50                   	push   %eax
     900:	68 6f 1e 00 00       	push   $0x1e6f
     905:	6a 01                	push   $0x1
     907:	e8 7f 10 00 00       	call   198b <printf>
     90c:	83 c4 10             	add    $0x10,%esp

			free(currentJob->cmd);
     90f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     912:	8b 40 14             	mov    0x14(%eax),%eax
     915:	83 ec 0c             	sub    $0xc,%esp
     918:	50                   	push   %eax
     919:	e8 fd 11 00 00       	call   1b1b <free>
     91e:	83 c4 10             	add    $0x10,%esp
			printf(1, "command deleted from head search\n" );
     921:	83 ec 08             	sub    $0x8,%esp
     924:	68 88 1e 00 00       	push   $0x1e88
     929:	6a 01                	push   $0x1
     92b:	e8 5b 10 00 00       	call   198b <printf>
     930:	83 c4 10             	add    $0x10,%esp

			free(currentJob);
     933:	83 ec 0c             	sub    $0xc,%esp
     936:	ff 75 f4             	pushl  -0xc(%ebp)
     939:	e8 dd 11 00 00       	call   1b1b <free>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	eb 47                	jmp    98a <clearJobList+0xff>
		}
		else {
			newHead = currentJob;
     943:	8b 45 f4             	mov    -0xc(%ebp),%eax
     946:	89 45 f0             	mov    %eax,-0x10(%ebp)
			printf(1, "new Head Jobs id = %d\n", newHead->id );
     949:	8b 45 f0             	mov    -0x10(%ebp),%eax
     94c:	8b 00                	mov    (%eax),%eax
     94e:	83 ec 04             	sub    $0x4,%esp
     951:	50                   	push   %eax
     952:	68 aa 1e 00 00       	push   $0x1eaa
     957:	6a 01                	push   $0x1
     959:	e8 2d 10 00 00       	call   198b <printf>
     95e:	83 c4 10             	add    $0x10,%esp

			if (currentJob->type == FOREGROUND){
     961:	8b 45 f4             	mov    -0xc(%ebp),%eax
     964:	8b 40 10             	mov    0x10(%eax),%eax
     967:	83 f8 01             	cmp    $0x1,%eax
     96a:	75 1e                	jne    98a <clearJobList+0xff>
				foregroundJob = currentJob;
     96c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     96f:	89 45 e8             	mov    %eax,-0x18(%ebp)
				printf(1, "Foreground job id = %d\n", foregroundJob->id);
     972:	8b 45 e8             	mov    -0x18(%ebp),%eax
     975:	8b 00                	mov    (%eax),%eax
     977:	83 ec 04             	sub    $0x4,%esp
     97a:	50                   	push   %eax
     97b:	68 c1 1e 00 00       	push   $0x1ec1
     980:	6a 01                	push   $0x1
     982:	e8 04 10 00 00       	call   198b <printf>
     987:	83 c4 10             	add    $0x10,%esp

			}
		}
		currentJob = temp;
     98a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     98d:	89 45 f4             	mov    %eax,-0xc(%ebp)

	struct job *currentJob = head;
	struct job *newHead = 0;
	struct job *foregroundJob = 0;

	while (newHead == 0 && currentJob != 0){
     990:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     994:	75 0a                	jne    9a0 <clearJobList+0x115>
     996:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     99a:	0f 85 2a ff ff ff    	jne    8ca <clearJobList+0x3f>
			}
		}
		currentJob = temp;
	}

	if(newHead != 0){
     9a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9a4:	0f 84 07 01 00 00    	je     ab1 <clearJobList+0x226>
		currentJob = newHead->nextjob;
     9aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9ad:	8b 40 04             	mov    0x4(%eax),%eax
     9b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		struct job *prevJob = newHead;
     9b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9b6:	89 45 ec             	mov    %eax,-0x14(%ebp)

		while (currentJob != 0){
     9b9:	e9 e9 00 00 00       	jmp    aa7 <clearJobList+0x21c>
			currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
     9be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c1:	8b 40 08             	mov    0x8(%eax),%eax
     9c4:	83 ec 0c             	sub    $0xc,%esp
     9c7:	50                   	push   %eax
     9c8:	e8 e9 00 00 00       	call   ab6 <clearZombieProcesses>
     9cd:	83 c4 10             	add    $0x10,%esp
     9d0:	89 c2                	mov    %eax,%edx
     9d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d5:	89 50 08             	mov    %edx,0x8(%eax)
			if (currentJob->headOfProcesses == 0){
     9d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9db:	8b 40 08             	mov    0x8(%eax),%eax
     9de:	85 c0                	test   %eax,%eax
     9e0:	0f 85 89 00 00 00    	jne    a6f <clearJobList+0x1e4>
				prevJob->nextjob = currentJob->nextjob;
     9e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9e9:	8b 50 04             	mov    0x4(%eax),%edx
     9ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9ef:	89 50 04             	mov    %edx,0x4(%eax)

				printf(1, "deleting job id = %d\n", currentJob->id );
     9f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f5:	8b 00                	mov    (%eax),%eax
     9f7:	83 ec 04             	sub    $0x4,%esp
     9fa:	50                   	push   %eax
     9fb:	68 6f 1e 00 00       	push   $0x1e6f
     a00:	6a 01                	push   $0x1
     a02:	e8 84 0f 00 00       	call   198b <printf>
     a07:	83 c4 10             	add    $0x10,%esp

				free(currentJob->cmd);
     a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0d:	8b 40 14             	mov    0x14(%eax),%eax
     a10:	83 ec 0c             	sub    $0xc,%esp
     a13:	50                   	push   %eax
     a14:	e8 02 11 00 00       	call   1b1b <free>
     a19:	83 c4 10             	add    $0x10,%esp
				printf(1, "command deleted\n" );
     a1c:	83 ec 08             	sub    $0x8,%esp
     a1f:	68 d9 1e 00 00       	push   $0x1ed9
     a24:	6a 01                	push   $0x1
     a26:	e8 60 0f 00 00       	call   198b <printf>
     a2b:	83 c4 10             	add    $0x10,%esp

				free(currentJob);
     a2e:	83 ec 0c             	sub    $0xc,%esp
     a31:	ff 75 f4             	pushl  -0xc(%ebp)
     a34:	e8 e2 10 00 00       	call   1b1b <free>
     a39:	83 c4 10             	add    $0x10,%esp
				printf(1, "job deleted after command deleted\n" );
     a3c:	83 ec 08             	sub    $0x8,%esp
     a3f:	68 ec 1e 00 00       	push   $0x1eec
     a44:	6a 01                	push   $0x1
     a46:	e8 40 0f 00 00       	call   198b <printf>
     a4b:	83 c4 10             	add    $0x10,%esp

				if (prevJob->nextjob != 0){
     a4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a51:	8b 40 04             	mov    0x4(%eax),%eax
     a54:	85 c0                	test   %eax,%eax
     a56:	74 0e                	je     a66 <clearJobList+0x1db>
					currentJob = prevJob->nextjob->nextjob;
     a58:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a5b:	8b 40 04             	mov    0x4(%eax),%eax
     a5e:	8b 40 04             	mov    0x4(%eax),%eax
     a61:	89 45 f4             	mov    %eax,-0xc(%ebp)
     a64:	eb 41                	jmp    aa7 <clearJobList+0x21c>
				}
				else {
					currentJob = 0;
     a66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a6d:	eb 38                	jmp    aa7 <clearJobList+0x21c>
				}
			}
			else {
				prevJob = currentJob;
     a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a72:	89 45 ec             	mov    %eax,-0x14(%ebp)
				currentJob = currentJob->nextjob;
     a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a78:	8b 40 04             	mov    0x4(%eax),%eax
     a7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
				if (prevJob->type == FOREGROUND){
     a7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a81:	8b 40 10             	mov    0x10(%eax),%eax
     a84:	83 f8 01             	cmp    $0x1,%eax
     a87:	75 1e                	jne    aa7 <clearJobList+0x21c>
					foregroundJob = prevJob;
     a89:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a8c:	89 45 e8             	mov    %eax,-0x18(%ebp)
					printf(1, "Foreground job id = %d\n", foregroundJob->id);
     a8f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     a92:	8b 00                	mov    (%eax),%eax
     a94:	83 ec 04             	sub    $0x4,%esp
     a97:	50                   	push   %eax
     a98:	68 c1 1e 00 00       	push   $0x1ec1
     a9d:	6a 01                	push   $0x1
     a9f:	e8 e7 0e 00 00       	call   198b <printf>
     aa4:	83 c4 10             	add    $0x10,%esp

	if(newHead != 0){
		currentJob = newHead->nextjob;
		struct job *prevJob = newHead;

		while (currentJob != 0){
     aa7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     aab:	0f 85 0d ff ff ff    	jne    9be <clearJobList+0x133>

				}
			}
		}
	}
	return newHead;
     ab1:	8b 45 f0             	mov    -0x10(%ebp),%eax

}
     ab4:	c9                   	leave  
     ab5:	c3                   	ret    

00000ab6 <clearZombieProcesses>:

struct jobprocess *clearZombieProcesses(struct jobprocess *head){
     ab6:	55                   	push   %ebp
     ab7:	89 e5                	mov    %esp,%ebp
     ab9:	83 ec 58             	sub    $0x58,%esp
	struct jobprocess *currentProcess = head;
     abc:	8b 45 08             	mov    0x8(%ebp),%eax
     abf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct jobprocess *newHead = 0;
     ac2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	if (head == 0){
     ac9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     acd:	75 08                	jne    ad7 <clearZombieProcesses+0x21>
		return head;
     acf:	8b 45 08             	mov    0x8(%ebp),%eax
     ad2:	e9 15 01 00 00       	jmp    bec <clearZombieProcesses+0x136>
	}

	while (newHead == 0  && currentProcess != 0){
     ad7:	eb 73                	jmp    b4c <clearZombieProcesses+0x96>
		struct jobprocess *temp = currentProcess->nextProcess;
     ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adc:	8b 40 04             	mov    0x4(%eax),%eax
     adf:	89 45 e8             	mov    %eax,-0x18(%ebp)
		struct procstat stat;

		if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
     ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae5:	8b 00                	mov    (%eax),%eax
     ae7:	83 ec 08             	sub    $0x8,%esp
     aea:	8d 55 cc             	lea    -0x34(%ebp),%edx
     aed:	52                   	push   %edx
     aee:	50                   	push   %eax
     aef:	e8 ba 0d 00 00       	call   18ae <pstat>
     af4:	83 c4 10             	add    $0x10,%esp
     af7:	85 c0                	test   %eax,%eax
     af9:	78 08                	js     b03 <clearZombieProcesses+0x4d>
     afb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     afe:	83 f8 05             	cmp    $0x5,%eax
     b01:	75 28                	jne    b2b <clearZombieProcesses+0x75>
			printf(1, "deleting process id = %d\n", currentProcess->pid );
     b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b06:	8b 00                	mov    (%eax),%eax
     b08:	83 ec 04             	sub    $0x4,%esp
     b0b:	50                   	push   %eax
     b0c:	68 0f 1f 00 00       	push   $0x1f0f
     b11:	6a 01                	push   $0x1
     b13:	e8 73 0e 00 00       	call   198b <printf>
     b18:	83 c4 10             	add    $0x10,%esp
			free(currentProcess);
     b1b:	83 ec 0c             	sub    $0xc,%esp
     b1e:	ff 75 f4             	pushl  -0xc(%ebp)
     b21:	e8 f5 0f 00 00       	call   1b1b <free>
     b26:	83 c4 10             	add    $0x10,%esp
     b29:	eb 06                	jmp    b31 <clearZombieProcesses+0x7b>
		}
		else {
			newHead = currentProcess;
     b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		}
		printf(1, "current = temp ,  pointer to temp = %p\n", temp );
     b31:	83 ec 04             	sub    $0x4,%esp
     b34:	ff 75 e8             	pushl  -0x18(%ebp)
     b37:	68 2c 1f 00 00       	push   $0x1f2c
     b3c:	6a 01                	push   $0x1
     b3e:	e8 48 0e 00 00       	call   198b <printf>
     b43:	83 c4 10             	add    $0x10,%esp

		currentProcess = temp;
     b46:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b49:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if (head == 0){
		return head;
	}

	while (newHead == 0  && currentProcess != 0){
     b4c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     b50:	75 06                	jne    b58 <clearZombieProcesses+0xa2>
     b52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b56:	75 81                	jne    ad9 <clearZombieProcesses+0x23>
		printf(1, "current = temp ,  pointer to temp = %p\n", temp );

		currentProcess = temp;
	}

	if(newHead != 0){
     b58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     b5c:	0f 84 87 00 00 00    	je     be9 <clearZombieProcesses+0x133>
		currentProcess = newHead->nextProcess;
     b62:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b65:	8b 40 04             	mov    0x4(%eax),%eax
     b68:	89 45 f4             	mov    %eax,-0xc(%ebp)
		struct jobprocess *prevProcess = newHead;
     b6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b6e:	89 45 ec             	mov    %eax,-0x14(%ebp)

		while (currentProcess != 0){
     b71:	eb 70                	jmp    be3 <clearZombieProcesses+0x12d>
			struct procstat stat;

			if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
     b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b76:	8b 00                	mov    (%eax),%eax
     b78:	83 ec 08             	sub    $0x8,%esp
     b7b:	8d 55 b0             	lea    -0x50(%ebp),%edx
     b7e:	52                   	push   %edx
     b7f:	50                   	push   %eax
     b80:	e8 29 0d 00 00       	call   18ae <pstat>
     b85:	83 c4 10             	add    $0x10,%esp
     b88:	85 c0                	test   %eax,%eax
     b8a:	78 08                	js     b94 <clearZombieProcesses+0xde>
     b8c:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b8f:	83 f8 05             	cmp    $0x5,%eax
     b92:	75 40                	jne    bd4 <clearZombieProcesses+0x11e>
				prevProcess->nextProcess = currentProcess->nextProcess;
     b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b97:	8b 50 04             	mov    0x4(%eax),%edx
     b9a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b9d:	89 50 04             	mov    %edx,0x4(%eax)

				printf(1, " --- deleting process id = %d\n", currentProcess->pid );
     ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba3:	8b 00                	mov    (%eax),%eax
     ba5:	83 ec 04             	sub    $0x4,%esp
     ba8:	50                   	push   %eax
     ba9:	68 54 1f 00 00       	push   $0x1f54
     bae:	6a 01                	push   $0x1
     bb0:	e8 d6 0d 00 00       	call   198b <printf>
     bb5:	83 c4 10             	add    $0x10,%esp

				free(currentProcess);
     bb8:	83 ec 0c             	sub    $0xc,%esp
     bbb:	ff 75 f4             	pushl  -0xc(%ebp)
     bbe:	e8 58 0f 00 00       	call   1b1b <free>
     bc3:	83 c4 10             	add    $0x10,%esp
				currentProcess = prevProcess->nextProcess->nextProcess;
     bc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bc9:	8b 40 04             	mov    0x4(%eax),%eax
     bcc:	8b 40 04             	mov    0x4(%eax),%eax
     bcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
     bd2:	eb 0f                	jmp    be3 <clearZombieProcesses+0x12d>
			}
			else {
				prevProcess = currentProcess;
     bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd7:	89 45 ec             	mov    %eax,-0x14(%ebp)
				currentProcess = currentProcess->nextProcess;
     bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bdd:	8b 40 04             	mov    0x4(%eax),%eax
     be0:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if(newHead != 0){
		currentProcess = newHead->nextProcess;
		struct jobprocess *prevProcess = newHead;

		while (currentProcess != 0){
     be3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     be7:	75 8a                	jne    b73 <clearZombieProcesses+0xbd>
				prevProcess = currentProcess;
				currentProcess = currentProcess->nextProcess;
			}
		}
	}
	return newHead;
     be9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     bec:	c9                   	leave  
     bed:	c3                   	ret    

00000bee <getJob>:


struct job *getJob(int jobId , int inputFd, char* buf){
     bee:	55                   	push   %ebp
     bef:	89 e5                	mov    %esp,%ebp
     bf1:	83 ec 18             	sub    $0x18,%esp
	struct job *newJob;

	newJob = malloc(sizeof(*newJob));
     bf4:	83 ec 0c             	sub    $0xc,%esp
     bf7:	6a 18                	push   $0x18
     bf9:	e8 5e 10 00 00       	call   1c5c <malloc>
     bfe:	83 c4 10             	add    $0x10,%esp
     c01:	89 45 f4             	mov    %eax,-0xc(%ebp)
	memset(newJob, 0, sizeof(*newJob));
     c04:	83 ec 04             	sub    $0x4,%esp
     c07:	6a 18                	push   $0x18
     c09:	6a 00                	push   $0x0
     c0b:	ff 75 f4             	pushl  -0xc(%ebp)
     c0e:	e8 61 0a 00 00       	call   1674 <memset>
     c13:	83 c4 10             	add    $0x10,%esp
	newJob->id = jobId;
     c16:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c19:	8b 55 08             	mov    0x8(%ebp),%edx
     c1c:	89 10                	mov    %edx,(%eax)
	newJob->nextjob = 0;// NULL
     c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c21:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	newJob->headOfProcesses = 0; //NULL
     c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	newJob->jobInFd = inputFd ;
     c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c35:	8b 55 0c             	mov    0xc(%ebp),%edx
     c38:	89 50 0c             	mov    %edx,0xc(%eax)
	newJob->type = FOREGROUND;
     c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3e:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)

	newJob->cmd = malloc(strlen(buf));
     c45:	83 ec 0c             	sub    $0xc,%esp
     c48:	ff 75 10             	pushl  0x10(%ebp)
     c4b:	e8 fd 09 00 00       	call   164d <strlen>
     c50:	83 c4 10             	add    $0x10,%esp
     c53:	83 ec 0c             	sub    $0xc,%esp
     c56:	50                   	push   %eax
     c57:	e8 00 10 00 00       	call   1c5c <malloc>
     c5c:	83 c4 10             	add    $0x10,%esp
     c5f:	89 c2                	mov    %eax,%edx
     c61:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c64:	89 50 14             	mov    %edx,0x14(%eax)
	strcpy(newJob->cmd, buf);
     c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6a:	8b 40 14             	mov    0x14(%eax),%eax
     c6d:	83 ec 08             	sub    $0x8,%esp
     c70:	ff 75 10             	pushl  0x10(%ebp)
     c73:	50                   	push   %eax
     c74:	e8 65 09 00 00       	call   15de <strcpy>
     c79:	83 c4 10             	add    $0x10,%esp
	printf(1, "Created new job id = %d\n", newJob->id);
     c7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c7f:	8b 00                	mov    (%eax),%eax
     c81:	83 ec 04             	sub    $0x4,%esp
     c84:	50                   	push   %eax
     c85:	68 73 1f 00 00       	push   $0x1f73
     c8a:	6a 01                	push   $0x1
     c8c:	e8 fa 0c 00 00       	call   198b <printf>
     c91:	83 c4 10             	add    $0x10,%esp

	return newJob;
     c94:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c97:	c9                   	leave  
     c98:	c3                   	ret    

00000c99 <getProcess>:

struct jobprocess *getProcess(int pid){
     c99:	55                   	push   %ebp
     c9a:	89 e5                	mov    %esp,%ebp
     c9c:	83 ec 18             	sub    $0x18,%esp
	struct jobprocess *newProcess;

	newProcess = malloc(sizeof(*newProcess));
     c9f:	83 ec 0c             	sub    $0xc,%esp
     ca2:	6a 08                	push   $0x8
     ca4:	e8 b3 0f 00 00       	call   1c5c <malloc>
     ca9:	83 c4 10             	add    $0x10,%esp
     cac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	memset(newProcess, 0, sizeof(*newProcess));
     caf:	83 ec 04             	sub    $0x4,%esp
     cb2:	6a 08                	push   $0x8
     cb4:	6a 00                	push   $0x0
     cb6:	ff 75 f4             	pushl  -0xc(%ebp)
     cb9:	e8 b6 09 00 00       	call   1674 <memset>
     cbe:	83 c4 10             	add    $0x10,%esp
	newProcess->pid = pid;
     cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc4:	8b 55 08             	mov    0x8(%ebp),%edx
     cc7:	89 10                	mov    %edx,(%eax)
	newProcess->nextProcess = 0;
     cc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ccc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	return newProcess;
     cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     cd6:	c9                   	leave  
     cd7:	c3                   	ret    

00000cd8 <panic>:

void
panic(char *s)
{
     cd8:	55                   	push   %ebp
     cd9:	89 e5                	mov    %esp,%ebp
     cdb:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     cde:	83 ec 04             	sub    $0x4,%esp
     ce1:	ff 75 08             	pushl  0x8(%ebp)
     ce4:	68 8c 1f 00 00       	push   $0x1f8c
     ce9:	6a 02                	push   $0x2
     ceb:	e8 9b 0c 00 00       	call   198b <printf>
     cf0:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
     cf3:	83 ec 0c             	sub    $0xc,%esp
     cf6:	6a 01                	push   $0x1
     cf8:	e8 11 0b 00 00       	call   180e <exit>

00000cfd <fork1>:
}

int
fork1(void)
{
     cfd:	55                   	push   %ebp
     cfe:	89 e5                	mov    %esp,%ebp
     d00:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     d03:	e8 fe 0a 00 00       	call   1806 <fork>
     d08:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     d0b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     d0f:	75 10                	jne    d21 <fork1+0x24>
    panic("fork");
     d11:	83 ec 0c             	sub    $0xc,%esp
     d14:	68 90 1f 00 00       	push   $0x1f90
     d19:	e8 ba ff ff ff       	call   cd8 <panic>
     d1e:	83 c4 10             	add    $0x10,%esp
  return pid;
     d21:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d24:	c9                   	leave  
     d25:	c3                   	ret    

00000d26 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     d26:	55                   	push   %ebp
     d27:	89 e5                	mov    %esp,%ebp
     d29:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     d2c:	83 ec 0c             	sub    $0xc,%esp
     d2f:	6a 54                	push   $0x54
     d31:	e8 26 0f 00 00       	call   1c5c <malloc>
     d36:	83 c4 10             	add    $0x10,%esp
     d39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     d3c:	83 ec 04             	sub    $0x4,%esp
     d3f:	6a 54                	push   $0x54
     d41:	6a 00                	push   $0x0
     d43:	ff 75 f4             	pushl  -0xc(%ebp)
     d46:	e8 29 09 00 00       	call   1674 <memset>
     d4b:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     d4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d51:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d5a:	c9                   	leave  
     d5b:	c3                   	ret    

00000d5c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     d5c:	55                   	push   %ebp
     d5d:	89 e5                	mov    %esp,%ebp
     d5f:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     d62:	83 ec 0c             	sub    $0xc,%esp
     d65:	6a 18                	push   $0x18
     d67:	e8 f0 0e 00 00       	call   1c5c <malloc>
     d6c:	83 c4 10             	add    $0x10,%esp
     d6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     d72:	83 ec 04             	sub    $0x4,%esp
     d75:	6a 18                	push   $0x18
     d77:	6a 00                	push   $0x0
     d79:	ff 75 f4             	pushl  -0xc(%ebp)
     d7c:	e8 f3 08 00 00       	call   1674 <memset>
     d81:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     d84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d87:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     d8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d90:	8b 55 08             	mov    0x8(%ebp),%edx
     d93:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d99:	8b 55 0c             	mov    0xc(%ebp),%edx
     d9c:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da2:	8b 55 10             	mov    0x10(%ebp),%edx
     da5:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     da8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dab:	8b 55 14             	mov    0x14(%ebp),%edx
     dae:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     db1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db4:	8b 55 18             	mov    0x18(%ebp),%edx
     db7:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dbd:	c9                   	leave  
     dbe:	c3                   	ret    

00000dbf <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     dbf:	55                   	push   %ebp
     dc0:	89 e5                	mov    %esp,%ebp
     dc2:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     dc5:	83 ec 0c             	sub    $0xc,%esp
     dc8:	6a 0c                	push   $0xc
     dca:	e8 8d 0e 00 00       	call   1c5c <malloc>
     dcf:	83 c4 10             	add    $0x10,%esp
     dd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     dd5:	83 ec 04             	sub    $0x4,%esp
     dd8:	6a 0c                	push   $0xc
     dda:	6a 00                	push   $0x0
     ddc:	ff 75 f4             	pushl  -0xc(%ebp)
     ddf:	e8 90 08 00 00       	call   1674 <memset>
     de4:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     de7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dea:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df3:	8b 55 08             	mov    0x8(%ebp),%edx
     df6:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     df9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dfc:	8b 55 0c             	mov    0xc(%ebp),%edx
     dff:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     e02:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e05:	c9                   	leave  
     e06:	c3                   	ret    

00000e07 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     e07:	55                   	push   %ebp
     e08:	89 e5                	mov    %esp,%ebp
     e0a:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     e0d:	83 ec 0c             	sub    $0xc,%esp
     e10:	6a 0c                	push   $0xc
     e12:	e8 45 0e 00 00       	call   1c5c <malloc>
     e17:	83 c4 10             	add    $0x10,%esp
     e1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     e1d:	83 ec 04             	sub    $0x4,%esp
     e20:	6a 0c                	push   $0xc
     e22:	6a 00                	push   $0x0
     e24:	ff 75 f4             	pushl  -0xc(%ebp)
     e27:	e8 48 08 00 00       	call   1674 <memset>
     e2c:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     e2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e32:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e3b:	8b 55 08             	mov    0x8(%ebp),%edx
     e3e:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     e41:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e44:	8b 55 0c             	mov    0xc(%ebp),%edx
     e47:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     e4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e4d:	c9                   	leave  
     e4e:	c3                   	ret    

00000e4f <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     e4f:	55                   	push   %ebp
     e50:	89 e5                	mov    %esp,%ebp
     e52:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     e55:	83 ec 0c             	sub    $0xc,%esp
     e58:	6a 08                	push   $0x8
     e5a:	e8 fd 0d 00 00       	call   1c5c <malloc>
     e5f:	83 c4 10             	add    $0x10,%esp
     e62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     e65:	83 ec 04             	sub    $0x4,%esp
     e68:	6a 08                	push   $0x8
     e6a:	6a 00                	push   $0x0
     e6c:	ff 75 f4             	pushl  -0xc(%ebp)
     e6f:	e8 00 08 00 00       	call   1674 <memset>
     e74:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     e77:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e7a:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     e80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e83:	8b 55 08             	mov    0x8(%ebp),%edx
     e86:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e8c:	c9                   	leave  
     e8d:	c3                   	ret    

00000e8e <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     e8e:	55                   	push   %ebp
     e8f:	89 e5                	mov    %esp,%ebp
     e91:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     e94:	8b 45 08             	mov    0x8(%ebp),%eax
     e97:	8b 00                	mov    (%eax),%eax
     e99:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     e9c:	eb 04                	jmp    ea2 <gettoken+0x14>
    s++;
     e9e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     ea2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ea8:	73 1e                	jae    ec8 <gettoken+0x3a>
     eaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ead:	0f b6 00             	movzbl (%eax),%eax
     eb0:	0f be c0             	movsbl %al,%eax
     eb3:	83 ec 08             	sub    $0x8,%esp
     eb6:	50                   	push   %eax
     eb7:	68 c8 25 00 00       	push   $0x25c8
     ebc:	e8 cd 07 00 00       	call   168e <strchr>
     ec1:	83 c4 10             	add    $0x10,%esp
     ec4:	85 c0                	test   %eax,%eax
     ec6:	75 d6                	jne    e9e <gettoken+0x10>
    s++;
  if(q)
     ec8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     ecc:	74 08                	je     ed6 <gettoken+0x48>
    *q = s;
     ece:	8b 45 10             	mov    0x10(%ebp),%eax
     ed1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ed4:	89 10                	mov    %edx,(%eax)
  ret = *s;
     ed6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed9:	0f b6 00             	movzbl (%eax),%eax
     edc:	0f be c0             	movsbl %al,%eax
     edf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     ee2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ee5:	0f b6 00             	movzbl (%eax),%eax
     ee8:	0f be c0             	movsbl %al,%eax
     eeb:	83 f8 29             	cmp    $0x29,%eax
     eee:	7f 14                	jg     f04 <gettoken+0x76>
     ef0:	83 f8 28             	cmp    $0x28,%eax
     ef3:	7d 28                	jge    f1d <gettoken+0x8f>
     ef5:	85 c0                	test   %eax,%eax
     ef7:	0f 84 96 00 00 00    	je     f93 <gettoken+0x105>
     efd:	83 f8 26             	cmp    $0x26,%eax
     f00:	74 1b                	je     f1d <gettoken+0x8f>
     f02:	eb 3c                	jmp    f40 <gettoken+0xb2>
     f04:	83 f8 3e             	cmp    $0x3e,%eax
     f07:	74 1a                	je     f23 <gettoken+0x95>
     f09:	83 f8 3e             	cmp    $0x3e,%eax
     f0c:	7f 0a                	jg     f18 <gettoken+0x8a>
     f0e:	83 e8 3b             	sub    $0x3b,%eax
     f11:	83 f8 01             	cmp    $0x1,%eax
     f14:	77 2a                	ja     f40 <gettoken+0xb2>
     f16:	eb 05                	jmp    f1d <gettoken+0x8f>
     f18:	83 f8 7c             	cmp    $0x7c,%eax
     f1b:	75 23                	jne    f40 <gettoken+0xb2>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     f1d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     f21:	eb 71                	jmp    f94 <gettoken+0x106>
  case '>':
    s++;
     f23:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     f27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f2a:	0f b6 00             	movzbl (%eax),%eax
     f2d:	3c 3e                	cmp    $0x3e,%al
     f2f:	75 0d                	jne    f3e <gettoken+0xb0>
      ret = '+';
     f31:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     f38:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     f3c:	eb 56                	jmp    f94 <gettoken+0x106>
     f3e:	eb 54                	jmp    f94 <gettoken+0x106>
  default:
    ret = 'a';
     f40:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     f47:	eb 04                	jmp    f4d <gettoken+0xbf>
      s++;
     f49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     f4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f50:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f53:	73 3c                	jae    f91 <gettoken+0x103>
     f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f58:	0f b6 00             	movzbl (%eax),%eax
     f5b:	0f be c0             	movsbl %al,%eax
     f5e:	83 ec 08             	sub    $0x8,%esp
     f61:	50                   	push   %eax
     f62:	68 c8 25 00 00       	push   $0x25c8
     f67:	e8 22 07 00 00       	call   168e <strchr>
     f6c:	83 c4 10             	add    $0x10,%esp
     f6f:	85 c0                	test   %eax,%eax
     f71:	75 1e                	jne    f91 <gettoken+0x103>
     f73:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f76:	0f b6 00             	movzbl (%eax),%eax
     f79:	0f be c0             	movsbl %al,%eax
     f7c:	83 ec 08             	sub    $0x8,%esp
     f7f:	50                   	push   %eax
     f80:	68 ce 25 00 00       	push   $0x25ce
     f85:	e8 04 07 00 00       	call   168e <strchr>
     f8a:	83 c4 10             	add    $0x10,%esp
     f8d:	85 c0                	test   %eax,%eax
     f8f:	74 b8                	je     f49 <gettoken+0xbb>
      s++;
    break;
     f91:	eb 01                	jmp    f94 <gettoken+0x106>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     f93:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     f94:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     f98:	74 08                	je     fa2 <gettoken+0x114>
    *eq = s;
     f9a:	8b 45 14             	mov    0x14(%ebp),%eax
     f9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     fa0:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     fa2:	eb 04                	jmp    fa8 <gettoken+0x11a>
    s++;
     fa4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     fa8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fab:	3b 45 0c             	cmp    0xc(%ebp),%eax
     fae:	73 1e                	jae    fce <gettoken+0x140>
     fb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb3:	0f b6 00             	movzbl (%eax),%eax
     fb6:	0f be c0             	movsbl %al,%eax
     fb9:	83 ec 08             	sub    $0x8,%esp
     fbc:	50                   	push   %eax
     fbd:	68 c8 25 00 00       	push   $0x25c8
     fc2:	e8 c7 06 00 00       	call   168e <strchr>
     fc7:	83 c4 10             	add    $0x10,%esp
     fca:	85 c0                	test   %eax,%eax
     fcc:	75 d6                	jne    fa4 <gettoken+0x116>
    s++;
  *ps = s;
     fce:	8b 45 08             	mov    0x8(%ebp),%eax
     fd1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     fd4:	89 10                	mov    %edx,(%eax)
  return ret;
     fd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     fd9:	c9                   	leave  
     fda:	c3                   	ret    

00000fdb <peek>:

int
peek(char **ps, char *es, char *toks)
{
     fdb:	55                   	push   %ebp
     fdc:	89 e5                	mov    %esp,%ebp
     fde:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     fe1:	8b 45 08             	mov    0x8(%ebp),%eax
     fe4:	8b 00                	mov    (%eax),%eax
     fe6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     fe9:	eb 04                	jmp    fef <peek+0x14>
    s++;
     feb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     fef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ff2:	3b 45 0c             	cmp    0xc(%ebp),%eax
     ff5:	73 1e                	jae    1015 <peek+0x3a>
     ff7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ffa:	0f b6 00             	movzbl (%eax),%eax
     ffd:	0f be c0             	movsbl %al,%eax
    1000:	83 ec 08             	sub    $0x8,%esp
    1003:	50                   	push   %eax
    1004:	68 c8 25 00 00       	push   $0x25c8
    1009:	e8 80 06 00 00       	call   168e <strchr>
    100e:	83 c4 10             	add    $0x10,%esp
    1011:	85 c0                	test   %eax,%eax
    1013:	75 d6                	jne    feb <peek+0x10>
    s++;
  *ps = s;
    1015:	8b 45 08             	mov    0x8(%ebp),%eax
    1018:	8b 55 f4             	mov    -0xc(%ebp),%edx
    101b:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
    101d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1020:	0f b6 00             	movzbl (%eax),%eax
    1023:	84 c0                	test   %al,%al
    1025:	74 23                	je     104a <peek+0x6f>
    1027:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102a:	0f b6 00             	movzbl (%eax),%eax
    102d:	0f be c0             	movsbl %al,%eax
    1030:	83 ec 08             	sub    $0x8,%esp
    1033:	50                   	push   %eax
    1034:	ff 75 10             	pushl  0x10(%ebp)
    1037:	e8 52 06 00 00       	call   168e <strchr>
    103c:	83 c4 10             	add    $0x10,%esp
    103f:	85 c0                	test   %eax,%eax
    1041:	74 07                	je     104a <peek+0x6f>
    1043:	b8 01 00 00 00       	mov    $0x1,%eax
    1048:	eb 05                	jmp    104f <peek+0x74>
    104a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    104f:	c9                   	leave  
    1050:	c3                   	ret    

00001051 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
    1051:	55                   	push   %ebp
    1052:	89 e5                	mov    %esp,%ebp
    1054:	53                   	push   %ebx
    1055:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
    1058:	8b 5d 08             	mov    0x8(%ebp),%ebx
    105b:	8b 45 08             	mov    0x8(%ebp),%eax
    105e:	83 ec 0c             	sub    $0xc,%esp
    1061:	50                   	push   %eax
    1062:	e8 e6 05 00 00       	call   164d <strlen>
    1067:	83 c4 10             	add    $0x10,%esp
    106a:	01 d8                	add    %ebx,%eax
    106c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
    106f:	83 ec 08             	sub    $0x8,%esp
    1072:	ff 75 f4             	pushl  -0xc(%ebp)
    1075:	8d 45 08             	lea    0x8(%ebp),%eax
    1078:	50                   	push   %eax
    1079:	e8 61 00 00 00       	call   10df <parseline>
    107e:	83 c4 10             	add    $0x10,%esp
    1081:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
    1084:	83 ec 04             	sub    $0x4,%esp
    1087:	68 95 1f 00 00       	push   $0x1f95
    108c:	ff 75 f4             	pushl  -0xc(%ebp)
    108f:	8d 45 08             	lea    0x8(%ebp),%eax
    1092:	50                   	push   %eax
    1093:	e8 43 ff ff ff       	call   fdb <peek>
    1098:	83 c4 10             	add    $0x10,%esp
  if(s != es){
    109b:	8b 45 08             	mov    0x8(%ebp),%eax
    109e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10a1:	74 26                	je     10c9 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	83 ec 04             	sub    $0x4,%esp
    10a9:	50                   	push   %eax
    10aa:	68 96 1f 00 00       	push   $0x1f96
    10af:	6a 02                	push   $0x2
    10b1:	e8 d5 08 00 00       	call   198b <printf>
    10b6:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
    10b9:	83 ec 0c             	sub    $0xc,%esp
    10bc:	68 a5 1f 00 00       	push   $0x1fa5
    10c1:	e8 12 fc ff ff       	call   cd8 <panic>
    10c6:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
    10c9:	83 ec 0c             	sub    $0xc,%esp
    10cc:	ff 75 f0             	pushl  -0x10(%ebp)
    10cf:	e8 e9 03 00 00       	call   14bd <nulterminate>
    10d4:	83 c4 10             	add    $0x10,%esp
  return cmd;
    10d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    10da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10dd:	c9                   	leave  
    10de:	c3                   	ret    

000010df <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
    10df:	55                   	push   %ebp
    10e0:	89 e5                	mov    %esp,%ebp
    10e2:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
    10e5:	83 ec 08             	sub    $0x8,%esp
    10e8:	ff 75 0c             	pushl  0xc(%ebp)
    10eb:	ff 75 08             	pushl  0x8(%ebp)
    10ee:	e8 99 00 00 00       	call   118c <parsepipe>
    10f3:	83 c4 10             	add    $0x10,%esp
    10f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
    10f9:	eb 23                	jmp    111e <parseline+0x3f>
    gettoken(ps, es, 0, 0);
    10fb:	6a 00                	push   $0x0
    10fd:	6a 00                	push   $0x0
    10ff:	ff 75 0c             	pushl  0xc(%ebp)
    1102:	ff 75 08             	pushl  0x8(%ebp)
    1105:	e8 84 fd ff ff       	call   e8e <gettoken>
    110a:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
    110d:	83 ec 0c             	sub    $0xc,%esp
    1110:	ff 75 f4             	pushl  -0xc(%ebp)
    1113:	e8 37 fd ff ff       	call   e4f <backcmd>
    1118:	83 c4 10             	add    $0x10,%esp
    111b:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    111e:	83 ec 04             	sub    $0x4,%esp
    1121:	68 ac 1f 00 00       	push   $0x1fac
    1126:	ff 75 0c             	pushl  0xc(%ebp)
    1129:	ff 75 08             	pushl  0x8(%ebp)
    112c:	e8 aa fe ff ff       	call   fdb <peek>
    1131:	83 c4 10             	add    $0x10,%esp
    1134:	85 c0                	test   %eax,%eax
    1136:	75 c3                	jne    10fb <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    1138:	83 ec 04             	sub    $0x4,%esp
    113b:	68 ae 1f 00 00       	push   $0x1fae
    1140:	ff 75 0c             	pushl  0xc(%ebp)
    1143:	ff 75 08             	pushl  0x8(%ebp)
    1146:	e8 90 fe ff ff       	call   fdb <peek>
    114b:	83 c4 10             	add    $0x10,%esp
    114e:	85 c0                	test   %eax,%eax
    1150:	74 35                	je     1187 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
    1152:	6a 00                	push   $0x0
    1154:	6a 00                	push   $0x0
    1156:	ff 75 0c             	pushl  0xc(%ebp)
    1159:	ff 75 08             	pushl  0x8(%ebp)
    115c:	e8 2d fd ff ff       	call   e8e <gettoken>
    1161:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
    1164:	83 ec 08             	sub    $0x8,%esp
    1167:	ff 75 0c             	pushl  0xc(%ebp)
    116a:	ff 75 08             	pushl  0x8(%ebp)
    116d:	e8 6d ff ff ff       	call   10df <parseline>
    1172:	83 c4 10             	add    $0x10,%esp
    1175:	83 ec 08             	sub    $0x8,%esp
    1178:	50                   	push   %eax
    1179:	ff 75 f4             	pushl  -0xc(%ebp)
    117c:	e8 86 fc ff ff       	call   e07 <listcmd>
    1181:	83 c4 10             	add    $0x10,%esp
    1184:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    1187:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    118a:	c9                   	leave  
    118b:	c3                   	ret    

0000118c <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
    118c:	55                   	push   %ebp
    118d:	89 e5                	mov    %esp,%ebp
    118f:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
    1192:	83 ec 08             	sub    $0x8,%esp
    1195:	ff 75 0c             	pushl  0xc(%ebp)
    1198:	ff 75 08             	pushl  0x8(%ebp)
    119b:	e8 ec 01 00 00       	call   138c <parseexec>
    11a0:	83 c4 10             	add    $0x10,%esp
    11a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
    11a6:	83 ec 04             	sub    $0x4,%esp
    11a9:	68 b0 1f 00 00       	push   $0x1fb0
    11ae:	ff 75 0c             	pushl  0xc(%ebp)
    11b1:	ff 75 08             	pushl  0x8(%ebp)
    11b4:	e8 22 fe ff ff       	call   fdb <peek>
    11b9:	83 c4 10             	add    $0x10,%esp
    11bc:	85 c0                	test   %eax,%eax
    11be:	74 35                	je     11f5 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
    11c0:	6a 00                	push   $0x0
    11c2:	6a 00                	push   $0x0
    11c4:	ff 75 0c             	pushl  0xc(%ebp)
    11c7:	ff 75 08             	pushl  0x8(%ebp)
    11ca:	e8 bf fc ff ff       	call   e8e <gettoken>
    11cf:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
    11d2:	83 ec 08             	sub    $0x8,%esp
    11d5:	ff 75 0c             	pushl  0xc(%ebp)
    11d8:	ff 75 08             	pushl  0x8(%ebp)
    11db:	e8 ac ff ff ff       	call   118c <parsepipe>
    11e0:	83 c4 10             	add    $0x10,%esp
    11e3:	83 ec 08             	sub    $0x8,%esp
    11e6:	50                   	push   %eax
    11e7:	ff 75 f4             	pushl  -0xc(%ebp)
    11ea:	e8 d0 fb ff ff       	call   dbf <pipecmd>
    11ef:	83 c4 10             	add    $0x10,%esp
    11f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    11f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    11f8:	c9                   	leave  
    11f9:	c3                   	ret    

000011fa <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    11fa:	55                   	push   %ebp
    11fb:	89 e5                	mov    %esp,%ebp
    11fd:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    1200:	e9 b6 00 00 00       	jmp    12bb <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
    1205:	6a 00                	push   $0x0
    1207:	6a 00                	push   $0x0
    1209:	ff 75 10             	pushl  0x10(%ebp)
    120c:	ff 75 0c             	pushl  0xc(%ebp)
    120f:	e8 7a fc ff ff       	call   e8e <gettoken>
    1214:	83 c4 10             	add    $0x10,%esp
    1217:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
    121a:	8d 45 ec             	lea    -0x14(%ebp),%eax
    121d:	50                   	push   %eax
    121e:	8d 45 f0             	lea    -0x10(%ebp),%eax
    1221:	50                   	push   %eax
    1222:	ff 75 10             	pushl  0x10(%ebp)
    1225:	ff 75 0c             	pushl  0xc(%ebp)
    1228:	e8 61 fc ff ff       	call   e8e <gettoken>
    122d:	83 c4 10             	add    $0x10,%esp
    1230:	83 f8 61             	cmp    $0x61,%eax
    1233:	74 10                	je     1245 <parseredirs+0x4b>
      panic("missing file for redirection");
    1235:	83 ec 0c             	sub    $0xc,%esp
    1238:	68 b2 1f 00 00       	push   $0x1fb2
    123d:	e8 96 fa ff ff       	call   cd8 <panic>
    1242:	83 c4 10             	add    $0x10,%esp
    switch(tok){
    1245:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1248:	83 f8 3c             	cmp    $0x3c,%eax
    124b:	74 0c                	je     1259 <parseredirs+0x5f>
    124d:	83 f8 3e             	cmp    $0x3e,%eax
    1250:	74 26                	je     1278 <parseredirs+0x7e>
    1252:	83 f8 2b             	cmp    $0x2b,%eax
    1255:	74 43                	je     129a <parseredirs+0xa0>
    1257:	eb 62                	jmp    12bb <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    1259:	8b 55 ec             	mov    -0x14(%ebp),%edx
    125c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    125f:	83 ec 0c             	sub    $0xc,%esp
    1262:	6a 00                	push   $0x0
    1264:	6a 00                	push   $0x0
    1266:	52                   	push   %edx
    1267:	50                   	push   %eax
    1268:	ff 75 08             	pushl  0x8(%ebp)
    126b:	e8 ec fa ff ff       	call   d5c <redircmd>
    1270:	83 c4 20             	add    $0x20,%esp
    1273:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1276:	eb 43                	jmp    12bb <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    1278:	8b 55 ec             	mov    -0x14(%ebp),%edx
    127b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    127e:	83 ec 0c             	sub    $0xc,%esp
    1281:	6a 01                	push   $0x1
    1283:	68 01 02 00 00       	push   $0x201
    1288:	52                   	push   %edx
    1289:	50                   	push   %eax
    128a:	ff 75 08             	pushl  0x8(%ebp)
    128d:	e8 ca fa ff ff       	call   d5c <redircmd>
    1292:	83 c4 20             	add    $0x20,%esp
    1295:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1298:	eb 21                	jmp    12bb <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    129a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    129d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12a0:	83 ec 0c             	sub    $0xc,%esp
    12a3:	6a 01                	push   $0x1
    12a5:	68 01 02 00 00       	push   $0x201
    12aa:	52                   	push   %edx
    12ab:	50                   	push   %eax
    12ac:	ff 75 08             	pushl  0x8(%ebp)
    12af:	e8 a8 fa ff ff       	call   d5c <redircmd>
    12b4:	83 c4 20             	add    $0x20,%esp
    12b7:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    12ba:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    12bb:	83 ec 04             	sub    $0x4,%esp
    12be:	68 cf 1f 00 00       	push   $0x1fcf
    12c3:	ff 75 10             	pushl  0x10(%ebp)
    12c6:	ff 75 0c             	pushl  0xc(%ebp)
    12c9:	e8 0d fd ff ff       	call   fdb <peek>
    12ce:	83 c4 10             	add    $0x10,%esp
    12d1:	85 c0                	test   %eax,%eax
    12d3:	0f 85 2c ff ff ff    	jne    1205 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
    12d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12dc:	c9                   	leave  
    12dd:	c3                   	ret    

000012de <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
    12de:	55                   	push   %ebp
    12df:	89 e5                	mov    %esp,%ebp
    12e1:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    12e4:	83 ec 04             	sub    $0x4,%esp
    12e7:	68 d2 1f 00 00       	push   $0x1fd2
    12ec:	ff 75 0c             	pushl  0xc(%ebp)
    12ef:	ff 75 08             	pushl  0x8(%ebp)
    12f2:	e8 e4 fc ff ff       	call   fdb <peek>
    12f7:	83 c4 10             	add    $0x10,%esp
    12fa:	85 c0                	test   %eax,%eax
    12fc:	75 10                	jne    130e <parseblock+0x30>
    panic("parseblock");
    12fe:	83 ec 0c             	sub    $0xc,%esp
    1301:	68 d4 1f 00 00       	push   $0x1fd4
    1306:	e8 cd f9 ff ff       	call   cd8 <panic>
    130b:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    130e:	6a 00                	push   $0x0
    1310:	6a 00                	push   $0x0
    1312:	ff 75 0c             	pushl  0xc(%ebp)
    1315:	ff 75 08             	pushl  0x8(%ebp)
    1318:	e8 71 fb ff ff       	call   e8e <gettoken>
    131d:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
    1320:	83 ec 08             	sub    $0x8,%esp
    1323:	ff 75 0c             	pushl  0xc(%ebp)
    1326:	ff 75 08             	pushl  0x8(%ebp)
    1329:	e8 b1 fd ff ff       	call   10df <parseline>
    132e:	83 c4 10             	add    $0x10,%esp
    1331:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
    1334:	83 ec 04             	sub    $0x4,%esp
    1337:	68 df 1f 00 00       	push   $0x1fdf
    133c:	ff 75 0c             	pushl  0xc(%ebp)
    133f:	ff 75 08             	pushl  0x8(%ebp)
    1342:	e8 94 fc ff ff       	call   fdb <peek>
    1347:	83 c4 10             	add    $0x10,%esp
    134a:	85 c0                	test   %eax,%eax
    134c:	75 10                	jne    135e <parseblock+0x80>
    panic("syntax - missing )");
    134e:	83 ec 0c             	sub    $0xc,%esp
    1351:	68 e1 1f 00 00       	push   $0x1fe1
    1356:	e8 7d f9 ff ff       	call   cd8 <panic>
    135b:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    135e:	6a 00                	push   $0x0
    1360:	6a 00                	push   $0x0
    1362:	ff 75 0c             	pushl  0xc(%ebp)
    1365:	ff 75 08             	pushl  0x8(%ebp)
    1368:	e8 21 fb ff ff       	call   e8e <gettoken>
    136d:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
    1370:	83 ec 04             	sub    $0x4,%esp
    1373:	ff 75 0c             	pushl  0xc(%ebp)
    1376:	ff 75 08             	pushl  0x8(%ebp)
    1379:	ff 75 f4             	pushl  -0xc(%ebp)
    137c:	e8 79 fe ff ff       	call   11fa <parseredirs>
    1381:	83 c4 10             	add    $0x10,%esp
    1384:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
    1387:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    138a:	c9                   	leave  
    138b:	c3                   	ret    

0000138c <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
    138c:	55                   	push   %ebp
    138d:	89 e5                	mov    %esp,%ebp
    138f:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    1392:	83 ec 04             	sub    $0x4,%esp
    1395:	68 d2 1f 00 00       	push   $0x1fd2
    139a:	ff 75 0c             	pushl  0xc(%ebp)
    139d:	ff 75 08             	pushl  0x8(%ebp)
    13a0:	e8 36 fc ff ff       	call   fdb <peek>
    13a5:	83 c4 10             	add    $0x10,%esp
    13a8:	85 c0                	test   %eax,%eax
    13aa:	74 16                	je     13c2 <parseexec+0x36>
    return parseblock(ps, es);
    13ac:	83 ec 08             	sub    $0x8,%esp
    13af:	ff 75 0c             	pushl  0xc(%ebp)
    13b2:	ff 75 08             	pushl  0x8(%ebp)
    13b5:	e8 24 ff ff ff       	call   12de <parseblock>
    13ba:	83 c4 10             	add    $0x10,%esp
    13bd:	e9 f9 00 00 00       	jmp    14bb <parseexec+0x12f>

  ret = execcmd();
    13c2:	e8 5f f9 ff ff       	call   d26 <execcmd>
    13c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
    13ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13cd:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
    13d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
    13d7:	83 ec 04             	sub    $0x4,%esp
    13da:	ff 75 0c             	pushl  0xc(%ebp)
    13dd:	ff 75 08             	pushl  0x8(%ebp)
    13e0:	ff 75 f0             	pushl  -0x10(%ebp)
    13e3:	e8 12 fe ff ff       	call   11fa <parseredirs>
    13e8:	83 c4 10             	add    $0x10,%esp
    13eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
    13ee:	e9 88 00 00 00       	jmp    147b <parseexec+0xef>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    13f3:	8d 45 e0             	lea    -0x20(%ebp),%eax
    13f6:	50                   	push   %eax
    13f7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    13fa:	50                   	push   %eax
    13fb:	ff 75 0c             	pushl  0xc(%ebp)
    13fe:	ff 75 08             	pushl  0x8(%ebp)
    1401:	e8 88 fa ff ff       	call   e8e <gettoken>
    1406:	83 c4 10             	add    $0x10,%esp
    1409:	89 45 e8             	mov    %eax,-0x18(%ebp)
    140c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1410:	75 05                	jne    1417 <parseexec+0x8b>
      break;
    1412:	e9 82 00 00 00       	jmp    1499 <parseexec+0x10d>
    if(tok != 'a')
    1417:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
    141b:	74 10                	je     142d <parseexec+0xa1>
      panic("syntax");
    141d:	83 ec 0c             	sub    $0xc,%esp
    1420:	68 a5 1f 00 00       	push   $0x1fa5
    1425:	e8 ae f8 ff ff       	call   cd8 <panic>
    142a:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
    142d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1430:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1433:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1436:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
    143a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    143d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1440:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1443:	83 c1 08             	add    $0x8,%ecx
    1446:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
    144a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
    144e:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1452:	7e 10                	jle    1464 <parseexec+0xd8>
      panic("too many args");
    1454:	83 ec 0c             	sub    $0xc,%esp
    1457:	68 f4 1f 00 00       	push   $0x1ff4
    145c:	e8 77 f8 ff ff       	call   cd8 <panic>
    1461:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
    1464:	83 ec 04             	sub    $0x4,%esp
    1467:	ff 75 0c             	pushl  0xc(%ebp)
    146a:	ff 75 08             	pushl  0x8(%ebp)
    146d:	ff 75 f0             	pushl  -0x10(%ebp)
    1470:	e8 85 fd ff ff       	call   11fa <parseredirs>
    1475:	83 c4 10             	add    $0x10,%esp
    1478:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    147b:	83 ec 04             	sub    $0x4,%esp
    147e:	68 02 20 00 00       	push   $0x2002
    1483:	ff 75 0c             	pushl  0xc(%ebp)
    1486:	ff 75 08             	pushl  0x8(%ebp)
    1489:	e8 4d fb ff ff       	call   fdb <peek>
    148e:	83 c4 10             	add    $0x10,%esp
    1491:	85 c0                	test   %eax,%eax
    1493:	0f 84 5a ff ff ff    	je     13f3 <parseexec+0x67>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
    1499:	8b 45 ec             	mov    -0x14(%ebp),%eax
    149c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    149f:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
    14a6:	00 
  cmd->eargv[argc] = 0;
    14a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14ad:	83 c2 08             	add    $0x8,%edx
    14b0:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
    14b7:	00 
  return ret;
    14b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    14bb:	c9                   	leave  
    14bc:	c3                   	ret    

000014bd <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    14bd:	55                   	push   %ebp
    14be:	89 e5                	mov    %esp,%ebp
    14c0:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    14c3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    14c7:	75 0a                	jne    14d3 <nulterminate+0x16>
    return 0;
    14c9:	b8 00 00 00 00       	mov    $0x0,%eax
    14ce:	e9 e4 00 00 00       	jmp    15b7 <nulterminate+0xfa>
  
  switch(cmd->type){
    14d3:	8b 45 08             	mov    0x8(%ebp),%eax
    14d6:	8b 00                	mov    (%eax),%eax
    14d8:	83 f8 05             	cmp    $0x5,%eax
    14db:	0f 87 d3 00 00 00    	ja     15b4 <nulterminate+0xf7>
    14e1:	8b 04 85 08 20 00 00 	mov    0x2008(,%eax,4),%eax
    14e8:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    14ea:	8b 45 08             	mov    0x8(%ebp),%eax
    14ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
    14f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14f7:	eb 14                	jmp    150d <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
    14f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14ff:	83 c2 08             	add    $0x8,%edx
    1502:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
    1506:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    1509:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    150d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1510:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1513:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
    1517:	85 c0                	test   %eax,%eax
    1519:	75 de                	jne    14f9 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
    151b:	e9 94 00 00 00       	jmp    15b4 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    1520:	8b 45 08             	mov    0x8(%ebp),%eax
    1523:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
    1526:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1529:	8b 40 04             	mov    0x4(%eax),%eax
    152c:	83 ec 0c             	sub    $0xc,%esp
    152f:	50                   	push   %eax
    1530:	e8 88 ff ff ff       	call   14bd <nulterminate>
    1535:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    1538:	8b 45 ec             	mov    -0x14(%ebp),%eax
    153b:	8b 40 0c             	mov    0xc(%eax),%eax
    153e:	c6 00 00             	movb   $0x0,(%eax)
    break;
    1541:	eb 71                	jmp    15b4 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    1543:	8b 45 08             	mov    0x8(%ebp),%eax
    1546:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
    1549:	8b 45 e8             	mov    -0x18(%ebp),%eax
    154c:	8b 40 04             	mov    0x4(%eax),%eax
    154f:	83 ec 0c             	sub    $0xc,%esp
    1552:	50                   	push   %eax
    1553:	e8 65 ff ff ff       	call   14bd <nulterminate>
    1558:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
    155b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    155e:	8b 40 08             	mov    0x8(%eax),%eax
    1561:	83 ec 0c             	sub    $0xc,%esp
    1564:	50                   	push   %eax
    1565:	e8 53 ff ff ff       	call   14bd <nulterminate>
    156a:	83 c4 10             	add    $0x10,%esp
    break;
    156d:	eb 45                	jmp    15b4 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    156f:	8b 45 08             	mov    0x8(%ebp),%eax
    1572:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
    1575:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1578:	8b 40 04             	mov    0x4(%eax),%eax
    157b:	83 ec 0c             	sub    $0xc,%esp
    157e:	50                   	push   %eax
    157f:	e8 39 ff ff ff       	call   14bd <nulterminate>
    1584:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
    1587:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    158a:	8b 40 08             	mov    0x8(%eax),%eax
    158d:	83 ec 0c             	sub    $0xc,%esp
    1590:	50                   	push   %eax
    1591:	e8 27 ff ff ff       	call   14bd <nulterminate>
    1596:	83 c4 10             	add    $0x10,%esp
    break;
    1599:	eb 19                	jmp    15b4 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    159b:	8b 45 08             	mov    0x8(%ebp),%eax
    159e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
    15a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    15a4:	8b 40 04             	mov    0x4(%eax),%eax
    15a7:	83 ec 0c             	sub    $0xc,%esp
    15aa:	50                   	push   %eax
    15ab:	e8 0d ff ff ff       	call   14bd <nulterminate>
    15b0:	83 c4 10             	add    $0x10,%esp
    break;
    15b3:	90                   	nop
  }
  return cmd;
    15b4:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15b7:	c9                   	leave  
    15b8:	c3                   	ret    

000015b9 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    15b9:	55                   	push   %ebp
    15ba:	89 e5                	mov    %esp,%ebp
    15bc:	57                   	push   %edi
    15bd:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    15be:	8b 4d 08             	mov    0x8(%ebp),%ecx
    15c1:	8b 55 10             	mov    0x10(%ebp),%edx
    15c4:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c7:	89 cb                	mov    %ecx,%ebx
    15c9:	89 df                	mov    %ebx,%edi
    15cb:	89 d1                	mov    %edx,%ecx
    15cd:	fc                   	cld    
    15ce:	f3 aa                	rep stos %al,%es:(%edi)
    15d0:	89 ca                	mov    %ecx,%edx
    15d2:	89 fb                	mov    %edi,%ebx
    15d4:	89 5d 08             	mov    %ebx,0x8(%ebp)
    15d7:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    15da:	5b                   	pop    %ebx
    15db:	5f                   	pop    %edi
    15dc:	5d                   	pop    %ebp
    15dd:	c3                   	ret    

000015de <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    15de:	55                   	push   %ebp
    15df:	89 e5                	mov    %esp,%ebp
    15e1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    15e4:	8b 45 08             	mov    0x8(%ebp),%eax
    15e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    15ea:	90                   	nop
    15eb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ee:	8d 50 01             	lea    0x1(%eax),%edx
    15f1:	89 55 08             	mov    %edx,0x8(%ebp)
    15f4:	8b 55 0c             	mov    0xc(%ebp),%edx
    15f7:	8d 4a 01             	lea    0x1(%edx),%ecx
    15fa:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    15fd:	0f b6 12             	movzbl (%edx),%edx
    1600:	88 10                	mov    %dl,(%eax)
    1602:	0f b6 00             	movzbl (%eax),%eax
    1605:	84 c0                	test   %al,%al
    1607:	75 e2                	jne    15eb <strcpy+0xd>
    ;
  return os;
    1609:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    160c:	c9                   	leave  
    160d:	c3                   	ret    

0000160e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    160e:	55                   	push   %ebp
    160f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1611:	eb 08                	jmp    161b <strcmp+0xd>
    p++, q++;
    1613:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1617:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    161b:	8b 45 08             	mov    0x8(%ebp),%eax
    161e:	0f b6 00             	movzbl (%eax),%eax
    1621:	84 c0                	test   %al,%al
    1623:	74 10                	je     1635 <strcmp+0x27>
    1625:	8b 45 08             	mov    0x8(%ebp),%eax
    1628:	0f b6 10             	movzbl (%eax),%edx
    162b:	8b 45 0c             	mov    0xc(%ebp),%eax
    162e:	0f b6 00             	movzbl (%eax),%eax
    1631:	38 c2                	cmp    %al,%dl
    1633:	74 de                	je     1613 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1635:	8b 45 08             	mov    0x8(%ebp),%eax
    1638:	0f b6 00             	movzbl (%eax),%eax
    163b:	0f b6 d0             	movzbl %al,%edx
    163e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1641:	0f b6 00             	movzbl (%eax),%eax
    1644:	0f b6 c0             	movzbl %al,%eax
    1647:	29 c2                	sub    %eax,%edx
    1649:	89 d0                	mov    %edx,%eax
}
    164b:	5d                   	pop    %ebp
    164c:	c3                   	ret    

0000164d <strlen>:

uint
strlen(char *s)
{
    164d:	55                   	push   %ebp
    164e:	89 e5                	mov    %esp,%ebp
    1650:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1653:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    165a:	eb 04                	jmp    1660 <strlen+0x13>
    165c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1660:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1663:	8b 45 08             	mov    0x8(%ebp),%eax
    1666:	01 d0                	add    %edx,%eax
    1668:	0f b6 00             	movzbl (%eax),%eax
    166b:	84 c0                	test   %al,%al
    166d:	75 ed                	jne    165c <strlen+0xf>
    ;
  return n;
    166f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1672:	c9                   	leave  
    1673:	c3                   	ret    

00001674 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1674:	55                   	push   %ebp
    1675:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    1677:	8b 45 10             	mov    0x10(%ebp),%eax
    167a:	50                   	push   %eax
    167b:	ff 75 0c             	pushl  0xc(%ebp)
    167e:	ff 75 08             	pushl  0x8(%ebp)
    1681:	e8 33 ff ff ff       	call   15b9 <stosb>
    1686:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1689:	8b 45 08             	mov    0x8(%ebp),%eax
}
    168c:	c9                   	leave  
    168d:	c3                   	ret    

0000168e <strchr>:

char*
strchr(const char *s, char c)
{
    168e:	55                   	push   %ebp
    168f:	89 e5                	mov    %esp,%ebp
    1691:	83 ec 04             	sub    $0x4,%esp
    1694:	8b 45 0c             	mov    0xc(%ebp),%eax
    1697:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    169a:	eb 14                	jmp    16b0 <strchr+0x22>
    if(*s == c)
    169c:	8b 45 08             	mov    0x8(%ebp),%eax
    169f:	0f b6 00             	movzbl (%eax),%eax
    16a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
    16a5:	75 05                	jne    16ac <strchr+0x1e>
      return (char*)s;
    16a7:	8b 45 08             	mov    0x8(%ebp),%eax
    16aa:	eb 13                	jmp    16bf <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    16ac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    16b0:	8b 45 08             	mov    0x8(%ebp),%eax
    16b3:	0f b6 00             	movzbl (%eax),%eax
    16b6:	84 c0                	test   %al,%al
    16b8:	75 e2                	jne    169c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    16ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
    16bf:	c9                   	leave  
    16c0:	c3                   	ret    

000016c1 <gets>:

char*
gets(char *buf, int max)
{
    16c1:	55                   	push   %ebp
    16c2:	89 e5                	mov    %esp,%ebp
    16c4:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    16c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16ce:	eb 44                	jmp    1714 <gets+0x53>
    cc = read(0, &c, 1);
    16d0:	83 ec 04             	sub    $0x4,%esp
    16d3:	6a 01                	push   $0x1
    16d5:	8d 45 ef             	lea    -0x11(%ebp),%eax
    16d8:	50                   	push   %eax
    16d9:	6a 00                	push   $0x0
    16db:	e8 46 01 00 00       	call   1826 <read>
    16e0:	83 c4 10             	add    $0x10,%esp
    16e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    16e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    16ea:	7f 02                	jg     16ee <gets+0x2d>
      break;
    16ec:	eb 31                	jmp    171f <gets+0x5e>
    buf[i++] = c;
    16ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f1:	8d 50 01             	lea    0x1(%eax),%edx
    16f4:	89 55 f4             	mov    %edx,-0xc(%ebp)
    16f7:	89 c2                	mov    %eax,%edx
    16f9:	8b 45 08             	mov    0x8(%ebp),%eax
    16fc:	01 c2                	add    %eax,%edx
    16fe:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1702:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1704:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1708:	3c 0a                	cmp    $0xa,%al
    170a:	74 13                	je     171f <gets+0x5e>
    170c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1710:	3c 0d                	cmp    $0xd,%al
    1712:	74 0b                	je     171f <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1714:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1717:	83 c0 01             	add    $0x1,%eax
    171a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    171d:	7c b1                	jl     16d0 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    171f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1722:	8b 45 08             	mov    0x8(%ebp),%eax
    1725:	01 d0                	add    %edx,%eax
    1727:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    172a:	8b 45 08             	mov    0x8(%ebp),%eax
}
    172d:	c9                   	leave  
    172e:	c3                   	ret    

0000172f <stat>:

int
stat(char *n, struct stat *st)
{
    172f:	55                   	push   %ebp
    1730:	89 e5                	mov    %esp,%ebp
    1732:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1735:	83 ec 08             	sub    $0x8,%esp
    1738:	6a 00                	push   $0x0
    173a:	ff 75 08             	pushl  0x8(%ebp)
    173d:	e8 0c 01 00 00       	call   184e <open>
    1742:	83 c4 10             	add    $0x10,%esp
    1745:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    1748:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    174c:	79 07                	jns    1755 <stat+0x26>
    return -1;
    174e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1753:	eb 25                	jmp    177a <stat+0x4b>
  r = fstat(fd, st);
    1755:	83 ec 08             	sub    $0x8,%esp
    1758:	ff 75 0c             	pushl  0xc(%ebp)
    175b:	ff 75 f4             	pushl  -0xc(%ebp)
    175e:	e8 03 01 00 00       	call   1866 <fstat>
    1763:	83 c4 10             	add    $0x10,%esp
    1766:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1769:	83 ec 0c             	sub    $0xc,%esp
    176c:	ff 75 f4             	pushl  -0xc(%ebp)
    176f:	e8 c2 00 00 00       	call   1836 <close>
    1774:	83 c4 10             	add    $0x10,%esp
  return r;
    1777:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    177a:	c9                   	leave  
    177b:	c3                   	ret    

0000177c <atoi>:

int
atoi(const char *s)
{
    177c:	55                   	push   %ebp
    177d:	89 e5                	mov    %esp,%ebp
    177f:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1782:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1789:	eb 25                	jmp    17b0 <atoi+0x34>
    n = n*10 + *s++ - '0';
    178b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    178e:	89 d0                	mov    %edx,%eax
    1790:	c1 e0 02             	shl    $0x2,%eax
    1793:	01 d0                	add    %edx,%eax
    1795:	01 c0                	add    %eax,%eax
    1797:	89 c1                	mov    %eax,%ecx
    1799:	8b 45 08             	mov    0x8(%ebp),%eax
    179c:	8d 50 01             	lea    0x1(%eax),%edx
    179f:	89 55 08             	mov    %edx,0x8(%ebp)
    17a2:	0f b6 00             	movzbl (%eax),%eax
    17a5:	0f be c0             	movsbl %al,%eax
    17a8:	01 c8                	add    %ecx,%eax
    17aa:	83 e8 30             	sub    $0x30,%eax
    17ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    17b0:	8b 45 08             	mov    0x8(%ebp),%eax
    17b3:	0f b6 00             	movzbl (%eax),%eax
    17b6:	3c 2f                	cmp    $0x2f,%al
    17b8:	7e 0a                	jle    17c4 <atoi+0x48>
    17ba:	8b 45 08             	mov    0x8(%ebp),%eax
    17bd:	0f b6 00             	movzbl (%eax),%eax
    17c0:	3c 39                	cmp    $0x39,%al
    17c2:	7e c7                	jle    178b <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    17c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    17c7:	c9                   	leave  
    17c8:	c3                   	ret    

000017c9 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    17c9:	55                   	push   %ebp
    17ca:	89 e5                	mov    %esp,%ebp
    17cc:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    17cf:	8b 45 08             	mov    0x8(%ebp),%eax
    17d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    17d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    17db:	eb 17                	jmp    17f4 <memmove+0x2b>
    *dst++ = *src++;
    17dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e0:	8d 50 01             	lea    0x1(%eax),%edx
    17e3:	89 55 fc             	mov    %edx,-0x4(%ebp)
    17e6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17e9:	8d 4a 01             	lea    0x1(%edx),%ecx
    17ec:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    17ef:	0f b6 12             	movzbl (%edx),%edx
    17f2:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    17f4:	8b 45 10             	mov    0x10(%ebp),%eax
    17f7:	8d 50 ff             	lea    -0x1(%eax),%edx
    17fa:	89 55 10             	mov    %edx,0x10(%ebp)
    17fd:	85 c0                	test   %eax,%eax
    17ff:	7f dc                	jg     17dd <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1801:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1804:	c9                   	leave  
    1805:	c3                   	ret    

00001806 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1806:	b8 01 00 00 00       	mov    $0x1,%eax
    180b:	cd 40                	int    $0x40
    180d:	c3                   	ret    

0000180e <exit>:
SYSCALL(exit)
    180e:	b8 02 00 00 00       	mov    $0x2,%eax
    1813:	cd 40                	int    $0x40
    1815:	c3                   	ret    

00001816 <wait>:
SYSCALL(wait)
    1816:	b8 03 00 00 00       	mov    $0x3,%eax
    181b:	cd 40                	int    $0x40
    181d:	c3                   	ret    

0000181e <pipe>:
SYSCALL(pipe)
    181e:	b8 04 00 00 00       	mov    $0x4,%eax
    1823:	cd 40                	int    $0x40
    1825:	c3                   	ret    

00001826 <read>:
SYSCALL(read)
    1826:	b8 05 00 00 00       	mov    $0x5,%eax
    182b:	cd 40                	int    $0x40
    182d:	c3                   	ret    

0000182e <write>:
SYSCALL(write)
    182e:	b8 10 00 00 00       	mov    $0x10,%eax
    1833:	cd 40                	int    $0x40
    1835:	c3                   	ret    

00001836 <close>:
SYSCALL(close)
    1836:	b8 15 00 00 00       	mov    $0x15,%eax
    183b:	cd 40                	int    $0x40
    183d:	c3                   	ret    

0000183e <kill>:
SYSCALL(kill)
    183e:	b8 06 00 00 00       	mov    $0x6,%eax
    1843:	cd 40                	int    $0x40
    1845:	c3                   	ret    

00001846 <exec>:
SYSCALL(exec)
    1846:	b8 07 00 00 00       	mov    $0x7,%eax
    184b:	cd 40                	int    $0x40
    184d:	c3                   	ret    

0000184e <open>:
SYSCALL(open)
    184e:	b8 0f 00 00 00       	mov    $0xf,%eax
    1853:	cd 40                	int    $0x40
    1855:	c3                   	ret    

00001856 <mknod>:
SYSCALL(mknod)
    1856:	b8 11 00 00 00       	mov    $0x11,%eax
    185b:	cd 40                	int    $0x40
    185d:	c3                   	ret    

0000185e <unlink>:
SYSCALL(unlink)
    185e:	b8 12 00 00 00       	mov    $0x12,%eax
    1863:	cd 40                	int    $0x40
    1865:	c3                   	ret    

00001866 <fstat>:
SYSCALL(fstat)
    1866:	b8 08 00 00 00       	mov    $0x8,%eax
    186b:	cd 40                	int    $0x40
    186d:	c3                   	ret    

0000186e <link>:
SYSCALL(link)
    186e:	b8 13 00 00 00       	mov    $0x13,%eax
    1873:	cd 40                	int    $0x40
    1875:	c3                   	ret    

00001876 <mkdir>:
SYSCALL(mkdir)
    1876:	b8 14 00 00 00       	mov    $0x14,%eax
    187b:	cd 40                	int    $0x40
    187d:	c3                   	ret    

0000187e <chdir>:
SYSCALL(chdir)
    187e:	b8 09 00 00 00       	mov    $0x9,%eax
    1883:	cd 40                	int    $0x40
    1885:	c3                   	ret    

00001886 <dup>:
SYSCALL(dup)
    1886:	b8 0a 00 00 00       	mov    $0xa,%eax
    188b:	cd 40                	int    $0x40
    188d:	c3                   	ret    

0000188e <getpid>:
SYSCALL(getpid)
    188e:	b8 0b 00 00 00       	mov    $0xb,%eax
    1893:	cd 40                	int    $0x40
    1895:	c3                   	ret    

00001896 <sbrk>:
SYSCALL(sbrk)
    1896:	b8 0c 00 00 00       	mov    $0xc,%eax
    189b:	cd 40                	int    $0x40
    189d:	c3                   	ret    

0000189e <sleep>:
SYSCALL(sleep)
    189e:	b8 0d 00 00 00       	mov    $0xd,%eax
    18a3:	cd 40                	int    $0x40
    18a5:	c3                   	ret    

000018a6 <uptime>:
SYSCALL(uptime)
    18a6:	b8 0e 00 00 00       	mov    $0xe,%eax
    18ab:	cd 40                	int    $0x40
    18ad:	c3                   	ret    

000018ae <pstat>:
SYSCALL(pstat)
    18ae:	b8 16 00 00 00       	mov    $0x16,%eax
    18b3:	cd 40                	int    $0x40
    18b5:	c3                   	ret    

000018b6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    18b6:	55                   	push   %ebp
    18b7:	89 e5                	mov    %esp,%ebp
    18b9:	83 ec 18             	sub    $0x18,%esp
    18bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    18bf:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    18c2:	83 ec 04             	sub    $0x4,%esp
    18c5:	6a 01                	push   $0x1
    18c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
    18ca:	50                   	push   %eax
    18cb:	ff 75 08             	pushl  0x8(%ebp)
    18ce:	e8 5b ff ff ff       	call   182e <write>
    18d3:	83 c4 10             	add    $0x10,%esp
}
    18d6:	c9                   	leave  
    18d7:	c3                   	ret    

000018d8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    18d8:	55                   	push   %ebp
    18d9:	89 e5                	mov    %esp,%ebp
    18db:	53                   	push   %ebx
    18dc:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    18df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    18e6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    18ea:	74 17                	je     1903 <printint+0x2b>
    18ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18f0:	79 11                	jns    1903 <printint+0x2b>
    neg = 1;
    18f2:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    18f9:	8b 45 0c             	mov    0xc(%ebp),%eax
    18fc:	f7 d8                	neg    %eax
    18fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1901:	eb 06                	jmp    1909 <printint+0x31>
  } else {
    x = xx;
    1903:	8b 45 0c             	mov    0xc(%ebp),%eax
    1906:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1909:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1910:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1913:	8d 41 01             	lea    0x1(%ecx),%eax
    1916:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1919:	8b 5d 10             	mov    0x10(%ebp),%ebx
    191c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    191f:	ba 00 00 00 00       	mov    $0x0,%edx
    1924:	f7 f3                	div    %ebx
    1926:	89 d0                	mov    %edx,%eax
    1928:	0f b6 80 d6 25 00 00 	movzbl 0x25d6(%eax),%eax
    192f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1933:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1936:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1939:	ba 00 00 00 00       	mov    $0x0,%edx
    193e:	f7 f3                	div    %ebx
    1940:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1943:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1947:	75 c7                	jne    1910 <printint+0x38>
  if(neg)
    1949:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    194d:	74 0e                	je     195d <printint+0x85>
    buf[i++] = '-';
    194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1952:	8d 50 01             	lea    0x1(%eax),%edx
    1955:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1958:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    195d:	eb 1d                	jmp    197c <printint+0xa4>
    putc(fd, buf[i]);
    195f:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1962:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1965:	01 d0                	add    %edx,%eax
    1967:	0f b6 00             	movzbl (%eax),%eax
    196a:	0f be c0             	movsbl %al,%eax
    196d:	83 ec 08             	sub    $0x8,%esp
    1970:	50                   	push   %eax
    1971:	ff 75 08             	pushl  0x8(%ebp)
    1974:	e8 3d ff ff ff       	call   18b6 <putc>
    1979:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    197c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1980:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1984:	79 d9                	jns    195f <printint+0x87>
    putc(fd, buf[i]);
}
    1986:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1989:	c9                   	leave  
    198a:	c3                   	ret    

0000198b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    198b:	55                   	push   %ebp
    198c:	89 e5                	mov    %esp,%ebp
    198e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1991:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1998:	8d 45 0c             	lea    0xc(%ebp),%eax
    199b:	83 c0 04             	add    $0x4,%eax
    199e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    19a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    19a8:	e9 59 01 00 00       	jmp    1b06 <printf+0x17b>
    c = fmt[i] & 0xff;
    19ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    19b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19b3:	01 d0                	add    %edx,%eax
    19b5:	0f b6 00             	movzbl (%eax),%eax
    19b8:	0f be c0             	movsbl %al,%eax
    19bb:	25 ff 00 00 00       	and    $0xff,%eax
    19c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    19c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19c7:	75 2c                	jne    19f5 <printf+0x6a>
      if(c == '%'){
    19c9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    19cd:	75 0c                	jne    19db <printf+0x50>
        state = '%';
    19cf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    19d6:	e9 27 01 00 00       	jmp    1b02 <printf+0x177>
      } else {
        putc(fd, c);
    19db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19de:	0f be c0             	movsbl %al,%eax
    19e1:	83 ec 08             	sub    $0x8,%esp
    19e4:	50                   	push   %eax
    19e5:	ff 75 08             	pushl  0x8(%ebp)
    19e8:	e8 c9 fe ff ff       	call   18b6 <putc>
    19ed:	83 c4 10             	add    $0x10,%esp
    19f0:	e9 0d 01 00 00       	jmp    1b02 <printf+0x177>
      }
    } else if(state == '%'){
    19f5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    19f9:	0f 85 03 01 00 00    	jne    1b02 <printf+0x177>
      if(c == 'd'){
    19ff:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1a03:	75 1e                	jne    1a23 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1a05:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a08:	8b 00                	mov    (%eax),%eax
    1a0a:	6a 01                	push   $0x1
    1a0c:	6a 0a                	push   $0xa
    1a0e:	50                   	push   %eax
    1a0f:	ff 75 08             	pushl  0x8(%ebp)
    1a12:	e8 c1 fe ff ff       	call   18d8 <printint>
    1a17:	83 c4 10             	add    $0x10,%esp
        ap++;
    1a1a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1a1e:	e9 d8 00 00 00       	jmp    1afb <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1a23:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1a27:	74 06                	je     1a2f <printf+0xa4>
    1a29:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1a2d:	75 1e                	jne    1a4d <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1a2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a32:	8b 00                	mov    (%eax),%eax
    1a34:	6a 00                	push   $0x0
    1a36:	6a 10                	push   $0x10
    1a38:	50                   	push   %eax
    1a39:	ff 75 08             	pushl  0x8(%ebp)
    1a3c:	e8 97 fe ff ff       	call   18d8 <printint>
    1a41:	83 c4 10             	add    $0x10,%esp
        ap++;
    1a44:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1a48:	e9 ae 00 00 00       	jmp    1afb <printf+0x170>
      } else if(c == 's'){
    1a4d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1a51:	75 43                	jne    1a96 <printf+0x10b>
        s = (char*)*ap;
    1a53:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a56:	8b 00                	mov    (%eax),%eax
    1a58:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1a5b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1a5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a63:	75 07                	jne    1a6c <printf+0xe1>
          s = "(null)";
    1a65:	c7 45 f4 20 20 00 00 	movl   $0x2020,-0xc(%ebp)
        while(*s != 0){
    1a6c:	eb 1c                	jmp    1a8a <printf+0xff>
          putc(fd, *s);
    1a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a71:	0f b6 00             	movzbl (%eax),%eax
    1a74:	0f be c0             	movsbl %al,%eax
    1a77:	83 ec 08             	sub    $0x8,%esp
    1a7a:	50                   	push   %eax
    1a7b:	ff 75 08             	pushl  0x8(%ebp)
    1a7e:	e8 33 fe ff ff       	call   18b6 <putc>
    1a83:	83 c4 10             	add    $0x10,%esp
          s++;
    1a86:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8d:	0f b6 00             	movzbl (%eax),%eax
    1a90:	84 c0                	test   %al,%al
    1a92:	75 da                	jne    1a6e <printf+0xe3>
    1a94:	eb 65                	jmp    1afb <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1a96:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1a9a:	75 1d                	jne    1ab9 <printf+0x12e>
        putc(fd, *ap);
    1a9c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a9f:	8b 00                	mov    (%eax),%eax
    1aa1:	0f be c0             	movsbl %al,%eax
    1aa4:	83 ec 08             	sub    $0x8,%esp
    1aa7:	50                   	push   %eax
    1aa8:	ff 75 08             	pushl  0x8(%ebp)
    1aab:	e8 06 fe ff ff       	call   18b6 <putc>
    1ab0:	83 c4 10             	add    $0x10,%esp
        ap++;
    1ab3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1ab7:	eb 42                	jmp    1afb <printf+0x170>
      } else if(c == '%'){
    1ab9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1abd:	75 17                	jne    1ad6 <printf+0x14b>
        putc(fd, c);
    1abf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ac2:	0f be c0             	movsbl %al,%eax
    1ac5:	83 ec 08             	sub    $0x8,%esp
    1ac8:	50                   	push   %eax
    1ac9:	ff 75 08             	pushl  0x8(%ebp)
    1acc:	e8 e5 fd ff ff       	call   18b6 <putc>
    1ad1:	83 c4 10             	add    $0x10,%esp
    1ad4:	eb 25                	jmp    1afb <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1ad6:	83 ec 08             	sub    $0x8,%esp
    1ad9:	6a 25                	push   $0x25
    1adb:	ff 75 08             	pushl  0x8(%ebp)
    1ade:	e8 d3 fd ff ff       	call   18b6 <putc>
    1ae3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1ae6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1ae9:	0f be c0             	movsbl %al,%eax
    1aec:	83 ec 08             	sub    $0x8,%esp
    1aef:	50                   	push   %eax
    1af0:	ff 75 08             	pushl  0x8(%ebp)
    1af3:	e8 be fd ff ff       	call   18b6 <putc>
    1af8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1afb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1b02:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1b06:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b09:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b0c:	01 d0                	add    %edx,%eax
    1b0e:	0f b6 00             	movzbl (%eax),%eax
    1b11:	84 c0                	test   %al,%al
    1b13:	0f 85 94 fe ff ff    	jne    19ad <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1b19:	c9                   	leave  
    1b1a:	c3                   	ret    

00001b1b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b1b:	55                   	push   %ebp
    1b1c:	89 e5                	mov    %esp,%ebp
    1b1e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b21:	8b 45 08             	mov    0x8(%ebp),%eax
    1b24:	83 e8 08             	sub    $0x8,%eax
    1b27:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b2a:	a1 6c 26 00 00       	mov    0x266c,%eax
    1b2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b32:	eb 24                	jmp    1b58 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b34:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b37:	8b 00                	mov    (%eax),%eax
    1b39:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1b3c:	77 12                	ja     1b50 <free+0x35>
    1b3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b41:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1b44:	77 24                	ja     1b6a <free+0x4f>
    1b46:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b49:	8b 00                	mov    (%eax),%eax
    1b4b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b4e:	77 1a                	ja     1b6a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b50:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b53:	8b 00                	mov    (%eax),%eax
    1b55:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b58:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b5b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1b5e:	76 d4                	jbe    1b34 <free+0x19>
    1b60:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b63:	8b 00                	mov    (%eax),%eax
    1b65:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b68:	76 ca                	jbe    1b34 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b6d:	8b 40 04             	mov    0x4(%eax),%eax
    1b70:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1b77:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b7a:	01 c2                	add    %eax,%edx
    1b7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b7f:	8b 00                	mov    (%eax),%eax
    1b81:	39 c2                	cmp    %eax,%edx
    1b83:	75 24                	jne    1ba9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1b85:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b88:	8b 50 04             	mov    0x4(%eax),%edx
    1b8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b8e:	8b 00                	mov    (%eax),%eax
    1b90:	8b 40 04             	mov    0x4(%eax),%eax
    1b93:	01 c2                	add    %eax,%edx
    1b95:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b98:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b9e:	8b 00                	mov    (%eax),%eax
    1ba0:	8b 10                	mov    (%eax),%edx
    1ba2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ba5:	89 10                	mov    %edx,(%eax)
    1ba7:	eb 0a                	jmp    1bb3 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1ba9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bac:	8b 10                	mov    (%eax),%edx
    1bae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bb1:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1bb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bb6:	8b 40 04             	mov    0x4(%eax),%eax
    1bb9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1bc0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bc3:	01 d0                	add    %edx,%eax
    1bc5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1bc8:	75 20                	jne    1bea <free+0xcf>
    p->s.size += bp->s.size;
    1bca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bcd:	8b 50 04             	mov    0x4(%eax),%edx
    1bd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bd3:	8b 40 04             	mov    0x4(%eax),%eax
    1bd6:	01 c2                	add    %eax,%edx
    1bd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bdb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1bde:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1be1:	8b 10                	mov    (%eax),%edx
    1be3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1be6:	89 10                	mov    %edx,(%eax)
    1be8:	eb 08                	jmp    1bf2 <free+0xd7>
  } else
    p->s.ptr = bp;
    1bea:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bed:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1bf0:	89 10                	mov    %edx,(%eax)
  freep = p;
    1bf2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bf5:	a3 6c 26 00 00       	mov    %eax,0x266c
}
    1bfa:	c9                   	leave  
    1bfb:	c3                   	ret    

00001bfc <morecore>:

static Header*
morecore(uint nu)
{
    1bfc:	55                   	push   %ebp
    1bfd:	89 e5                	mov    %esp,%ebp
    1bff:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1c02:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1c09:	77 07                	ja     1c12 <morecore+0x16>
    nu = 4096;
    1c0b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1c12:	8b 45 08             	mov    0x8(%ebp),%eax
    1c15:	c1 e0 03             	shl    $0x3,%eax
    1c18:	83 ec 0c             	sub    $0xc,%esp
    1c1b:	50                   	push   %eax
    1c1c:	e8 75 fc ff ff       	call   1896 <sbrk>
    1c21:	83 c4 10             	add    $0x10,%esp
    1c24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1c27:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1c2b:	75 07                	jne    1c34 <morecore+0x38>
    return 0;
    1c2d:	b8 00 00 00 00       	mov    $0x0,%eax
    1c32:	eb 26                	jmp    1c5a <morecore+0x5e>
  hp = (Header*)p;
    1c34:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1c3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c3d:	8b 55 08             	mov    0x8(%ebp),%edx
    1c40:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1c43:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c46:	83 c0 08             	add    $0x8,%eax
    1c49:	83 ec 0c             	sub    $0xc,%esp
    1c4c:	50                   	push   %eax
    1c4d:	e8 c9 fe ff ff       	call   1b1b <free>
    1c52:	83 c4 10             	add    $0x10,%esp
  return freep;
    1c55:	a1 6c 26 00 00       	mov    0x266c,%eax
}
    1c5a:	c9                   	leave  
    1c5b:	c3                   	ret    

00001c5c <malloc>:

void*
malloc(uint nbytes)
{
    1c5c:	55                   	push   %ebp
    1c5d:	89 e5                	mov    %esp,%ebp
    1c5f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c62:	8b 45 08             	mov    0x8(%ebp),%eax
    1c65:	83 c0 07             	add    $0x7,%eax
    1c68:	c1 e8 03             	shr    $0x3,%eax
    1c6b:	83 c0 01             	add    $0x1,%eax
    1c6e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1c71:	a1 6c 26 00 00       	mov    0x266c,%eax
    1c76:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c79:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c7d:	75 23                	jne    1ca2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1c7f:	c7 45 f0 64 26 00 00 	movl   $0x2664,-0x10(%ebp)
    1c86:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c89:	a3 6c 26 00 00       	mov    %eax,0x266c
    1c8e:	a1 6c 26 00 00       	mov    0x266c,%eax
    1c93:	a3 64 26 00 00       	mov    %eax,0x2664
    base.s.size = 0;
    1c98:	c7 05 68 26 00 00 00 	movl   $0x0,0x2668
    1c9f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ca5:	8b 00                	mov    (%eax),%eax
    1ca7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1caa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cad:	8b 40 04             	mov    0x4(%eax),%eax
    1cb0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1cb3:	72 4d                	jb     1d02 <malloc+0xa6>
      if(p->s.size == nunits)
    1cb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb8:	8b 40 04             	mov    0x4(%eax),%eax
    1cbb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1cbe:	75 0c                	jne    1ccc <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1cc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cc3:	8b 10                	mov    (%eax),%edx
    1cc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cc8:	89 10                	mov    %edx,(%eax)
    1cca:	eb 26                	jmp    1cf2 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1ccc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ccf:	8b 40 04             	mov    0x4(%eax),%eax
    1cd2:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1cd5:	89 c2                	mov    %eax,%edx
    1cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cda:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ce0:	8b 40 04             	mov    0x4(%eax),%eax
    1ce3:	c1 e0 03             	shl    $0x3,%eax
    1ce6:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1ce9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cec:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1cef:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1cf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cf5:	a3 6c 26 00 00       	mov    %eax,0x266c
      return (void*)(p + 1);
    1cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cfd:	83 c0 08             	add    $0x8,%eax
    1d00:	eb 3b                	jmp    1d3d <malloc+0xe1>
    }
    if(p == freep)
    1d02:	a1 6c 26 00 00       	mov    0x266c,%eax
    1d07:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1d0a:	75 1e                	jne    1d2a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1d0c:	83 ec 0c             	sub    $0xc,%esp
    1d0f:	ff 75 ec             	pushl  -0x14(%ebp)
    1d12:	e8 e5 fe ff ff       	call   1bfc <morecore>
    1d17:	83 c4 10             	add    $0x10,%esp
    1d1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1d1d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d21:	75 07                	jne    1d2a <malloc+0xce>
        return 0;
    1d23:	b8 00 00 00 00       	mov    $0x0,%eax
    1d28:	eb 13                	jmp    1d3d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d30:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d33:	8b 00                	mov    (%eax),%eax
    1d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1d38:	e9 6d ff ff ff       	jmp    1caa <malloc+0x4e>
}
    1d3d:	c9                   	leave  
    1d3e:	c3                   	ret    
