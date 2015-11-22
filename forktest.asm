
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	pushl  0xc(%ebp)
   c:	e8 be 01 00 00       	call   1cf <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	pushl  0xc(%ebp)
  1b:	ff 75 08             	pushl  0x8(%ebp)
  1e:	e8 8d 03 00 00       	call   3b0 <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	c9                   	leave  
  27:	c3                   	ret    

00000028 <forktest>:

void
forktest(void)
{
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2e:	83 ec 08             	sub    $0x8,%esp
  31:	68 38 04 00 00       	push   $0x438
  36:	6a 01                	push   $0x1
  38:	e8 c3 ff ff ff       	call   0 <printf>
  3d:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  47:	eb 24                	jmp    6d <forktest+0x45>
    pid = fork();
  49:	e8 3a 03 00 00       	call   388 <fork>
  4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  55:	79 02                	jns    59 <forktest+0x31>
      break;
  57:	eb 1d                	jmp    76 <forktest+0x4e>
    if(pid == 0)
  59:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5d:	75 0a                	jne    69 <forktest+0x41>
      exit(EXIT_STATUS_OK);
  5f:	83 ec 0c             	sub    $0xc,%esp
  62:	6a 01                	push   $0x1
  64:	e8 27 03 00 00       	call   390 <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  69:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  6d:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  74:	7e d3                	jle    49 <forktest+0x21>
      break;
    if(pid == 0)
      exit(EXIT_STATUS_OK);
  }
  
  if(n == N){
  76:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  7d:	75 21                	jne    a0 <forktest+0x78>
    printf(1, "fork claimed to work N times!\n", N);
  7f:	83 ec 04             	sub    $0x4,%esp
  82:	68 e8 03 00 00       	push   $0x3e8
  87:	68 44 04 00 00       	push   $0x444
  8c:	6a 01                	push   $0x1
  8e:	e8 6d ff ff ff       	call   0 <printf>
  93:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
  96:	83 ec 0c             	sub    $0xc,%esp
  99:	6a 01                	push   $0x1
  9b:	e8 f0 02 00 00       	call   390 <exit>
  }
  
  for(; n > 0; n--){
  a0:	eb 31                	jmp    d3 <forktest+0xab>
    if(wait(0) < 0){
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	6a 00                	push   $0x0
  a7:	e8 ec 02 00 00       	call   398 <wait>
  ac:	83 c4 10             	add    $0x10,%esp
  af:	85 c0                	test   %eax,%eax
  b1:	79 1c                	jns    cf <forktest+0xa7>
      printf(1, "wait stopped early\n");
  b3:	83 ec 08             	sub    $0x8,%esp
  b6:	68 63 04 00 00       	push   $0x463
  bb:	6a 01                	push   $0x1
  bd:	e8 3e ff ff ff       	call   0 <printf>
  c2:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
  c5:	83 ec 0c             	sub    $0xc,%esp
  c8:	6a 01                	push   $0x1
  ca:	e8 c1 02 00 00       	call   390 <exit>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit(EXIT_STATUS_OK);
  }
  
  for(; n > 0; n--){
  cf:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  d7:	7f c9                	jg     a2 <forktest+0x7a>
      printf(1, "wait stopped early\n");
      exit(EXIT_STATUS_OK);
    }
  }
  
  if(wait(0) != -1){
  d9:	83 ec 0c             	sub    $0xc,%esp
  dc:	6a 00                	push   $0x0
  de:	e8 b5 02 00 00       	call   398 <wait>
  e3:	83 c4 10             	add    $0x10,%esp
  e6:	83 f8 ff             	cmp    $0xffffffff,%eax
  e9:	74 1c                	je     107 <forktest+0xdf>
    printf(1, "wait got too many\n");
  eb:	83 ec 08             	sub    $0x8,%esp
  ee:	68 77 04 00 00       	push   $0x477
  f3:	6a 01                	push   $0x1
  f5:	e8 06 ff ff ff       	call   0 <printf>
  fa:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
  fd:	83 ec 0c             	sub    $0xc,%esp
 100:	6a 01                	push   $0x1
 102:	e8 89 02 00 00       	call   390 <exit>
  }
  
  printf(1, "fork test OK\n");
 107:	83 ec 08             	sub    $0x8,%esp
 10a:	68 8a 04 00 00       	push   $0x48a
 10f:	6a 01                	push   $0x1
 111:	e8 ea fe ff ff       	call   0 <printf>
 116:	83 c4 10             	add    $0x10,%esp
}
 119:	c9                   	leave  
 11a:	c3                   	ret    

0000011b <main>:

int
main(void)
{
 11b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 11f:	83 e4 f0             	and    $0xfffffff0,%esp
 122:	ff 71 fc             	pushl  -0x4(%ecx)
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
 128:	51                   	push   %ecx
 129:	83 ec 04             	sub    $0x4,%esp
  forktest();
 12c:	e8 f7 fe ff ff       	call   28 <forktest>
  exit(EXIT_STATUS_OK);
 131:	83 ec 0c             	sub    $0xc,%esp
 134:	6a 01                	push   $0x1
 136:	e8 55 02 00 00       	call   390 <exit>

0000013b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	57                   	push   %edi
 13f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 140:	8b 4d 08             	mov    0x8(%ebp),%ecx
 143:	8b 55 10             	mov    0x10(%ebp),%edx
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	89 cb                	mov    %ecx,%ebx
 14b:	89 df                	mov    %ebx,%edi
 14d:	89 d1                	mov    %edx,%ecx
 14f:	fc                   	cld    
 150:	f3 aa                	rep stos %al,%es:(%edi)
 152:	89 ca                	mov    %ecx,%edx
 154:	89 fb                	mov    %edi,%ebx
 156:	89 5d 08             	mov    %ebx,0x8(%ebp)
 159:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 15c:	5b                   	pop    %ebx
 15d:	5f                   	pop    %edi
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 16c:	90                   	nop
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	8d 50 01             	lea    0x1(%eax),%edx
 173:	89 55 08             	mov    %edx,0x8(%ebp)
 176:	8b 55 0c             	mov    0xc(%ebp),%edx
 179:	8d 4a 01             	lea    0x1(%edx),%ecx
 17c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 17f:	0f b6 12             	movzbl (%edx),%edx
 182:	88 10                	mov    %dl,(%eax)
 184:	0f b6 00             	movzbl (%eax),%eax
 187:	84 c0                	test   %al,%al
 189:	75 e2                	jne    16d <strcpy+0xd>
    ;
  return os;
 18b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 18e:	c9                   	leave  
 18f:	c3                   	ret    

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 193:	eb 08                	jmp    19d <strcmp+0xd>
    p++, q++;
 195:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 199:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 19d:	8b 45 08             	mov    0x8(%ebp),%eax
 1a0:	0f b6 00             	movzbl (%eax),%eax
 1a3:	84 c0                	test   %al,%al
 1a5:	74 10                	je     1b7 <strcmp+0x27>
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	0f b6 10             	movzbl (%eax),%edx
 1ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b0:	0f b6 00             	movzbl (%eax),%eax
 1b3:	38 c2                	cmp    %al,%dl
 1b5:	74 de                	je     195 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	0f b6 00             	movzbl (%eax),%eax
 1bd:	0f b6 d0             	movzbl %al,%edx
 1c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	0f b6 c0             	movzbl %al,%eax
 1c9:	29 c2                	sub    %eax,%edx
 1cb:	89 d0                	mov    %edx,%eax
}
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    

000001cf <strlen>:

uint
strlen(char *s)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
 1d2:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1dc:	eb 04                	jmp    1e2 <strlen+0x13>
 1de:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	01 d0                	add    %edx,%eax
 1ea:	0f b6 00             	movzbl (%eax),%eax
 1ed:	84 c0                	test   %al,%al
 1ef:	75 ed                	jne    1de <strlen+0xf>
    ;
  return n;
 1f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1f4:	c9                   	leave  
 1f5:	c3                   	ret    

000001f6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f6:	55                   	push   %ebp
 1f7:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1f9:	8b 45 10             	mov    0x10(%ebp),%eax
 1fc:	50                   	push   %eax
 1fd:	ff 75 0c             	pushl  0xc(%ebp)
 200:	ff 75 08             	pushl  0x8(%ebp)
 203:	e8 33 ff ff ff       	call   13b <stosb>
 208:	83 c4 0c             	add    $0xc,%esp
  return dst;
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 20e:	c9                   	leave  
 20f:	c3                   	ret    

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	83 ec 04             	sub    $0x4,%esp
 216:	8b 45 0c             	mov    0xc(%ebp),%eax
 219:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 21c:	eb 14                	jmp    232 <strchr+0x22>
    if(*s == c)
 21e:	8b 45 08             	mov    0x8(%ebp),%eax
 221:	0f b6 00             	movzbl (%eax),%eax
 224:	3a 45 fc             	cmp    -0x4(%ebp),%al
 227:	75 05                	jne    22e <strchr+0x1e>
      return (char*)s;
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	eb 13                	jmp    241 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 22e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	0f b6 00             	movzbl (%eax),%eax
 238:	84 c0                	test   %al,%al
 23a:	75 e2                	jne    21e <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 23c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 241:	c9                   	leave  
 242:	c3                   	ret    

00000243 <gets>:

char*
gets(char *buf, int max)
{
 243:	55                   	push   %ebp
 244:	89 e5                	mov    %esp,%ebp
 246:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 249:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 250:	eb 44                	jmp    296 <gets+0x53>
    cc = read(0, &c, 1);
 252:	83 ec 04             	sub    $0x4,%esp
 255:	6a 01                	push   $0x1
 257:	8d 45 ef             	lea    -0x11(%ebp),%eax
 25a:	50                   	push   %eax
 25b:	6a 00                	push   $0x0
 25d:	e8 46 01 00 00       	call   3a8 <read>
 262:	83 c4 10             	add    $0x10,%esp
 265:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 268:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 26c:	7f 02                	jg     270 <gets+0x2d>
      break;
 26e:	eb 31                	jmp    2a1 <gets+0x5e>
    buf[i++] = c;
 270:	8b 45 f4             	mov    -0xc(%ebp),%eax
 273:	8d 50 01             	lea    0x1(%eax),%edx
 276:	89 55 f4             	mov    %edx,-0xc(%ebp)
 279:	89 c2                	mov    %eax,%edx
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	01 c2                	add    %eax,%edx
 280:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 284:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 286:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 28a:	3c 0a                	cmp    $0xa,%al
 28c:	74 13                	je     2a1 <gets+0x5e>
 28e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 292:	3c 0d                	cmp    $0xd,%al
 294:	74 0b                	je     2a1 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 296:	8b 45 f4             	mov    -0xc(%ebp),%eax
 299:	83 c0 01             	add    $0x1,%eax
 29c:	3b 45 0c             	cmp    0xc(%ebp),%eax
 29f:	7c b1                	jl     252 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	01 d0                	add    %edx,%eax
 2a9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2af:	c9                   	leave  
 2b0:	c3                   	ret    

000002b1 <stat>:

int
stat(char *n, struct stat *st)
{
 2b1:	55                   	push   %ebp
 2b2:	89 e5                	mov    %esp,%ebp
 2b4:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b7:	83 ec 08             	sub    $0x8,%esp
 2ba:	6a 00                	push   $0x0
 2bc:	ff 75 08             	pushl  0x8(%ebp)
 2bf:	e8 0c 01 00 00       	call   3d0 <open>
 2c4:	83 c4 10             	add    $0x10,%esp
 2c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2ce:	79 07                	jns    2d7 <stat+0x26>
    return -1;
 2d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2d5:	eb 25                	jmp    2fc <stat+0x4b>
  r = fstat(fd, st);
 2d7:	83 ec 08             	sub    $0x8,%esp
 2da:	ff 75 0c             	pushl  0xc(%ebp)
 2dd:	ff 75 f4             	pushl  -0xc(%ebp)
 2e0:	e8 03 01 00 00       	call   3e8 <fstat>
 2e5:	83 c4 10             	add    $0x10,%esp
 2e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2eb:	83 ec 0c             	sub    $0xc,%esp
 2ee:	ff 75 f4             	pushl  -0xc(%ebp)
 2f1:	e8 c2 00 00 00       	call   3b8 <close>
 2f6:	83 c4 10             	add    $0x10,%esp
  return r;
 2f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2fc:	c9                   	leave  
 2fd:	c3                   	ret    

000002fe <atoi>:

int
atoi(const char *s)
{
 2fe:	55                   	push   %ebp
 2ff:	89 e5                	mov    %esp,%ebp
 301:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 304:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 30b:	eb 25                	jmp    332 <atoi+0x34>
    n = n*10 + *s++ - '0';
 30d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 310:	89 d0                	mov    %edx,%eax
 312:	c1 e0 02             	shl    $0x2,%eax
 315:	01 d0                	add    %edx,%eax
 317:	01 c0                	add    %eax,%eax
 319:	89 c1                	mov    %eax,%ecx
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	8d 50 01             	lea    0x1(%eax),%edx
 321:	89 55 08             	mov    %edx,0x8(%ebp)
 324:	0f b6 00             	movzbl (%eax),%eax
 327:	0f be c0             	movsbl %al,%eax
 32a:	01 c8                	add    %ecx,%eax
 32c:	83 e8 30             	sub    $0x30,%eax
 32f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 332:	8b 45 08             	mov    0x8(%ebp),%eax
 335:	0f b6 00             	movzbl (%eax),%eax
 338:	3c 2f                	cmp    $0x2f,%al
 33a:	7e 0a                	jle    346 <atoi+0x48>
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
 33f:	0f b6 00             	movzbl (%eax),%eax
 342:	3c 39                	cmp    $0x39,%al
 344:	7e c7                	jle    30d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 346:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 349:	c9                   	leave  
 34a:	c3                   	ret    

0000034b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 34b:	55                   	push   %ebp
 34c:	89 e5                	mov    %esp,%ebp
 34e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 351:	8b 45 08             	mov    0x8(%ebp),%eax
 354:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 357:	8b 45 0c             	mov    0xc(%ebp),%eax
 35a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 35d:	eb 17                	jmp    376 <memmove+0x2b>
    *dst++ = *src++;
 35f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 362:	8d 50 01             	lea    0x1(%eax),%edx
 365:	89 55 fc             	mov    %edx,-0x4(%ebp)
 368:	8b 55 f8             	mov    -0x8(%ebp),%edx
 36b:	8d 4a 01             	lea    0x1(%edx),%ecx
 36e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 371:	0f b6 12             	movzbl (%edx),%edx
 374:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 376:	8b 45 10             	mov    0x10(%ebp),%eax
 379:	8d 50 ff             	lea    -0x1(%eax),%edx
 37c:	89 55 10             	mov    %edx,0x10(%ebp)
 37f:	85 c0                	test   %eax,%eax
 381:	7f dc                	jg     35f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 383:	8b 45 08             	mov    0x8(%ebp),%eax
}
 386:	c9                   	leave  
 387:	c3                   	ret    

00000388 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 388:	b8 01 00 00 00       	mov    $0x1,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <exit>:
SYSCALL(exit)
 390:	b8 02 00 00 00       	mov    $0x2,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <wait>:
SYSCALL(wait)
 398:	b8 03 00 00 00       	mov    $0x3,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <pipe>:
SYSCALL(pipe)
 3a0:	b8 04 00 00 00       	mov    $0x4,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <read>:
SYSCALL(read)
 3a8:	b8 05 00 00 00       	mov    $0x5,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <write>:
SYSCALL(write)
 3b0:	b8 10 00 00 00       	mov    $0x10,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <close>:
SYSCALL(close)
 3b8:	b8 15 00 00 00       	mov    $0x15,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <kill>:
SYSCALL(kill)
 3c0:	b8 06 00 00 00       	mov    $0x6,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <exec>:
SYSCALL(exec)
 3c8:	b8 07 00 00 00       	mov    $0x7,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <open>:
SYSCALL(open)
 3d0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <mknod>:
SYSCALL(mknod)
 3d8:	b8 11 00 00 00       	mov    $0x11,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <unlink>:
SYSCALL(unlink)
 3e0:	b8 12 00 00 00       	mov    $0x12,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <fstat>:
SYSCALL(fstat)
 3e8:	b8 08 00 00 00       	mov    $0x8,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <link>:
SYSCALL(link)
 3f0:	b8 13 00 00 00       	mov    $0x13,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <mkdir>:
SYSCALL(mkdir)
 3f8:	b8 14 00 00 00       	mov    $0x14,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <chdir>:
SYSCALL(chdir)
 400:	b8 09 00 00 00       	mov    $0x9,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <dup>:
SYSCALL(dup)
 408:	b8 0a 00 00 00       	mov    $0xa,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <getpid>:
SYSCALL(getpid)
 410:	b8 0b 00 00 00       	mov    $0xb,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <sbrk>:
SYSCALL(sbrk)
 418:	b8 0c 00 00 00       	mov    $0xc,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <sleep>:
SYSCALL(sleep)
 420:	b8 0d 00 00 00       	mov    $0xd,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <uptime>:
SYSCALL(uptime)
 428:	b8 0e 00 00 00       	mov    $0xe,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <pstat>:
SYSCALL(pstat)
 430:	b8 16 00 00 00       	mov    $0x16,%eax
 435:	cd 40                	int    $0x40
 437:	c3                   	ret    
