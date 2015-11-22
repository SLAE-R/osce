
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
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
      11:	e8 a0 11 00 00       	call   11b6 <exit>
  
  switch(cmd->type){
      16:	8b 45 08             	mov    0x8(%ebp),%eax
      19:	8b 00                	mov    (%eax),%eax
      1b:	83 f8 05             	cmp    $0x5,%eax
      1e:	77 09                	ja     29 <runcmd+0x29>
      20:	8b 04 85 14 17 00 00 	mov    0x1714(,%eax,4),%eax
      27:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      29:	83 ec 0c             	sub    $0xc,%esp
      2c:	68 e8 16 00 00       	push   $0x16e8
      31:	e8 4a 06 00 00       	call   680 <panic>
      36:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      39:	8b 45 08             	mov    0x8(%ebp),%eax
      3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      42:	8b 40 04             	mov    0x4(%eax),%eax
      45:	85 c0                	test   %eax,%eax
      47:	75 0a                	jne    53 <runcmd+0x53>
      exit(EXIT_STATUS_OK);
      49:	83 ec 0c             	sub    $0xc,%esp
      4c:	6a 01                	push   $0x1
      4e:	e8 63 11 00 00       	call   11b6 <exit>
	char pidBuff[sizeof(int)];
	int pid = getpid();
      53:	e8 de 11 00 00       	call   1236 <getpid>
      58:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	strcpy(pidBuff, (char *) &pid);
      5b:	83 ec 08             	sub    $0x8,%esp
      5e:	8d 45 d4             	lea    -0x2c(%ebp),%eax
      61:	50                   	push   %eax
      62:	8d 45 d8             	lea    -0x28(%ebp),%eax
      65:	50                   	push   %eax
      66:	e8 1b 0f 00 00       	call   f86 <strcpy>
      6b:	83 c4 10             	add    $0x10,%esp
	write(3 ,pidBuff, sizeof(int));
      6e:	83 ec 04             	sub    $0x4,%esp
      71:	6a 04                	push   $0x4
      73:	8d 45 d8             	lea    -0x28(%ebp),%eax
      76:	50                   	push   %eax
      77:	6a 03                	push   $0x3
      79:	e8 58 11 00 00       	call   11d6 <write>
      7e:	83 c4 10             	add    $0x10,%esp
    exec(ecmd->argv[0], ecmd->argv);
      81:	8b 45 f4             	mov    -0xc(%ebp),%eax
      84:	8d 50 04             	lea    0x4(%eax),%edx
      87:	8b 45 f4             	mov    -0xc(%ebp),%eax
      8a:	8b 40 04             	mov    0x4(%eax),%eax
      8d:	83 ec 08             	sub    $0x8,%esp
      90:	52                   	push   %edx
      91:	50                   	push   %eax
      92:	e8 57 11 00 00       	call   11ee <exec>
      97:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      9d:	8b 40 04             	mov    0x4(%eax),%eax
      a0:	83 ec 04             	sub    $0x4,%esp
      a3:	50                   	push   %eax
      a4:	68 ef 16 00 00       	push   $0x16ef
      a9:	6a 02                	push   $0x2
      ab:	e8 83 12 00 00       	call   1333 <printf>
      b0:	83 c4 10             	add    $0x10,%esp
    break;
      b3:	e9 13 02 00 00       	jmp    2cb <runcmd+0x2cb>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      b8:	8b 45 08             	mov    0x8(%ebp),%eax
      bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      be:	8b 45 f0             	mov    -0x10(%ebp),%eax
      c1:	8b 40 14             	mov    0x14(%eax),%eax
      c4:	83 ec 0c             	sub    $0xc,%esp
      c7:	50                   	push   %eax
      c8:	e8 11 11 00 00       	call   11de <close>
      cd:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d3:	8b 50 10             	mov    0x10(%eax),%edx
      d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d9:	8b 40 08             	mov    0x8(%eax),%eax
      dc:	83 ec 08             	sub    $0x8,%esp
      df:	52                   	push   %edx
      e0:	50                   	push   %eax
      e1:	e8 10 11 00 00       	call   11f6 <open>
      e6:	83 c4 10             	add    $0x10,%esp
      e9:	85 c0                	test   %eax,%eax
      eb:	79 23                	jns    110 <runcmd+0x110>
      printf(2, "open %s failed\n", rcmd->file);
      ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
      f0:	8b 40 08             	mov    0x8(%eax),%eax
      f3:	83 ec 04             	sub    $0x4,%esp
      f6:	50                   	push   %eax
      f7:	68 ff 16 00 00       	push   $0x16ff
      fc:	6a 02                	push   $0x2
      fe:	e8 30 12 00 00       	call   1333 <printf>
     103:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     106:	83 ec 0c             	sub    $0xc,%esp
     109:	6a 01                	push   $0x1
     10b:	e8 a6 10 00 00       	call   11b6 <exit>
    }
    runcmd(rcmd->cmd);
     110:	8b 45 f0             	mov    -0x10(%ebp),%eax
     113:	8b 40 04             	mov    0x4(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 a4 01 00 00       	jmp    2cb <runcmd+0x2cb>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
     12d:	e8 73 05 00 00       	call   6a5 <fork1>
     132:	85 c0                	test   %eax,%eax
     134:	75 12                	jne    148 <runcmd+0x148>
      runcmd(lcmd->left);
     136:	8b 45 ec             	mov    -0x14(%ebp),%eax
     139:	8b 40 04             	mov    0x4(%eax),%eax
     13c:	83 ec 0c             	sub    $0xc,%esp
     13f:	50                   	push   %eax
     140:	e8 bb fe ff ff       	call   0 <runcmd>
     145:	83 c4 10             	add    $0x10,%esp
    wait(0);
     148:	83 ec 0c             	sub    $0xc,%esp
     14b:	6a 00                	push   $0x0
     14d:	e8 6c 10 00 00       	call   11be <wait>
     152:	83 c4 10             	add    $0x10,%esp
    runcmd(lcmd->right);
     155:	8b 45 ec             	mov    -0x14(%ebp),%eax
     158:	8b 40 08             	mov    0x8(%eax),%eax
     15b:	83 ec 0c             	sub    $0xc,%esp
     15e:	50                   	push   %eax
     15f:	e8 9c fe ff ff       	call   0 <runcmd>
     164:	83 c4 10             	add    $0x10,%esp
    break;
     167:	e9 5f 01 00 00       	jmp    2cb <runcmd+0x2cb>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     16c:	8b 45 08             	mov    0x8(%ebp),%eax
     16f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     172:	83 ec 0c             	sub    $0xc,%esp
     175:	8d 45 dc             	lea    -0x24(%ebp),%eax
     178:	50                   	push   %eax
     179:	e8 48 10 00 00       	call   11c6 <pipe>
     17e:	83 c4 10             	add    $0x10,%esp
     181:	85 c0                	test   %eax,%eax
     183:	79 10                	jns    195 <runcmd+0x195>
      panic("pipe");
     185:	83 ec 0c             	sub    $0xc,%esp
     188:	68 0f 17 00 00       	push   $0x170f
     18d:	e8 ee 04 00 00       	call   680 <panic>
     192:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     195:	e8 0b 05 00 00       	call   6a5 <fork1>
     19a:	85 c0                	test   %eax,%eax
     19c:	75 4c                	jne    1ea <runcmd+0x1ea>
      close(1);
     19e:	83 ec 0c             	sub    $0xc,%esp
     1a1:	6a 01                	push   $0x1
     1a3:	e8 36 10 00 00       	call   11de <close>
     1a8:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     1ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	50                   	push   %eax
     1b2:	e8 77 10 00 00       	call   122e <dup>
     1b7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1bd:	83 ec 0c             	sub    $0xc,%esp
     1c0:	50                   	push   %eax
     1c1:	e8 18 10 00 00       	call   11de <close>
     1c6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1cc:	83 ec 0c             	sub    $0xc,%esp
     1cf:	50                   	push   %eax
     1d0:	e8 09 10 00 00       	call   11de <close>
     1d5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     1d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1db:	8b 40 04             	mov    0x4(%eax),%eax
     1de:	83 ec 0c             	sub    $0xc,%esp
     1e1:	50                   	push   %eax
     1e2:	e8 19 fe ff ff       	call   0 <runcmd>
     1e7:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1ea:	e8 b6 04 00 00       	call   6a5 <fork1>
     1ef:	85 c0                	test   %eax,%eax
     1f1:	75 4c                	jne    23f <runcmd+0x23f>
      close(0);
     1f3:	83 ec 0c             	sub    $0xc,%esp
     1f6:	6a 00                	push   $0x0
     1f8:	e8 e1 0f 00 00       	call   11de <close>
     1fd:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     200:	8b 45 dc             	mov    -0x24(%ebp),%eax
     203:	83 ec 0c             	sub    $0xc,%esp
     206:	50                   	push   %eax
     207:	e8 22 10 00 00       	call   122e <dup>
     20c:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     20f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     212:	83 ec 0c             	sub    $0xc,%esp
     215:	50                   	push   %eax
     216:	e8 c3 0f 00 00       	call   11de <close>
     21b:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     21e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     221:	83 ec 0c             	sub    $0xc,%esp
     224:	50                   	push   %eax
     225:	e8 b4 0f 00 00       	call   11de <close>
     22a:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     22d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     230:	8b 40 08             	mov    0x8(%eax),%eax
     233:	83 ec 0c             	sub    $0xc,%esp
     236:	50                   	push   %eax
     237:	e8 c4 fd ff ff       	call   0 <runcmd>
     23c:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     23f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     242:	83 ec 0c             	sub    $0xc,%esp
     245:	50                   	push   %eax
     246:	e8 93 0f 00 00       	call   11de <close>
     24b:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     24e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     251:	83 ec 0c             	sub    $0xc,%esp
     254:	50                   	push   %eax
     255:	e8 84 0f 00 00       	call   11de <close>
     25a:	83 c4 10             	add    $0x10,%esp
    wait(0);
     25d:	83 ec 0c             	sub    $0xc,%esp
     260:	6a 00                	push   $0x0
     262:	e8 57 0f 00 00       	call   11be <wait>
     267:	83 c4 10             	add    $0x10,%esp
    wait(0);
     26a:	83 ec 0c             	sub    $0xc,%esp
     26d:	6a 00                	push   $0x0
     26f:	e8 4a 0f 00 00       	call   11be <wait>
     274:	83 c4 10             	add    $0x10,%esp
    break;
     277:	eb 52                	jmp    2cb <runcmd+0x2cb>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     279:	8b 45 08             	mov    0x8(%ebp),%eax
     27c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0){
     27f:	e8 21 04 00 00       	call   6a5 <fork1>
     284:	85 c0                	test   %eax,%eax
     286:	75 42                	jne    2ca <runcmd+0x2ca>
    	char pidBuff[sizeof(int)];
    	int pid = getpid();
     288:	e8 a9 0f 00 00       	call   1236 <getpid>
     28d:	89 45 cc             	mov    %eax,-0x34(%ebp)
    	strcpy(pidBuff, (char *) &pid);
     290:	83 ec 08             	sub    $0x8,%esp
     293:	8d 45 cc             	lea    -0x34(%ebp),%eax
     296:	50                   	push   %eax
     297:	8d 45 d0             	lea    -0x30(%ebp),%eax
     29a:	50                   	push   %eax
     29b:	e8 e6 0c 00 00       	call   f86 <strcpy>
     2a0:	83 c4 10             	add    $0x10,%esp
    	write(3 ,pidBuff, sizeof(int));
     2a3:	83 ec 04             	sub    $0x4,%esp
     2a6:	6a 04                	push   $0x4
     2a8:	8d 45 d0             	lea    -0x30(%ebp),%eax
     2ab:	50                   	push   %eax
     2ac:	6a 03                	push   $0x3
     2ae:	e8 23 0f 00 00       	call   11d6 <write>
     2b3:	83 c4 10             	add    $0x10,%esp
    	runcmd(bcmd->cmd);
     2b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     2b9:	8b 40 04             	mov    0x4(%eax),%eax
     2bc:	83 ec 0c             	sub    $0xc,%esp
     2bf:	50                   	push   %eax
     2c0:	e8 3b fd ff ff       	call   0 <runcmd>
     2c5:	83 c4 10             	add    $0x10,%esp
    }
    break;
     2c8:	eb 00                	jmp    2ca <runcmd+0x2ca>
     2ca:	90                   	nop
  }
  exit(EXIT_STATUS_OK);
     2cb:	83 ec 0c             	sub    $0xc,%esp
     2ce:	6a 01                	push   $0x1
     2d0:	e8 e1 0e 00 00       	call   11b6 <exit>

000002d5 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     2d5:	55                   	push   %ebp
     2d6:	89 e5                	mov    %esp,%ebp
     2d8:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     2db:	83 ec 08             	sub    $0x8,%esp
     2de:	68 2c 17 00 00       	push   $0x172c
     2e3:	6a 02                	push   $0x2
     2e5:	e8 49 10 00 00       	call   1333 <printf>
     2ea:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     2ed:	8b 45 0c             	mov    0xc(%ebp),%eax
     2f0:	83 ec 04             	sub    $0x4,%esp
     2f3:	50                   	push   %eax
     2f4:	6a 00                	push   $0x0
     2f6:	ff 75 08             	pushl  0x8(%ebp)
     2f9:	e8 1e 0d 00 00       	call   101c <memset>
     2fe:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     301:	83 ec 08             	sub    $0x8,%esp
     304:	ff 75 0c             	pushl  0xc(%ebp)
     307:	ff 75 08             	pushl  0x8(%ebp)
     30a:	e8 5a 0d 00 00       	call   1069 <gets>
     30f:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     312:	8b 45 08             	mov    0x8(%ebp),%eax
     315:	0f b6 00             	movzbl (%eax),%eax
     318:	84 c0                	test   %al,%al
     31a:	75 07                	jne    323 <getcmd+0x4e>
    return -1;
     31c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     321:	eb 05                	jmp    328 <getcmd+0x53>
  return 0;
     323:	b8 00 00 00 00       	mov    $0x0,%eax
}
     328:	c9                   	leave  
     329:	c3                   	ret    

0000032a <main>:

int
main(void)
{
     32a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     32e:	83 e4 f0             	and    $0xfffffff0,%esp
     331:	ff 71 fc             	pushl  -0x4(%ecx)
     334:	55                   	push   %ebp
     335:	89 e5                	mov    %esp,%ebp
     337:	51                   	push   %ecx
     338:	81 ec 44 04 00 00    	sub    $0x444,%esp
  static char buf[100];
  int fd;
  struct job *foregroungJob = 0;
     33e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  struct job *lastBackgroundJob = 0;
     345:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  struct job *backgroundJobsHead = 0;
     34c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int jobCount = 0;
     353:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     35a:	eb 16                	jmp    372 <main+0x48>
    if(fd >= 3){
     35c:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
     360:	7e 10                	jle    372 <main+0x48>
      close(fd);
     362:	83 ec 0c             	sub    $0xc,%esp
     365:	ff 75 e4             	pushl  -0x1c(%ebp)
     368:	e8 71 0e 00 00       	call   11de <close>
     36d:	83 c4 10             	add    $0x10,%esp
      break;
     370:	eb 1b                	jmp    38d <main+0x63>
  struct job *lastBackgroundJob = 0;
  struct job *backgroundJobsHead = 0;
  int jobCount = 0;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     372:	83 ec 08             	sub    $0x8,%esp
     375:	6a 02                	push   $0x2
     377:	68 2f 17 00 00       	push   $0x172f
     37c:	e8 75 0e 00 00       	call   11f6 <open>
     381:	83 c4 10             	add    $0x10,%esp
     384:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     387:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     38b:	79 cf                	jns    35c <main+0x32>
  }



  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     38d:	e9 81 02 00 00       	jmp    613 <main+0x2e9>

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     392:	0f b6 05 40 1d 00 00 	movzbl 0x1d40,%eax
     399:	3c 63                	cmp    $0x63,%al
     39b:	75 64                	jne    401 <main+0xd7>
     39d:	0f b6 05 41 1d 00 00 	movzbl 0x1d41,%eax
     3a4:	3c 64                	cmp    $0x64,%al
     3a6:	75 59                	jne    401 <main+0xd7>
     3a8:	0f b6 05 42 1d 00 00 	movzbl 0x1d42,%eax
     3af:	3c 20                	cmp    $0x20,%al
     3b1:	75 4e                	jne    401 <main+0xd7>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     3b3:	83 ec 0c             	sub    $0xc,%esp
     3b6:	68 40 1d 00 00       	push   $0x1d40
     3bb:	e8 35 0c 00 00       	call   ff5 <strlen>
     3c0:	83 c4 10             	add    $0x10,%esp
     3c3:	83 e8 01             	sub    $0x1,%eax
     3c6:	c6 80 40 1d 00 00 00 	movb   $0x0,0x1d40(%eax)
      if(chdir(buf+3) < 0)
     3cd:	83 ec 0c             	sub    $0xc,%esp
     3d0:	68 43 1d 00 00       	push   $0x1d43
     3d5:	e8 4c 0e 00 00       	call   1226 <chdir>
     3da:	83 c4 10             	add    $0x10,%esp
     3dd:	85 c0                	test   %eax,%eax
     3df:	0f 89 2e 02 00 00    	jns    613 <main+0x2e9>
        printf(2, "cannot cd %s\n", buf+3);
     3e5:	83 ec 04             	sub    $0x4,%esp
     3e8:	68 43 1d 00 00       	push   $0x1d43
     3ed:	68 37 17 00 00       	push   $0x1737
     3f2:	6a 02                	push   $0x2
     3f4:	e8 3a 0f 00 00       	call   1333 <printf>
     3f9:	83 c4 10             	add    $0x10,%esp
     3fc:	e9 12 02 00 00       	jmp    613 <main+0x2e9>
      continue;
    }

    int jobOutput[2],jobInput[2];
    if(pipe(jobOutput) < 0)
     401:	83 ec 0c             	sub    $0xc,%esp
     404:	8d 45 d0             	lea    -0x30(%ebp),%eax
     407:	50                   	push   %eax
     408:	e8 b9 0d 00 00       	call   11c6 <pipe>
     40d:	83 c4 10             	add    $0x10,%esp
     410:	85 c0                	test   %eax,%eax
     412:	79 10                	jns    424 <main+0xfa>
      panic("jobOutput error");
     414:	83 ec 0c             	sub    $0xc,%esp
     417:	68 45 17 00 00       	push   $0x1745
     41c:	e8 5f 02 00 00       	call   680 <panic>
     421:	83 c4 10             	add    $0x10,%esp
    if(pipe(jobInput) < 0)
     424:	83 ec 0c             	sub    $0xc,%esp
     427:	8d 45 c8             	lea    -0x38(%ebp),%eax
     42a:	50                   	push   %eax
     42b:	e8 96 0d 00 00       	call   11c6 <pipe>
     430:	83 c4 10             	add    $0x10,%esp
     433:	85 c0                	test   %eax,%eax
     435:	79 10                	jns    447 <main+0x11d>
      panic("jobInput error");
     437:	83 ec 0c             	sub    $0xc,%esp
     43a:	68 55 17 00 00       	push   $0x1755
     43f:	e8 3c 02 00 00       	call   680 <panic>
     444:	83 c4 10             	add    $0x10,%esp


    jobCount++;
     447:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    struct job *newJob = getJob(jobCount);
     44b:	83 ec 0c             	sub    $0xc,%esp
     44e:	ff 75 e8             	pushl  -0x18(%ebp)
     451:	e8 e1 01 00 00       	call   637 <getJob>
     456:	83 c4 10             	add    $0x10,%esp
     459:	89 45 e0             	mov    %eax,-0x20(%ebp)
    struct cmd *newcmd = parsecmd(buf);
     45c:	83 ec 0c             	sub    $0xc,%esp
     45f:	68 40 1d 00 00       	push   $0x1d40
     464:	e8 90 05 00 00       	call   9f9 <parsecmd>
     469:	83 c4 10             	add    $0x10,%esp
     46c:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(newcmd->type != BACK && foregroungJob != 0){
     46f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     472:	8b 00                	mov    (%eax),%eax
     474:	83 f8 05             	cmp    $0x5,%eax
     477:	74 26                	je     49f <main+0x175>
     479:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     47d:	74 20                	je     49f <main+0x175>
		foregroungJob = newJob;
     47f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     482:	89 45 f4             	mov    %eax,-0xc(%ebp)
		printf(1, "Foreground job set. JobId = %d\n", foregroungJob->id);
     485:	8b 45 f4             	mov    -0xc(%ebp),%eax
     488:	8b 00                	mov    (%eax),%eax
     48a:	83 ec 04             	sub    $0x4,%esp
     48d:	50                   	push   %eax
     48e:	68 64 17 00 00       	push   $0x1764
     493:	6a 01                	push   $0x1
     495:	e8 99 0e 00 00       	call   1333 <printf>
     49a:	83 c4 10             	add    $0x10,%esp
     49d:	eb 23                	jmp    4c2 <main+0x198>

	}
	else {
		if(backgroundJobsHead == 0){
     49f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4a3:	75 0e                	jne    4b3 <main+0x189>
			backgroundJobsHead = newJob;
     4a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     4a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
			lastBackgroundJob = newJob;
     4ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
     4ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
     4b1:	eb 0f                	jmp    4c2 <main+0x198>
		}
		else {
			lastBackgroundJob->nextjob = newJob;
     4b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
     4b9:	89 50 04             	mov    %edx,0x4(%eax)
			lastBackgroundJob = newJob;
     4bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     4bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
		}
	}

	if(fork1() == 0){
     4c2:	e8 de 01 00 00       	call   6a5 <fork1>
     4c7:	85 c0                	test   %eax,%eax
     4c9:	75 75                	jne    540 <main+0x216>

      //close(1);
	  dup(jobOutput[0]);
     4cb:	8b 45 d0             	mov    -0x30(%ebp),%eax
     4ce:	83 ec 0c             	sub    $0xc,%esp
     4d1:	50                   	push   %eax
     4d2:	e8 57 0d 00 00       	call   122e <dup>
     4d7:	83 c4 10             	add    $0x10,%esp
	  close(jobOutput[0]);
     4da:	8b 45 d0             	mov    -0x30(%ebp),%eax
     4dd:	83 ec 0c             	sub    $0xc,%esp
     4e0:	50                   	push   %eax
     4e1:	e8 f8 0c 00 00       	call   11de <close>
     4e6:	83 c4 10             	add    $0x10,%esp
	  close(jobOutput[1]);
     4e9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     4ec:	83 ec 0c             	sub    $0xc,%esp
     4ef:	50                   	push   %eax
     4f0:	e8 e9 0c 00 00       	call   11de <close>
     4f5:	83 c4 10             	add    $0x10,%esp

	  close(0);
     4f8:	83 ec 0c             	sub    $0xc,%esp
     4fb:	6a 00                	push   $0x0
     4fd:	e8 dc 0c 00 00       	call   11de <close>
     502:	83 c4 10             	add    $0x10,%esp
	  dup(jobInput[1]);
     505:	8b 45 cc             	mov    -0x34(%ebp),%eax
     508:	83 ec 0c             	sub    $0xc,%esp
     50b:	50                   	push   %eax
     50c:	e8 1d 0d 00 00       	call   122e <dup>
     511:	83 c4 10             	add    $0x10,%esp
	  close(jobInput[0]);
     514:	8b 45 c8             	mov    -0x38(%ebp),%eax
     517:	83 ec 0c             	sub    $0xc,%esp
     51a:	50                   	push   %eax
     51b:	e8 be 0c 00 00       	call   11de <close>
     520:	83 c4 10             	add    $0x10,%esp
	  close(jobInput[1]);
     523:	8b 45 cc             	mov    -0x34(%ebp),%eax
     526:	83 ec 0c             	sub    $0xc,%esp
     529:	50                   	push   %eax
     52a:	e8 af 0c 00 00       	call   11de <close>
     52f:	83 c4 10             	add    $0x10,%esp

      runcmd(newcmd);
     532:	83 ec 0c             	sub    $0xc,%esp
     535:	ff 75 dc             	pushl  -0x24(%ebp)
     538:	e8 c3 fa ff ff       	call   0 <runcmd>
     53d:	83 c4 10             	add    $0x10,%esp
    }

	if (fork1() == 0){ // input redirecting
     540:	e8 60 01 00 00       	call   6a5 <fork1>
     545:	85 c0                	test   %eax,%eax
     547:	0f 85 83 00 00 00    	jne    5d0 <main+0x2a6>
		char *newbuf[256];
		while(gets(buf, sizeof(buf)) >= 0 && foregroungJob == newJob){
     54d:	eb 44                	jmp    593 <main+0x269>
			printf(1, "Received INPUT = %s" , buf);
     54f:	83 ec 04             	sub    $0x4,%esp
     552:	68 40 1d 00 00       	push   $0x1d40
     557:	68 84 17 00 00       	push   $0x1784
     55c:	6a 01                	push   $0x1
     55e:	e8 d0 0d 00 00       	call   1333 <printf>
     563:	83 c4 10             	add    $0x10,%esp
			write(jobInput[0] , newbuf, sizeof(newbuf));
     566:	8b 45 c8             	mov    -0x38(%ebp),%eax
     569:	83 ec 04             	sub    $0x4,%esp
     56c:	68 00 04 00 00       	push   $0x400
     571:	8d 95 b8 fb ff ff    	lea    -0x448(%ebp),%edx
     577:	52                   	push   %edx
     578:	50                   	push   %eax
     579:	e8 58 0c 00 00       	call   11d6 <write>
     57e:	83 c4 10             	add    $0x10,%esp
			printf(2, "$ ");
     581:	83 ec 08             	sub    $0x8,%esp
     584:	68 2c 17 00 00       	push   $0x172c
     589:	6a 02                	push   $0x2
     58b:	e8 a3 0d 00 00       	call   1333 <printf>
     590:	83 c4 10             	add    $0x10,%esp
      runcmd(newcmd);
    }

	if (fork1() == 0){ // input redirecting
		char *newbuf[256];
		while(gets(buf, sizeof(buf)) >= 0 && foregroungJob == newJob){
     593:	83 ec 08             	sub    $0x8,%esp
     596:	6a 64                	push   $0x64
     598:	68 40 1d 00 00       	push   $0x1d40
     59d:	e8 c7 0a 00 00       	call   1069 <gets>
     5a2:	83 c4 10             	add    $0x10,%esp
     5a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a8:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     5ab:	74 a2                	je     54f <main+0x225>
			printf(1, "Received INPUT = %s" , buf);
			write(jobInput[0] , newbuf, sizeof(newbuf));
			printf(2, "$ ");
		 }
		printf(1, "redirecting exit\n");
     5ad:	83 ec 08             	sub    $0x8,%esp
     5b0:	68 98 17 00 00       	push   $0x1798
     5b5:	6a 01                	push   $0x1
     5b7:	e8 77 0d 00 00       	call   1333 <printf>
     5bc:	83 c4 10             	add    $0x10,%esp
		foregroungJob = 0;
     5bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		exit(0);
     5c6:	83 ec 0c             	sub    $0xc,%esp
     5c9:	6a 00                	push   $0x0
     5cb:	e8 e6 0b 00 00       	call   11b6 <exit>
	}


	char *pidBuf[4];
	while (read(jobOutput[1] , pidBuf , sizeof(pidBuf)) > 0 ){
     5d0:	eb 1b                	jmp    5ed <main+0x2c3>
		int recievedPid = (int)*pidBuf;
     5d2:	8b 45 b8             	mov    -0x48(%ebp),%eax
     5d5:	89 45 d8             	mov    %eax,-0x28(%ebp)
		printf(1, "Received pid = %d\n" , recievedPid );
     5d8:	83 ec 04             	sub    $0x4,%esp
     5db:	ff 75 d8             	pushl  -0x28(%ebp)
     5de:	68 aa 17 00 00       	push   $0x17aa
     5e3:	6a 01                	push   $0x1
     5e5:	e8 49 0d 00 00       	call   1333 <printf>
     5ea:	83 c4 10             	add    $0x10,%esp
		exit(0);
	}


	char *pidBuf[4];
	while (read(jobOutput[1] , pidBuf , sizeof(pidBuf)) > 0 ){
     5ed:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     5f0:	83 ec 04             	sub    $0x4,%esp
     5f3:	6a 10                	push   $0x10
     5f5:	8d 55 b8             	lea    -0x48(%ebp),%edx
     5f8:	52                   	push   %edx
     5f9:	50                   	push   %eax
     5fa:	e8 cf 0b 00 00       	call   11ce <read>
     5ff:	83 c4 10             	add    $0x10,%esp
     602:	85 c0                	test   %eax,%eax
     604:	7f cc                	jg     5d2 <main+0x2a8>
		int recievedPid = (int)*pidBuf;
		printf(1, "Received pid = %d\n" , recievedPid );
	}
    wait(0);
     606:	83 ec 0c             	sub    $0xc,%esp
     609:	6a 00                	push   $0x0
     60b:	e8 ae 0b 00 00       	call   11be <wait>
     610:	83 c4 10             	add    $0x10,%esp
  }



  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     613:	83 ec 08             	sub    $0x8,%esp
     616:	6a 64                	push   $0x64
     618:	68 40 1d 00 00       	push   $0x1d40
     61d:	e8 b3 fc ff ff       	call   2d5 <getcmd>
     622:	83 c4 10             	add    $0x10,%esp
     625:	85 c0                	test   %eax,%eax
     627:	0f 89 65 fd ff ff    	jns    392 <main+0x68>
		int recievedPid = (int)*pidBuf;
		printf(1, "Received pid = %d\n" , recievedPid );
	}
    wait(0);
  }
  exit(EXIT_STATUS_OK);
     62d:	83 ec 0c             	sub    $0xc,%esp
     630:	6a 01                	push   $0x1
     632:	e8 7f 0b 00 00       	call   11b6 <exit>

00000637 <getJob>:
}

struct job *getJob(int jobId){
     637:	55                   	push   %ebp
     638:	89 e5                	mov    %esp,%ebp
     63a:	83 ec 18             	sub    $0x18,%esp
	  struct job *newJob;

	  newJob = malloc(sizeof(*newJob));
     63d:	83 ec 0c             	sub    $0xc,%esp
     640:	6a 0c                	push   $0xc
     642:	e8 bd 0f 00 00       	call   1604 <malloc>
     647:	83 c4 10             	add    $0x10,%esp
     64a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	  memset(newJob, 0, sizeof(*newJob));
     64d:	83 ec 04             	sub    $0x4,%esp
     650:	6a 0c                	push   $0xc
     652:	6a 00                	push   $0x0
     654:	ff 75 f4             	pushl  -0xc(%ebp)
     657:	e8 c0 09 00 00       	call   101c <memset>
     65c:	83 c4 10             	add    $0x10,%esp
	  newJob->id = jobId;
     65f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     662:	8b 55 08             	mov    0x8(%ebp),%edx
     665:	89 10                	mov    %edx,(%eax)
	  newJob->nextjob = 0;// NULL
     667:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	  newJob->headOfProcesses = 0; //NULL
     671:	8b 45 f4             	mov    -0xc(%ebp),%eax
     674:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)

	  return newJob;
     67b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     67e:	c9                   	leave  
     67f:	c3                   	ret    

00000680 <panic>:

void
panic(char *s)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     686:	83 ec 04             	sub    $0x4,%esp
     689:	ff 75 08             	pushl  0x8(%ebp)
     68c:	68 bd 17 00 00       	push   $0x17bd
     691:	6a 02                	push   $0x2
     693:	e8 9b 0c 00 00       	call   1333 <printf>
     698:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
     69b:	83 ec 0c             	sub    $0xc,%esp
     69e:	6a 01                	push   $0x1
     6a0:	e8 11 0b 00 00       	call   11b6 <exit>

000006a5 <fork1>:
}

int
fork1(void)
{
     6a5:	55                   	push   %ebp
     6a6:	89 e5                	mov    %esp,%ebp
     6a8:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     6ab:	e8 fe 0a 00 00       	call   11ae <fork>
     6b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     6b3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6b7:	75 10                	jne    6c9 <fork1+0x24>
    panic("fork");
     6b9:	83 ec 0c             	sub    $0xc,%esp
     6bc:	68 c1 17 00 00       	push   $0x17c1
     6c1:	e8 ba ff ff ff       	call   680 <panic>
     6c6:	83 c4 10             	add    $0x10,%esp
  return pid;
     6c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     6cc:	c9                   	leave  
     6cd:	c3                   	ret    

000006ce <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     6ce:	55                   	push   %ebp
     6cf:	89 e5                	mov    %esp,%ebp
     6d1:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6d4:	83 ec 0c             	sub    $0xc,%esp
     6d7:	6a 54                	push   $0x54
     6d9:	e8 26 0f 00 00       	call   1604 <malloc>
     6de:	83 c4 10             	add    $0x10,%esp
     6e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     6e4:	83 ec 04             	sub    $0x4,%esp
     6e7:	6a 54                	push   $0x54
     6e9:	6a 00                	push   $0x0
     6eb:	ff 75 f4             	pushl  -0xc(%ebp)
     6ee:	e8 29 09 00 00       	call   101c <memset>
     6f3:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     6f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f9:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     6ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     702:	c9                   	leave  
     703:	c3                   	ret    

00000704 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     704:	55                   	push   %ebp
     705:	89 e5                	mov    %esp,%ebp
     707:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     70a:	83 ec 0c             	sub    $0xc,%esp
     70d:	6a 18                	push   $0x18
     70f:	e8 f0 0e 00 00       	call   1604 <malloc>
     714:	83 c4 10             	add    $0x10,%esp
     717:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     71a:	83 ec 04             	sub    $0x4,%esp
     71d:	6a 18                	push   $0x18
     71f:	6a 00                	push   $0x0
     721:	ff 75 f4             	pushl  -0xc(%ebp)
     724:	e8 f3 08 00 00       	call   101c <memset>
     729:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     72c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72f:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     735:	8b 45 f4             	mov    -0xc(%ebp),%eax
     738:	8b 55 08             	mov    0x8(%ebp),%edx
     73b:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     73e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     741:	8b 55 0c             	mov    0xc(%ebp),%edx
     744:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     747:	8b 45 f4             	mov    -0xc(%ebp),%eax
     74a:	8b 55 10             	mov    0x10(%ebp),%edx
     74d:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     750:	8b 45 f4             	mov    -0xc(%ebp),%eax
     753:	8b 55 14             	mov    0x14(%ebp),%edx
     756:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     759:	8b 45 f4             	mov    -0xc(%ebp),%eax
     75c:	8b 55 18             	mov    0x18(%ebp),%edx
     75f:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     762:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     765:	c9                   	leave  
     766:	c3                   	ret    

00000767 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     767:	55                   	push   %ebp
     768:	89 e5                	mov    %esp,%ebp
     76a:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     76d:	83 ec 0c             	sub    $0xc,%esp
     770:	6a 0c                	push   $0xc
     772:	e8 8d 0e 00 00       	call   1604 <malloc>
     777:	83 c4 10             	add    $0x10,%esp
     77a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     77d:	83 ec 04             	sub    $0x4,%esp
     780:	6a 0c                	push   $0xc
     782:	6a 00                	push   $0x0
     784:	ff 75 f4             	pushl  -0xc(%ebp)
     787:	e8 90 08 00 00       	call   101c <memset>
     78c:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     792:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     798:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79b:	8b 55 08             	mov    0x8(%ebp),%edx
     79e:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a4:	8b 55 0c             	mov    0xc(%ebp),%edx
     7a7:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     7ad:	c9                   	leave  
     7ae:	c3                   	ret    

000007af <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     7af:	55                   	push   %ebp
     7b0:	89 e5                	mov    %esp,%ebp
     7b2:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     7b5:	83 ec 0c             	sub    $0xc,%esp
     7b8:	6a 0c                	push   $0xc
     7ba:	e8 45 0e 00 00       	call   1604 <malloc>
     7bf:	83 c4 10             	add    $0x10,%esp
     7c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     7c5:	83 ec 04             	sub    $0x4,%esp
     7c8:	6a 0c                	push   $0xc
     7ca:	6a 00                	push   $0x0
     7cc:	ff 75 f4             	pushl  -0xc(%ebp)
     7cf:	e8 48 08 00 00       	call   101c <memset>
     7d4:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7da:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e3:	8b 55 08             	mov    0x8(%ebp),%edx
     7e6:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ec:	8b 55 0c             	mov    0xc(%ebp),%edx
     7ef:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     7f5:	c9                   	leave  
     7f6:	c3                   	ret    

000007f7 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     7f7:	55                   	push   %ebp
     7f8:	89 e5                	mov    %esp,%ebp
     7fa:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     7fd:	83 ec 0c             	sub    $0xc,%esp
     800:	6a 08                	push   $0x8
     802:	e8 fd 0d 00 00       	call   1604 <malloc>
     807:	83 c4 10             	add    $0x10,%esp
     80a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     80d:	83 ec 04             	sub    $0x4,%esp
     810:	6a 08                	push   $0x8
     812:	6a 00                	push   $0x0
     814:	ff 75 f4             	pushl  -0xc(%ebp)
     817:	e8 00 08 00 00       	call   101c <memset>
     81c:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     822:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     828:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82b:	8b 55 08             	mov    0x8(%ebp),%edx
     82e:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     831:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     834:	c9                   	leave  
     835:	c3                   	ret    

00000836 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     836:	55                   	push   %ebp
     837:	89 e5                	mov    %esp,%ebp
     839:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     83c:	8b 45 08             	mov    0x8(%ebp),%eax
     83f:	8b 00                	mov    (%eax),%eax
     841:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     844:	eb 04                	jmp    84a <gettoken+0x14>
    s++;
     846:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     850:	73 1e                	jae    870 <gettoken+0x3a>
     852:	8b 45 f4             	mov    -0xc(%ebp),%eax
     855:	0f b6 00             	movzbl (%eax),%eax
     858:	0f be c0             	movsbl %al,%eax
     85b:	83 ec 08             	sub    $0x8,%esp
     85e:	50                   	push   %eax
     85f:	68 fc 1c 00 00       	push   $0x1cfc
     864:	e8 cd 07 00 00       	call   1036 <strchr>
     869:	83 c4 10             	add    $0x10,%esp
     86c:	85 c0                	test   %eax,%eax
     86e:	75 d6                	jne    846 <gettoken+0x10>
    s++;
  if(q)
     870:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     874:	74 08                	je     87e <gettoken+0x48>
    *q = s;
     876:	8b 45 10             	mov    0x10(%ebp),%eax
     879:	8b 55 f4             	mov    -0xc(%ebp),%edx
     87c:	89 10                	mov    %edx,(%eax)
  ret = *s;
     87e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     881:	0f b6 00             	movzbl (%eax),%eax
     884:	0f be c0             	movsbl %al,%eax
     887:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     88a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88d:	0f b6 00             	movzbl (%eax),%eax
     890:	0f be c0             	movsbl %al,%eax
     893:	83 f8 29             	cmp    $0x29,%eax
     896:	7f 14                	jg     8ac <gettoken+0x76>
     898:	83 f8 28             	cmp    $0x28,%eax
     89b:	7d 28                	jge    8c5 <gettoken+0x8f>
     89d:	85 c0                	test   %eax,%eax
     89f:	0f 84 96 00 00 00    	je     93b <gettoken+0x105>
     8a5:	83 f8 26             	cmp    $0x26,%eax
     8a8:	74 1b                	je     8c5 <gettoken+0x8f>
     8aa:	eb 3c                	jmp    8e8 <gettoken+0xb2>
     8ac:	83 f8 3e             	cmp    $0x3e,%eax
     8af:	74 1a                	je     8cb <gettoken+0x95>
     8b1:	83 f8 3e             	cmp    $0x3e,%eax
     8b4:	7f 0a                	jg     8c0 <gettoken+0x8a>
     8b6:	83 e8 3b             	sub    $0x3b,%eax
     8b9:	83 f8 01             	cmp    $0x1,%eax
     8bc:	77 2a                	ja     8e8 <gettoken+0xb2>
     8be:	eb 05                	jmp    8c5 <gettoken+0x8f>
     8c0:	83 f8 7c             	cmp    $0x7c,%eax
     8c3:	75 23                	jne    8e8 <gettoken+0xb2>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     8c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     8c9:	eb 71                	jmp    93c <gettoken+0x106>
  case '>':
    s++;
     8cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     8cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d2:	0f b6 00             	movzbl (%eax),%eax
     8d5:	3c 3e                	cmp    $0x3e,%al
     8d7:	75 0d                	jne    8e6 <gettoken+0xb0>
      ret = '+';
     8d9:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     8e0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     8e4:	eb 56                	jmp    93c <gettoken+0x106>
     8e6:	eb 54                	jmp    93c <gettoken+0x106>
  default:
    ret = 'a';
     8e8:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8ef:	eb 04                	jmp    8f5 <gettoken+0xbf>
      s++;
     8f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     8f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8fb:	73 3c                	jae    939 <gettoken+0x103>
     8fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     900:	0f b6 00             	movzbl (%eax),%eax
     903:	0f be c0             	movsbl %al,%eax
     906:	83 ec 08             	sub    $0x8,%esp
     909:	50                   	push   %eax
     90a:	68 fc 1c 00 00       	push   $0x1cfc
     90f:	e8 22 07 00 00       	call   1036 <strchr>
     914:	83 c4 10             	add    $0x10,%esp
     917:	85 c0                	test   %eax,%eax
     919:	75 1e                	jne    939 <gettoken+0x103>
     91b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91e:	0f b6 00             	movzbl (%eax),%eax
     921:	0f be c0             	movsbl %al,%eax
     924:	83 ec 08             	sub    $0x8,%esp
     927:	50                   	push   %eax
     928:	68 02 1d 00 00       	push   $0x1d02
     92d:	e8 04 07 00 00       	call   1036 <strchr>
     932:	83 c4 10             	add    $0x10,%esp
     935:	85 c0                	test   %eax,%eax
     937:	74 b8                	je     8f1 <gettoken+0xbb>
      s++;
    break;
     939:	eb 01                	jmp    93c <gettoken+0x106>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     93b:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     93c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     940:	74 08                	je     94a <gettoken+0x114>
    *eq = s;
     942:	8b 45 14             	mov    0x14(%ebp),%eax
     945:	8b 55 f4             	mov    -0xc(%ebp),%edx
     948:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     94a:	eb 04                	jmp    950 <gettoken+0x11a>
    s++;
     94c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     950:	8b 45 f4             	mov    -0xc(%ebp),%eax
     953:	3b 45 0c             	cmp    0xc(%ebp),%eax
     956:	73 1e                	jae    976 <gettoken+0x140>
     958:	8b 45 f4             	mov    -0xc(%ebp),%eax
     95b:	0f b6 00             	movzbl (%eax),%eax
     95e:	0f be c0             	movsbl %al,%eax
     961:	83 ec 08             	sub    $0x8,%esp
     964:	50                   	push   %eax
     965:	68 fc 1c 00 00       	push   $0x1cfc
     96a:	e8 c7 06 00 00       	call   1036 <strchr>
     96f:	83 c4 10             	add    $0x10,%esp
     972:	85 c0                	test   %eax,%eax
     974:	75 d6                	jne    94c <gettoken+0x116>
    s++;
  *ps = s;
     976:	8b 45 08             	mov    0x8(%ebp),%eax
     979:	8b 55 f4             	mov    -0xc(%ebp),%edx
     97c:	89 10                	mov    %edx,(%eax)
  return ret;
     97e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     981:	c9                   	leave  
     982:	c3                   	ret    

00000983 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     983:	55                   	push   %ebp
     984:	89 e5                	mov    %esp,%ebp
     986:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     989:	8b 45 08             	mov    0x8(%ebp),%eax
     98c:	8b 00                	mov    (%eax),%eax
     98e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     991:	eb 04                	jmp    997 <peek+0x14>
    s++;
     993:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     997:	8b 45 f4             	mov    -0xc(%ebp),%eax
     99a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     99d:	73 1e                	jae    9bd <peek+0x3a>
     99f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a2:	0f b6 00             	movzbl (%eax),%eax
     9a5:	0f be c0             	movsbl %al,%eax
     9a8:	83 ec 08             	sub    $0x8,%esp
     9ab:	50                   	push   %eax
     9ac:	68 fc 1c 00 00       	push   $0x1cfc
     9b1:	e8 80 06 00 00       	call   1036 <strchr>
     9b6:	83 c4 10             	add    $0x10,%esp
     9b9:	85 c0                	test   %eax,%eax
     9bb:	75 d6                	jne    993 <peek+0x10>
    s++;
  *ps = s;
     9bd:	8b 45 08             	mov    0x8(%ebp),%eax
     9c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     9c3:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     9c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c8:	0f b6 00             	movzbl (%eax),%eax
     9cb:	84 c0                	test   %al,%al
     9cd:	74 23                	je     9f2 <peek+0x6f>
     9cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9d2:	0f b6 00             	movzbl (%eax),%eax
     9d5:	0f be c0             	movsbl %al,%eax
     9d8:	83 ec 08             	sub    $0x8,%esp
     9db:	50                   	push   %eax
     9dc:	ff 75 10             	pushl  0x10(%ebp)
     9df:	e8 52 06 00 00       	call   1036 <strchr>
     9e4:	83 c4 10             	add    $0x10,%esp
     9e7:	85 c0                	test   %eax,%eax
     9e9:	74 07                	je     9f2 <peek+0x6f>
     9eb:	b8 01 00 00 00       	mov    $0x1,%eax
     9f0:	eb 05                	jmp    9f7 <peek+0x74>
     9f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     9f7:	c9                   	leave  
     9f8:	c3                   	ret    

000009f9 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     9f9:	55                   	push   %ebp
     9fa:	89 e5                	mov    %esp,%ebp
     9fc:	53                   	push   %ebx
     9fd:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     a00:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a03:	8b 45 08             	mov    0x8(%ebp),%eax
     a06:	83 ec 0c             	sub    $0xc,%esp
     a09:	50                   	push   %eax
     a0a:	e8 e6 05 00 00       	call   ff5 <strlen>
     a0f:	83 c4 10             	add    $0x10,%esp
     a12:	01 d8                	add    %ebx,%eax
     a14:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     a17:	83 ec 08             	sub    $0x8,%esp
     a1a:	ff 75 f4             	pushl  -0xc(%ebp)
     a1d:	8d 45 08             	lea    0x8(%ebp),%eax
     a20:	50                   	push   %eax
     a21:	e8 61 00 00 00       	call   a87 <parseline>
     a26:	83 c4 10             	add    $0x10,%esp
     a29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     a2c:	83 ec 04             	sub    $0x4,%esp
     a2f:	68 c6 17 00 00       	push   $0x17c6
     a34:	ff 75 f4             	pushl  -0xc(%ebp)
     a37:	8d 45 08             	lea    0x8(%ebp),%eax
     a3a:	50                   	push   %eax
     a3b:	e8 43 ff ff ff       	call   983 <peek>
     a40:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     a43:	8b 45 08             	mov    0x8(%ebp),%eax
     a46:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     a49:	74 26                	je     a71 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     a4b:	8b 45 08             	mov    0x8(%ebp),%eax
     a4e:	83 ec 04             	sub    $0x4,%esp
     a51:	50                   	push   %eax
     a52:	68 c7 17 00 00       	push   $0x17c7
     a57:	6a 02                	push   $0x2
     a59:	e8 d5 08 00 00       	call   1333 <printf>
     a5e:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     a61:	83 ec 0c             	sub    $0xc,%esp
     a64:	68 d6 17 00 00       	push   $0x17d6
     a69:	e8 12 fc ff ff       	call   680 <panic>
     a6e:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     a71:	83 ec 0c             	sub    $0xc,%esp
     a74:	ff 75 f0             	pushl  -0x10(%ebp)
     a77:	e8 e9 03 00 00       	call   e65 <nulterminate>
     a7c:	83 c4 10             	add    $0x10,%esp
  return cmd;
     a7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     a82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a85:	c9                   	leave  
     a86:	c3                   	ret    

00000a87 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     a87:	55                   	push   %ebp
     a88:	89 e5                	mov    %esp,%ebp
     a8a:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     a8d:	83 ec 08             	sub    $0x8,%esp
     a90:	ff 75 0c             	pushl  0xc(%ebp)
     a93:	ff 75 08             	pushl  0x8(%ebp)
     a96:	e8 99 00 00 00       	call   b34 <parsepipe>
     a9b:	83 c4 10             	add    $0x10,%esp
     a9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     aa1:	eb 23                	jmp    ac6 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     aa3:	6a 00                	push   $0x0
     aa5:	6a 00                	push   $0x0
     aa7:	ff 75 0c             	pushl  0xc(%ebp)
     aaa:	ff 75 08             	pushl  0x8(%ebp)
     aad:	e8 84 fd ff ff       	call   836 <gettoken>
     ab2:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     ab5:	83 ec 0c             	sub    $0xc,%esp
     ab8:	ff 75 f4             	pushl  -0xc(%ebp)
     abb:	e8 37 fd ff ff       	call   7f7 <backcmd>
     ac0:	83 c4 10             	add    $0x10,%esp
     ac3:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     ac6:	83 ec 04             	sub    $0x4,%esp
     ac9:	68 dd 17 00 00       	push   $0x17dd
     ace:	ff 75 0c             	pushl  0xc(%ebp)
     ad1:	ff 75 08             	pushl  0x8(%ebp)
     ad4:	e8 aa fe ff ff       	call   983 <peek>
     ad9:	83 c4 10             	add    $0x10,%esp
     adc:	85 c0                	test   %eax,%eax
     ade:	75 c3                	jne    aa3 <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     ae0:	83 ec 04             	sub    $0x4,%esp
     ae3:	68 df 17 00 00       	push   $0x17df
     ae8:	ff 75 0c             	pushl  0xc(%ebp)
     aeb:	ff 75 08             	pushl  0x8(%ebp)
     aee:	e8 90 fe ff ff       	call   983 <peek>
     af3:	83 c4 10             	add    $0x10,%esp
     af6:	85 c0                	test   %eax,%eax
     af8:	74 35                	je     b2f <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     afa:	6a 00                	push   $0x0
     afc:	6a 00                	push   $0x0
     afe:	ff 75 0c             	pushl  0xc(%ebp)
     b01:	ff 75 08             	pushl  0x8(%ebp)
     b04:	e8 2d fd ff ff       	call   836 <gettoken>
     b09:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     b0c:	83 ec 08             	sub    $0x8,%esp
     b0f:	ff 75 0c             	pushl  0xc(%ebp)
     b12:	ff 75 08             	pushl  0x8(%ebp)
     b15:	e8 6d ff ff ff       	call   a87 <parseline>
     b1a:	83 c4 10             	add    $0x10,%esp
     b1d:	83 ec 08             	sub    $0x8,%esp
     b20:	50                   	push   %eax
     b21:	ff 75 f4             	pushl  -0xc(%ebp)
     b24:	e8 86 fc ff ff       	call   7af <listcmd>
     b29:	83 c4 10             	add    $0x10,%esp
     b2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     b32:	c9                   	leave  
     b33:	c3                   	ret    

00000b34 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     b34:	55                   	push   %ebp
     b35:	89 e5                	mov    %esp,%ebp
     b37:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     b3a:	83 ec 08             	sub    $0x8,%esp
     b3d:	ff 75 0c             	pushl  0xc(%ebp)
     b40:	ff 75 08             	pushl  0x8(%ebp)
     b43:	e8 ec 01 00 00       	call   d34 <parseexec>
     b48:	83 c4 10             	add    $0x10,%esp
     b4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     b4e:	83 ec 04             	sub    $0x4,%esp
     b51:	68 e1 17 00 00       	push   $0x17e1
     b56:	ff 75 0c             	pushl  0xc(%ebp)
     b59:	ff 75 08             	pushl  0x8(%ebp)
     b5c:	e8 22 fe ff ff       	call   983 <peek>
     b61:	83 c4 10             	add    $0x10,%esp
     b64:	85 c0                	test   %eax,%eax
     b66:	74 35                	je     b9d <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     b68:	6a 00                	push   $0x0
     b6a:	6a 00                	push   $0x0
     b6c:	ff 75 0c             	pushl  0xc(%ebp)
     b6f:	ff 75 08             	pushl  0x8(%ebp)
     b72:	e8 bf fc ff ff       	call   836 <gettoken>
     b77:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b7a:	83 ec 08             	sub    $0x8,%esp
     b7d:	ff 75 0c             	pushl  0xc(%ebp)
     b80:	ff 75 08             	pushl  0x8(%ebp)
     b83:	e8 ac ff ff ff       	call   b34 <parsepipe>
     b88:	83 c4 10             	add    $0x10,%esp
     b8b:	83 ec 08             	sub    $0x8,%esp
     b8e:	50                   	push   %eax
     b8f:	ff 75 f4             	pushl  -0xc(%ebp)
     b92:	e8 d0 fb ff ff       	call   767 <pipecmd>
     b97:	83 c4 10             	add    $0x10,%esp
     b9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ba0:	c9                   	leave  
     ba1:	c3                   	ret    

00000ba2 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     ba2:	55                   	push   %ebp
     ba3:	89 e5                	mov    %esp,%ebp
     ba5:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     ba8:	e9 b6 00 00 00       	jmp    c63 <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     bad:	6a 00                	push   $0x0
     baf:	6a 00                	push   $0x0
     bb1:	ff 75 10             	pushl  0x10(%ebp)
     bb4:	ff 75 0c             	pushl  0xc(%ebp)
     bb7:	e8 7a fc ff ff       	call   836 <gettoken>
     bbc:	83 c4 10             	add    $0x10,%esp
     bbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     bc2:	8d 45 ec             	lea    -0x14(%ebp),%eax
     bc5:	50                   	push   %eax
     bc6:	8d 45 f0             	lea    -0x10(%ebp),%eax
     bc9:	50                   	push   %eax
     bca:	ff 75 10             	pushl  0x10(%ebp)
     bcd:	ff 75 0c             	pushl  0xc(%ebp)
     bd0:	e8 61 fc ff ff       	call   836 <gettoken>
     bd5:	83 c4 10             	add    $0x10,%esp
     bd8:	83 f8 61             	cmp    $0x61,%eax
     bdb:	74 10                	je     bed <parseredirs+0x4b>
      panic("missing file for redirection");
     bdd:	83 ec 0c             	sub    $0xc,%esp
     be0:	68 e3 17 00 00       	push   $0x17e3
     be5:	e8 96 fa ff ff       	call   680 <panic>
     bea:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     bed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf0:	83 f8 3c             	cmp    $0x3c,%eax
     bf3:	74 0c                	je     c01 <parseredirs+0x5f>
     bf5:	83 f8 3e             	cmp    $0x3e,%eax
     bf8:	74 26                	je     c20 <parseredirs+0x7e>
     bfa:	83 f8 2b             	cmp    $0x2b,%eax
     bfd:	74 43                	je     c42 <parseredirs+0xa0>
     bff:	eb 62                	jmp    c63 <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     c01:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c04:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c07:	83 ec 0c             	sub    $0xc,%esp
     c0a:	6a 00                	push   $0x0
     c0c:	6a 00                	push   $0x0
     c0e:	52                   	push   %edx
     c0f:	50                   	push   %eax
     c10:	ff 75 08             	pushl  0x8(%ebp)
     c13:	e8 ec fa ff ff       	call   704 <redircmd>
     c18:	83 c4 20             	add    $0x20,%esp
     c1b:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     c1e:	eb 43                	jmp    c63 <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     c20:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c23:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c26:	83 ec 0c             	sub    $0xc,%esp
     c29:	6a 01                	push   $0x1
     c2b:	68 01 02 00 00       	push   $0x201
     c30:	52                   	push   %edx
     c31:	50                   	push   %eax
     c32:	ff 75 08             	pushl  0x8(%ebp)
     c35:	e8 ca fa ff ff       	call   704 <redircmd>
     c3a:	83 c4 20             	add    $0x20,%esp
     c3d:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     c40:	eb 21                	jmp    c63 <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     c42:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c45:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c48:	83 ec 0c             	sub    $0xc,%esp
     c4b:	6a 01                	push   $0x1
     c4d:	68 01 02 00 00       	push   $0x201
     c52:	52                   	push   %edx
     c53:	50                   	push   %eax
     c54:	ff 75 08             	pushl  0x8(%ebp)
     c57:	e8 a8 fa ff ff       	call   704 <redircmd>
     c5c:	83 c4 20             	add    $0x20,%esp
     c5f:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     c62:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     c63:	83 ec 04             	sub    $0x4,%esp
     c66:	68 00 18 00 00       	push   $0x1800
     c6b:	ff 75 10             	pushl  0x10(%ebp)
     c6e:	ff 75 0c             	pushl  0xc(%ebp)
     c71:	e8 0d fd ff ff       	call   983 <peek>
     c76:	83 c4 10             	add    $0x10,%esp
     c79:	85 c0                	test   %eax,%eax
     c7b:	0f 85 2c ff ff ff    	jne    bad <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     c81:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c84:	c9                   	leave  
     c85:	c3                   	ret    

00000c86 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     c86:	55                   	push   %ebp
     c87:	89 e5                	mov    %esp,%ebp
     c89:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     c8c:	83 ec 04             	sub    $0x4,%esp
     c8f:	68 03 18 00 00       	push   $0x1803
     c94:	ff 75 0c             	pushl  0xc(%ebp)
     c97:	ff 75 08             	pushl  0x8(%ebp)
     c9a:	e8 e4 fc ff ff       	call   983 <peek>
     c9f:	83 c4 10             	add    $0x10,%esp
     ca2:	85 c0                	test   %eax,%eax
     ca4:	75 10                	jne    cb6 <parseblock+0x30>
    panic("parseblock");
     ca6:	83 ec 0c             	sub    $0xc,%esp
     ca9:	68 05 18 00 00       	push   $0x1805
     cae:	e8 cd f9 ff ff       	call   680 <panic>
     cb3:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     cb6:	6a 00                	push   $0x0
     cb8:	6a 00                	push   $0x0
     cba:	ff 75 0c             	pushl  0xc(%ebp)
     cbd:	ff 75 08             	pushl  0x8(%ebp)
     cc0:	e8 71 fb ff ff       	call   836 <gettoken>
     cc5:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     cc8:	83 ec 08             	sub    $0x8,%esp
     ccb:	ff 75 0c             	pushl  0xc(%ebp)
     cce:	ff 75 08             	pushl  0x8(%ebp)
     cd1:	e8 b1 fd ff ff       	call   a87 <parseline>
     cd6:	83 c4 10             	add    $0x10,%esp
     cd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     cdc:	83 ec 04             	sub    $0x4,%esp
     cdf:	68 10 18 00 00       	push   $0x1810
     ce4:	ff 75 0c             	pushl  0xc(%ebp)
     ce7:	ff 75 08             	pushl  0x8(%ebp)
     cea:	e8 94 fc ff ff       	call   983 <peek>
     cef:	83 c4 10             	add    $0x10,%esp
     cf2:	85 c0                	test   %eax,%eax
     cf4:	75 10                	jne    d06 <parseblock+0x80>
    panic("syntax - missing )");
     cf6:	83 ec 0c             	sub    $0xc,%esp
     cf9:	68 12 18 00 00       	push   $0x1812
     cfe:	e8 7d f9 ff ff       	call   680 <panic>
     d03:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     d06:	6a 00                	push   $0x0
     d08:	6a 00                	push   $0x0
     d0a:	ff 75 0c             	pushl  0xc(%ebp)
     d0d:	ff 75 08             	pushl  0x8(%ebp)
     d10:	e8 21 fb ff ff       	call   836 <gettoken>
     d15:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     d18:	83 ec 04             	sub    $0x4,%esp
     d1b:	ff 75 0c             	pushl  0xc(%ebp)
     d1e:	ff 75 08             	pushl  0x8(%ebp)
     d21:	ff 75 f4             	pushl  -0xc(%ebp)
     d24:	e8 79 fe ff ff       	call   ba2 <parseredirs>
     d29:	83 c4 10             	add    $0x10,%esp
     d2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     d2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d32:	c9                   	leave  
     d33:	c3                   	ret    

00000d34 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     d34:	55                   	push   %ebp
     d35:	89 e5                	mov    %esp,%ebp
     d37:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     d3a:	83 ec 04             	sub    $0x4,%esp
     d3d:	68 03 18 00 00       	push   $0x1803
     d42:	ff 75 0c             	pushl  0xc(%ebp)
     d45:	ff 75 08             	pushl  0x8(%ebp)
     d48:	e8 36 fc ff ff       	call   983 <peek>
     d4d:	83 c4 10             	add    $0x10,%esp
     d50:	85 c0                	test   %eax,%eax
     d52:	74 16                	je     d6a <parseexec+0x36>
    return parseblock(ps, es);
     d54:	83 ec 08             	sub    $0x8,%esp
     d57:	ff 75 0c             	pushl  0xc(%ebp)
     d5a:	ff 75 08             	pushl  0x8(%ebp)
     d5d:	e8 24 ff ff ff       	call   c86 <parseblock>
     d62:	83 c4 10             	add    $0x10,%esp
     d65:	e9 f9 00 00 00       	jmp    e63 <parseexec+0x12f>

  ret = execcmd();
     d6a:	e8 5f f9 ff ff       	call   6ce <execcmd>
     d6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     d72:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d75:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     d78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     d7f:	83 ec 04             	sub    $0x4,%esp
     d82:	ff 75 0c             	pushl  0xc(%ebp)
     d85:	ff 75 08             	pushl  0x8(%ebp)
     d88:	ff 75 f0             	pushl  -0x10(%ebp)
     d8b:	e8 12 fe ff ff       	call   ba2 <parseredirs>
     d90:	83 c4 10             	add    $0x10,%esp
     d93:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     d96:	e9 88 00 00 00       	jmp    e23 <parseexec+0xef>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     d9b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     d9e:	50                   	push   %eax
     d9f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     da2:	50                   	push   %eax
     da3:	ff 75 0c             	pushl  0xc(%ebp)
     da6:	ff 75 08             	pushl  0x8(%ebp)
     da9:	e8 88 fa ff ff       	call   836 <gettoken>
     dae:	83 c4 10             	add    $0x10,%esp
     db1:	89 45 e8             	mov    %eax,-0x18(%ebp)
     db4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     db8:	75 05                	jne    dbf <parseexec+0x8b>
      break;
     dba:	e9 82 00 00 00       	jmp    e41 <parseexec+0x10d>
    if(tok != 'a')
     dbf:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     dc3:	74 10                	je     dd5 <parseexec+0xa1>
      panic("syntax");
     dc5:	83 ec 0c             	sub    $0xc,%esp
     dc8:	68 d6 17 00 00       	push   $0x17d6
     dcd:	e8 ae f8 ff ff       	call   680 <panic>
     dd2:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     dd5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     dd8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ddb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     dde:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     de2:	8b 55 e0             	mov    -0x20(%ebp),%edx
     de5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     de8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     deb:	83 c1 08             	add    $0x8,%ecx
     dee:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     df2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     df6:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     dfa:	7e 10                	jle    e0c <parseexec+0xd8>
      panic("too many args");
     dfc:	83 ec 0c             	sub    $0xc,%esp
     dff:	68 25 18 00 00       	push   $0x1825
     e04:	e8 77 f8 ff ff       	call   680 <panic>
     e09:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     e0c:	83 ec 04             	sub    $0x4,%esp
     e0f:	ff 75 0c             	pushl  0xc(%ebp)
     e12:	ff 75 08             	pushl  0x8(%ebp)
     e15:	ff 75 f0             	pushl  -0x10(%ebp)
     e18:	e8 85 fd ff ff       	call   ba2 <parseredirs>
     e1d:	83 c4 10             	add    $0x10,%esp
     e20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     e23:	83 ec 04             	sub    $0x4,%esp
     e26:	68 33 18 00 00       	push   $0x1833
     e2b:	ff 75 0c             	pushl  0xc(%ebp)
     e2e:	ff 75 08             	pushl  0x8(%ebp)
     e31:	e8 4d fb ff ff       	call   983 <peek>
     e36:	83 c4 10             	add    $0x10,%esp
     e39:	85 c0                	test   %eax,%eax
     e3b:	0f 84 5a ff ff ff    	je     d9b <parseexec+0x67>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     e41:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e44:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e47:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     e4e:	00 
  cmd->eargv[argc] = 0;
     e4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e52:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e55:	83 c2 08             	add    $0x8,%edx
     e58:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     e5f:	00 
  return ret;
     e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e63:	c9                   	leave  
     e64:	c3                   	ret    

00000e65 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     e65:	55                   	push   %ebp
     e66:	89 e5                	mov    %esp,%ebp
     e68:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     e6b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     e6f:	75 0a                	jne    e7b <nulterminate+0x16>
    return 0;
     e71:	b8 00 00 00 00       	mov    $0x0,%eax
     e76:	e9 e4 00 00 00       	jmp    f5f <nulterminate+0xfa>
  
  switch(cmd->type){
     e7b:	8b 45 08             	mov    0x8(%ebp),%eax
     e7e:	8b 00                	mov    (%eax),%eax
     e80:	83 f8 05             	cmp    $0x5,%eax
     e83:	0f 87 d3 00 00 00    	ja     f5c <nulterminate+0xf7>
     e89:	8b 04 85 38 18 00 00 	mov    0x1838(,%eax,4),%eax
     e90:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     e92:	8b 45 08             	mov    0x8(%ebp),%eax
     e95:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     e98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e9f:	eb 14                	jmp    eb5 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     ea1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ea4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ea7:	83 c2 08             	add    $0x8,%edx
     eaa:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     eae:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     eb1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     eb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ebb:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     ebf:	85 c0                	test   %eax,%eax
     ec1:	75 de                	jne    ea1 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     ec3:	e9 94 00 00 00       	jmp    f5c <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     ec8:	8b 45 08             	mov    0x8(%ebp),%eax
     ecb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     ece:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed1:	8b 40 04             	mov    0x4(%eax),%eax
     ed4:	83 ec 0c             	sub    $0xc,%esp
     ed7:	50                   	push   %eax
     ed8:	e8 88 ff ff ff       	call   e65 <nulterminate>
     edd:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     ee0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ee3:	8b 40 0c             	mov    0xc(%eax),%eax
     ee6:	c6 00 00             	movb   $0x0,(%eax)
    break;
     ee9:	eb 71                	jmp    f5c <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     eeb:	8b 45 08             	mov    0x8(%ebp),%eax
     eee:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     ef1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ef4:	8b 40 04             	mov    0x4(%eax),%eax
     ef7:	83 ec 0c             	sub    $0xc,%esp
     efa:	50                   	push   %eax
     efb:	e8 65 ff ff ff       	call   e65 <nulterminate>
     f00:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     f03:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f06:	8b 40 08             	mov    0x8(%eax),%eax
     f09:	83 ec 0c             	sub    $0xc,%esp
     f0c:	50                   	push   %eax
     f0d:	e8 53 ff ff ff       	call   e65 <nulterminate>
     f12:	83 c4 10             	add    $0x10,%esp
    break;
     f15:	eb 45                	jmp    f5c <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     f17:	8b 45 08             	mov    0x8(%ebp),%eax
     f1a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     f1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f20:	8b 40 04             	mov    0x4(%eax),%eax
     f23:	83 ec 0c             	sub    $0xc,%esp
     f26:	50                   	push   %eax
     f27:	e8 39 ff ff ff       	call   e65 <nulterminate>
     f2c:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     f2f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f32:	8b 40 08             	mov    0x8(%eax),%eax
     f35:	83 ec 0c             	sub    $0xc,%esp
     f38:	50                   	push   %eax
     f39:	e8 27 ff ff ff       	call   e65 <nulterminate>
     f3e:	83 c4 10             	add    $0x10,%esp
    break;
     f41:	eb 19                	jmp    f5c <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     f43:	8b 45 08             	mov    0x8(%ebp),%eax
     f46:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     f49:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f4c:	8b 40 04             	mov    0x4(%eax),%eax
     f4f:	83 ec 0c             	sub    $0xc,%esp
     f52:	50                   	push   %eax
     f53:	e8 0d ff ff ff       	call   e65 <nulterminate>
     f58:	83 c4 10             	add    $0x10,%esp
    break;
     f5b:	90                   	nop
  }
  return cmd;
     f5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f5f:	c9                   	leave  
     f60:	c3                   	ret    

00000f61 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     f61:	55                   	push   %ebp
     f62:	89 e5                	mov    %esp,%ebp
     f64:	57                   	push   %edi
     f65:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     f66:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f69:	8b 55 10             	mov    0x10(%ebp),%edx
     f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6f:	89 cb                	mov    %ecx,%ebx
     f71:	89 df                	mov    %ebx,%edi
     f73:	89 d1                	mov    %edx,%ecx
     f75:	fc                   	cld    
     f76:	f3 aa                	rep stos %al,%es:(%edi)
     f78:	89 ca                	mov    %ecx,%edx
     f7a:	89 fb                	mov    %edi,%ebx
     f7c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     f7f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     f82:	5b                   	pop    %ebx
     f83:	5f                   	pop    %edi
     f84:	5d                   	pop    %ebp
     f85:	c3                   	ret    

00000f86 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     f86:	55                   	push   %ebp
     f87:	89 e5                	mov    %esp,%ebp
     f89:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     f8c:	8b 45 08             	mov    0x8(%ebp),%eax
     f8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     f92:	90                   	nop
     f93:	8b 45 08             	mov    0x8(%ebp),%eax
     f96:	8d 50 01             	lea    0x1(%eax),%edx
     f99:	89 55 08             	mov    %edx,0x8(%ebp)
     f9c:	8b 55 0c             	mov    0xc(%ebp),%edx
     f9f:	8d 4a 01             	lea    0x1(%edx),%ecx
     fa2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     fa5:	0f b6 12             	movzbl (%edx),%edx
     fa8:	88 10                	mov    %dl,(%eax)
     faa:	0f b6 00             	movzbl (%eax),%eax
     fad:	84 c0                	test   %al,%al
     faf:	75 e2                	jne    f93 <strcpy+0xd>
    ;
  return os;
     fb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     fb4:	c9                   	leave  
     fb5:	c3                   	ret    

00000fb6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     fb6:	55                   	push   %ebp
     fb7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     fb9:	eb 08                	jmp    fc3 <strcmp+0xd>
    p++, q++;
     fbb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     fbf:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     fc3:	8b 45 08             	mov    0x8(%ebp),%eax
     fc6:	0f b6 00             	movzbl (%eax),%eax
     fc9:	84 c0                	test   %al,%al
     fcb:	74 10                	je     fdd <strcmp+0x27>
     fcd:	8b 45 08             	mov    0x8(%ebp),%eax
     fd0:	0f b6 10             	movzbl (%eax),%edx
     fd3:	8b 45 0c             	mov    0xc(%ebp),%eax
     fd6:	0f b6 00             	movzbl (%eax),%eax
     fd9:	38 c2                	cmp    %al,%dl
     fdb:	74 de                	je     fbb <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     fdd:	8b 45 08             	mov    0x8(%ebp),%eax
     fe0:	0f b6 00             	movzbl (%eax),%eax
     fe3:	0f b6 d0             	movzbl %al,%edx
     fe6:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe9:	0f b6 00             	movzbl (%eax),%eax
     fec:	0f b6 c0             	movzbl %al,%eax
     fef:	29 c2                	sub    %eax,%edx
     ff1:	89 d0                	mov    %edx,%eax
}
     ff3:	5d                   	pop    %ebp
     ff4:	c3                   	ret    

00000ff5 <strlen>:

uint
strlen(char *s)
{
     ff5:	55                   	push   %ebp
     ff6:	89 e5                	mov    %esp,%ebp
     ff8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     ffb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1002:	eb 04                	jmp    1008 <strlen+0x13>
    1004:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1008:	8b 55 fc             	mov    -0x4(%ebp),%edx
    100b:	8b 45 08             	mov    0x8(%ebp),%eax
    100e:	01 d0                	add    %edx,%eax
    1010:	0f b6 00             	movzbl (%eax),%eax
    1013:	84 c0                	test   %al,%al
    1015:	75 ed                	jne    1004 <strlen+0xf>
    ;
  return n;
    1017:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    101a:	c9                   	leave  
    101b:	c3                   	ret    

0000101c <memset>:

void*
memset(void *dst, int c, uint n)
{
    101c:	55                   	push   %ebp
    101d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    101f:	8b 45 10             	mov    0x10(%ebp),%eax
    1022:	50                   	push   %eax
    1023:	ff 75 0c             	pushl  0xc(%ebp)
    1026:	ff 75 08             	pushl  0x8(%ebp)
    1029:	e8 33 ff ff ff       	call   f61 <stosb>
    102e:	83 c4 0c             	add    $0xc,%esp
  return dst;
    1031:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1034:	c9                   	leave  
    1035:	c3                   	ret    

00001036 <strchr>:

char*
strchr(const char *s, char c)
{
    1036:	55                   	push   %ebp
    1037:	89 e5                	mov    %esp,%ebp
    1039:	83 ec 04             	sub    $0x4,%esp
    103c:	8b 45 0c             	mov    0xc(%ebp),%eax
    103f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1042:	eb 14                	jmp    1058 <strchr+0x22>
    if(*s == c)
    1044:	8b 45 08             	mov    0x8(%ebp),%eax
    1047:	0f b6 00             	movzbl (%eax),%eax
    104a:	3a 45 fc             	cmp    -0x4(%ebp),%al
    104d:	75 05                	jne    1054 <strchr+0x1e>
      return (char*)s;
    104f:	8b 45 08             	mov    0x8(%ebp),%eax
    1052:	eb 13                	jmp    1067 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1054:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1058:	8b 45 08             	mov    0x8(%ebp),%eax
    105b:	0f b6 00             	movzbl (%eax),%eax
    105e:	84 c0                	test   %al,%al
    1060:	75 e2                	jne    1044 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1062:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1067:	c9                   	leave  
    1068:	c3                   	ret    

00001069 <gets>:

char*
gets(char *buf, int max)
{
    1069:	55                   	push   %ebp
    106a:	89 e5                	mov    %esp,%ebp
    106c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    106f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1076:	eb 44                	jmp    10bc <gets+0x53>
    cc = read(0, &c, 1);
    1078:	83 ec 04             	sub    $0x4,%esp
    107b:	6a 01                	push   $0x1
    107d:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1080:	50                   	push   %eax
    1081:	6a 00                	push   $0x0
    1083:	e8 46 01 00 00       	call   11ce <read>
    1088:	83 c4 10             	add    $0x10,%esp
    108b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    108e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1092:	7f 02                	jg     1096 <gets+0x2d>
      break;
    1094:	eb 31                	jmp    10c7 <gets+0x5e>
    buf[i++] = c;
    1096:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1099:	8d 50 01             	lea    0x1(%eax),%edx
    109c:	89 55 f4             	mov    %edx,-0xc(%ebp)
    109f:	89 c2                	mov    %eax,%edx
    10a1:	8b 45 08             	mov    0x8(%ebp),%eax
    10a4:	01 c2                	add    %eax,%edx
    10a6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    10aa:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    10ac:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    10b0:	3c 0a                	cmp    $0xa,%al
    10b2:	74 13                	je     10c7 <gets+0x5e>
    10b4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    10b8:	3c 0d                	cmp    $0xd,%al
    10ba:	74 0b                	je     10c7 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    10bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10bf:	83 c0 01             	add    $0x1,%eax
    10c2:	3b 45 0c             	cmp    0xc(%ebp),%eax
    10c5:	7c b1                	jl     1078 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    10c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    10ca:	8b 45 08             	mov    0x8(%ebp),%eax
    10cd:	01 d0                	add    %edx,%eax
    10cf:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    10d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
    10d5:	c9                   	leave  
    10d6:	c3                   	ret    

000010d7 <stat>:

int
stat(char *n, struct stat *st)
{
    10d7:	55                   	push   %ebp
    10d8:	89 e5                	mov    %esp,%ebp
    10da:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10dd:	83 ec 08             	sub    $0x8,%esp
    10e0:	6a 00                	push   $0x0
    10e2:	ff 75 08             	pushl  0x8(%ebp)
    10e5:	e8 0c 01 00 00       	call   11f6 <open>
    10ea:	83 c4 10             	add    $0x10,%esp
    10ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    10f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10f4:	79 07                	jns    10fd <stat+0x26>
    return -1;
    10f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10fb:	eb 25                	jmp    1122 <stat+0x4b>
  r = fstat(fd, st);
    10fd:	83 ec 08             	sub    $0x8,%esp
    1100:	ff 75 0c             	pushl  0xc(%ebp)
    1103:	ff 75 f4             	pushl  -0xc(%ebp)
    1106:	e8 03 01 00 00       	call   120e <fstat>
    110b:	83 c4 10             	add    $0x10,%esp
    110e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    1111:	83 ec 0c             	sub    $0xc,%esp
    1114:	ff 75 f4             	pushl  -0xc(%ebp)
    1117:	e8 c2 00 00 00       	call   11de <close>
    111c:	83 c4 10             	add    $0x10,%esp
  return r;
    111f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1122:	c9                   	leave  
    1123:	c3                   	ret    

00001124 <atoi>:

int
atoi(const char *s)
{
    1124:	55                   	push   %ebp
    1125:	89 e5                	mov    %esp,%ebp
    1127:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    112a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1131:	eb 25                	jmp    1158 <atoi+0x34>
    n = n*10 + *s++ - '0';
    1133:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1136:	89 d0                	mov    %edx,%eax
    1138:	c1 e0 02             	shl    $0x2,%eax
    113b:	01 d0                	add    %edx,%eax
    113d:	01 c0                	add    %eax,%eax
    113f:	89 c1                	mov    %eax,%ecx
    1141:	8b 45 08             	mov    0x8(%ebp),%eax
    1144:	8d 50 01             	lea    0x1(%eax),%edx
    1147:	89 55 08             	mov    %edx,0x8(%ebp)
    114a:	0f b6 00             	movzbl (%eax),%eax
    114d:	0f be c0             	movsbl %al,%eax
    1150:	01 c8                	add    %ecx,%eax
    1152:	83 e8 30             	sub    $0x30,%eax
    1155:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1158:	8b 45 08             	mov    0x8(%ebp),%eax
    115b:	0f b6 00             	movzbl (%eax),%eax
    115e:	3c 2f                	cmp    $0x2f,%al
    1160:	7e 0a                	jle    116c <atoi+0x48>
    1162:	8b 45 08             	mov    0x8(%ebp),%eax
    1165:	0f b6 00             	movzbl (%eax),%eax
    1168:	3c 39                	cmp    $0x39,%al
    116a:	7e c7                	jle    1133 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    116c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    116f:	c9                   	leave  
    1170:	c3                   	ret    

00001171 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1171:	55                   	push   %ebp
    1172:	89 e5                	mov    %esp,%ebp
    1174:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1177:	8b 45 08             	mov    0x8(%ebp),%eax
    117a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    117d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1180:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1183:	eb 17                	jmp    119c <memmove+0x2b>
    *dst++ = *src++;
    1185:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1188:	8d 50 01             	lea    0x1(%eax),%edx
    118b:	89 55 fc             	mov    %edx,-0x4(%ebp)
    118e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1191:	8d 4a 01             	lea    0x1(%edx),%ecx
    1194:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    1197:	0f b6 12             	movzbl (%edx),%edx
    119a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    119c:	8b 45 10             	mov    0x10(%ebp),%eax
    119f:	8d 50 ff             	lea    -0x1(%eax),%edx
    11a2:	89 55 10             	mov    %edx,0x10(%ebp)
    11a5:	85 c0                	test   %eax,%eax
    11a7:	7f dc                	jg     1185 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    11a9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ac:	c9                   	leave  
    11ad:	c3                   	ret    

000011ae <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    11ae:	b8 01 00 00 00       	mov    $0x1,%eax
    11b3:	cd 40                	int    $0x40
    11b5:	c3                   	ret    

000011b6 <exit>:
SYSCALL(exit)
    11b6:	b8 02 00 00 00       	mov    $0x2,%eax
    11bb:	cd 40                	int    $0x40
    11bd:	c3                   	ret    

000011be <wait>:
SYSCALL(wait)
    11be:	b8 03 00 00 00       	mov    $0x3,%eax
    11c3:	cd 40                	int    $0x40
    11c5:	c3                   	ret    

000011c6 <pipe>:
SYSCALL(pipe)
    11c6:	b8 04 00 00 00       	mov    $0x4,%eax
    11cb:	cd 40                	int    $0x40
    11cd:	c3                   	ret    

000011ce <read>:
SYSCALL(read)
    11ce:	b8 05 00 00 00       	mov    $0x5,%eax
    11d3:	cd 40                	int    $0x40
    11d5:	c3                   	ret    

000011d6 <write>:
SYSCALL(write)
    11d6:	b8 10 00 00 00       	mov    $0x10,%eax
    11db:	cd 40                	int    $0x40
    11dd:	c3                   	ret    

000011de <close>:
SYSCALL(close)
    11de:	b8 15 00 00 00       	mov    $0x15,%eax
    11e3:	cd 40                	int    $0x40
    11e5:	c3                   	ret    

000011e6 <kill>:
SYSCALL(kill)
    11e6:	b8 06 00 00 00       	mov    $0x6,%eax
    11eb:	cd 40                	int    $0x40
    11ed:	c3                   	ret    

000011ee <exec>:
SYSCALL(exec)
    11ee:	b8 07 00 00 00       	mov    $0x7,%eax
    11f3:	cd 40                	int    $0x40
    11f5:	c3                   	ret    

000011f6 <open>:
SYSCALL(open)
    11f6:	b8 0f 00 00 00       	mov    $0xf,%eax
    11fb:	cd 40                	int    $0x40
    11fd:	c3                   	ret    

000011fe <mknod>:
SYSCALL(mknod)
    11fe:	b8 11 00 00 00       	mov    $0x11,%eax
    1203:	cd 40                	int    $0x40
    1205:	c3                   	ret    

00001206 <unlink>:
SYSCALL(unlink)
    1206:	b8 12 00 00 00       	mov    $0x12,%eax
    120b:	cd 40                	int    $0x40
    120d:	c3                   	ret    

0000120e <fstat>:
SYSCALL(fstat)
    120e:	b8 08 00 00 00       	mov    $0x8,%eax
    1213:	cd 40                	int    $0x40
    1215:	c3                   	ret    

00001216 <link>:
SYSCALL(link)
    1216:	b8 13 00 00 00       	mov    $0x13,%eax
    121b:	cd 40                	int    $0x40
    121d:	c3                   	ret    

0000121e <mkdir>:
SYSCALL(mkdir)
    121e:	b8 14 00 00 00       	mov    $0x14,%eax
    1223:	cd 40                	int    $0x40
    1225:	c3                   	ret    

00001226 <chdir>:
SYSCALL(chdir)
    1226:	b8 09 00 00 00       	mov    $0x9,%eax
    122b:	cd 40                	int    $0x40
    122d:	c3                   	ret    

0000122e <dup>:
SYSCALL(dup)
    122e:	b8 0a 00 00 00       	mov    $0xa,%eax
    1233:	cd 40                	int    $0x40
    1235:	c3                   	ret    

00001236 <getpid>:
SYSCALL(getpid)
    1236:	b8 0b 00 00 00       	mov    $0xb,%eax
    123b:	cd 40                	int    $0x40
    123d:	c3                   	ret    

0000123e <sbrk>:
SYSCALL(sbrk)
    123e:	b8 0c 00 00 00       	mov    $0xc,%eax
    1243:	cd 40                	int    $0x40
    1245:	c3                   	ret    

00001246 <sleep>:
SYSCALL(sleep)
    1246:	b8 0d 00 00 00       	mov    $0xd,%eax
    124b:	cd 40                	int    $0x40
    124d:	c3                   	ret    

0000124e <uptime>:
SYSCALL(uptime)
    124e:	b8 0e 00 00 00       	mov    $0xe,%eax
    1253:	cd 40                	int    $0x40
    1255:	c3                   	ret    

00001256 <pstat>:
SYSCALL(pstat)
    1256:	b8 16 00 00 00       	mov    $0x16,%eax
    125b:	cd 40                	int    $0x40
    125d:	c3                   	ret    

0000125e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    125e:	55                   	push   %ebp
    125f:	89 e5                	mov    %esp,%ebp
    1261:	83 ec 18             	sub    $0x18,%esp
    1264:	8b 45 0c             	mov    0xc(%ebp),%eax
    1267:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    126a:	83 ec 04             	sub    $0x4,%esp
    126d:	6a 01                	push   $0x1
    126f:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1272:	50                   	push   %eax
    1273:	ff 75 08             	pushl  0x8(%ebp)
    1276:	e8 5b ff ff ff       	call   11d6 <write>
    127b:	83 c4 10             	add    $0x10,%esp
}
    127e:	c9                   	leave  
    127f:	c3                   	ret    

00001280 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	53                   	push   %ebx
    1284:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1287:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    128e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1292:	74 17                	je     12ab <printint+0x2b>
    1294:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1298:	79 11                	jns    12ab <printint+0x2b>
    neg = 1;
    129a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    12a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    12a4:	f7 d8                	neg    %eax
    12a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12a9:	eb 06                	jmp    12b1 <printint+0x31>
  } else {
    x = xx;
    12ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    12b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    12b8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    12bb:	8d 41 01             	lea    0x1(%ecx),%eax
    12be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    12c1:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12c7:	ba 00 00 00 00       	mov    $0x0,%edx
    12cc:	f7 f3                	div    %ebx
    12ce:	89 d0                	mov    %edx,%eax
    12d0:	0f b6 80 0a 1d 00 00 	movzbl 0x1d0a(%eax),%eax
    12d7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    12db:	8b 5d 10             	mov    0x10(%ebp),%ebx
    12de:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12e1:	ba 00 00 00 00       	mov    $0x0,%edx
    12e6:	f7 f3                	div    %ebx
    12e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12ef:	75 c7                	jne    12b8 <printint+0x38>
  if(neg)
    12f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12f5:	74 0e                	je     1305 <printint+0x85>
    buf[i++] = '-';
    12f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12fa:	8d 50 01             	lea    0x1(%eax),%edx
    12fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1300:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    1305:	eb 1d                	jmp    1324 <printint+0xa4>
    putc(fd, buf[i]);
    1307:	8d 55 dc             	lea    -0x24(%ebp),%edx
    130a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    130d:	01 d0                	add    %edx,%eax
    130f:	0f b6 00             	movzbl (%eax),%eax
    1312:	0f be c0             	movsbl %al,%eax
    1315:	83 ec 08             	sub    $0x8,%esp
    1318:	50                   	push   %eax
    1319:	ff 75 08             	pushl  0x8(%ebp)
    131c:	e8 3d ff ff ff       	call   125e <putc>
    1321:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1324:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1328:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    132c:	79 d9                	jns    1307 <printint+0x87>
    putc(fd, buf[i]);
}
    132e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1331:	c9                   	leave  
    1332:	c3                   	ret    

00001333 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1333:	55                   	push   %ebp
    1334:	89 e5                	mov    %esp,%ebp
    1336:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1339:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1340:	8d 45 0c             	lea    0xc(%ebp),%eax
    1343:	83 c0 04             	add    $0x4,%eax
    1346:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1349:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1350:	e9 59 01 00 00       	jmp    14ae <printf+0x17b>
    c = fmt[i] & 0xff;
    1355:	8b 55 0c             	mov    0xc(%ebp),%edx
    1358:	8b 45 f0             	mov    -0x10(%ebp),%eax
    135b:	01 d0                	add    %edx,%eax
    135d:	0f b6 00             	movzbl (%eax),%eax
    1360:	0f be c0             	movsbl %al,%eax
    1363:	25 ff 00 00 00       	and    $0xff,%eax
    1368:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    136b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    136f:	75 2c                	jne    139d <printf+0x6a>
      if(c == '%'){
    1371:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1375:	75 0c                	jne    1383 <printf+0x50>
        state = '%';
    1377:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    137e:	e9 27 01 00 00       	jmp    14aa <printf+0x177>
      } else {
        putc(fd, c);
    1383:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1386:	0f be c0             	movsbl %al,%eax
    1389:	83 ec 08             	sub    $0x8,%esp
    138c:	50                   	push   %eax
    138d:	ff 75 08             	pushl  0x8(%ebp)
    1390:	e8 c9 fe ff ff       	call   125e <putc>
    1395:	83 c4 10             	add    $0x10,%esp
    1398:	e9 0d 01 00 00       	jmp    14aa <printf+0x177>
      }
    } else if(state == '%'){
    139d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    13a1:	0f 85 03 01 00 00    	jne    14aa <printf+0x177>
      if(c == 'd'){
    13a7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    13ab:	75 1e                	jne    13cb <printf+0x98>
        printint(fd, *ap, 10, 1);
    13ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13b0:	8b 00                	mov    (%eax),%eax
    13b2:	6a 01                	push   $0x1
    13b4:	6a 0a                	push   $0xa
    13b6:	50                   	push   %eax
    13b7:	ff 75 08             	pushl  0x8(%ebp)
    13ba:	e8 c1 fe ff ff       	call   1280 <printint>
    13bf:	83 c4 10             	add    $0x10,%esp
        ap++;
    13c2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    13c6:	e9 d8 00 00 00       	jmp    14a3 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    13cb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    13cf:	74 06                	je     13d7 <printf+0xa4>
    13d1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    13d5:	75 1e                	jne    13f5 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    13d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13da:	8b 00                	mov    (%eax),%eax
    13dc:	6a 00                	push   $0x0
    13de:	6a 10                	push   $0x10
    13e0:	50                   	push   %eax
    13e1:	ff 75 08             	pushl  0x8(%ebp)
    13e4:	e8 97 fe ff ff       	call   1280 <printint>
    13e9:	83 c4 10             	add    $0x10,%esp
        ap++;
    13ec:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    13f0:	e9 ae 00 00 00       	jmp    14a3 <printf+0x170>
      } else if(c == 's'){
    13f5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    13f9:	75 43                	jne    143e <printf+0x10b>
        s = (char*)*ap;
    13fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    13fe:	8b 00                	mov    (%eax),%eax
    1400:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1403:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1407:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    140b:	75 07                	jne    1414 <printf+0xe1>
          s = "(null)";
    140d:	c7 45 f4 50 18 00 00 	movl   $0x1850,-0xc(%ebp)
        while(*s != 0){
    1414:	eb 1c                	jmp    1432 <printf+0xff>
          putc(fd, *s);
    1416:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1419:	0f b6 00             	movzbl (%eax),%eax
    141c:	0f be c0             	movsbl %al,%eax
    141f:	83 ec 08             	sub    $0x8,%esp
    1422:	50                   	push   %eax
    1423:	ff 75 08             	pushl  0x8(%ebp)
    1426:	e8 33 fe ff ff       	call   125e <putc>
    142b:	83 c4 10             	add    $0x10,%esp
          s++;
    142e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1432:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1435:	0f b6 00             	movzbl (%eax),%eax
    1438:	84 c0                	test   %al,%al
    143a:	75 da                	jne    1416 <printf+0xe3>
    143c:	eb 65                	jmp    14a3 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    143e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1442:	75 1d                	jne    1461 <printf+0x12e>
        putc(fd, *ap);
    1444:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1447:	8b 00                	mov    (%eax),%eax
    1449:	0f be c0             	movsbl %al,%eax
    144c:	83 ec 08             	sub    $0x8,%esp
    144f:	50                   	push   %eax
    1450:	ff 75 08             	pushl  0x8(%ebp)
    1453:	e8 06 fe ff ff       	call   125e <putc>
    1458:	83 c4 10             	add    $0x10,%esp
        ap++;
    145b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    145f:	eb 42                	jmp    14a3 <printf+0x170>
      } else if(c == '%'){
    1461:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1465:	75 17                	jne    147e <printf+0x14b>
        putc(fd, c);
    1467:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    146a:	0f be c0             	movsbl %al,%eax
    146d:	83 ec 08             	sub    $0x8,%esp
    1470:	50                   	push   %eax
    1471:	ff 75 08             	pushl  0x8(%ebp)
    1474:	e8 e5 fd ff ff       	call   125e <putc>
    1479:	83 c4 10             	add    $0x10,%esp
    147c:	eb 25                	jmp    14a3 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    147e:	83 ec 08             	sub    $0x8,%esp
    1481:	6a 25                	push   $0x25
    1483:	ff 75 08             	pushl  0x8(%ebp)
    1486:	e8 d3 fd ff ff       	call   125e <putc>
    148b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    148e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1491:	0f be c0             	movsbl %al,%eax
    1494:	83 ec 08             	sub    $0x8,%esp
    1497:	50                   	push   %eax
    1498:	ff 75 08             	pushl  0x8(%ebp)
    149b:	e8 be fd ff ff       	call   125e <putc>
    14a0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    14a3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    14aa:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14ae:	8b 55 0c             	mov    0xc(%ebp),%edx
    14b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14b4:	01 d0                	add    %edx,%eax
    14b6:	0f b6 00             	movzbl (%eax),%eax
    14b9:	84 c0                	test   %al,%al
    14bb:	0f 85 94 fe ff ff    	jne    1355 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    14c1:	c9                   	leave  
    14c2:	c3                   	ret    

000014c3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14c3:	55                   	push   %ebp
    14c4:	89 e5                	mov    %esp,%ebp
    14c6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    14c9:	8b 45 08             	mov    0x8(%ebp),%eax
    14cc:	83 e8 08             	sub    $0x8,%eax
    14cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14d2:	a1 ac 1d 00 00       	mov    0x1dac,%eax
    14d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    14da:	eb 24                	jmp    1500 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14df:	8b 00                	mov    (%eax),%eax
    14e1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14e4:	77 12                	ja     14f8 <free+0x35>
    14e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14e9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    14ec:	77 24                	ja     1512 <free+0x4f>
    14ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14f1:	8b 00                	mov    (%eax),%eax
    14f3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    14f6:	77 1a                	ja     1512 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14fb:	8b 00                	mov    (%eax),%eax
    14fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1500:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1503:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1506:	76 d4                	jbe    14dc <free+0x19>
    1508:	8b 45 fc             	mov    -0x4(%ebp),%eax
    150b:	8b 00                	mov    (%eax),%eax
    150d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1510:	76 ca                	jbe    14dc <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1512:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1515:	8b 40 04             	mov    0x4(%eax),%eax
    1518:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    151f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1522:	01 c2                	add    %eax,%edx
    1524:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1527:	8b 00                	mov    (%eax),%eax
    1529:	39 c2                	cmp    %eax,%edx
    152b:	75 24                	jne    1551 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    152d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1530:	8b 50 04             	mov    0x4(%eax),%edx
    1533:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1536:	8b 00                	mov    (%eax),%eax
    1538:	8b 40 04             	mov    0x4(%eax),%eax
    153b:	01 c2                	add    %eax,%edx
    153d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1540:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1543:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1546:	8b 00                	mov    (%eax),%eax
    1548:	8b 10                	mov    (%eax),%edx
    154a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    154d:	89 10                	mov    %edx,(%eax)
    154f:	eb 0a                	jmp    155b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1551:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1554:	8b 10                	mov    (%eax),%edx
    1556:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1559:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    155b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    155e:	8b 40 04             	mov    0x4(%eax),%eax
    1561:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1568:	8b 45 fc             	mov    -0x4(%ebp),%eax
    156b:	01 d0                	add    %edx,%eax
    156d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1570:	75 20                	jne    1592 <free+0xcf>
    p->s.size += bp->s.size;
    1572:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1575:	8b 50 04             	mov    0x4(%eax),%edx
    1578:	8b 45 f8             	mov    -0x8(%ebp),%eax
    157b:	8b 40 04             	mov    0x4(%eax),%eax
    157e:	01 c2                	add    %eax,%edx
    1580:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1583:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1586:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1589:	8b 10                	mov    (%eax),%edx
    158b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    158e:	89 10                	mov    %edx,(%eax)
    1590:	eb 08                	jmp    159a <free+0xd7>
  } else
    p->s.ptr = bp;
    1592:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1595:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1598:	89 10                	mov    %edx,(%eax)
  freep = p;
    159a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    159d:	a3 ac 1d 00 00       	mov    %eax,0x1dac
}
    15a2:	c9                   	leave  
    15a3:	c3                   	ret    

000015a4 <morecore>:

static Header*
morecore(uint nu)
{
    15a4:	55                   	push   %ebp
    15a5:	89 e5                	mov    %esp,%ebp
    15a7:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    15aa:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    15b1:	77 07                	ja     15ba <morecore+0x16>
    nu = 4096;
    15b3:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    15ba:	8b 45 08             	mov    0x8(%ebp),%eax
    15bd:	c1 e0 03             	shl    $0x3,%eax
    15c0:	83 ec 0c             	sub    $0xc,%esp
    15c3:	50                   	push   %eax
    15c4:	e8 75 fc ff ff       	call   123e <sbrk>
    15c9:	83 c4 10             	add    $0x10,%esp
    15cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    15cf:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    15d3:	75 07                	jne    15dc <morecore+0x38>
    return 0;
    15d5:	b8 00 00 00 00       	mov    $0x0,%eax
    15da:	eb 26                	jmp    1602 <morecore+0x5e>
  hp = (Header*)p;
    15dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    15e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15e5:	8b 55 08             	mov    0x8(%ebp),%edx
    15e8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    15eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ee:	83 c0 08             	add    $0x8,%eax
    15f1:	83 ec 0c             	sub    $0xc,%esp
    15f4:	50                   	push   %eax
    15f5:	e8 c9 fe ff ff       	call   14c3 <free>
    15fa:	83 c4 10             	add    $0x10,%esp
  return freep;
    15fd:	a1 ac 1d 00 00       	mov    0x1dac,%eax
}
    1602:	c9                   	leave  
    1603:	c3                   	ret    

00001604 <malloc>:

void*
malloc(uint nbytes)
{
    1604:	55                   	push   %ebp
    1605:	89 e5                	mov    %esp,%ebp
    1607:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    160a:	8b 45 08             	mov    0x8(%ebp),%eax
    160d:	83 c0 07             	add    $0x7,%eax
    1610:	c1 e8 03             	shr    $0x3,%eax
    1613:	83 c0 01             	add    $0x1,%eax
    1616:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1619:	a1 ac 1d 00 00       	mov    0x1dac,%eax
    161e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1621:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1625:	75 23                	jne    164a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1627:	c7 45 f0 a4 1d 00 00 	movl   $0x1da4,-0x10(%ebp)
    162e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1631:	a3 ac 1d 00 00       	mov    %eax,0x1dac
    1636:	a1 ac 1d 00 00       	mov    0x1dac,%eax
    163b:	a3 a4 1d 00 00       	mov    %eax,0x1da4
    base.s.size = 0;
    1640:	c7 05 a8 1d 00 00 00 	movl   $0x0,0x1da8
    1647:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    164a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    164d:	8b 00                	mov    (%eax),%eax
    164f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1652:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1655:	8b 40 04             	mov    0x4(%eax),%eax
    1658:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    165b:	72 4d                	jb     16aa <malloc+0xa6>
      if(p->s.size == nunits)
    165d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1660:	8b 40 04             	mov    0x4(%eax),%eax
    1663:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1666:	75 0c                	jne    1674 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1668:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166b:	8b 10                	mov    (%eax),%edx
    166d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1670:	89 10                	mov    %edx,(%eax)
    1672:	eb 26                	jmp    169a <malloc+0x96>
      else {
        p->s.size -= nunits;
    1674:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1677:	8b 40 04             	mov    0x4(%eax),%eax
    167a:	2b 45 ec             	sub    -0x14(%ebp),%eax
    167d:	89 c2                	mov    %eax,%edx
    167f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1682:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1685:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1688:	8b 40 04             	mov    0x4(%eax),%eax
    168b:	c1 e0 03             	shl    $0x3,%eax
    168e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1694:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1697:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    169a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    169d:	a3 ac 1d 00 00       	mov    %eax,0x1dac
      return (void*)(p + 1);
    16a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a5:	83 c0 08             	add    $0x8,%eax
    16a8:	eb 3b                	jmp    16e5 <malloc+0xe1>
    }
    if(p == freep)
    16aa:	a1 ac 1d 00 00       	mov    0x1dac,%eax
    16af:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    16b2:	75 1e                	jne    16d2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    16b4:	83 ec 0c             	sub    $0xc,%esp
    16b7:	ff 75 ec             	pushl  -0x14(%ebp)
    16ba:	e8 e5 fe ff ff       	call   15a4 <morecore>
    16bf:	83 c4 10             	add    $0x10,%esp
    16c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16c9:	75 07                	jne    16d2 <malloc+0xce>
        return 0;
    16cb:	b8 00 00 00 00       	mov    $0x0,%eax
    16d0:	eb 13                	jmp    16e5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    16d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    16d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16db:	8b 00                	mov    (%eax),%eax
    16dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    16e0:	e9 6d ff ff ff       	jmp    1652 <malloc+0x4e>
}
    16e5:	c9                   	leave  
    16e6:	c3                   	ret    
