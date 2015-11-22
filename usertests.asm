
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "iput test\n");
       6:	a1 f0 66 00 00       	mov    0x66f0,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 4a 48 00 00       	push   $0x484a
      13:	50                   	push   %eax
      14:	e8 67 44 00 00       	call   4480 <printf>
      19:	83 c4 10             	add    $0x10,%esp

  if(mkdir("iputdir") < 0){
      1c:	83 ec 0c             	sub    $0xc,%esp
      1f:	68 55 48 00 00       	push   $0x4855
      24:	e8 42 43 00 00       	call   436b <mkdir>
      29:	83 c4 10             	add    $0x10,%esp
      2c:	85 c0                	test   %eax,%eax
      2e:	79 20                	jns    50 <iputtest+0x50>
    printf(stdout, "mkdir failed\n");
      30:	a1 f0 66 00 00       	mov    0x66f0,%eax
      35:	83 ec 08             	sub    $0x8,%esp
      38:	68 5d 48 00 00       	push   $0x485d
      3d:	50                   	push   %eax
      3e:	e8 3d 44 00 00       	call   4480 <printf>
      43:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
      46:	83 ec 0c             	sub    $0xc,%esp
      49:	6a 01                	push   $0x1
      4b:	e8 b3 42 00 00       	call   4303 <exit>
  }
  if(chdir("iputdir") < 0){
      50:	83 ec 0c             	sub    $0xc,%esp
      53:	68 55 48 00 00       	push   $0x4855
      58:	e8 16 43 00 00       	call   4373 <chdir>
      5d:	83 c4 10             	add    $0x10,%esp
      60:	85 c0                	test   %eax,%eax
      62:	79 20                	jns    84 <iputtest+0x84>
    printf(stdout, "chdir iputdir failed\n");
      64:	a1 f0 66 00 00       	mov    0x66f0,%eax
      69:	83 ec 08             	sub    $0x8,%esp
      6c:	68 6b 48 00 00       	push   $0x486b
      71:	50                   	push   %eax
      72:	e8 09 44 00 00       	call   4480 <printf>
      77:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
      7a:	83 ec 0c             	sub    $0xc,%esp
      7d:	6a 01                	push   $0x1
      7f:	e8 7f 42 00 00       	call   4303 <exit>
  }
  if(unlink("../iputdir") < 0){
      84:	83 ec 0c             	sub    $0xc,%esp
      87:	68 81 48 00 00       	push   $0x4881
      8c:	e8 c2 42 00 00       	call   4353 <unlink>
      91:	83 c4 10             	add    $0x10,%esp
      94:	85 c0                	test   %eax,%eax
      96:	79 20                	jns    b8 <iputtest+0xb8>
    printf(stdout, "unlink ../iputdir failed\n");
      98:	a1 f0 66 00 00       	mov    0x66f0,%eax
      9d:	83 ec 08             	sub    $0x8,%esp
      a0:	68 8c 48 00 00       	push   $0x488c
      a5:	50                   	push   %eax
      a6:	e8 d5 43 00 00       	call   4480 <printf>
      ab:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
      ae:	83 ec 0c             	sub    $0xc,%esp
      b1:	6a 01                	push   $0x1
      b3:	e8 4b 42 00 00       	call   4303 <exit>
  }
  if(chdir("/") < 0){
      b8:	83 ec 0c             	sub    $0xc,%esp
      bb:	68 a6 48 00 00       	push   $0x48a6
      c0:	e8 ae 42 00 00       	call   4373 <chdir>
      c5:	83 c4 10             	add    $0x10,%esp
      c8:	85 c0                	test   %eax,%eax
      ca:	79 20                	jns    ec <iputtest+0xec>
    printf(stdout, "chdir / failed\n");
      cc:	a1 f0 66 00 00       	mov    0x66f0,%eax
      d1:	83 ec 08             	sub    $0x8,%esp
      d4:	68 a8 48 00 00       	push   $0x48a8
      d9:	50                   	push   %eax
      da:	e8 a1 43 00 00       	call   4480 <printf>
      df:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
      e2:	83 ec 0c             	sub    $0xc,%esp
      e5:	6a 01                	push   $0x1
      e7:	e8 17 42 00 00       	call   4303 <exit>
  }
  printf(stdout, "iput test ok\n");
      ec:	a1 f0 66 00 00       	mov    0x66f0,%eax
      f1:	83 ec 08             	sub    $0x8,%esp
      f4:	68 b8 48 00 00       	push   $0x48b8
      f9:	50                   	push   %eax
      fa:	e8 81 43 00 00       	call   4480 <printf>
      ff:	83 c4 10             	add    $0x10,%esp
}
     102:	c9                   	leave  
     103:	c3                   	ret    

00000104 <exitiputtest>:

// does exit(EXIT_STATUS_OK) call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     104:	55                   	push   %ebp
     105:	89 e5                	mov    %esp,%ebp
     107:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
     10a:	a1 f0 66 00 00       	mov    0x66f0,%eax
     10f:	83 ec 08             	sub    $0x8,%esp
     112:	68 c6 48 00 00       	push   $0x48c6
     117:	50                   	push   %eax
     118:	e8 63 43 00 00       	call   4480 <printf>
     11d:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     120:	e8 d6 41 00 00       	call   42fb <fork>
     125:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     128:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     12c:	79 20                	jns    14e <exitiputtest+0x4a>
    printf(stdout, "fork failed\n");
     12e:	a1 f0 66 00 00       	mov    0x66f0,%eax
     133:	83 ec 08             	sub    $0x8,%esp
     136:	68 d5 48 00 00       	push   $0x48d5
     13b:	50                   	push   %eax
     13c:	e8 3f 43 00 00       	call   4480 <printf>
     141:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     144:	83 ec 0c             	sub    $0xc,%esp
     147:	6a 01                	push   $0x1
     149:	e8 b5 41 00 00       	call   4303 <exit>
  }
  if(pid == 0){
     14e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     152:	0f 85 a6 00 00 00    	jne    1fe <exitiputtest+0xfa>
    if(mkdir("iputdir") < 0){
     158:	83 ec 0c             	sub    $0xc,%esp
     15b:	68 55 48 00 00       	push   $0x4855
     160:	e8 06 42 00 00       	call   436b <mkdir>
     165:	83 c4 10             	add    $0x10,%esp
     168:	85 c0                	test   %eax,%eax
     16a:	79 20                	jns    18c <exitiputtest+0x88>
      printf(stdout, "mkdir failed\n");
     16c:	a1 f0 66 00 00       	mov    0x66f0,%eax
     171:	83 ec 08             	sub    $0x8,%esp
     174:	68 5d 48 00 00       	push   $0x485d
     179:	50                   	push   %eax
     17a:	e8 01 43 00 00       	call   4480 <printf>
     17f:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     182:	83 ec 0c             	sub    $0xc,%esp
     185:	6a 01                	push   $0x1
     187:	e8 77 41 00 00       	call   4303 <exit>
    }
    if(chdir("iputdir") < 0){
     18c:	83 ec 0c             	sub    $0xc,%esp
     18f:	68 55 48 00 00       	push   $0x4855
     194:	e8 da 41 00 00       	call   4373 <chdir>
     199:	83 c4 10             	add    $0x10,%esp
     19c:	85 c0                	test   %eax,%eax
     19e:	79 20                	jns    1c0 <exitiputtest+0xbc>
      printf(stdout, "child chdir failed\n");
     1a0:	a1 f0 66 00 00       	mov    0x66f0,%eax
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 e2 48 00 00       	push   $0x48e2
     1ad:	50                   	push   %eax
     1ae:	e8 cd 42 00 00       	call   4480 <printf>
     1b3:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     1b6:	83 ec 0c             	sub    $0xc,%esp
     1b9:	6a 01                	push   $0x1
     1bb:	e8 43 41 00 00       	call   4303 <exit>
    }
    if(unlink("../iputdir") < 0){
     1c0:	83 ec 0c             	sub    $0xc,%esp
     1c3:	68 81 48 00 00       	push   $0x4881
     1c8:	e8 86 41 00 00       	call   4353 <unlink>
     1cd:	83 c4 10             	add    $0x10,%esp
     1d0:	85 c0                	test   %eax,%eax
     1d2:	79 20                	jns    1f4 <exitiputtest+0xf0>
      printf(stdout, "unlink ../iputdir failed\n");
     1d4:	a1 f0 66 00 00       	mov    0x66f0,%eax
     1d9:	83 ec 08             	sub    $0x8,%esp
     1dc:	68 8c 48 00 00       	push   $0x488c
     1e1:	50                   	push   %eax
     1e2:	e8 99 42 00 00       	call   4480 <printf>
     1e7:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     1ea:	83 ec 0c             	sub    $0xc,%esp
     1ed:	6a 01                	push   $0x1
     1ef:	e8 0f 41 00 00       	call   4303 <exit>
    }
    exit(EXIT_STATUS_OK);
     1f4:	83 ec 0c             	sub    $0xc,%esp
     1f7:	6a 01                	push   $0x1
     1f9:	e8 05 41 00 00       	call   4303 <exit>
  }
  wait(0);
     1fe:	83 ec 0c             	sub    $0xc,%esp
     201:	6a 00                	push   $0x0
     203:	e8 03 41 00 00       	call   430b <wait>
     208:	83 c4 10             	add    $0x10,%esp
  printf(stdout, "exitiput test ok\n");
     20b:	a1 f0 66 00 00       	mov    0x66f0,%eax
     210:	83 ec 08             	sub    $0x8,%esp
     213:	68 f6 48 00 00       	push   $0x48f6
     218:	50                   	push   %eax
     219:	e8 62 42 00 00       	call   4480 <printf>
     21e:	83 c4 10             	add    $0x10,%esp
}
     221:	c9                   	leave  
     222:	c3                   	ret    

00000223 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     223:	55                   	push   %ebp
     224:	89 e5                	mov    %esp,%ebp
     226:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
     229:	a1 f0 66 00 00       	mov    0x66f0,%eax
     22e:	83 ec 08             	sub    $0x8,%esp
     231:	68 08 49 00 00       	push   $0x4908
     236:	50                   	push   %eax
     237:	e8 44 42 00 00       	call   4480 <printf>
     23c:	83 c4 10             	add    $0x10,%esp
  if(mkdir("oidir") < 0){
     23f:	83 ec 0c             	sub    $0xc,%esp
     242:	68 17 49 00 00       	push   $0x4917
     247:	e8 1f 41 00 00       	call   436b <mkdir>
     24c:	83 c4 10             	add    $0x10,%esp
     24f:	85 c0                	test   %eax,%eax
     251:	79 20                	jns    273 <openiputtest+0x50>
    printf(stdout, "mkdir oidir failed\n");
     253:	a1 f0 66 00 00       	mov    0x66f0,%eax
     258:	83 ec 08             	sub    $0x8,%esp
     25b:	68 1d 49 00 00       	push   $0x491d
     260:	50                   	push   %eax
     261:	e8 1a 42 00 00       	call   4480 <printf>
     266:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     269:	83 ec 0c             	sub    $0xc,%esp
     26c:	6a 01                	push   $0x1
     26e:	e8 90 40 00 00       	call   4303 <exit>
  }
  pid = fork();
     273:	e8 83 40 00 00       	call   42fb <fork>
     278:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     27b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     27f:	79 20                	jns    2a1 <openiputtest+0x7e>
    printf(stdout, "fork failed\n");
     281:	a1 f0 66 00 00       	mov    0x66f0,%eax
     286:	83 ec 08             	sub    $0x8,%esp
     289:	68 d5 48 00 00       	push   $0x48d5
     28e:	50                   	push   %eax
     28f:	e8 ec 41 00 00       	call   4480 <printf>
     294:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     297:	83 ec 0c             	sub    $0xc,%esp
     29a:	6a 01                	push   $0x1
     29c:	e8 62 40 00 00       	call   4303 <exit>
  }
  if(pid == 0){
     2a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2a5:	75 45                	jne    2ec <openiputtest+0xc9>
    int fd = open("oidir", O_RDWR);
     2a7:	83 ec 08             	sub    $0x8,%esp
     2aa:	6a 02                	push   $0x2
     2ac:	68 17 49 00 00       	push   $0x4917
     2b1:	e8 8d 40 00 00       	call   4343 <open>
     2b6:	83 c4 10             	add    $0x10,%esp
     2b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
     2bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2c0:	78 20                	js     2e2 <openiputtest+0xbf>
      printf(stdout, "open directory for write succeeded\n");
     2c2:	a1 f0 66 00 00       	mov    0x66f0,%eax
     2c7:	83 ec 08             	sub    $0x8,%esp
     2ca:	68 34 49 00 00       	push   $0x4934
     2cf:	50                   	push   %eax
     2d0:	e8 ab 41 00 00       	call   4480 <printf>
     2d5:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     2d8:	83 ec 0c             	sub    $0xc,%esp
     2db:	6a 01                	push   $0x1
     2dd:	e8 21 40 00 00       	call   4303 <exit>
    }
    exit(EXIT_STATUS_OK);
     2e2:	83 ec 0c             	sub    $0xc,%esp
     2e5:	6a 01                	push   $0x1
     2e7:	e8 17 40 00 00       	call   4303 <exit>
  }
  sleep(1);
     2ec:	83 ec 0c             	sub    $0xc,%esp
     2ef:	6a 01                	push   $0x1
     2f1:	e8 9d 40 00 00       	call   4393 <sleep>
     2f6:	83 c4 10             	add    $0x10,%esp
  if(unlink("oidir") != 0){
     2f9:	83 ec 0c             	sub    $0xc,%esp
     2fc:	68 17 49 00 00       	push   $0x4917
     301:	e8 4d 40 00 00       	call   4353 <unlink>
     306:	83 c4 10             	add    $0x10,%esp
     309:	85 c0                	test   %eax,%eax
     30b:	74 20                	je     32d <openiputtest+0x10a>
    printf(stdout, "unlink failed\n");
     30d:	a1 f0 66 00 00       	mov    0x66f0,%eax
     312:	83 ec 08             	sub    $0x8,%esp
     315:	68 58 49 00 00       	push   $0x4958
     31a:	50                   	push   %eax
     31b:	e8 60 41 00 00       	call   4480 <printf>
     320:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     323:	83 ec 0c             	sub    $0xc,%esp
     326:	6a 01                	push   $0x1
     328:	e8 d6 3f 00 00       	call   4303 <exit>
  }
  wait(0);
     32d:	83 ec 0c             	sub    $0xc,%esp
     330:	6a 00                	push   $0x0
     332:	e8 d4 3f 00 00       	call   430b <wait>
     337:	83 c4 10             	add    $0x10,%esp
  printf(stdout, "openiput test ok\n");
     33a:	a1 f0 66 00 00       	mov    0x66f0,%eax
     33f:	83 ec 08             	sub    $0x8,%esp
     342:	68 67 49 00 00       	push   $0x4967
     347:	50                   	push   %eax
     348:	e8 33 41 00 00       	call   4480 <printf>
     34d:	83 c4 10             	add    $0x10,%esp
}
     350:	c9                   	leave  
     351:	c3                   	ret    

00000352 <opentest>:

// simple file system tests

void
opentest(void)
{
     352:	55                   	push   %ebp
     353:	89 e5                	mov    %esp,%ebp
     355:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
     358:	a1 f0 66 00 00       	mov    0x66f0,%eax
     35d:	83 ec 08             	sub    $0x8,%esp
     360:	68 79 49 00 00       	push   $0x4979
     365:	50                   	push   %eax
     366:	e8 15 41 00 00       	call   4480 <printf>
     36b:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
     36e:	83 ec 08             	sub    $0x8,%esp
     371:	6a 00                	push   $0x0
     373:	68 34 48 00 00       	push   $0x4834
     378:	e8 c6 3f 00 00       	call   4343 <open>
     37d:	83 c4 10             	add    $0x10,%esp
     380:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
     383:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     387:	79 20                	jns    3a9 <opentest+0x57>
    printf(stdout, "open echo failed!\n");
     389:	a1 f0 66 00 00       	mov    0x66f0,%eax
     38e:	83 ec 08             	sub    $0x8,%esp
     391:	68 84 49 00 00       	push   $0x4984
     396:	50                   	push   %eax
     397:	e8 e4 40 00 00       	call   4480 <printf>
     39c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     39f:	83 ec 0c             	sub    $0xc,%esp
     3a2:	6a 01                	push   $0x1
     3a4:	e8 5a 3f 00 00       	call   4303 <exit>
  }
  close(fd);
     3a9:	83 ec 0c             	sub    $0xc,%esp
     3ac:	ff 75 f4             	pushl  -0xc(%ebp)
     3af:	e8 77 3f 00 00       	call   432b <close>
     3b4:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
     3b7:	83 ec 08             	sub    $0x8,%esp
     3ba:	6a 00                	push   $0x0
     3bc:	68 97 49 00 00       	push   $0x4997
     3c1:	e8 7d 3f 00 00       	call   4343 <open>
     3c6:	83 c4 10             	add    $0x10,%esp
     3c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
     3cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3d0:	78 20                	js     3f2 <opentest+0xa0>
    printf(stdout, "open doesnotexist succeeded!\n");
     3d2:	a1 f0 66 00 00       	mov    0x66f0,%eax
     3d7:	83 ec 08             	sub    $0x8,%esp
     3da:	68 a4 49 00 00       	push   $0x49a4
     3df:	50                   	push   %eax
     3e0:	e8 9b 40 00 00       	call   4480 <printf>
     3e5:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     3e8:	83 ec 0c             	sub    $0xc,%esp
     3eb:	6a 01                	push   $0x1
     3ed:	e8 11 3f 00 00       	call   4303 <exit>
  }
  printf(stdout, "open test ok\n");
     3f2:	a1 f0 66 00 00       	mov    0x66f0,%eax
     3f7:	83 ec 08             	sub    $0x8,%esp
     3fa:	68 c2 49 00 00       	push   $0x49c2
     3ff:	50                   	push   %eax
     400:	e8 7b 40 00 00       	call   4480 <printf>
     405:	83 c4 10             	add    $0x10,%esp
}
     408:	c9                   	leave  
     409:	c3                   	ret    

0000040a <writetest>:

void
writetest(void)
{
     40a:	55                   	push   %ebp
     40b:	89 e5                	mov    %esp,%ebp
     40d:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     410:	a1 f0 66 00 00       	mov    0x66f0,%eax
     415:	83 ec 08             	sub    $0x8,%esp
     418:	68 d0 49 00 00       	push   $0x49d0
     41d:	50                   	push   %eax
     41e:	e8 5d 40 00 00       	call   4480 <printf>
     423:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
     426:	83 ec 08             	sub    $0x8,%esp
     429:	68 02 02 00 00       	push   $0x202
     42e:	68 e1 49 00 00       	push   $0x49e1
     433:	e8 0b 3f 00 00       	call   4343 <open>
     438:	83 c4 10             	add    $0x10,%esp
     43b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     43e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     442:	78 22                	js     466 <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
     444:	a1 f0 66 00 00       	mov    0x66f0,%eax
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	68 e7 49 00 00       	push   $0x49e7
     451:	50                   	push   %eax
     452:	e8 29 40 00 00       	call   4480 <printf>
     457:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(EXIT_STATUS_OK);
  }
  for(i = 0; i < 100; i++){
     45a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     461:	e9 9e 00 00 00       	jmp    504 <writetest+0xfa>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     466:	a1 f0 66 00 00       	mov    0x66f0,%eax
     46b:	83 ec 08             	sub    $0x8,%esp
     46e:	68 02 4a 00 00       	push   $0x4a02
     473:	50                   	push   %eax
     474:	e8 07 40 00 00       	call   4480 <printf>
     479:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     47c:	83 ec 0c             	sub    $0xc,%esp
     47f:	6a 01                	push   $0x1
     481:	e8 7d 3e 00 00       	call   4303 <exit>
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     486:	83 ec 04             	sub    $0x4,%esp
     489:	6a 0a                	push   $0xa
     48b:	68 1e 4a 00 00       	push   $0x4a1e
     490:	ff 75 f0             	pushl  -0x10(%ebp)
     493:	e8 8b 3e 00 00       	call   4323 <write>
     498:	83 c4 10             	add    $0x10,%esp
     49b:	83 f8 0a             	cmp    $0xa,%eax
     49e:	74 23                	je     4c3 <writetest+0xb9>
      printf(stdout, "error: write aa %d new file failed\n", i);
     4a0:	a1 f0 66 00 00       	mov    0x66f0,%eax
     4a5:	83 ec 04             	sub    $0x4,%esp
     4a8:	ff 75 f4             	pushl  -0xc(%ebp)
     4ab:	68 2c 4a 00 00       	push   $0x4a2c
     4b0:	50                   	push   %eax
     4b1:	e8 ca 3f 00 00       	call   4480 <printf>
     4b6:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     4b9:	83 ec 0c             	sub    $0xc,%esp
     4bc:	6a 01                	push   $0x1
     4be:	e8 40 3e 00 00       	call   4303 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4c3:	83 ec 04             	sub    $0x4,%esp
     4c6:	6a 0a                	push   $0xa
     4c8:	68 50 4a 00 00       	push   $0x4a50
     4cd:	ff 75 f0             	pushl  -0x10(%ebp)
     4d0:	e8 4e 3e 00 00       	call   4323 <write>
     4d5:	83 c4 10             	add    $0x10,%esp
     4d8:	83 f8 0a             	cmp    $0xa,%eax
     4db:	74 23                	je     500 <writetest+0xf6>
      printf(stdout, "error: write bb %d new file failed\n", i);
     4dd:	a1 f0 66 00 00       	mov    0x66f0,%eax
     4e2:	83 ec 04             	sub    $0x4,%esp
     4e5:	ff 75 f4             	pushl  -0xc(%ebp)
     4e8:	68 5c 4a 00 00       	push   $0x4a5c
     4ed:	50                   	push   %eax
     4ee:	e8 8d 3f 00 00       	call   4480 <printf>
     4f3:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     4f6:	83 ec 0c             	sub    $0xc,%esp
     4f9:	6a 01                	push   $0x1
     4fb:	e8 03 3e 00 00       	call   4303 <exit>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit(EXIT_STATUS_OK);
  }
  for(i = 0; i < 100; i++){
     500:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     504:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     508:	0f 8e 78 ff ff ff    	jle    486 <writetest+0x7c>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit(EXIT_STATUS_OK);
    }
  }
  printf(stdout, "writes ok\n");
     50e:	a1 f0 66 00 00       	mov    0x66f0,%eax
     513:	83 ec 08             	sub    $0x8,%esp
     516:	68 80 4a 00 00       	push   $0x4a80
     51b:	50                   	push   %eax
     51c:	e8 5f 3f 00 00       	call   4480 <printf>
     521:	83 c4 10             	add    $0x10,%esp
  close(fd);
     524:	83 ec 0c             	sub    $0xc,%esp
     527:	ff 75 f0             	pushl  -0x10(%ebp)
     52a:	e8 fc 3d 00 00       	call   432b <close>
     52f:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     532:	83 ec 08             	sub    $0x8,%esp
     535:	6a 00                	push   $0x0
     537:	68 e1 49 00 00       	push   $0x49e1
     53c:	e8 02 3e 00 00       	call   4343 <open>
     541:	83 c4 10             	add    $0x10,%esp
     544:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     547:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     54b:	78 3c                	js     589 <writetest+0x17f>
    printf(stdout, "open small succeeded ok\n");
     54d:	a1 f0 66 00 00       	mov    0x66f0,%eax
     552:	83 ec 08             	sub    $0x8,%esp
     555:	68 8b 4a 00 00       	push   $0x4a8b
     55a:	50                   	push   %eax
     55b:	e8 20 3f 00 00       	call   4480 <printf>
     560:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit(EXIT_STATUS_OK);
  }
  i = read(fd, buf, 2000);
     563:	83 ec 04             	sub    $0x4,%esp
     566:	68 d0 07 00 00       	push   $0x7d0
     56b:	68 40 8f 00 00       	push   $0x8f40
     570:	ff 75 f0             	pushl  -0x10(%ebp)
     573:	e8 a3 3d 00 00       	call   431b <read>
     578:	83 c4 10             	add    $0x10,%esp
     57b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     57e:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     585:	75 5c                	jne    5e3 <writetest+0x1d9>
     587:	eb 20                	jmp    5a9 <writetest+0x19f>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     589:	a1 f0 66 00 00       	mov    0x66f0,%eax
     58e:	83 ec 08             	sub    $0x8,%esp
     591:	68 a4 4a 00 00       	push   $0x4aa4
     596:	50                   	push   %eax
     597:	e8 e4 3e 00 00       	call   4480 <printf>
     59c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     59f:	83 ec 0c             	sub    $0xc,%esp
     5a2:	6a 01                	push   $0x1
     5a4:	e8 5a 3d 00 00       	call   4303 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
     5a9:	a1 f0 66 00 00       	mov    0x66f0,%eax
     5ae:	83 ec 08             	sub    $0x8,%esp
     5b1:	68 bf 4a 00 00       	push   $0x4abf
     5b6:	50                   	push   %eax
     5b7:	e8 c4 3e 00 00       	call   4480 <printf>
     5bc:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit(EXIT_STATUS_OK);
  }
  close(fd);
     5bf:	83 ec 0c             	sub    $0xc,%esp
     5c2:	ff 75 f0             	pushl  -0x10(%ebp)
     5c5:	e8 61 3d 00 00       	call   432b <close>
     5ca:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     5cd:	83 ec 0c             	sub    $0xc,%esp
     5d0:	68 e1 49 00 00       	push   $0x49e1
     5d5:	e8 79 3d 00 00       	call   4353 <unlink>
     5da:	83 c4 10             	add    $0x10,%esp
     5dd:	85 c0                	test   %eax,%eax
     5df:	79 42                	jns    623 <writetest+0x219>
     5e1:	eb 20                	jmp    603 <writetest+0x1f9>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     5e3:	a1 f0 66 00 00       	mov    0x66f0,%eax
     5e8:	83 ec 08             	sub    $0x8,%esp
     5eb:	68 d2 4a 00 00       	push   $0x4ad2
     5f0:	50                   	push   %eax
     5f1:	e8 8a 3e 00 00       	call   4480 <printf>
     5f6:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     5f9:	83 ec 0c             	sub    $0xc,%esp
     5fc:	6a 01                	push   $0x1
     5fe:	e8 00 3d 00 00       	call   4303 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     603:	a1 f0 66 00 00       	mov    0x66f0,%eax
     608:	83 ec 08             	sub    $0x8,%esp
     60b:	68 df 4a 00 00       	push   $0x4adf
     610:	50                   	push   %eax
     611:	e8 6a 3e 00 00       	call   4480 <printf>
     616:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     619:	83 ec 0c             	sub    $0xc,%esp
     61c:	6a 01                	push   $0x1
     61e:	e8 e0 3c 00 00       	call   4303 <exit>
  }
  printf(stdout, "small file test ok\n");
     623:	a1 f0 66 00 00       	mov    0x66f0,%eax
     628:	83 ec 08             	sub    $0x8,%esp
     62b:	68 f4 4a 00 00       	push   $0x4af4
     630:	50                   	push   %eax
     631:	e8 4a 3e 00 00       	call   4480 <printf>
     636:	83 c4 10             	add    $0x10,%esp
}
     639:	c9                   	leave  
     63a:	c3                   	ret    

0000063b <writetest1>:

void
writetest1(void)
{
     63b:	55                   	push   %ebp
     63c:	89 e5                	mov    %esp,%ebp
     63e:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     641:	a1 f0 66 00 00       	mov    0x66f0,%eax
     646:	83 ec 08             	sub    $0x8,%esp
     649:	68 08 4b 00 00       	push   $0x4b08
     64e:	50                   	push   %eax
     64f:	e8 2c 3e 00 00       	call   4480 <printf>
     654:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     657:	83 ec 08             	sub    $0x8,%esp
     65a:	68 02 02 00 00       	push   $0x202
     65f:	68 18 4b 00 00       	push   $0x4b18
     664:	e8 da 3c 00 00       	call   4343 <open>
     669:	83 c4 10             	add    $0x10,%esp
     66c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     66f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     673:	79 20                	jns    695 <writetest1+0x5a>
    printf(stdout, "error: creat big failed!\n");
     675:	a1 f0 66 00 00       	mov    0x66f0,%eax
     67a:	83 ec 08             	sub    $0x8,%esp
     67d:	68 1c 4b 00 00       	push   $0x4b1c
     682:	50                   	push   %eax
     683:	e8 f8 3d 00 00       	call   4480 <printf>
     688:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     68b:	83 ec 0c             	sub    $0xc,%esp
     68e:	6a 01                	push   $0x1
     690:	e8 6e 3c 00 00       	call   4303 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     695:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     69c:	eb 50                	jmp    6ee <writetest1+0xb3>
    ((int*)buf)[0] = i;
     69e:	ba 40 8f 00 00       	mov    $0x8f40,%edx
     6a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a6:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     6a8:	83 ec 04             	sub    $0x4,%esp
     6ab:	68 00 02 00 00       	push   $0x200
     6b0:	68 40 8f 00 00       	push   $0x8f40
     6b5:	ff 75 ec             	pushl  -0x14(%ebp)
     6b8:	e8 66 3c 00 00       	call   4323 <write>
     6bd:	83 c4 10             	add    $0x10,%esp
     6c0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6c5:	74 23                	je     6ea <writetest1+0xaf>
      printf(stdout, "error: write big file failed\n", i);
     6c7:	a1 f0 66 00 00       	mov    0x66f0,%eax
     6cc:	83 ec 04             	sub    $0x4,%esp
     6cf:	ff 75 f4             	pushl  -0xc(%ebp)
     6d2:	68 36 4b 00 00       	push   $0x4b36
     6d7:	50                   	push   %eax
     6d8:	e8 a3 3d 00 00       	call   4480 <printf>
     6dd:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     6e0:	83 ec 0c             	sub    $0xc,%esp
     6e3:	6a 01                	push   $0x1
     6e5:	e8 19 3c 00 00       	call   4303 <exit>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit(EXIT_STATUS_OK);
  }

  for(i = 0; i < MAXFILE; i++){
     6ea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     6ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f1:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     6f6:	76 a6                	jbe    69e <writetest1+0x63>
      printf(stdout, "error: write big file failed\n", i);
      exit(EXIT_STATUS_OK);
    }
  }

  close(fd);
     6f8:	83 ec 0c             	sub    $0xc,%esp
     6fb:	ff 75 ec             	pushl  -0x14(%ebp)
     6fe:	e8 28 3c 00 00       	call   432b <close>
     703:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     706:	83 ec 08             	sub    $0x8,%esp
     709:	6a 00                	push   $0x0
     70b:	68 18 4b 00 00       	push   $0x4b18
     710:	e8 2e 3c 00 00       	call   4343 <open>
     715:	83 c4 10             	add    $0x10,%esp
     718:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     71b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     71f:	79 20                	jns    741 <writetest1+0x106>
    printf(stdout, "error: open big failed!\n");
     721:	a1 f0 66 00 00       	mov    0x66f0,%eax
     726:	83 ec 08             	sub    $0x8,%esp
     729:	68 54 4b 00 00       	push   $0x4b54
     72e:	50                   	push   %eax
     72f:	e8 4c 3d 00 00       	call   4480 <printf>
     734:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     737:	83 ec 0c             	sub    $0xc,%esp
     73a:	6a 01                	push   $0x1
     73c:	e8 c2 3b 00 00       	call   4303 <exit>
  }

  n = 0;
     741:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     748:	83 ec 04             	sub    $0x4,%esp
     74b:	68 00 02 00 00       	push   $0x200
     750:	68 40 8f 00 00       	push   $0x8f40
     755:	ff 75 ec             	pushl  -0x14(%ebp)
     758:	e8 be 3b 00 00       	call   431b <read>
     75d:	83 c4 10             	add    $0x10,%esp
     760:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     763:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     767:	75 55                	jne    7be <writetest1+0x183>
      if(n == MAXFILE - 1){
     769:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     770:	75 23                	jne    795 <writetest1+0x15a>
        printf(stdout, "read only %d blocks from big", n);
     772:	a1 f0 66 00 00       	mov    0x66f0,%eax
     777:	83 ec 04             	sub    $0x4,%esp
     77a:	ff 75 f0             	pushl  -0x10(%ebp)
     77d:	68 6d 4b 00 00       	push   $0x4b6d
     782:	50                   	push   %eax
     783:	e8 f8 3c 00 00       	call   4480 <printf>
     788:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
     78b:	83 ec 0c             	sub    $0xc,%esp
     78e:	6a 01                	push   $0x1
     790:	e8 6e 3b 00 00       	call   4303 <exit>
      }
      break;
     795:	90                   	nop
             n, ((int*)buf)[0]);
      exit(EXIT_STATUS_OK);
    }
    n++;
  }
  close(fd);
     796:	83 ec 0c             	sub    $0xc,%esp
     799:	ff 75 ec             	pushl  -0x14(%ebp)
     79c:	e8 8a 3b 00 00       	call   432b <close>
     7a1:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     7a4:	83 ec 0c             	sub    $0xc,%esp
     7a7:	68 18 4b 00 00       	push   $0x4b18
     7ac:	e8 a2 3b 00 00       	call   4353 <unlink>
     7b1:	83 c4 10             	add    $0x10,%esp
     7b4:	85 c0                	test   %eax,%eax
     7b6:	0f 89 8b 00 00 00    	jns    847 <writetest1+0x20c>
     7bc:	eb 69                	jmp    827 <writetest1+0x1ec>
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit(EXIT_STATUS_OK);
      }
      break;
    } else if(i != 512){
     7be:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     7c5:	74 23                	je     7ea <writetest1+0x1af>
      printf(stdout, "read failed %d\n", i);
     7c7:	a1 f0 66 00 00       	mov    0x66f0,%eax
     7cc:	83 ec 04             	sub    $0x4,%esp
     7cf:	ff 75 f4             	pushl  -0xc(%ebp)
     7d2:	68 8a 4b 00 00       	push   $0x4b8a
     7d7:	50                   	push   %eax
     7d8:	e8 a3 3c 00 00       	call   4480 <printf>
     7dd:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     7e0:	83 ec 0c             	sub    $0xc,%esp
     7e3:	6a 01                	push   $0x1
     7e5:	e8 19 3b 00 00       	call   4303 <exit>
    }
    if(((int*)buf)[0] != n){
     7ea:	b8 40 8f 00 00       	mov    $0x8f40,%eax
     7ef:	8b 00                	mov    (%eax),%eax
     7f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     7f4:	74 28                	je     81e <writetest1+0x1e3>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     7f6:	b8 40 8f 00 00       	mov    $0x8f40,%eax
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit(EXIT_STATUS_OK);
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     7fb:	8b 10                	mov    (%eax),%edx
     7fd:	a1 f0 66 00 00       	mov    0x66f0,%eax
     802:	52                   	push   %edx
     803:	ff 75 f0             	pushl  -0x10(%ebp)
     806:	68 9c 4b 00 00       	push   $0x4b9c
     80b:	50                   	push   %eax
     80c:	e8 6f 3c 00 00       	call   4480 <printf>
     811:	83 c4 10             	add    $0x10,%esp
             n, ((int*)buf)[0]);
      exit(EXIT_STATUS_OK);
     814:	83 ec 0c             	sub    $0xc,%esp
     817:	6a 01                	push   $0x1
     819:	e8 e5 3a 00 00       	call   4303 <exit>
    }
    n++;
     81e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }
     822:	e9 21 ff ff ff       	jmp    748 <writetest1+0x10d>
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     827:	a1 f0 66 00 00       	mov    0x66f0,%eax
     82c:	83 ec 08             	sub    $0x8,%esp
     82f:	68 bc 4b 00 00       	push   $0x4bbc
     834:	50                   	push   %eax
     835:	e8 46 3c 00 00       	call   4480 <printf>
     83a:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     83d:	83 ec 0c             	sub    $0xc,%esp
     840:	6a 01                	push   $0x1
     842:	e8 bc 3a 00 00       	call   4303 <exit>
  }
  printf(stdout, "big files ok\n");
     847:	a1 f0 66 00 00       	mov    0x66f0,%eax
     84c:	83 ec 08             	sub    $0x8,%esp
     84f:	68 cf 4b 00 00       	push   $0x4bcf
     854:	50                   	push   %eax
     855:	e8 26 3c 00 00       	call   4480 <printf>
     85a:	83 c4 10             	add    $0x10,%esp
}
     85d:	c9                   	leave  
     85e:	c3                   	ret    

0000085f <createtest>:

void
createtest(void)
{
     85f:	55                   	push   %ebp
     860:	89 e5                	mov    %esp,%ebp
     862:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     865:	a1 f0 66 00 00       	mov    0x66f0,%eax
     86a:	83 ec 08             	sub    $0x8,%esp
     86d:	68 e0 4b 00 00       	push   $0x4be0
     872:	50                   	push   %eax
     873:	e8 08 3c 00 00       	call   4480 <printf>
     878:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     87b:	c6 05 40 af 00 00 61 	movb   $0x61,0xaf40
  name[2] = '\0';
     882:	c6 05 42 af 00 00 00 	movb   $0x0,0xaf42
  for(i = 0; i < 52; i++){
     889:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     890:	eb 35                	jmp    8c7 <createtest+0x68>
    name[1] = '0' + i;
     892:	8b 45 f4             	mov    -0xc(%ebp),%eax
     895:	83 c0 30             	add    $0x30,%eax
     898:	a2 41 af 00 00       	mov    %al,0xaf41
    fd = open(name, O_CREATE|O_RDWR);
     89d:	83 ec 08             	sub    $0x8,%esp
     8a0:	68 02 02 00 00       	push   $0x202
     8a5:	68 40 af 00 00       	push   $0xaf40
     8aa:	e8 94 3a 00 00       	call   4343 <open>
     8af:	83 c4 10             	add    $0x10,%esp
     8b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     8b5:	83 ec 0c             	sub    $0xc,%esp
     8b8:	ff 75 f0             	pushl  -0x10(%ebp)
     8bb:	e8 6b 3a 00 00       	call   432b <close>
     8c0:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     8c3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     8c7:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     8cb:	7e c5                	jle    892 <createtest+0x33>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     8cd:	c6 05 40 af 00 00 61 	movb   $0x61,0xaf40
  name[2] = '\0';
     8d4:	c6 05 42 af 00 00 00 	movb   $0x0,0xaf42
  for(i = 0; i < 52; i++){
     8db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     8e2:	eb 1f                	jmp    903 <createtest+0xa4>
    name[1] = '0' + i;
     8e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e7:	83 c0 30             	add    $0x30,%eax
     8ea:	a2 41 af 00 00       	mov    %al,0xaf41
    unlink(name);
     8ef:	83 ec 0c             	sub    $0xc,%esp
     8f2:	68 40 af 00 00       	push   $0xaf40
     8f7:	e8 57 3a 00 00       	call   4353 <unlink>
     8fc:	83 c4 10             	add    $0x10,%esp
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     8ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     903:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     907:	7e db                	jle    8e4 <createtest+0x85>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     909:	a1 f0 66 00 00       	mov    0x66f0,%eax
     90e:	83 ec 08             	sub    $0x8,%esp
     911:	68 08 4c 00 00       	push   $0x4c08
     916:	50                   	push   %eax
     917:	e8 64 3b 00 00       	call   4480 <printf>
     91c:	83 c4 10             	add    $0x10,%esp
}
     91f:	c9                   	leave  
     920:	c3                   	ret    

00000921 <dirtest>:

void dirtest(void)
{
     921:	55                   	push   %ebp
     922:	89 e5                	mov    %esp,%ebp
     924:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     927:	a1 f0 66 00 00       	mov    0x66f0,%eax
     92c:	83 ec 08             	sub    $0x8,%esp
     92f:	68 2e 4c 00 00       	push   $0x4c2e
     934:	50                   	push   %eax
     935:	e8 46 3b 00 00       	call   4480 <printf>
     93a:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     93d:	83 ec 0c             	sub    $0xc,%esp
     940:	68 3a 4c 00 00       	push   $0x4c3a
     945:	e8 21 3a 00 00       	call   436b <mkdir>
     94a:	83 c4 10             	add    $0x10,%esp
     94d:	85 c0                	test   %eax,%eax
     94f:	79 20                	jns    971 <dirtest+0x50>
    printf(stdout, "mkdir failed\n");
     951:	a1 f0 66 00 00       	mov    0x66f0,%eax
     956:	83 ec 08             	sub    $0x8,%esp
     959:	68 5d 48 00 00       	push   $0x485d
     95e:	50                   	push   %eax
     95f:	e8 1c 3b 00 00       	call   4480 <printf>
     964:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     967:	83 ec 0c             	sub    $0xc,%esp
     96a:	6a 01                	push   $0x1
     96c:	e8 92 39 00 00       	call   4303 <exit>
  }

  if(chdir("dir0") < 0){
     971:	83 ec 0c             	sub    $0xc,%esp
     974:	68 3a 4c 00 00       	push   $0x4c3a
     979:	e8 f5 39 00 00       	call   4373 <chdir>
     97e:	83 c4 10             	add    $0x10,%esp
     981:	85 c0                	test   %eax,%eax
     983:	79 20                	jns    9a5 <dirtest+0x84>
    printf(stdout, "chdir dir0 failed\n");
     985:	a1 f0 66 00 00       	mov    0x66f0,%eax
     98a:	83 ec 08             	sub    $0x8,%esp
     98d:	68 3f 4c 00 00       	push   $0x4c3f
     992:	50                   	push   %eax
     993:	e8 e8 3a 00 00       	call   4480 <printf>
     998:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     99b:	83 ec 0c             	sub    $0xc,%esp
     99e:	6a 01                	push   $0x1
     9a0:	e8 5e 39 00 00       	call   4303 <exit>
  }

  if(chdir("..") < 0){
     9a5:	83 ec 0c             	sub    $0xc,%esp
     9a8:	68 52 4c 00 00       	push   $0x4c52
     9ad:	e8 c1 39 00 00       	call   4373 <chdir>
     9b2:	83 c4 10             	add    $0x10,%esp
     9b5:	85 c0                	test   %eax,%eax
     9b7:	79 20                	jns    9d9 <dirtest+0xb8>
    printf(stdout, "chdir .. failed\n");
     9b9:	a1 f0 66 00 00       	mov    0x66f0,%eax
     9be:	83 ec 08             	sub    $0x8,%esp
     9c1:	68 55 4c 00 00       	push   $0x4c55
     9c6:	50                   	push   %eax
     9c7:	e8 b4 3a 00 00       	call   4480 <printf>
     9cc:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     9cf:	83 ec 0c             	sub    $0xc,%esp
     9d2:	6a 01                	push   $0x1
     9d4:	e8 2a 39 00 00       	call   4303 <exit>
  }

  if(unlink("dir0") < 0){
     9d9:	83 ec 0c             	sub    $0xc,%esp
     9dc:	68 3a 4c 00 00       	push   $0x4c3a
     9e1:	e8 6d 39 00 00       	call   4353 <unlink>
     9e6:	83 c4 10             	add    $0x10,%esp
     9e9:	85 c0                	test   %eax,%eax
     9eb:	79 20                	jns    a0d <dirtest+0xec>
    printf(stdout, "unlink dir0 failed\n");
     9ed:	a1 f0 66 00 00       	mov    0x66f0,%eax
     9f2:	83 ec 08             	sub    $0x8,%esp
     9f5:	68 66 4c 00 00       	push   $0x4c66
     9fa:	50                   	push   %eax
     9fb:	e8 80 3a 00 00       	call   4480 <printf>
     a00:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     a03:	83 ec 0c             	sub    $0xc,%esp
     a06:	6a 01                	push   $0x1
     a08:	e8 f6 38 00 00       	call   4303 <exit>
  }
  printf(stdout, "mkdir test ok\n");
     a0d:	a1 f0 66 00 00       	mov    0x66f0,%eax
     a12:	83 ec 08             	sub    $0x8,%esp
     a15:	68 7a 4c 00 00       	push   $0x4c7a
     a1a:	50                   	push   %eax
     a1b:	e8 60 3a 00 00       	call   4480 <printf>
     a20:	83 c4 10             	add    $0x10,%esp
}
     a23:	c9                   	leave  
     a24:	c3                   	ret    

00000a25 <exectest>:

void
exectest(void)
{
     a25:	55                   	push   %ebp
     a26:	89 e5                	mov    %esp,%ebp
     a28:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     a2b:	a1 f0 66 00 00       	mov    0x66f0,%eax
     a30:	83 ec 08             	sub    $0x8,%esp
     a33:	68 89 4c 00 00       	push   $0x4c89
     a38:	50                   	push   %eax
     a39:	e8 42 3a 00 00       	call   4480 <printf>
     a3e:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     a41:	83 ec 08             	sub    $0x8,%esp
     a44:	68 dc 66 00 00       	push   $0x66dc
     a49:	68 34 48 00 00       	push   $0x4834
     a4e:	e8 e8 38 00 00       	call   433b <exec>
     a53:	83 c4 10             	add    $0x10,%esp
     a56:	85 c0                	test   %eax,%eax
     a58:	79 20                	jns    a7a <exectest+0x55>
    printf(stdout, "exec echo failed\n");
     a5a:	a1 f0 66 00 00       	mov    0x66f0,%eax
     a5f:	83 ec 08             	sub    $0x8,%esp
     a62:	68 94 4c 00 00       	push   $0x4c94
     a67:	50                   	push   %eax
     a68:	e8 13 3a 00 00       	call   4480 <printf>
     a6d:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     a70:	83 ec 0c             	sub    $0xc,%esp
     a73:	6a 01                	push   $0x1
     a75:	e8 89 38 00 00       	call   4303 <exit>
  }
}
     a7a:	c9                   	leave  
     a7b:	c3                   	ret    

00000a7c <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     a7c:	55                   	push   %ebp
     a7d:	89 e5                	mov    %esp,%ebp
     a7f:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     a82:	83 ec 0c             	sub    $0xc,%esp
     a85:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a88:	50                   	push   %eax
     a89:	e8 85 38 00 00       	call   4313 <pipe>
     a8e:	83 c4 10             	add    $0x10,%esp
     a91:	85 c0                	test   %eax,%eax
     a93:	74 1c                	je     ab1 <pipe1+0x35>
    printf(1, "pipe() failed\n");
     a95:	83 ec 08             	sub    $0x8,%esp
     a98:	68 a6 4c 00 00       	push   $0x4ca6
     a9d:	6a 01                	push   $0x1
     a9f:	e8 dc 39 00 00       	call   4480 <printf>
     aa4:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     aa7:	83 ec 0c             	sub    $0xc,%esp
     aaa:	6a 01                	push   $0x1
     aac:	e8 52 38 00 00       	call   4303 <exit>
  }
  pid = fork();
     ab1:	e8 45 38 00 00       	call   42fb <fork>
     ab6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     ab9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     ac0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     ac4:	0f 85 93 00 00 00    	jne    b5d <pipe1+0xe1>
    close(fds[0]);
     aca:	8b 45 d8             	mov    -0x28(%ebp),%eax
     acd:	83 ec 0c             	sub    $0xc,%esp
     ad0:	50                   	push   %eax
     ad1:	e8 55 38 00 00       	call   432b <close>
     ad6:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     ad9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ae0:	eb 6b                	jmp    b4d <pipe1+0xd1>
      for(i = 0; i < 1033; i++)
     ae2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ae9:	eb 19                	jmp    b04 <pipe1+0x88>
        buf[i] = seq++;
     aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aee:	8d 50 01             	lea    0x1(%eax),%edx
     af1:	89 55 f4             	mov    %edx,-0xc(%ebp)
     af4:	89 c2                	mov    %eax,%edx
     af6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af9:	05 40 8f 00 00       	add    $0x8f40,%eax
     afe:	88 10                	mov    %dl,(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     b00:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b04:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     b0b:	7e de                	jle    aeb <pipe1+0x6f>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     b0d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b10:	83 ec 04             	sub    $0x4,%esp
     b13:	68 09 04 00 00       	push   $0x409
     b18:	68 40 8f 00 00       	push   $0x8f40
     b1d:	50                   	push   %eax
     b1e:	e8 00 38 00 00       	call   4323 <write>
     b23:	83 c4 10             	add    $0x10,%esp
     b26:	3d 09 04 00 00       	cmp    $0x409,%eax
     b2b:	74 1c                	je     b49 <pipe1+0xcd>
        printf(1, "pipe1 oops 1\n");
     b2d:	83 ec 08             	sub    $0x8,%esp
     b30:	68 b5 4c 00 00       	push   $0x4cb5
     b35:	6a 01                	push   $0x1
     b37:	e8 44 39 00 00       	call   4480 <printf>
     b3c:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
     b3f:	83 ec 0c             	sub    $0xc,%esp
     b42:	6a 01                	push   $0x1
     b44:	e8 ba 37 00 00       	call   4303 <exit>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     b49:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     b4d:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     b51:	7e 8f                	jle    ae2 <pipe1+0x66>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit(EXIT_STATUS_OK);
      }
    }
    exit(EXIT_STATUS_OK);
     b53:	83 ec 0c             	sub    $0xc,%esp
     b56:	6a 01                	push   $0x1
     b58:	e8 a6 37 00 00       	call   4303 <exit>
  } else if(pid > 0){
     b5d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     b61:	0f 8e 01 01 00 00    	jle    c68 <pipe1+0x1ec>
    close(fds[1]);
     b67:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b6a:	83 ec 0c             	sub    $0xc,%esp
     b6d:	50                   	push   %eax
     b6e:	e8 b8 37 00 00       	call   432b <close>
     b73:	83 c4 10             	add    $0x10,%esp
    total = 0;
     b76:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     b7d:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     b84:	eb 66                	jmp    bec <pipe1+0x170>
      for(i = 0; i < n; i++){
     b86:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b8d:	eb 3b                	jmp    bca <pipe1+0x14e>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     b8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b92:	05 40 8f 00 00       	add    $0x8f40,%eax
     b97:	0f b6 00             	movzbl (%eax),%eax
     b9a:	0f be c8             	movsbl %al,%ecx
     b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ba0:	8d 50 01             	lea    0x1(%eax),%edx
     ba3:	89 55 f4             	mov    %edx,-0xc(%ebp)
     ba6:	31 c8                	xor    %ecx,%eax
     ba8:	0f b6 c0             	movzbl %al,%eax
     bab:	85 c0                	test   %eax,%eax
     bad:	74 17                	je     bc6 <pipe1+0x14a>
          printf(1, "pipe1 oops 2\n");
     baf:	83 ec 08             	sub    $0x8,%esp
     bb2:	68 c3 4c 00 00       	push   $0x4cc3
     bb7:	6a 01                	push   $0x1
     bb9:	e8 c2 38 00 00       	call   4480 <printf>
     bbe:	83 c4 10             	add    $0x10,%esp
     bc1:	e9 be 00 00 00       	jmp    c84 <pipe1+0x208>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     bc6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     bca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bcd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     bd0:	7c bd                	jl     b8f <pipe1+0x113>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     bd2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bd5:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     bd8:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     bdb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bde:	3d 00 20 00 00       	cmp    $0x2000,%eax
     be3:	76 07                	jbe    bec <pipe1+0x170>
        cc = sizeof(buf);
     be5:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    exit(EXIT_STATUS_OK);
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     bec:	8b 45 d8             	mov    -0x28(%ebp),%eax
     bef:	83 ec 04             	sub    $0x4,%esp
     bf2:	ff 75 e8             	pushl  -0x18(%ebp)
     bf5:	68 40 8f 00 00       	push   $0x8f40
     bfa:	50                   	push   %eax
     bfb:	e8 1b 37 00 00       	call   431b <read>
     c00:	83 c4 10             	add    $0x10,%esp
     c03:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c06:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c0a:	0f 8f 76 ff ff ff    	jg     b86 <pipe1+0x10a>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     c10:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     c17:	74 1f                	je     c38 <pipe1+0x1bc>
      printf(1, "pipe1 oops 3 total %d\n", total);
     c19:	83 ec 04             	sub    $0x4,%esp
     c1c:	ff 75 e4             	pushl  -0x1c(%ebp)
     c1f:	68 d1 4c 00 00       	push   $0x4cd1
     c24:	6a 01                	push   $0x1
     c26:	e8 55 38 00 00       	call   4480 <printf>
     c2b:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     c2e:	83 ec 0c             	sub    $0xc,%esp
     c31:	6a 01                	push   $0x1
     c33:	e8 cb 36 00 00       	call   4303 <exit>
    }
    close(fds[0]);
     c38:	8b 45 d8             	mov    -0x28(%ebp),%eax
     c3b:	83 ec 0c             	sub    $0xc,%esp
     c3e:	50                   	push   %eax
     c3f:	e8 e7 36 00 00       	call   432b <close>
     c44:	83 c4 10             	add    $0x10,%esp
    wait(0);
     c47:	83 ec 0c             	sub    $0xc,%esp
     c4a:	6a 00                	push   $0x0
     c4c:	e8 ba 36 00 00       	call   430b <wait>
     c51:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "fork() failed\n");
    exit(EXIT_STATUS_OK);
  }
  printf(1, "pipe1 ok\n");
     c54:	83 ec 08             	sub    $0x8,%esp
     c57:	68 f7 4c 00 00       	push   $0x4cf7
     c5c:	6a 01                	push   $0x1
     c5e:	e8 1d 38 00 00       	call   4480 <printf>
     c63:	83 c4 10             	add    $0x10,%esp
     c66:	eb 1c                	jmp    c84 <pipe1+0x208>
      exit(EXIT_STATUS_OK);
    }
    close(fds[0]);
    wait(0);
  } else {
    printf(1, "fork() failed\n");
     c68:	83 ec 08             	sub    $0x8,%esp
     c6b:	68 e8 4c 00 00       	push   $0x4ce8
     c70:	6a 01                	push   $0x1
     c72:	e8 09 38 00 00       	call   4480 <printf>
     c77:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     c7a:	83 ec 0c             	sub    $0xc,%esp
     c7d:	6a 01                	push   $0x1
     c7f:	e8 7f 36 00 00       	call   4303 <exit>
  }
  printf(1, "pipe1 ok\n");
}
     c84:	c9                   	leave  
     c85:	c3                   	ret    

00000c86 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     c86:	55                   	push   %ebp
     c87:	89 e5                	mov    %esp,%ebp
     c89:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     c8c:	83 ec 08             	sub    $0x8,%esp
     c8f:	68 01 4d 00 00       	push   $0x4d01
     c94:	6a 01                	push   $0x1
     c96:	e8 e5 37 00 00       	call   4480 <printf>
     c9b:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     c9e:	e8 58 36 00 00       	call   42fb <fork>
     ca3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     ca6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     caa:	75 02                	jne    cae <preempt+0x28>
    for(;;)
      ;
     cac:	eb fe                	jmp    cac <preempt+0x26>

  pid2 = fork();
     cae:	e8 48 36 00 00       	call   42fb <fork>
     cb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     cb6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     cba:	75 02                	jne    cbe <preempt+0x38>
    for(;;)
      ;
     cbc:	eb fe                	jmp    cbc <preempt+0x36>

  pipe(pfds);
     cbe:	83 ec 0c             	sub    $0xc,%esp
     cc1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     cc4:	50                   	push   %eax
     cc5:	e8 49 36 00 00       	call   4313 <pipe>
     cca:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     ccd:	e8 29 36 00 00       	call   42fb <fork>
     cd2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     cd5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     cd9:	75 4d                	jne    d28 <preempt+0xa2>
    close(pfds[0]);
     cdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cde:	83 ec 0c             	sub    $0xc,%esp
     ce1:	50                   	push   %eax
     ce2:	e8 44 36 00 00       	call   432b <close>
     ce7:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     cea:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ced:	83 ec 04             	sub    $0x4,%esp
     cf0:	6a 01                	push   $0x1
     cf2:	68 0b 4d 00 00       	push   $0x4d0b
     cf7:	50                   	push   %eax
     cf8:	e8 26 36 00 00       	call   4323 <write>
     cfd:	83 c4 10             	add    $0x10,%esp
     d00:	83 f8 01             	cmp    $0x1,%eax
     d03:	74 12                	je     d17 <preempt+0x91>
      printf(1, "preempt write error");
     d05:	83 ec 08             	sub    $0x8,%esp
     d08:	68 0d 4d 00 00       	push   $0x4d0d
     d0d:	6a 01                	push   $0x1
     d0f:	e8 6c 37 00 00       	call   4480 <printf>
     d14:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     d17:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d1a:	83 ec 0c             	sub    $0xc,%esp
     d1d:	50                   	push   %eax
     d1e:	e8 08 36 00 00       	call   432b <close>
     d23:	83 c4 10             	add    $0x10,%esp
    for(;;)
      ;
     d26:	eb fe                	jmp    d26 <preempt+0xa0>
  }

  close(pfds[1]);
     d28:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d2b:	83 ec 0c             	sub    $0xc,%esp
     d2e:	50                   	push   %eax
     d2f:	e8 f7 35 00 00       	call   432b <close>
     d34:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     d37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d3a:	83 ec 04             	sub    $0x4,%esp
     d3d:	68 00 20 00 00       	push   $0x2000
     d42:	68 40 8f 00 00       	push   $0x8f40
     d47:	50                   	push   %eax
     d48:	e8 ce 35 00 00       	call   431b <read>
     d4d:	83 c4 10             	add    $0x10,%esp
     d50:	83 f8 01             	cmp    $0x1,%eax
     d53:	74 17                	je     d6c <preempt+0xe6>
    printf(1, "preempt read error");
     d55:	83 ec 08             	sub    $0x8,%esp
     d58:	68 21 4d 00 00       	push   $0x4d21
     d5d:	6a 01                	push   $0x1
     d5f:	e8 1c 37 00 00       	call   4480 <printf>
     d64:	83 c4 10             	add    $0x10,%esp
     d67:	e9 96 00 00 00       	jmp    e02 <preempt+0x17c>
    return;
  }
  close(pfds[0]);
     d6c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d6f:	83 ec 0c             	sub    $0xc,%esp
     d72:	50                   	push   %eax
     d73:	e8 b3 35 00 00       	call   432b <close>
     d78:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     d7b:	83 ec 08             	sub    $0x8,%esp
     d7e:	68 34 4d 00 00       	push   $0x4d34
     d83:	6a 01                	push   $0x1
     d85:	e8 f6 36 00 00       	call   4480 <printf>
     d8a:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     d8d:	83 ec 0c             	sub    $0xc,%esp
     d90:	ff 75 f4             	pushl  -0xc(%ebp)
     d93:	e8 9b 35 00 00       	call   4333 <kill>
     d98:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     d9b:	83 ec 0c             	sub    $0xc,%esp
     d9e:	ff 75 f0             	pushl  -0x10(%ebp)
     da1:	e8 8d 35 00 00       	call   4333 <kill>
     da6:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     da9:	83 ec 0c             	sub    $0xc,%esp
     dac:	ff 75 ec             	pushl  -0x14(%ebp)
     daf:	e8 7f 35 00 00       	call   4333 <kill>
     db4:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     db7:	83 ec 08             	sub    $0x8,%esp
     dba:	68 3d 4d 00 00       	push   $0x4d3d
     dbf:	6a 01                	push   $0x1
     dc1:	e8 ba 36 00 00       	call   4480 <printf>
     dc6:	83 c4 10             	add    $0x10,%esp
  wait(0);
     dc9:	83 ec 0c             	sub    $0xc,%esp
     dcc:	6a 00                	push   $0x0
     dce:	e8 38 35 00 00       	call   430b <wait>
     dd3:	83 c4 10             	add    $0x10,%esp
  wait(0);
     dd6:	83 ec 0c             	sub    $0xc,%esp
     dd9:	6a 00                	push   $0x0
     ddb:	e8 2b 35 00 00       	call   430b <wait>
     de0:	83 c4 10             	add    $0x10,%esp
  wait(0);
     de3:	83 ec 0c             	sub    $0xc,%esp
     de6:	6a 00                	push   $0x0
     de8:	e8 1e 35 00 00       	call   430b <wait>
     ded:	83 c4 10             	add    $0x10,%esp
  printf(1, "preempt ok\n");
     df0:	83 ec 08             	sub    $0x8,%esp
     df3:	68 46 4d 00 00       	push   $0x4d46
     df8:	6a 01                	push   $0x1
     dfa:	e8 81 36 00 00       	call   4480 <printf>
     dff:	83 c4 10             	add    $0x10,%esp
}
     e02:	c9                   	leave  
     e03:	c3                   	ret    

00000e04 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     e04:	55                   	push   %ebp
     e05:	89 e5                	mov    %esp,%ebp
     e07:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     e0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e11:	eb 5c                	jmp    e6f <exitwait+0x6b>
    pid = fork();
     e13:	e8 e3 34 00 00       	call   42fb <fork>
     e18:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     e1b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e1f:	79 14                	jns    e35 <exitwait+0x31>
      printf(1, "fork failed\n");
     e21:	83 ec 08             	sub    $0x8,%esp
     e24:	68 d5 48 00 00       	push   $0x48d5
     e29:	6a 01                	push   $0x1
     e2b:	e8 50 36 00 00       	call   4480 <printf>
     e30:	83 c4 10             	add    $0x10,%esp
      return;
     e33:	eb 52                	jmp    e87 <exitwait+0x83>
    }
    if(pid){
     e35:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     e39:	74 26                	je     e61 <exitwait+0x5d>
      if(wait(0) != pid){
     e3b:	83 ec 0c             	sub    $0xc,%esp
     e3e:	6a 00                	push   $0x0
     e40:	e8 c6 34 00 00       	call   430b <wait>
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     e4b:	74 1e                	je     e6b <exitwait+0x67>
        printf(1, "wait wrong pid\n");
     e4d:	83 ec 08             	sub    $0x8,%esp
     e50:	68 52 4d 00 00       	push   $0x4d52
     e55:	6a 01                	push   $0x1
     e57:	e8 24 36 00 00       	call   4480 <printf>
     e5c:	83 c4 10             	add    $0x10,%esp
        return;
     e5f:	eb 26                	jmp    e87 <exitwait+0x83>
      }
    } else {
      exit(EXIT_STATUS_OK);
     e61:	83 ec 0c             	sub    $0xc,%esp
     e64:	6a 01                	push   $0x1
     e66:	e8 98 34 00 00       	call   4303 <exit>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     e6b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e6f:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     e73:	7e 9e                	jle    e13 <exitwait+0xf>
      }
    } else {
      exit(EXIT_STATUS_OK);
    }
  }
  printf(1, "exitwait ok\n");
     e75:	83 ec 08             	sub    $0x8,%esp
     e78:	68 62 4d 00 00       	push   $0x4d62
     e7d:	6a 01                	push   $0x1
     e7f:	e8 fc 35 00 00       	call   4480 <printf>
     e84:	83 c4 10             	add    $0x10,%esp
}
     e87:	c9                   	leave  
     e88:	c3                   	ret    

00000e89 <mem>:

void
mem(void)
{
     e89:	55                   	push   %ebp
     e8a:	89 e5                	mov    %esp,%ebp
     e8c:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     e8f:	83 ec 08             	sub    $0x8,%esp
     e92:	68 6f 4d 00 00       	push   $0x4d6f
     e97:	6a 01                	push   $0x1
     e99:	e8 e2 35 00 00       	call   4480 <printf>
     e9e:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     ea1:	e8 dd 34 00 00       	call   4383 <getpid>
     ea6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     ea9:	e8 4d 34 00 00       	call   42fb <fork>
     eae:	89 45 ec             	mov    %eax,-0x14(%ebp)
     eb1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     eb5:	0f 85 c1 00 00 00    	jne    f7c <mem+0xf3>
    m1 = 0;
     ebb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     ec2:	eb 0e                	jmp    ed2 <mem+0x49>
      *(char**)m2 = m1;
     ec4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ec7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     eca:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     ecc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ecf:	89 45 f4             	mov    %eax,-0xc(%ebp)

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     ed2:	83 ec 0c             	sub    $0xc,%esp
     ed5:	68 11 27 00 00       	push   $0x2711
     eda:	e8 72 38 00 00       	call   4751 <malloc>
     edf:	83 c4 10             	add    $0x10,%esp
     ee2:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ee5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ee9:	75 d9                	jne    ec4 <mem+0x3b>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     eeb:	eb 1c                	jmp    f09 <mem+0x80>
      m2 = *(char**)m1;
     eed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef0:	8b 00                	mov    (%eax),%eax
     ef2:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     ef5:	83 ec 0c             	sub    $0xc,%esp
     ef8:	ff 75 f4             	pushl  -0xc(%ebp)
     efb:	e8 10 37 00 00       	call   4610 <free>
     f00:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     f03:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f06:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     f09:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f0d:	75 de                	jne    eed <mem+0x64>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     f0f:	83 ec 0c             	sub    $0xc,%esp
     f12:	68 00 50 00 00       	push   $0x5000
     f17:	e8 35 38 00 00       	call   4751 <malloc>
     f1c:	83 c4 10             	add    $0x10,%esp
     f1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     f22:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f26:	75 2a                	jne    f52 <mem+0xc9>
      printf(1, "couldn't allocate mem?!!\n");
     f28:	83 ec 08             	sub    $0x8,%esp
     f2b:	68 79 4d 00 00       	push   $0x4d79
     f30:	6a 01                	push   $0x1
     f32:	e8 49 35 00 00       	call   4480 <printf>
     f37:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     f3a:	83 ec 0c             	sub    $0xc,%esp
     f3d:	ff 75 f0             	pushl  -0x10(%ebp)
     f40:	e8 ee 33 00 00       	call   4333 <kill>
     f45:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
     f48:	83 ec 0c             	sub    $0xc,%esp
     f4b:	6a 01                	push   $0x1
     f4d:	e8 b1 33 00 00       	call   4303 <exit>
    }
    free(m1);
     f52:	83 ec 0c             	sub    $0xc,%esp
     f55:	ff 75 f4             	pushl  -0xc(%ebp)
     f58:	e8 b3 36 00 00       	call   4610 <free>
     f5d:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     f60:	83 ec 08             	sub    $0x8,%esp
     f63:	68 93 4d 00 00       	push   $0x4d93
     f68:	6a 01                	push   $0x1
     f6a:	e8 11 35 00 00       	call   4480 <printf>
     f6f:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
     f72:	83 ec 0c             	sub    $0xc,%esp
     f75:	6a 01                	push   $0x1
     f77:	e8 87 33 00 00       	call   4303 <exit>
  } else {
    wait(0);
     f7c:	83 ec 0c             	sub    $0xc,%esp
     f7f:	6a 00                	push   $0x0
     f81:	e8 85 33 00 00       	call   430b <wait>
     f86:	83 c4 10             	add    $0x10,%esp
  }
}
     f89:	c9                   	leave  
     f8a:	c3                   	ret    

00000f8b <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     f8b:	55                   	push   %ebp
     f8c:	89 e5                	mov    %esp,%ebp
     f8e:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     f91:	83 ec 08             	sub    $0x8,%esp
     f94:	68 9b 4d 00 00       	push   $0x4d9b
     f99:	6a 01                	push   $0x1
     f9b:	e8 e0 34 00 00       	call   4480 <printf>
     fa0:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     fa3:	83 ec 0c             	sub    $0xc,%esp
     fa6:	68 aa 4d 00 00       	push   $0x4daa
     fab:	e8 a3 33 00 00       	call   4353 <unlink>
     fb0:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     fb3:	83 ec 08             	sub    $0x8,%esp
     fb6:	68 02 02 00 00       	push   $0x202
     fbb:	68 aa 4d 00 00       	push   $0x4daa
     fc0:	e8 7e 33 00 00       	call   4343 <open>
     fc5:	83 c4 10             	add    $0x10,%esp
     fc8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     fcb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     fcf:	79 17                	jns    fe8 <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     fd1:	83 ec 08             	sub    $0x8,%esp
     fd4:	68 b4 4d 00 00       	push   $0x4db4
     fd9:	6a 01                	push   $0x1
     fdb:	e8 a0 34 00 00       	call   4480 <printf>
     fe0:	83 c4 10             	add    $0x10,%esp
    return;
     fe3:	e9 96 01 00 00       	jmp    117e <sharedfd+0x1f3>
  }
  pid = fork();
     fe8:	e8 0e 33 00 00       	call   42fb <fork>
     fed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ff0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ff4:	75 07                	jne    ffd <sharedfd+0x72>
     ff6:	b8 63 00 00 00       	mov    $0x63,%eax
     ffb:	eb 05                	jmp    1002 <sharedfd+0x77>
     ffd:	b8 70 00 00 00       	mov    $0x70,%eax
    1002:	83 ec 04             	sub    $0x4,%esp
    1005:	6a 0a                	push   $0xa
    1007:	50                   	push   %eax
    1008:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    100b:	50                   	push   %eax
    100c:	e8 58 31 00 00       	call   4169 <memset>
    1011:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
    1014:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    101b:	eb 31                	jmp    104e <sharedfd+0xc3>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    101d:	83 ec 04             	sub    $0x4,%esp
    1020:	6a 0a                	push   $0xa
    1022:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    1025:	50                   	push   %eax
    1026:	ff 75 e8             	pushl  -0x18(%ebp)
    1029:	e8 f5 32 00 00       	call   4323 <write>
    102e:	83 c4 10             	add    $0x10,%esp
    1031:	83 f8 0a             	cmp    $0xa,%eax
    1034:	74 14                	je     104a <sharedfd+0xbf>
      printf(1, "fstests: write sharedfd failed\n");
    1036:	83 ec 08             	sub    $0x8,%esp
    1039:	68 e0 4d 00 00       	push   $0x4de0
    103e:	6a 01                	push   $0x1
    1040:	e8 3b 34 00 00       	call   4480 <printf>
    1045:	83 c4 10             	add    $0x10,%esp
      break;
    1048:	eb 0d                	jmp    1057 <sharedfd+0xcc>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
  for(i = 0; i < 1000; i++){
    104a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    104e:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    1055:	7e c6                	jle    101d <sharedfd+0x92>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    1057:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    105b:	75 0a                	jne    1067 <sharedfd+0xdc>
    exit(EXIT_STATUS_OK);
    105d:	83 ec 0c             	sub    $0xc,%esp
    1060:	6a 01                	push   $0x1
    1062:	e8 9c 32 00 00       	call   4303 <exit>
  else
    wait(0);
    1067:	83 ec 0c             	sub    $0xc,%esp
    106a:	6a 00                	push   $0x0
    106c:	e8 9a 32 00 00       	call   430b <wait>
    1071:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1074:	83 ec 0c             	sub    $0xc,%esp
    1077:	ff 75 e8             	pushl  -0x18(%ebp)
    107a:	e8 ac 32 00 00       	call   432b <close>
    107f:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
    1082:	83 ec 08             	sub    $0x8,%esp
    1085:	6a 00                	push   $0x0
    1087:	68 aa 4d 00 00       	push   $0x4daa
    108c:	e8 b2 32 00 00       	call   4343 <open>
    1091:	83 c4 10             	add    $0x10,%esp
    1094:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
    1097:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    109b:	79 17                	jns    10b4 <sharedfd+0x129>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    109d:	83 ec 08             	sub    $0x8,%esp
    10a0:	68 00 4e 00 00       	push   $0x4e00
    10a5:	6a 01                	push   $0x1
    10a7:	e8 d4 33 00 00       	call   4480 <printf>
    10ac:	83 c4 10             	add    $0x10,%esp
    return;
    10af:	e9 ca 00 00 00       	jmp    117e <sharedfd+0x1f3>
  }
  nc = np = 0;
    10b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    10bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    10c1:	eb 3b                	jmp    10fe <sharedfd+0x173>
    for(i = 0; i < sizeof(buf); i++){
    10c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10ca:	eb 2a                	jmp    10f6 <sharedfd+0x16b>
      if(buf[i] == 'c')
    10cc:	8d 55 d6             	lea    -0x2a(%ebp),%edx
    10cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d2:	01 d0                	add    %edx,%eax
    10d4:	0f b6 00             	movzbl (%eax),%eax
    10d7:	3c 63                	cmp    $0x63,%al
    10d9:	75 04                	jne    10df <sharedfd+0x154>
        nc++;
    10db:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
    10df:	8d 55 d6             	lea    -0x2a(%ebp),%edx
    10e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e5:	01 d0                	add    %edx,%eax
    10e7:	0f b6 00             	movzbl (%eax),%eax
    10ea:	3c 70                	cmp    $0x70,%al
    10ec:	75 04                	jne    10f2 <sharedfd+0x167>
        np++;
    10ee:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    10f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10f9:	83 f8 09             	cmp    $0x9,%eax
    10fc:	76 ce                	jbe    10cc <sharedfd+0x141>
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    10fe:	83 ec 04             	sub    $0x4,%esp
    1101:	6a 0a                	push   $0xa
    1103:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    1106:	50                   	push   %eax
    1107:	ff 75 e8             	pushl  -0x18(%ebp)
    110a:	e8 0c 32 00 00       	call   431b <read>
    110f:	83 c4 10             	add    $0x10,%esp
    1112:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1115:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1119:	7f a8                	jg     10c3 <sharedfd+0x138>
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    111b:	83 ec 0c             	sub    $0xc,%esp
    111e:	ff 75 e8             	pushl  -0x18(%ebp)
    1121:	e8 05 32 00 00       	call   432b <close>
    1126:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
    1129:	83 ec 0c             	sub    $0xc,%esp
    112c:	68 aa 4d 00 00       	push   $0x4daa
    1131:	e8 1d 32 00 00       	call   4353 <unlink>
    1136:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
    1139:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    1140:	75 1d                	jne    115f <sharedfd+0x1d4>
    1142:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    1149:	75 14                	jne    115f <sharedfd+0x1d4>
    printf(1, "sharedfd ok\n");
    114b:	83 ec 08             	sub    $0x8,%esp
    114e:	68 2b 4e 00 00       	push   $0x4e2b
    1153:	6a 01                	push   $0x1
    1155:	e8 26 33 00 00       	call   4480 <printf>
    115a:	83 c4 10             	add    $0x10,%esp
    115d:	eb 1f                	jmp    117e <sharedfd+0x1f3>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    115f:	ff 75 ec             	pushl  -0x14(%ebp)
    1162:	ff 75 f0             	pushl  -0x10(%ebp)
    1165:	68 38 4e 00 00       	push   $0x4e38
    116a:	6a 01                	push   $0x1
    116c:	e8 0f 33 00 00       	call   4480 <printf>
    1171:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    1174:	83 ec 0c             	sub    $0xc,%esp
    1177:	6a 01                	push   $0x1
    1179:	e8 85 31 00 00       	call   4303 <exit>
  }
}
    117e:	c9                   	leave  
    117f:	c3                   	ret    

00001180 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    1186:	c7 45 c8 4d 4e 00 00 	movl   $0x4e4d,-0x38(%ebp)
    118d:	c7 45 cc 50 4e 00 00 	movl   $0x4e50,-0x34(%ebp)
    1194:	c7 45 d0 53 4e 00 00 	movl   $0x4e53,-0x30(%ebp)
    119b:	c7 45 d4 56 4e 00 00 	movl   $0x4e56,-0x2c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    11a2:	83 ec 08             	sub    $0x8,%esp
    11a5:	68 59 4e 00 00       	push   $0x4e59
    11aa:	6a 01                	push   $0x1
    11ac:	e8 cf 32 00 00       	call   4480 <printf>
    11b1:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    11b4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    11bb:	e9 04 01 00 00       	jmp    12c4 <fourfiles+0x144>
    fname = names[pi];
    11c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11c3:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    11c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    unlink(fname);
    11ca:	83 ec 0c             	sub    $0xc,%esp
    11cd:	ff 75 e4             	pushl  -0x1c(%ebp)
    11d0:	e8 7e 31 00 00       	call   4353 <unlink>
    11d5:	83 c4 10             	add    $0x10,%esp

    pid = fork();
    11d8:	e8 1e 31 00 00       	call   42fb <fork>
    11dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if(pid < 0){
    11e0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    11e4:	79 1c                	jns    1202 <fourfiles+0x82>
      printf(1, "fork failed\n");
    11e6:	83 ec 08             	sub    $0x8,%esp
    11e9:	68 d5 48 00 00       	push   $0x48d5
    11ee:	6a 01                	push   $0x1
    11f0:	e8 8b 32 00 00       	call   4480 <printf>
    11f5:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    11f8:	83 ec 0c             	sub    $0xc,%esp
    11fb:	6a 01                	push   $0x1
    11fd:	e8 01 31 00 00       	call   4303 <exit>
    }

    if(pid == 0){
    1202:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    1206:	0f 85 b4 00 00 00    	jne    12c0 <fourfiles+0x140>
      fd = open(fname, O_CREATE | O_RDWR);
    120c:	83 ec 08             	sub    $0x8,%esp
    120f:	68 02 02 00 00       	push   $0x202
    1214:	ff 75 e4             	pushl  -0x1c(%ebp)
    1217:	e8 27 31 00 00       	call   4343 <open>
    121c:	83 c4 10             	add    $0x10,%esp
    121f:	89 45 dc             	mov    %eax,-0x24(%ebp)
      if(fd < 0){
    1222:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    1226:	79 1c                	jns    1244 <fourfiles+0xc4>
        printf(1, "create failed\n");
    1228:	83 ec 08             	sub    $0x8,%esp
    122b:	68 69 4e 00 00       	push   $0x4e69
    1230:	6a 01                	push   $0x1
    1232:	e8 49 32 00 00       	call   4480 <printf>
    1237:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
    123a:	83 ec 0c             	sub    $0xc,%esp
    123d:	6a 01                	push   $0x1
    123f:	e8 bf 30 00 00       	call   4303 <exit>
      }
      
      memset(buf, '0'+pi, 512);
    1244:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1247:	83 c0 30             	add    $0x30,%eax
    124a:	83 ec 04             	sub    $0x4,%esp
    124d:	68 00 02 00 00       	push   $0x200
    1252:	50                   	push   %eax
    1253:	68 40 8f 00 00       	push   $0x8f40
    1258:	e8 0c 2f 00 00       	call   4169 <memset>
    125d:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
    1260:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1267:	eb 47                	jmp    12b0 <fourfiles+0x130>
        if((n = write(fd, buf, 500)) != 500){
    1269:	83 ec 04             	sub    $0x4,%esp
    126c:	68 f4 01 00 00       	push   $0x1f4
    1271:	68 40 8f 00 00       	push   $0x8f40
    1276:	ff 75 dc             	pushl  -0x24(%ebp)
    1279:	e8 a5 30 00 00       	call   4323 <write>
    127e:	83 c4 10             	add    $0x10,%esp
    1281:	89 45 d8             	mov    %eax,-0x28(%ebp)
    1284:	81 7d d8 f4 01 00 00 	cmpl   $0x1f4,-0x28(%ebp)
    128b:	74 1f                	je     12ac <fourfiles+0x12c>
          printf(1, "write failed %d\n", n);
    128d:	83 ec 04             	sub    $0x4,%esp
    1290:	ff 75 d8             	pushl  -0x28(%ebp)
    1293:	68 78 4e 00 00       	push   $0x4e78
    1298:	6a 01                	push   $0x1
    129a:	e8 e1 31 00 00       	call   4480 <printf>
    129f:	83 c4 10             	add    $0x10,%esp
          exit(EXIT_STATUS_OK);
    12a2:	83 ec 0c             	sub    $0xc,%esp
    12a5:	6a 01                	push   $0x1
    12a7:	e8 57 30 00 00       	call   4303 <exit>
        printf(1, "create failed\n");
        exit(EXIT_STATUS_OK);
      }
      
      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    12ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12b0:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    12b4:	7e b3                	jle    1269 <fourfiles+0xe9>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit(EXIT_STATUS_OK);
        }
      }
      exit(EXIT_STATUS_OK);
    12b6:	83 ec 0c             	sub    $0xc,%esp
    12b9:	6a 01                	push   $0x1
    12bb:	e8 43 30 00 00       	call   4303 <exit>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    12c0:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12c4:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    12c8:	0f 8e f2 fe ff ff    	jle    11c0 <fourfiles+0x40>
      }
      exit(EXIT_STATUS_OK);
    }
  }

  for(pi = 0; pi < 4; pi++){
    12ce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    12d5:	eb 11                	jmp    12e8 <fourfiles+0x168>
    wait(0);
    12d7:	83 ec 0c             	sub    $0xc,%esp
    12da:	6a 00                	push   $0x0
    12dc:	e8 2a 30 00 00       	call   430b <wait>
    12e1:	83 c4 10             	add    $0x10,%esp
      }
      exit(EXIT_STATUS_OK);
    }
  }

  for(pi = 0; pi < 4; pi++){
    12e4:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12e8:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    12ec:	7e e9                	jle    12d7 <fourfiles+0x157>
    wait(0);
  }

  for(i = 0; i < 2; i++){
    12ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12f5:	e9 de 00 00 00       	jmp    13d8 <fourfiles+0x258>
    fname = names[i];
    12fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12fd:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    1301:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    fd = open(fname, 0);
    1304:	83 ec 08             	sub    $0x8,%esp
    1307:	6a 00                	push   $0x0
    1309:	ff 75 e4             	pushl  -0x1c(%ebp)
    130c:	e8 32 30 00 00       	call   4343 <open>
    1311:	83 c4 10             	add    $0x10,%esp
    1314:	89 45 dc             	mov    %eax,-0x24(%ebp)
    total = 0;
    1317:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    131e:	eb 4f                	jmp    136f <fourfiles+0x1ef>
      for(j = 0; j < n; j++){
    1320:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1327:	eb 38                	jmp    1361 <fourfiles+0x1e1>
        if(buf[j] != '0'+i){
    1329:	8b 45 f0             	mov    -0x10(%ebp),%eax
    132c:	05 40 8f 00 00       	add    $0x8f40,%eax
    1331:	0f b6 00             	movzbl (%eax),%eax
    1334:	0f be c0             	movsbl %al,%eax
    1337:	8b 55 f4             	mov    -0xc(%ebp),%edx
    133a:	83 c2 30             	add    $0x30,%edx
    133d:	39 d0                	cmp    %edx,%eax
    133f:	74 1c                	je     135d <fourfiles+0x1dd>
          printf(1, "wrong char\n");
    1341:	83 ec 08             	sub    $0x8,%esp
    1344:	68 89 4e 00 00       	push   $0x4e89
    1349:	6a 01                	push   $0x1
    134b:	e8 30 31 00 00       	call   4480 <printf>
    1350:	83 c4 10             	add    $0x10,%esp
          exit(EXIT_STATUS_OK);
    1353:	83 ec 0c             	sub    $0xc,%esp
    1356:	6a 01                	push   $0x1
    1358:	e8 a6 2f 00 00       	call   4303 <exit>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    135d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1361:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1364:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    1367:	7c c0                	jl     1329 <fourfiles+0x1a9>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit(EXIT_STATUS_OK);
        }
      }
      total += n;
    1369:	8b 45 d8             	mov    -0x28(%ebp),%eax
    136c:	01 45 ec             	add    %eax,-0x14(%ebp)

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    136f:	83 ec 04             	sub    $0x4,%esp
    1372:	68 00 20 00 00       	push   $0x2000
    1377:	68 40 8f 00 00       	push   $0x8f40
    137c:	ff 75 dc             	pushl  -0x24(%ebp)
    137f:	e8 97 2f 00 00       	call   431b <read>
    1384:	83 c4 10             	add    $0x10,%esp
    1387:	89 45 d8             	mov    %eax,-0x28(%ebp)
    138a:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    138e:	7f 90                	jg     1320 <fourfiles+0x1a0>
          exit(EXIT_STATUS_OK);
        }
      }
      total += n;
    }
    close(fd);
    1390:	83 ec 0c             	sub    $0xc,%esp
    1393:	ff 75 dc             	pushl  -0x24(%ebp)
    1396:	e8 90 2f 00 00       	call   432b <close>
    139b:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
    139e:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
    13a5:	74 1f                	je     13c6 <fourfiles+0x246>
      printf(1, "wrong length %d\n", total);
    13a7:	83 ec 04             	sub    $0x4,%esp
    13aa:	ff 75 ec             	pushl  -0x14(%ebp)
    13ad:	68 95 4e 00 00       	push   $0x4e95
    13b2:	6a 01                	push   $0x1
    13b4:	e8 c7 30 00 00       	call   4480 <printf>
    13b9:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    13bc:	83 ec 0c             	sub    $0xc,%esp
    13bf:	6a 01                	push   $0x1
    13c1:	e8 3d 2f 00 00       	call   4303 <exit>
    }
    unlink(fname);
    13c6:	83 ec 0c             	sub    $0xc,%esp
    13c9:	ff 75 e4             	pushl  -0x1c(%ebp)
    13cc:	e8 82 2f 00 00       	call   4353 <unlink>
    13d1:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    wait(0);
  }

  for(i = 0; i < 2; i++){
    13d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13d8:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    13dc:	0f 8e 18 ff ff ff    	jle    12fa <fourfiles+0x17a>
      exit(EXIT_STATUS_OK);
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    13e2:	83 ec 08             	sub    $0x8,%esp
    13e5:	68 a6 4e 00 00       	push   $0x4ea6
    13ea:	6a 01                	push   $0x1
    13ec:	e8 8f 30 00 00       	call   4480 <printf>
    13f1:	83 c4 10             	add    $0x10,%esp
}
    13f4:	c9                   	leave  
    13f5:	c3                   	ret    

000013f6 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    13f6:	55                   	push   %ebp
    13f7:	89 e5                	mov    %esp,%ebp
    13f9:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    13fc:	83 ec 08             	sub    $0x8,%esp
    13ff:	68 b4 4e 00 00       	push   $0x4eb4
    1404:	6a 01                	push   $0x1
    1406:	e8 75 30 00 00       	call   4480 <printf>
    140b:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    140e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1415:	e9 0a 01 00 00       	jmp    1524 <createdelete+0x12e>
    pid = fork();
    141a:	e8 dc 2e 00 00       	call   42fb <fork>
    141f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    1422:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1426:	79 1c                	jns    1444 <createdelete+0x4e>
      printf(1, "fork failed\n");
    1428:	83 ec 08             	sub    $0x8,%esp
    142b:	68 d5 48 00 00       	push   $0x48d5
    1430:	6a 01                	push   $0x1
    1432:	e8 49 30 00 00       	call   4480 <printf>
    1437:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    143a:	83 ec 0c             	sub    $0xc,%esp
    143d:	6a 01                	push   $0x1
    143f:	e8 bf 2e 00 00       	call   4303 <exit>
    }

    if(pid == 0){
    1444:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1448:	0f 85 d2 00 00 00    	jne    1520 <createdelete+0x12a>
      name[0] = 'p' + pi;
    144e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1451:	83 c0 70             	add    $0x70,%eax
    1454:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    1457:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    145b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1462:	e9 a5 00 00 00       	jmp    150c <createdelete+0x116>
        name[1] = '0' + i;
    1467:	8b 45 f4             	mov    -0xc(%ebp),%eax
    146a:	83 c0 30             	add    $0x30,%eax
    146d:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1470:	83 ec 08             	sub    $0x8,%esp
    1473:	68 02 02 00 00       	push   $0x202
    1478:	8d 45 c8             	lea    -0x38(%ebp),%eax
    147b:	50                   	push   %eax
    147c:	e8 c2 2e 00 00       	call   4343 <open>
    1481:	83 c4 10             	add    $0x10,%esp
    1484:	89 45 e8             	mov    %eax,-0x18(%ebp)
        if(fd < 0){
    1487:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    148b:	79 1c                	jns    14a9 <createdelete+0xb3>
          printf(1, "create failed\n");
    148d:	83 ec 08             	sub    $0x8,%esp
    1490:	68 69 4e 00 00       	push   $0x4e69
    1495:	6a 01                	push   $0x1
    1497:	e8 e4 2f 00 00       	call   4480 <printf>
    149c:	83 c4 10             	add    $0x10,%esp
          exit(EXIT_STATUS_OK);
    149f:	83 ec 0c             	sub    $0xc,%esp
    14a2:	6a 01                	push   $0x1
    14a4:	e8 5a 2e 00 00       	call   4303 <exit>
        }
        close(fd);
    14a9:	83 ec 0c             	sub    $0xc,%esp
    14ac:	ff 75 e8             	pushl  -0x18(%ebp)
    14af:	e8 77 2e 00 00       	call   432b <close>
    14b4:	83 c4 10             	add    $0x10,%esp
        if(i > 0 && (i % 2 ) == 0){
    14b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14bb:	7e 4b                	jle    1508 <createdelete+0x112>
    14bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14c0:	83 e0 01             	and    $0x1,%eax
    14c3:	85 c0                	test   %eax,%eax
    14c5:	75 41                	jne    1508 <createdelete+0x112>
          name[1] = '0' + (i / 2);
    14c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14ca:	89 c2                	mov    %eax,%edx
    14cc:	c1 ea 1f             	shr    $0x1f,%edx
    14cf:	01 d0                	add    %edx,%eax
    14d1:	d1 f8                	sar    %eax
    14d3:	83 c0 30             	add    $0x30,%eax
    14d6:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    14d9:	83 ec 0c             	sub    $0xc,%esp
    14dc:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14df:	50                   	push   %eax
    14e0:	e8 6e 2e 00 00       	call   4353 <unlink>
    14e5:	83 c4 10             	add    $0x10,%esp
    14e8:	85 c0                	test   %eax,%eax
    14ea:	79 1c                	jns    1508 <createdelete+0x112>
            printf(1, "unlink failed\n");
    14ec:	83 ec 08             	sub    $0x8,%esp
    14ef:	68 58 49 00 00       	push   $0x4958
    14f4:	6a 01                	push   $0x1
    14f6:	e8 85 2f 00 00       	call   4480 <printf>
    14fb:	83 c4 10             	add    $0x10,%esp
            exit(EXIT_STATUS_OK);
    14fe:	83 ec 0c             	sub    $0xc,%esp
    1501:	6a 01                	push   $0x1
    1503:	e8 fb 2d 00 00       	call   4303 <exit>
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
    1508:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    150c:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1510:	0f 8e 51 ff ff ff    	jle    1467 <createdelete+0x71>
            printf(1, "unlink failed\n");
            exit(EXIT_STATUS_OK);
          }
        }
      }
      exit(EXIT_STATUS_OK);
    1516:	83 ec 0c             	sub    $0xc,%esp
    1519:	6a 01                	push   $0x1
    151b:	e8 e3 2d 00 00       	call   4303 <exit>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1520:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1524:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    1528:	0f 8e ec fe ff ff    	jle    141a <createdelete+0x24>
      }
      exit(EXIT_STATUS_OK);
    }
  }

  for(pi = 0; pi < 4; pi++){
    152e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1535:	eb 11                	jmp    1548 <createdelete+0x152>
    wait(0);
    1537:	83 ec 0c             	sub    $0xc,%esp
    153a:	6a 00                	push   $0x0
    153c:	e8 ca 2d 00 00       	call   430b <wait>
    1541:	83 c4 10             	add    $0x10,%esp
      }
      exit(EXIT_STATUS_OK);
    }
  }

  for(pi = 0; pi < 4; pi++){
    1544:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1548:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    154c:	7e e9                	jle    1537 <createdelete+0x141>
    wait(0);
  }

  name[0] = name[1] = name[2] = 0;
    154e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1552:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
    1556:	88 45 c9             	mov    %al,-0x37(%ebp)
    1559:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
    155d:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    1560:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1567:	e9 bc 00 00 00       	jmp    1628 <createdelete+0x232>
    for(pi = 0; pi < 4; pi++){
    156c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1573:	e9 a2 00 00 00       	jmp    161a <createdelete+0x224>
      name[0] = 'p' + pi;
    1578:	8b 45 f0             	mov    -0x10(%ebp),%eax
    157b:	83 c0 70             	add    $0x70,%eax
    157e:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1581:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1584:	83 c0 30             	add    $0x30,%eax
    1587:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    158a:	83 ec 08             	sub    $0x8,%esp
    158d:	6a 00                	push   $0x0
    158f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1592:	50                   	push   %eax
    1593:	e8 ab 2d 00 00       	call   4343 <open>
    1598:	83 c4 10             	add    $0x10,%esp
    159b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    159e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15a2:	74 06                	je     15aa <createdelete+0x1b4>
    15a4:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    15a8:	7e 26                	jle    15d0 <createdelete+0x1da>
    15aa:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    15ae:	79 20                	jns    15d0 <createdelete+0x1da>
        printf(1, "oops createdelete %s didn't exist\n", name);
    15b0:	83 ec 04             	sub    $0x4,%esp
    15b3:	8d 45 c8             	lea    -0x38(%ebp),%eax
    15b6:	50                   	push   %eax
    15b7:	68 c8 4e 00 00       	push   $0x4ec8
    15bc:	6a 01                	push   $0x1
    15be:	e8 bd 2e 00 00       	call   4480 <printf>
    15c3:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
    15c6:	83 ec 0c             	sub    $0xc,%esp
    15c9:	6a 01                	push   $0x1
    15cb:	e8 33 2d 00 00       	call   4303 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    15d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15d4:	7e 2c                	jle    1602 <createdelete+0x20c>
    15d6:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    15da:	7f 26                	jg     1602 <createdelete+0x20c>
    15dc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    15e0:	78 20                	js     1602 <createdelete+0x20c>
        printf(1, "oops createdelete %s did exist\n", name);
    15e2:	83 ec 04             	sub    $0x4,%esp
    15e5:	8d 45 c8             	lea    -0x38(%ebp),%eax
    15e8:	50                   	push   %eax
    15e9:	68 ec 4e 00 00       	push   $0x4eec
    15ee:	6a 01                	push   $0x1
    15f0:	e8 8b 2e 00 00       	call   4480 <printf>
    15f5:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
    15f8:	83 ec 0c             	sub    $0xc,%esp
    15fb:	6a 01                	push   $0x1
    15fd:	e8 01 2d 00 00       	call   4303 <exit>
      }
      if(fd >= 0)
    1602:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1606:	78 0e                	js     1616 <createdelete+0x220>
        close(fd);
    1608:	83 ec 0c             	sub    $0xc,%esp
    160b:	ff 75 e8             	pushl  -0x18(%ebp)
    160e:	e8 18 2d 00 00       	call   432b <close>
    1613:	83 c4 10             	add    $0x10,%esp
    wait(0);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1616:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    161a:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    161e:	0f 8e 54 ff ff ff    	jle    1578 <createdelete+0x182>
  for(pi = 0; pi < 4; pi++){
    wait(0);
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1624:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1628:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    162c:	0f 8e 3a ff ff ff    	jle    156c <createdelete+0x176>
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    1632:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1639:	eb 38                	jmp    1673 <createdelete+0x27d>
    for(pi = 0; pi < 4; pi++){
    163b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1642:	eb 25                	jmp    1669 <createdelete+0x273>
      name[0] = 'p' + i;
    1644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1647:	83 c0 70             	add    $0x70,%eax
    164a:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    164d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1650:	83 c0 30             	add    $0x30,%eax
    1653:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    1656:	83 ec 0c             	sub    $0xc,%esp
    1659:	8d 45 c8             	lea    -0x38(%ebp),%eax
    165c:	50                   	push   %eax
    165d:	e8 f1 2c 00 00       	call   4353 <unlink>
    1662:	83 c4 10             	add    $0x10,%esp
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1665:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1669:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    166d:	7e d5                	jle    1644 <createdelete+0x24e>
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    166f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1673:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1677:	7e c2                	jle    163b <createdelete+0x245>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    1679:	83 ec 08             	sub    $0x8,%esp
    167c:	68 0c 4f 00 00       	push   $0x4f0c
    1681:	6a 01                	push   $0x1
    1683:	e8 f8 2d 00 00       	call   4480 <printf>
    1688:	83 c4 10             	add    $0x10,%esp
}
    168b:	c9                   	leave  
    168c:	c3                   	ret    

0000168d <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    168d:	55                   	push   %ebp
    168e:	89 e5                	mov    %esp,%ebp
    1690:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1693:	83 ec 08             	sub    $0x8,%esp
    1696:	68 1d 4f 00 00       	push   $0x4f1d
    169b:	6a 01                	push   $0x1
    169d:	e8 de 2d 00 00       	call   4480 <printf>
    16a2:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    16a5:	83 ec 08             	sub    $0x8,%esp
    16a8:	68 02 02 00 00       	push   $0x202
    16ad:	68 2e 4f 00 00       	push   $0x4f2e
    16b2:	e8 8c 2c 00 00       	call   4343 <open>
    16b7:	83 c4 10             	add    $0x10,%esp
    16ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    16bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16c1:	79 1c                	jns    16df <unlinkread+0x52>
    printf(1, "create unlinkread failed\n");
    16c3:	83 ec 08             	sub    $0x8,%esp
    16c6:	68 39 4f 00 00       	push   $0x4f39
    16cb:	6a 01                	push   $0x1
    16cd:	e8 ae 2d 00 00       	call   4480 <printf>
    16d2:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    16d5:	83 ec 0c             	sub    $0xc,%esp
    16d8:	6a 01                	push   $0x1
    16da:	e8 24 2c 00 00       	call   4303 <exit>
  }
  write(fd, "hello", 5);
    16df:	83 ec 04             	sub    $0x4,%esp
    16e2:	6a 05                	push   $0x5
    16e4:	68 53 4f 00 00       	push   $0x4f53
    16e9:	ff 75 f4             	pushl  -0xc(%ebp)
    16ec:	e8 32 2c 00 00       	call   4323 <write>
    16f1:	83 c4 10             	add    $0x10,%esp
  close(fd);
    16f4:	83 ec 0c             	sub    $0xc,%esp
    16f7:	ff 75 f4             	pushl  -0xc(%ebp)
    16fa:	e8 2c 2c 00 00       	call   432b <close>
    16ff:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    1702:	83 ec 08             	sub    $0x8,%esp
    1705:	6a 02                	push   $0x2
    1707:	68 2e 4f 00 00       	push   $0x4f2e
    170c:	e8 32 2c 00 00       	call   4343 <open>
    1711:	83 c4 10             	add    $0x10,%esp
    1714:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1717:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    171b:	79 1c                	jns    1739 <unlinkread+0xac>
    printf(1, "open unlinkread failed\n");
    171d:	83 ec 08             	sub    $0x8,%esp
    1720:	68 59 4f 00 00       	push   $0x4f59
    1725:	6a 01                	push   $0x1
    1727:	e8 54 2d 00 00       	call   4480 <printf>
    172c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    172f:	83 ec 0c             	sub    $0xc,%esp
    1732:	6a 01                	push   $0x1
    1734:	e8 ca 2b 00 00       	call   4303 <exit>
  }
  if(unlink("unlinkread") != 0){
    1739:	83 ec 0c             	sub    $0xc,%esp
    173c:	68 2e 4f 00 00       	push   $0x4f2e
    1741:	e8 0d 2c 00 00       	call   4353 <unlink>
    1746:	83 c4 10             	add    $0x10,%esp
    1749:	85 c0                	test   %eax,%eax
    174b:	74 1c                	je     1769 <unlinkread+0xdc>
    printf(1, "unlink unlinkread failed\n");
    174d:	83 ec 08             	sub    $0x8,%esp
    1750:	68 71 4f 00 00       	push   $0x4f71
    1755:	6a 01                	push   $0x1
    1757:	e8 24 2d 00 00       	call   4480 <printf>
    175c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    175f:	83 ec 0c             	sub    $0xc,%esp
    1762:	6a 01                	push   $0x1
    1764:	e8 9a 2b 00 00       	call   4303 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1769:	83 ec 08             	sub    $0x8,%esp
    176c:	68 02 02 00 00       	push   $0x202
    1771:	68 2e 4f 00 00       	push   $0x4f2e
    1776:	e8 c8 2b 00 00       	call   4343 <open>
    177b:	83 c4 10             	add    $0x10,%esp
    177e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    1781:	83 ec 04             	sub    $0x4,%esp
    1784:	6a 03                	push   $0x3
    1786:	68 8b 4f 00 00       	push   $0x4f8b
    178b:	ff 75 f0             	pushl  -0x10(%ebp)
    178e:	e8 90 2b 00 00       	call   4323 <write>
    1793:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1796:	83 ec 0c             	sub    $0xc,%esp
    1799:	ff 75 f0             	pushl  -0x10(%ebp)
    179c:	e8 8a 2b 00 00       	call   432b <close>
    17a1:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    17a4:	83 ec 04             	sub    $0x4,%esp
    17a7:	68 00 20 00 00       	push   $0x2000
    17ac:	68 40 8f 00 00       	push   $0x8f40
    17b1:	ff 75 f4             	pushl  -0xc(%ebp)
    17b4:	e8 62 2b 00 00       	call   431b <read>
    17b9:	83 c4 10             	add    $0x10,%esp
    17bc:	83 f8 05             	cmp    $0x5,%eax
    17bf:	74 1c                	je     17dd <unlinkread+0x150>
    printf(1, "unlinkread read failed");
    17c1:	83 ec 08             	sub    $0x8,%esp
    17c4:	68 8f 4f 00 00       	push   $0x4f8f
    17c9:	6a 01                	push   $0x1
    17cb:	e8 b0 2c 00 00       	call   4480 <printf>
    17d0:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    17d3:	83 ec 0c             	sub    $0xc,%esp
    17d6:	6a 01                	push   $0x1
    17d8:	e8 26 2b 00 00       	call   4303 <exit>
  }
  if(buf[0] != 'h'){
    17dd:	0f b6 05 40 8f 00 00 	movzbl 0x8f40,%eax
    17e4:	3c 68                	cmp    $0x68,%al
    17e6:	74 1c                	je     1804 <unlinkread+0x177>
    printf(1, "unlinkread wrong data\n");
    17e8:	83 ec 08             	sub    $0x8,%esp
    17eb:	68 a6 4f 00 00       	push   $0x4fa6
    17f0:	6a 01                	push   $0x1
    17f2:	e8 89 2c 00 00       	call   4480 <printf>
    17f7:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    17fa:	83 ec 0c             	sub    $0xc,%esp
    17fd:	6a 01                	push   $0x1
    17ff:	e8 ff 2a 00 00       	call   4303 <exit>
  }
  if(write(fd, buf, 10) != 10){
    1804:	83 ec 04             	sub    $0x4,%esp
    1807:	6a 0a                	push   $0xa
    1809:	68 40 8f 00 00       	push   $0x8f40
    180e:	ff 75 f4             	pushl  -0xc(%ebp)
    1811:	e8 0d 2b 00 00       	call   4323 <write>
    1816:	83 c4 10             	add    $0x10,%esp
    1819:	83 f8 0a             	cmp    $0xa,%eax
    181c:	74 1c                	je     183a <unlinkread+0x1ad>
    printf(1, "unlinkread write failed\n");
    181e:	83 ec 08             	sub    $0x8,%esp
    1821:	68 bd 4f 00 00       	push   $0x4fbd
    1826:	6a 01                	push   $0x1
    1828:	e8 53 2c 00 00       	call   4480 <printf>
    182d:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    1830:	83 ec 0c             	sub    $0xc,%esp
    1833:	6a 01                	push   $0x1
    1835:	e8 c9 2a 00 00       	call   4303 <exit>
  }
  close(fd);
    183a:	83 ec 0c             	sub    $0xc,%esp
    183d:	ff 75 f4             	pushl  -0xc(%ebp)
    1840:	e8 e6 2a 00 00       	call   432b <close>
    1845:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    1848:	83 ec 0c             	sub    $0xc,%esp
    184b:	68 2e 4f 00 00       	push   $0x4f2e
    1850:	e8 fe 2a 00 00       	call   4353 <unlink>
    1855:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    1858:	83 ec 08             	sub    $0x8,%esp
    185b:	68 d6 4f 00 00       	push   $0x4fd6
    1860:	6a 01                	push   $0x1
    1862:	e8 19 2c 00 00       	call   4480 <printf>
    1867:	83 c4 10             	add    $0x10,%esp
}
    186a:	c9                   	leave  
    186b:	c3                   	ret    

0000186c <linktest>:

void
linktest(void)
{
    186c:	55                   	push   %ebp
    186d:	89 e5                	mov    %esp,%ebp
    186f:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    1872:	83 ec 08             	sub    $0x8,%esp
    1875:	68 e5 4f 00 00       	push   $0x4fe5
    187a:	6a 01                	push   $0x1
    187c:	e8 ff 2b 00 00       	call   4480 <printf>
    1881:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    1884:	83 ec 0c             	sub    $0xc,%esp
    1887:	68 ef 4f 00 00       	push   $0x4fef
    188c:	e8 c2 2a 00 00       	call   4353 <unlink>
    1891:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    1894:	83 ec 0c             	sub    $0xc,%esp
    1897:	68 f3 4f 00 00       	push   $0x4ff3
    189c:	e8 b2 2a 00 00       	call   4353 <unlink>
    18a1:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    18a4:	83 ec 08             	sub    $0x8,%esp
    18a7:	68 02 02 00 00       	push   $0x202
    18ac:	68 ef 4f 00 00       	push   $0x4fef
    18b1:	e8 8d 2a 00 00       	call   4343 <open>
    18b6:	83 c4 10             	add    $0x10,%esp
    18b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    18bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18c0:	79 1c                	jns    18de <linktest+0x72>
    printf(1, "create lf1 failed\n");
    18c2:	83 ec 08             	sub    $0x8,%esp
    18c5:	68 f7 4f 00 00       	push   $0x4ff7
    18ca:	6a 01                	push   $0x1
    18cc:	e8 af 2b 00 00       	call   4480 <printf>
    18d1:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    18d4:	83 ec 0c             	sub    $0xc,%esp
    18d7:	6a 01                	push   $0x1
    18d9:	e8 25 2a 00 00       	call   4303 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    18de:	83 ec 04             	sub    $0x4,%esp
    18e1:	6a 05                	push   $0x5
    18e3:	68 53 4f 00 00       	push   $0x4f53
    18e8:	ff 75 f4             	pushl  -0xc(%ebp)
    18eb:	e8 33 2a 00 00       	call   4323 <write>
    18f0:	83 c4 10             	add    $0x10,%esp
    18f3:	83 f8 05             	cmp    $0x5,%eax
    18f6:	74 1c                	je     1914 <linktest+0xa8>
    printf(1, "write lf1 failed\n");
    18f8:	83 ec 08             	sub    $0x8,%esp
    18fb:	68 0a 50 00 00       	push   $0x500a
    1900:	6a 01                	push   $0x1
    1902:	e8 79 2b 00 00       	call   4480 <printf>
    1907:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    190a:	83 ec 0c             	sub    $0xc,%esp
    190d:	6a 01                	push   $0x1
    190f:	e8 ef 29 00 00       	call   4303 <exit>
  }
  close(fd);
    1914:	83 ec 0c             	sub    $0xc,%esp
    1917:	ff 75 f4             	pushl  -0xc(%ebp)
    191a:	e8 0c 2a 00 00       	call   432b <close>
    191f:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    1922:	83 ec 08             	sub    $0x8,%esp
    1925:	68 f3 4f 00 00       	push   $0x4ff3
    192a:	68 ef 4f 00 00       	push   $0x4fef
    192f:	e8 2f 2a 00 00       	call   4363 <link>
    1934:	83 c4 10             	add    $0x10,%esp
    1937:	85 c0                	test   %eax,%eax
    1939:	79 1c                	jns    1957 <linktest+0xeb>
    printf(1, "link lf1 lf2 failed\n");
    193b:	83 ec 08             	sub    $0x8,%esp
    193e:	68 1c 50 00 00       	push   $0x501c
    1943:	6a 01                	push   $0x1
    1945:	e8 36 2b 00 00       	call   4480 <printf>
    194a:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    194d:	83 ec 0c             	sub    $0xc,%esp
    1950:	6a 01                	push   $0x1
    1952:	e8 ac 29 00 00       	call   4303 <exit>
  }
  unlink("lf1");
    1957:	83 ec 0c             	sub    $0xc,%esp
    195a:	68 ef 4f 00 00       	push   $0x4fef
    195f:	e8 ef 29 00 00       	call   4353 <unlink>
    1964:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    1967:	83 ec 08             	sub    $0x8,%esp
    196a:	6a 00                	push   $0x0
    196c:	68 ef 4f 00 00       	push   $0x4fef
    1971:	e8 cd 29 00 00       	call   4343 <open>
    1976:	83 c4 10             	add    $0x10,%esp
    1979:	85 c0                	test   %eax,%eax
    197b:	78 1c                	js     1999 <linktest+0x12d>
    printf(1, "unlinked lf1 but it is still there!\n");
    197d:	83 ec 08             	sub    $0x8,%esp
    1980:	68 34 50 00 00       	push   $0x5034
    1985:	6a 01                	push   $0x1
    1987:	e8 f4 2a 00 00       	call   4480 <printf>
    198c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    198f:	83 ec 0c             	sub    $0xc,%esp
    1992:	6a 01                	push   $0x1
    1994:	e8 6a 29 00 00       	call   4303 <exit>
  }

  fd = open("lf2", 0);
    1999:	83 ec 08             	sub    $0x8,%esp
    199c:	6a 00                	push   $0x0
    199e:	68 f3 4f 00 00       	push   $0x4ff3
    19a3:	e8 9b 29 00 00       	call   4343 <open>
    19a8:	83 c4 10             	add    $0x10,%esp
    19ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    19ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19b2:	79 1c                	jns    19d0 <linktest+0x164>
    printf(1, "open lf2 failed\n");
    19b4:	83 ec 08             	sub    $0x8,%esp
    19b7:	68 59 50 00 00       	push   $0x5059
    19bc:	6a 01                	push   $0x1
    19be:	e8 bd 2a 00 00       	call   4480 <printf>
    19c3:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    19c6:	83 ec 0c             	sub    $0xc,%esp
    19c9:	6a 01                	push   $0x1
    19cb:	e8 33 29 00 00       	call   4303 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    19d0:	83 ec 04             	sub    $0x4,%esp
    19d3:	68 00 20 00 00       	push   $0x2000
    19d8:	68 40 8f 00 00       	push   $0x8f40
    19dd:	ff 75 f4             	pushl  -0xc(%ebp)
    19e0:	e8 36 29 00 00       	call   431b <read>
    19e5:	83 c4 10             	add    $0x10,%esp
    19e8:	83 f8 05             	cmp    $0x5,%eax
    19eb:	74 1c                	je     1a09 <linktest+0x19d>
    printf(1, "read lf2 failed\n");
    19ed:	83 ec 08             	sub    $0x8,%esp
    19f0:	68 6a 50 00 00       	push   $0x506a
    19f5:	6a 01                	push   $0x1
    19f7:	e8 84 2a 00 00       	call   4480 <printf>
    19fc:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    19ff:	83 ec 0c             	sub    $0xc,%esp
    1a02:	6a 01                	push   $0x1
    1a04:	e8 fa 28 00 00       	call   4303 <exit>
  }
  close(fd);
    1a09:	83 ec 0c             	sub    $0xc,%esp
    1a0c:	ff 75 f4             	pushl  -0xc(%ebp)
    1a0f:	e8 17 29 00 00       	call   432b <close>
    1a14:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    1a17:	83 ec 08             	sub    $0x8,%esp
    1a1a:	68 f3 4f 00 00       	push   $0x4ff3
    1a1f:	68 f3 4f 00 00       	push   $0x4ff3
    1a24:	e8 3a 29 00 00       	call   4363 <link>
    1a29:	83 c4 10             	add    $0x10,%esp
    1a2c:	85 c0                	test   %eax,%eax
    1a2e:	78 1c                	js     1a4c <linktest+0x1e0>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1a30:	83 ec 08             	sub    $0x8,%esp
    1a33:	68 7b 50 00 00       	push   $0x507b
    1a38:	6a 01                	push   $0x1
    1a3a:	e8 41 2a 00 00       	call   4480 <printf>
    1a3f:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    1a42:	83 ec 0c             	sub    $0xc,%esp
    1a45:	6a 01                	push   $0x1
    1a47:	e8 b7 28 00 00       	call   4303 <exit>
  }

  unlink("lf2");
    1a4c:	83 ec 0c             	sub    $0xc,%esp
    1a4f:	68 f3 4f 00 00       	push   $0x4ff3
    1a54:	e8 fa 28 00 00       	call   4353 <unlink>
    1a59:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    1a5c:	83 ec 08             	sub    $0x8,%esp
    1a5f:	68 ef 4f 00 00       	push   $0x4fef
    1a64:	68 f3 4f 00 00       	push   $0x4ff3
    1a69:	e8 f5 28 00 00       	call   4363 <link>
    1a6e:	83 c4 10             	add    $0x10,%esp
    1a71:	85 c0                	test   %eax,%eax
    1a73:	78 1c                	js     1a91 <linktest+0x225>
    printf(1, "link non-existant succeeded! oops\n");
    1a75:	83 ec 08             	sub    $0x8,%esp
    1a78:	68 9c 50 00 00       	push   $0x509c
    1a7d:	6a 01                	push   $0x1
    1a7f:	e8 fc 29 00 00       	call   4480 <printf>
    1a84:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    1a87:	83 ec 0c             	sub    $0xc,%esp
    1a8a:	6a 01                	push   $0x1
    1a8c:	e8 72 28 00 00       	call   4303 <exit>
  }

  if(link(".", "lf1") >= 0){
    1a91:	83 ec 08             	sub    $0x8,%esp
    1a94:	68 ef 4f 00 00       	push   $0x4fef
    1a99:	68 bf 50 00 00       	push   $0x50bf
    1a9e:	e8 c0 28 00 00       	call   4363 <link>
    1aa3:	83 c4 10             	add    $0x10,%esp
    1aa6:	85 c0                	test   %eax,%eax
    1aa8:	78 1c                	js     1ac6 <linktest+0x25a>
    printf(1, "link . lf1 succeeded! oops\n");
    1aaa:	83 ec 08             	sub    $0x8,%esp
    1aad:	68 c1 50 00 00       	push   $0x50c1
    1ab2:	6a 01                	push   $0x1
    1ab4:	e8 c7 29 00 00       	call   4480 <printf>
    1ab9:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    1abc:	83 ec 0c             	sub    $0xc,%esp
    1abf:	6a 01                	push   $0x1
    1ac1:	e8 3d 28 00 00       	call   4303 <exit>
  }

  printf(1, "linktest ok\n");
    1ac6:	83 ec 08             	sub    $0x8,%esp
    1ac9:	68 dd 50 00 00       	push   $0x50dd
    1ace:	6a 01                	push   $0x1
    1ad0:	e8 ab 29 00 00       	call   4480 <printf>
    1ad5:	83 c4 10             	add    $0x10,%esp
}
    1ad8:	c9                   	leave  
    1ad9:	c3                   	ret    

00001ada <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1ada:	55                   	push   %ebp
    1adb:	89 e5                	mov    %esp,%ebp
    1add:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1ae0:	83 ec 08             	sub    $0x8,%esp
    1ae3:	68 ea 50 00 00       	push   $0x50ea
    1ae8:	6a 01                	push   $0x1
    1aea:	e8 91 29 00 00       	call   4480 <printf>
    1aef:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    1af2:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1af6:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1afa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b01:	e9 0e 01 00 00       	jmp    1c14 <concreate+0x13a>
    file[1] = '0' + i;
    1b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b09:	83 c0 30             	add    $0x30,%eax
    1b0c:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    1b0f:	83 ec 0c             	sub    $0xc,%esp
    1b12:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1b15:	50                   	push   %eax
    1b16:	e8 38 28 00 00       	call   4353 <unlink>
    1b1b:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    1b1e:	e8 d8 27 00 00       	call   42fb <fork>
    1b23:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid && (i % 3) == 1){
    1b26:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b2a:	74 3b                	je     1b67 <concreate+0x8d>
    1b2c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1b2f:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1b34:	89 c8                	mov    %ecx,%eax
    1b36:	f7 ea                	imul   %edx
    1b38:	89 c8                	mov    %ecx,%eax
    1b3a:	c1 f8 1f             	sar    $0x1f,%eax
    1b3d:	29 c2                	sub    %eax,%edx
    1b3f:	89 d0                	mov    %edx,%eax
    1b41:	01 c0                	add    %eax,%eax
    1b43:	01 d0                	add    %edx,%eax
    1b45:	29 c1                	sub    %eax,%ecx
    1b47:	89 ca                	mov    %ecx,%edx
    1b49:	83 fa 01             	cmp    $0x1,%edx
    1b4c:	75 19                	jne    1b67 <concreate+0x8d>
      link("C0", file);
    1b4e:	83 ec 08             	sub    $0x8,%esp
    1b51:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1b54:	50                   	push   %eax
    1b55:	68 fa 50 00 00       	push   $0x50fa
    1b5a:	e8 04 28 00 00       	call   4363 <link>
    1b5f:	83 c4 10             	add    $0x10,%esp
    1b62:	e9 8c 00 00 00       	jmp    1bf3 <concreate+0x119>
    } else if(pid == 0 && (i % 5) == 1){
    1b67:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b6b:	75 3b                	jne    1ba8 <concreate+0xce>
    1b6d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1b70:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1b75:	89 c8                	mov    %ecx,%eax
    1b77:	f7 ea                	imul   %edx
    1b79:	d1 fa                	sar    %edx
    1b7b:	89 c8                	mov    %ecx,%eax
    1b7d:	c1 f8 1f             	sar    $0x1f,%eax
    1b80:	29 c2                	sub    %eax,%edx
    1b82:	89 d0                	mov    %edx,%eax
    1b84:	c1 e0 02             	shl    $0x2,%eax
    1b87:	01 d0                	add    %edx,%eax
    1b89:	29 c1                	sub    %eax,%ecx
    1b8b:	89 ca                	mov    %ecx,%edx
    1b8d:	83 fa 01             	cmp    $0x1,%edx
    1b90:	75 16                	jne    1ba8 <concreate+0xce>
      link("C0", file);
    1b92:	83 ec 08             	sub    $0x8,%esp
    1b95:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1b98:	50                   	push   %eax
    1b99:	68 fa 50 00 00       	push   $0x50fa
    1b9e:	e8 c0 27 00 00       	call   4363 <link>
    1ba3:	83 c4 10             	add    $0x10,%esp
    1ba6:	eb 4b                	jmp    1bf3 <concreate+0x119>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1ba8:	83 ec 08             	sub    $0x8,%esp
    1bab:	68 02 02 00 00       	push   $0x202
    1bb0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bb3:	50                   	push   %eax
    1bb4:	e8 8a 27 00 00       	call   4343 <open>
    1bb9:	83 c4 10             	add    $0x10,%esp
    1bbc:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(fd < 0){
    1bbf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1bc3:	79 20                	jns    1be5 <concreate+0x10b>
        printf(1, "concreate create %s failed\n", file);
    1bc5:	83 ec 04             	sub    $0x4,%esp
    1bc8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bcb:	50                   	push   %eax
    1bcc:	68 fd 50 00 00       	push   $0x50fd
    1bd1:	6a 01                	push   $0x1
    1bd3:	e8 a8 28 00 00       	call   4480 <printf>
    1bd8:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
    1bdb:	83 ec 0c             	sub    $0xc,%esp
    1bde:	6a 01                	push   $0x1
    1be0:	e8 1e 27 00 00       	call   4303 <exit>
      }
      close(fd);
    1be5:	83 ec 0c             	sub    $0xc,%esp
    1be8:	ff 75 e8             	pushl  -0x18(%ebp)
    1beb:	e8 3b 27 00 00       	call   432b <close>
    1bf0:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1bf3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bf7:	75 0a                	jne    1c03 <concreate+0x129>
      exit(EXIT_STATUS_OK);
    1bf9:	83 ec 0c             	sub    $0xc,%esp
    1bfc:	6a 01                	push   $0x1
    1bfe:	e8 00 27 00 00       	call   4303 <exit>
    else
      wait(0);
    1c03:	83 ec 0c             	sub    $0xc,%esp
    1c06:	6a 00                	push   $0x0
    1c08:	e8 fe 26 00 00       	call   430b <wait>
    1c0d:	83 c4 10             	add    $0x10,%esp
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1c10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c14:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1c18:	0f 8e e8 fe ff ff    	jle    1b06 <concreate+0x2c>
      exit(EXIT_STATUS_OK);
    else
      wait(0);
  }

  memset(fa, 0, sizeof(fa));
    1c1e:	83 ec 04             	sub    $0x4,%esp
    1c21:	6a 28                	push   $0x28
    1c23:	6a 00                	push   $0x0
    1c25:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1c28:	50                   	push   %eax
    1c29:	e8 3b 25 00 00       	call   4169 <memset>
    1c2e:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1c31:	83 ec 08             	sub    $0x8,%esp
    1c34:	6a 00                	push   $0x0
    1c36:	68 bf 50 00 00       	push   $0x50bf
    1c3b:	e8 03 27 00 00       	call   4343 <open>
    1c40:	83 c4 10             	add    $0x10,%esp
    1c43:	89 45 e8             	mov    %eax,-0x18(%ebp)
  n = 0;
    1c46:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1c4d:	e9 a1 00 00 00       	jmp    1cf3 <concreate+0x219>
    if(de.inum == 0)
    1c52:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    1c56:	66 85 c0             	test   %ax,%ax
    1c59:	75 05                	jne    1c60 <concreate+0x186>
      continue;
    1c5b:	e9 93 00 00 00       	jmp    1cf3 <concreate+0x219>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1c60:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    1c64:	3c 43                	cmp    $0x43,%al
    1c66:	0f 85 87 00 00 00    	jne    1cf3 <concreate+0x219>
    1c6c:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    1c70:	84 c0                	test   %al,%al
    1c72:	75 7f                	jne    1cf3 <concreate+0x219>
      i = de.name[1] - '0';
    1c74:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    1c78:	0f be c0             	movsbl %al,%eax
    1c7b:	83 e8 30             	sub    $0x30,%eax
    1c7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1c81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c85:	78 08                	js     1c8f <concreate+0x1b5>
    1c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c8a:	83 f8 27             	cmp    $0x27,%eax
    1c8d:	76 23                	jbe    1cb2 <concreate+0x1d8>
        printf(1, "concreate weird file %s\n", de.name);
    1c8f:	83 ec 04             	sub    $0x4,%esp
    1c92:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1c95:	83 c0 02             	add    $0x2,%eax
    1c98:	50                   	push   %eax
    1c99:	68 19 51 00 00       	push   $0x5119
    1c9e:	6a 01                	push   $0x1
    1ca0:	e8 db 27 00 00       	call   4480 <printf>
    1ca5:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
    1ca8:	83 ec 0c             	sub    $0xc,%esp
    1cab:	6a 01                	push   $0x1
    1cad:	e8 51 26 00 00       	call   4303 <exit>
      }
      if(fa[i]){
    1cb2:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1cb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cb8:	01 d0                	add    %edx,%eax
    1cba:	0f b6 00             	movzbl (%eax),%eax
    1cbd:	84 c0                	test   %al,%al
    1cbf:	74 23                	je     1ce4 <concreate+0x20a>
        printf(1, "concreate duplicate file %s\n", de.name);
    1cc1:	83 ec 04             	sub    $0x4,%esp
    1cc4:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1cc7:	83 c0 02             	add    $0x2,%eax
    1cca:	50                   	push   %eax
    1ccb:	68 32 51 00 00       	push   $0x5132
    1cd0:	6a 01                	push   $0x1
    1cd2:	e8 a9 27 00 00       	call   4480 <printf>
    1cd7:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
    1cda:	83 ec 0c             	sub    $0xc,%esp
    1cdd:	6a 01                	push   $0x1
    1cdf:	e8 1f 26 00 00       	call   4303 <exit>
      }
      fa[i] = 1;
    1ce4:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cea:	01 d0                	add    %edx,%eax
    1cec:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1cef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1cf3:	83 ec 04             	sub    $0x4,%esp
    1cf6:	6a 10                	push   $0x10
    1cf8:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1cfb:	50                   	push   %eax
    1cfc:	ff 75 e8             	pushl  -0x18(%ebp)
    1cff:	e8 17 26 00 00       	call   431b <read>
    1d04:	83 c4 10             	add    $0x10,%esp
    1d07:	85 c0                	test   %eax,%eax
    1d09:	0f 8f 43 ff ff ff    	jg     1c52 <concreate+0x178>
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    1d0f:	83 ec 0c             	sub    $0xc,%esp
    1d12:	ff 75 e8             	pushl  -0x18(%ebp)
    1d15:	e8 11 26 00 00       	call   432b <close>
    1d1a:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1d1d:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1d21:	74 1c                	je     1d3f <concreate+0x265>
    printf(1, "concreate not enough files in directory listing\n");
    1d23:	83 ec 08             	sub    $0x8,%esp
    1d26:	68 50 51 00 00       	push   $0x5150
    1d2b:	6a 01                	push   $0x1
    1d2d:	e8 4e 27 00 00       	call   4480 <printf>
    1d32:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    1d35:	83 ec 0c             	sub    $0xc,%esp
    1d38:	6a 01                	push   $0x1
    1d3a:	e8 c4 25 00 00       	call   4303 <exit>
  }

  for(i = 0; i < 40; i++){
    1d3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d46:	e9 57 01 00 00       	jmp    1ea2 <concreate+0x3c8>
    file[1] = '0' + i;
    1d4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d4e:	83 c0 30             	add    $0x30,%eax
    1d51:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    1d54:	e8 a2 25 00 00       	call   42fb <fork>
    1d59:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    1d5c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d60:	79 1c                	jns    1d7e <concreate+0x2a4>
      printf(1, "fork failed\n");
    1d62:	83 ec 08             	sub    $0x8,%esp
    1d65:	68 d5 48 00 00       	push   $0x48d5
    1d6a:	6a 01                	push   $0x1
    1d6c:	e8 0f 27 00 00       	call   4480 <printf>
    1d71:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    1d74:	83 ec 0c             	sub    $0xc,%esp
    1d77:	6a 01                	push   $0x1
    1d79:	e8 85 25 00 00       	call   4303 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1d7e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1d81:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1d86:	89 c8                	mov    %ecx,%eax
    1d88:	f7 ea                	imul   %edx
    1d8a:	89 c8                	mov    %ecx,%eax
    1d8c:	c1 f8 1f             	sar    $0x1f,%eax
    1d8f:	29 c2                	sub    %eax,%edx
    1d91:	89 d0                	mov    %edx,%eax
    1d93:	89 c2                	mov    %eax,%edx
    1d95:	01 d2                	add    %edx,%edx
    1d97:	01 c2                	add    %eax,%edx
    1d99:	89 c8                	mov    %ecx,%eax
    1d9b:	29 d0                	sub    %edx,%eax
    1d9d:	85 c0                	test   %eax,%eax
    1d9f:	75 06                	jne    1da7 <concreate+0x2cd>
    1da1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1da5:	74 28                	je     1dcf <concreate+0x2f5>
       ((i % 3) == 1 && pid != 0)){
    1da7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1daa:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1daf:	89 c8                	mov    %ecx,%eax
    1db1:	f7 ea                	imul   %edx
    1db3:	89 c8                	mov    %ecx,%eax
    1db5:	c1 f8 1f             	sar    $0x1f,%eax
    1db8:	29 c2                	sub    %eax,%edx
    1dba:	89 d0                	mov    %edx,%eax
    1dbc:	01 c0                	add    %eax,%eax
    1dbe:	01 d0                	add    %edx,%eax
    1dc0:	29 c1                	sub    %eax,%ecx
    1dc2:	89 ca                	mov    %ecx,%edx
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit(EXIT_STATUS_OK);
    }
    if(((i % 3) == 0 && pid == 0) ||
    1dc4:	83 fa 01             	cmp    $0x1,%edx
    1dc7:	75 7c                	jne    1e45 <concreate+0x36b>
       ((i % 3) == 1 && pid != 0)){
    1dc9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1dcd:	74 76                	je     1e45 <concreate+0x36b>
      close(open(file, 0));
    1dcf:	83 ec 08             	sub    $0x8,%esp
    1dd2:	6a 00                	push   $0x0
    1dd4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1dd7:	50                   	push   %eax
    1dd8:	e8 66 25 00 00       	call   4343 <open>
    1ddd:	83 c4 10             	add    $0x10,%esp
    1de0:	83 ec 0c             	sub    $0xc,%esp
    1de3:	50                   	push   %eax
    1de4:	e8 42 25 00 00       	call   432b <close>
    1de9:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1dec:	83 ec 08             	sub    $0x8,%esp
    1def:	6a 00                	push   $0x0
    1df1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1df4:	50                   	push   %eax
    1df5:	e8 49 25 00 00       	call   4343 <open>
    1dfa:	83 c4 10             	add    $0x10,%esp
    1dfd:	83 ec 0c             	sub    $0xc,%esp
    1e00:	50                   	push   %eax
    1e01:	e8 25 25 00 00       	call   432b <close>
    1e06:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1e09:	83 ec 08             	sub    $0x8,%esp
    1e0c:	6a 00                	push   $0x0
    1e0e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1e11:	50                   	push   %eax
    1e12:	e8 2c 25 00 00       	call   4343 <open>
    1e17:	83 c4 10             	add    $0x10,%esp
    1e1a:	83 ec 0c             	sub    $0xc,%esp
    1e1d:	50                   	push   %eax
    1e1e:	e8 08 25 00 00       	call   432b <close>
    1e23:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1e26:	83 ec 08             	sub    $0x8,%esp
    1e29:	6a 00                	push   $0x0
    1e2b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1e2e:	50                   	push   %eax
    1e2f:	e8 0f 25 00 00       	call   4343 <open>
    1e34:	83 c4 10             	add    $0x10,%esp
    1e37:	83 ec 0c             	sub    $0xc,%esp
    1e3a:	50                   	push   %eax
    1e3b:	e8 eb 24 00 00       	call   432b <close>
    1e40:	83 c4 10             	add    $0x10,%esp
    1e43:	eb 3c                	jmp    1e81 <concreate+0x3a7>
    } else {
      unlink(file);
    1e45:	83 ec 0c             	sub    $0xc,%esp
    1e48:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1e4b:	50                   	push   %eax
    1e4c:	e8 02 25 00 00       	call   4353 <unlink>
    1e51:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1e54:	83 ec 0c             	sub    $0xc,%esp
    1e57:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1e5a:	50                   	push   %eax
    1e5b:	e8 f3 24 00 00       	call   4353 <unlink>
    1e60:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1e63:	83 ec 0c             	sub    $0xc,%esp
    1e66:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1e69:	50                   	push   %eax
    1e6a:	e8 e4 24 00 00       	call   4353 <unlink>
    1e6f:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1e72:	83 ec 0c             	sub    $0xc,%esp
    1e75:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1e78:	50                   	push   %eax
    1e79:	e8 d5 24 00 00       	call   4353 <unlink>
    1e7e:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1e81:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e85:	75 0a                	jne    1e91 <concreate+0x3b7>
      exit(EXIT_STATUS_OK);
    1e87:	83 ec 0c             	sub    $0xc,%esp
    1e8a:	6a 01                	push   $0x1
    1e8c:	e8 72 24 00 00       	call   4303 <exit>
    else
      wait(0);
    1e91:	83 ec 0c             	sub    $0xc,%esp
    1e94:	6a 00                	push   $0x0
    1e96:	e8 70 24 00 00       	call   430b <wait>
    1e9b:	83 c4 10             	add    $0x10,%esp
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit(EXIT_STATUS_OK);
  }

  for(i = 0; i < 40; i++){
    1e9e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ea2:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1ea6:	0f 8e 9f fe ff ff    	jle    1d4b <concreate+0x271>
      exit(EXIT_STATUS_OK);
    else
      wait(0);
  }

  printf(1, "concreate ok\n");
    1eac:	83 ec 08             	sub    $0x8,%esp
    1eaf:	68 81 51 00 00       	push   $0x5181
    1eb4:	6a 01                	push   $0x1
    1eb6:	e8 c5 25 00 00       	call   4480 <printf>
    1ebb:	83 c4 10             	add    $0x10,%esp
}
    1ebe:	c9                   	leave  
    1ebf:	c3                   	ret    

00001ec0 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1ec0:	55                   	push   %ebp
    1ec1:	89 e5                	mov    %esp,%ebp
    1ec3:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1ec6:	83 ec 08             	sub    $0x8,%esp
    1ec9:	68 8f 51 00 00       	push   $0x518f
    1ece:	6a 01                	push   $0x1
    1ed0:	e8 ab 25 00 00       	call   4480 <printf>
    1ed5:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1ed8:	83 ec 0c             	sub    $0xc,%esp
    1edb:	68 0b 4d 00 00       	push   $0x4d0b
    1ee0:	e8 6e 24 00 00       	call   4353 <unlink>
    1ee5:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1ee8:	e8 0e 24 00 00       	call   42fb <fork>
    1eed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1ef0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ef4:	79 1c                	jns    1f12 <linkunlink+0x52>
    printf(1, "fork failed\n");
    1ef6:	83 ec 08             	sub    $0x8,%esp
    1ef9:	68 d5 48 00 00       	push   $0x48d5
    1efe:	6a 01                	push   $0x1
    1f00:	e8 7b 25 00 00       	call   4480 <printf>
    1f05:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    1f08:	83 ec 0c             	sub    $0xc,%esp
    1f0b:	6a 01                	push   $0x1
    1f0d:	e8 f1 23 00 00       	call   4303 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1f12:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f16:	74 07                	je     1f1f <linkunlink+0x5f>
    1f18:	b8 01 00 00 00       	mov    $0x1,%eax
    1f1d:	eb 05                	jmp    1f24 <linkunlink+0x64>
    1f1f:	b8 61 00 00 00       	mov    $0x61,%eax
    1f24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1f27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f2e:	e9 9a 00 00 00       	jmp    1fcd <linkunlink+0x10d>
    x = x * 1103515245 + 12345;
    1f33:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f36:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1f3c:	05 39 30 00 00       	add    $0x3039,%eax
    1f41:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1f44:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1f47:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1f4c:	89 c8                	mov    %ecx,%eax
    1f4e:	f7 e2                	mul    %edx
    1f50:	89 d0                	mov    %edx,%eax
    1f52:	d1 e8                	shr    %eax
    1f54:	89 c2                	mov    %eax,%edx
    1f56:	01 d2                	add    %edx,%edx
    1f58:	01 c2                	add    %eax,%edx
    1f5a:	89 c8                	mov    %ecx,%eax
    1f5c:	29 d0                	sub    %edx,%eax
    1f5e:	85 c0                	test   %eax,%eax
    1f60:	75 23                	jne    1f85 <linkunlink+0xc5>
      close(open("x", O_RDWR | O_CREATE));
    1f62:	83 ec 08             	sub    $0x8,%esp
    1f65:	68 02 02 00 00       	push   $0x202
    1f6a:	68 0b 4d 00 00       	push   $0x4d0b
    1f6f:	e8 cf 23 00 00       	call   4343 <open>
    1f74:	83 c4 10             	add    $0x10,%esp
    1f77:	83 ec 0c             	sub    $0xc,%esp
    1f7a:	50                   	push   %eax
    1f7b:	e8 ab 23 00 00       	call   432b <close>
    1f80:	83 c4 10             	add    $0x10,%esp
    1f83:	eb 44                	jmp    1fc9 <linkunlink+0x109>
    } else if((x % 3) == 1){
    1f85:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1f88:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1f8d:	89 c8                	mov    %ecx,%eax
    1f8f:	f7 e2                	mul    %edx
    1f91:	d1 ea                	shr    %edx
    1f93:	89 d0                	mov    %edx,%eax
    1f95:	01 c0                	add    %eax,%eax
    1f97:	01 d0                	add    %edx,%eax
    1f99:	29 c1                	sub    %eax,%ecx
    1f9b:	89 ca                	mov    %ecx,%edx
    1f9d:	83 fa 01             	cmp    $0x1,%edx
    1fa0:	75 17                	jne    1fb9 <linkunlink+0xf9>
      link("cat", "x");
    1fa2:	83 ec 08             	sub    $0x8,%esp
    1fa5:	68 0b 4d 00 00       	push   $0x4d0b
    1faa:	68 a0 51 00 00       	push   $0x51a0
    1faf:	e8 af 23 00 00       	call   4363 <link>
    1fb4:	83 c4 10             	add    $0x10,%esp
    1fb7:	eb 10                	jmp    1fc9 <linkunlink+0x109>
    } else {
      unlink("x");
    1fb9:	83 ec 0c             	sub    $0xc,%esp
    1fbc:	68 0b 4d 00 00       	push   $0x4d0b
    1fc1:	e8 8d 23 00 00       	call   4353 <unlink>
    1fc6:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit(EXIT_STATUS_OK);
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1fc9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1fcd:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1fd1:	0f 8e 5c ff ff ff    	jle    1f33 <linkunlink+0x73>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1fd7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1fdb:	74 0f                	je     1fec <linkunlink+0x12c>
    wait(0);
    1fdd:	83 ec 0c             	sub    $0xc,%esp
    1fe0:	6a 00                	push   $0x0
    1fe2:	e8 24 23 00 00       	call   430b <wait>
    1fe7:	83 c4 10             	add    $0x10,%esp
    1fea:	eb 0a                	jmp    1ff6 <linkunlink+0x136>
  else 
    exit(EXIT_STATUS_OK);
    1fec:	83 ec 0c             	sub    $0xc,%esp
    1fef:	6a 01                	push   $0x1
    1ff1:	e8 0d 23 00 00       	call   4303 <exit>

  printf(1, "linkunlink ok\n");
    1ff6:	83 ec 08             	sub    $0x8,%esp
    1ff9:	68 a4 51 00 00       	push   $0x51a4
    1ffe:	6a 01                	push   $0x1
    2000:	e8 7b 24 00 00       	call   4480 <printf>
    2005:	83 c4 10             	add    $0x10,%esp
}
    2008:	c9                   	leave  
    2009:	c3                   	ret    

0000200a <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    200a:	55                   	push   %ebp
    200b:	89 e5                	mov    %esp,%ebp
    200d:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    2010:	83 ec 08             	sub    $0x8,%esp
    2013:	68 b3 51 00 00       	push   $0x51b3
    2018:	6a 01                	push   $0x1
    201a:	e8 61 24 00 00       	call   4480 <printf>
    201f:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    2022:	83 ec 0c             	sub    $0xc,%esp
    2025:	68 c0 51 00 00       	push   $0x51c0
    202a:	e8 24 23 00 00       	call   4353 <unlink>
    202f:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    2032:	83 ec 08             	sub    $0x8,%esp
    2035:	68 00 02 00 00       	push   $0x200
    203a:	68 c0 51 00 00       	push   $0x51c0
    203f:	e8 ff 22 00 00       	call   4343 <open>
    2044:	83 c4 10             	add    $0x10,%esp
    2047:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    204a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    204e:	79 1c                	jns    206c <bigdir+0x62>
    printf(1, "bigdir create failed\n");
    2050:	83 ec 08             	sub    $0x8,%esp
    2053:	68 c3 51 00 00       	push   $0x51c3
    2058:	6a 01                	push   $0x1
    205a:	e8 21 24 00 00       	call   4480 <printf>
    205f:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2062:	83 ec 0c             	sub    $0xc,%esp
    2065:	6a 01                	push   $0x1
    2067:	e8 97 22 00 00       	call   4303 <exit>
  }
  close(fd);
    206c:	83 ec 0c             	sub    $0xc,%esp
    206f:	ff 75 f0             	pushl  -0x10(%ebp)
    2072:	e8 b4 22 00 00       	call   432b <close>
    2077:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    207a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2081:	eb 68                	jmp    20eb <bigdir+0xe1>
    name[0] = 'x';
    2083:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    2087:	8b 45 f4             	mov    -0xc(%ebp),%eax
    208a:	8d 50 3f             	lea    0x3f(%eax),%edx
    208d:	85 c0                	test   %eax,%eax
    208f:	0f 48 c2             	cmovs  %edx,%eax
    2092:	c1 f8 06             	sar    $0x6,%eax
    2095:	83 c0 30             	add    $0x30,%eax
    2098:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    209b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    209e:	99                   	cltd   
    209f:	c1 ea 1a             	shr    $0x1a,%edx
    20a2:	01 d0                	add    %edx,%eax
    20a4:	83 e0 3f             	and    $0x3f,%eax
    20a7:	29 d0                	sub    %edx,%eax
    20a9:	83 c0 30             	add    $0x30,%eax
    20ac:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    20af:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    20b3:	83 ec 08             	sub    $0x8,%esp
    20b6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    20b9:	50                   	push   %eax
    20ba:	68 c0 51 00 00       	push   $0x51c0
    20bf:	e8 9f 22 00 00       	call   4363 <link>
    20c4:	83 c4 10             	add    $0x10,%esp
    20c7:	85 c0                	test   %eax,%eax
    20c9:	74 1c                	je     20e7 <bigdir+0xdd>
      printf(1, "bigdir link failed\n");
    20cb:	83 ec 08             	sub    $0x8,%esp
    20ce:	68 d9 51 00 00       	push   $0x51d9
    20d3:	6a 01                	push   $0x1
    20d5:	e8 a6 23 00 00       	call   4480 <printf>
    20da:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    20dd:	83 ec 0c             	sub    $0xc,%esp
    20e0:	6a 01                	push   $0x1
    20e2:	e8 1c 22 00 00       	call   4303 <exit>
    printf(1, "bigdir create failed\n");
    exit(EXIT_STATUS_OK);
  }
  close(fd);

  for(i = 0; i < 500; i++){
    20e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    20eb:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    20f2:	7e 8f                	jle    2083 <bigdir+0x79>
      printf(1, "bigdir link failed\n");
      exit(EXIT_STATUS_OK);
    }
  }

  unlink("bd");
    20f4:	83 ec 0c             	sub    $0xc,%esp
    20f7:	68 c0 51 00 00       	push   $0x51c0
    20fc:	e8 52 22 00 00       	call   4353 <unlink>
    2101:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    2104:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    210b:	eb 63                	jmp    2170 <bigdir+0x166>
    name[0] = 'x';
    210d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    2111:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2114:	8d 50 3f             	lea    0x3f(%eax),%edx
    2117:	85 c0                	test   %eax,%eax
    2119:	0f 48 c2             	cmovs  %edx,%eax
    211c:	c1 f8 06             	sar    $0x6,%eax
    211f:	83 c0 30             	add    $0x30,%eax
    2122:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    2125:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2128:	99                   	cltd   
    2129:	c1 ea 1a             	shr    $0x1a,%edx
    212c:	01 d0                	add    %edx,%eax
    212e:	83 e0 3f             	and    $0x3f,%eax
    2131:	29 d0                	sub    %edx,%eax
    2133:	83 c0 30             	add    $0x30,%eax
    2136:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    2139:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    213d:	83 ec 0c             	sub    $0xc,%esp
    2140:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    2143:	50                   	push   %eax
    2144:	e8 0a 22 00 00       	call   4353 <unlink>
    2149:	83 c4 10             	add    $0x10,%esp
    214c:	85 c0                	test   %eax,%eax
    214e:	74 1c                	je     216c <bigdir+0x162>
      printf(1, "bigdir unlink failed");
    2150:	83 ec 08             	sub    $0x8,%esp
    2153:	68 ed 51 00 00       	push   $0x51ed
    2158:	6a 01                	push   $0x1
    215a:	e8 21 23 00 00       	call   4480 <printf>
    215f:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    2162:	83 ec 0c             	sub    $0xc,%esp
    2165:	6a 01                	push   $0x1
    2167:	e8 97 21 00 00       	call   4303 <exit>
      exit(EXIT_STATUS_OK);
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    216c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2170:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    2177:	7e 94                	jle    210d <bigdir+0x103>
      printf(1, "bigdir unlink failed");
      exit(EXIT_STATUS_OK);
    }
  }

  printf(1, "bigdir ok\n");
    2179:	83 ec 08             	sub    $0x8,%esp
    217c:	68 02 52 00 00       	push   $0x5202
    2181:	6a 01                	push   $0x1
    2183:	e8 f8 22 00 00       	call   4480 <printf>
    2188:	83 c4 10             	add    $0x10,%esp
}
    218b:	c9                   	leave  
    218c:	c3                   	ret    

0000218d <subdir>:

void
subdir(void)
{
    218d:	55                   	push   %ebp
    218e:	89 e5                	mov    %esp,%ebp
    2190:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    2193:	83 ec 08             	sub    $0x8,%esp
    2196:	68 0d 52 00 00       	push   $0x520d
    219b:	6a 01                	push   $0x1
    219d:	e8 de 22 00 00       	call   4480 <printf>
    21a2:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    21a5:	83 ec 0c             	sub    $0xc,%esp
    21a8:	68 1a 52 00 00       	push   $0x521a
    21ad:	e8 a1 21 00 00       	call   4353 <unlink>
    21b2:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    21b5:	83 ec 0c             	sub    $0xc,%esp
    21b8:	68 1d 52 00 00       	push   $0x521d
    21bd:	e8 a9 21 00 00       	call   436b <mkdir>
    21c2:	83 c4 10             	add    $0x10,%esp
    21c5:	85 c0                	test   %eax,%eax
    21c7:	74 1c                	je     21e5 <subdir+0x58>
    printf(1, "subdir mkdir dd failed\n");
    21c9:	83 ec 08             	sub    $0x8,%esp
    21cc:	68 20 52 00 00       	push   $0x5220
    21d1:	6a 01                	push   $0x1
    21d3:	e8 a8 22 00 00       	call   4480 <printf>
    21d8:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    21db:	83 ec 0c             	sub    $0xc,%esp
    21de:	6a 01                	push   $0x1
    21e0:	e8 1e 21 00 00       	call   4303 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    21e5:	83 ec 08             	sub    $0x8,%esp
    21e8:	68 02 02 00 00       	push   $0x202
    21ed:	68 38 52 00 00       	push   $0x5238
    21f2:	e8 4c 21 00 00       	call   4343 <open>
    21f7:	83 c4 10             	add    $0x10,%esp
    21fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    21fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2201:	79 1c                	jns    221f <subdir+0x92>
    printf(1, "create dd/ff failed\n");
    2203:	83 ec 08             	sub    $0x8,%esp
    2206:	68 3e 52 00 00       	push   $0x523e
    220b:	6a 01                	push   $0x1
    220d:	e8 6e 22 00 00       	call   4480 <printf>
    2212:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2215:	83 ec 0c             	sub    $0xc,%esp
    2218:	6a 01                	push   $0x1
    221a:	e8 e4 20 00 00       	call   4303 <exit>
  }
  write(fd, "ff", 2);
    221f:	83 ec 04             	sub    $0x4,%esp
    2222:	6a 02                	push   $0x2
    2224:	68 1a 52 00 00       	push   $0x521a
    2229:	ff 75 f4             	pushl  -0xc(%ebp)
    222c:	e8 f2 20 00 00       	call   4323 <write>
    2231:	83 c4 10             	add    $0x10,%esp
  close(fd);
    2234:	83 ec 0c             	sub    $0xc,%esp
    2237:	ff 75 f4             	pushl  -0xc(%ebp)
    223a:	e8 ec 20 00 00       	call   432b <close>
    223f:	83 c4 10             	add    $0x10,%esp
  
  if(unlink("dd") >= 0){
    2242:	83 ec 0c             	sub    $0xc,%esp
    2245:	68 1d 52 00 00       	push   $0x521d
    224a:	e8 04 21 00 00       	call   4353 <unlink>
    224f:	83 c4 10             	add    $0x10,%esp
    2252:	85 c0                	test   %eax,%eax
    2254:	78 1c                	js     2272 <subdir+0xe5>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2256:	83 ec 08             	sub    $0x8,%esp
    2259:	68 54 52 00 00       	push   $0x5254
    225e:	6a 01                	push   $0x1
    2260:	e8 1b 22 00 00       	call   4480 <printf>
    2265:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2268:	83 ec 0c             	sub    $0xc,%esp
    226b:	6a 01                	push   $0x1
    226d:	e8 91 20 00 00       	call   4303 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    2272:	83 ec 0c             	sub    $0xc,%esp
    2275:	68 7a 52 00 00       	push   $0x527a
    227a:	e8 ec 20 00 00       	call   436b <mkdir>
    227f:	83 c4 10             	add    $0x10,%esp
    2282:	85 c0                	test   %eax,%eax
    2284:	74 1c                	je     22a2 <subdir+0x115>
    printf(1, "subdir mkdir dd/dd failed\n");
    2286:	83 ec 08             	sub    $0x8,%esp
    2289:	68 81 52 00 00       	push   $0x5281
    228e:	6a 01                	push   $0x1
    2290:	e8 eb 21 00 00       	call   4480 <printf>
    2295:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2298:	83 ec 0c             	sub    $0xc,%esp
    229b:	6a 01                	push   $0x1
    229d:	e8 61 20 00 00       	call   4303 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    22a2:	83 ec 08             	sub    $0x8,%esp
    22a5:	68 02 02 00 00       	push   $0x202
    22aa:	68 9c 52 00 00       	push   $0x529c
    22af:	e8 8f 20 00 00       	call   4343 <open>
    22b4:	83 c4 10             	add    $0x10,%esp
    22b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    22ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22be:	79 1c                	jns    22dc <subdir+0x14f>
    printf(1, "create dd/dd/ff failed\n");
    22c0:	83 ec 08             	sub    $0x8,%esp
    22c3:	68 a5 52 00 00       	push   $0x52a5
    22c8:	6a 01                	push   $0x1
    22ca:	e8 b1 21 00 00       	call   4480 <printf>
    22cf:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    22d2:	83 ec 0c             	sub    $0xc,%esp
    22d5:	6a 01                	push   $0x1
    22d7:	e8 27 20 00 00       	call   4303 <exit>
  }
  write(fd, "FF", 2);
    22dc:	83 ec 04             	sub    $0x4,%esp
    22df:	6a 02                	push   $0x2
    22e1:	68 bd 52 00 00       	push   $0x52bd
    22e6:	ff 75 f4             	pushl  -0xc(%ebp)
    22e9:	e8 35 20 00 00       	call   4323 <write>
    22ee:	83 c4 10             	add    $0x10,%esp
  close(fd);
    22f1:	83 ec 0c             	sub    $0xc,%esp
    22f4:	ff 75 f4             	pushl  -0xc(%ebp)
    22f7:	e8 2f 20 00 00       	call   432b <close>
    22fc:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    22ff:	83 ec 08             	sub    $0x8,%esp
    2302:	6a 00                	push   $0x0
    2304:	68 c0 52 00 00       	push   $0x52c0
    2309:	e8 35 20 00 00       	call   4343 <open>
    230e:	83 c4 10             	add    $0x10,%esp
    2311:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2314:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2318:	79 1c                	jns    2336 <subdir+0x1a9>
    printf(1, "open dd/dd/../ff failed\n");
    231a:	83 ec 08             	sub    $0x8,%esp
    231d:	68 cc 52 00 00       	push   $0x52cc
    2322:	6a 01                	push   $0x1
    2324:	e8 57 21 00 00       	call   4480 <printf>
    2329:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    232c:	83 ec 0c             	sub    $0xc,%esp
    232f:	6a 01                	push   $0x1
    2331:	e8 cd 1f 00 00       	call   4303 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    2336:	83 ec 04             	sub    $0x4,%esp
    2339:	68 00 20 00 00       	push   $0x2000
    233e:	68 40 8f 00 00       	push   $0x8f40
    2343:	ff 75 f4             	pushl  -0xc(%ebp)
    2346:	e8 d0 1f 00 00       	call   431b <read>
    234b:	83 c4 10             	add    $0x10,%esp
    234e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    2351:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    2355:	75 0b                	jne    2362 <subdir+0x1d5>
    2357:	0f b6 05 40 8f 00 00 	movzbl 0x8f40,%eax
    235e:	3c 66                	cmp    $0x66,%al
    2360:	74 1c                	je     237e <subdir+0x1f1>
    printf(1, "dd/dd/../ff wrong content\n");
    2362:	83 ec 08             	sub    $0x8,%esp
    2365:	68 e5 52 00 00       	push   $0x52e5
    236a:	6a 01                	push   $0x1
    236c:	e8 0f 21 00 00       	call   4480 <printf>
    2371:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2374:	83 ec 0c             	sub    $0xc,%esp
    2377:	6a 01                	push   $0x1
    2379:	e8 85 1f 00 00       	call   4303 <exit>
  }
  close(fd);
    237e:	83 ec 0c             	sub    $0xc,%esp
    2381:	ff 75 f4             	pushl  -0xc(%ebp)
    2384:	e8 a2 1f 00 00       	call   432b <close>
    2389:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    238c:	83 ec 08             	sub    $0x8,%esp
    238f:	68 00 53 00 00       	push   $0x5300
    2394:	68 9c 52 00 00       	push   $0x529c
    2399:	e8 c5 1f 00 00       	call   4363 <link>
    239e:	83 c4 10             	add    $0x10,%esp
    23a1:	85 c0                	test   %eax,%eax
    23a3:	74 1c                	je     23c1 <subdir+0x234>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    23a5:	83 ec 08             	sub    $0x8,%esp
    23a8:	68 0c 53 00 00       	push   $0x530c
    23ad:	6a 01                	push   $0x1
    23af:	e8 cc 20 00 00       	call   4480 <printf>
    23b4:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    23b7:	83 ec 0c             	sub    $0xc,%esp
    23ba:	6a 01                	push   $0x1
    23bc:	e8 42 1f 00 00       	call   4303 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    23c1:	83 ec 0c             	sub    $0xc,%esp
    23c4:	68 9c 52 00 00       	push   $0x529c
    23c9:	e8 85 1f 00 00       	call   4353 <unlink>
    23ce:	83 c4 10             	add    $0x10,%esp
    23d1:	85 c0                	test   %eax,%eax
    23d3:	74 1c                	je     23f1 <subdir+0x264>
    printf(1, "unlink dd/dd/ff failed\n");
    23d5:	83 ec 08             	sub    $0x8,%esp
    23d8:	68 2d 53 00 00       	push   $0x532d
    23dd:	6a 01                	push   $0x1
    23df:	e8 9c 20 00 00       	call   4480 <printf>
    23e4:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    23e7:	83 ec 0c             	sub    $0xc,%esp
    23ea:	6a 01                	push   $0x1
    23ec:	e8 12 1f 00 00       	call   4303 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    23f1:	83 ec 08             	sub    $0x8,%esp
    23f4:	6a 00                	push   $0x0
    23f6:	68 9c 52 00 00       	push   $0x529c
    23fb:	e8 43 1f 00 00       	call   4343 <open>
    2400:	83 c4 10             	add    $0x10,%esp
    2403:	85 c0                	test   %eax,%eax
    2405:	78 1c                	js     2423 <subdir+0x296>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2407:	83 ec 08             	sub    $0x8,%esp
    240a:	68 48 53 00 00       	push   $0x5348
    240f:	6a 01                	push   $0x1
    2411:	e8 6a 20 00 00       	call   4480 <printf>
    2416:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2419:	83 ec 0c             	sub    $0xc,%esp
    241c:	6a 01                	push   $0x1
    241e:	e8 e0 1e 00 00       	call   4303 <exit>
  }

  if(chdir("dd") != 0){
    2423:	83 ec 0c             	sub    $0xc,%esp
    2426:	68 1d 52 00 00       	push   $0x521d
    242b:	e8 43 1f 00 00       	call   4373 <chdir>
    2430:	83 c4 10             	add    $0x10,%esp
    2433:	85 c0                	test   %eax,%eax
    2435:	74 1c                	je     2453 <subdir+0x2c6>
    printf(1, "chdir dd failed\n");
    2437:	83 ec 08             	sub    $0x8,%esp
    243a:	68 6c 53 00 00       	push   $0x536c
    243f:	6a 01                	push   $0x1
    2441:	e8 3a 20 00 00       	call   4480 <printf>
    2446:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2449:	83 ec 0c             	sub    $0xc,%esp
    244c:	6a 01                	push   $0x1
    244e:	e8 b0 1e 00 00       	call   4303 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    2453:	83 ec 0c             	sub    $0xc,%esp
    2456:	68 7d 53 00 00       	push   $0x537d
    245b:	e8 13 1f 00 00       	call   4373 <chdir>
    2460:	83 c4 10             	add    $0x10,%esp
    2463:	85 c0                	test   %eax,%eax
    2465:	74 1c                	je     2483 <subdir+0x2f6>
    printf(1, "chdir dd/../../dd failed\n");
    2467:	83 ec 08             	sub    $0x8,%esp
    246a:	68 89 53 00 00       	push   $0x5389
    246f:	6a 01                	push   $0x1
    2471:	e8 0a 20 00 00       	call   4480 <printf>
    2476:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2479:	83 ec 0c             	sub    $0xc,%esp
    247c:	6a 01                	push   $0x1
    247e:	e8 80 1e 00 00       	call   4303 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    2483:	83 ec 0c             	sub    $0xc,%esp
    2486:	68 a3 53 00 00       	push   $0x53a3
    248b:	e8 e3 1e 00 00       	call   4373 <chdir>
    2490:	83 c4 10             	add    $0x10,%esp
    2493:	85 c0                	test   %eax,%eax
    2495:	74 1c                	je     24b3 <subdir+0x326>
    printf(1, "chdir dd/../../dd failed\n");
    2497:	83 ec 08             	sub    $0x8,%esp
    249a:	68 89 53 00 00       	push   $0x5389
    249f:	6a 01                	push   $0x1
    24a1:	e8 da 1f 00 00       	call   4480 <printf>
    24a6:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    24a9:	83 ec 0c             	sub    $0xc,%esp
    24ac:	6a 01                	push   $0x1
    24ae:	e8 50 1e 00 00       	call   4303 <exit>
  }
  if(chdir("./..") != 0){
    24b3:	83 ec 0c             	sub    $0xc,%esp
    24b6:	68 b2 53 00 00       	push   $0x53b2
    24bb:	e8 b3 1e 00 00       	call   4373 <chdir>
    24c0:	83 c4 10             	add    $0x10,%esp
    24c3:	85 c0                	test   %eax,%eax
    24c5:	74 1c                	je     24e3 <subdir+0x356>
    printf(1, "chdir ./.. failed\n");
    24c7:	83 ec 08             	sub    $0x8,%esp
    24ca:	68 b7 53 00 00       	push   $0x53b7
    24cf:	6a 01                	push   $0x1
    24d1:	e8 aa 1f 00 00       	call   4480 <printf>
    24d6:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    24d9:	83 ec 0c             	sub    $0xc,%esp
    24dc:	6a 01                	push   $0x1
    24de:	e8 20 1e 00 00       	call   4303 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    24e3:	83 ec 08             	sub    $0x8,%esp
    24e6:	6a 00                	push   $0x0
    24e8:	68 00 53 00 00       	push   $0x5300
    24ed:	e8 51 1e 00 00       	call   4343 <open>
    24f2:	83 c4 10             	add    $0x10,%esp
    24f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    24f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    24fc:	79 1c                	jns    251a <subdir+0x38d>
    printf(1, "open dd/dd/ffff failed\n");
    24fe:	83 ec 08             	sub    $0x8,%esp
    2501:	68 ca 53 00 00       	push   $0x53ca
    2506:	6a 01                	push   $0x1
    2508:	e8 73 1f 00 00       	call   4480 <printf>
    250d:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2510:	83 ec 0c             	sub    $0xc,%esp
    2513:	6a 01                	push   $0x1
    2515:	e8 e9 1d 00 00       	call   4303 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    251a:	83 ec 04             	sub    $0x4,%esp
    251d:	68 00 20 00 00       	push   $0x2000
    2522:	68 40 8f 00 00       	push   $0x8f40
    2527:	ff 75 f4             	pushl  -0xc(%ebp)
    252a:	e8 ec 1d 00 00       	call   431b <read>
    252f:	83 c4 10             	add    $0x10,%esp
    2532:	83 f8 02             	cmp    $0x2,%eax
    2535:	74 1c                	je     2553 <subdir+0x3c6>
    printf(1, "read dd/dd/ffff wrong len\n");
    2537:	83 ec 08             	sub    $0x8,%esp
    253a:	68 e2 53 00 00       	push   $0x53e2
    253f:	6a 01                	push   $0x1
    2541:	e8 3a 1f 00 00       	call   4480 <printf>
    2546:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2549:	83 ec 0c             	sub    $0xc,%esp
    254c:	6a 01                	push   $0x1
    254e:	e8 b0 1d 00 00       	call   4303 <exit>
  }
  close(fd);
    2553:	83 ec 0c             	sub    $0xc,%esp
    2556:	ff 75 f4             	pushl  -0xc(%ebp)
    2559:	e8 cd 1d 00 00       	call   432b <close>
    255e:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2561:	83 ec 08             	sub    $0x8,%esp
    2564:	6a 00                	push   $0x0
    2566:	68 9c 52 00 00       	push   $0x529c
    256b:	e8 d3 1d 00 00       	call   4343 <open>
    2570:	83 c4 10             	add    $0x10,%esp
    2573:	85 c0                	test   %eax,%eax
    2575:	78 1c                	js     2593 <subdir+0x406>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2577:	83 ec 08             	sub    $0x8,%esp
    257a:	68 00 54 00 00       	push   $0x5400
    257f:	6a 01                	push   $0x1
    2581:	e8 fa 1e 00 00       	call   4480 <printf>
    2586:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2589:	83 ec 0c             	sub    $0xc,%esp
    258c:	6a 01                	push   $0x1
    258e:	e8 70 1d 00 00       	call   4303 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2593:	83 ec 08             	sub    $0x8,%esp
    2596:	68 02 02 00 00       	push   $0x202
    259b:	68 25 54 00 00       	push   $0x5425
    25a0:	e8 9e 1d 00 00       	call   4343 <open>
    25a5:	83 c4 10             	add    $0x10,%esp
    25a8:	85 c0                	test   %eax,%eax
    25aa:	78 1c                	js     25c8 <subdir+0x43b>
    printf(1, "create dd/ff/ff succeeded!\n");
    25ac:	83 ec 08             	sub    $0x8,%esp
    25af:	68 2e 54 00 00       	push   $0x542e
    25b4:	6a 01                	push   $0x1
    25b6:	e8 c5 1e 00 00       	call   4480 <printf>
    25bb:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    25be:	83 ec 0c             	sub    $0xc,%esp
    25c1:	6a 01                	push   $0x1
    25c3:	e8 3b 1d 00 00       	call   4303 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    25c8:	83 ec 08             	sub    $0x8,%esp
    25cb:	68 02 02 00 00       	push   $0x202
    25d0:	68 4a 54 00 00       	push   $0x544a
    25d5:	e8 69 1d 00 00       	call   4343 <open>
    25da:	83 c4 10             	add    $0x10,%esp
    25dd:	85 c0                	test   %eax,%eax
    25df:	78 1c                	js     25fd <subdir+0x470>
    printf(1, "create dd/xx/ff succeeded!\n");
    25e1:	83 ec 08             	sub    $0x8,%esp
    25e4:	68 53 54 00 00       	push   $0x5453
    25e9:	6a 01                	push   $0x1
    25eb:	e8 90 1e 00 00       	call   4480 <printf>
    25f0:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    25f3:	83 ec 0c             	sub    $0xc,%esp
    25f6:	6a 01                	push   $0x1
    25f8:	e8 06 1d 00 00       	call   4303 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    25fd:	83 ec 08             	sub    $0x8,%esp
    2600:	68 00 02 00 00       	push   $0x200
    2605:	68 1d 52 00 00       	push   $0x521d
    260a:	e8 34 1d 00 00       	call   4343 <open>
    260f:	83 c4 10             	add    $0x10,%esp
    2612:	85 c0                	test   %eax,%eax
    2614:	78 1c                	js     2632 <subdir+0x4a5>
    printf(1, "create dd succeeded!\n");
    2616:	83 ec 08             	sub    $0x8,%esp
    2619:	68 6f 54 00 00       	push   $0x546f
    261e:	6a 01                	push   $0x1
    2620:	e8 5b 1e 00 00       	call   4480 <printf>
    2625:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2628:	83 ec 0c             	sub    $0xc,%esp
    262b:	6a 01                	push   $0x1
    262d:	e8 d1 1c 00 00       	call   4303 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    2632:	83 ec 08             	sub    $0x8,%esp
    2635:	6a 02                	push   $0x2
    2637:	68 1d 52 00 00       	push   $0x521d
    263c:	e8 02 1d 00 00       	call   4343 <open>
    2641:	83 c4 10             	add    $0x10,%esp
    2644:	85 c0                	test   %eax,%eax
    2646:	78 1c                	js     2664 <subdir+0x4d7>
    printf(1, "open dd rdwr succeeded!\n");
    2648:	83 ec 08             	sub    $0x8,%esp
    264b:	68 85 54 00 00       	push   $0x5485
    2650:	6a 01                	push   $0x1
    2652:	e8 29 1e 00 00       	call   4480 <printf>
    2657:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    265a:	83 ec 0c             	sub    $0xc,%esp
    265d:	6a 01                	push   $0x1
    265f:	e8 9f 1c 00 00       	call   4303 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    2664:	83 ec 08             	sub    $0x8,%esp
    2667:	6a 01                	push   $0x1
    2669:	68 1d 52 00 00       	push   $0x521d
    266e:	e8 d0 1c 00 00       	call   4343 <open>
    2673:	83 c4 10             	add    $0x10,%esp
    2676:	85 c0                	test   %eax,%eax
    2678:	78 1c                	js     2696 <subdir+0x509>
    printf(1, "open dd wronly succeeded!\n");
    267a:	83 ec 08             	sub    $0x8,%esp
    267d:	68 9e 54 00 00       	push   $0x549e
    2682:	6a 01                	push   $0x1
    2684:	e8 f7 1d 00 00       	call   4480 <printf>
    2689:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    268c:	83 ec 0c             	sub    $0xc,%esp
    268f:	6a 01                	push   $0x1
    2691:	e8 6d 1c 00 00       	call   4303 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2696:	83 ec 08             	sub    $0x8,%esp
    2699:	68 b9 54 00 00       	push   $0x54b9
    269e:	68 25 54 00 00       	push   $0x5425
    26a3:	e8 bb 1c 00 00       	call   4363 <link>
    26a8:	83 c4 10             	add    $0x10,%esp
    26ab:	85 c0                	test   %eax,%eax
    26ad:	75 1c                	jne    26cb <subdir+0x53e>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    26af:	83 ec 08             	sub    $0x8,%esp
    26b2:	68 c4 54 00 00       	push   $0x54c4
    26b7:	6a 01                	push   $0x1
    26b9:	e8 c2 1d 00 00       	call   4480 <printf>
    26be:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    26c1:	83 ec 0c             	sub    $0xc,%esp
    26c4:	6a 01                	push   $0x1
    26c6:	e8 38 1c 00 00       	call   4303 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    26cb:	83 ec 08             	sub    $0x8,%esp
    26ce:	68 b9 54 00 00       	push   $0x54b9
    26d3:	68 4a 54 00 00       	push   $0x544a
    26d8:	e8 86 1c 00 00       	call   4363 <link>
    26dd:	83 c4 10             	add    $0x10,%esp
    26e0:	85 c0                	test   %eax,%eax
    26e2:	75 1c                	jne    2700 <subdir+0x573>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    26e4:	83 ec 08             	sub    $0x8,%esp
    26e7:	68 e8 54 00 00       	push   $0x54e8
    26ec:	6a 01                	push   $0x1
    26ee:	e8 8d 1d 00 00       	call   4480 <printf>
    26f3:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    26f6:	83 ec 0c             	sub    $0xc,%esp
    26f9:	6a 01                	push   $0x1
    26fb:	e8 03 1c 00 00       	call   4303 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2700:	83 ec 08             	sub    $0x8,%esp
    2703:	68 00 53 00 00       	push   $0x5300
    2708:	68 38 52 00 00       	push   $0x5238
    270d:	e8 51 1c 00 00       	call   4363 <link>
    2712:	83 c4 10             	add    $0x10,%esp
    2715:	85 c0                	test   %eax,%eax
    2717:	75 1c                	jne    2735 <subdir+0x5a8>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2719:	83 ec 08             	sub    $0x8,%esp
    271c:	68 0c 55 00 00       	push   $0x550c
    2721:	6a 01                	push   $0x1
    2723:	e8 58 1d 00 00       	call   4480 <printf>
    2728:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    272b:	83 ec 0c             	sub    $0xc,%esp
    272e:	6a 01                	push   $0x1
    2730:	e8 ce 1b 00 00       	call   4303 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    2735:	83 ec 0c             	sub    $0xc,%esp
    2738:	68 25 54 00 00       	push   $0x5425
    273d:	e8 29 1c 00 00       	call   436b <mkdir>
    2742:	83 c4 10             	add    $0x10,%esp
    2745:	85 c0                	test   %eax,%eax
    2747:	75 1c                	jne    2765 <subdir+0x5d8>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2749:	83 ec 08             	sub    $0x8,%esp
    274c:	68 2e 55 00 00       	push   $0x552e
    2751:	6a 01                	push   $0x1
    2753:	e8 28 1d 00 00       	call   4480 <printf>
    2758:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    275b:	83 ec 0c             	sub    $0xc,%esp
    275e:	6a 01                	push   $0x1
    2760:	e8 9e 1b 00 00       	call   4303 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2765:	83 ec 0c             	sub    $0xc,%esp
    2768:	68 4a 54 00 00       	push   $0x544a
    276d:	e8 f9 1b 00 00       	call   436b <mkdir>
    2772:	83 c4 10             	add    $0x10,%esp
    2775:	85 c0                	test   %eax,%eax
    2777:	75 1c                	jne    2795 <subdir+0x608>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2779:	83 ec 08             	sub    $0x8,%esp
    277c:	68 49 55 00 00       	push   $0x5549
    2781:	6a 01                	push   $0x1
    2783:	e8 f8 1c 00 00       	call   4480 <printf>
    2788:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    278b:	83 ec 0c             	sub    $0xc,%esp
    278e:	6a 01                	push   $0x1
    2790:	e8 6e 1b 00 00       	call   4303 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    2795:	83 ec 0c             	sub    $0xc,%esp
    2798:	68 00 53 00 00       	push   $0x5300
    279d:	e8 c9 1b 00 00       	call   436b <mkdir>
    27a2:	83 c4 10             	add    $0x10,%esp
    27a5:	85 c0                	test   %eax,%eax
    27a7:	75 1c                	jne    27c5 <subdir+0x638>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    27a9:	83 ec 08             	sub    $0x8,%esp
    27ac:	68 64 55 00 00       	push   $0x5564
    27b1:	6a 01                	push   $0x1
    27b3:	e8 c8 1c 00 00       	call   4480 <printf>
    27b8:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    27bb:	83 ec 0c             	sub    $0xc,%esp
    27be:	6a 01                	push   $0x1
    27c0:	e8 3e 1b 00 00       	call   4303 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    27c5:	83 ec 0c             	sub    $0xc,%esp
    27c8:	68 4a 54 00 00       	push   $0x544a
    27cd:	e8 81 1b 00 00       	call   4353 <unlink>
    27d2:	83 c4 10             	add    $0x10,%esp
    27d5:	85 c0                	test   %eax,%eax
    27d7:	75 1c                	jne    27f5 <subdir+0x668>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    27d9:	83 ec 08             	sub    $0x8,%esp
    27dc:	68 81 55 00 00       	push   $0x5581
    27e1:	6a 01                	push   $0x1
    27e3:	e8 98 1c 00 00       	call   4480 <printf>
    27e8:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    27eb:	83 ec 0c             	sub    $0xc,%esp
    27ee:	6a 01                	push   $0x1
    27f0:	e8 0e 1b 00 00       	call   4303 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    27f5:	83 ec 0c             	sub    $0xc,%esp
    27f8:	68 25 54 00 00       	push   $0x5425
    27fd:	e8 51 1b 00 00       	call   4353 <unlink>
    2802:	83 c4 10             	add    $0x10,%esp
    2805:	85 c0                	test   %eax,%eax
    2807:	75 1c                	jne    2825 <subdir+0x698>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2809:	83 ec 08             	sub    $0x8,%esp
    280c:	68 9d 55 00 00       	push   $0x559d
    2811:	6a 01                	push   $0x1
    2813:	e8 68 1c 00 00       	call   4480 <printf>
    2818:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    281b:	83 ec 0c             	sub    $0xc,%esp
    281e:	6a 01                	push   $0x1
    2820:	e8 de 1a 00 00       	call   4303 <exit>
  }
  if(chdir("dd/ff") == 0){
    2825:	83 ec 0c             	sub    $0xc,%esp
    2828:	68 38 52 00 00       	push   $0x5238
    282d:	e8 41 1b 00 00       	call   4373 <chdir>
    2832:	83 c4 10             	add    $0x10,%esp
    2835:	85 c0                	test   %eax,%eax
    2837:	75 1c                	jne    2855 <subdir+0x6c8>
    printf(1, "chdir dd/ff succeeded!\n");
    2839:	83 ec 08             	sub    $0x8,%esp
    283c:	68 b9 55 00 00       	push   $0x55b9
    2841:	6a 01                	push   $0x1
    2843:	e8 38 1c 00 00       	call   4480 <printf>
    2848:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    284b:	83 ec 0c             	sub    $0xc,%esp
    284e:	6a 01                	push   $0x1
    2850:	e8 ae 1a 00 00       	call   4303 <exit>
  }
  if(chdir("dd/xx") == 0){
    2855:	83 ec 0c             	sub    $0xc,%esp
    2858:	68 d1 55 00 00       	push   $0x55d1
    285d:	e8 11 1b 00 00       	call   4373 <chdir>
    2862:	83 c4 10             	add    $0x10,%esp
    2865:	85 c0                	test   %eax,%eax
    2867:	75 1c                	jne    2885 <subdir+0x6f8>
    printf(1, "chdir dd/xx succeeded!\n");
    2869:	83 ec 08             	sub    $0x8,%esp
    286c:	68 d7 55 00 00       	push   $0x55d7
    2871:	6a 01                	push   $0x1
    2873:	e8 08 1c 00 00       	call   4480 <printf>
    2878:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    287b:	83 ec 0c             	sub    $0xc,%esp
    287e:	6a 01                	push   $0x1
    2880:	e8 7e 1a 00 00       	call   4303 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2885:	83 ec 0c             	sub    $0xc,%esp
    2888:	68 00 53 00 00       	push   $0x5300
    288d:	e8 c1 1a 00 00       	call   4353 <unlink>
    2892:	83 c4 10             	add    $0x10,%esp
    2895:	85 c0                	test   %eax,%eax
    2897:	74 1c                	je     28b5 <subdir+0x728>
    printf(1, "unlink dd/dd/ff failed\n");
    2899:	83 ec 08             	sub    $0x8,%esp
    289c:	68 2d 53 00 00       	push   $0x532d
    28a1:	6a 01                	push   $0x1
    28a3:	e8 d8 1b 00 00       	call   4480 <printf>
    28a8:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    28ab:	83 ec 0c             	sub    $0xc,%esp
    28ae:	6a 01                	push   $0x1
    28b0:	e8 4e 1a 00 00       	call   4303 <exit>
  }
  if(unlink("dd/ff") != 0){
    28b5:	83 ec 0c             	sub    $0xc,%esp
    28b8:	68 38 52 00 00       	push   $0x5238
    28bd:	e8 91 1a 00 00       	call   4353 <unlink>
    28c2:	83 c4 10             	add    $0x10,%esp
    28c5:	85 c0                	test   %eax,%eax
    28c7:	74 1c                	je     28e5 <subdir+0x758>
    printf(1, "unlink dd/ff failed\n");
    28c9:	83 ec 08             	sub    $0x8,%esp
    28cc:	68 ef 55 00 00       	push   $0x55ef
    28d1:	6a 01                	push   $0x1
    28d3:	e8 a8 1b 00 00       	call   4480 <printf>
    28d8:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    28db:	83 ec 0c             	sub    $0xc,%esp
    28de:	6a 01                	push   $0x1
    28e0:	e8 1e 1a 00 00       	call   4303 <exit>
  }
  if(unlink("dd") == 0){
    28e5:	83 ec 0c             	sub    $0xc,%esp
    28e8:	68 1d 52 00 00       	push   $0x521d
    28ed:	e8 61 1a 00 00       	call   4353 <unlink>
    28f2:	83 c4 10             	add    $0x10,%esp
    28f5:	85 c0                	test   %eax,%eax
    28f7:	75 1c                	jne    2915 <subdir+0x788>
    printf(1, "unlink non-empty dd succeeded!\n");
    28f9:	83 ec 08             	sub    $0x8,%esp
    28fc:	68 04 56 00 00       	push   $0x5604
    2901:	6a 01                	push   $0x1
    2903:	e8 78 1b 00 00       	call   4480 <printf>
    2908:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    290b:	83 ec 0c             	sub    $0xc,%esp
    290e:	6a 01                	push   $0x1
    2910:	e8 ee 19 00 00       	call   4303 <exit>
  }
  if(unlink("dd/dd") < 0){
    2915:	83 ec 0c             	sub    $0xc,%esp
    2918:	68 24 56 00 00       	push   $0x5624
    291d:	e8 31 1a 00 00       	call   4353 <unlink>
    2922:	83 c4 10             	add    $0x10,%esp
    2925:	85 c0                	test   %eax,%eax
    2927:	79 1c                	jns    2945 <subdir+0x7b8>
    printf(1, "unlink dd/dd failed\n");
    2929:	83 ec 08             	sub    $0x8,%esp
    292c:	68 2a 56 00 00       	push   $0x562a
    2931:	6a 01                	push   $0x1
    2933:	e8 48 1b 00 00       	call   4480 <printf>
    2938:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    293b:	83 ec 0c             	sub    $0xc,%esp
    293e:	6a 01                	push   $0x1
    2940:	e8 be 19 00 00       	call   4303 <exit>
  }
  if(unlink("dd") < 0){
    2945:	83 ec 0c             	sub    $0xc,%esp
    2948:	68 1d 52 00 00       	push   $0x521d
    294d:	e8 01 1a 00 00       	call   4353 <unlink>
    2952:	83 c4 10             	add    $0x10,%esp
    2955:	85 c0                	test   %eax,%eax
    2957:	79 1c                	jns    2975 <subdir+0x7e8>
    printf(1, "unlink dd failed\n");
    2959:	83 ec 08             	sub    $0x8,%esp
    295c:	68 3f 56 00 00       	push   $0x563f
    2961:	6a 01                	push   $0x1
    2963:	e8 18 1b 00 00       	call   4480 <printf>
    2968:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    296b:	83 ec 0c             	sub    $0xc,%esp
    296e:	6a 01                	push   $0x1
    2970:	e8 8e 19 00 00       	call   4303 <exit>
  }

  printf(1, "subdir ok\n");
    2975:	83 ec 08             	sub    $0x8,%esp
    2978:	68 51 56 00 00       	push   $0x5651
    297d:	6a 01                	push   $0x1
    297f:	e8 fc 1a 00 00       	call   4480 <printf>
    2984:	83 c4 10             	add    $0x10,%esp
}
    2987:	c9                   	leave  
    2988:	c3                   	ret    

00002989 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2989:	55                   	push   %ebp
    298a:	89 e5                	mov    %esp,%ebp
    298c:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    298f:	83 ec 08             	sub    $0x8,%esp
    2992:	68 5c 56 00 00       	push   $0x565c
    2997:	6a 01                	push   $0x1
    2999:	e8 e2 1a 00 00       	call   4480 <printf>
    299e:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    29a1:	83 ec 0c             	sub    $0xc,%esp
    29a4:	68 6b 56 00 00       	push   $0x566b
    29a9:	e8 a5 19 00 00       	call   4353 <unlink>
    29ae:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    29b1:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    29b8:	e9 b2 00 00 00       	jmp    2a6f <bigwrite+0xe6>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    29bd:	83 ec 08             	sub    $0x8,%esp
    29c0:	68 02 02 00 00       	push   $0x202
    29c5:	68 6b 56 00 00       	push   $0x566b
    29ca:	e8 74 19 00 00       	call   4343 <open>
    29cf:	83 c4 10             	add    $0x10,%esp
    29d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    29d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    29d9:	79 1c                	jns    29f7 <bigwrite+0x6e>
      printf(1, "cannot create bigwrite\n");
    29db:	83 ec 08             	sub    $0x8,%esp
    29de:	68 74 56 00 00       	push   $0x5674
    29e3:	6a 01                	push   $0x1
    29e5:	e8 96 1a 00 00       	call   4480 <printf>
    29ea:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    29ed:	83 ec 0c             	sub    $0xc,%esp
    29f0:	6a 01                	push   $0x1
    29f2:	e8 0c 19 00 00       	call   4303 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    29f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    29fe:	eb 44                	jmp    2a44 <bigwrite+0xbb>
      int cc = write(fd, buf, sz);
    2a00:	83 ec 04             	sub    $0x4,%esp
    2a03:	ff 75 f4             	pushl  -0xc(%ebp)
    2a06:	68 40 8f 00 00       	push   $0x8f40
    2a0b:	ff 75 ec             	pushl  -0x14(%ebp)
    2a0e:	e8 10 19 00 00       	call   4323 <write>
    2a13:	83 c4 10             	add    $0x10,%esp
    2a16:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    2a19:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2a1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2a1f:	74 1f                	je     2a40 <bigwrite+0xb7>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2a21:	ff 75 e8             	pushl  -0x18(%ebp)
    2a24:	ff 75 f4             	pushl  -0xc(%ebp)
    2a27:	68 8c 56 00 00       	push   $0x568c
    2a2c:	6a 01                	push   $0x1
    2a2e:	e8 4d 1a 00 00       	call   4480 <printf>
    2a33:	83 c4 10             	add    $0x10,%esp
        exit(EXIT_STATUS_OK);
    2a36:	83 ec 0c             	sub    $0xc,%esp
    2a39:	6a 01                	push   $0x1
    2a3b:	e8 c3 18 00 00       	call   4303 <exit>
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
      exit(EXIT_STATUS_OK);
    }
    int i;
    for(i = 0; i < 2; i++){
    2a40:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2a44:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    2a48:	7e b6                	jle    2a00 <bigwrite+0x77>
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit(EXIT_STATUS_OK);
      }
    }
    close(fd);
    2a4a:	83 ec 0c             	sub    $0xc,%esp
    2a4d:	ff 75 ec             	pushl  -0x14(%ebp)
    2a50:	e8 d6 18 00 00       	call   432b <close>
    2a55:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    2a58:	83 ec 0c             	sub    $0xc,%esp
    2a5b:	68 6b 56 00 00       	push   $0x566b
    2a60:	e8 ee 18 00 00       	call   4353 <unlink>
    2a65:	83 c4 10             	add    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2a68:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    2a6f:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    2a76:	0f 8e 41 ff ff ff    	jle    29bd <bigwrite+0x34>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    2a7c:	83 ec 08             	sub    $0x8,%esp
    2a7f:	68 9e 56 00 00       	push   $0x569e
    2a84:	6a 01                	push   $0x1
    2a86:	e8 f5 19 00 00       	call   4480 <printf>
    2a8b:	83 c4 10             	add    $0x10,%esp
}
    2a8e:	c9                   	leave  
    2a8f:	c3                   	ret    

00002a90 <bigfile>:

void
bigfile(void)
{
    2a90:	55                   	push   %ebp
    2a91:	89 e5                	mov    %esp,%ebp
    2a93:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2a96:	83 ec 08             	sub    $0x8,%esp
    2a99:	68 ab 56 00 00       	push   $0x56ab
    2a9e:	6a 01                	push   $0x1
    2aa0:	e8 db 19 00 00       	call   4480 <printf>
    2aa5:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    2aa8:	83 ec 0c             	sub    $0xc,%esp
    2aab:	68 b9 56 00 00       	push   $0x56b9
    2ab0:	e8 9e 18 00 00       	call   4353 <unlink>
    2ab5:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    2ab8:	83 ec 08             	sub    $0x8,%esp
    2abb:	68 02 02 00 00       	push   $0x202
    2ac0:	68 b9 56 00 00       	push   $0x56b9
    2ac5:	e8 79 18 00 00       	call   4343 <open>
    2aca:	83 c4 10             	add    $0x10,%esp
    2acd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2ad0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2ad4:	79 1c                	jns    2af2 <bigfile+0x62>
    printf(1, "cannot create bigfile");
    2ad6:	83 ec 08             	sub    $0x8,%esp
    2ad9:	68 c1 56 00 00       	push   $0x56c1
    2ade:	6a 01                	push   $0x1
    2ae0:	e8 9b 19 00 00       	call   4480 <printf>
    2ae5:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2ae8:	83 ec 0c             	sub    $0xc,%esp
    2aeb:	6a 01                	push   $0x1
    2aed:	e8 11 18 00 00       	call   4303 <exit>
  }
  for(i = 0; i < 20; i++){
    2af2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2af9:	eb 57                	jmp    2b52 <bigfile+0xc2>
    memset(buf, i, 600);
    2afb:	83 ec 04             	sub    $0x4,%esp
    2afe:	68 58 02 00 00       	push   $0x258
    2b03:	ff 75 f4             	pushl  -0xc(%ebp)
    2b06:	68 40 8f 00 00       	push   $0x8f40
    2b0b:	e8 59 16 00 00       	call   4169 <memset>
    2b10:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    2b13:	83 ec 04             	sub    $0x4,%esp
    2b16:	68 58 02 00 00       	push   $0x258
    2b1b:	68 40 8f 00 00       	push   $0x8f40
    2b20:	ff 75 ec             	pushl  -0x14(%ebp)
    2b23:	e8 fb 17 00 00       	call   4323 <write>
    2b28:	83 c4 10             	add    $0x10,%esp
    2b2b:	3d 58 02 00 00       	cmp    $0x258,%eax
    2b30:	74 1c                	je     2b4e <bigfile+0xbe>
      printf(1, "write bigfile failed\n");
    2b32:	83 ec 08             	sub    $0x8,%esp
    2b35:	68 d7 56 00 00       	push   $0x56d7
    2b3a:	6a 01                	push   $0x1
    2b3c:	e8 3f 19 00 00       	call   4480 <printf>
    2b41:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    2b44:	83 ec 0c             	sub    $0xc,%esp
    2b47:	6a 01                	push   $0x1
    2b49:	e8 b5 17 00 00       	call   4303 <exit>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit(EXIT_STATUS_OK);
  }
  for(i = 0; i < 20; i++){
    2b4e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2b52:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    2b56:	7e a3                	jle    2afb <bigfile+0x6b>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit(EXIT_STATUS_OK);
    }
  }
  close(fd);
    2b58:	83 ec 0c             	sub    $0xc,%esp
    2b5b:	ff 75 ec             	pushl  -0x14(%ebp)
    2b5e:	e8 c8 17 00 00       	call   432b <close>
    2b63:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    2b66:	83 ec 08             	sub    $0x8,%esp
    2b69:	6a 00                	push   $0x0
    2b6b:	68 b9 56 00 00       	push   $0x56b9
    2b70:	e8 ce 17 00 00       	call   4343 <open>
    2b75:	83 c4 10             	add    $0x10,%esp
    2b78:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2b7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2b7f:	79 1c                	jns    2b9d <bigfile+0x10d>
    printf(1, "cannot open bigfile\n");
    2b81:	83 ec 08             	sub    $0x8,%esp
    2b84:	68 ed 56 00 00       	push   $0x56ed
    2b89:	6a 01                	push   $0x1
    2b8b:	e8 f0 18 00 00       	call   4480 <printf>
    2b90:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2b93:	83 ec 0c             	sub    $0xc,%esp
    2b96:	6a 01                	push   $0x1
    2b98:	e8 66 17 00 00       	call   4303 <exit>
  }
  total = 0;
    2b9d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    2ba4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    2bab:	83 ec 04             	sub    $0x4,%esp
    2bae:	68 2c 01 00 00       	push   $0x12c
    2bb3:	68 40 8f 00 00       	push   $0x8f40
    2bb8:	ff 75 ec             	pushl  -0x14(%ebp)
    2bbb:	e8 5b 17 00 00       	call   431b <read>
    2bc0:	83 c4 10             	add    $0x10,%esp
    2bc3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    2bc6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2bca:	79 1c                	jns    2be8 <bigfile+0x158>
      printf(1, "read bigfile failed\n");
    2bcc:	83 ec 08             	sub    $0x8,%esp
    2bcf:	68 02 57 00 00       	push   $0x5702
    2bd4:	6a 01                	push   $0x1
    2bd6:	e8 a5 18 00 00       	call   4480 <printf>
    2bdb:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    2bde:	83 ec 0c             	sub    $0xc,%esp
    2be1:	6a 01                	push   $0x1
    2be3:	e8 1b 17 00 00       	call   4303 <exit>
    }
    if(cc == 0)
    2be8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2bec:	75 21                	jne    2c0f <bigfile+0x17f>
      break;
    2bee:	90                   	nop
      printf(1, "read bigfile wrong data\n");
      exit(EXIT_STATUS_OK);
    }
    total += cc;
  }
  close(fd);
    2bef:	83 ec 0c             	sub    $0xc,%esp
    2bf2:	ff 75 ec             	pushl  -0x14(%ebp)
    2bf5:	e8 31 17 00 00       	call   432b <close>
    2bfa:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    2bfd:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    2c04:	0f 84 a5 00 00 00    	je     2caf <bigfile+0x21f>
    2c0a:	e9 84 00 00 00       	jmp    2c93 <bigfile+0x203>
      printf(1, "read bigfile failed\n");
      exit(EXIT_STATUS_OK);
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2c0f:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2c16:	74 1c                	je     2c34 <bigfile+0x1a4>
      printf(1, "short read bigfile\n");
    2c18:	83 ec 08             	sub    $0x8,%esp
    2c1b:	68 17 57 00 00       	push   $0x5717
    2c20:	6a 01                	push   $0x1
    2c22:	e8 59 18 00 00       	call   4480 <printf>
    2c27:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    2c2a:	83 ec 0c             	sub    $0xc,%esp
    2c2d:	6a 01                	push   $0x1
    2c2f:	e8 cf 16 00 00       	call   4303 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    2c34:	0f b6 05 40 8f 00 00 	movzbl 0x8f40,%eax
    2c3b:	0f be d0             	movsbl %al,%edx
    2c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2c41:	89 c1                	mov    %eax,%ecx
    2c43:	c1 e9 1f             	shr    $0x1f,%ecx
    2c46:	01 c8                	add    %ecx,%eax
    2c48:	d1 f8                	sar    %eax
    2c4a:	39 c2                	cmp    %eax,%edx
    2c4c:	75 1a                	jne    2c68 <bigfile+0x1d8>
    2c4e:	0f b6 05 6b 90 00 00 	movzbl 0x906b,%eax
    2c55:	0f be d0             	movsbl %al,%edx
    2c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2c5b:	89 c1                	mov    %eax,%ecx
    2c5d:	c1 e9 1f             	shr    $0x1f,%ecx
    2c60:	01 c8                	add    %ecx,%eax
    2c62:	d1 f8                	sar    %eax
    2c64:	39 c2                	cmp    %eax,%edx
    2c66:	74 1c                	je     2c84 <bigfile+0x1f4>
      printf(1, "read bigfile wrong data\n");
    2c68:	83 ec 08             	sub    $0x8,%esp
    2c6b:	68 2b 57 00 00       	push   $0x572b
    2c70:	6a 01                	push   $0x1
    2c72:	e8 09 18 00 00       	call   4480 <printf>
    2c77:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    2c7a:	83 ec 0c             	sub    $0xc,%esp
    2c7d:	6a 01                	push   $0x1
    2c7f:	e8 7f 16 00 00       	call   4303 <exit>
    }
    total += cc;
    2c84:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2c87:	01 45 f0             	add    %eax,-0x10(%ebp)
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit(EXIT_STATUS_OK);
  }
  total = 0;
  for(i = 0; ; i++){
    2c8a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
      exit(EXIT_STATUS_OK);
    }
    total += cc;
  }
    2c8e:	e9 18 ff ff ff       	jmp    2bab <bigfile+0x11b>
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    2c93:	83 ec 08             	sub    $0x8,%esp
    2c96:	68 44 57 00 00       	push   $0x5744
    2c9b:	6a 01                	push   $0x1
    2c9d:	e8 de 17 00 00       	call   4480 <printf>
    2ca2:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2ca5:	83 ec 0c             	sub    $0xc,%esp
    2ca8:	6a 01                	push   $0x1
    2caa:	e8 54 16 00 00       	call   4303 <exit>
  }
  unlink("bigfile");
    2caf:	83 ec 0c             	sub    $0xc,%esp
    2cb2:	68 b9 56 00 00       	push   $0x56b9
    2cb7:	e8 97 16 00 00       	call   4353 <unlink>
    2cbc:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    2cbf:	83 ec 08             	sub    $0x8,%esp
    2cc2:	68 5e 57 00 00       	push   $0x575e
    2cc7:	6a 01                	push   $0x1
    2cc9:	e8 b2 17 00 00       	call   4480 <printf>
    2cce:	83 c4 10             	add    $0x10,%esp
}
    2cd1:	c9                   	leave  
    2cd2:	c3                   	ret    

00002cd3 <fourteen>:

void
fourteen(void)
{
    2cd3:	55                   	push   %ebp
    2cd4:	89 e5                	mov    %esp,%ebp
    2cd6:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2cd9:	83 ec 08             	sub    $0x8,%esp
    2cdc:	68 6f 57 00 00       	push   $0x576f
    2ce1:	6a 01                	push   $0x1
    2ce3:	e8 98 17 00 00       	call   4480 <printf>
    2ce8:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2ceb:	83 ec 0c             	sub    $0xc,%esp
    2cee:	68 7e 57 00 00       	push   $0x577e
    2cf3:	e8 73 16 00 00       	call   436b <mkdir>
    2cf8:	83 c4 10             	add    $0x10,%esp
    2cfb:	85 c0                	test   %eax,%eax
    2cfd:	74 1c                	je     2d1b <fourteen+0x48>
    printf(1, "mkdir 12345678901234 failed\n");
    2cff:	83 ec 08             	sub    $0x8,%esp
    2d02:	68 8d 57 00 00       	push   $0x578d
    2d07:	6a 01                	push   $0x1
    2d09:	e8 72 17 00 00       	call   4480 <printf>
    2d0e:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2d11:	83 ec 0c             	sub    $0xc,%esp
    2d14:	6a 01                	push   $0x1
    2d16:	e8 e8 15 00 00       	call   4303 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2d1b:	83 ec 0c             	sub    $0xc,%esp
    2d1e:	68 ac 57 00 00       	push   $0x57ac
    2d23:	e8 43 16 00 00       	call   436b <mkdir>
    2d28:	83 c4 10             	add    $0x10,%esp
    2d2b:	85 c0                	test   %eax,%eax
    2d2d:	74 1c                	je     2d4b <fourteen+0x78>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2d2f:	83 ec 08             	sub    $0x8,%esp
    2d32:	68 cc 57 00 00       	push   $0x57cc
    2d37:	6a 01                	push   $0x1
    2d39:	e8 42 17 00 00       	call   4480 <printf>
    2d3e:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2d41:	83 ec 0c             	sub    $0xc,%esp
    2d44:	6a 01                	push   $0x1
    2d46:	e8 b8 15 00 00       	call   4303 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2d4b:	83 ec 08             	sub    $0x8,%esp
    2d4e:	68 00 02 00 00       	push   $0x200
    2d53:	68 fc 57 00 00       	push   $0x57fc
    2d58:	e8 e6 15 00 00       	call   4343 <open>
    2d5d:	83 c4 10             	add    $0x10,%esp
    2d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2d63:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d67:	79 1c                	jns    2d85 <fourteen+0xb2>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2d69:	83 ec 08             	sub    $0x8,%esp
    2d6c:	68 2c 58 00 00       	push   $0x582c
    2d71:	6a 01                	push   $0x1
    2d73:	e8 08 17 00 00       	call   4480 <printf>
    2d78:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2d7b:	83 ec 0c             	sub    $0xc,%esp
    2d7e:	6a 01                	push   $0x1
    2d80:	e8 7e 15 00 00       	call   4303 <exit>
  }
  close(fd);
    2d85:	83 ec 0c             	sub    $0xc,%esp
    2d88:	ff 75 f4             	pushl  -0xc(%ebp)
    2d8b:	e8 9b 15 00 00       	call   432b <close>
    2d90:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2d93:	83 ec 08             	sub    $0x8,%esp
    2d96:	6a 00                	push   $0x0
    2d98:	68 6c 58 00 00       	push   $0x586c
    2d9d:	e8 a1 15 00 00       	call   4343 <open>
    2da2:	83 c4 10             	add    $0x10,%esp
    2da5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2da8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2dac:	79 1c                	jns    2dca <fourteen+0xf7>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2dae:	83 ec 08             	sub    $0x8,%esp
    2db1:	68 9c 58 00 00       	push   $0x589c
    2db6:	6a 01                	push   $0x1
    2db8:	e8 c3 16 00 00       	call   4480 <printf>
    2dbd:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2dc0:	83 ec 0c             	sub    $0xc,%esp
    2dc3:	6a 01                	push   $0x1
    2dc5:	e8 39 15 00 00       	call   4303 <exit>
  }
  close(fd);
    2dca:	83 ec 0c             	sub    $0xc,%esp
    2dcd:	ff 75 f4             	pushl  -0xc(%ebp)
    2dd0:	e8 56 15 00 00       	call   432b <close>
    2dd5:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    2dd8:	83 ec 0c             	sub    $0xc,%esp
    2ddb:	68 d6 58 00 00       	push   $0x58d6
    2de0:	e8 86 15 00 00       	call   436b <mkdir>
    2de5:	83 c4 10             	add    $0x10,%esp
    2de8:	85 c0                	test   %eax,%eax
    2dea:	75 1c                	jne    2e08 <fourteen+0x135>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2dec:	83 ec 08             	sub    $0x8,%esp
    2def:	68 f4 58 00 00       	push   $0x58f4
    2df4:	6a 01                	push   $0x1
    2df6:	e8 85 16 00 00       	call   4480 <printf>
    2dfb:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2dfe:	83 ec 0c             	sub    $0xc,%esp
    2e01:	6a 01                	push   $0x1
    2e03:	e8 fb 14 00 00       	call   4303 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2e08:	83 ec 0c             	sub    $0xc,%esp
    2e0b:	68 24 59 00 00       	push   $0x5924
    2e10:	e8 56 15 00 00       	call   436b <mkdir>
    2e15:	83 c4 10             	add    $0x10,%esp
    2e18:	85 c0                	test   %eax,%eax
    2e1a:	75 1c                	jne    2e38 <fourteen+0x165>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2e1c:	83 ec 08             	sub    $0x8,%esp
    2e1f:	68 44 59 00 00       	push   $0x5944
    2e24:	6a 01                	push   $0x1
    2e26:	e8 55 16 00 00       	call   4480 <printf>
    2e2b:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2e2e:	83 ec 0c             	sub    $0xc,%esp
    2e31:	6a 01                	push   $0x1
    2e33:	e8 cb 14 00 00       	call   4303 <exit>
  }

  printf(1, "fourteen ok\n");
    2e38:	83 ec 08             	sub    $0x8,%esp
    2e3b:	68 75 59 00 00       	push   $0x5975
    2e40:	6a 01                	push   $0x1
    2e42:	e8 39 16 00 00       	call   4480 <printf>
    2e47:	83 c4 10             	add    $0x10,%esp
}
    2e4a:	c9                   	leave  
    2e4b:	c3                   	ret    

00002e4c <rmdot>:

void
rmdot(void)
{
    2e4c:	55                   	push   %ebp
    2e4d:	89 e5                	mov    %esp,%ebp
    2e4f:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    2e52:	83 ec 08             	sub    $0x8,%esp
    2e55:	68 82 59 00 00       	push   $0x5982
    2e5a:	6a 01                	push   $0x1
    2e5c:	e8 1f 16 00 00       	call   4480 <printf>
    2e61:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    2e64:	83 ec 0c             	sub    $0xc,%esp
    2e67:	68 8e 59 00 00       	push   $0x598e
    2e6c:	e8 fa 14 00 00       	call   436b <mkdir>
    2e71:	83 c4 10             	add    $0x10,%esp
    2e74:	85 c0                	test   %eax,%eax
    2e76:	74 1c                	je     2e94 <rmdot+0x48>
    printf(1, "mkdir dots failed\n");
    2e78:	83 ec 08             	sub    $0x8,%esp
    2e7b:	68 93 59 00 00       	push   $0x5993
    2e80:	6a 01                	push   $0x1
    2e82:	e8 f9 15 00 00       	call   4480 <printf>
    2e87:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2e8a:	83 ec 0c             	sub    $0xc,%esp
    2e8d:	6a 01                	push   $0x1
    2e8f:	e8 6f 14 00 00       	call   4303 <exit>
  }
  if(chdir("dots") != 0){
    2e94:	83 ec 0c             	sub    $0xc,%esp
    2e97:	68 8e 59 00 00       	push   $0x598e
    2e9c:	e8 d2 14 00 00       	call   4373 <chdir>
    2ea1:	83 c4 10             	add    $0x10,%esp
    2ea4:	85 c0                	test   %eax,%eax
    2ea6:	74 1c                	je     2ec4 <rmdot+0x78>
    printf(1, "chdir dots failed\n");
    2ea8:	83 ec 08             	sub    $0x8,%esp
    2eab:	68 a6 59 00 00       	push   $0x59a6
    2eb0:	6a 01                	push   $0x1
    2eb2:	e8 c9 15 00 00       	call   4480 <printf>
    2eb7:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2eba:	83 ec 0c             	sub    $0xc,%esp
    2ebd:	6a 01                	push   $0x1
    2ebf:	e8 3f 14 00 00       	call   4303 <exit>
  }
  if(unlink(".") == 0){
    2ec4:	83 ec 0c             	sub    $0xc,%esp
    2ec7:	68 bf 50 00 00       	push   $0x50bf
    2ecc:	e8 82 14 00 00       	call   4353 <unlink>
    2ed1:	83 c4 10             	add    $0x10,%esp
    2ed4:	85 c0                	test   %eax,%eax
    2ed6:	75 1c                	jne    2ef4 <rmdot+0xa8>
    printf(1, "rm . worked!\n");
    2ed8:	83 ec 08             	sub    $0x8,%esp
    2edb:	68 b9 59 00 00       	push   $0x59b9
    2ee0:	6a 01                	push   $0x1
    2ee2:	e8 99 15 00 00       	call   4480 <printf>
    2ee7:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2eea:	83 ec 0c             	sub    $0xc,%esp
    2eed:	6a 01                	push   $0x1
    2eef:	e8 0f 14 00 00       	call   4303 <exit>
  }
  if(unlink("..") == 0){
    2ef4:	83 ec 0c             	sub    $0xc,%esp
    2ef7:	68 52 4c 00 00       	push   $0x4c52
    2efc:	e8 52 14 00 00       	call   4353 <unlink>
    2f01:	83 c4 10             	add    $0x10,%esp
    2f04:	85 c0                	test   %eax,%eax
    2f06:	75 1c                	jne    2f24 <rmdot+0xd8>
    printf(1, "rm .. worked!\n");
    2f08:	83 ec 08             	sub    $0x8,%esp
    2f0b:	68 c7 59 00 00       	push   $0x59c7
    2f10:	6a 01                	push   $0x1
    2f12:	e8 69 15 00 00       	call   4480 <printf>
    2f17:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2f1a:	83 ec 0c             	sub    $0xc,%esp
    2f1d:	6a 01                	push   $0x1
    2f1f:	e8 df 13 00 00       	call   4303 <exit>
  }
  if(chdir("/") != 0){
    2f24:	83 ec 0c             	sub    $0xc,%esp
    2f27:	68 a6 48 00 00       	push   $0x48a6
    2f2c:	e8 42 14 00 00       	call   4373 <chdir>
    2f31:	83 c4 10             	add    $0x10,%esp
    2f34:	85 c0                	test   %eax,%eax
    2f36:	74 1c                	je     2f54 <rmdot+0x108>
    printf(1, "chdir / failed\n");
    2f38:	83 ec 08             	sub    $0x8,%esp
    2f3b:	68 a8 48 00 00       	push   $0x48a8
    2f40:	6a 01                	push   $0x1
    2f42:	e8 39 15 00 00       	call   4480 <printf>
    2f47:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2f4a:	83 ec 0c             	sub    $0xc,%esp
    2f4d:	6a 01                	push   $0x1
    2f4f:	e8 af 13 00 00       	call   4303 <exit>
  }
  if(unlink("dots/.") == 0){
    2f54:	83 ec 0c             	sub    $0xc,%esp
    2f57:	68 d6 59 00 00       	push   $0x59d6
    2f5c:	e8 f2 13 00 00       	call   4353 <unlink>
    2f61:	83 c4 10             	add    $0x10,%esp
    2f64:	85 c0                	test   %eax,%eax
    2f66:	75 1c                	jne    2f84 <rmdot+0x138>
    printf(1, "unlink dots/. worked!\n");
    2f68:	83 ec 08             	sub    $0x8,%esp
    2f6b:	68 dd 59 00 00       	push   $0x59dd
    2f70:	6a 01                	push   $0x1
    2f72:	e8 09 15 00 00       	call   4480 <printf>
    2f77:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2f7a:	83 ec 0c             	sub    $0xc,%esp
    2f7d:	6a 01                	push   $0x1
    2f7f:	e8 7f 13 00 00       	call   4303 <exit>
  }
  if(unlink("dots/..") == 0){
    2f84:	83 ec 0c             	sub    $0xc,%esp
    2f87:	68 f4 59 00 00       	push   $0x59f4
    2f8c:	e8 c2 13 00 00       	call   4353 <unlink>
    2f91:	83 c4 10             	add    $0x10,%esp
    2f94:	85 c0                	test   %eax,%eax
    2f96:	75 1c                	jne    2fb4 <rmdot+0x168>
    printf(1, "unlink dots/.. worked!\n");
    2f98:	83 ec 08             	sub    $0x8,%esp
    2f9b:	68 fc 59 00 00       	push   $0x59fc
    2fa0:	6a 01                	push   $0x1
    2fa2:	e8 d9 14 00 00       	call   4480 <printf>
    2fa7:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2faa:	83 ec 0c             	sub    $0xc,%esp
    2fad:	6a 01                	push   $0x1
    2faf:	e8 4f 13 00 00       	call   4303 <exit>
  }
  if(unlink("dots") != 0){
    2fb4:	83 ec 0c             	sub    $0xc,%esp
    2fb7:	68 8e 59 00 00       	push   $0x598e
    2fbc:	e8 92 13 00 00       	call   4353 <unlink>
    2fc1:	83 c4 10             	add    $0x10,%esp
    2fc4:	85 c0                	test   %eax,%eax
    2fc6:	74 1c                	je     2fe4 <rmdot+0x198>
    printf(1, "unlink dots failed!\n");
    2fc8:	83 ec 08             	sub    $0x8,%esp
    2fcb:	68 14 5a 00 00       	push   $0x5a14
    2fd0:	6a 01                	push   $0x1
    2fd2:	e8 a9 14 00 00       	call   4480 <printf>
    2fd7:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    2fda:	83 ec 0c             	sub    $0xc,%esp
    2fdd:	6a 01                	push   $0x1
    2fdf:	e8 1f 13 00 00       	call   4303 <exit>
  }
  printf(1, "rmdot ok\n");
    2fe4:	83 ec 08             	sub    $0x8,%esp
    2fe7:	68 29 5a 00 00       	push   $0x5a29
    2fec:	6a 01                	push   $0x1
    2fee:	e8 8d 14 00 00       	call   4480 <printf>
    2ff3:	83 c4 10             	add    $0x10,%esp
}
    2ff6:	c9                   	leave  
    2ff7:	c3                   	ret    

00002ff8 <dirfile>:

void
dirfile(void)
{
    2ff8:	55                   	push   %ebp
    2ff9:	89 e5                	mov    %esp,%ebp
    2ffb:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2ffe:	83 ec 08             	sub    $0x8,%esp
    3001:	68 33 5a 00 00       	push   $0x5a33
    3006:	6a 01                	push   $0x1
    3008:	e8 73 14 00 00       	call   4480 <printf>
    300d:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    3010:	83 ec 08             	sub    $0x8,%esp
    3013:	68 00 02 00 00       	push   $0x200
    3018:	68 40 5a 00 00       	push   $0x5a40
    301d:	e8 21 13 00 00       	call   4343 <open>
    3022:	83 c4 10             	add    $0x10,%esp
    3025:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    3028:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    302c:	79 1c                	jns    304a <dirfile+0x52>
    printf(1, "create dirfile failed\n");
    302e:	83 ec 08             	sub    $0x8,%esp
    3031:	68 48 5a 00 00       	push   $0x5a48
    3036:	6a 01                	push   $0x1
    3038:	e8 43 14 00 00       	call   4480 <printf>
    303d:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3040:	83 ec 0c             	sub    $0xc,%esp
    3043:	6a 01                	push   $0x1
    3045:	e8 b9 12 00 00       	call   4303 <exit>
  }
  close(fd);
    304a:	83 ec 0c             	sub    $0xc,%esp
    304d:	ff 75 f4             	pushl  -0xc(%ebp)
    3050:	e8 d6 12 00 00       	call   432b <close>
    3055:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    3058:	83 ec 0c             	sub    $0xc,%esp
    305b:	68 40 5a 00 00       	push   $0x5a40
    3060:	e8 0e 13 00 00       	call   4373 <chdir>
    3065:	83 c4 10             	add    $0x10,%esp
    3068:	85 c0                	test   %eax,%eax
    306a:	75 1c                	jne    3088 <dirfile+0x90>
    printf(1, "chdir dirfile succeeded!\n");
    306c:	83 ec 08             	sub    $0x8,%esp
    306f:	68 5f 5a 00 00       	push   $0x5a5f
    3074:	6a 01                	push   $0x1
    3076:	e8 05 14 00 00       	call   4480 <printf>
    307b:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    307e:	83 ec 0c             	sub    $0xc,%esp
    3081:	6a 01                	push   $0x1
    3083:	e8 7b 12 00 00       	call   4303 <exit>
  }
  fd = open("dirfile/xx", 0);
    3088:	83 ec 08             	sub    $0x8,%esp
    308b:	6a 00                	push   $0x0
    308d:	68 79 5a 00 00       	push   $0x5a79
    3092:	e8 ac 12 00 00       	call   4343 <open>
    3097:	83 c4 10             	add    $0x10,%esp
    309a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    309d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30a1:	78 1c                	js     30bf <dirfile+0xc7>
    printf(1, "create dirfile/xx succeeded!\n");
    30a3:	83 ec 08             	sub    $0x8,%esp
    30a6:	68 84 5a 00 00       	push   $0x5a84
    30ab:	6a 01                	push   $0x1
    30ad:	e8 ce 13 00 00       	call   4480 <printf>
    30b2:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    30b5:	83 ec 0c             	sub    $0xc,%esp
    30b8:	6a 01                	push   $0x1
    30ba:	e8 44 12 00 00       	call   4303 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    30bf:	83 ec 08             	sub    $0x8,%esp
    30c2:	68 00 02 00 00       	push   $0x200
    30c7:	68 79 5a 00 00       	push   $0x5a79
    30cc:	e8 72 12 00 00       	call   4343 <open>
    30d1:	83 c4 10             	add    $0x10,%esp
    30d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    30d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30db:	78 1c                	js     30f9 <dirfile+0x101>
    printf(1, "create dirfile/xx succeeded!\n");
    30dd:	83 ec 08             	sub    $0x8,%esp
    30e0:	68 84 5a 00 00       	push   $0x5a84
    30e5:	6a 01                	push   $0x1
    30e7:	e8 94 13 00 00       	call   4480 <printf>
    30ec:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    30ef:	83 ec 0c             	sub    $0xc,%esp
    30f2:	6a 01                	push   $0x1
    30f4:	e8 0a 12 00 00       	call   4303 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    30f9:	83 ec 0c             	sub    $0xc,%esp
    30fc:	68 79 5a 00 00       	push   $0x5a79
    3101:	e8 65 12 00 00       	call   436b <mkdir>
    3106:	83 c4 10             	add    $0x10,%esp
    3109:	85 c0                	test   %eax,%eax
    310b:	75 1c                	jne    3129 <dirfile+0x131>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    310d:	83 ec 08             	sub    $0x8,%esp
    3110:	68 a2 5a 00 00       	push   $0x5aa2
    3115:	6a 01                	push   $0x1
    3117:	e8 64 13 00 00       	call   4480 <printf>
    311c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    311f:	83 ec 0c             	sub    $0xc,%esp
    3122:	6a 01                	push   $0x1
    3124:	e8 da 11 00 00       	call   4303 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    3129:	83 ec 0c             	sub    $0xc,%esp
    312c:	68 79 5a 00 00       	push   $0x5a79
    3131:	e8 1d 12 00 00       	call   4353 <unlink>
    3136:	83 c4 10             	add    $0x10,%esp
    3139:	85 c0                	test   %eax,%eax
    313b:	75 1c                	jne    3159 <dirfile+0x161>
    printf(1, "unlink dirfile/xx succeeded!\n");
    313d:	83 ec 08             	sub    $0x8,%esp
    3140:	68 bf 5a 00 00       	push   $0x5abf
    3145:	6a 01                	push   $0x1
    3147:	e8 34 13 00 00       	call   4480 <printf>
    314c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    314f:	83 ec 0c             	sub    $0xc,%esp
    3152:	6a 01                	push   $0x1
    3154:	e8 aa 11 00 00       	call   4303 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    3159:	83 ec 08             	sub    $0x8,%esp
    315c:	68 79 5a 00 00       	push   $0x5a79
    3161:	68 dd 5a 00 00       	push   $0x5add
    3166:	e8 f8 11 00 00       	call   4363 <link>
    316b:	83 c4 10             	add    $0x10,%esp
    316e:	85 c0                	test   %eax,%eax
    3170:	75 1c                	jne    318e <dirfile+0x196>
    printf(1, "link to dirfile/xx succeeded!\n");
    3172:	83 ec 08             	sub    $0x8,%esp
    3175:	68 e4 5a 00 00       	push   $0x5ae4
    317a:	6a 01                	push   $0x1
    317c:	e8 ff 12 00 00       	call   4480 <printf>
    3181:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3184:	83 ec 0c             	sub    $0xc,%esp
    3187:	6a 01                	push   $0x1
    3189:	e8 75 11 00 00       	call   4303 <exit>
  }
  if(unlink("dirfile") != 0){
    318e:	83 ec 0c             	sub    $0xc,%esp
    3191:	68 40 5a 00 00       	push   $0x5a40
    3196:	e8 b8 11 00 00       	call   4353 <unlink>
    319b:	83 c4 10             	add    $0x10,%esp
    319e:	85 c0                	test   %eax,%eax
    31a0:	74 1c                	je     31be <dirfile+0x1c6>
    printf(1, "unlink dirfile failed!\n");
    31a2:	83 ec 08             	sub    $0x8,%esp
    31a5:	68 03 5b 00 00       	push   $0x5b03
    31aa:	6a 01                	push   $0x1
    31ac:	e8 cf 12 00 00       	call   4480 <printf>
    31b1:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    31b4:	83 ec 0c             	sub    $0xc,%esp
    31b7:	6a 01                	push   $0x1
    31b9:	e8 45 11 00 00       	call   4303 <exit>
  }

  fd = open(".", O_RDWR);
    31be:	83 ec 08             	sub    $0x8,%esp
    31c1:	6a 02                	push   $0x2
    31c3:	68 bf 50 00 00       	push   $0x50bf
    31c8:	e8 76 11 00 00       	call   4343 <open>
    31cd:	83 c4 10             	add    $0x10,%esp
    31d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    31d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    31d7:	78 1c                	js     31f5 <dirfile+0x1fd>
    printf(1, "open . for writing succeeded!\n");
    31d9:	83 ec 08             	sub    $0x8,%esp
    31dc:	68 1c 5b 00 00       	push   $0x5b1c
    31e1:	6a 01                	push   $0x1
    31e3:	e8 98 12 00 00       	call   4480 <printf>
    31e8:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    31eb:	83 ec 0c             	sub    $0xc,%esp
    31ee:	6a 01                	push   $0x1
    31f0:	e8 0e 11 00 00       	call   4303 <exit>
  }
  fd = open(".", 0);
    31f5:	83 ec 08             	sub    $0x8,%esp
    31f8:	6a 00                	push   $0x0
    31fa:	68 bf 50 00 00       	push   $0x50bf
    31ff:	e8 3f 11 00 00       	call   4343 <open>
    3204:	83 c4 10             	add    $0x10,%esp
    3207:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    320a:	83 ec 04             	sub    $0x4,%esp
    320d:	6a 01                	push   $0x1
    320f:	68 0b 4d 00 00       	push   $0x4d0b
    3214:	ff 75 f4             	pushl  -0xc(%ebp)
    3217:	e8 07 11 00 00       	call   4323 <write>
    321c:	83 c4 10             	add    $0x10,%esp
    321f:	85 c0                	test   %eax,%eax
    3221:	7e 1c                	jle    323f <dirfile+0x247>
    printf(1, "write . succeeded!\n");
    3223:	83 ec 08             	sub    $0x8,%esp
    3226:	68 3b 5b 00 00       	push   $0x5b3b
    322b:	6a 01                	push   $0x1
    322d:	e8 4e 12 00 00       	call   4480 <printf>
    3232:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3235:	83 ec 0c             	sub    $0xc,%esp
    3238:	6a 01                	push   $0x1
    323a:	e8 c4 10 00 00       	call   4303 <exit>
  }
  close(fd);
    323f:	83 ec 0c             	sub    $0xc,%esp
    3242:	ff 75 f4             	pushl  -0xc(%ebp)
    3245:	e8 e1 10 00 00       	call   432b <close>
    324a:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    324d:	83 ec 08             	sub    $0x8,%esp
    3250:	68 4f 5b 00 00       	push   $0x5b4f
    3255:	6a 01                	push   $0x1
    3257:	e8 24 12 00 00       	call   4480 <printf>
    325c:	83 c4 10             	add    $0x10,%esp
}
    325f:	c9                   	leave  
    3260:	c3                   	ret    

00003261 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    3261:	55                   	push   %ebp
    3262:	89 e5                	mov    %esp,%ebp
    3264:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    3267:	83 ec 08             	sub    $0x8,%esp
    326a:	68 5f 5b 00 00       	push   $0x5b5f
    326f:	6a 01                	push   $0x1
    3271:	e8 0a 12 00 00       	call   4480 <printf>
    3276:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    3279:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3280:	e9 f1 00 00 00       	jmp    3376 <iref+0x115>
    if(mkdir("irefd") != 0){
    3285:	83 ec 0c             	sub    $0xc,%esp
    3288:	68 70 5b 00 00       	push   $0x5b70
    328d:	e8 d9 10 00 00       	call   436b <mkdir>
    3292:	83 c4 10             	add    $0x10,%esp
    3295:	85 c0                	test   %eax,%eax
    3297:	74 1c                	je     32b5 <iref+0x54>
      printf(1, "mkdir irefd failed\n");
    3299:	83 ec 08             	sub    $0x8,%esp
    329c:	68 76 5b 00 00       	push   $0x5b76
    32a1:	6a 01                	push   $0x1
    32a3:	e8 d8 11 00 00       	call   4480 <printf>
    32a8:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    32ab:	83 ec 0c             	sub    $0xc,%esp
    32ae:	6a 01                	push   $0x1
    32b0:	e8 4e 10 00 00       	call   4303 <exit>
    }
    if(chdir("irefd") != 0){
    32b5:	83 ec 0c             	sub    $0xc,%esp
    32b8:	68 70 5b 00 00       	push   $0x5b70
    32bd:	e8 b1 10 00 00       	call   4373 <chdir>
    32c2:	83 c4 10             	add    $0x10,%esp
    32c5:	85 c0                	test   %eax,%eax
    32c7:	74 1c                	je     32e5 <iref+0x84>
      printf(1, "chdir irefd failed\n");
    32c9:	83 ec 08             	sub    $0x8,%esp
    32cc:	68 8a 5b 00 00       	push   $0x5b8a
    32d1:	6a 01                	push   $0x1
    32d3:	e8 a8 11 00 00       	call   4480 <printf>
    32d8:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    32db:	83 ec 0c             	sub    $0xc,%esp
    32de:	6a 01                	push   $0x1
    32e0:	e8 1e 10 00 00       	call   4303 <exit>
    }

    mkdir("");
    32e5:	83 ec 0c             	sub    $0xc,%esp
    32e8:	68 9e 5b 00 00       	push   $0x5b9e
    32ed:	e8 79 10 00 00       	call   436b <mkdir>
    32f2:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    32f5:	83 ec 08             	sub    $0x8,%esp
    32f8:	68 9e 5b 00 00       	push   $0x5b9e
    32fd:	68 dd 5a 00 00       	push   $0x5add
    3302:	e8 5c 10 00 00       	call   4363 <link>
    3307:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    330a:	83 ec 08             	sub    $0x8,%esp
    330d:	68 00 02 00 00       	push   $0x200
    3312:	68 9e 5b 00 00       	push   $0x5b9e
    3317:	e8 27 10 00 00       	call   4343 <open>
    331c:	83 c4 10             	add    $0x10,%esp
    331f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    3322:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3326:	78 0e                	js     3336 <iref+0xd5>
      close(fd);
    3328:	83 ec 0c             	sub    $0xc,%esp
    332b:	ff 75 f0             	pushl  -0x10(%ebp)
    332e:	e8 f8 0f 00 00       	call   432b <close>
    3333:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    3336:	83 ec 08             	sub    $0x8,%esp
    3339:	68 00 02 00 00       	push   $0x200
    333e:	68 9f 5b 00 00       	push   $0x5b9f
    3343:	e8 fb 0f 00 00       	call   4343 <open>
    3348:	83 c4 10             	add    $0x10,%esp
    334b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    334e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3352:	78 0e                	js     3362 <iref+0x101>
      close(fd);
    3354:	83 ec 0c             	sub    $0xc,%esp
    3357:	ff 75 f0             	pushl  -0x10(%ebp)
    335a:	e8 cc 0f 00 00       	call   432b <close>
    335f:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    3362:	83 ec 0c             	sub    $0xc,%esp
    3365:	68 9f 5b 00 00       	push   $0x5b9f
    336a:	e8 e4 0f 00 00       	call   4353 <unlink>
    336f:	83 c4 10             	add    $0x10,%esp
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    3372:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3376:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    337a:	0f 8e 05 ff ff ff    	jle    3285 <iref+0x24>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    3380:	83 ec 0c             	sub    $0xc,%esp
    3383:	68 a6 48 00 00       	push   $0x48a6
    3388:	e8 e6 0f 00 00       	call   4373 <chdir>
    338d:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    3390:	83 ec 08             	sub    $0x8,%esp
    3393:	68 a2 5b 00 00       	push   $0x5ba2
    3398:	6a 01                	push   $0x1
    339a:	e8 e1 10 00 00       	call   4480 <printf>
    339f:	83 c4 10             	add    $0x10,%esp
}
    33a2:	c9                   	leave  
    33a3:	c3                   	ret    

000033a4 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    33a4:	55                   	push   %ebp
    33a5:	89 e5                	mov    %esp,%ebp
    33a7:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    33aa:	83 ec 08             	sub    $0x8,%esp
    33ad:	68 b6 5b 00 00       	push   $0x5bb6
    33b2:	6a 01                	push   $0x1
    33b4:	e8 c7 10 00 00       	call   4480 <printf>
    33b9:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    33bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    33c3:	eb 24                	jmp    33e9 <forktest+0x45>
    pid = fork();
    33c5:	e8 31 0f 00 00       	call   42fb <fork>
    33ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    33cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    33d1:	79 02                	jns    33d5 <forktest+0x31>
      break;
    33d3:	eb 1d                	jmp    33f2 <forktest+0x4e>
    if(pid == 0)
    33d5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    33d9:	75 0a                	jne    33e5 <forktest+0x41>
      exit(EXIT_STATUS_OK);
    33db:	83 ec 0c             	sub    $0xc,%esp
    33de:	6a 01                	push   $0x1
    33e0:	e8 1e 0f 00 00       	call   4303 <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    33e5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    33e9:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    33f0:	7e d3                	jle    33c5 <forktest+0x21>
      break;
    if(pid == 0)
      exit(EXIT_STATUS_OK);
  }
  
  if(n == 1000){
    33f2:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    33f9:	75 1c                	jne    3417 <forktest+0x73>
    printf(1, "fork claimed to work 1000 times!\n");
    33fb:	83 ec 08             	sub    $0x8,%esp
    33fe:	68 c4 5b 00 00       	push   $0x5bc4
    3403:	6a 01                	push   $0x1
    3405:	e8 76 10 00 00       	call   4480 <printf>
    340a:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    340d:	83 ec 0c             	sub    $0xc,%esp
    3410:	6a 01                	push   $0x1
    3412:	e8 ec 0e 00 00       	call   4303 <exit>
  }
  
  for(; n > 0; n--){
    3417:	eb 31                	jmp    344a <forktest+0xa6>
    if(wait(0) < 0){
    3419:	83 ec 0c             	sub    $0xc,%esp
    341c:	6a 00                	push   $0x0
    341e:	e8 e8 0e 00 00       	call   430b <wait>
    3423:	83 c4 10             	add    $0x10,%esp
    3426:	85 c0                	test   %eax,%eax
    3428:	79 1c                	jns    3446 <forktest+0xa2>
      printf(1, "wait stopped early\n");
    342a:	83 ec 08             	sub    $0x8,%esp
    342d:	68 e6 5b 00 00       	push   $0x5be6
    3432:	6a 01                	push   $0x1
    3434:	e8 47 10 00 00       	call   4480 <printf>
    3439:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    343c:	83 ec 0c             	sub    $0xc,%esp
    343f:	6a 01                	push   $0x1
    3441:	e8 bd 0e 00 00       	call   4303 <exit>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit(EXIT_STATUS_OK);
  }
  
  for(; n > 0; n--){
    3446:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    344a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    344e:	7f c9                	jg     3419 <forktest+0x75>
      printf(1, "wait stopped early\n");
      exit(EXIT_STATUS_OK);
    }
  }
  
  if(wait(0) != -1){
    3450:	83 ec 0c             	sub    $0xc,%esp
    3453:	6a 00                	push   $0x0
    3455:	e8 b1 0e 00 00       	call   430b <wait>
    345a:	83 c4 10             	add    $0x10,%esp
    345d:	83 f8 ff             	cmp    $0xffffffff,%eax
    3460:	74 1c                	je     347e <forktest+0xda>
    printf(1, "wait got too many\n");
    3462:	83 ec 08             	sub    $0x8,%esp
    3465:	68 fa 5b 00 00       	push   $0x5bfa
    346a:	6a 01                	push   $0x1
    346c:	e8 0f 10 00 00       	call   4480 <printf>
    3471:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3474:	83 ec 0c             	sub    $0xc,%esp
    3477:	6a 01                	push   $0x1
    3479:	e8 85 0e 00 00       	call   4303 <exit>
  }
  
  printf(1, "fork test OK\n");
    347e:	83 ec 08             	sub    $0x8,%esp
    3481:	68 0d 5c 00 00       	push   $0x5c0d
    3486:	6a 01                	push   $0x1
    3488:	e8 f3 0f 00 00       	call   4480 <printf>
    348d:	83 c4 10             	add    $0x10,%esp
}
    3490:	c9                   	leave  
    3491:	c3                   	ret    

00003492 <sbrktest>:

void
sbrktest(void)
{
    3492:	55                   	push   %ebp
    3493:	89 e5                	mov    %esp,%ebp
    3495:	53                   	push   %ebx
    3496:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    3499:	a1 f0 66 00 00       	mov    0x66f0,%eax
    349e:	83 ec 08             	sub    $0x8,%esp
    34a1:	68 1b 5c 00 00       	push   $0x5c1b
    34a6:	50                   	push   %eax
    34a7:	e8 d4 0f 00 00       	call   4480 <printf>
    34ac:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    34af:	83 ec 0c             	sub    $0xc,%esp
    34b2:	6a 00                	push   $0x0
    34b4:	e8 d2 0e 00 00       	call   438b <sbrk>
    34b9:	83 c4 10             	add    $0x10,%esp
    34bc:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    34bf:	83 ec 0c             	sub    $0xc,%esp
    34c2:	6a 00                	push   $0x0
    34c4:	e8 c2 0e 00 00       	call   438b <sbrk>
    34c9:	83 c4 10             	add    $0x10,%esp
    34cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    34cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    34d6:	eb 54                	jmp    352c <sbrktest+0x9a>
    b = sbrk(1);
    34d8:	83 ec 0c             	sub    $0xc,%esp
    34db:	6a 01                	push   $0x1
    34dd:	e8 a9 0e 00 00       	call   438b <sbrk>
    34e2:	83 c4 10             	add    $0x10,%esp
    34e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(b != a){
    34e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    34eb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    34ee:	74 29                	je     3519 <sbrktest+0x87>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    34f0:	a1 f0 66 00 00       	mov    0x66f0,%eax
    34f5:	83 ec 0c             	sub    $0xc,%esp
    34f8:	ff 75 e8             	pushl  -0x18(%ebp)
    34fb:	ff 75 f4             	pushl  -0xc(%ebp)
    34fe:	ff 75 f0             	pushl  -0x10(%ebp)
    3501:	68 26 5c 00 00       	push   $0x5c26
    3506:	50                   	push   %eax
    3507:	e8 74 0f 00 00       	call   4480 <printf>
    350c:	83 c4 20             	add    $0x20,%esp
      exit(EXIT_STATUS_OK);
    350f:	83 ec 0c             	sub    $0xc,%esp
    3512:	6a 01                	push   $0x1
    3514:	e8 ea 0d 00 00       	call   4303 <exit>
    }
    *b = 1;
    3519:	8b 45 e8             	mov    -0x18(%ebp),%eax
    351c:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    351f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3522:	83 c0 01             	add    $0x1,%eax
    3525:	89 45 f4             	mov    %eax,-0xc(%ebp)
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){ 
    3528:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    352c:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    3533:	7e a3                	jle    34d8 <sbrktest+0x46>
      exit(EXIT_STATUS_OK);
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    3535:	e8 c1 0d 00 00       	call   42fb <fork>
    353a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    353d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3541:	79 20                	jns    3563 <sbrktest+0xd1>
    printf(stdout, "sbrk test fork failed\n");
    3543:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3548:	83 ec 08             	sub    $0x8,%esp
    354b:	68 41 5c 00 00       	push   $0x5c41
    3550:	50                   	push   %eax
    3551:	e8 2a 0f 00 00       	call   4480 <printf>
    3556:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3559:	83 ec 0c             	sub    $0xc,%esp
    355c:	6a 01                	push   $0x1
    355e:	e8 a0 0d 00 00       	call   4303 <exit>
  }
  c = sbrk(1);
    3563:	83 ec 0c             	sub    $0xc,%esp
    3566:	6a 01                	push   $0x1
    3568:	e8 1e 0e 00 00       	call   438b <sbrk>
    356d:	83 c4 10             	add    $0x10,%esp
    3570:	89 45 e0             	mov    %eax,-0x20(%ebp)
  c = sbrk(1);
    3573:	83 ec 0c             	sub    $0xc,%esp
    3576:	6a 01                	push   $0x1
    3578:	e8 0e 0e 00 00       	call   438b <sbrk>
    357d:	83 c4 10             	add    $0x10,%esp
    3580:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a + 1){
    3583:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3586:	83 c0 01             	add    $0x1,%eax
    3589:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    358c:	74 20                	je     35ae <sbrktest+0x11c>
    printf(stdout, "sbrk test failed post-fork\n");
    358e:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3593:	83 ec 08             	sub    $0x8,%esp
    3596:	68 58 5c 00 00       	push   $0x5c58
    359b:	50                   	push   %eax
    359c:	e8 df 0e 00 00       	call   4480 <printf>
    35a1:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    35a4:	83 ec 0c             	sub    $0xc,%esp
    35a7:	6a 01                	push   $0x1
    35a9:	e8 55 0d 00 00       	call   4303 <exit>
  }
  if(pid == 0)
    35ae:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    35b2:	75 0a                	jne    35be <sbrktest+0x12c>
    exit(EXIT_STATUS_OK);
    35b4:	83 ec 0c             	sub    $0xc,%esp
    35b7:	6a 01                	push   $0x1
    35b9:	e8 45 0d 00 00       	call   4303 <exit>
  wait(0);
    35be:	83 ec 0c             	sub    $0xc,%esp
    35c1:	6a 00                	push   $0x0
    35c3:	e8 43 0d 00 00       	call   430b <wait>
    35c8:	83 c4 10             	add    $0x10,%esp

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    35cb:	83 ec 0c             	sub    $0xc,%esp
    35ce:	6a 00                	push   $0x0
    35d0:	e8 b6 0d 00 00       	call   438b <sbrk>
    35d5:	83 c4 10             	add    $0x10,%esp
    35d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    35db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    35de:	ba 00 00 40 06       	mov    $0x6400000,%edx
    35e3:	29 c2                	sub    %eax,%edx
    35e5:	89 d0                	mov    %edx,%eax
    35e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  p = sbrk(amt);
    35ea:	8b 45 dc             	mov    -0x24(%ebp),%eax
    35ed:	83 ec 0c             	sub    $0xc,%esp
    35f0:	50                   	push   %eax
    35f1:	e8 95 0d 00 00       	call   438b <sbrk>
    35f6:	83 c4 10             	add    $0x10,%esp
    35f9:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (p != a) { 
    35fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    35ff:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3602:	74 20                	je     3624 <sbrktest+0x192>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3604:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3609:	83 ec 08             	sub    $0x8,%esp
    360c:	68 74 5c 00 00       	push   $0x5c74
    3611:	50                   	push   %eax
    3612:	e8 69 0e 00 00       	call   4480 <printf>
    3617:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    361a:	83 ec 0c             	sub    $0xc,%esp
    361d:	6a 01                	push   $0x1
    361f:	e8 df 0c 00 00       	call   4303 <exit>
  }
  lastaddr = (char*) (BIG-1);
    3624:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
  *lastaddr = 99;
    362b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    362e:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    3631:	83 ec 0c             	sub    $0xc,%esp
    3634:	6a 00                	push   $0x0
    3636:	e8 50 0d 00 00       	call   438b <sbrk>
    363b:	83 c4 10             	add    $0x10,%esp
    363e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    3641:	83 ec 0c             	sub    $0xc,%esp
    3644:	68 00 f0 ff ff       	push   $0xfffff000
    3649:	e8 3d 0d 00 00       	call   438b <sbrk>
    364e:	83 c4 10             	add    $0x10,%esp
    3651:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c == (char*)0xffffffff){
    3654:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    3658:	75 20                	jne    367a <sbrktest+0x1e8>
    printf(stdout, "sbrk could not deallocate\n");
    365a:	a1 f0 66 00 00       	mov    0x66f0,%eax
    365f:	83 ec 08             	sub    $0x8,%esp
    3662:	68 b2 5c 00 00       	push   $0x5cb2
    3667:	50                   	push   %eax
    3668:	e8 13 0e 00 00       	call   4480 <printf>
    366d:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3670:	83 ec 0c             	sub    $0xc,%esp
    3673:	6a 01                	push   $0x1
    3675:	e8 89 0c 00 00       	call   4303 <exit>
  }
  c = sbrk(0);
    367a:	83 ec 0c             	sub    $0xc,%esp
    367d:	6a 00                	push   $0x0
    367f:	e8 07 0d 00 00       	call   438b <sbrk>
    3684:	83 c4 10             	add    $0x10,%esp
    3687:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a - 4096){
    368a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    368d:	2d 00 10 00 00       	sub    $0x1000,%eax
    3692:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    3695:	74 23                	je     36ba <sbrktest+0x228>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3697:	a1 f0 66 00 00       	mov    0x66f0,%eax
    369c:	ff 75 e0             	pushl  -0x20(%ebp)
    369f:	ff 75 f4             	pushl  -0xc(%ebp)
    36a2:	68 d0 5c 00 00       	push   $0x5cd0
    36a7:	50                   	push   %eax
    36a8:	e8 d3 0d 00 00       	call   4480 <printf>
    36ad:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    36b0:	83 ec 0c             	sub    $0xc,%esp
    36b3:	6a 01                	push   $0x1
    36b5:	e8 49 0c 00 00       	call   4303 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    36ba:	83 ec 0c             	sub    $0xc,%esp
    36bd:	6a 00                	push   $0x0
    36bf:	e8 c7 0c 00 00       	call   438b <sbrk>
    36c4:	83 c4 10             	add    $0x10,%esp
    36c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    36ca:	83 ec 0c             	sub    $0xc,%esp
    36cd:	68 00 10 00 00       	push   $0x1000
    36d2:	e8 b4 0c 00 00       	call   438b <sbrk>
    36d7:	83 c4 10             	add    $0x10,%esp
    36da:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    36dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    36e0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    36e3:	75 1b                	jne    3700 <sbrktest+0x26e>
    36e5:	83 ec 0c             	sub    $0xc,%esp
    36e8:	6a 00                	push   $0x0
    36ea:	e8 9c 0c 00 00       	call   438b <sbrk>
    36ef:	83 c4 10             	add    $0x10,%esp
    36f2:	89 c2                	mov    %eax,%edx
    36f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36f7:	05 00 10 00 00       	add    $0x1000,%eax
    36fc:	39 c2                	cmp    %eax,%edx
    36fe:	74 23                	je     3723 <sbrktest+0x291>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3700:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3705:	ff 75 e0             	pushl  -0x20(%ebp)
    3708:	ff 75 f4             	pushl  -0xc(%ebp)
    370b:	68 08 5d 00 00       	push   $0x5d08
    3710:	50                   	push   %eax
    3711:	e8 6a 0d 00 00       	call   4480 <printf>
    3716:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3719:	83 ec 0c             	sub    $0xc,%esp
    371c:	6a 01                	push   $0x1
    371e:	e8 e0 0b 00 00       	call   4303 <exit>
  }
  if(*lastaddr == 99){
    3723:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3726:	0f b6 00             	movzbl (%eax),%eax
    3729:	3c 63                	cmp    $0x63,%al
    372b:	75 20                	jne    374d <sbrktest+0x2bb>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    372d:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3732:	83 ec 08             	sub    $0x8,%esp
    3735:	68 30 5d 00 00       	push   $0x5d30
    373a:	50                   	push   %eax
    373b:	e8 40 0d 00 00       	call   4480 <printf>
    3740:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3743:	83 ec 0c             	sub    $0xc,%esp
    3746:	6a 01                	push   $0x1
    3748:	e8 b6 0b 00 00       	call   4303 <exit>
  }

  a = sbrk(0);
    374d:	83 ec 0c             	sub    $0xc,%esp
    3750:	6a 00                	push   $0x0
    3752:	e8 34 0c 00 00       	call   438b <sbrk>
    3757:	83 c4 10             	add    $0x10,%esp
    375a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    375d:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3760:	83 ec 0c             	sub    $0xc,%esp
    3763:	6a 00                	push   $0x0
    3765:	e8 21 0c 00 00       	call   438b <sbrk>
    376a:	83 c4 10             	add    $0x10,%esp
    376d:	29 c3                	sub    %eax,%ebx
    376f:	89 d8                	mov    %ebx,%eax
    3771:	83 ec 0c             	sub    $0xc,%esp
    3774:	50                   	push   %eax
    3775:	e8 11 0c 00 00       	call   438b <sbrk>
    377a:	83 c4 10             	add    $0x10,%esp
    377d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a){
    3780:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3783:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3786:	74 23                	je     37ab <sbrktest+0x319>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3788:	a1 f0 66 00 00       	mov    0x66f0,%eax
    378d:	ff 75 e0             	pushl  -0x20(%ebp)
    3790:	ff 75 f4             	pushl  -0xc(%ebp)
    3793:	68 60 5d 00 00       	push   $0x5d60
    3798:	50                   	push   %eax
    3799:	e8 e2 0c 00 00       	call   4480 <printf>
    379e:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    37a1:	83 ec 0c             	sub    $0xc,%esp
    37a4:	6a 01                	push   $0x1
    37a6:	e8 58 0b 00 00       	call   4303 <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    37ab:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    37b2:	e9 88 00 00 00       	jmp    383f <sbrktest+0x3ad>
    ppid = getpid();
    37b7:	e8 c7 0b 00 00       	call   4383 <getpid>
    37bc:	89 45 d0             	mov    %eax,-0x30(%ebp)
    pid = fork();
    37bf:	e8 37 0b 00 00       	call   42fb <fork>
    37c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pid < 0){
    37c7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    37cb:	79 20                	jns    37ed <sbrktest+0x35b>
      printf(stdout, "fork failed\n");
    37cd:	a1 f0 66 00 00       	mov    0x66f0,%eax
    37d2:	83 ec 08             	sub    $0x8,%esp
    37d5:	68 d5 48 00 00       	push   $0x48d5
    37da:	50                   	push   %eax
    37db:	e8 a0 0c 00 00       	call   4480 <printf>
    37e0:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    37e3:	83 ec 0c             	sub    $0xc,%esp
    37e6:	6a 01                	push   $0x1
    37e8:	e8 16 0b 00 00       	call   4303 <exit>
    }
    if(pid == 0){
    37ed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    37f1:	75 38                	jne    382b <sbrktest+0x399>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    37f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    37f6:	0f b6 00             	movzbl (%eax),%eax
    37f9:	0f be d0             	movsbl %al,%edx
    37fc:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3801:	52                   	push   %edx
    3802:	ff 75 f4             	pushl  -0xc(%ebp)
    3805:	68 81 5d 00 00       	push   $0x5d81
    380a:	50                   	push   %eax
    380b:	e8 70 0c 00 00       	call   4480 <printf>
    3810:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    3813:	83 ec 0c             	sub    $0xc,%esp
    3816:	ff 75 d0             	pushl  -0x30(%ebp)
    3819:	e8 15 0b 00 00       	call   4333 <kill>
    381e:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    3821:	83 ec 0c             	sub    $0xc,%esp
    3824:	6a 01                	push   $0x1
    3826:	e8 d8 0a 00 00       	call   4303 <exit>
    }
    wait(0);
    382b:	83 ec 0c             	sub    $0xc,%esp
    382e:	6a 00                	push   $0x0
    3830:	e8 d6 0a 00 00       	call   430b <wait>
    3835:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit(EXIT_STATUS_OK);
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3838:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    383f:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    3846:	0f 86 6b ff ff ff    	jbe    37b7 <sbrktest+0x325>
    wait(0);
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    384c:	83 ec 0c             	sub    $0xc,%esp
    384f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3852:	50                   	push   %eax
    3853:	e8 bb 0a 00 00       	call   4313 <pipe>
    3858:	83 c4 10             	add    $0x10,%esp
    385b:	85 c0                	test   %eax,%eax
    385d:	74 1c                	je     387b <sbrktest+0x3e9>
    printf(1, "pipe() failed\n");
    385f:	83 ec 08             	sub    $0x8,%esp
    3862:	68 a6 4c 00 00       	push   $0x4ca6
    3867:	6a 01                	push   $0x1
    3869:	e8 12 0c 00 00       	call   4480 <printf>
    386e:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3871:	83 ec 0c             	sub    $0xc,%esp
    3874:	6a 01                	push   $0x1
    3876:	e8 88 0a 00 00       	call   4303 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    387b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3882:	e9 88 00 00 00       	jmp    390f <sbrktest+0x47d>
    if((pids[i] = fork()) == 0){
    3887:	e8 6f 0a 00 00       	call   42fb <fork>
    388c:	89 c2                	mov    %eax,%edx
    388e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3891:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
    3895:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3898:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    389c:	85 c0                	test   %eax,%eax
    389e:	75 4a                	jne    38ea <sbrktest+0x458>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    38a0:	83 ec 0c             	sub    $0xc,%esp
    38a3:	6a 00                	push   $0x0
    38a5:	e8 e1 0a 00 00       	call   438b <sbrk>
    38aa:	83 c4 10             	add    $0x10,%esp
    38ad:	ba 00 00 40 06       	mov    $0x6400000,%edx
    38b2:	29 c2                	sub    %eax,%edx
    38b4:	89 d0                	mov    %edx,%eax
    38b6:	83 ec 0c             	sub    $0xc,%esp
    38b9:	50                   	push   %eax
    38ba:	e8 cc 0a 00 00       	call   438b <sbrk>
    38bf:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    38c2:	8b 45 cc             	mov    -0x34(%ebp),%eax
    38c5:	83 ec 04             	sub    $0x4,%esp
    38c8:	6a 01                	push   $0x1
    38ca:	68 0b 4d 00 00       	push   $0x4d0b
    38cf:	50                   	push   %eax
    38d0:	e8 4e 0a 00 00       	call   4323 <write>
    38d5:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    38d8:	83 ec 0c             	sub    $0xc,%esp
    38db:	68 e8 03 00 00       	push   $0x3e8
    38e0:	e8 ae 0a 00 00       	call   4393 <sleep>
    38e5:	83 c4 10             	add    $0x10,%esp
    38e8:	eb ee                	jmp    38d8 <sbrktest+0x446>
    }
    if(pids[i] != -1)
    38ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    38ed:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    38f1:	83 f8 ff             	cmp    $0xffffffff,%eax
    38f4:	74 15                	je     390b <sbrktest+0x479>
      read(fds[0], &scratch, 1);
    38f6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    38f9:	83 ec 04             	sub    $0x4,%esp
    38fc:	6a 01                	push   $0x1
    38fe:	8d 55 9f             	lea    -0x61(%ebp),%edx
    3901:	52                   	push   %edx
    3902:	50                   	push   %eax
    3903:	e8 13 0a 00 00       	call   431b <read>
    3908:	83 c4 10             	add    $0x10,%esp
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit(EXIT_STATUS_OK);
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    390b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    390f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3912:	83 f8 09             	cmp    $0x9,%eax
    3915:	0f 86 6c ff ff ff    	jbe    3887 <sbrktest+0x3f5>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    391b:	83 ec 0c             	sub    $0xc,%esp
    391e:	68 00 10 00 00       	push   $0x1000
    3923:	e8 63 0a 00 00       	call   438b <sbrk>
    3928:	83 c4 10             	add    $0x10,%esp
    392b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    392e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3935:	eb 32                	jmp    3969 <sbrktest+0x4d7>
    if(pids[i] == -1)
    3937:	8b 45 f0             	mov    -0x10(%ebp),%eax
    393a:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    393e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3941:	75 02                	jne    3945 <sbrktest+0x4b3>
      continue;
    3943:	eb 20                	jmp    3965 <sbrktest+0x4d3>
    kill(pids[i]);
    3945:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3948:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    394c:	83 ec 0c             	sub    $0xc,%esp
    394f:	50                   	push   %eax
    3950:	e8 de 09 00 00       	call   4333 <kill>
    3955:	83 c4 10             	add    $0x10,%esp
    wait(0);
    3958:	83 ec 0c             	sub    $0xc,%esp
    395b:	6a 00                	push   $0x0
    395d:	e8 a9 09 00 00       	call   430b <wait>
    3962:	83 c4 10             	add    $0x10,%esp
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3965:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3969:	8b 45 f0             	mov    -0x10(%ebp),%eax
    396c:	83 f8 09             	cmp    $0x9,%eax
    396f:	76 c6                	jbe    3937 <sbrktest+0x4a5>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait(0);
  }
  if(c == (char*)0xffffffff){
    3971:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    3975:	75 20                	jne    3997 <sbrktest+0x505>
    printf(stdout, "failed sbrk leaked memory\n");
    3977:	a1 f0 66 00 00       	mov    0x66f0,%eax
    397c:	83 ec 08             	sub    $0x8,%esp
    397f:	68 9a 5d 00 00       	push   $0x5d9a
    3984:	50                   	push   %eax
    3985:	e8 f6 0a 00 00       	call   4480 <printf>
    398a:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    398d:	83 ec 0c             	sub    $0xc,%esp
    3990:	6a 01                	push   $0x1
    3992:	e8 6c 09 00 00       	call   4303 <exit>
  }

  if(sbrk(0) > oldbrk)
    3997:	83 ec 0c             	sub    $0xc,%esp
    399a:	6a 00                	push   $0x0
    399c:	e8 ea 09 00 00       	call   438b <sbrk>
    39a1:	83 c4 10             	add    $0x10,%esp
    39a4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    39a7:	76 20                	jbe    39c9 <sbrktest+0x537>
    sbrk(-(sbrk(0) - oldbrk));
    39a9:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    39ac:	83 ec 0c             	sub    $0xc,%esp
    39af:	6a 00                	push   $0x0
    39b1:	e8 d5 09 00 00       	call   438b <sbrk>
    39b6:	83 c4 10             	add    $0x10,%esp
    39b9:	29 c3                	sub    %eax,%ebx
    39bb:	89 d8                	mov    %ebx,%eax
    39bd:	83 ec 0c             	sub    $0xc,%esp
    39c0:	50                   	push   %eax
    39c1:	e8 c5 09 00 00       	call   438b <sbrk>
    39c6:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    39c9:	a1 f0 66 00 00       	mov    0x66f0,%eax
    39ce:	83 ec 08             	sub    $0x8,%esp
    39d1:	68 b5 5d 00 00       	push   $0x5db5
    39d6:	50                   	push   %eax
    39d7:	e8 a4 0a 00 00       	call   4480 <printf>
    39dc:	83 c4 10             	add    $0x10,%esp
}
    39df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    39e2:	c9                   	leave  
    39e3:	c3                   	ret    

000039e4 <validateint>:

void
validateint(int *p)
{
    39e4:	55                   	push   %ebp
    39e5:	89 e5                	mov    %esp,%ebp
    39e7:	53                   	push   %ebx
    39e8:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    39eb:	b8 0d 00 00 00       	mov    $0xd,%eax
    39f0:	8b 55 08             	mov    0x8(%ebp),%edx
    39f3:	89 d1                	mov    %edx,%ecx
    39f5:	89 e3                	mov    %esp,%ebx
    39f7:	89 cc                	mov    %ecx,%esp
    39f9:	cd 40                	int    $0x40
    39fb:	89 dc                	mov    %ebx,%esp
    39fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3a00:	83 c4 10             	add    $0x10,%esp
    3a03:	5b                   	pop    %ebx
    3a04:	5d                   	pop    %ebp
    3a05:	c3                   	ret    

00003a06 <validatetest>:

void
validatetest(void)
{
    3a06:	55                   	push   %ebp
    3a07:	89 e5                	mov    %esp,%ebp
    3a09:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3a0c:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3a11:	83 ec 08             	sub    $0x8,%esp
    3a14:	68 c3 5d 00 00       	push   $0x5dc3
    3a19:	50                   	push   %eax
    3a1a:	e8 61 0a 00 00       	call   4480 <printf>
    3a1f:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    3a22:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    3a29:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3a30:	e9 9c 00 00 00       	jmp    3ad1 <validatetest+0xcb>
    if((pid = fork()) == 0){
    3a35:	e8 c1 08 00 00       	call   42fb <fork>
    3a3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3a3d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3a41:	75 19                	jne    3a5c <validatetest+0x56>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    3a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3a46:	83 ec 0c             	sub    $0xc,%esp
    3a49:	50                   	push   %eax
    3a4a:	e8 95 ff ff ff       	call   39e4 <validateint>
    3a4f:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    3a52:	83 ec 0c             	sub    $0xc,%esp
    3a55:	6a 01                	push   $0x1
    3a57:	e8 a7 08 00 00       	call   4303 <exit>
    }
    sleep(0);
    3a5c:	83 ec 0c             	sub    $0xc,%esp
    3a5f:	6a 00                	push   $0x0
    3a61:	e8 2d 09 00 00       	call   4393 <sleep>
    3a66:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    3a69:	83 ec 0c             	sub    $0xc,%esp
    3a6c:	6a 00                	push   $0x0
    3a6e:	e8 20 09 00 00       	call   4393 <sleep>
    3a73:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    3a76:	83 ec 0c             	sub    $0xc,%esp
    3a79:	ff 75 ec             	pushl  -0x14(%ebp)
    3a7c:	e8 b2 08 00 00       	call   4333 <kill>
    3a81:	83 c4 10             	add    $0x10,%esp
    wait(0);
    3a84:	83 ec 0c             	sub    $0xc,%esp
    3a87:	6a 00                	push   $0x0
    3a89:	e8 7d 08 00 00       	call   430b <wait>
    3a8e:	83 c4 10             	add    $0x10,%esp

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3a94:	83 ec 08             	sub    $0x8,%esp
    3a97:	50                   	push   %eax
    3a98:	68 d2 5d 00 00       	push   $0x5dd2
    3a9d:	e8 c1 08 00 00       	call   4363 <link>
    3aa2:	83 c4 10             	add    $0x10,%esp
    3aa5:	83 f8 ff             	cmp    $0xffffffff,%eax
    3aa8:	74 20                	je     3aca <validatetest+0xc4>
      printf(stdout, "link should not succeed\n");
    3aaa:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3aaf:	83 ec 08             	sub    $0x8,%esp
    3ab2:	68 dd 5d 00 00       	push   $0x5ddd
    3ab7:	50                   	push   %eax
    3ab8:	e8 c3 09 00 00       	call   4480 <printf>
    3abd:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    3ac0:	83 ec 0c             	sub    $0xc,%esp
    3ac3:	6a 01                	push   $0x1
    3ac5:	e8 39 08 00 00       	call   4303 <exit>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    3aca:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    3ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3ad4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3ad7:	0f 83 58 ff ff ff    	jae    3a35 <validatetest+0x2f>
      printf(stdout, "link should not succeed\n");
      exit(EXIT_STATUS_OK);
    }
  }

  printf(stdout, "validate ok\n");
    3add:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3ae2:	83 ec 08             	sub    $0x8,%esp
    3ae5:	68 f6 5d 00 00       	push   $0x5df6
    3aea:	50                   	push   %eax
    3aeb:	e8 90 09 00 00       	call   4480 <printf>
    3af0:	83 c4 10             	add    $0x10,%esp
}
    3af3:	c9                   	leave  
    3af4:	c3                   	ret    

00003af5 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3af5:	55                   	push   %ebp
    3af6:	89 e5                	mov    %esp,%ebp
    3af8:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    3afb:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3b00:	83 ec 08             	sub    $0x8,%esp
    3b03:	68 03 5e 00 00       	push   $0x5e03
    3b08:	50                   	push   %eax
    3b09:	e8 72 09 00 00       	call   4480 <printf>
    3b0e:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3b11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3b18:	eb 33                	jmp    3b4d <bsstest+0x58>
    if(uninit[i] != '\0'){
    3b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b1d:	05 00 68 00 00       	add    $0x6800,%eax
    3b22:	0f b6 00             	movzbl (%eax),%eax
    3b25:	84 c0                	test   %al,%al
    3b27:	74 20                	je     3b49 <bsstest+0x54>
      printf(stdout, "bss test failed\n");
    3b29:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3b2e:	83 ec 08             	sub    $0x8,%esp
    3b31:	68 0d 5e 00 00       	push   $0x5e0d
    3b36:	50                   	push   %eax
    3b37:	e8 44 09 00 00       	call   4480 <printf>
    3b3c:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
    3b3f:	83 ec 0c             	sub    $0xc,%esp
    3b42:	6a 01                	push   $0x1
    3b44:	e8 ba 07 00 00       	call   4303 <exit>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    3b49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b50:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3b55:	76 c3                	jbe    3b1a <bsstest+0x25>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit(EXIT_STATUS_OK);
    }
  }
  printf(stdout, "bss test ok\n");
    3b57:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3b5c:	83 ec 08             	sub    $0x8,%esp
    3b5f:	68 1e 5e 00 00       	push   $0x5e1e
    3b64:	50                   	push   %eax
    3b65:	e8 16 09 00 00       	call   4480 <printf>
    3b6a:	83 c4 10             	add    $0x10,%esp
}
    3b6d:	c9                   	leave  
    3b6e:	c3                   	ret    

00003b6f <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3b6f:	55                   	push   %ebp
    3b70:	89 e5                	mov    %esp,%ebp
    3b72:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3b75:	83 ec 0c             	sub    $0xc,%esp
    3b78:	68 2b 5e 00 00       	push   $0x5e2b
    3b7d:	e8 d1 07 00 00       	call   4353 <unlink>
    3b82:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    3b85:	e8 71 07 00 00       	call   42fb <fork>
    3b8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    3b8d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3b91:	0f 85 9c 00 00 00    	jne    3c33 <bigargtest+0xc4>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3b97:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3b9e:	eb 12                	jmp    3bb2 <bigargtest+0x43>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ba3:	c7 04 85 40 67 00 00 	movl   $0x5e38,0x6740(,%eax,4)
    3baa:	38 5e 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3bae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3bb2:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    3bb6:	7e e8                	jle    3ba0 <bigargtest+0x31>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    3bb8:	c7 05 bc 67 00 00 00 	movl   $0x0,0x67bc
    3bbf:	00 00 00 
    printf(stdout, "bigarg test\n");
    3bc2:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3bc7:	83 ec 08             	sub    $0x8,%esp
    3bca:	68 15 5f 00 00       	push   $0x5f15
    3bcf:	50                   	push   %eax
    3bd0:	e8 ab 08 00 00       	call   4480 <printf>
    3bd5:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    3bd8:	83 ec 08             	sub    $0x8,%esp
    3bdb:	68 40 67 00 00       	push   $0x6740
    3be0:	68 34 48 00 00       	push   $0x4834
    3be5:	e8 51 07 00 00       	call   433b <exec>
    3bea:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    3bed:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3bf2:	83 ec 08             	sub    $0x8,%esp
    3bf5:	68 22 5f 00 00       	push   $0x5f22
    3bfa:	50                   	push   %eax
    3bfb:	e8 80 08 00 00       	call   4480 <printf>
    3c00:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    3c03:	83 ec 08             	sub    $0x8,%esp
    3c06:	68 00 02 00 00       	push   $0x200
    3c0b:	68 2b 5e 00 00       	push   $0x5e2b
    3c10:	e8 2e 07 00 00       	call   4343 <open>
    3c15:	83 c4 10             	add    $0x10,%esp
    3c18:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    3c1b:	83 ec 0c             	sub    $0xc,%esp
    3c1e:	ff 75 ec             	pushl  -0x14(%ebp)
    3c21:	e8 05 07 00 00       	call   432b <close>
    3c26:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3c29:	83 ec 0c             	sub    $0xc,%esp
    3c2c:	6a 01                	push   $0x1
    3c2e:	e8 d0 06 00 00       	call   4303 <exit>
  } else if(pid < 0){
    3c33:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3c37:	79 20                	jns    3c59 <bigargtest+0xea>
    printf(stdout, "bigargtest: fork failed\n");
    3c39:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3c3e:	83 ec 08             	sub    $0x8,%esp
    3c41:	68 32 5f 00 00       	push   $0x5f32
    3c46:	50                   	push   %eax
    3c47:	e8 34 08 00 00       	call   4480 <printf>
    3c4c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3c4f:	83 ec 0c             	sub    $0xc,%esp
    3c52:	6a 01                	push   $0x1
    3c54:	e8 aa 06 00 00       	call   4303 <exit>
  }
  wait(0);
    3c59:	83 ec 0c             	sub    $0xc,%esp
    3c5c:	6a 00                	push   $0x0
    3c5e:	e8 a8 06 00 00       	call   430b <wait>
    3c63:	83 c4 10             	add    $0x10,%esp
  fd = open("bigarg-ok", 0);
    3c66:	83 ec 08             	sub    $0x8,%esp
    3c69:	6a 00                	push   $0x0
    3c6b:	68 2b 5e 00 00       	push   $0x5e2b
    3c70:	e8 ce 06 00 00       	call   4343 <open>
    3c75:	83 c4 10             	add    $0x10,%esp
    3c78:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3c7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3c7f:	79 20                	jns    3ca1 <bigargtest+0x132>
    printf(stdout, "bigarg test failed!\n");
    3c81:	a1 f0 66 00 00       	mov    0x66f0,%eax
    3c86:	83 ec 08             	sub    $0x8,%esp
    3c89:	68 4b 5f 00 00       	push   $0x5f4b
    3c8e:	50                   	push   %eax
    3c8f:	e8 ec 07 00 00       	call   4480 <printf>
    3c94:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3c97:	83 ec 0c             	sub    $0xc,%esp
    3c9a:	6a 01                	push   $0x1
    3c9c:	e8 62 06 00 00       	call   4303 <exit>
  }
  close(fd);
    3ca1:	83 ec 0c             	sub    $0xc,%esp
    3ca4:	ff 75 ec             	pushl  -0x14(%ebp)
    3ca7:	e8 7f 06 00 00       	call   432b <close>
    3cac:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    3caf:	83 ec 0c             	sub    $0xc,%esp
    3cb2:	68 2b 5e 00 00       	push   $0x5e2b
    3cb7:	e8 97 06 00 00       	call   4353 <unlink>
    3cbc:	83 c4 10             	add    $0x10,%esp
}
    3cbf:	c9                   	leave  
    3cc0:	c3                   	ret    

00003cc1 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3cc1:	55                   	push   %ebp
    3cc2:	89 e5                	mov    %esp,%ebp
    3cc4:	53                   	push   %ebx
    3cc5:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    3cc8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    3ccf:	83 ec 08             	sub    $0x8,%esp
    3cd2:	68 60 5f 00 00       	push   $0x5f60
    3cd7:	6a 01                	push   $0x1
    3cd9:	e8 a2 07 00 00       	call   4480 <printf>
    3cde:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3ce1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    3ce8:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3cec:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3cef:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3cf4:	89 c8                	mov    %ecx,%eax
    3cf6:	f7 ea                	imul   %edx
    3cf8:	c1 fa 06             	sar    $0x6,%edx
    3cfb:	89 c8                	mov    %ecx,%eax
    3cfd:	c1 f8 1f             	sar    $0x1f,%eax
    3d00:	29 c2                	sub    %eax,%edx
    3d02:	89 d0                	mov    %edx,%eax
    3d04:	83 c0 30             	add    $0x30,%eax
    3d07:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3d0a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3d0d:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3d12:	89 d8                	mov    %ebx,%eax
    3d14:	f7 ea                	imul   %edx
    3d16:	c1 fa 06             	sar    $0x6,%edx
    3d19:	89 d8                	mov    %ebx,%eax
    3d1b:	c1 f8 1f             	sar    $0x1f,%eax
    3d1e:	89 d1                	mov    %edx,%ecx
    3d20:	29 c1                	sub    %eax,%ecx
    3d22:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3d28:	29 c3                	sub    %eax,%ebx
    3d2a:	89 d9                	mov    %ebx,%ecx
    3d2c:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3d31:	89 c8                	mov    %ecx,%eax
    3d33:	f7 ea                	imul   %edx
    3d35:	c1 fa 05             	sar    $0x5,%edx
    3d38:	89 c8                	mov    %ecx,%eax
    3d3a:	c1 f8 1f             	sar    $0x1f,%eax
    3d3d:	29 c2                	sub    %eax,%edx
    3d3f:	89 d0                	mov    %edx,%eax
    3d41:	83 c0 30             	add    $0x30,%eax
    3d44:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3d47:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3d4a:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3d4f:	89 d8                	mov    %ebx,%eax
    3d51:	f7 ea                	imul   %edx
    3d53:	c1 fa 05             	sar    $0x5,%edx
    3d56:	89 d8                	mov    %ebx,%eax
    3d58:	c1 f8 1f             	sar    $0x1f,%eax
    3d5b:	89 d1                	mov    %edx,%ecx
    3d5d:	29 c1                	sub    %eax,%ecx
    3d5f:	6b c1 64             	imul   $0x64,%ecx,%eax
    3d62:	29 c3                	sub    %eax,%ebx
    3d64:	89 d9                	mov    %ebx,%ecx
    3d66:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3d6b:	89 c8                	mov    %ecx,%eax
    3d6d:	f7 ea                	imul   %edx
    3d6f:	c1 fa 02             	sar    $0x2,%edx
    3d72:	89 c8                	mov    %ecx,%eax
    3d74:	c1 f8 1f             	sar    $0x1f,%eax
    3d77:	29 c2                	sub    %eax,%edx
    3d79:	89 d0                	mov    %edx,%eax
    3d7b:	83 c0 30             	add    $0x30,%eax
    3d7e:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3d81:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3d84:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3d89:	89 c8                	mov    %ecx,%eax
    3d8b:	f7 ea                	imul   %edx
    3d8d:	c1 fa 02             	sar    $0x2,%edx
    3d90:	89 c8                	mov    %ecx,%eax
    3d92:	c1 f8 1f             	sar    $0x1f,%eax
    3d95:	29 c2                	sub    %eax,%edx
    3d97:	89 d0                	mov    %edx,%eax
    3d99:	c1 e0 02             	shl    $0x2,%eax
    3d9c:	01 d0                	add    %edx,%eax
    3d9e:	01 c0                	add    %eax,%eax
    3da0:	29 c1                	sub    %eax,%ecx
    3da2:	89 ca                	mov    %ecx,%edx
    3da4:	89 d0                	mov    %edx,%eax
    3da6:	83 c0 30             	add    $0x30,%eax
    3da9:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3dac:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    3db0:	83 ec 04             	sub    $0x4,%esp
    3db3:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3db6:	50                   	push   %eax
    3db7:	68 6d 5f 00 00       	push   $0x5f6d
    3dbc:	6a 01                	push   $0x1
    3dbe:	e8 bd 06 00 00       	call   4480 <printf>
    3dc3:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3dc6:	83 ec 08             	sub    $0x8,%esp
    3dc9:	68 02 02 00 00       	push   $0x202
    3dce:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3dd1:	50                   	push   %eax
    3dd2:	e8 6c 05 00 00       	call   4343 <open>
    3dd7:	83 c4 10             	add    $0x10,%esp
    3dda:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    3ddd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3de1:	79 18                	jns    3dfb <fsfull+0x13a>
      printf(1, "open %s failed\n", name);
    3de3:	83 ec 04             	sub    $0x4,%esp
    3de6:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3de9:	50                   	push   %eax
    3dea:	68 79 5f 00 00       	push   $0x5f79
    3def:	6a 01                	push   $0x1
    3df1:	e8 8a 06 00 00       	call   4480 <printf>
    3df6:	83 c4 10             	add    $0x10,%esp
      break;
    3df9:	eb 6e                	jmp    3e69 <fsfull+0x1a8>
    }
    int total = 0;
    3dfb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    3e02:	83 ec 04             	sub    $0x4,%esp
    3e05:	68 00 02 00 00       	push   $0x200
    3e0a:	68 40 8f 00 00       	push   $0x8f40
    3e0f:	ff 75 e8             	pushl  -0x18(%ebp)
    3e12:	e8 0c 05 00 00       	call   4323 <write>
    3e17:	83 c4 10             	add    $0x10,%esp
    3e1a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    3e1d:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    3e24:	7f 2c                	jg     3e52 <fsfull+0x191>
        break;
    3e26:	90                   	nop
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3e27:	83 ec 04             	sub    $0x4,%esp
    3e2a:	ff 75 ec             	pushl  -0x14(%ebp)
    3e2d:	68 89 5f 00 00       	push   $0x5f89
    3e32:	6a 01                	push   $0x1
    3e34:	e8 47 06 00 00       	call   4480 <printf>
    3e39:	83 c4 10             	add    $0x10,%esp
    close(fd);
    3e3c:	83 ec 0c             	sub    $0xc,%esp
    3e3f:	ff 75 e8             	pushl  -0x18(%ebp)
    3e42:	e8 e4 04 00 00       	call   432b <close>
    3e47:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    3e4a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3e4e:	75 10                	jne    3e60 <fsfull+0x19f>
    3e50:	eb 0c                	jmp    3e5e <fsfull+0x19d>
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    3e52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3e55:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    3e58:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    }
    3e5c:	eb a4                	jmp    3e02 <fsfull+0x141>
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
    3e5e:	eb 09                	jmp    3e69 <fsfull+0x1a8>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3e60:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3e64:	e9 7f fe ff ff       	jmp    3ce8 <fsfull+0x27>

  while(nfiles >= 0){
    3e69:	e9 db 00 00 00       	jmp    3f49 <fsfull+0x288>
    char name[64];
    name[0] = 'f';
    3e6e:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3e72:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3e75:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3e7a:	89 c8                	mov    %ecx,%eax
    3e7c:	f7 ea                	imul   %edx
    3e7e:	c1 fa 06             	sar    $0x6,%edx
    3e81:	89 c8                	mov    %ecx,%eax
    3e83:	c1 f8 1f             	sar    $0x1f,%eax
    3e86:	29 c2                	sub    %eax,%edx
    3e88:	89 d0                	mov    %edx,%eax
    3e8a:	83 c0 30             	add    $0x30,%eax
    3e8d:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3e90:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3e93:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3e98:	89 d8                	mov    %ebx,%eax
    3e9a:	f7 ea                	imul   %edx
    3e9c:	c1 fa 06             	sar    $0x6,%edx
    3e9f:	89 d8                	mov    %ebx,%eax
    3ea1:	c1 f8 1f             	sar    $0x1f,%eax
    3ea4:	89 d1                	mov    %edx,%ecx
    3ea6:	29 c1                	sub    %eax,%ecx
    3ea8:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3eae:	29 c3                	sub    %eax,%ebx
    3eb0:	89 d9                	mov    %ebx,%ecx
    3eb2:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3eb7:	89 c8                	mov    %ecx,%eax
    3eb9:	f7 ea                	imul   %edx
    3ebb:	c1 fa 05             	sar    $0x5,%edx
    3ebe:	89 c8                	mov    %ecx,%eax
    3ec0:	c1 f8 1f             	sar    $0x1f,%eax
    3ec3:	29 c2                	sub    %eax,%edx
    3ec5:	89 d0                	mov    %edx,%eax
    3ec7:	83 c0 30             	add    $0x30,%eax
    3eca:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3ecd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3ed0:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3ed5:	89 d8                	mov    %ebx,%eax
    3ed7:	f7 ea                	imul   %edx
    3ed9:	c1 fa 05             	sar    $0x5,%edx
    3edc:	89 d8                	mov    %ebx,%eax
    3ede:	c1 f8 1f             	sar    $0x1f,%eax
    3ee1:	89 d1                	mov    %edx,%ecx
    3ee3:	29 c1                	sub    %eax,%ecx
    3ee5:	6b c1 64             	imul   $0x64,%ecx,%eax
    3ee8:	29 c3                	sub    %eax,%ebx
    3eea:	89 d9                	mov    %ebx,%ecx
    3eec:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3ef1:	89 c8                	mov    %ecx,%eax
    3ef3:	f7 ea                	imul   %edx
    3ef5:	c1 fa 02             	sar    $0x2,%edx
    3ef8:	89 c8                	mov    %ecx,%eax
    3efa:	c1 f8 1f             	sar    $0x1f,%eax
    3efd:	29 c2                	sub    %eax,%edx
    3eff:	89 d0                	mov    %edx,%eax
    3f01:	83 c0 30             	add    $0x30,%eax
    3f04:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3f07:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3f0a:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3f0f:	89 c8                	mov    %ecx,%eax
    3f11:	f7 ea                	imul   %edx
    3f13:	c1 fa 02             	sar    $0x2,%edx
    3f16:	89 c8                	mov    %ecx,%eax
    3f18:	c1 f8 1f             	sar    $0x1f,%eax
    3f1b:	29 c2                	sub    %eax,%edx
    3f1d:	89 d0                	mov    %edx,%eax
    3f1f:	c1 e0 02             	shl    $0x2,%eax
    3f22:	01 d0                	add    %edx,%eax
    3f24:	01 c0                	add    %eax,%eax
    3f26:	29 c1                	sub    %eax,%ecx
    3f28:	89 ca                	mov    %ecx,%edx
    3f2a:	89 d0                	mov    %edx,%eax
    3f2c:	83 c0 30             	add    $0x30,%eax
    3f2f:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3f32:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    3f36:	83 ec 0c             	sub    $0xc,%esp
    3f39:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3f3c:	50                   	push   %eax
    3f3d:	e8 11 04 00 00       	call   4353 <unlink>
    3f42:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    3f45:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    3f49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3f4d:	0f 89 1b ff ff ff    	jns    3e6e <fsfull+0x1ad>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3f53:	83 ec 08             	sub    $0x8,%esp
    3f56:	68 99 5f 00 00       	push   $0x5f99
    3f5b:	6a 01                	push   $0x1
    3f5d:	e8 1e 05 00 00       	call   4480 <printf>
    3f62:	83 c4 10             	add    $0x10,%esp
}
    3f65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3f68:	c9                   	leave  
    3f69:	c3                   	ret    

00003f6a <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3f6a:	55                   	push   %ebp
    3f6b:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3f6d:	a1 f4 66 00 00       	mov    0x66f4,%eax
    3f72:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    3f78:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3f7d:	a3 f4 66 00 00       	mov    %eax,0x66f4
  return randstate;
    3f82:	a1 f4 66 00 00       	mov    0x66f4,%eax
}
    3f87:	5d                   	pop    %ebp
    3f88:	c3                   	ret    

00003f89 <main>:

int
main(int argc, char *argv[])
{
    3f89:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3f8d:	83 e4 f0             	and    $0xfffffff0,%esp
    3f90:	ff 71 fc             	pushl  -0x4(%ecx)
    3f93:	55                   	push   %ebp
    3f94:	89 e5                	mov    %esp,%ebp
    3f96:	51                   	push   %ecx
    3f97:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    3f9a:	83 ec 08             	sub    $0x8,%esp
    3f9d:	68 af 5f 00 00       	push   $0x5faf
    3fa2:	6a 01                	push   $0x1
    3fa4:	e8 d7 04 00 00       	call   4480 <printf>
    3fa9:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    3fac:	83 ec 08             	sub    $0x8,%esp
    3faf:	6a 00                	push   $0x0
    3fb1:	68 c3 5f 00 00       	push   $0x5fc3
    3fb6:	e8 88 03 00 00       	call   4343 <open>
    3fbb:	83 c4 10             	add    $0x10,%esp
    3fbe:	85 c0                	test   %eax,%eax
    3fc0:	78 1c                	js     3fde <main+0x55>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3fc2:	83 ec 08             	sub    $0x8,%esp
    3fc5:	68 d4 5f 00 00       	push   $0x5fd4
    3fca:	6a 01                	push   $0x1
    3fcc:	e8 af 04 00 00       	call   4480 <printf>
    3fd1:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
    3fd4:	83 ec 0c             	sub    $0xc,%esp
    3fd7:	6a 01                	push   $0x1
    3fd9:	e8 25 03 00 00       	call   4303 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3fde:	83 ec 08             	sub    $0x8,%esp
    3fe1:	68 00 02 00 00       	push   $0x200
    3fe6:	68 c3 5f 00 00       	push   $0x5fc3
    3feb:	e8 53 03 00 00       	call   4343 <open>
    3ff0:	83 c4 10             	add    $0x10,%esp
    3ff3:	83 ec 0c             	sub    $0xc,%esp
    3ff6:	50                   	push   %eax
    3ff7:	e8 2f 03 00 00       	call   432b <close>
    3ffc:	83 c4 10             	add    $0x10,%esp

  createdelete();
    3fff:	e8 f2 d3 ff ff       	call   13f6 <createdelete>
  linkunlink();
    4004:	e8 b7 de ff ff       	call   1ec0 <linkunlink>
  concreate();
    4009:	e8 cc da ff ff       	call   1ada <concreate>
  fourfiles();
    400e:	e8 6d d1 ff ff       	call   1180 <fourfiles>
  sharedfd();
    4013:	e8 73 cf ff ff       	call   f8b <sharedfd>

  bigargtest();
    4018:	e8 52 fb ff ff       	call   3b6f <bigargtest>
  bigwrite();
    401d:	e8 67 e9 ff ff       	call   2989 <bigwrite>
  bigargtest();
    4022:	e8 48 fb ff ff       	call   3b6f <bigargtest>
  bsstest();
    4027:	e8 c9 fa ff ff       	call   3af5 <bsstest>
  sbrktest();
    402c:	e8 61 f4 ff ff       	call   3492 <sbrktest>
  validatetest();
    4031:	e8 d0 f9 ff ff       	call   3a06 <validatetest>

  opentest();
    4036:	e8 17 c3 ff ff       	call   352 <opentest>
  writetest();
    403b:	e8 ca c3 ff ff       	call   40a <writetest>
  writetest1();
    4040:	e8 f6 c5 ff ff       	call   63b <writetest1>
  createtest();
    4045:	e8 15 c8 ff ff       	call   85f <createtest>

  openiputtest();
    404a:	e8 d4 c1 ff ff       	call   223 <openiputtest>
  exitiputtest();
    404f:	e8 b0 c0 ff ff       	call   104 <exitiputtest>
  iputtest();
    4054:	e8 a7 bf ff ff       	call   0 <iputtest>

  mem();
    4059:	e8 2b ce ff ff       	call   e89 <mem>
  pipe1();
    405e:	e8 19 ca ff ff       	call   a7c <pipe1>
  preempt();
    4063:	e8 1e cc ff ff       	call   c86 <preempt>
  exitwait();
    4068:	e8 97 cd ff ff       	call   e04 <exitwait>

  rmdot();
    406d:	e8 da ed ff ff       	call   2e4c <rmdot>
  fourteen();
    4072:	e8 5c ec ff ff       	call   2cd3 <fourteen>
  bigfile();
    4077:	e8 14 ea ff ff       	call   2a90 <bigfile>
  subdir();
    407c:	e8 0c e1 ff ff       	call   218d <subdir>
  linktest();
    4081:	e8 e6 d7 ff ff       	call   186c <linktest>
  unlinkread();
    4086:	e8 02 d6 ff ff       	call   168d <unlinkread>
  dirfile();
    408b:	e8 68 ef ff ff       	call   2ff8 <dirfile>
  iref();
    4090:	e8 cc f1 ff ff       	call   3261 <iref>
  forktest();
    4095:	e8 0a f3 ff ff       	call   33a4 <forktest>
  bigdir(); // slow
    409a:	e8 6b df ff ff       	call   200a <bigdir>
  exectest();
    409f:	e8 81 c9 ff ff       	call   a25 <exectest>

  exit(EXIT_STATUS_OK);
    40a4:	83 ec 0c             	sub    $0xc,%esp
    40a7:	6a 01                	push   $0x1
    40a9:	e8 55 02 00 00       	call   4303 <exit>

000040ae <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    40ae:	55                   	push   %ebp
    40af:	89 e5                	mov    %esp,%ebp
    40b1:	57                   	push   %edi
    40b2:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    40b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    40b6:	8b 55 10             	mov    0x10(%ebp),%edx
    40b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    40bc:	89 cb                	mov    %ecx,%ebx
    40be:	89 df                	mov    %ebx,%edi
    40c0:	89 d1                	mov    %edx,%ecx
    40c2:	fc                   	cld    
    40c3:	f3 aa                	rep stos %al,%es:(%edi)
    40c5:	89 ca                	mov    %ecx,%edx
    40c7:	89 fb                	mov    %edi,%ebx
    40c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
    40cc:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    40cf:	5b                   	pop    %ebx
    40d0:	5f                   	pop    %edi
    40d1:	5d                   	pop    %ebp
    40d2:	c3                   	ret    

000040d3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    40d3:	55                   	push   %ebp
    40d4:	89 e5                	mov    %esp,%ebp
    40d6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    40d9:	8b 45 08             	mov    0x8(%ebp),%eax
    40dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    40df:	90                   	nop
    40e0:	8b 45 08             	mov    0x8(%ebp),%eax
    40e3:	8d 50 01             	lea    0x1(%eax),%edx
    40e6:	89 55 08             	mov    %edx,0x8(%ebp)
    40e9:	8b 55 0c             	mov    0xc(%ebp),%edx
    40ec:	8d 4a 01             	lea    0x1(%edx),%ecx
    40ef:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    40f2:	0f b6 12             	movzbl (%edx),%edx
    40f5:	88 10                	mov    %dl,(%eax)
    40f7:	0f b6 00             	movzbl (%eax),%eax
    40fa:	84 c0                	test   %al,%al
    40fc:	75 e2                	jne    40e0 <strcpy+0xd>
    ;
  return os;
    40fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4101:	c9                   	leave  
    4102:	c3                   	ret    

00004103 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4103:	55                   	push   %ebp
    4104:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    4106:	eb 08                	jmp    4110 <strcmp+0xd>
    p++, q++;
    4108:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    410c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4110:	8b 45 08             	mov    0x8(%ebp),%eax
    4113:	0f b6 00             	movzbl (%eax),%eax
    4116:	84 c0                	test   %al,%al
    4118:	74 10                	je     412a <strcmp+0x27>
    411a:	8b 45 08             	mov    0x8(%ebp),%eax
    411d:	0f b6 10             	movzbl (%eax),%edx
    4120:	8b 45 0c             	mov    0xc(%ebp),%eax
    4123:	0f b6 00             	movzbl (%eax),%eax
    4126:	38 c2                	cmp    %al,%dl
    4128:	74 de                	je     4108 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    412a:	8b 45 08             	mov    0x8(%ebp),%eax
    412d:	0f b6 00             	movzbl (%eax),%eax
    4130:	0f b6 d0             	movzbl %al,%edx
    4133:	8b 45 0c             	mov    0xc(%ebp),%eax
    4136:	0f b6 00             	movzbl (%eax),%eax
    4139:	0f b6 c0             	movzbl %al,%eax
    413c:	29 c2                	sub    %eax,%edx
    413e:	89 d0                	mov    %edx,%eax
}
    4140:	5d                   	pop    %ebp
    4141:	c3                   	ret    

00004142 <strlen>:

uint
strlen(char *s)
{
    4142:	55                   	push   %ebp
    4143:	89 e5                	mov    %esp,%ebp
    4145:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    4148:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    414f:	eb 04                	jmp    4155 <strlen+0x13>
    4151:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    4155:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4158:	8b 45 08             	mov    0x8(%ebp),%eax
    415b:	01 d0                	add    %edx,%eax
    415d:	0f b6 00             	movzbl (%eax),%eax
    4160:	84 c0                	test   %al,%al
    4162:	75 ed                	jne    4151 <strlen+0xf>
    ;
  return n;
    4164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4167:	c9                   	leave  
    4168:	c3                   	ret    

00004169 <memset>:

void*
memset(void *dst, int c, uint n)
{
    4169:	55                   	push   %ebp
    416a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    416c:	8b 45 10             	mov    0x10(%ebp),%eax
    416f:	50                   	push   %eax
    4170:	ff 75 0c             	pushl  0xc(%ebp)
    4173:	ff 75 08             	pushl  0x8(%ebp)
    4176:	e8 33 ff ff ff       	call   40ae <stosb>
    417b:	83 c4 0c             	add    $0xc,%esp
  return dst;
    417e:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4181:	c9                   	leave  
    4182:	c3                   	ret    

00004183 <strchr>:

char*
strchr(const char *s, char c)
{
    4183:	55                   	push   %ebp
    4184:	89 e5                	mov    %esp,%ebp
    4186:	83 ec 04             	sub    $0x4,%esp
    4189:	8b 45 0c             	mov    0xc(%ebp),%eax
    418c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    418f:	eb 14                	jmp    41a5 <strchr+0x22>
    if(*s == c)
    4191:	8b 45 08             	mov    0x8(%ebp),%eax
    4194:	0f b6 00             	movzbl (%eax),%eax
    4197:	3a 45 fc             	cmp    -0x4(%ebp),%al
    419a:	75 05                	jne    41a1 <strchr+0x1e>
      return (char*)s;
    419c:	8b 45 08             	mov    0x8(%ebp),%eax
    419f:	eb 13                	jmp    41b4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    41a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    41a5:	8b 45 08             	mov    0x8(%ebp),%eax
    41a8:	0f b6 00             	movzbl (%eax),%eax
    41ab:	84 c0                	test   %al,%al
    41ad:	75 e2                	jne    4191 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    41af:	b8 00 00 00 00       	mov    $0x0,%eax
}
    41b4:	c9                   	leave  
    41b5:	c3                   	ret    

000041b6 <gets>:

char*
gets(char *buf, int max)
{
    41b6:	55                   	push   %ebp
    41b7:	89 e5                	mov    %esp,%ebp
    41b9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    41bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    41c3:	eb 44                	jmp    4209 <gets+0x53>
    cc = read(0, &c, 1);
    41c5:	83 ec 04             	sub    $0x4,%esp
    41c8:	6a 01                	push   $0x1
    41ca:	8d 45 ef             	lea    -0x11(%ebp),%eax
    41cd:	50                   	push   %eax
    41ce:	6a 00                	push   $0x0
    41d0:	e8 46 01 00 00       	call   431b <read>
    41d5:	83 c4 10             	add    $0x10,%esp
    41d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    41db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    41df:	7f 02                	jg     41e3 <gets+0x2d>
      break;
    41e1:	eb 31                	jmp    4214 <gets+0x5e>
    buf[i++] = c;
    41e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41e6:	8d 50 01             	lea    0x1(%eax),%edx
    41e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
    41ec:	89 c2                	mov    %eax,%edx
    41ee:	8b 45 08             	mov    0x8(%ebp),%eax
    41f1:	01 c2                	add    %eax,%edx
    41f3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    41f7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    41f9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    41fd:	3c 0a                	cmp    $0xa,%al
    41ff:	74 13                	je     4214 <gets+0x5e>
    4201:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4205:	3c 0d                	cmp    $0xd,%al
    4207:	74 0b                	je     4214 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4209:	8b 45 f4             	mov    -0xc(%ebp),%eax
    420c:	83 c0 01             	add    $0x1,%eax
    420f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    4212:	7c b1                	jl     41c5 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    4214:	8b 55 f4             	mov    -0xc(%ebp),%edx
    4217:	8b 45 08             	mov    0x8(%ebp),%eax
    421a:	01 d0                	add    %edx,%eax
    421c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    421f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4222:	c9                   	leave  
    4223:	c3                   	ret    

00004224 <stat>:

int
stat(char *n, struct stat *st)
{
    4224:	55                   	push   %ebp
    4225:	89 e5                	mov    %esp,%ebp
    4227:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    422a:	83 ec 08             	sub    $0x8,%esp
    422d:	6a 00                	push   $0x0
    422f:	ff 75 08             	pushl  0x8(%ebp)
    4232:	e8 0c 01 00 00       	call   4343 <open>
    4237:	83 c4 10             	add    $0x10,%esp
    423a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    423d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4241:	79 07                	jns    424a <stat+0x26>
    return -1;
    4243:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    4248:	eb 25                	jmp    426f <stat+0x4b>
  r = fstat(fd, st);
    424a:	83 ec 08             	sub    $0x8,%esp
    424d:	ff 75 0c             	pushl  0xc(%ebp)
    4250:	ff 75 f4             	pushl  -0xc(%ebp)
    4253:	e8 03 01 00 00       	call   435b <fstat>
    4258:	83 c4 10             	add    $0x10,%esp
    425b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    425e:	83 ec 0c             	sub    $0xc,%esp
    4261:	ff 75 f4             	pushl  -0xc(%ebp)
    4264:	e8 c2 00 00 00       	call   432b <close>
    4269:	83 c4 10             	add    $0x10,%esp
  return r;
    426c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    426f:	c9                   	leave  
    4270:	c3                   	ret    

00004271 <atoi>:

int
atoi(const char *s)
{
    4271:	55                   	push   %ebp
    4272:	89 e5                	mov    %esp,%ebp
    4274:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    4277:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    427e:	eb 25                	jmp    42a5 <atoi+0x34>
    n = n*10 + *s++ - '0';
    4280:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4283:	89 d0                	mov    %edx,%eax
    4285:	c1 e0 02             	shl    $0x2,%eax
    4288:	01 d0                	add    %edx,%eax
    428a:	01 c0                	add    %eax,%eax
    428c:	89 c1                	mov    %eax,%ecx
    428e:	8b 45 08             	mov    0x8(%ebp),%eax
    4291:	8d 50 01             	lea    0x1(%eax),%edx
    4294:	89 55 08             	mov    %edx,0x8(%ebp)
    4297:	0f b6 00             	movzbl (%eax),%eax
    429a:	0f be c0             	movsbl %al,%eax
    429d:	01 c8                	add    %ecx,%eax
    429f:	83 e8 30             	sub    $0x30,%eax
    42a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    42a5:	8b 45 08             	mov    0x8(%ebp),%eax
    42a8:	0f b6 00             	movzbl (%eax),%eax
    42ab:	3c 2f                	cmp    $0x2f,%al
    42ad:	7e 0a                	jle    42b9 <atoi+0x48>
    42af:	8b 45 08             	mov    0x8(%ebp),%eax
    42b2:	0f b6 00             	movzbl (%eax),%eax
    42b5:	3c 39                	cmp    $0x39,%al
    42b7:	7e c7                	jle    4280 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    42b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    42bc:	c9                   	leave  
    42bd:	c3                   	ret    

000042be <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    42be:	55                   	push   %ebp
    42bf:	89 e5                	mov    %esp,%ebp
    42c1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    42c4:	8b 45 08             	mov    0x8(%ebp),%eax
    42c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    42ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    42cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    42d0:	eb 17                	jmp    42e9 <memmove+0x2b>
    *dst++ = *src++;
    42d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42d5:	8d 50 01             	lea    0x1(%eax),%edx
    42d8:	89 55 fc             	mov    %edx,-0x4(%ebp)
    42db:	8b 55 f8             	mov    -0x8(%ebp),%edx
    42de:	8d 4a 01             	lea    0x1(%edx),%ecx
    42e1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    42e4:	0f b6 12             	movzbl (%edx),%edx
    42e7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    42e9:	8b 45 10             	mov    0x10(%ebp),%eax
    42ec:	8d 50 ff             	lea    -0x1(%eax),%edx
    42ef:	89 55 10             	mov    %edx,0x10(%ebp)
    42f2:	85 c0                	test   %eax,%eax
    42f4:	7f dc                	jg     42d2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    42f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
    42f9:	c9                   	leave  
    42fa:	c3                   	ret    

000042fb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    42fb:	b8 01 00 00 00       	mov    $0x1,%eax
    4300:	cd 40                	int    $0x40
    4302:	c3                   	ret    

00004303 <exit>:
SYSCALL(exit)
    4303:	b8 02 00 00 00       	mov    $0x2,%eax
    4308:	cd 40                	int    $0x40
    430a:	c3                   	ret    

0000430b <wait>:
SYSCALL(wait)
    430b:	b8 03 00 00 00       	mov    $0x3,%eax
    4310:	cd 40                	int    $0x40
    4312:	c3                   	ret    

00004313 <pipe>:
SYSCALL(pipe)
    4313:	b8 04 00 00 00       	mov    $0x4,%eax
    4318:	cd 40                	int    $0x40
    431a:	c3                   	ret    

0000431b <read>:
SYSCALL(read)
    431b:	b8 05 00 00 00       	mov    $0x5,%eax
    4320:	cd 40                	int    $0x40
    4322:	c3                   	ret    

00004323 <write>:
SYSCALL(write)
    4323:	b8 10 00 00 00       	mov    $0x10,%eax
    4328:	cd 40                	int    $0x40
    432a:	c3                   	ret    

0000432b <close>:
SYSCALL(close)
    432b:	b8 15 00 00 00       	mov    $0x15,%eax
    4330:	cd 40                	int    $0x40
    4332:	c3                   	ret    

00004333 <kill>:
SYSCALL(kill)
    4333:	b8 06 00 00 00       	mov    $0x6,%eax
    4338:	cd 40                	int    $0x40
    433a:	c3                   	ret    

0000433b <exec>:
SYSCALL(exec)
    433b:	b8 07 00 00 00       	mov    $0x7,%eax
    4340:	cd 40                	int    $0x40
    4342:	c3                   	ret    

00004343 <open>:
SYSCALL(open)
    4343:	b8 0f 00 00 00       	mov    $0xf,%eax
    4348:	cd 40                	int    $0x40
    434a:	c3                   	ret    

0000434b <mknod>:
SYSCALL(mknod)
    434b:	b8 11 00 00 00       	mov    $0x11,%eax
    4350:	cd 40                	int    $0x40
    4352:	c3                   	ret    

00004353 <unlink>:
SYSCALL(unlink)
    4353:	b8 12 00 00 00       	mov    $0x12,%eax
    4358:	cd 40                	int    $0x40
    435a:	c3                   	ret    

0000435b <fstat>:
SYSCALL(fstat)
    435b:	b8 08 00 00 00       	mov    $0x8,%eax
    4360:	cd 40                	int    $0x40
    4362:	c3                   	ret    

00004363 <link>:
SYSCALL(link)
    4363:	b8 13 00 00 00       	mov    $0x13,%eax
    4368:	cd 40                	int    $0x40
    436a:	c3                   	ret    

0000436b <mkdir>:
SYSCALL(mkdir)
    436b:	b8 14 00 00 00       	mov    $0x14,%eax
    4370:	cd 40                	int    $0x40
    4372:	c3                   	ret    

00004373 <chdir>:
SYSCALL(chdir)
    4373:	b8 09 00 00 00       	mov    $0x9,%eax
    4378:	cd 40                	int    $0x40
    437a:	c3                   	ret    

0000437b <dup>:
SYSCALL(dup)
    437b:	b8 0a 00 00 00       	mov    $0xa,%eax
    4380:	cd 40                	int    $0x40
    4382:	c3                   	ret    

00004383 <getpid>:
SYSCALL(getpid)
    4383:	b8 0b 00 00 00       	mov    $0xb,%eax
    4388:	cd 40                	int    $0x40
    438a:	c3                   	ret    

0000438b <sbrk>:
SYSCALL(sbrk)
    438b:	b8 0c 00 00 00       	mov    $0xc,%eax
    4390:	cd 40                	int    $0x40
    4392:	c3                   	ret    

00004393 <sleep>:
SYSCALL(sleep)
    4393:	b8 0d 00 00 00       	mov    $0xd,%eax
    4398:	cd 40                	int    $0x40
    439a:	c3                   	ret    

0000439b <uptime>:
SYSCALL(uptime)
    439b:	b8 0e 00 00 00       	mov    $0xe,%eax
    43a0:	cd 40                	int    $0x40
    43a2:	c3                   	ret    

000043a3 <pstat>:
SYSCALL(pstat)
    43a3:	b8 16 00 00 00       	mov    $0x16,%eax
    43a8:	cd 40                	int    $0x40
    43aa:	c3                   	ret    

000043ab <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    43ab:	55                   	push   %ebp
    43ac:	89 e5                	mov    %esp,%ebp
    43ae:	83 ec 18             	sub    $0x18,%esp
    43b1:	8b 45 0c             	mov    0xc(%ebp),%eax
    43b4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    43b7:	83 ec 04             	sub    $0x4,%esp
    43ba:	6a 01                	push   $0x1
    43bc:	8d 45 f4             	lea    -0xc(%ebp),%eax
    43bf:	50                   	push   %eax
    43c0:	ff 75 08             	pushl  0x8(%ebp)
    43c3:	e8 5b ff ff ff       	call   4323 <write>
    43c8:	83 c4 10             	add    $0x10,%esp
}
    43cb:	c9                   	leave  
    43cc:	c3                   	ret    

000043cd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    43cd:	55                   	push   %ebp
    43ce:	89 e5                	mov    %esp,%ebp
    43d0:	53                   	push   %ebx
    43d1:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    43d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    43db:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    43df:	74 17                	je     43f8 <printint+0x2b>
    43e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    43e5:	79 11                	jns    43f8 <printint+0x2b>
    neg = 1;
    43e7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    43ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    43f1:	f7 d8                	neg    %eax
    43f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    43f6:	eb 06                	jmp    43fe <printint+0x31>
  } else {
    x = xx;
    43f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    43fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    43fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    4405:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    4408:	8d 41 01             	lea    0x1(%ecx),%eax
    440b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    440e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    4411:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4414:	ba 00 00 00 00       	mov    $0x0,%edx
    4419:	f7 f3                	div    %ebx
    441b:	89 d0                	mov    %edx,%eax
    441d:	0f b6 80 f8 66 00 00 	movzbl 0x66f8(%eax),%eax
    4424:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    4428:	8b 5d 10             	mov    0x10(%ebp),%ebx
    442b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    442e:	ba 00 00 00 00       	mov    $0x0,%edx
    4433:	f7 f3                	div    %ebx
    4435:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4438:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    443c:	75 c7                	jne    4405 <printint+0x38>
  if(neg)
    443e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4442:	74 0e                	je     4452 <printint+0x85>
    buf[i++] = '-';
    4444:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4447:	8d 50 01             	lea    0x1(%eax),%edx
    444a:	89 55 f4             	mov    %edx,-0xc(%ebp)
    444d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    4452:	eb 1d                	jmp    4471 <printint+0xa4>
    putc(fd, buf[i]);
    4454:	8d 55 dc             	lea    -0x24(%ebp),%edx
    4457:	8b 45 f4             	mov    -0xc(%ebp),%eax
    445a:	01 d0                	add    %edx,%eax
    445c:	0f b6 00             	movzbl (%eax),%eax
    445f:	0f be c0             	movsbl %al,%eax
    4462:	83 ec 08             	sub    $0x8,%esp
    4465:	50                   	push   %eax
    4466:	ff 75 08             	pushl  0x8(%ebp)
    4469:	e8 3d ff ff ff       	call   43ab <putc>
    446e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    4471:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    4475:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4479:	79 d9                	jns    4454 <printint+0x87>
    putc(fd, buf[i]);
}
    447b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    447e:	c9                   	leave  
    447f:	c3                   	ret    

00004480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4480:	55                   	push   %ebp
    4481:	89 e5                	mov    %esp,%ebp
    4483:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    4486:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    448d:	8d 45 0c             	lea    0xc(%ebp),%eax
    4490:	83 c0 04             	add    $0x4,%eax
    4493:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    4496:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    449d:	e9 59 01 00 00       	jmp    45fb <printf+0x17b>
    c = fmt[i] & 0xff;
    44a2:	8b 55 0c             	mov    0xc(%ebp),%edx
    44a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    44a8:	01 d0                	add    %edx,%eax
    44aa:	0f b6 00             	movzbl (%eax),%eax
    44ad:	0f be c0             	movsbl %al,%eax
    44b0:	25 ff 00 00 00       	and    $0xff,%eax
    44b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    44b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    44bc:	75 2c                	jne    44ea <printf+0x6a>
      if(c == '%'){
    44be:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    44c2:	75 0c                	jne    44d0 <printf+0x50>
        state = '%';
    44c4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    44cb:	e9 27 01 00 00       	jmp    45f7 <printf+0x177>
      } else {
        putc(fd, c);
    44d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    44d3:	0f be c0             	movsbl %al,%eax
    44d6:	83 ec 08             	sub    $0x8,%esp
    44d9:	50                   	push   %eax
    44da:	ff 75 08             	pushl  0x8(%ebp)
    44dd:	e8 c9 fe ff ff       	call   43ab <putc>
    44e2:	83 c4 10             	add    $0x10,%esp
    44e5:	e9 0d 01 00 00       	jmp    45f7 <printf+0x177>
      }
    } else if(state == '%'){
    44ea:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    44ee:	0f 85 03 01 00 00    	jne    45f7 <printf+0x177>
      if(c == 'd'){
    44f4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    44f8:	75 1e                	jne    4518 <printf+0x98>
        printint(fd, *ap, 10, 1);
    44fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
    44fd:	8b 00                	mov    (%eax),%eax
    44ff:	6a 01                	push   $0x1
    4501:	6a 0a                	push   $0xa
    4503:	50                   	push   %eax
    4504:	ff 75 08             	pushl  0x8(%ebp)
    4507:	e8 c1 fe ff ff       	call   43cd <printint>
    450c:	83 c4 10             	add    $0x10,%esp
        ap++;
    450f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4513:	e9 d8 00 00 00       	jmp    45f0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    4518:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    451c:	74 06                	je     4524 <printf+0xa4>
    451e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    4522:	75 1e                	jne    4542 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    4524:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4527:	8b 00                	mov    (%eax),%eax
    4529:	6a 00                	push   $0x0
    452b:	6a 10                	push   $0x10
    452d:	50                   	push   %eax
    452e:	ff 75 08             	pushl  0x8(%ebp)
    4531:	e8 97 fe ff ff       	call   43cd <printint>
    4536:	83 c4 10             	add    $0x10,%esp
        ap++;
    4539:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    453d:	e9 ae 00 00 00       	jmp    45f0 <printf+0x170>
      } else if(c == 's'){
    4542:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    4546:	75 43                	jne    458b <printf+0x10b>
        s = (char*)*ap;
    4548:	8b 45 e8             	mov    -0x18(%ebp),%eax
    454b:	8b 00                	mov    (%eax),%eax
    454d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    4550:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    4554:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4558:	75 07                	jne    4561 <printf+0xe1>
          s = "(null)";
    455a:	c7 45 f4 fe 5f 00 00 	movl   $0x5ffe,-0xc(%ebp)
        while(*s != 0){
    4561:	eb 1c                	jmp    457f <printf+0xff>
          putc(fd, *s);
    4563:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4566:	0f b6 00             	movzbl (%eax),%eax
    4569:	0f be c0             	movsbl %al,%eax
    456c:	83 ec 08             	sub    $0x8,%esp
    456f:	50                   	push   %eax
    4570:	ff 75 08             	pushl  0x8(%ebp)
    4573:	e8 33 fe ff ff       	call   43ab <putc>
    4578:	83 c4 10             	add    $0x10,%esp
          s++;
    457b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    457f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4582:	0f b6 00             	movzbl (%eax),%eax
    4585:	84 c0                	test   %al,%al
    4587:	75 da                	jne    4563 <printf+0xe3>
    4589:	eb 65                	jmp    45f0 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    458b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    458f:	75 1d                	jne    45ae <printf+0x12e>
        putc(fd, *ap);
    4591:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4594:	8b 00                	mov    (%eax),%eax
    4596:	0f be c0             	movsbl %al,%eax
    4599:	83 ec 08             	sub    $0x8,%esp
    459c:	50                   	push   %eax
    459d:	ff 75 08             	pushl  0x8(%ebp)
    45a0:	e8 06 fe ff ff       	call   43ab <putc>
    45a5:	83 c4 10             	add    $0x10,%esp
        ap++;
    45a8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    45ac:	eb 42                	jmp    45f0 <printf+0x170>
      } else if(c == '%'){
    45ae:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    45b2:	75 17                	jne    45cb <printf+0x14b>
        putc(fd, c);
    45b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    45b7:	0f be c0             	movsbl %al,%eax
    45ba:	83 ec 08             	sub    $0x8,%esp
    45bd:	50                   	push   %eax
    45be:	ff 75 08             	pushl  0x8(%ebp)
    45c1:	e8 e5 fd ff ff       	call   43ab <putc>
    45c6:	83 c4 10             	add    $0x10,%esp
    45c9:	eb 25                	jmp    45f0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    45cb:	83 ec 08             	sub    $0x8,%esp
    45ce:	6a 25                	push   $0x25
    45d0:	ff 75 08             	pushl  0x8(%ebp)
    45d3:	e8 d3 fd ff ff       	call   43ab <putc>
    45d8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    45db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    45de:	0f be c0             	movsbl %al,%eax
    45e1:	83 ec 08             	sub    $0x8,%esp
    45e4:	50                   	push   %eax
    45e5:	ff 75 08             	pushl  0x8(%ebp)
    45e8:	e8 be fd ff ff       	call   43ab <putc>
    45ed:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    45f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    45f7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    45fb:	8b 55 0c             	mov    0xc(%ebp),%edx
    45fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4601:	01 d0                	add    %edx,%eax
    4603:	0f b6 00             	movzbl (%eax),%eax
    4606:	84 c0                	test   %al,%al
    4608:	0f 85 94 fe ff ff    	jne    44a2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    460e:	c9                   	leave  
    460f:	c3                   	ret    

00004610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4610:	55                   	push   %ebp
    4611:	89 e5                	mov    %esp,%ebp
    4613:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4616:	8b 45 08             	mov    0x8(%ebp),%eax
    4619:	83 e8 08             	sub    $0x8,%eax
    461c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    461f:	a1 c8 67 00 00       	mov    0x67c8,%eax
    4624:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4627:	eb 24                	jmp    464d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4629:	8b 45 fc             	mov    -0x4(%ebp),%eax
    462c:	8b 00                	mov    (%eax),%eax
    462e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4631:	77 12                	ja     4645 <free+0x35>
    4633:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4636:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4639:	77 24                	ja     465f <free+0x4f>
    463b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    463e:	8b 00                	mov    (%eax),%eax
    4640:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4643:	77 1a                	ja     465f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4645:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4648:	8b 00                	mov    (%eax),%eax
    464a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    464d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4650:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4653:	76 d4                	jbe    4629 <free+0x19>
    4655:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4658:	8b 00                	mov    (%eax),%eax
    465a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    465d:	76 ca                	jbe    4629 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    465f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4662:	8b 40 04             	mov    0x4(%eax),%eax
    4665:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    466c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    466f:	01 c2                	add    %eax,%edx
    4671:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4674:	8b 00                	mov    (%eax),%eax
    4676:	39 c2                	cmp    %eax,%edx
    4678:	75 24                	jne    469e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    467a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    467d:	8b 50 04             	mov    0x4(%eax),%edx
    4680:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4683:	8b 00                	mov    (%eax),%eax
    4685:	8b 40 04             	mov    0x4(%eax),%eax
    4688:	01 c2                	add    %eax,%edx
    468a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    468d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    4690:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4693:	8b 00                	mov    (%eax),%eax
    4695:	8b 10                	mov    (%eax),%edx
    4697:	8b 45 f8             	mov    -0x8(%ebp),%eax
    469a:	89 10                	mov    %edx,(%eax)
    469c:	eb 0a                	jmp    46a8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    469e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46a1:	8b 10                	mov    (%eax),%edx
    46a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    46a6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    46a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46ab:	8b 40 04             	mov    0x4(%eax),%eax
    46ae:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    46b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46b8:	01 d0                	add    %edx,%eax
    46ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    46bd:	75 20                	jne    46df <free+0xcf>
    p->s.size += bp->s.size;
    46bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46c2:	8b 50 04             	mov    0x4(%eax),%edx
    46c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    46c8:	8b 40 04             	mov    0x4(%eax),%eax
    46cb:	01 c2                	add    %eax,%edx
    46cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46d0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    46d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    46d6:	8b 10                	mov    (%eax),%edx
    46d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46db:	89 10                	mov    %edx,(%eax)
    46dd:	eb 08                	jmp    46e7 <free+0xd7>
  } else
    p->s.ptr = bp;
    46df:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46e2:	8b 55 f8             	mov    -0x8(%ebp),%edx
    46e5:	89 10                	mov    %edx,(%eax)
  freep = p;
    46e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    46ea:	a3 c8 67 00 00       	mov    %eax,0x67c8
}
    46ef:	c9                   	leave  
    46f0:	c3                   	ret    

000046f1 <morecore>:

static Header*
morecore(uint nu)
{
    46f1:	55                   	push   %ebp
    46f2:	89 e5                	mov    %esp,%ebp
    46f4:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    46f7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    46fe:	77 07                	ja     4707 <morecore+0x16>
    nu = 4096;
    4700:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4707:	8b 45 08             	mov    0x8(%ebp),%eax
    470a:	c1 e0 03             	shl    $0x3,%eax
    470d:	83 ec 0c             	sub    $0xc,%esp
    4710:	50                   	push   %eax
    4711:	e8 75 fc ff ff       	call   438b <sbrk>
    4716:	83 c4 10             	add    $0x10,%esp
    4719:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    471c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4720:	75 07                	jne    4729 <morecore+0x38>
    return 0;
    4722:	b8 00 00 00 00       	mov    $0x0,%eax
    4727:	eb 26                	jmp    474f <morecore+0x5e>
  hp = (Header*)p;
    4729:	8b 45 f4             	mov    -0xc(%ebp),%eax
    472c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    472f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4732:	8b 55 08             	mov    0x8(%ebp),%edx
    4735:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4738:	8b 45 f0             	mov    -0x10(%ebp),%eax
    473b:	83 c0 08             	add    $0x8,%eax
    473e:	83 ec 0c             	sub    $0xc,%esp
    4741:	50                   	push   %eax
    4742:	e8 c9 fe ff ff       	call   4610 <free>
    4747:	83 c4 10             	add    $0x10,%esp
  return freep;
    474a:	a1 c8 67 00 00       	mov    0x67c8,%eax
}
    474f:	c9                   	leave  
    4750:	c3                   	ret    

00004751 <malloc>:

void*
malloc(uint nbytes)
{
    4751:	55                   	push   %ebp
    4752:	89 e5                	mov    %esp,%ebp
    4754:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4757:	8b 45 08             	mov    0x8(%ebp),%eax
    475a:	83 c0 07             	add    $0x7,%eax
    475d:	c1 e8 03             	shr    $0x3,%eax
    4760:	83 c0 01             	add    $0x1,%eax
    4763:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    4766:	a1 c8 67 00 00       	mov    0x67c8,%eax
    476b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    476e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4772:	75 23                	jne    4797 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    4774:	c7 45 f0 c0 67 00 00 	movl   $0x67c0,-0x10(%ebp)
    477b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    477e:	a3 c8 67 00 00       	mov    %eax,0x67c8
    4783:	a1 c8 67 00 00       	mov    0x67c8,%eax
    4788:	a3 c0 67 00 00       	mov    %eax,0x67c0
    base.s.size = 0;
    478d:	c7 05 c4 67 00 00 00 	movl   $0x0,0x67c4
    4794:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4797:	8b 45 f0             	mov    -0x10(%ebp),%eax
    479a:	8b 00                	mov    (%eax),%eax
    479c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    479f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47a2:	8b 40 04             	mov    0x4(%eax),%eax
    47a5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    47a8:	72 4d                	jb     47f7 <malloc+0xa6>
      if(p->s.size == nunits)
    47aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47ad:	8b 40 04             	mov    0x4(%eax),%eax
    47b0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    47b3:	75 0c                	jne    47c1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    47b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47b8:	8b 10                	mov    (%eax),%edx
    47ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    47bd:	89 10                	mov    %edx,(%eax)
    47bf:	eb 26                	jmp    47e7 <malloc+0x96>
      else {
        p->s.size -= nunits;
    47c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47c4:	8b 40 04             	mov    0x4(%eax),%eax
    47c7:	2b 45 ec             	sub    -0x14(%ebp),%eax
    47ca:	89 c2                	mov    %eax,%edx
    47cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47cf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    47d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47d5:	8b 40 04             	mov    0x4(%eax),%eax
    47d8:	c1 e0 03             	shl    $0x3,%eax
    47db:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    47de:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    47e4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    47e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    47ea:	a3 c8 67 00 00       	mov    %eax,0x67c8
      return (void*)(p + 1);
    47ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47f2:	83 c0 08             	add    $0x8,%eax
    47f5:	eb 3b                	jmp    4832 <malloc+0xe1>
    }
    if(p == freep)
    47f7:	a1 c8 67 00 00       	mov    0x67c8,%eax
    47fc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    47ff:	75 1e                	jne    481f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    4801:	83 ec 0c             	sub    $0xc,%esp
    4804:	ff 75 ec             	pushl  -0x14(%ebp)
    4807:	e8 e5 fe ff ff       	call   46f1 <morecore>
    480c:	83 c4 10             	add    $0x10,%esp
    480f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4812:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4816:	75 07                	jne    481f <malloc+0xce>
        return 0;
    4818:	b8 00 00 00 00       	mov    $0x0,%eax
    481d:	eb 13                	jmp    4832 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    481f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4822:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4825:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4828:	8b 00                	mov    (%eax),%eax
    482a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    482d:	e9 6d ff ff ff       	jmp    479f <malloc+0x4e>
}
    4832:	c9                   	leave  
    4833:	c3                   	ret    
