
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
      11:	e8 56 17 00 00       	call   176c <exit>
  
  switch(cmd->type){
      16:	8b 45 08             	mov    0x8(%ebp),%eax
      19:	8b 00                	mov    (%eax),%eax
      1b:	83 f8 05             	cmp    $0x5,%eax
      1e:	77 09                	ja     29 <runcmd+0x29>
      20:	8b 04 85 fc 1c 00 00 	mov    0x1cfc(,%eax,4),%eax
      27:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      29:	83 ec 0c             	sub    $0xc,%esp
      2c:	68 cc 1c 00 00       	push   $0x1ccc
      31:	e8 00 0c 00 00       	call   c36 <panic>
      36:	83 c4 10             	add    $0x10,%esp

  case EXEC:
	  if (fork1() == 0){
      39:	e8 1d 0c 00 00       	call   c5b <fork1>
      3e:	85 c0                	test   %eax,%eax
      40:	0f 85 a1 00 00 00    	jne    e7 <runcmd+0xe7>
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
      5b:	e8 0c 17 00 00       	call   176c <exit>
		 char buf[sizeof(int)];
		 int pid = getpid();
      60:	e8 87 17 00 00       	call   17ec <getpid>
      65:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		 strcpy(buf , (char*)&pid);
      68:	83 ec 08             	sub    $0x8,%esp
      6b:	8d 45 d4             	lea    -0x2c(%ebp),%eax
      6e:	50                   	push   %eax
      6f:	8d 45 d8             	lea    -0x28(%ebp),%eax
      72:	50                   	push   %eax
      73:	e8 c4 14 00 00       	call   153c <strcpy>
      78:	83 c4 10             	add    $0x10,%esp
		 write(fdToShell , buf, strlen(buf));
      7b:	83 ec 0c             	sub    $0xc,%esp
      7e:	8d 45 d8             	lea    -0x28(%ebp),%eax
      81:	50                   	push   %eax
      82:	e8 24 15 00 00       	call   15ab <strlen>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	83 ec 04             	sub    $0x4,%esp
      8d:	50                   	push   %eax
      8e:	8d 45 d8             	lea    -0x28(%ebp),%eax
      91:	50                   	push   %eax
      92:	ff 75 0c             	pushl  0xc(%ebp)
      95:	e8 f2 16 00 00       	call   178c <write>
      9a:	83 c4 10             	add    $0x10,%esp
		 close(fdToShell);
      9d:	83 ec 0c             	sub    $0xc,%esp
      a0:	ff 75 0c             	pushl  0xc(%ebp)
      a3:	e8 ec 16 00 00       	call   1794 <close>
      a8:	83 c4 10             	add    $0x10,%esp

		 exec(ecmd->argv[0], ecmd->argv);
      ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
      ae:	8d 50 04             	lea    0x4(%eax),%edx
      b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
      b4:	8b 40 04             	mov    0x4(%eax),%eax
      b7:	83 ec 08             	sub    $0x8,%esp
      ba:	52                   	push   %edx
      bb:	50                   	push   %eax
      bc:	e8 e3 16 00 00       	call   17a4 <exec>
      c1:	83 c4 10             	add    $0x10,%esp
		 printf(2, "exec %s failed\n", ecmd->argv[0]);
      c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c7:	8b 40 04             	mov    0x4(%eax),%eax
      ca:	83 ec 04             	sub    $0x4,%esp
      cd:	50                   	push   %eax
      ce:	68 d3 1c 00 00       	push   $0x1cd3
      d3:	6a 02                	push   $0x2
      d5:	e8 0f 18 00 00       	call   18e9 <printf>
      da:	83 c4 10             	add    $0x10,%esp
		 exit(EXIT_STATUS_OK);
      dd:	83 ec 0c             	sub    $0xc,%esp
      e0:	6a 01                	push   $0x1
      e2:	e8 85 16 00 00       	call   176c <exit>
	  }
	  close(fdToShell);
      e7:	83 ec 0c             	sub    $0xc,%esp
      ea:	ff 75 0c             	pushl  0xc(%ebp)
      ed:	e8 a2 16 00 00       	call   1794 <close>
      f2:	83 c4 10             	add    $0x10,%esp
	  wait(0);
      f5:	83 ec 0c             	sub    $0xc,%esp
      f8:	6a 00                	push   $0x0
      fa:	e8 75 16 00 00       	call   1774 <wait>
      ff:	83 c4 10             	add    $0x10,%esp
     break;
     102:	e9 0c 02 00 00       	jmp    313 <runcmd+0x313>

   case REDIR:
     rcmd = (struct redircmd*)cmd;
     107:	8b 45 08             	mov    0x8(%ebp),%eax
     10a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     close(rcmd->fd);
     10d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     110:	8b 40 14             	mov    0x14(%eax),%eax
     113:	83 ec 0c             	sub    $0xc,%esp
     116:	50                   	push   %eax
     117:	e8 78 16 00 00       	call   1794 <close>
     11c:	83 c4 10             	add    $0x10,%esp
     if(open(rcmd->file, rcmd->mode) < 0){
     11f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     122:	8b 50 10             	mov    0x10(%eax),%edx
     125:	8b 45 f0             	mov    -0x10(%ebp),%eax
     128:	8b 40 08             	mov    0x8(%eax),%eax
     12b:	83 ec 08             	sub    $0x8,%esp
     12e:	52                   	push   %edx
     12f:	50                   	push   %eax
     130:	e8 77 16 00 00       	call   17ac <open>
     135:	83 c4 10             	add    $0x10,%esp
     138:	85 c0                	test   %eax,%eax
     13a:	79 23                	jns    15f <runcmd+0x15f>
       printf(2, "open %s failed\n", rcmd->file);
     13c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     13f:	8b 40 08             	mov    0x8(%eax),%eax
     142:	83 ec 04             	sub    $0x4,%esp
     145:	50                   	push   %eax
     146:	68 e3 1c 00 00       	push   $0x1ce3
     14b:	6a 02                	push   $0x2
     14d:	e8 97 17 00 00       	call   18e9 <printf>
     152:	83 c4 10             	add    $0x10,%esp
       exit(EXIT_STATUS_OK);
     155:	83 ec 0c             	sub    $0xc,%esp
     158:	6a 01                	push   $0x1
     15a:	e8 0d 16 00 00       	call   176c <exit>
     }
     runcmd(rcmd->cmd,fdToShell);
     15f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     162:	8b 40 04             	mov    0x4(%eax),%eax
     165:	83 ec 08             	sub    $0x8,%esp
     168:	ff 75 0c             	pushl  0xc(%ebp)
     16b:	50                   	push   %eax
     16c:	e8 8f fe ff ff       	call   0 <runcmd>
     171:	83 c4 10             	add    $0x10,%esp
     break;
     174:	e9 9a 01 00 00       	jmp    313 <runcmd+0x313>

   case LIST:
     lcmd = (struct listcmd*)cmd;
     179:	8b 45 08             	mov    0x8(%ebp),%eax
     17c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     if(fork1() == 0)
     17f:	e8 d7 0a 00 00       	call   c5b <fork1>
     184:	85 c0                	test   %eax,%eax
     186:	75 15                	jne    19d <runcmd+0x19d>
       runcmd(lcmd->left,fdToShell);
     188:	8b 45 ec             	mov    -0x14(%ebp),%eax
     18b:	8b 40 04             	mov    0x4(%eax),%eax
     18e:	83 ec 08             	sub    $0x8,%esp
     191:	ff 75 0c             	pushl  0xc(%ebp)
     194:	50                   	push   %eax
     195:	e8 66 fe ff ff       	call   0 <runcmd>
     19a:	83 c4 10             	add    $0x10,%esp
     wait(0);
     19d:	83 ec 0c             	sub    $0xc,%esp
     1a0:	6a 00                	push   $0x0
     1a2:	e8 cd 15 00 00       	call   1774 <wait>
     1a7:	83 c4 10             	add    $0x10,%esp
     runcmd(lcmd->right,fdToShell);
     1aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1ad:	8b 40 08             	mov    0x8(%eax),%eax
     1b0:	83 ec 08             	sub    $0x8,%esp
     1b3:	ff 75 0c             	pushl  0xc(%ebp)
     1b6:	50                   	push   %eax
     1b7:	e8 44 fe ff ff       	call   0 <runcmd>
     1bc:	83 c4 10             	add    $0x10,%esp
     break;
     1bf:	e9 4f 01 00 00       	jmp    313 <runcmd+0x313>

   case PIPE:
     pcmd = (struct pipecmd*)cmd;
     1c4:	8b 45 08             	mov    0x8(%ebp),%eax
     1c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
     if(pipe(p) < 0)
     1ca:	83 ec 0c             	sub    $0xc,%esp
     1cd:	8d 45 dc             	lea    -0x24(%ebp),%eax
     1d0:	50                   	push   %eax
     1d1:	e8 a6 15 00 00       	call   177c <pipe>
     1d6:	83 c4 10             	add    $0x10,%esp
     1d9:	85 c0                	test   %eax,%eax
     1db:	79 10                	jns    1ed <runcmd+0x1ed>
       panic("pipe");
     1dd:	83 ec 0c             	sub    $0xc,%esp
     1e0:	68 f3 1c 00 00       	push   $0x1cf3
     1e5:	e8 4c 0a 00 00       	call   c36 <panic>
     1ea:	83 c4 10             	add    $0x10,%esp
     if(fork1() == 0){
     1ed:	e8 69 0a 00 00       	call   c5b <fork1>
     1f2:	85 c0                	test   %eax,%eax
     1f4:	75 4f                	jne    245 <runcmd+0x245>
       close(1);
     1f6:	83 ec 0c             	sub    $0xc,%esp
     1f9:	6a 01                	push   $0x1
     1fb:	e8 94 15 00 00       	call   1794 <close>
     200:	83 c4 10             	add    $0x10,%esp
       dup(p[1]);
     203:	8b 45 e0             	mov    -0x20(%ebp),%eax
     206:	83 ec 0c             	sub    $0xc,%esp
     209:	50                   	push   %eax
     20a:	e8 d5 15 00 00       	call   17e4 <dup>
     20f:	83 c4 10             	add    $0x10,%esp
       close(p[0]);
     212:	8b 45 dc             	mov    -0x24(%ebp),%eax
     215:	83 ec 0c             	sub    $0xc,%esp
     218:	50                   	push   %eax
     219:	e8 76 15 00 00       	call   1794 <close>
     21e:	83 c4 10             	add    $0x10,%esp
       close(p[1]);
     221:	8b 45 e0             	mov    -0x20(%ebp),%eax
     224:	83 ec 0c             	sub    $0xc,%esp
     227:	50                   	push   %eax
     228:	e8 67 15 00 00       	call   1794 <close>
     22d:	83 c4 10             	add    $0x10,%esp
       runcmd(pcmd->left,fdToShell);
     230:	8b 45 e8             	mov    -0x18(%ebp),%eax
     233:	8b 40 04             	mov    0x4(%eax),%eax
     236:	83 ec 08             	sub    $0x8,%esp
     239:	ff 75 0c             	pushl  0xc(%ebp)
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
     }
     if(fork1() == 0){
     245:	e8 11 0a 00 00       	call   c5b <fork1>
     24a:	85 c0                	test   %eax,%eax
     24c:	75 4f                	jne    29d <runcmd+0x29d>
       close(0);
     24e:	83 ec 0c             	sub    $0xc,%esp
     251:	6a 00                	push   $0x0
     253:	e8 3c 15 00 00       	call   1794 <close>
     258:	83 c4 10             	add    $0x10,%esp
       dup(p[0]);
     25b:	8b 45 dc             	mov    -0x24(%ebp),%eax
     25e:	83 ec 0c             	sub    $0xc,%esp
     261:	50                   	push   %eax
     262:	e8 7d 15 00 00       	call   17e4 <dup>
     267:	83 c4 10             	add    $0x10,%esp
       close(p[0]);
     26a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     26d:	83 ec 0c             	sub    $0xc,%esp
     270:	50                   	push   %eax
     271:	e8 1e 15 00 00       	call   1794 <close>
     276:	83 c4 10             	add    $0x10,%esp
       close(p[1]);
     279:	8b 45 e0             	mov    -0x20(%ebp),%eax
     27c:	83 ec 0c             	sub    $0xc,%esp
     27f:	50                   	push   %eax
     280:	e8 0f 15 00 00       	call   1794 <close>
     285:	83 c4 10             	add    $0x10,%esp
       runcmd(pcmd->right,fdToShell);
     288:	8b 45 e8             	mov    -0x18(%ebp),%eax
     28b:	8b 40 08             	mov    0x8(%eax),%eax
     28e:	83 ec 08             	sub    $0x8,%esp
     291:	ff 75 0c             	pushl  0xc(%ebp)
     294:	50                   	push   %eax
     295:	e8 66 fd ff ff       	call   0 <runcmd>
     29a:	83 c4 10             	add    $0x10,%esp
     }
     close(p[0]);
     29d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     2a0:	83 ec 0c             	sub    $0xc,%esp
     2a3:	50                   	push   %eax
     2a4:	e8 eb 14 00 00       	call   1794 <close>
     2a9:	83 c4 10             	add    $0x10,%esp
     close(p[1]);
     2ac:	8b 45 e0             	mov    -0x20(%ebp),%eax
     2af:	83 ec 0c             	sub    $0xc,%esp
     2b2:	50                   	push   %eax
     2b3:	e8 dc 14 00 00       	call   1794 <close>
     2b8:	83 c4 10             	add    $0x10,%esp
     close(fdToShell);
     2bb:	83 ec 0c             	sub    $0xc,%esp
     2be:	ff 75 0c             	pushl  0xc(%ebp)
     2c1:	e8 ce 14 00 00       	call   1794 <close>
     2c6:	83 c4 10             	add    $0x10,%esp
     wait(0);
     2c9:	83 ec 0c             	sub    $0xc,%esp
     2cc:	6a 00                	push   $0x0
     2ce:	e8 a1 14 00 00       	call   1774 <wait>
     2d3:	83 c4 10             	add    $0x10,%esp

     wait(0);
     2d6:	83 ec 0c             	sub    $0xc,%esp
     2d9:	6a 00                	push   $0x0
     2db:	e8 94 14 00 00       	call   1774 <wait>
     2e0:	83 c4 10             	add    $0x10,%esp
     break;
     2e3:	eb 2e                	jmp    313 <runcmd+0x313>

   case BACK:
     bcmd = (struct backcmd*)cmd;
     2e5:	8b 45 08             	mov    0x8(%ebp),%eax
     2e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	  printf(2, "$ ");
     2eb:	83 ec 08             	sub    $0x8,%esp
     2ee:	68 f8 1c 00 00       	push   $0x1cf8
     2f3:	6a 02                	push   $0x2
     2f5:	e8 ef 15 00 00       	call   18e9 <printf>
     2fa:	83 c4 10             	add    $0x10,%esp
    	 runcmd(bcmd->cmd,fdToShell);
     2fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     300:	8b 40 04             	mov    0x4(%eax),%eax
     303:	83 ec 08             	sub    $0x8,%esp
     306:	ff 75 0c             	pushl  0xc(%ebp)
     309:	50                   	push   %eax
     30a:	e8 f1 fc ff ff       	call   0 <runcmd>
     30f:	83 c4 10             	add    $0x10,%esp
     break;
     312:	90                   	nop
  }
  printf(2, "$ ");
     313:	83 ec 08             	sub    $0x8,%esp
     316:	68 f8 1c 00 00       	push   $0x1cf8
     31b:	6a 02                	push   $0x2
     31d:	e8 c7 15 00 00       	call   18e9 <printf>
     322:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
     325:	83 ec 0c             	sub    $0xc,%esp
     328:	6a 01                	push   $0x1
     32a:	e8 3d 14 00 00       	call   176c <exit>

0000032f <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     32f:	55                   	push   %ebp
     330:	89 e5                	mov    %esp,%ebp
     332:	83 ec 08             	sub    $0x8,%esp
  //printf(2, "$ ");
  memset(buf, 0, nbuf);
     335:	8b 45 0c             	mov    0xc(%ebp),%eax
     338:	83 ec 04             	sub    $0x4,%esp
     33b:	50                   	push   %eax
     33c:	6a 00                	push   $0x0
     33e:	ff 75 08             	pushl  0x8(%ebp)
     341:	e8 8c 12 00 00       	call   15d2 <memset>
     346:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     349:	83 ec 08             	sub    $0x8,%esp
     34c:	ff 75 0c             	pushl  0xc(%ebp)
     34f:	ff 75 08             	pushl  0x8(%ebp)
     352:	e8 c8 12 00 00       	call   161f <gets>
     357:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     35a:	8b 45 08             	mov    0x8(%ebp),%eax
     35d:	0f b6 00             	movzbl (%eax),%eax
     360:	84 c0                	test   %al,%al
     362:	75 07                	jne    36b <getcmd+0x3c>
    return -1;
     364:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     369:	eb 05                	jmp    370 <getcmd+0x41>
  return 0;
     36b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     370:	c9                   	leave  
     371:	c3                   	ret    

00000372 <main>:

int
main(void)
{
     372:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     376:	83 e4 f0             	and    $0xfffffff0,%esp
     379:	ff 71 fc             	pushl  -0x4(%ecx)
     37c:	55                   	push   %ebp
     37d:	89 e5                	mov    %esp,%ebp
     37f:	51                   	push   %ecx
     380:	83 ec 44             	sub    $0x44,%esp
  static char buf[100];
  int fd;
  struct job *jobsHead = 0;
     383:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  struct job *foregroungJob = 0;
     38a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

  int jobCount = 0;
     391:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     398:	eb 16                	jmp    3b0 <main+0x3e>
    if(fd >= 3){
     39a:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
     39e:	7e 10                	jle    3b0 <main+0x3e>
      close(fd);
     3a0:	83 ec 0c             	sub    $0xc,%esp
     3a3:	ff 75 e8             	pushl  -0x18(%ebp)
     3a6:	e8 e9 13 00 00       	call   1794 <close>
     3ab:	83 c4 10             	add    $0x10,%esp
      break;
     3ae:	eb 1b                	jmp    3cb <main+0x59>
  struct job *foregroungJob = 0;

  int jobCount = 0;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     3b0:	83 ec 08             	sub    $0x8,%esp
     3b3:	6a 02                	push   $0x2
     3b5:	68 14 1d 00 00       	push   $0x1d14
     3ba:	e8 ed 13 00 00       	call   17ac <open>
     3bf:	83 c4 10             	add    $0x10,%esp
     3c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
     3c5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     3c9:	79 cf                	jns    39a <main+0x28>
      break;
    }
  }

  // Read and run input commands.
  printf(2, "$ ");
     3cb:	83 ec 08             	sub    $0x8,%esp
     3ce:	68 f8 1c 00 00       	push   $0x1cf8
     3d3:	6a 02                	push   $0x2
     3d5:	e8 0f 15 00 00       	call   18e9 <printf>
     3da:	83 c4 10             	add    $0x10,%esp

  while(getcmd(buf, sizeof(buf)) >= 0){
     3dd:	e9 2c 03 00 00       	jmp    70e <main+0x39c>
	 jobsHead = clearJobList(jobsHead);
     3e2:	83 ec 0c             	sub    $0xc,%esp
     3e5:	ff 75 f4             	pushl  -0xc(%ebp)
     3e8:	e8 51 05 00 00       	call   93e <clearJobList>
     3ed:	83 c4 10             	add    $0x10,%esp
     3f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	 foregroungJob = findForegroundJob(jobsHead);
     3f3:	83 ec 0c             	sub    $0xc,%esp
     3f6:	ff 75 f4             	pushl  -0xc(%ebp)
     3f9:	e8 f9 04 00 00       	call   8f7 <findForegroundJob>
     3fe:	83 c4 10             	add    $0x10,%esp
     401:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (foregroungJob != 0){
     404:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     408:	74 2f                	je     439 <main+0xc7>
		//TODO pass to pipe entered data
		write(foregroungJob->jobInFd , buf, strlen(buf));
     40a:	83 ec 0c             	sub    $0xc,%esp
     40d:	68 00 24 00 00       	push   $0x2400
     412:	e8 94 11 00 00       	call   15ab <strlen>
     417:	83 c4 10             	add    $0x10,%esp
     41a:	89 c2                	mov    %eax,%edx
     41c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     41f:	8b 40 0c             	mov    0xc(%eax),%eax
     422:	83 ec 04             	sub    $0x4,%esp
     425:	52                   	push   %edx
     426:	68 00 24 00 00       	push   $0x2400
     42b:	50                   	push   %eax
     42c:	e8 5b 13 00 00       	call   178c <write>
     431:	83 c4 10             	add    $0x10,%esp
		continue;
     434:	e9 d5 02 00 00       	jmp    70e <main+0x39c>
	}

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     439:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     440:	3c 63                	cmp    $0x63,%al
     442:	75 72                	jne    4b6 <main+0x144>
     444:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     44b:	3c 64                	cmp    $0x64,%al
     44d:	75 67                	jne    4b6 <main+0x144>
     44f:	0f b6 05 02 24 00 00 	movzbl 0x2402,%eax
     456:	3c 20                	cmp    $0x20,%al
     458:	75 5c                	jne    4b6 <main+0x144>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     45a:	83 ec 0c             	sub    $0xc,%esp
     45d:	68 00 24 00 00       	push   $0x2400
     462:	e8 44 11 00 00       	call   15ab <strlen>
     467:	83 c4 10             	add    $0x10,%esp
     46a:	83 e8 01             	sub    $0x1,%eax
     46d:	c6 80 00 24 00 00 00 	movb   $0x0,0x2400(%eax)
      if(chdir(buf+3) < 0)
     474:	83 ec 0c             	sub    $0xc,%esp
     477:	68 03 24 00 00       	push   $0x2403
     47c:	e8 5b 13 00 00       	call   17dc <chdir>
     481:	83 c4 10             	add    $0x10,%esp
     484:	85 c0                	test   %eax,%eax
     486:	79 17                	jns    49f <main+0x12d>
        printf(2, "cannot cd %s\n", buf+3);
     488:	83 ec 04             	sub    $0x4,%esp
     48b:	68 03 24 00 00       	push   $0x2403
     490:	68 1c 1d 00 00       	push   $0x1d1c
     495:	6a 02                	push   $0x2
     497:	e8 4d 14 00 00       	call   18e9 <printf>
     49c:	83 c4 10             	add    $0x10,%esp
	  printf(2, "$ ");
     49f:	83 ec 08             	sub    $0x8,%esp
     4a2:	68 f8 1c 00 00       	push   $0x1cf8
     4a7:	6a 02                	push   $0x2
     4a9:	e8 3b 14 00 00       	call   18e9 <printf>
     4ae:	83 c4 10             	add    $0x10,%esp
      continue;
     4b1:	e9 58 02 00 00       	jmp    70e <main+0x39c>
    }

    if(buf[0] == 'j' && buf[1] == 'o' && buf[2] == 'b' && buf[3] == 's'){
     4b6:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     4bd:	3c 6a                	cmp    $0x6a,%al
     4bf:	75 46                	jne    507 <main+0x195>
     4c1:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     4c8:	3c 6f                	cmp    $0x6f,%al
     4ca:	75 3b                	jne    507 <main+0x195>
     4cc:	0f b6 05 02 24 00 00 	movzbl 0x2402,%eax
     4d3:	3c 62                	cmp    $0x62,%al
     4d5:	75 30                	jne    507 <main+0x195>
     4d7:	0f b6 05 03 24 00 00 	movzbl 0x2403,%eax
     4de:	3c 73                	cmp    $0x73,%al
     4e0:	75 25                	jne    507 <main+0x195>
    	printAllJobs(jobsHead);
     4e2:	83 ec 0c             	sub    $0xc,%esp
     4e5:	ff 75 f4             	pushl  -0xc(%ebp)
     4e8:	e8 dd 02 00 00       	call   7ca <printAllJobs>
     4ed:	83 c4 10             	add    $0x10,%esp
    	printf(2, "$ ");
     4f0:	83 ec 08             	sub    $0x8,%esp
     4f3:	68 f8 1c 00 00       	push   $0x1cf8
     4f8:	6a 02                	push   $0x2
     4fa:	e8 ea 13 00 00       	call   18e9 <printf>
     4ff:	83 c4 10             	add    $0x10,%esp
    	continue;
     502:	e9 07 02 00 00       	jmp    70e <main+0x39c>
    }

    if(buf[0] == 'f' && buf[1] == 'g' && buf[2] == ' '){
     507:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     50e:	3c 66                	cmp    $0x66,%al
     510:	75 66                	jne    578 <main+0x206>
     512:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     519:	3c 67                	cmp    $0x67,%al
     51b:	75 5b                	jne    578 <main+0x206>
     51d:	0f b6 05 02 24 00 00 	movzbl 0x2402,%eax
     524:	3c 20                	cmp    $0x20,%al
     526:	75 50                	jne    578 <main+0x206>
        buf[strlen(buf)-1] = 0;  // chop \n
     528:	83 ec 0c             	sub    $0xc,%esp
     52b:	68 00 24 00 00       	push   $0x2400
     530:	e8 76 10 00 00       	call   15ab <strlen>
     535:	83 c4 10             	add    $0x10,%esp
     538:	83 e8 01             	sub    $0x1,%eax
     53b:	c6 80 00 24 00 00 00 	movb   $0x0,0x2400(%eax)
        int pid = atoi(buf + 3);
     542:	83 ec 0c             	sub    $0xc,%esp
     545:	68 03 24 00 00       	push   $0x2403
     54a:	e8 8b 11 00 00       	call   16da <atoi>
     54f:	83 c4 10             	add    $0x10,%esp
     552:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        struct job *findedJob = findJobById(jobsHead , pid);
     555:	83 ec 08             	sub    $0x8,%esp
     558:	ff 75 e4             	pushl  -0x1c(%ebp)
     55b:	ff 75 f4             	pushl  -0xc(%ebp)
     55e:	e8 5b 03 00 00       	call   8be <findJobById>
     563:	83 c4 10             	add    $0x10,%esp
     566:	89 45 e0             	mov    %eax,-0x20(%ebp)
        findedJob->type = FOREGROUND;
     569:	8b 45 e0             	mov    -0x20(%ebp),%eax
     56c:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
    	continue;
     573:	e9 96 01 00 00       	jmp    70e <main+0x39c>
    }

    if(buf[0] == 'f' && buf[1] == 'g'){
     578:	0f b6 05 00 24 00 00 	movzbl 0x2400,%eax
     57f:	3c 66                	cmp    $0x66,%al
     581:	75 1a                	jne    59d <main+0x22b>
     583:	0f b6 05 01 24 00 00 	movzbl 0x2401,%eax
     58a:	3c 67                	cmp    $0x67,%al
     58c:	75 0f                	jne    59d <main+0x22b>
        jobsHead->type = FOREGROUND;
     58e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     591:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
    	continue;
     598:	e9 71 01 00 00       	jmp    70e <main+0x39c>
    }

	int jobPids[2],jobInput[2];

	if(pipe(jobPids) < 0)
     59d:	83 ec 0c             	sub    $0xc,%esp
     5a0:	8d 45 cc             	lea    -0x34(%ebp),%eax
     5a3:	50                   	push   %eax
     5a4:	e8 d3 11 00 00       	call   177c <pipe>
     5a9:	83 c4 10             	add    $0x10,%esp
     5ac:	85 c0                	test   %eax,%eax
     5ae:	79 10                	jns    5c0 <main+0x24e>
	  panic("jobPids error");
     5b0:	83 ec 0c             	sub    $0xc,%esp
     5b3:	68 2a 1d 00 00       	push   $0x1d2a
     5b8:	e8 79 06 00 00       	call   c36 <panic>
     5bd:	83 c4 10             	add    $0x10,%esp

	if(pipe(jobInput) < 0)
     5c0:	83 ec 0c             	sub    $0xc,%esp
     5c3:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     5c6:	50                   	push   %eax
     5c7:	e8 b0 11 00 00       	call   177c <pipe>
     5cc:	83 c4 10             	add    $0x10,%esp
     5cf:	85 c0                	test   %eax,%eax
     5d1:	79 10                	jns    5e3 <main+0x271>
	  panic("jobInput error");
     5d3:	83 ec 0c             	sub    $0xc,%esp
     5d6:	68 38 1d 00 00       	push   $0x1d38
     5db:	e8 56 06 00 00       	call   c36 <panic>
     5e0:	83 c4 10             	add    $0x10,%esp

	jobCount++;
     5e3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	struct job *newJob = getJob(jobCount , jobInput[1], buf); // by default FOREGROUND sJOB
     5e7:	8b 45 c8             	mov    -0x38(%ebp),%eax
     5ea:	83 ec 04             	sub    $0x4,%esp
     5ed:	68 00 24 00 00       	push   $0x2400
     5f2:	50                   	push   %eax
     5f3:	ff 75 f0             	pushl  -0x10(%ebp)
     5f6:	e8 69 05 00 00       	call   b64 <getJob>
     5fb:	83 c4 10             	add    $0x10,%esp
     5fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
	struct cmd *newcmd = parsecmd(buf);
     601:	83 ec 0c             	sub    $0xc,%esp
     604:	68 00 24 00 00       	push   $0x2400
     609:	e8 a1 09 00 00       	call   faf <parsecmd>
     60e:	83 c4 10             	add    $0x10,%esp
     611:	89 45 d8             	mov    %eax,-0x28(%ebp)

	if (newcmd->type == BACK){
     614:	8b 45 d8             	mov    -0x28(%ebp),%eax
     617:	8b 00                	mov    (%eax),%eax
     619:	83 f8 05             	cmp    $0x5,%eax
     61c:	75 0a                	jne    628 <main+0x2b6>
		newJob->type = BACKGROUND; // change to background if it's so
     61e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     621:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
	}


	if(jobsHead == 0){
     628:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     62c:	75 08                	jne    636 <main+0x2c4>
		jobsHead = newJob;
     62e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     631:	89 45 f4             	mov    %eax,-0xc(%ebp)
     634:	eb 0f                	jmp    645 <main+0x2d3>
	}
	else {
		newJob->nextjob = jobsHead;
     636:	8b 45 dc             	mov    -0x24(%ebp),%eax
     639:	8b 55 f4             	mov    -0xc(%ebp),%edx
     63c:	89 50 04             	mov    %edx,0x4(%eax)
		jobsHead = newJob;
     63f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     642:	89 45 f4             	mov    %eax,-0xc(%ebp)
	}

	if(fork1() == 0)
     645:	e8 11 06 00 00       	call   c5b <fork1>
     64a:	85 c0                	test   %eax,%eax
     64c:	75 5d                	jne    6ab <main+0x339>
	{
		close(0);
     64e:	83 ec 0c             	sub    $0xc,%esp
     651:	6a 00                	push   $0x0
     653:	e8 3c 11 00 00       	call   1794 <close>
     658:	83 c4 10             	add    $0x10,%esp
		dup(jobInput[0]);
     65b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     65e:	83 ec 0c             	sub    $0xc,%esp
     661:	50                   	push   %eax
     662:	e8 7d 11 00 00       	call   17e4 <dup>
     667:	83 c4 10             	add    $0x10,%esp

		close(jobInput[0]);
     66a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     66d:	83 ec 0c             	sub    $0xc,%esp
     670:	50                   	push   %eax
     671:	e8 1e 11 00 00       	call   1794 <close>
     676:	83 c4 10             	add    $0x10,%esp
		close(jobInput[1]);
     679:	8b 45 c8             	mov    -0x38(%ebp),%eax
     67c:	83 ec 0c             	sub    $0xc,%esp
     67f:	50                   	push   %eax
     680:	e8 0f 11 00 00       	call   1794 <close>
     685:	83 c4 10             	add    $0x10,%esp
		close(jobPids[0]);
     688:	8b 45 cc             	mov    -0x34(%ebp),%eax
     68b:	83 ec 0c             	sub    $0xc,%esp
     68e:	50                   	push   %eax
     68f:	e8 00 11 00 00       	call   1794 <close>
     694:	83 c4 10             	add    $0x10,%esp

		runcmd(newcmd , jobPids[1]);
     697:	8b 45 d0             	mov    -0x30(%ebp),%eax
     69a:	83 ec 08             	sub    $0x8,%esp
     69d:	50                   	push   %eax
     69e:	ff 75 d8             	pushl  -0x28(%ebp)
     6a1:	e8 5a f9 ff ff       	call   0 <runcmd>
     6a6:	83 c4 10             	add    $0x10,%esp
     6a9:	eb 63                	jmp    70e <main+0x39c>
	}
	else{
		close(jobInput[0]);
     6ab:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     6ae:	83 ec 0c             	sub    $0xc,%esp
     6b1:	50                   	push   %eax
     6b2:	e8 dd 10 00 00       	call   1794 <close>
     6b7:	83 c4 10             	add    $0x10,%esp
		close(jobPids[1]);
     6ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
     6bd:	83 ec 0c             	sub    $0xc,%esp
     6c0:	50                   	push   %eax
     6c1:	e8 ce 10 00 00       	call   1794 <close>
     6c6:	83 c4 10             	add    $0x10,%esp

		char pidBuf[sizeof(int)];
		while (read(jobPids[0] , pidBuf , sizeof(pidBuf)) > 0 ){
     6c9:	eb 1b                	jmp    6e6 <main+0x374>
			int recievedPid = (int)*pidBuf;
     6cb:	0f b6 45 c0          	movzbl -0x40(%ebp),%eax
     6cf:	0f be c0             	movsbl %al,%eax
     6d2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			addProcessToJob(newJob , recievedPid);
     6d5:	83 ec 08             	sub    $0x8,%esp
     6d8:	ff 75 d4             	pushl  -0x2c(%ebp)
     6db:	ff 75 dc             	pushl  -0x24(%ebp)
     6de:	e8 ad 01 00 00       	call   890 <addProcessToJob>
     6e3:	83 c4 10             	add    $0x10,%esp
	else{
		close(jobInput[0]);
		close(jobPids[1]);

		char pidBuf[sizeof(int)];
		while (read(jobPids[0] , pidBuf , sizeof(pidBuf)) > 0 ){
     6e6:	8b 45 cc             	mov    -0x34(%ebp),%eax
     6e9:	83 ec 04             	sub    $0x4,%esp
     6ec:	6a 04                	push   $0x4
     6ee:	8d 55 c0             	lea    -0x40(%ebp),%edx
     6f1:	52                   	push   %edx
     6f2:	50                   	push   %eax
     6f3:	e8 8c 10 00 00       	call   1784 <read>
     6f8:	83 c4 10             	add    $0x10,%esp
     6fb:	85 c0                	test   %eax,%eax
     6fd:	7f cc                	jg     6cb <main+0x359>
			int recievedPid = (int)*pidBuf;
			addProcessToJob(newJob , recievedPid);
		}
		close(jobPids[0]);
     6ff:	8b 45 cc             	mov    -0x34(%ebp),%eax
     702:	83 ec 0c             	sub    $0xc,%esp
     705:	50                   	push   %eax
     706:	e8 89 10 00 00       	call   1794 <close>
     70b:	83 c4 10             	add    $0x10,%esp
  }

  // Read and run input commands.
  printf(2, "$ ");

  while(getcmd(buf, sizeof(buf)) >= 0){
     70e:	83 ec 08             	sub    $0x8,%esp
     711:	6a 64                	push   $0x64
     713:	68 00 24 00 00       	push   $0x2400
     718:	e8 12 fc ff ff       	call   32f <getcmd>
     71d:	83 c4 10             	add    $0x10,%esp
     720:	85 c0                	test   %eax,%eax
     722:	0f 89 ba fc ff ff    	jns    3e2 <main+0x70>
	}


	//wait(0);
  }
  deleteJobList(jobsHead);
     728:	83 ec 0c             	sub    $0xc,%esp
     72b:	ff 75 f4             	pushl  -0xc(%ebp)
     72e:	e8 0d 00 00 00       	call   740 <deleteJobList>
     733:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
     736:	83 ec 0c             	sub    $0xc,%esp
     739:	6a 01                	push   $0x1
     73b:	e8 2c 10 00 00       	call   176c <exit>

00000740 <deleteJobList>:
}


void deleteJobList(struct job * head){
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	83 ec 18             	sub    $0x18,%esp
	struct job* currentJob = head;
     746:	8b 45 08             	mov    0x8(%ebp),%eax
     749:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job* tempJob = 0;
     74c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	if (head == 0) {
     753:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     757:	75 02                	jne    75b <deleteJobList+0x1b>
		return;
     759:	eb 6d                	jmp    7c8 <deleteJobList+0x88>
	}
	while (currentJob!=0){
     75b:	eb 64                	jmp    7c1 <deleteJobList+0x81>
		struct jobprocess* currentProc = currentJob->headOfProcesses;
     75d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     760:	8b 40 08             	mov    0x8(%eax),%eax
     763:	89 45 f0             	mov    %eax,-0x10(%ebp)
		struct jobprocess* tempProc = 0;
     766:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		while (currentProc != 0 ){
     76d:	eb 1d                	jmp    78c <deleteJobList+0x4c>
			tempProc = currentProc->nextProcess;
     76f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     772:	8b 40 04             	mov    0x4(%eax),%eax
     775:	89 45 e8             	mov    %eax,-0x18(%ebp)
			free(currentProc);
     778:	83 ec 0c             	sub    $0xc,%esp
     77b:	ff 75 f0             	pushl  -0x10(%ebp)
     77e:	e8 f6 12 00 00       	call   1a79 <free>
     783:	83 c4 10             	add    $0x10,%esp
			currentProc = tempProc;
     786:	8b 45 e8             	mov    -0x18(%ebp),%eax
     789:	89 45 f0             	mov    %eax,-0x10(%ebp)
		return;
	}
	while (currentJob!=0){
		struct jobprocess* currentProc = currentJob->headOfProcesses;
		struct jobprocess* tempProc = 0;
		while (currentProc != 0 ){
     78c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     790:	75 dd                	jne    76f <deleteJobList+0x2f>
			tempProc = currentProc->nextProcess;
			free(currentProc);
			currentProc = tempProc;
		}
		tempJob = currentJob->nextjob;
     792:	8b 45 f4             	mov    -0xc(%ebp),%eax
     795:	8b 40 04             	mov    0x4(%eax),%eax
     798:	89 45 ec             	mov    %eax,-0x14(%ebp)
		free(currentJob->cmd);
     79b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79e:	8b 40 14             	mov    0x14(%eax),%eax
     7a1:	83 ec 0c             	sub    $0xc,%esp
     7a4:	50                   	push   %eax
     7a5:	e8 cf 12 00 00       	call   1a79 <free>
     7aa:	83 c4 10             	add    $0x10,%esp
		free(currentJob);
     7ad:	83 ec 0c             	sub    $0xc,%esp
     7b0:	ff 75 f4             	pushl  -0xc(%ebp)
     7b3:	e8 c1 12 00 00       	call   1a79 <free>
     7b8:	83 c4 10             	add    $0x10,%esp
		currentJob = tempJob;
     7bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     7be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job* currentJob = head;
	struct job* tempJob = 0;
	if (head == 0) {
		return;
	}
	while (currentJob!=0){
     7c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7c5:	75 96                	jne    75d <deleteJobList+0x1d>
		tempJob = currentJob->nextjob;
		free(currentJob->cmd);
		free(currentJob);
		currentJob = tempJob;
	}
	return;
     7c7:	90                   	nop
}
     7c8:	c9                   	leave  
     7c9:	c3                   	ret    

000007ca <printAllJobs>:

void printAllJobs(struct job * head){
     7ca:	55                   	push   %ebp
     7cb:	89 e5                	mov    %esp,%ebp
     7cd:	53                   	push   %ebx
     7ce:	83 ec 34             	sub    $0x34,%esp
	struct job* currentJob = head;
     7d1:	8b 45 08             	mov    0x8(%ebp),%eax
     7d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (head == 0) {
     7d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     7db:	75 17                	jne    7f4 <printAllJobs+0x2a>
		printf(2, "There are no jobs\n");
     7dd:	83 ec 08             	sub    $0x8,%esp
     7e0:	68 47 1d 00 00       	push   $0x1d47
     7e5:	6a 02                	push   $0x2
     7e7:	e8 fd 10 00 00       	call   18e9 <printf>
     7ec:	83 c4 10             	add    $0x10,%esp
		return;
     7ef:	e9 97 00 00 00       	jmp    88b <printAllJobs+0xc1>
	}
	while (currentJob!=0){
     7f4:	e9 87 00 00 00       	jmp    880 <printAllJobs+0xb6>
		struct jobprocess* currentProc = currentJob->headOfProcesses;
     7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fc:	8b 40 08             	mov    0x8(%eax),%eax
     7ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
		printf(2, "Job %d: %s", currentJob->id, currentJob->cmd);
     802:	8b 45 f4             	mov    -0xc(%ebp),%eax
     805:	8b 50 14             	mov    0x14(%eax),%edx
     808:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80b:	8b 00                	mov    (%eax),%eax
     80d:	52                   	push   %edx
     80e:	50                   	push   %eax
     80f:	68 5a 1d 00 00       	push   $0x1d5a
     814:	6a 02                	push   $0x2
     816:	e8 ce 10 00 00       	call   18e9 <printf>
     81b:	83 c4 10             	add    $0x10,%esp
		while (currentProc != 0 ){
     81e:	eb 51                	jmp    871 <printAllJobs+0xa7>
			struct procstat stat;
			if (pstat(currentProc->pid, &stat) == 0){
     820:	8b 45 f0             	mov    -0x10(%ebp),%eax
     823:	8b 00                	mov    (%eax),%eax
     825:	83 ec 08             	sub    $0x8,%esp
     828:	8d 55 d4             	lea    -0x2c(%ebp),%edx
     82b:	52                   	push   %edx
     82c:	50                   	push   %eax
     82d:	e8 da 0f 00 00       	call   180c <pstat>
     832:	83 c4 10             	add    $0x10,%esp
     835:	85 c0                	test   %eax,%eax
     837:	75 2f                	jne    868 <printAllJobs+0x9e>
				printf(2, "%d: %s %d %d %s\n", currentProc->pid, stat.name, stat.sz, stat.nofile, states[stat.state]);
     839:	8b 45 ec             	mov    -0x14(%ebp),%eax
     83c:	8b 1c 85 bc 23 00 00 	mov    0x23bc(,%eax,4),%ebx
     843:	8b 4d e8             	mov    -0x18(%ebp),%ecx
     846:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     849:	8b 45 f0             	mov    -0x10(%ebp),%eax
     84c:	8b 00                	mov    (%eax),%eax
     84e:	83 ec 04             	sub    $0x4,%esp
     851:	53                   	push   %ebx
     852:	51                   	push   %ecx
     853:	52                   	push   %edx
     854:	8d 55 d4             	lea    -0x2c(%ebp),%edx
     857:	52                   	push   %edx
     858:	50                   	push   %eax
     859:	68 65 1d 00 00       	push   $0x1d65
     85e:	6a 02                	push   $0x2
     860:	e8 84 10 00 00       	call   18e9 <printf>
     865:	83 c4 20             	add    $0x20,%esp
			}
			currentProc = currentProc->nextProcess;
     868:	8b 45 f0             	mov    -0x10(%ebp),%eax
     86b:	8b 40 04             	mov    0x4(%eax),%eax
     86e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		return;
	}
	while (currentJob!=0){
		struct jobprocess* currentProc = currentJob->headOfProcesses;
		printf(2, "Job %d: %s", currentJob->id, currentJob->cmd);
		while (currentProc != 0 ){
     871:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     875:	75 a9                	jne    820 <printAllJobs+0x56>
			if (pstat(currentProc->pid, &stat) == 0){
				printf(2, "%d: %s %d %d %s\n", currentProc->pid, stat.name, stat.sz, stat.nofile, states[stat.state]);
			}
			currentProc = currentProc->nextProcess;
		}
		currentJob = currentJob->nextjob;
     877:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87a:	8b 40 04             	mov    0x4(%eax),%eax
     87d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job* currentJob = head;
	if (head == 0) {
		printf(2, "There are no jobs\n");
		return;
	}
	while (currentJob!=0){
     880:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     884:	0f 85 6f ff ff ff    	jne    7f9 <printAllJobs+0x2f>
			}
			currentProc = currentProc->nextProcess;
		}
		currentJob = currentJob->nextjob;
	}
	return;
     88a:	90                   	nop
}
     88b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     88e:	c9                   	leave  
     88f:	c3                   	ret    

00000890 <addProcessToJob>:

void addProcessToJob(struct job *job , int pid){
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	83 ec 18             	sub    $0x18,%esp
	struct jobprocess *newProcess = getProcess(pid);
     896:	83 ec 0c             	sub    $0xc,%esp
     899:	ff 75 0c             	pushl  0xc(%ebp)
     89c:	e8 56 03 00 00       	call   bf7 <getProcess>
     8a1:	83 c4 10             	add    $0x10,%esp
     8a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	newProcess->nextProcess = job->headOfProcesses;
     8a7:	8b 45 08             	mov    0x8(%ebp),%eax
     8aa:	8b 50 08             	mov    0x8(%eax),%edx
     8ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b0:	89 50 04             	mov    %edx,0x4(%eax)
	job->headOfProcesses = newProcess;
     8b3:	8b 45 08             	mov    0x8(%ebp),%eax
     8b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8b9:	89 50 08             	mov    %edx,0x8(%eax)
}
     8bc:	c9                   	leave  
     8bd:	c3                   	ret    

000008be <findJobById>:

struct job *findJobById(struct job *head , int pid){
     8be:	55                   	push   %ebp
     8bf:	89 e5                	mov    %esp,%ebp
     8c1:	83 ec 10             	sub    $0x10,%esp
	struct job* currentJob = head;
     8c4:	8b 45 08             	mov    0x8(%ebp),%eax
     8c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (head == 0) {
     8ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     8ce:	75 05                	jne    8d5 <findJobById+0x17>
		return head;
     8d0:	8b 45 08             	mov    0x8(%ebp),%eax
     8d3:	eb 20                	jmp    8f5 <findJobById+0x37>
	}
	while (currentJob != 0){
     8d5:	eb 15                	jmp    8ec <findJobById+0x2e>
		if (currentJob->id == pid){
     8d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8da:	8b 00                	mov    (%eax),%eax
     8dc:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8df:	75 02                	jne    8e3 <findJobById+0x25>
			break;
     8e1:	eb 0f                	jmp    8f2 <findJobById+0x34>
		}
		currentJob = currentJob->nextjob;
     8e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8e6:	8b 40 04             	mov    0x4(%eax),%eax
     8e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
struct job *findJobById(struct job *head , int pid){
	struct job* currentJob = head;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
     8ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     8f0:	75 e5                	jne    8d7 <findJobById+0x19>
		if (currentJob->id == pid){
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return currentJob;
     8f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     8f5:	c9                   	leave  
     8f6:	c3                   	ret    

000008f7 <findForegroundJob>:

struct job *findForegroundJob(struct job *head){
     8f7:	55                   	push   %ebp
     8f8:	89 e5                	mov    %esp,%ebp
     8fa:	83 ec 10             	sub    $0x10,%esp
	struct job* currentJob = head;
     8fd:	8b 45 08             	mov    0x8(%ebp),%eax
     900:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct job* foregroundJob = 0;
     903:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	if (head == 0) {
     90a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     90e:	75 05                	jne    915 <findForegroundJob+0x1e>
		return head;
     910:	8b 45 08             	mov    0x8(%ebp),%eax
     913:	eb 27                	jmp    93c <findForegroundJob+0x45>
	}
	while (currentJob != 0){
     915:	eb 1c                	jmp    933 <findForegroundJob+0x3c>
		if (currentJob->type == FOREGROUND){
     917:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91a:	8b 40 10             	mov    0x10(%eax),%eax
     91d:	83 f8 01             	cmp    $0x1,%eax
     920:	75 08                	jne    92a <findForegroundJob+0x33>
			foregroundJob = currentJob;
     922:	8b 45 fc             	mov    -0x4(%ebp),%eax
     925:	89 45 f8             	mov    %eax,-0x8(%ebp)
			break;
     928:	eb 0f                	jmp    939 <findForegroundJob+0x42>
		}
		currentJob = currentJob->nextjob;
     92a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     92d:	8b 40 04             	mov    0x4(%eax),%eax
     930:	89 45 fc             	mov    %eax,-0x4(%ebp)
	struct job* currentJob = head;
	struct job* foregroundJob = 0;
	if (head == 0) {
		return head;
	}
	while (currentJob != 0){
     933:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
     937:	75 de                	jne    917 <findForegroundJob+0x20>
			foregroundJob = currentJob;
			break;
		}
		currentJob = currentJob->nextjob;
	}
	return foregroundJob;
     939:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     93c:	c9                   	leave  
     93d:	c3                   	ret    

0000093e <clearJobList>:

struct job *clearJobList(struct job *head){
     93e:	55                   	push   %ebp
     93f:	89 e5                	mov    %esp,%ebp
     941:	83 ec 18             	sub    $0x18,%esp
	if (head == 0){
     944:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     948:	75 08                	jne    952 <clearJobList+0x14>
		return head;
     94a:	8b 45 08             	mov    0x8(%ebp),%eax
     94d:	e9 21 01 00 00       	jmp    a73 <clearJobList+0x135>
	}

	struct job *currentJob = head;
     952:	8b 45 08             	mov    0x8(%ebp),%eax
     955:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct job *newHead = 0;
     958:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	while (newHead == 0 && currentJob != 0){
     95f:	eb 5b                	jmp    9bc <clearJobList+0x7e>
		struct job *temp = currentJob->nextjob;
     961:	8b 45 f4             	mov    -0xc(%ebp),%eax
     964:	8b 40 04             	mov    0x4(%eax),%eax
     967:	89 45 e8             	mov    %eax,-0x18(%ebp)
		currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
     96a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     96d:	8b 40 08             	mov    0x8(%eax),%eax
     970:	83 ec 0c             	sub    $0xc,%esp
     973:	50                   	push   %eax
     974:	e8 fc 00 00 00       	call   a75 <clearZombieProcesses>
     979:	83 c4 10             	add    $0x10,%esp
     97c:	89 c2                	mov    %eax,%edx
     97e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     981:	89 50 08             	mov    %edx,0x8(%eax)
		if (currentJob->headOfProcesses == 0){
     984:	8b 45 f4             	mov    -0xc(%ebp),%eax
     987:	8b 40 08             	mov    0x8(%eax),%eax
     98a:	85 c0                	test   %eax,%eax
     98c:	75 22                	jne    9b0 <clearJobList+0x72>
			free(currentJob->cmd);
     98e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     991:	8b 40 14             	mov    0x14(%eax),%eax
     994:	83 ec 0c             	sub    $0xc,%esp
     997:	50                   	push   %eax
     998:	e8 dc 10 00 00       	call   1a79 <free>
     99d:	83 c4 10             	add    $0x10,%esp
			free(currentJob);
     9a0:	83 ec 0c             	sub    $0xc,%esp
     9a3:	ff 75 f4             	pushl  -0xc(%ebp)
     9a6:	e8 ce 10 00 00       	call   1a79 <free>
     9ab:	83 c4 10             	add    $0x10,%esp
     9ae:	eb 06                	jmp    9b6 <clearJobList+0x78>
		}
		else {
			newHead = currentJob;
     9b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		}
		currentJob = temp;
     9b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	}

	struct job *currentJob = head;
	struct job *newHead = 0;

	while (newHead == 0 && currentJob != 0){
     9bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9c0:	75 06                	jne    9c8 <clearJobList+0x8a>
     9c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     9c6:	75 99                	jne    961 <clearJobList+0x23>
			newHead = currentJob;
		}
		currentJob = temp;
	}

	if(newHead != 0){
     9c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9cc:	0f 84 9e 00 00 00    	je     a70 <clearJobList+0x132>
		currentJob = newHead->nextjob;
     9d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9d5:	8b 40 04             	mov    0x4(%eax),%eax
     9d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		struct job *prevJob = newHead;
     9db:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9de:	89 45 ec             	mov    %eax,-0x14(%ebp)

		while (currentJob != 0){
     9e1:	e9 80 00 00 00       	jmp    a66 <clearJobList+0x128>
			currentJob->headOfProcesses = clearZombieProcesses(currentJob->headOfProcesses);
     9e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9e9:	8b 40 08             	mov    0x8(%eax),%eax
     9ec:	83 ec 0c             	sub    $0xc,%esp
     9ef:	50                   	push   %eax
     9f0:	e8 80 00 00 00       	call   a75 <clearZombieProcesses>
     9f5:	83 c4 10             	add    $0x10,%esp
     9f8:	89 c2                	mov    %eax,%edx
     9fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fd:	89 50 08             	mov    %edx,0x8(%eax)
			if (currentJob->headOfProcesses == 0){
     a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a03:	8b 40 08             	mov    0x8(%eax),%eax
     a06:	85 c0                	test   %eax,%eax
     a08:	75 4d                	jne    a57 <clearJobList+0x119>
				prevJob->nextjob = currentJob->nextjob;
     a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0d:	8b 50 04             	mov    0x4(%eax),%edx
     a10:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a13:	89 50 04             	mov    %edx,0x4(%eax)
				free(currentJob->cmd);
     a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a19:	8b 40 14             	mov    0x14(%eax),%eax
     a1c:	83 ec 0c             	sub    $0xc,%esp
     a1f:	50                   	push   %eax
     a20:	e8 54 10 00 00       	call   1a79 <free>
     a25:	83 c4 10             	add    $0x10,%esp
				free(currentJob);
     a28:	83 ec 0c             	sub    $0xc,%esp
     a2b:	ff 75 f4             	pushl  -0xc(%ebp)
     a2e:	e8 46 10 00 00       	call   1a79 <free>
     a33:	83 c4 10             	add    $0x10,%esp
				if (prevJob->nextjob != 0){
     a36:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a39:	8b 40 04             	mov    0x4(%eax),%eax
     a3c:	85 c0                	test   %eax,%eax
     a3e:	74 0e                	je     a4e <clearJobList+0x110>
					currentJob = prevJob->nextjob->nextjob;
     a40:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a43:	8b 40 04             	mov    0x4(%eax),%eax
     a46:	8b 40 04             	mov    0x4(%eax),%eax
     a49:	89 45 f4             	mov    %eax,-0xc(%ebp)
     a4c:	eb 18                	jmp    a66 <clearJobList+0x128>
				}
				else {
					currentJob = 0;
     a4e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a55:	eb 0f                	jmp    a66 <clearJobList+0x128>
				}
			}
			else {
				prevJob = currentJob;
     a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5a:	89 45 ec             	mov    %eax,-0x14(%ebp)
				currentJob = currentJob->nextjob;
     a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a60:	8b 40 04             	mov    0x4(%eax),%eax
     a63:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if(newHead != 0){
		currentJob = newHead->nextjob;
		struct job *prevJob = newHead;

		while (currentJob != 0){
     a66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a6a:	0f 85 76 ff ff ff    	jne    9e6 <clearJobList+0xa8>
				prevJob = currentJob;
				currentJob = currentJob->nextjob;
			}
		}
	}
	return newHead;
     a70:	8b 45 f0             	mov    -0x10(%ebp),%eax

}
     a73:	c9                   	leave  
     a74:	c3                   	ret    

00000a75 <clearZombieProcesses>:

struct jobprocess *clearZombieProcesses(struct jobprocess *head){
     a75:	55                   	push   %ebp
     a76:	89 e5                	mov    %esp,%ebp
     a78:	83 ec 58             	sub    $0x58,%esp
	struct jobprocess *currentProcess = head;
     a7b:	8b 45 08             	mov    0x8(%ebp),%eax
     a7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	struct jobprocess *newHead = 0;
     a81:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	if (head == 0){
     a88:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     a8c:	75 08                	jne    a96 <clearZombieProcesses+0x21>
		return head;
     a8e:	8b 45 08             	mov    0x8(%ebp),%eax
     a91:	e9 cc 00 00 00       	jmp    b62 <clearZombieProcesses+0xed>
	}

	while (newHead == 0  && currentProcess != 0){
     a96:	eb 46                	jmp    ade <clearZombieProcesses+0x69>
		struct jobprocess *temp = currentProcess->nextProcess;
     a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9b:	8b 40 04             	mov    0x4(%eax),%eax
     a9e:	89 45 e8             	mov    %eax,-0x18(%ebp)
		struct procstat stat;

		if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
     aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa4:	8b 00                	mov    (%eax),%eax
     aa6:	83 ec 08             	sub    $0x8,%esp
     aa9:	8d 55 cc             	lea    -0x34(%ebp),%edx
     aac:	52                   	push   %edx
     aad:	50                   	push   %eax
     aae:	e8 59 0d 00 00       	call   180c <pstat>
     ab3:	83 c4 10             	add    $0x10,%esp
     ab6:	85 c0                	test   %eax,%eax
     ab8:	78 08                	js     ac2 <clearZombieProcesses+0x4d>
     aba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     abd:	83 f8 05             	cmp    $0x5,%eax
     ac0:	75 10                	jne    ad2 <clearZombieProcesses+0x5d>
			free(currentProcess);
     ac2:	83 ec 0c             	sub    $0xc,%esp
     ac5:	ff 75 f4             	pushl  -0xc(%ebp)
     ac8:	e8 ac 0f 00 00       	call   1a79 <free>
     acd:	83 c4 10             	add    $0x10,%esp
     ad0:	eb 06                	jmp    ad8 <clearZombieProcesses+0x63>
		}
		else {
			newHead = currentProcess;
     ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		}
		currentProcess = temp;
     ad8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     adb:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if (head == 0){
		return head;
	}

	while (newHead == 0  && currentProcess != 0){
     ade:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ae2:	75 06                	jne    aea <clearZombieProcesses+0x75>
     ae4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ae8:	75 ae                	jne    a98 <clearZombieProcesses+0x23>
			newHead = currentProcess;
		}
		currentProcess = temp;
	}

	if(newHead != 0){
     aea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     aee:	74 6f                	je     b5f <clearZombieProcesses+0xea>
		currentProcess = newHead->nextProcess;
     af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af3:	8b 40 04             	mov    0x4(%eax),%eax
     af6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		struct jobprocess *prevProcess = newHead;
     af9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     afc:	89 45 ec             	mov    %eax,-0x14(%ebp)

		while (currentProcess != 0){
     aff:	eb 58                	jmp    b59 <clearZombieProcesses+0xe4>
			struct procstat stat;

			if (pstat(currentProcess->pid , &stat) < 0 || stat.state == ZOMBIE){
     b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b04:	8b 00                	mov    (%eax),%eax
     b06:	83 ec 08             	sub    $0x8,%esp
     b09:	8d 55 b0             	lea    -0x50(%ebp),%edx
     b0c:	52                   	push   %edx
     b0d:	50                   	push   %eax
     b0e:	e8 f9 0c 00 00       	call   180c <pstat>
     b13:	83 c4 10             	add    $0x10,%esp
     b16:	85 c0                	test   %eax,%eax
     b18:	78 08                	js     b22 <clearZombieProcesses+0xad>
     b1a:	8b 45 c8             	mov    -0x38(%ebp),%eax
     b1d:	83 f8 05             	cmp    $0x5,%eax
     b20:	75 28                	jne    b4a <clearZombieProcesses+0xd5>
				prevProcess->nextProcess = currentProcess->nextProcess;
     b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b25:	8b 50 04             	mov    0x4(%eax),%edx
     b28:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b2b:	89 50 04             	mov    %edx,0x4(%eax)
				free(currentProcess);
     b2e:	83 ec 0c             	sub    $0xc,%esp
     b31:	ff 75 f4             	pushl  -0xc(%ebp)
     b34:	e8 40 0f 00 00       	call   1a79 <free>
     b39:	83 c4 10             	add    $0x10,%esp
				currentProcess = prevProcess->nextProcess->nextProcess;
     b3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b3f:	8b 40 04             	mov    0x4(%eax),%eax
     b42:	8b 40 04             	mov    0x4(%eax),%eax
     b45:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b48:	eb 0f                	jmp    b59 <clearZombieProcesses+0xe4>
			}
			else {
				prevProcess = currentProcess;
     b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
				currentProcess = currentProcess->nextProcess;
     b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b53:	8b 40 04             	mov    0x4(%eax),%eax
     b56:	89 45 f4             	mov    %eax,-0xc(%ebp)

	if(newHead != 0){
		currentProcess = newHead->nextProcess;
		struct jobprocess *prevProcess = newHead;

		while (currentProcess != 0){
     b59:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b5d:	75 a2                	jne    b01 <clearZombieProcesses+0x8c>
				prevProcess = currentProcess;
				currentProcess = currentProcess->nextProcess;
			}
		}
	}
	return newHead;
     b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b62:	c9                   	leave  
     b63:	c3                   	ret    

00000b64 <getJob>:


struct job *getJob(int jobId , int inputFd, char* buf){
     b64:	55                   	push   %ebp
     b65:	89 e5                	mov    %esp,%ebp
     b67:	83 ec 18             	sub    $0x18,%esp
	struct job *newJob;

	newJob = malloc(sizeof(*newJob));
     b6a:	83 ec 0c             	sub    $0xc,%esp
     b6d:	6a 18                	push   $0x18
     b6f:	e8 46 10 00 00       	call   1bba <malloc>
     b74:	83 c4 10             	add    $0x10,%esp
     b77:	89 45 f4             	mov    %eax,-0xc(%ebp)
	memset(newJob, 0, sizeof(*newJob));
     b7a:	83 ec 04             	sub    $0x4,%esp
     b7d:	6a 18                	push   $0x18
     b7f:	6a 00                	push   $0x0
     b81:	ff 75 f4             	pushl  -0xc(%ebp)
     b84:	e8 49 0a 00 00       	call   15d2 <memset>
     b89:	83 c4 10             	add    $0x10,%esp
	newJob->id = jobId;
     b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b8f:	8b 55 08             	mov    0x8(%ebp),%edx
     b92:	89 10                	mov    %edx,(%eax)
	newJob->nextjob = 0;// NULL
     b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b97:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
	newJob->headOfProcesses = 0; //NULL
     b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	newJob->jobInFd = inputFd ;
     ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bab:	8b 55 0c             	mov    0xc(%ebp),%edx
     bae:	89 50 0c             	mov    %edx,0xc(%eax)
	newJob->type = FOREGROUND;
     bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb4:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
	newJob->cmd = malloc(strlen(buf));
     bbb:	83 ec 0c             	sub    $0xc,%esp
     bbe:	ff 75 10             	pushl  0x10(%ebp)
     bc1:	e8 e5 09 00 00       	call   15ab <strlen>
     bc6:	83 c4 10             	add    $0x10,%esp
     bc9:	83 ec 0c             	sub    $0xc,%esp
     bcc:	50                   	push   %eax
     bcd:	e8 e8 0f 00 00       	call   1bba <malloc>
     bd2:	83 c4 10             	add    $0x10,%esp
     bd5:	89 c2                	mov    %eax,%edx
     bd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bda:	89 50 14             	mov    %edx,0x14(%eax)
	strcpy(newJob->cmd, buf);
     bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be0:	8b 40 14             	mov    0x14(%eax),%eax
     be3:	83 ec 08             	sub    $0x8,%esp
     be6:	ff 75 10             	pushl  0x10(%ebp)
     be9:	50                   	push   %eax
     bea:	e8 4d 09 00 00       	call   153c <strcpy>
     bef:	83 c4 10             	add    $0x10,%esp
	return newJob;
     bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bf5:	c9                   	leave  
     bf6:	c3                   	ret    

00000bf7 <getProcess>:

struct jobprocess *getProcess(int pid){
     bf7:	55                   	push   %ebp
     bf8:	89 e5                	mov    %esp,%ebp
     bfa:	83 ec 18             	sub    $0x18,%esp
	struct jobprocess *newProcess;

	newProcess = malloc(sizeof(*newProcess));
     bfd:	83 ec 0c             	sub    $0xc,%esp
     c00:	6a 08                	push   $0x8
     c02:	e8 b3 0f 00 00       	call   1bba <malloc>
     c07:	83 c4 10             	add    $0x10,%esp
     c0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	memset(newProcess, 0, sizeof(*newProcess));
     c0d:	83 ec 04             	sub    $0x4,%esp
     c10:	6a 08                	push   $0x8
     c12:	6a 00                	push   $0x0
     c14:	ff 75 f4             	pushl  -0xc(%ebp)
     c17:	e8 b6 09 00 00       	call   15d2 <memset>
     c1c:	83 c4 10             	add    $0x10,%esp
	newProcess->pid = pid;
     c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c22:	8b 55 08             	mov    0x8(%ebp),%edx
     c25:	89 10                	mov    %edx,(%eax)
	newProcess->nextProcess = 0;
     c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	return newProcess;
     c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c34:	c9                   	leave  
     c35:	c3                   	ret    

00000c36 <panic>:

void
panic(char *s)
{
     c36:	55                   	push   %ebp
     c37:	89 e5                	mov    %esp,%ebp
     c39:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     c3c:	83 ec 04             	sub    $0x4,%esp
     c3f:	ff 75 08             	pushl  0x8(%ebp)
     c42:	68 76 1d 00 00       	push   $0x1d76
     c47:	6a 02                	push   $0x2
     c49:	e8 9b 0c 00 00       	call   18e9 <printf>
     c4e:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
     c51:	83 ec 0c             	sub    $0xc,%esp
     c54:	6a 01                	push   $0x1
     c56:	e8 11 0b 00 00       	call   176c <exit>

00000c5b <fork1>:
}

int
fork1(void)
{
     c5b:	55                   	push   %ebp
     c5c:	89 e5                	mov    %esp,%ebp
     c5e:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     c61:	e8 fe 0a 00 00       	call   1764 <fork>
     c66:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     c69:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     c6d:	75 10                	jne    c7f <fork1+0x24>
    panic("fork");
     c6f:	83 ec 0c             	sub    $0xc,%esp
     c72:	68 7a 1d 00 00       	push   $0x1d7a
     c77:	e8 ba ff ff ff       	call   c36 <panic>
     c7c:	83 c4 10             	add    $0x10,%esp
  return pid;
     c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c82:	c9                   	leave  
     c83:	c3                   	ret    

00000c84 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     c84:	55                   	push   %ebp
     c85:	89 e5                	mov    %esp,%ebp
     c87:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     c8a:	83 ec 0c             	sub    $0xc,%esp
     c8d:	6a 54                	push   $0x54
     c8f:	e8 26 0f 00 00       	call   1bba <malloc>
     c94:	83 c4 10             	add    $0x10,%esp
     c97:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     c9a:	83 ec 04             	sub    $0x4,%esp
     c9d:	6a 54                	push   $0x54
     c9f:	6a 00                	push   $0x0
     ca1:	ff 75 f4             	pushl  -0xc(%ebp)
     ca4:	e8 29 09 00 00       	call   15d2 <memset>
     ca9:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     cac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     caf:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     cb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     cb8:	c9                   	leave  
     cb9:	c3                   	ret    

00000cba <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     cba:	55                   	push   %ebp
     cbb:	89 e5                	mov    %esp,%ebp
     cbd:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     cc0:	83 ec 0c             	sub    $0xc,%esp
     cc3:	6a 18                	push   $0x18
     cc5:	e8 f0 0e 00 00       	call   1bba <malloc>
     cca:	83 c4 10             	add    $0x10,%esp
     ccd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     cd0:	83 ec 04             	sub    $0x4,%esp
     cd3:	6a 18                	push   $0x18
     cd5:	6a 00                	push   $0x0
     cd7:	ff 75 f4             	pushl  -0xc(%ebp)
     cda:	e8 f3 08 00 00       	call   15d2 <memset>
     cdf:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     ce2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce5:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cee:	8b 55 08             	mov    0x8(%ebp),%edx
     cf1:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cf7:	8b 55 0c             	mov    0xc(%ebp),%edx
     cfa:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d00:	8b 55 10             	mov    0x10(%ebp),%edx
     d03:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     d06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d09:	8b 55 14             	mov    0x14(%ebp),%edx
     d0c:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     d0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d12:	8b 55 18             	mov    0x18(%ebp),%edx
     d15:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d1b:	c9                   	leave  
     d1c:	c3                   	ret    

00000d1d <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     d1d:	55                   	push   %ebp
     d1e:	89 e5                	mov    %esp,%ebp
     d20:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     d23:	83 ec 0c             	sub    $0xc,%esp
     d26:	6a 0c                	push   $0xc
     d28:	e8 8d 0e 00 00       	call   1bba <malloc>
     d2d:	83 c4 10             	add    $0x10,%esp
     d30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     d33:	83 ec 04             	sub    $0x4,%esp
     d36:	6a 0c                	push   $0xc
     d38:	6a 00                	push   $0x0
     d3a:	ff 75 f4             	pushl  -0xc(%ebp)
     d3d:	e8 90 08 00 00       	call   15d2 <memset>
     d42:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     d45:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d48:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     d4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d51:	8b 55 08             	mov    0x8(%ebp),%edx
     d54:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5a:	8b 55 0c             	mov    0xc(%ebp),%edx
     d5d:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     d63:	c9                   	leave  
     d64:	c3                   	ret    

00000d65 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     d65:	55                   	push   %ebp
     d66:	89 e5                	mov    %esp,%ebp
     d68:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     d6b:	83 ec 0c             	sub    $0xc,%esp
     d6e:	6a 0c                	push   $0xc
     d70:	e8 45 0e 00 00       	call   1bba <malloc>
     d75:	83 c4 10             	add    $0x10,%esp
     d78:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     d7b:	83 ec 04             	sub    $0x4,%esp
     d7e:	6a 0c                	push   $0xc
     d80:	6a 00                	push   $0x0
     d82:	ff 75 f4             	pushl  -0xc(%ebp)
     d85:	e8 48 08 00 00       	call   15d2 <memset>
     d8a:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     d8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d90:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d99:	8b 55 08             	mov    0x8(%ebp),%edx
     d9c:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da2:	8b 55 0c             	mov    0xc(%ebp),%edx
     da5:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     da8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dab:	c9                   	leave  
     dac:	c3                   	ret    

00000dad <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     dad:	55                   	push   %ebp
     dae:	89 e5                	mov    %esp,%ebp
     db0:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     db3:	83 ec 0c             	sub    $0xc,%esp
     db6:	6a 08                	push   $0x8
     db8:	e8 fd 0d 00 00       	call   1bba <malloc>
     dbd:	83 c4 10             	add    $0x10,%esp
     dc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     dc3:	83 ec 04             	sub    $0x4,%esp
     dc6:	6a 08                	push   $0x8
     dc8:	6a 00                	push   $0x0
     dca:	ff 75 f4             	pushl  -0xc(%ebp)
     dcd:	e8 00 08 00 00       	call   15d2 <memset>
     dd2:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     dd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dd8:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     dde:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de1:	8b 55 08             	mov    0x8(%ebp),%edx
     de4:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     de7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dea:	c9                   	leave  
     deb:	c3                   	ret    

00000dec <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     dec:	55                   	push   %ebp
     ded:	89 e5                	mov    %esp,%ebp
     def:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     df2:	8b 45 08             	mov    0x8(%ebp),%eax
     df5:	8b 00                	mov    (%eax),%eax
     df7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     dfa:	eb 04                	jmp    e00 <gettoken+0x14>
    s++;
     dfc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e03:	3b 45 0c             	cmp    0xc(%ebp),%eax
     e06:	73 1e                	jae    e26 <gettoken+0x3a>
     e08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e0b:	0f b6 00             	movzbl (%eax),%eax
     e0e:	0f be c0             	movsbl %al,%eax
     e11:	83 ec 08             	sub    $0x8,%esp
     e14:	50                   	push   %eax
     e15:	68 d4 23 00 00       	push   $0x23d4
     e1a:	e8 cd 07 00 00       	call   15ec <strchr>
     e1f:	83 c4 10             	add    $0x10,%esp
     e22:	85 c0                	test   %eax,%eax
     e24:	75 d6                	jne    dfc <gettoken+0x10>
    s++;
  if(q)
     e26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     e2a:	74 08                	je     e34 <gettoken+0x48>
    *q = s;
     e2c:	8b 45 10             	mov    0x10(%ebp),%eax
     e2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e32:	89 10                	mov    %edx,(%eax)
  ret = *s;
     e34:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e37:	0f b6 00             	movzbl (%eax),%eax
     e3a:	0f be c0             	movsbl %al,%eax
     e3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     e40:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e43:	0f b6 00             	movzbl (%eax),%eax
     e46:	0f be c0             	movsbl %al,%eax
     e49:	83 f8 29             	cmp    $0x29,%eax
     e4c:	7f 14                	jg     e62 <gettoken+0x76>
     e4e:	83 f8 28             	cmp    $0x28,%eax
     e51:	7d 28                	jge    e7b <gettoken+0x8f>
     e53:	85 c0                	test   %eax,%eax
     e55:	0f 84 96 00 00 00    	je     ef1 <gettoken+0x105>
     e5b:	83 f8 26             	cmp    $0x26,%eax
     e5e:	74 1b                	je     e7b <gettoken+0x8f>
     e60:	eb 3c                	jmp    e9e <gettoken+0xb2>
     e62:	83 f8 3e             	cmp    $0x3e,%eax
     e65:	74 1a                	je     e81 <gettoken+0x95>
     e67:	83 f8 3e             	cmp    $0x3e,%eax
     e6a:	7f 0a                	jg     e76 <gettoken+0x8a>
     e6c:	83 e8 3b             	sub    $0x3b,%eax
     e6f:	83 f8 01             	cmp    $0x1,%eax
     e72:	77 2a                	ja     e9e <gettoken+0xb2>
     e74:	eb 05                	jmp    e7b <gettoken+0x8f>
     e76:	83 f8 7c             	cmp    $0x7c,%eax
     e79:	75 23                	jne    e9e <gettoken+0xb2>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     e7b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     e7f:	eb 71                	jmp    ef2 <gettoken+0x106>
  case '>':
    s++;
     e81:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     e85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e88:	0f b6 00             	movzbl (%eax),%eax
     e8b:	3c 3e                	cmp    $0x3e,%al
     e8d:	75 0d                	jne    e9c <gettoken+0xb0>
      ret = '+';
     e8f:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     e96:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     e9a:	eb 56                	jmp    ef2 <gettoken+0x106>
     e9c:	eb 54                	jmp    ef2 <gettoken+0x106>
  default:
    ret = 'a';
     e9e:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     ea5:	eb 04                	jmp    eab <gettoken+0xbf>
      s++;
     ea7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     eab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eae:	3b 45 0c             	cmp    0xc(%ebp),%eax
     eb1:	73 3c                	jae    eef <gettoken+0x103>
     eb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eb6:	0f b6 00             	movzbl (%eax),%eax
     eb9:	0f be c0             	movsbl %al,%eax
     ebc:	83 ec 08             	sub    $0x8,%esp
     ebf:	50                   	push   %eax
     ec0:	68 d4 23 00 00       	push   $0x23d4
     ec5:	e8 22 07 00 00       	call   15ec <strchr>
     eca:	83 c4 10             	add    $0x10,%esp
     ecd:	85 c0                	test   %eax,%eax
     ecf:	75 1e                	jne    eef <gettoken+0x103>
     ed1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ed4:	0f b6 00             	movzbl (%eax),%eax
     ed7:	0f be c0             	movsbl %al,%eax
     eda:	83 ec 08             	sub    $0x8,%esp
     edd:	50                   	push   %eax
     ede:	68 da 23 00 00       	push   $0x23da
     ee3:	e8 04 07 00 00       	call   15ec <strchr>
     ee8:	83 c4 10             	add    $0x10,%esp
     eeb:	85 c0                	test   %eax,%eax
     eed:	74 b8                	je     ea7 <gettoken+0xbb>
      s++;
    break;
     eef:	eb 01                	jmp    ef2 <gettoken+0x106>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     ef1:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     ef2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     ef6:	74 08                	je     f00 <gettoken+0x114>
    *eq = s;
     ef8:	8b 45 14             	mov    0x14(%ebp),%eax
     efb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     efe:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     f00:	eb 04                	jmp    f06 <gettoken+0x11a>
    s++;
     f02:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     f06:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f09:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f0c:	73 1e                	jae    f2c <gettoken+0x140>
     f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f11:	0f b6 00             	movzbl (%eax),%eax
     f14:	0f be c0             	movsbl %al,%eax
     f17:	83 ec 08             	sub    $0x8,%esp
     f1a:	50                   	push   %eax
     f1b:	68 d4 23 00 00       	push   $0x23d4
     f20:	e8 c7 06 00 00       	call   15ec <strchr>
     f25:	83 c4 10             	add    $0x10,%esp
     f28:	85 c0                	test   %eax,%eax
     f2a:	75 d6                	jne    f02 <gettoken+0x116>
    s++;
  *ps = s;
     f2c:	8b 45 08             	mov    0x8(%ebp),%eax
     f2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f32:	89 10                	mov    %edx,(%eax)
  return ret;
     f34:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     f37:	c9                   	leave  
     f38:	c3                   	ret    

00000f39 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     f39:	55                   	push   %ebp
     f3a:	89 e5                	mov    %esp,%ebp
     f3c:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     f3f:	8b 45 08             	mov    0x8(%ebp),%eax
     f42:	8b 00                	mov    (%eax),%eax
     f44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     f47:	eb 04                	jmp    f4d <peek+0x14>
    s++;
     f49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     f4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f50:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f53:	73 1e                	jae    f73 <peek+0x3a>
     f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f58:	0f b6 00             	movzbl (%eax),%eax
     f5b:	0f be c0             	movsbl %al,%eax
     f5e:	83 ec 08             	sub    $0x8,%esp
     f61:	50                   	push   %eax
     f62:	68 d4 23 00 00       	push   $0x23d4
     f67:	e8 80 06 00 00       	call   15ec <strchr>
     f6c:	83 c4 10             	add    $0x10,%esp
     f6f:	85 c0                	test   %eax,%eax
     f71:	75 d6                	jne    f49 <peek+0x10>
    s++;
  *ps = s;
     f73:	8b 45 08             	mov    0x8(%ebp),%eax
     f76:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f79:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     f7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f7e:	0f b6 00             	movzbl (%eax),%eax
     f81:	84 c0                	test   %al,%al
     f83:	74 23                	je     fa8 <peek+0x6f>
     f85:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f88:	0f b6 00             	movzbl (%eax),%eax
     f8b:	0f be c0             	movsbl %al,%eax
     f8e:	83 ec 08             	sub    $0x8,%esp
     f91:	50                   	push   %eax
     f92:	ff 75 10             	pushl  0x10(%ebp)
     f95:	e8 52 06 00 00       	call   15ec <strchr>
     f9a:	83 c4 10             	add    $0x10,%esp
     f9d:	85 c0                	test   %eax,%eax
     f9f:	74 07                	je     fa8 <peek+0x6f>
     fa1:	b8 01 00 00 00       	mov    $0x1,%eax
     fa6:	eb 05                	jmp    fad <peek+0x74>
     fa8:	b8 00 00 00 00       	mov    $0x0,%eax
}
     fad:	c9                   	leave  
     fae:	c3                   	ret    

00000faf <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     faf:	55                   	push   %ebp
     fb0:	89 e5                	mov    %esp,%ebp
     fb2:	53                   	push   %ebx
     fb3:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     fb6:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fb9:	8b 45 08             	mov    0x8(%ebp),%eax
     fbc:	83 ec 0c             	sub    $0xc,%esp
     fbf:	50                   	push   %eax
     fc0:	e8 e6 05 00 00       	call   15ab <strlen>
     fc5:	83 c4 10             	add    $0x10,%esp
     fc8:	01 d8                	add    %ebx,%eax
     fca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     fcd:	83 ec 08             	sub    $0x8,%esp
     fd0:	ff 75 f4             	pushl  -0xc(%ebp)
     fd3:	8d 45 08             	lea    0x8(%ebp),%eax
     fd6:	50                   	push   %eax
     fd7:	e8 61 00 00 00       	call   103d <parseline>
     fdc:	83 c4 10             	add    $0x10,%esp
     fdf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     fe2:	83 ec 04             	sub    $0x4,%esp
     fe5:	68 7f 1d 00 00       	push   $0x1d7f
     fea:	ff 75 f4             	pushl  -0xc(%ebp)
     fed:	8d 45 08             	lea    0x8(%ebp),%eax
     ff0:	50                   	push   %eax
     ff1:	e8 43 ff ff ff       	call   f39 <peek>
     ff6:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     ff9:	8b 45 08             	mov    0x8(%ebp),%eax
     ffc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     fff:	74 26                	je     1027 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
    1001:	8b 45 08             	mov    0x8(%ebp),%eax
    1004:	83 ec 04             	sub    $0x4,%esp
    1007:	50                   	push   %eax
    1008:	68 80 1d 00 00       	push   $0x1d80
    100d:	6a 02                	push   $0x2
    100f:	e8 d5 08 00 00       	call   18e9 <printf>
    1014:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
    1017:	83 ec 0c             	sub    $0xc,%esp
    101a:	68 8f 1d 00 00       	push   $0x1d8f
    101f:	e8 12 fc ff ff       	call   c36 <panic>
    1024:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
    1027:	83 ec 0c             	sub    $0xc,%esp
    102a:	ff 75 f0             	pushl  -0x10(%ebp)
    102d:	e8 e9 03 00 00       	call   141b <nulterminate>
    1032:	83 c4 10             	add    $0x10,%esp
  return cmd;
    1035:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1038:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    103b:	c9                   	leave  
    103c:	c3                   	ret    

0000103d <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
    103d:	55                   	push   %ebp
    103e:	89 e5                	mov    %esp,%ebp
    1040:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
    1043:	83 ec 08             	sub    $0x8,%esp
    1046:	ff 75 0c             	pushl  0xc(%ebp)
    1049:	ff 75 08             	pushl  0x8(%ebp)
    104c:	e8 99 00 00 00       	call   10ea <parsepipe>
    1051:	83 c4 10             	add    $0x10,%esp
    1054:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
    1057:	eb 23                	jmp    107c <parseline+0x3f>
    gettoken(ps, es, 0, 0);
    1059:	6a 00                	push   $0x0
    105b:	6a 00                	push   $0x0
    105d:	ff 75 0c             	pushl  0xc(%ebp)
    1060:	ff 75 08             	pushl  0x8(%ebp)
    1063:	e8 84 fd ff ff       	call   dec <gettoken>
    1068:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
    106b:	83 ec 0c             	sub    $0xc,%esp
    106e:	ff 75 f4             	pushl  -0xc(%ebp)
    1071:	e8 37 fd ff ff       	call   dad <backcmd>
    1076:	83 c4 10             	add    $0x10,%esp
    1079:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    107c:	83 ec 04             	sub    $0x4,%esp
    107f:	68 96 1d 00 00       	push   $0x1d96
    1084:	ff 75 0c             	pushl  0xc(%ebp)
    1087:	ff 75 08             	pushl  0x8(%ebp)
    108a:	e8 aa fe ff ff       	call   f39 <peek>
    108f:	83 c4 10             	add    $0x10,%esp
    1092:	85 c0                	test   %eax,%eax
    1094:	75 c3                	jne    1059 <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    1096:	83 ec 04             	sub    $0x4,%esp
    1099:	68 98 1d 00 00       	push   $0x1d98
    109e:	ff 75 0c             	pushl  0xc(%ebp)
    10a1:	ff 75 08             	pushl  0x8(%ebp)
    10a4:	e8 90 fe ff ff       	call   f39 <peek>
    10a9:	83 c4 10             	add    $0x10,%esp
    10ac:	85 c0                	test   %eax,%eax
    10ae:	74 35                	je     10e5 <parseline+0xa8>
    gettoken(ps, es, 0, 0);
    10b0:	6a 00                	push   $0x0
    10b2:	6a 00                	push   $0x0
    10b4:	ff 75 0c             	pushl  0xc(%ebp)
    10b7:	ff 75 08             	pushl  0x8(%ebp)
    10ba:	e8 2d fd ff ff       	call   dec <gettoken>
    10bf:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
    10c2:	83 ec 08             	sub    $0x8,%esp
    10c5:	ff 75 0c             	pushl  0xc(%ebp)
    10c8:	ff 75 08             	pushl  0x8(%ebp)
    10cb:	e8 6d ff ff ff       	call   103d <parseline>
    10d0:	83 c4 10             	add    $0x10,%esp
    10d3:	83 ec 08             	sub    $0x8,%esp
    10d6:	50                   	push   %eax
    10d7:	ff 75 f4             	pushl  -0xc(%ebp)
    10da:	e8 86 fc ff ff       	call   d65 <listcmd>
    10df:	83 c4 10             	add    $0x10,%esp
    10e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    10e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10e8:	c9                   	leave  
    10e9:	c3                   	ret    

000010ea <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
    10ea:	55                   	push   %ebp
    10eb:	89 e5                	mov    %esp,%ebp
    10ed:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
    10f0:	83 ec 08             	sub    $0x8,%esp
    10f3:	ff 75 0c             	pushl  0xc(%ebp)
    10f6:	ff 75 08             	pushl  0x8(%ebp)
    10f9:	e8 ec 01 00 00       	call   12ea <parseexec>
    10fe:	83 c4 10             	add    $0x10,%esp
    1101:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
    1104:	83 ec 04             	sub    $0x4,%esp
    1107:	68 9a 1d 00 00       	push   $0x1d9a
    110c:	ff 75 0c             	pushl  0xc(%ebp)
    110f:	ff 75 08             	pushl  0x8(%ebp)
    1112:	e8 22 fe ff ff       	call   f39 <peek>
    1117:	83 c4 10             	add    $0x10,%esp
    111a:	85 c0                	test   %eax,%eax
    111c:	74 35                	je     1153 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
    111e:	6a 00                	push   $0x0
    1120:	6a 00                	push   $0x0
    1122:	ff 75 0c             	pushl  0xc(%ebp)
    1125:	ff 75 08             	pushl  0x8(%ebp)
    1128:	e8 bf fc ff ff       	call   dec <gettoken>
    112d:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
    1130:	83 ec 08             	sub    $0x8,%esp
    1133:	ff 75 0c             	pushl  0xc(%ebp)
    1136:	ff 75 08             	pushl  0x8(%ebp)
    1139:	e8 ac ff ff ff       	call   10ea <parsepipe>
    113e:	83 c4 10             	add    $0x10,%esp
    1141:	83 ec 08             	sub    $0x8,%esp
    1144:	50                   	push   %eax
    1145:	ff 75 f4             	pushl  -0xc(%ebp)
    1148:	e8 d0 fb ff ff       	call   d1d <pipecmd>
    114d:	83 c4 10             	add    $0x10,%esp
    1150:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
    1153:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1156:	c9                   	leave  
    1157:	c3                   	ret    

00001158 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    1158:	55                   	push   %ebp
    1159:	89 e5                	mov    %esp,%ebp
    115b:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    115e:	e9 b6 00 00 00       	jmp    1219 <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
    1163:	6a 00                	push   $0x0
    1165:	6a 00                	push   $0x0
    1167:	ff 75 10             	pushl  0x10(%ebp)
    116a:	ff 75 0c             	pushl  0xc(%ebp)
    116d:	e8 7a fc ff ff       	call   dec <gettoken>
    1172:	83 c4 10             	add    $0x10,%esp
    1175:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
    1178:	8d 45 ec             	lea    -0x14(%ebp),%eax
    117b:	50                   	push   %eax
    117c:	8d 45 f0             	lea    -0x10(%ebp),%eax
    117f:	50                   	push   %eax
    1180:	ff 75 10             	pushl  0x10(%ebp)
    1183:	ff 75 0c             	pushl  0xc(%ebp)
    1186:	e8 61 fc ff ff       	call   dec <gettoken>
    118b:	83 c4 10             	add    $0x10,%esp
    118e:	83 f8 61             	cmp    $0x61,%eax
    1191:	74 10                	je     11a3 <parseredirs+0x4b>
      panic("missing file for redirection");
    1193:	83 ec 0c             	sub    $0xc,%esp
    1196:	68 9c 1d 00 00       	push   $0x1d9c
    119b:	e8 96 fa ff ff       	call   c36 <panic>
    11a0:	83 c4 10             	add    $0x10,%esp
    switch(tok){
    11a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a6:	83 f8 3c             	cmp    $0x3c,%eax
    11a9:	74 0c                	je     11b7 <parseredirs+0x5f>
    11ab:	83 f8 3e             	cmp    $0x3e,%eax
    11ae:	74 26                	je     11d6 <parseredirs+0x7e>
    11b0:	83 f8 2b             	cmp    $0x2b,%eax
    11b3:	74 43                	je     11f8 <parseredirs+0xa0>
    11b5:	eb 62                	jmp    1219 <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    11b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    11ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11bd:	83 ec 0c             	sub    $0xc,%esp
    11c0:	6a 00                	push   $0x0
    11c2:	6a 00                	push   $0x0
    11c4:	52                   	push   %edx
    11c5:	50                   	push   %eax
    11c6:	ff 75 08             	pushl  0x8(%ebp)
    11c9:	e8 ec fa ff ff       	call   cba <redircmd>
    11ce:	83 c4 20             	add    $0x20,%esp
    11d1:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    11d4:	eb 43                	jmp    1219 <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    11d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    11d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11dc:	83 ec 0c             	sub    $0xc,%esp
    11df:	6a 01                	push   $0x1
    11e1:	68 01 02 00 00       	push   $0x201
    11e6:	52                   	push   %edx
    11e7:	50                   	push   %eax
    11e8:	ff 75 08             	pushl  0x8(%ebp)
    11eb:	e8 ca fa ff ff       	call   cba <redircmd>
    11f0:	83 c4 20             	add    $0x20,%esp
    11f3:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    11f6:	eb 21                	jmp    1219 <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    11f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
    11fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11fe:	83 ec 0c             	sub    $0xc,%esp
    1201:	6a 01                	push   $0x1
    1203:	68 01 02 00 00       	push   $0x201
    1208:	52                   	push   %edx
    1209:	50                   	push   %eax
    120a:	ff 75 08             	pushl  0x8(%ebp)
    120d:	e8 a8 fa ff ff       	call   cba <redircmd>
    1212:	83 c4 20             	add    $0x20,%esp
    1215:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
    1218:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    1219:	83 ec 04             	sub    $0x4,%esp
    121c:	68 b9 1d 00 00       	push   $0x1db9
    1221:	ff 75 10             	pushl  0x10(%ebp)
    1224:	ff 75 0c             	pushl  0xc(%ebp)
    1227:	e8 0d fd ff ff       	call   f39 <peek>
    122c:	83 c4 10             	add    $0x10,%esp
    122f:	85 c0                	test   %eax,%eax
    1231:	0f 85 2c ff ff ff    	jne    1163 <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
    1237:	8b 45 08             	mov    0x8(%ebp),%eax
}
    123a:	c9                   	leave  
    123b:	c3                   	ret    

0000123c <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
    123c:	55                   	push   %ebp
    123d:	89 e5                	mov    %esp,%ebp
    123f:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    1242:	83 ec 04             	sub    $0x4,%esp
    1245:	68 bc 1d 00 00       	push   $0x1dbc
    124a:	ff 75 0c             	pushl  0xc(%ebp)
    124d:	ff 75 08             	pushl  0x8(%ebp)
    1250:	e8 e4 fc ff ff       	call   f39 <peek>
    1255:	83 c4 10             	add    $0x10,%esp
    1258:	85 c0                	test   %eax,%eax
    125a:	75 10                	jne    126c <parseblock+0x30>
    panic("parseblock");
    125c:	83 ec 0c             	sub    $0xc,%esp
    125f:	68 be 1d 00 00       	push   $0x1dbe
    1264:	e8 cd f9 ff ff       	call   c36 <panic>
    1269:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    126c:	6a 00                	push   $0x0
    126e:	6a 00                	push   $0x0
    1270:	ff 75 0c             	pushl  0xc(%ebp)
    1273:	ff 75 08             	pushl  0x8(%ebp)
    1276:	e8 71 fb ff ff       	call   dec <gettoken>
    127b:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
    127e:	83 ec 08             	sub    $0x8,%esp
    1281:	ff 75 0c             	pushl  0xc(%ebp)
    1284:	ff 75 08             	pushl  0x8(%ebp)
    1287:	e8 b1 fd ff ff       	call   103d <parseline>
    128c:	83 c4 10             	add    $0x10,%esp
    128f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
    1292:	83 ec 04             	sub    $0x4,%esp
    1295:	68 c9 1d 00 00       	push   $0x1dc9
    129a:	ff 75 0c             	pushl  0xc(%ebp)
    129d:	ff 75 08             	pushl  0x8(%ebp)
    12a0:	e8 94 fc ff ff       	call   f39 <peek>
    12a5:	83 c4 10             	add    $0x10,%esp
    12a8:	85 c0                	test   %eax,%eax
    12aa:	75 10                	jne    12bc <parseblock+0x80>
    panic("syntax - missing )");
    12ac:	83 ec 0c             	sub    $0xc,%esp
    12af:	68 cb 1d 00 00       	push   $0x1dcb
    12b4:	e8 7d f9 ff ff       	call   c36 <panic>
    12b9:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
    12bc:	6a 00                	push   $0x0
    12be:	6a 00                	push   $0x0
    12c0:	ff 75 0c             	pushl  0xc(%ebp)
    12c3:	ff 75 08             	pushl  0x8(%ebp)
    12c6:	e8 21 fb ff ff       	call   dec <gettoken>
    12cb:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
    12ce:	83 ec 04             	sub    $0x4,%esp
    12d1:	ff 75 0c             	pushl  0xc(%ebp)
    12d4:	ff 75 08             	pushl  0x8(%ebp)
    12d7:	ff 75 f4             	pushl  -0xc(%ebp)
    12da:	e8 79 fe ff ff       	call   1158 <parseredirs>
    12df:	83 c4 10             	add    $0x10,%esp
    12e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
    12e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    12e8:	c9                   	leave  
    12e9:	c3                   	ret    

000012ea <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
    12ea:	55                   	push   %ebp
    12eb:	89 e5                	mov    %esp,%ebp
    12ed:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    12f0:	83 ec 04             	sub    $0x4,%esp
    12f3:	68 bc 1d 00 00       	push   $0x1dbc
    12f8:	ff 75 0c             	pushl  0xc(%ebp)
    12fb:	ff 75 08             	pushl  0x8(%ebp)
    12fe:	e8 36 fc ff ff       	call   f39 <peek>
    1303:	83 c4 10             	add    $0x10,%esp
    1306:	85 c0                	test   %eax,%eax
    1308:	74 16                	je     1320 <parseexec+0x36>
    return parseblock(ps, es);
    130a:	83 ec 08             	sub    $0x8,%esp
    130d:	ff 75 0c             	pushl  0xc(%ebp)
    1310:	ff 75 08             	pushl  0x8(%ebp)
    1313:	e8 24 ff ff ff       	call   123c <parseblock>
    1318:	83 c4 10             	add    $0x10,%esp
    131b:	e9 f9 00 00 00       	jmp    1419 <parseexec+0x12f>

  ret = execcmd();
    1320:	e8 5f f9 ff ff       	call   c84 <execcmd>
    1325:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
    1328:	8b 45 f0             	mov    -0x10(%ebp),%eax
    132b:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
    132e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
    1335:	83 ec 04             	sub    $0x4,%esp
    1338:	ff 75 0c             	pushl  0xc(%ebp)
    133b:	ff 75 08             	pushl  0x8(%ebp)
    133e:	ff 75 f0             	pushl  -0x10(%ebp)
    1341:	e8 12 fe ff ff       	call   1158 <parseredirs>
    1346:	83 c4 10             	add    $0x10,%esp
    1349:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
    134c:	e9 88 00 00 00       	jmp    13d9 <parseexec+0xef>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    1351:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1354:	50                   	push   %eax
    1355:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1358:	50                   	push   %eax
    1359:	ff 75 0c             	pushl  0xc(%ebp)
    135c:	ff 75 08             	pushl  0x8(%ebp)
    135f:	e8 88 fa ff ff       	call   dec <gettoken>
    1364:	83 c4 10             	add    $0x10,%esp
    1367:	89 45 e8             	mov    %eax,-0x18(%ebp)
    136a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    136e:	75 05                	jne    1375 <parseexec+0x8b>
      break;
    1370:	e9 82 00 00 00       	jmp    13f7 <parseexec+0x10d>
    if(tok != 'a')
    1375:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
    1379:	74 10                	je     138b <parseexec+0xa1>
      panic("syntax");
    137b:	83 ec 0c             	sub    $0xc,%esp
    137e:	68 8f 1d 00 00       	push   $0x1d8f
    1383:	e8 ae f8 ff ff       	call   c36 <panic>
    1388:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
    138b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    138e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1391:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1394:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
    1398:	8b 55 e0             	mov    -0x20(%ebp),%edx
    139b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    139e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    13a1:	83 c1 08             	add    $0x8,%ecx
    13a4:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
    13a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
    13ac:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    13b0:	7e 10                	jle    13c2 <parseexec+0xd8>
      panic("too many args");
    13b2:	83 ec 0c             	sub    $0xc,%esp
    13b5:	68 de 1d 00 00       	push   $0x1dde
    13ba:	e8 77 f8 ff ff       	call   c36 <panic>
    13bf:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
    13c2:	83 ec 04             	sub    $0x4,%esp
    13c5:	ff 75 0c             	pushl  0xc(%ebp)
    13c8:	ff 75 08             	pushl  0x8(%ebp)
    13cb:	ff 75 f0             	pushl  -0x10(%ebp)
    13ce:	e8 85 fd ff ff       	call   1158 <parseredirs>
    13d3:	83 c4 10             	add    $0x10,%esp
    13d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    13d9:	83 ec 04             	sub    $0x4,%esp
    13dc:	68 ec 1d 00 00       	push   $0x1dec
    13e1:	ff 75 0c             	pushl  0xc(%ebp)
    13e4:	ff 75 08             	pushl  0x8(%ebp)
    13e7:	e8 4d fb ff ff       	call   f39 <peek>
    13ec:	83 c4 10             	add    $0x10,%esp
    13ef:	85 c0                	test   %eax,%eax
    13f1:	0f 84 5a ff ff ff    	je     1351 <parseexec+0x67>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
    13f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13fd:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
    1404:	00 
  cmd->eargv[argc] = 0;
    1405:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1408:	8b 55 f4             	mov    -0xc(%ebp),%edx
    140b:	83 c2 08             	add    $0x8,%edx
    140e:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
    1415:	00 
  return ret;
    1416:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    1419:	c9                   	leave  
    141a:	c3                   	ret    

0000141b <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    141b:	55                   	push   %ebp
    141c:	89 e5                	mov    %esp,%ebp
    141e:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    1421:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    1425:	75 0a                	jne    1431 <nulterminate+0x16>
    return 0;
    1427:	b8 00 00 00 00       	mov    $0x0,%eax
    142c:	e9 e4 00 00 00       	jmp    1515 <nulterminate+0xfa>
  
  switch(cmd->type){
    1431:	8b 45 08             	mov    0x8(%ebp),%eax
    1434:	8b 00                	mov    (%eax),%eax
    1436:	83 f8 05             	cmp    $0x5,%eax
    1439:	0f 87 d3 00 00 00    	ja     1512 <nulterminate+0xf7>
    143f:	8b 04 85 f4 1d 00 00 	mov    0x1df4(,%eax,4),%eax
    1446:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    1448:	8b 45 08             	mov    0x8(%ebp),%eax
    144b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
    144e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1455:	eb 14                	jmp    146b <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
    1457:	8b 45 f0             	mov    -0x10(%ebp),%eax
    145a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    145d:	83 c2 08             	add    $0x8,%edx
    1460:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
    1464:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    1467:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    146b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    146e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1471:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
    1475:	85 c0                	test   %eax,%eax
    1477:	75 de                	jne    1457 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
    1479:	e9 94 00 00 00       	jmp    1512 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    147e:	8b 45 08             	mov    0x8(%ebp),%eax
    1481:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
    1484:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1487:	8b 40 04             	mov    0x4(%eax),%eax
    148a:	83 ec 0c             	sub    $0xc,%esp
    148d:	50                   	push   %eax
    148e:	e8 88 ff ff ff       	call   141b <nulterminate>
    1493:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
    1496:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1499:	8b 40 0c             	mov    0xc(%eax),%eax
    149c:	c6 00 00             	movb   $0x0,(%eax)
    break;
    149f:	eb 71                	jmp    1512 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    14a1:	8b 45 08             	mov    0x8(%ebp),%eax
    14a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
    14a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14aa:	8b 40 04             	mov    0x4(%eax),%eax
    14ad:	83 ec 0c             	sub    $0xc,%esp
    14b0:	50                   	push   %eax
    14b1:	e8 65 ff ff ff       	call   141b <nulterminate>
    14b6:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
    14b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    14bc:	8b 40 08             	mov    0x8(%eax),%eax
    14bf:	83 ec 0c             	sub    $0xc,%esp
    14c2:	50                   	push   %eax
    14c3:	e8 53 ff ff ff       	call   141b <nulterminate>
    14c8:	83 c4 10             	add    $0x10,%esp
    break;
    14cb:	eb 45                	jmp    1512 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    14cd:	8b 45 08             	mov    0x8(%ebp),%eax
    14d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
    14d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14d6:	8b 40 04             	mov    0x4(%eax),%eax
    14d9:	83 ec 0c             	sub    $0xc,%esp
    14dc:	50                   	push   %eax
    14dd:	e8 39 ff ff ff       	call   141b <nulterminate>
    14e2:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
    14e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14e8:	8b 40 08             	mov    0x8(%eax),%eax
    14eb:	83 ec 0c             	sub    $0xc,%esp
    14ee:	50                   	push   %eax
    14ef:	e8 27 ff ff ff       	call   141b <nulterminate>
    14f4:	83 c4 10             	add    $0x10,%esp
    break;
    14f7:	eb 19                	jmp    1512 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
    14f9:	8b 45 08             	mov    0x8(%ebp),%eax
    14fc:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
    14ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1502:	8b 40 04             	mov    0x4(%eax),%eax
    1505:	83 ec 0c             	sub    $0xc,%esp
    1508:	50                   	push   %eax
    1509:	e8 0d ff ff ff       	call   141b <nulterminate>
    150e:	83 c4 10             	add    $0x10,%esp
    break;
    1511:	90                   	nop
  }
  return cmd;
    1512:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1515:	c9                   	leave  
    1516:	c3                   	ret    

00001517 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1517:	55                   	push   %ebp
    1518:	89 e5                	mov    %esp,%ebp
    151a:	57                   	push   %edi
    151b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    151c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    151f:	8b 55 10             	mov    0x10(%ebp),%edx
    1522:	8b 45 0c             	mov    0xc(%ebp),%eax
    1525:	89 cb                	mov    %ecx,%ebx
    1527:	89 df                	mov    %ebx,%edi
    1529:	89 d1                	mov    %edx,%ecx
    152b:	fc                   	cld    
    152c:	f3 aa                	rep stos %al,%es:(%edi)
    152e:	89 ca                	mov    %ecx,%edx
    1530:	89 fb                	mov    %edi,%ebx
    1532:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1535:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1538:	5b                   	pop    %ebx
    1539:	5f                   	pop    %edi
    153a:	5d                   	pop    %ebp
    153b:	c3                   	ret    

0000153c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    153c:	55                   	push   %ebp
    153d:	89 e5                	mov    %esp,%ebp
    153f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1542:	8b 45 08             	mov    0x8(%ebp),%eax
    1545:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1548:	90                   	nop
    1549:	8b 45 08             	mov    0x8(%ebp),%eax
    154c:	8d 50 01             	lea    0x1(%eax),%edx
    154f:	89 55 08             	mov    %edx,0x8(%ebp)
    1552:	8b 55 0c             	mov    0xc(%ebp),%edx
    1555:	8d 4a 01             	lea    0x1(%edx),%ecx
    1558:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    155b:	0f b6 12             	movzbl (%edx),%edx
    155e:	88 10                	mov    %dl,(%eax)
    1560:	0f b6 00             	movzbl (%eax),%eax
    1563:	84 c0                	test   %al,%al
    1565:	75 e2                	jne    1549 <strcpy+0xd>
    ;
  return os;
    1567:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    156a:	c9                   	leave  
    156b:	c3                   	ret    

0000156c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    156c:	55                   	push   %ebp
    156d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    156f:	eb 08                	jmp    1579 <strcmp+0xd>
    p++, q++;
    1571:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1575:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1579:	8b 45 08             	mov    0x8(%ebp),%eax
    157c:	0f b6 00             	movzbl (%eax),%eax
    157f:	84 c0                	test   %al,%al
    1581:	74 10                	je     1593 <strcmp+0x27>
    1583:	8b 45 08             	mov    0x8(%ebp),%eax
    1586:	0f b6 10             	movzbl (%eax),%edx
    1589:	8b 45 0c             	mov    0xc(%ebp),%eax
    158c:	0f b6 00             	movzbl (%eax),%eax
    158f:	38 c2                	cmp    %al,%dl
    1591:	74 de                	je     1571 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1593:	8b 45 08             	mov    0x8(%ebp),%eax
    1596:	0f b6 00             	movzbl (%eax),%eax
    1599:	0f b6 d0             	movzbl %al,%edx
    159c:	8b 45 0c             	mov    0xc(%ebp),%eax
    159f:	0f b6 00             	movzbl (%eax),%eax
    15a2:	0f b6 c0             	movzbl %al,%eax
    15a5:	29 c2                	sub    %eax,%edx
    15a7:	89 d0                	mov    %edx,%eax
}
    15a9:	5d                   	pop    %ebp
    15aa:	c3                   	ret    

000015ab <strlen>:

uint
strlen(char *s)
{
    15ab:	55                   	push   %ebp
    15ac:	89 e5                	mov    %esp,%ebp
    15ae:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    15b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    15b8:	eb 04                	jmp    15be <strlen+0x13>
    15ba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    15be:	8b 55 fc             	mov    -0x4(%ebp),%edx
    15c1:	8b 45 08             	mov    0x8(%ebp),%eax
    15c4:	01 d0                	add    %edx,%eax
    15c6:	0f b6 00             	movzbl (%eax),%eax
    15c9:	84 c0                	test   %al,%al
    15cb:	75 ed                	jne    15ba <strlen+0xf>
    ;
  return n;
    15cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15d0:	c9                   	leave  
    15d1:	c3                   	ret    

000015d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    15d2:	55                   	push   %ebp
    15d3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    15d5:	8b 45 10             	mov    0x10(%ebp),%eax
    15d8:	50                   	push   %eax
    15d9:	ff 75 0c             	pushl  0xc(%ebp)
    15dc:	ff 75 08             	pushl  0x8(%ebp)
    15df:	e8 33 ff ff ff       	call   1517 <stosb>
    15e4:	83 c4 0c             	add    $0xc,%esp
  return dst;
    15e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15ea:	c9                   	leave  
    15eb:	c3                   	ret    

000015ec <strchr>:

char*
strchr(const char *s, char c)
{
    15ec:	55                   	push   %ebp
    15ed:	89 e5                	mov    %esp,%ebp
    15ef:	83 ec 04             	sub    $0x4,%esp
    15f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    15f5:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    15f8:	eb 14                	jmp    160e <strchr+0x22>
    if(*s == c)
    15fa:	8b 45 08             	mov    0x8(%ebp),%eax
    15fd:	0f b6 00             	movzbl (%eax),%eax
    1600:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1603:	75 05                	jne    160a <strchr+0x1e>
      return (char*)s;
    1605:	8b 45 08             	mov    0x8(%ebp),%eax
    1608:	eb 13                	jmp    161d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    160a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    160e:	8b 45 08             	mov    0x8(%ebp),%eax
    1611:	0f b6 00             	movzbl (%eax),%eax
    1614:	84 c0                	test   %al,%al
    1616:	75 e2                	jne    15fa <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1618:	b8 00 00 00 00       	mov    $0x0,%eax
}
    161d:	c9                   	leave  
    161e:	c3                   	ret    

0000161f <gets>:

char*
gets(char *buf, int max)
{
    161f:	55                   	push   %ebp
    1620:	89 e5                	mov    %esp,%ebp
    1622:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1625:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    162c:	eb 44                	jmp    1672 <gets+0x53>
    cc = read(0, &c, 1);
    162e:	83 ec 04             	sub    $0x4,%esp
    1631:	6a 01                	push   $0x1
    1633:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1636:	50                   	push   %eax
    1637:	6a 00                	push   $0x0
    1639:	e8 46 01 00 00       	call   1784 <read>
    163e:	83 c4 10             	add    $0x10,%esp
    1641:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1644:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1648:	7f 02                	jg     164c <gets+0x2d>
      break;
    164a:	eb 31                	jmp    167d <gets+0x5e>
    buf[i++] = c;
    164c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    164f:	8d 50 01             	lea    0x1(%eax),%edx
    1652:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1655:	89 c2                	mov    %eax,%edx
    1657:	8b 45 08             	mov    0x8(%ebp),%eax
    165a:	01 c2                	add    %eax,%edx
    165c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1660:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    1662:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1666:	3c 0a                	cmp    $0xa,%al
    1668:	74 13                	je     167d <gets+0x5e>
    166a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    166e:	3c 0d                	cmp    $0xd,%al
    1670:	74 0b                	je     167d <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1672:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1675:	83 c0 01             	add    $0x1,%eax
    1678:	3b 45 0c             	cmp    0xc(%ebp),%eax
    167b:	7c b1                	jl     162e <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    167d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1680:	8b 45 08             	mov    0x8(%ebp),%eax
    1683:	01 d0                	add    %edx,%eax
    1685:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1688:	8b 45 08             	mov    0x8(%ebp),%eax
}
    168b:	c9                   	leave  
    168c:	c3                   	ret    

0000168d <stat>:

int
stat(char *n, struct stat *st)
{
    168d:	55                   	push   %ebp
    168e:	89 e5                	mov    %esp,%ebp
    1690:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1693:	83 ec 08             	sub    $0x8,%esp
    1696:	6a 00                	push   $0x0
    1698:	ff 75 08             	pushl  0x8(%ebp)
    169b:	e8 0c 01 00 00       	call   17ac <open>
    16a0:	83 c4 10             	add    $0x10,%esp
    16a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    16a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16aa:	79 07                	jns    16b3 <stat+0x26>
    return -1;
    16ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    16b1:	eb 25                	jmp    16d8 <stat+0x4b>
  r = fstat(fd, st);
    16b3:	83 ec 08             	sub    $0x8,%esp
    16b6:	ff 75 0c             	pushl  0xc(%ebp)
    16b9:	ff 75 f4             	pushl  -0xc(%ebp)
    16bc:	e8 03 01 00 00       	call   17c4 <fstat>
    16c1:	83 c4 10             	add    $0x10,%esp
    16c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    16c7:	83 ec 0c             	sub    $0xc,%esp
    16ca:	ff 75 f4             	pushl  -0xc(%ebp)
    16cd:	e8 c2 00 00 00       	call   1794 <close>
    16d2:	83 c4 10             	add    $0x10,%esp
  return r;
    16d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    16d8:	c9                   	leave  
    16d9:	c3                   	ret    

000016da <atoi>:

int
atoi(const char *s)
{
    16da:	55                   	push   %ebp
    16db:	89 e5                	mov    %esp,%ebp
    16dd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    16e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    16e7:	eb 25                	jmp    170e <atoi+0x34>
    n = n*10 + *s++ - '0';
    16e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    16ec:	89 d0                	mov    %edx,%eax
    16ee:	c1 e0 02             	shl    $0x2,%eax
    16f1:	01 d0                	add    %edx,%eax
    16f3:	01 c0                	add    %eax,%eax
    16f5:	89 c1                	mov    %eax,%ecx
    16f7:	8b 45 08             	mov    0x8(%ebp),%eax
    16fa:	8d 50 01             	lea    0x1(%eax),%edx
    16fd:	89 55 08             	mov    %edx,0x8(%ebp)
    1700:	0f b6 00             	movzbl (%eax),%eax
    1703:	0f be c0             	movsbl %al,%eax
    1706:	01 c8                	add    %ecx,%eax
    1708:	83 e8 30             	sub    $0x30,%eax
    170b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    170e:	8b 45 08             	mov    0x8(%ebp),%eax
    1711:	0f b6 00             	movzbl (%eax),%eax
    1714:	3c 2f                	cmp    $0x2f,%al
    1716:	7e 0a                	jle    1722 <atoi+0x48>
    1718:	8b 45 08             	mov    0x8(%ebp),%eax
    171b:	0f b6 00             	movzbl (%eax),%eax
    171e:	3c 39                	cmp    $0x39,%al
    1720:	7e c7                	jle    16e9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1722:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1725:	c9                   	leave  
    1726:	c3                   	ret    

00001727 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1727:	55                   	push   %ebp
    1728:	89 e5                	mov    %esp,%ebp
    172a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    172d:	8b 45 08             	mov    0x8(%ebp),%eax
    1730:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1733:	8b 45 0c             	mov    0xc(%ebp),%eax
    1736:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1739:	eb 17                	jmp    1752 <memmove+0x2b>
    *dst++ = *src++;
    173b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    173e:	8d 50 01             	lea    0x1(%eax),%edx
    1741:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1744:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1747:	8d 4a 01             	lea    0x1(%edx),%ecx
    174a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    174d:	0f b6 12             	movzbl (%edx),%edx
    1750:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1752:	8b 45 10             	mov    0x10(%ebp),%eax
    1755:	8d 50 ff             	lea    -0x1(%eax),%edx
    1758:	89 55 10             	mov    %edx,0x10(%ebp)
    175b:	85 c0                	test   %eax,%eax
    175d:	7f dc                	jg     173b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    175f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1762:	c9                   	leave  
    1763:	c3                   	ret    

00001764 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1764:	b8 01 00 00 00       	mov    $0x1,%eax
    1769:	cd 40                	int    $0x40
    176b:	c3                   	ret    

0000176c <exit>:
SYSCALL(exit)
    176c:	b8 02 00 00 00       	mov    $0x2,%eax
    1771:	cd 40                	int    $0x40
    1773:	c3                   	ret    

00001774 <wait>:
SYSCALL(wait)
    1774:	b8 03 00 00 00       	mov    $0x3,%eax
    1779:	cd 40                	int    $0x40
    177b:	c3                   	ret    

0000177c <pipe>:
SYSCALL(pipe)
    177c:	b8 04 00 00 00       	mov    $0x4,%eax
    1781:	cd 40                	int    $0x40
    1783:	c3                   	ret    

00001784 <read>:
SYSCALL(read)
    1784:	b8 05 00 00 00       	mov    $0x5,%eax
    1789:	cd 40                	int    $0x40
    178b:	c3                   	ret    

0000178c <write>:
SYSCALL(write)
    178c:	b8 10 00 00 00       	mov    $0x10,%eax
    1791:	cd 40                	int    $0x40
    1793:	c3                   	ret    

00001794 <close>:
SYSCALL(close)
    1794:	b8 15 00 00 00       	mov    $0x15,%eax
    1799:	cd 40                	int    $0x40
    179b:	c3                   	ret    

0000179c <kill>:
SYSCALL(kill)
    179c:	b8 06 00 00 00       	mov    $0x6,%eax
    17a1:	cd 40                	int    $0x40
    17a3:	c3                   	ret    

000017a4 <exec>:
SYSCALL(exec)
    17a4:	b8 07 00 00 00       	mov    $0x7,%eax
    17a9:	cd 40                	int    $0x40
    17ab:	c3                   	ret    

000017ac <open>:
SYSCALL(open)
    17ac:	b8 0f 00 00 00       	mov    $0xf,%eax
    17b1:	cd 40                	int    $0x40
    17b3:	c3                   	ret    

000017b4 <mknod>:
SYSCALL(mknod)
    17b4:	b8 11 00 00 00       	mov    $0x11,%eax
    17b9:	cd 40                	int    $0x40
    17bb:	c3                   	ret    

000017bc <unlink>:
SYSCALL(unlink)
    17bc:	b8 12 00 00 00       	mov    $0x12,%eax
    17c1:	cd 40                	int    $0x40
    17c3:	c3                   	ret    

000017c4 <fstat>:
SYSCALL(fstat)
    17c4:	b8 08 00 00 00       	mov    $0x8,%eax
    17c9:	cd 40                	int    $0x40
    17cb:	c3                   	ret    

000017cc <link>:
SYSCALL(link)
    17cc:	b8 13 00 00 00       	mov    $0x13,%eax
    17d1:	cd 40                	int    $0x40
    17d3:	c3                   	ret    

000017d4 <mkdir>:
SYSCALL(mkdir)
    17d4:	b8 14 00 00 00       	mov    $0x14,%eax
    17d9:	cd 40                	int    $0x40
    17db:	c3                   	ret    

000017dc <chdir>:
SYSCALL(chdir)
    17dc:	b8 09 00 00 00       	mov    $0x9,%eax
    17e1:	cd 40                	int    $0x40
    17e3:	c3                   	ret    

000017e4 <dup>:
SYSCALL(dup)
    17e4:	b8 0a 00 00 00       	mov    $0xa,%eax
    17e9:	cd 40                	int    $0x40
    17eb:	c3                   	ret    

000017ec <getpid>:
SYSCALL(getpid)
    17ec:	b8 0b 00 00 00       	mov    $0xb,%eax
    17f1:	cd 40                	int    $0x40
    17f3:	c3                   	ret    

000017f4 <sbrk>:
SYSCALL(sbrk)
    17f4:	b8 0c 00 00 00       	mov    $0xc,%eax
    17f9:	cd 40                	int    $0x40
    17fb:	c3                   	ret    

000017fc <sleep>:
SYSCALL(sleep)
    17fc:	b8 0d 00 00 00       	mov    $0xd,%eax
    1801:	cd 40                	int    $0x40
    1803:	c3                   	ret    

00001804 <uptime>:
SYSCALL(uptime)
    1804:	b8 0e 00 00 00       	mov    $0xe,%eax
    1809:	cd 40                	int    $0x40
    180b:	c3                   	ret    

0000180c <pstat>:
SYSCALL(pstat)
    180c:	b8 16 00 00 00       	mov    $0x16,%eax
    1811:	cd 40                	int    $0x40
    1813:	c3                   	ret    

00001814 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1814:	55                   	push   %ebp
    1815:	89 e5                	mov    %esp,%ebp
    1817:	83 ec 18             	sub    $0x18,%esp
    181a:	8b 45 0c             	mov    0xc(%ebp),%eax
    181d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1820:	83 ec 04             	sub    $0x4,%esp
    1823:	6a 01                	push   $0x1
    1825:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1828:	50                   	push   %eax
    1829:	ff 75 08             	pushl  0x8(%ebp)
    182c:	e8 5b ff ff ff       	call   178c <write>
    1831:	83 c4 10             	add    $0x10,%esp
}
    1834:	c9                   	leave  
    1835:	c3                   	ret    

00001836 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1836:	55                   	push   %ebp
    1837:	89 e5                	mov    %esp,%ebp
    1839:	53                   	push   %ebx
    183a:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    183d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1844:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1848:	74 17                	je     1861 <printint+0x2b>
    184a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    184e:	79 11                	jns    1861 <printint+0x2b>
    neg = 1;
    1850:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1857:	8b 45 0c             	mov    0xc(%ebp),%eax
    185a:	f7 d8                	neg    %eax
    185c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    185f:	eb 06                	jmp    1867 <printint+0x31>
  } else {
    x = xx;
    1861:	8b 45 0c             	mov    0xc(%ebp),%eax
    1864:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1867:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    186e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1871:	8d 41 01             	lea    0x1(%ecx),%eax
    1874:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1877:	8b 5d 10             	mov    0x10(%ebp),%ebx
    187a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    187d:	ba 00 00 00 00       	mov    $0x0,%edx
    1882:	f7 f3                	div    %ebx
    1884:	89 d0                	mov    %edx,%eax
    1886:	0f b6 80 e2 23 00 00 	movzbl 0x23e2(%eax),%eax
    188d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1891:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1894:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1897:	ba 00 00 00 00       	mov    $0x0,%edx
    189c:	f7 f3                	div    %ebx
    189e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18a5:	75 c7                	jne    186e <printint+0x38>
  if(neg)
    18a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18ab:	74 0e                	je     18bb <printint+0x85>
    buf[i++] = '-';
    18ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b0:	8d 50 01             	lea    0x1(%eax),%edx
    18b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
    18b6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    18bb:	eb 1d                	jmp    18da <printint+0xa4>
    putc(fd, buf[i]);
    18bd:	8d 55 dc             	lea    -0x24(%ebp),%edx
    18c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c3:	01 d0                	add    %edx,%eax
    18c5:	0f b6 00             	movzbl (%eax),%eax
    18c8:	0f be c0             	movsbl %al,%eax
    18cb:	83 ec 08             	sub    $0x8,%esp
    18ce:	50                   	push   %eax
    18cf:	ff 75 08             	pushl  0x8(%ebp)
    18d2:	e8 3d ff ff ff       	call   1814 <putc>
    18d7:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    18da:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    18de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18e2:	79 d9                	jns    18bd <printint+0x87>
    putc(fd, buf[i]);
}
    18e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    18e7:	c9                   	leave  
    18e8:	c3                   	ret    

000018e9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    18e9:	55                   	push   %ebp
    18ea:	89 e5                	mov    %esp,%ebp
    18ec:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    18ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    18f6:	8d 45 0c             	lea    0xc(%ebp),%eax
    18f9:	83 c0 04             	add    $0x4,%eax
    18fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    18ff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1906:	e9 59 01 00 00       	jmp    1a64 <printf+0x17b>
    c = fmt[i] & 0xff;
    190b:	8b 55 0c             	mov    0xc(%ebp),%edx
    190e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1911:	01 d0                	add    %edx,%eax
    1913:	0f b6 00             	movzbl (%eax),%eax
    1916:	0f be c0             	movsbl %al,%eax
    1919:	25 ff 00 00 00       	and    $0xff,%eax
    191e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1921:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1925:	75 2c                	jne    1953 <printf+0x6a>
      if(c == '%'){
    1927:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    192b:	75 0c                	jne    1939 <printf+0x50>
        state = '%';
    192d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1934:	e9 27 01 00 00       	jmp    1a60 <printf+0x177>
      } else {
        putc(fd, c);
    1939:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    193c:	0f be c0             	movsbl %al,%eax
    193f:	83 ec 08             	sub    $0x8,%esp
    1942:	50                   	push   %eax
    1943:	ff 75 08             	pushl  0x8(%ebp)
    1946:	e8 c9 fe ff ff       	call   1814 <putc>
    194b:	83 c4 10             	add    $0x10,%esp
    194e:	e9 0d 01 00 00       	jmp    1a60 <printf+0x177>
      }
    } else if(state == '%'){
    1953:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1957:	0f 85 03 01 00 00    	jne    1a60 <printf+0x177>
      if(c == 'd'){
    195d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1961:	75 1e                	jne    1981 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1963:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1966:	8b 00                	mov    (%eax),%eax
    1968:	6a 01                	push   $0x1
    196a:	6a 0a                	push   $0xa
    196c:	50                   	push   %eax
    196d:	ff 75 08             	pushl  0x8(%ebp)
    1970:	e8 c1 fe ff ff       	call   1836 <printint>
    1975:	83 c4 10             	add    $0x10,%esp
        ap++;
    1978:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    197c:	e9 d8 00 00 00       	jmp    1a59 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1981:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1985:	74 06                	je     198d <printf+0xa4>
    1987:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    198b:	75 1e                	jne    19ab <printf+0xc2>
        printint(fd, *ap, 16, 0);
    198d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1990:	8b 00                	mov    (%eax),%eax
    1992:	6a 00                	push   $0x0
    1994:	6a 10                	push   $0x10
    1996:	50                   	push   %eax
    1997:	ff 75 08             	pushl  0x8(%ebp)
    199a:	e8 97 fe ff ff       	call   1836 <printint>
    199f:	83 c4 10             	add    $0x10,%esp
        ap++;
    19a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    19a6:	e9 ae 00 00 00       	jmp    1a59 <printf+0x170>
      } else if(c == 's'){
    19ab:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    19af:	75 43                	jne    19f4 <printf+0x10b>
        s = (char*)*ap;
    19b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19b4:	8b 00                	mov    (%eax),%eax
    19b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    19b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    19bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19c1:	75 07                	jne    19ca <printf+0xe1>
          s = "(null)";
    19c3:	c7 45 f4 0c 1e 00 00 	movl   $0x1e0c,-0xc(%ebp)
        while(*s != 0){
    19ca:	eb 1c                	jmp    19e8 <printf+0xff>
          putc(fd, *s);
    19cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19cf:	0f b6 00             	movzbl (%eax),%eax
    19d2:	0f be c0             	movsbl %al,%eax
    19d5:	83 ec 08             	sub    $0x8,%esp
    19d8:	50                   	push   %eax
    19d9:	ff 75 08             	pushl  0x8(%ebp)
    19dc:	e8 33 fe ff ff       	call   1814 <putc>
    19e1:	83 c4 10             	add    $0x10,%esp
          s++;
    19e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    19e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19eb:	0f b6 00             	movzbl (%eax),%eax
    19ee:	84 c0                	test   %al,%al
    19f0:	75 da                	jne    19cc <printf+0xe3>
    19f2:	eb 65                	jmp    1a59 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    19f4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    19f8:	75 1d                	jne    1a17 <printf+0x12e>
        putc(fd, *ap);
    19fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19fd:	8b 00                	mov    (%eax),%eax
    19ff:	0f be c0             	movsbl %al,%eax
    1a02:	83 ec 08             	sub    $0x8,%esp
    1a05:	50                   	push   %eax
    1a06:	ff 75 08             	pushl  0x8(%ebp)
    1a09:	e8 06 fe ff ff       	call   1814 <putc>
    1a0e:	83 c4 10             	add    $0x10,%esp
        ap++;
    1a11:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1a15:	eb 42                	jmp    1a59 <printf+0x170>
      } else if(c == '%'){
    1a17:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1a1b:	75 17                	jne    1a34 <printf+0x14b>
        putc(fd, c);
    1a1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a20:	0f be c0             	movsbl %al,%eax
    1a23:	83 ec 08             	sub    $0x8,%esp
    1a26:	50                   	push   %eax
    1a27:	ff 75 08             	pushl  0x8(%ebp)
    1a2a:	e8 e5 fd ff ff       	call   1814 <putc>
    1a2f:	83 c4 10             	add    $0x10,%esp
    1a32:	eb 25                	jmp    1a59 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1a34:	83 ec 08             	sub    $0x8,%esp
    1a37:	6a 25                	push   $0x25
    1a39:	ff 75 08             	pushl  0x8(%ebp)
    1a3c:	e8 d3 fd ff ff       	call   1814 <putc>
    1a41:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1a44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a47:	0f be c0             	movsbl %al,%eax
    1a4a:	83 ec 08             	sub    $0x8,%esp
    1a4d:	50                   	push   %eax
    1a4e:	ff 75 08             	pushl  0x8(%ebp)
    1a51:	e8 be fd ff ff       	call   1814 <putc>
    1a56:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1a59:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1a60:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1a64:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a6a:	01 d0                	add    %edx,%eax
    1a6c:	0f b6 00             	movzbl (%eax),%eax
    1a6f:	84 c0                	test   %al,%al
    1a71:	0f 85 94 fe ff ff    	jne    190b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1a77:	c9                   	leave  
    1a78:	c3                   	ret    

00001a79 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a79:	55                   	push   %ebp
    1a7a:	89 e5                	mov    %esp,%ebp
    1a7c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1a7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1a82:	83 e8 08             	sub    $0x8,%eax
    1a85:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a88:	a1 6c 24 00 00       	mov    0x246c,%eax
    1a8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1a90:	eb 24                	jmp    1ab6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1a92:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a95:	8b 00                	mov    (%eax),%eax
    1a97:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1a9a:	77 12                	ja     1aae <free+0x35>
    1a9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a9f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1aa2:	77 24                	ja     1ac8 <free+0x4f>
    1aa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aa7:	8b 00                	mov    (%eax),%eax
    1aa9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1aac:	77 1a                	ja     1ac8 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1aae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ab1:	8b 00                	mov    (%eax),%eax
    1ab3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1ab6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ab9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1abc:	76 d4                	jbe    1a92 <free+0x19>
    1abe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ac1:	8b 00                	mov    (%eax),%eax
    1ac3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ac6:	76 ca                	jbe    1a92 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ac8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1acb:	8b 40 04             	mov    0x4(%eax),%eax
    1ace:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1ad5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ad8:	01 c2                	add    %eax,%edx
    1ada:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1add:	8b 00                	mov    (%eax),%eax
    1adf:	39 c2                	cmp    %eax,%edx
    1ae1:	75 24                	jne    1b07 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1ae3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ae6:	8b 50 04             	mov    0x4(%eax),%edx
    1ae9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aec:	8b 00                	mov    (%eax),%eax
    1aee:	8b 40 04             	mov    0x4(%eax),%eax
    1af1:	01 c2                	add    %eax,%edx
    1af3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1af6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1af9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1afc:	8b 00                	mov    (%eax),%eax
    1afe:	8b 10                	mov    (%eax),%edx
    1b00:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b03:	89 10                	mov    %edx,(%eax)
    1b05:	eb 0a                	jmp    1b11 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1b07:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b0a:	8b 10                	mov    (%eax),%edx
    1b0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b0f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1b11:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b14:	8b 40 04             	mov    0x4(%eax),%eax
    1b17:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1b1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b21:	01 d0                	add    %edx,%eax
    1b23:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b26:	75 20                	jne    1b48 <free+0xcf>
    p->s.size += bp->s.size;
    1b28:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b2b:	8b 50 04             	mov    0x4(%eax),%edx
    1b2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b31:	8b 40 04             	mov    0x4(%eax),%eax
    1b34:	01 c2                	add    %eax,%edx
    1b36:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b39:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1b3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b3f:	8b 10                	mov    (%eax),%edx
    1b41:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b44:	89 10                	mov    %edx,(%eax)
    1b46:	eb 08                	jmp    1b50 <free+0xd7>
  } else
    p->s.ptr = bp;
    1b48:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b4b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1b4e:	89 10                	mov    %edx,(%eax)
  freep = p;
    1b50:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b53:	a3 6c 24 00 00       	mov    %eax,0x246c
}
    1b58:	c9                   	leave  
    1b59:	c3                   	ret    

00001b5a <morecore>:

static Header*
morecore(uint nu)
{
    1b5a:	55                   	push   %ebp
    1b5b:	89 e5                	mov    %esp,%ebp
    1b5d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1b60:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1b67:	77 07                	ja     1b70 <morecore+0x16>
    nu = 4096;
    1b69:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1b70:	8b 45 08             	mov    0x8(%ebp),%eax
    1b73:	c1 e0 03             	shl    $0x3,%eax
    1b76:	83 ec 0c             	sub    $0xc,%esp
    1b79:	50                   	push   %eax
    1b7a:	e8 75 fc ff ff       	call   17f4 <sbrk>
    1b7f:	83 c4 10             	add    $0x10,%esp
    1b82:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1b85:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1b89:	75 07                	jne    1b92 <morecore+0x38>
    return 0;
    1b8b:	b8 00 00 00 00       	mov    $0x0,%eax
    1b90:	eb 26                	jmp    1bb8 <morecore+0x5e>
  hp = (Header*)p;
    1b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1b98:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b9b:	8b 55 08             	mov    0x8(%ebp),%edx
    1b9e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1ba1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ba4:	83 c0 08             	add    $0x8,%eax
    1ba7:	83 ec 0c             	sub    $0xc,%esp
    1baa:	50                   	push   %eax
    1bab:	e8 c9 fe ff ff       	call   1a79 <free>
    1bb0:	83 c4 10             	add    $0x10,%esp
  return freep;
    1bb3:	a1 6c 24 00 00       	mov    0x246c,%eax
}
    1bb8:	c9                   	leave  
    1bb9:	c3                   	ret    

00001bba <malloc>:

void*
malloc(uint nbytes)
{
    1bba:	55                   	push   %ebp
    1bbb:	89 e5                	mov    %esp,%ebp
    1bbd:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1bc0:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc3:	83 c0 07             	add    $0x7,%eax
    1bc6:	c1 e8 03             	shr    $0x3,%eax
    1bc9:	83 c0 01             	add    $0x1,%eax
    1bcc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1bcf:	a1 6c 24 00 00       	mov    0x246c,%eax
    1bd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bd7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1bdb:	75 23                	jne    1c00 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1bdd:	c7 45 f0 64 24 00 00 	movl   $0x2464,-0x10(%ebp)
    1be4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1be7:	a3 6c 24 00 00       	mov    %eax,0x246c
    1bec:	a1 6c 24 00 00       	mov    0x246c,%eax
    1bf1:	a3 64 24 00 00       	mov    %eax,0x2464
    base.s.size = 0;
    1bf6:	c7 05 68 24 00 00 00 	movl   $0x0,0x2468
    1bfd:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c00:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c03:	8b 00                	mov    (%eax),%eax
    1c05:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1c08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c0b:	8b 40 04             	mov    0x4(%eax),%eax
    1c0e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1c11:	72 4d                	jb     1c60 <malloc+0xa6>
      if(p->s.size == nunits)
    1c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c16:	8b 40 04             	mov    0x4(%eax),%eax
    1c19:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1c1c:	75 0c                	jne    1c2a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c21:	8b 10                	mov    (%eax),%edx
    1c23:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c26:	89 10                	mov    %edx,(%eax)
    1c28:	eb 26                	jmp    1c50 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c2d:	8b 40 04             	mov    0x4(%eax),%eax
    1c30:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1c33:	89 c2                	mov    %eax,%edx
    1c35:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c38:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c3e:	8b 40 04             	mov    0x4(%eax),%eax
    1c41:	c1 e0 03             	shl    $0x3,%eax
    1c44:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c4a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1c4d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c53:	a3 6c 24 00 00       	mov    %eax,0x246c
      return (void*)(p + 1);
    1c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c5b:	83 c0 08             	add    $0x8,%eax
    1c5e:	eb 3b                	jmp    1c9b <malloc+0xe1>
    }
    if(p == freep)
    1c60:	a1 6c 24 00 00       	mov    0x246c,%eax
    1c65:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1c68:	75 1e                	jne    1c88 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1c6a:	83 ec 0c             	sub    $0xc,%esp
    1c6d:	ff 75 ec             	pushl  -0x14(%ebp)
    1c70:	e8 e5 fe ff ff       	call   1b5a <morecore>
    1c75:	83 c4 10             	add    $0x10,%esp
    1c78:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1c7b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c7f:	75 07                	jne    1c88 <malloc+0xce>
        return 0;
    1c81:	b8 00 00 00 00       	mov    $0x0,%eax
    1c86:	eb 13                	jmp    1c9b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c88:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c91:	8b 00                	mov    (%eax),%eax
    1c93:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1c96:	e9 6d ff ff ff       	jmp    1c08 <malloc+0x4e>
}
    1c9b:	c9                   	leave  
    1c9c:	c3                   	ret    
