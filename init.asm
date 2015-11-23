
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 aa 08 00 00       	push   $0x8aa
  1b:	e8 96 03 00 00       	call   3b6 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 aa 08 00 00       	push   $0x8aa
  33:	e8 86 03 00 00       	call   3be <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 aa 08 00 00       	push   $0x8aa
  45:	e8 6c 03 00 00       	call   3b6 <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 97 03 00 00       	call   3ee <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 8a 03 00 00       	call   3ee <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 b2 08 00 00       	push   $0x8b2
  6f:	6a 01                	push   $0x1
  71:	e8 7d 04 00 00       	call   4f3 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    sleep(10);
  79:	83 ec 0c             	sub    $0xc,%esp
  7c:	6a 0a                	push   $0xa
  7e:	e8 83 03 00 00       	call   406 <sleep>
  83:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  86:	e8 e3 02 00 00       	call   36e <fork>
  8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  8e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  92:	79 1c                	jns    b0 <main+0xb0>
      printf(1, "init: fork failed\n");
  94:	83 ec 08             	sub    $0x8,%esp
  97:	68 c5 08 00 00       	push   $0x8c5
  9c:	6a 01                	push   $0x1
  9e:	e8 50 04 00 00       	call   4f3 <printf>
  a3:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
  a6:	83 ec 0c             	sub    $0xc,%esp
  a9:	6a 01                	push   $0x1
  ab:	e8 c6 02 00 00       	call   376 <exit>
    }
    if(pid == 0){
  b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  b4:	75 31                	jne    e7 <main+0xe7>
      exec("sh", argv);
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 50 0b 00 00       	push   $0xb50
  be:	68 a7 08 00 00       	push   $0x8a7
  c3:	e8 e6 02 00 00       	call   3ae <exec>
  c8:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  cb:	83 ec 08             	sub    $0x8,%esp
  ce:	68 d8 08 00 00       	push   $0x8d8
  d3:	6a 01                	push   $0x1
  d5:	e8 19 04 00 00       	call   4f3 <printf>
  da:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
  dd:	83 ec 0c             	sub    $0xc,%esp
  e0:	6a 01                	push   $0x1
  e2:	e8 8f 02 00 00       	call   376 <exit>
    }
    while((wpid=wait(0)) >= 0 && wpid != pid)
  e7:	eb 15                	jmp    fe <main+0xfe>
      printf(1, "zombie! pid =%d\n", pid);
  e9:	83 ec 04             	sub    $0x4,%esp
  ec:	ff 75 f4             	pushl  -0xc(%ebp)
  ef:	68 ee 08 00 00       	push   $0x8ee
  f4:	6a 01                	push   $0x1
  f6:	e8 f8 03 00 00       	call   4f3 <printf>
  fb:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit(EXIT_STATUS_OK);
    }
    while((wpid=wait(0)) >= 0 && wpid != pid)
  fe:	83 ec 0c             	sub    $0xc,%esp
 101:	6a 00                	push   $0x0
 103:	e8 76 02 00 00       	call   37e <wait>
 108:	83 c4 10             	add    $0x10,%esp
 10b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 10e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 112:	78 08                	js     11c <main+0x11c>
 114:	8b 45 f0             	mov    -0x10(%ebp),%eax
 117:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 11a:	75 cd                	jne    e9 <main+0xe9>
      printf(1, "zombie! pid =%d\n", pid);
  }
 11c:	e9 46 ff ff ff       	jmp    67 <main+0x67>

00000121 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
 124:	57                   	push   %edi
 125:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 55 10             	mov    0x10(%ebp),%edx
 12c:	8b 45 0c             	mov    0xc(%ebp),%eax
 12f:	89 cb                	mov    %ecx,%ebx
 131:	89 df                	mov    %ebx,%edi
 133:	89 d1                	mov    %edx,%ecx
 135:	fc                   	cld    
 136:	f3 aa                	rep stos %al,%es:(%edi)
 138:	89 ca                	mov    %ecx,%edx
 13a:	89 fb                	mov    %edi,%ebx
 13c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 13f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 142:	5b                   	pop    %ebx
 143:	5f                   	pop    %edi
 144:	5d                   	pop    %ebp
 145:	c3                   	ret    

00000146 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 146:	55                   	push   %ebp
 147:	89 e5                	mov    %esp,%ebp
 149:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 152:	90                   	nop
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	8d 50 01             	lea    0x1(%eax),%edx
 159:	89 55 08             	mov    %edx,0x8(%ebp)
 15c:	8b 55 0c             	mov    0xc(%ebp),%edx
 15f:	8d 4a 01             	lea    0x1(%edx),%ecx
 162:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 165:	0f b6 12             	movzbl (%edx),%edx
 168:	88 10                	mov    %dl,(%eax)
 16a:	0f b6 00             	movzbl (%eax),%eax
 16d:	84 c0                	test   %al,%al
 16f:	75 e2                	jne    153 <strcpy+0xd>
    ;
  return os;
 171:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 174:	c9                   	leave  
 175:	c3                   	ret    

00000176 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 176:	55                   	push   %ebp
 177:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 179:	eb 08                	jmp    183 <strcmp+0xd>
    p++, q++;
 17b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	0f b6 00             	movzbl (%eax),%eax
 189:	84 c0                	test   %al,%al
 18b:	74 10                	je     19d <strcmp+0x27>
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
 190:	0f b6 10             	movzbl (%eax),%edx
 193:	8b 45 0c             	mov    0xc(%ebp),%eax
 196:	0f b6 00             	movzbl (%eax),%eax
 199:	38 c2                	cmp    %al,%dl
 19b:	74 de                	je     17b <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19d:	8b 45 08             	mov    0x8(%ebp),%eax
 1a0:	0f b6 00             	movzbl (%eax),%eax
 1a3:	0f b6 d0             	movzbl %al,%edx
 1a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a9:	0f b6 00             	movzbl (%eax),%eax
 1ac:	0f b6 c0             	movzbl %al,%eax
 1af:	29 c2                	sub    %eax,%edx
 1b1:	89 d0                	mov    %edx,%eax
}
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    

000001b5 <strlen>:

uint
strlen(char *s)
{
 1b5:	55                   	push   %ebp
 1b6:	89 e5                	mov    %esp,%ebp
 1b8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c2:	eb 04                	jmp    1c8 <strlen+0x13>
 1c4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	01 d0                	add    %edx,%eax
 1d0:	0f b6 00             	movzbl (%eax),%eax
 1d3:	84 c0                	test   %al,%al
 1d5:	75 ed                	jne    1c4 <strlen+0xf>
    ;
  return n;
 1d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1da:	c9                   	leave  
 1db:	c3                   	ret    

000001dc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1df:	8b 45 10             	mov    0x10(%ebp),%eax
 1e2:	50                   	push   %eax
 1e3:	ff 75 0c             	pushl  0xc(%ebp)
 1e6:	ff 75 08             	pushl  0x8(%ebp)
 1e9:	e8 33 ff ff ff       	call   121 <stosb>
 1ee:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f4:	c9                   	leave  
 1f5:	c3                   	ret    

000001f6 <strchr>:

char*
strchr(const char *s, char c)
{
 1f6:	55                   	push   %ebp
 1f7:	89 e5                	mov    %esp,%ebp
 1f9:	83 ec 04             	sub    $0x4,%esp
 1fc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ff:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 202:	eb 14                	jmp    218 <strchr+0x22>
    if(*s == c)
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	0f b6 00             	movzbl (%eax),%eax
 20a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 20d:	75 05                	jne    214 <strchr+0x1e>
      return (char*)s;
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	eb 13                	jmp    227 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 214:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	0f b6 00             	movzbl (%eax),%eax
 21e:	84 c0                	test   %al,%al
 220:	75 e2                	jne    204 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 222:	b8 00 00 00 00       	mov    $0x0,%eax
}
 227:	c9                   	leave  
 228:	c3                   	ret    

00000229 <gets>:

char*
gets(char *buf, int max)
{
 229:	55                   	push   %ebp
 22a:	89 e5                	mov    %esp,%ebp
 22c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 236:	eb 44                	jmp    27c <gets+0x53>
    cc = read(0, &c, 1);
 238:	83 ec 04             	sub    $0x4,%esp
 23b:	6a 01                	push   $0x1
 23d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 240:	50                   	push   %eax
 241:	6a 00                	push   $0x0
 243:	e8 46 01 00 00       	call   38e <read>
 248:	83 c4 10             	add    $0x10,%esp
 24b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 252:	7f 02                	jg     256 <gets+0x2d>
      break;
 254:	eb 31                	jmp    287 <gets+0x5e>
    buf[i++] = c;
 256:	8b 45 f4             	mov    -0xc(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 25f:	89 c2                	mov    %eax,%edx
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	01 c2                	add    %eax,%edx
 266:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 26c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 270:	3c 0a                	cmp    $0xa,%al
 272:	74 13                	je     287 <gets+0x5e>
 274:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 278:	3c 0d                	cmp    $0xd,%al
 27a:	74 0b                	je     287 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27f:	83 c0 01             	add    $0x1,%eax
 282:	3b 45 0c             	cmp    0xc(%ebp),%eax
 285:	7c b1                	jl     238 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 287:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	01 d0                	add    %edx,%eax
 28f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <stat>:

int
stat(char *n, struct stat *st)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29d:	83 ec 08             	sub    $0x8,%esp
 2a0:	6a 00                	push   $0x0
 2a2:	ff 75 08             	pushl  0x8(%ebp)
 2a5:	e8 0c 01 00 00       	call   3b6 <open>
 2aa:	83 c4 10             	add    $0x10,%esp
 2ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b4:	79 07                	jns    2bd <stat+0x26>
    return -1;
 2b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bb:	eb 25                	jmp    2e2 <stat+0x4b>
  r = fstat(fd, st);
 2bd:	83 ec 08             	sub    $0x8,%esp
 2c0:	ff 75 0c             	pushl  0xc(%ebp)
 2c3:	ff 75 f4             	pushl  -0xc(%ebp)
 2c6:	e8 03 01 00 00       	call   3ce <fstat>
 2cb:	83 c4 10             	add    $0x10,%esp
 2ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d1:	83 ec 0c             	sub    $0xc,%esp
 2d4:	ff 75 f4             	pushl  -0xc(%ebp)
 2d7:	e8 c2 00 00 00       	call   39e <close>
 2dc:	83 c4 10             	add    $0x10,%esp
  return r;
 2df:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e2:	c9                   	leave  
 2e3:	c3                   	ret    

000002e4 <atoi>:

int
atoi(const char *s)
{
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f1:	eb 25                	jmp    318 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f6:	89 d0                	mov    %edx,%eax
 2f8:	c1 e0 02             	shl    $0x2,%eax
 2fb:	01 d0                	add    %edx,%eax
 2fd:	01 c0                	add    %eax,%eax
 2ff:	89 c1                	mov    %eax,%ecx
 301:	8b 45 08             	mov    0x8(%ebp),%eax
 304:	8d 50 01             	lea    0x1(%eax),%edx
 307:	89 55 08             	mov    %edx,0x8(%ebp)
 30a:	0f b6 00             	movzbl (%eax),%eax
 30d:	0f be c0             	movsbl %al,%eax
 310:	01 c8                	add    %ecx,%eax
 312:	83 e8 30             	sub    $0x30,%eax
 315:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	0f b6 00             	movzbl (%eax),%eax
 31e:	3c 2f                	cmp    $0x2f,%al
 320:	7e 0a                	jle    32c <atoi+0x48>
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	0f b6 00             	movzbl (%eax),%eax
 328:	3c 39                	cmp    $0x39,%al
 32a:	7e c7                	jle    2f3 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 32c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 32f:	c9                   	leave  
 330:	c3                   	ret    

00000331 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 331:	55                   	push   %ebp
 332:	89 e5                	mov    %esp,%ebp
 334:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33d:	8b 45 0c             	mov    0xc(%ebp),%eax
 340:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 343:	eb 17                	jmp    35c <memmove+0x2b>
    *dst++ = *src++;
 345:	8b 45 fc             	mov    -0x4(%ebp),%eax
 348:	8d 50 01             	lea    0x1(%eax),%edx
 34b:	89 55 fc             	mov    %edx,-0x4(%ebp)
 34e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 351:	8d 4a 01             	lea    0x1(%edx),%ecx
 354:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 357:	0f b6 12             	movzbl (%edx),%edx
 35a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35c:	8b 45 10             	mov    0x10(%ebp),%eax
 35f:	8d 50 ff             	lea    -0x1(%eax),%edx
 362:	89 55 10             	mov    %edx,0x10(%ebp)
 365:	85 c0                	test   %eax,%eax
 367:	7f dc                	jg     345 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 369:	8b 45 08             	mov    0x8(%ebp),%eax
}
 36c:	c9                   	leave  
 36d:	c3                   	ret    

0000036e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36e:	b8 01 00 00 00       	mov    $0x1,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <exit>:
SYSCALL(exit)
 376:	b8 02 00 00 00       	mov    $0x2,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <wait>:
SYSCALL(wait)
 37e:	b8 03 00 00 00       	mov    $0x3,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <pipe>:
SYSCALL(pipe)
 386:	b8 04 00 00 00       	mov    $0x4,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <read>:
SYSCALL(read)
 38e:	b8 05 00 00 00       	mov    $0x5,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <write>:
SYSCALL(write)
 396:	b8 10 00 00 00       	mov    $0x10,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <close>:
SYSCALL(close)
 39e:	b8 15 00 00 00       	mov    $0x15,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <kill>:
SYSCALL(kill)
 3a6:	b8 06 00 00 00       	mov    $0x6,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <exec>:
SYSCALL(exec)
 3ae:	b8 07 00 00 00       	mov    $0x7,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <open>:
SYSCALL(open)
 3b6:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <mknod>:
SYSCALL(mknod)
 3be:	b8 11 00 00 00       	mov    $0x11,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <unlink>:
SYSCALL(unlink)
 3c6:	b8 12 00 00 00       	mov    $0x12,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <fstat>:
SYSCALL(fstat)
 3ce:	b8 08 00 00 00       	mov    $0x8,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <link>:
SYSCALL(link)
 3d6:	b8 13 00 00 00       	mov    $0x13,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <mkdir>:
SYSCALL(mkdir)
 3de:	b8 14 00 00 00       	mov    $0x14,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    

000003e6 <chdir>:
SYSCALL(chdir)
 3e6:	b8 09 00 00 00       	mov    $0x9,%eax
 3eb:	cd 40                	int    $0x40
 3ed:	c3                   	ret    

000003ee <dup>:
SYSCALL(dup)
 3ee:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f3:	cd 40                	int    $0x40
 3f5:	c3                   	ret    

000003f6 <getpid>:
SYSCALL(getpid)
 3f6:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fb:	cd 40                	int    $0x40
 3fd:	c3                   	ret    

000003fe <sbrk>:
SYSCALL(sbrk)
 3fe:	b8 0c 00 00 00       	mov    $0xc,%eax
 403:	cd 40                	int    $0x40
 405:	c3                   	ret    

00000406 <sleep>:
SYSCALL(sleep)
 406:	b8 0d 00 00 00       	mov    $0xd,%eax
 40b:	cd 40                	int    $0x40
 40d:	c3                   	ret    

0000040e <uptime>:
SYSCALL(uptime)
 40e:	b8 0e 00 00 00       	mov    $0xe,%eax
 413:	cd 40                	int    $0x40
 415:	c3                   	ret    

00000416 <pstat>:
SYSCALL(pstat)
 416:	b8 16 00 00 00       	mov    $0x16,%eax
 41b:	cd 40                	int    $0x40
 41d:	c3                   	ret    

0000041e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 41e:	55                   	push   %ebp
 41f:	89 e5                	mov    %esp,%ebp
 421:	83 ec 18             	sub    $0x18,%esp
 424:	8b 45 0c             	mov    0xc(%ebp),%eax
 427:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 42a:	83 ec 04             	sub    $0x4,%esp
 42d:	6a 01                	push   $0x1
 42f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 432:	50                   	push   %eax
 433:	ff 75 08             	pushl  0x8(%ebp)
 436:	e8 5b ff ff ff       	call   396 <write>
 43b:	83 c4 10             	add    $0x10,%esp
}
 43e:	c9                   	leave  
 43f:	c3                   	ret    

00000440 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	53                   	push   %ebx
 444:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 447:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 44e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 452:	74 17                	je     46b <printint+0x2b>
 454:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 458:	79 11                	jns    46b <printint+0x2b>
    neg = 1;
 45a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 461:	8b 45 0c             	mov    0xc(%ebp),%eax
 464:	f7 d8                	neg    %eax
 466:	89 45 ec             	mov    %eax,-0x14(%ebp)
 469:	eb 06                	jmp    471 <printint+0x31>
  } else {
    x = xx;
 46b:	8b 45 0c             	mov    0xc(%ebp),%eax
 46e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 471:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 478:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 47b:	8d 41 01             	lea    0x1(%ecx),%eax
 47e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 481:	8b 5d 10             	mov    0x10(%ebp),%ebx
 484:	8b 45 ec             	mov    -0x14(%ebp),%eax
 487:	ba 00 00 00 00       	mov    $0x0,%edx
 48c:	f7 f3                	div    %ebx
 48e:	89 d0                	mov    %edx,%eax
 490:	0f b6 80 58 0b 00 00 	movzbl 0xb58(%eax),%eax
 497:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 49b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 49e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a1:	ba 00 00 00 00       	mov    $0x0,%edx
 4a6:	f7 f3                	div    %ebx
 4a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4af:	75 c7                	jne    478 <printint+0x38>
  if(neg)
 4b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b5:	74 0e                	je     4c5 <printint+0x85>
    buf[i++] = '-';
 4b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ba:	8d 50 01             	lea    0x1(%eax),%edx
 4bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4c0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4c5:	eb 1d                	jmp    4e4 <printint+0xa4>
    putc(fd, buf[i]);
 4c7:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4cd:	01 d0                	add    %edx,%eax
 4cf:	0f b6 00             	movzbl (%eax),%eax
 4d2:	0f be c0             	movsbl %al,%eax
 4d5:	83 ec 08             	sub    $0x8,%esp
 4d8:	50                   	push   %eax
 4d9:	ff 75 08             	pushl  0x8(%ebp)
 4dc:	e8 3d ff ff ff       	call   41e <putc>
 4e1:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ec:	79 d9                	jns    4c7 <printint+0x87>
    putc(fd, buf[i]);
}
 4ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f1:	c9                   	leave  
 4f2:	c3                   	ret    

000004f3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f3:	55                   	push   %ebp
 4f4:	89 e5                	mov    %esp,%ebp
 4f6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4f9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 500:	8d 45 0c             	lea    0xc(%ebp),%eax
 503:	83 c0 04             	add    $0x4,%eax
 506:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 509:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 510:	e9 59 01 00 00       	jmp    66e <printf+0x17b>
    c = fmt[i] & 0xff;
 515:	8b 55 0c             	mov    0xc(%ebp),%edx
 518:	8b 45 f0             	mov    -0x10(%ebp),%eax
 51b:	01 d0                	add    %edx,%eax
 51d:	0f b6 00             	movzbl (%eax),%eax
 520:	0f be c0             	movsbl %al,%eax
 523:	25 ff 00 00 00       	and    $0xff,%eax
 528:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 52b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 52f:	75 2c                	jne    55d <printf+0x6a>
      if(c == '%'){
 531:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 535:	75 0c                	jne    543 <printf+0x50>
        state = '%';
 537:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 53e:	e9 27 01 00 00       	jmp    66a <printf+0x177>
      } else {
        putc(fd, c);
 543:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 546:	0f be c0             	movsbl %al,%eax
 549:	83 ec 08             	sub    $0x8,%esp
 54c:	50                   	push   %eax
 54d:	ff 75 08             	pushl  0x8(%ebp)
 550:	e8 c9 fe ff ff       	call   41e <putc>
 555:	83 c4 10             	add    $0x10,%esp
 558:	e9 0d 01 00 00       	jmp    66a <printf+0x177>
      }
    } else if(state == '%'){
 55d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 561:	0f 85 03 01 00 00    	jne    66a <printf+0x177>
      if(c == 'd'){
 567:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 56b:	75 1e                	jne    58b <printf+0x98>
        printint(fd, *ap, 10, 1);
 56d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 570:	8b 00                	mov    (%eax),%eax
 572:	6a 01                	push   $0x1
 574:	6a 0a                	push   $0xa
 576:	50                   	push   %eax
 577:	ff 75 08             	pushl  0x8(%ebp)
 57a:	e8 c1 fe ff ff       	call   440 <printint>
 57f:	83 c4 10             	add    $0x10,%esp
        ap++;
 582:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 586:	e9 d8 00 00 00       	jmp    663 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 58b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 58f:	74 06                	je     597 <printf+0xa4>
 591:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 595:	75 1e                	jne    5b5 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 597:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59a:	8b 00                	mov    (%eax),%eax
 59c:	6a 00                	push   $0x0
 59e:	6a 10                	push   $0x10
 5a0:	50                   	push   %eax
 5a1:	ff 75 08             	pushl  0x8(%ebp)
 5a4:	e8 97 fe ff ff       	call   440 <printint>
 5a9:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b0:	e9 ae 00 00 00       	jmp    663 <printf+0x170>
      } else if(c == 's'){
 5b5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5b9:	75 43                	jne    5fe <printf+0x10b>
        s = (char*)*ap;
 5bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5be:	8b 00                	mov    (%eax),%eax
 5c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5cb:	75 07                	jne    5d4 <printf+0xe1>
          s = "(null)";
 5cd:	c7 45 f4 ff 08 00 00 	movl   $0x8ff,-0xc(%ebp)
        while(*s != 0){
 5d4:	eb 1c                	jmp    5f2 <printf+0xff>
          putc(fd, *s);
 5d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d9:	0f b6 00             	movzbl (%eax),%eax
 5dc:	0f be c0             	movsbl %al,%eax
 5df:	83 ec 08             	sub    $0x8,%esp
 5e2:	50                   	push   %eax
 5e3:	ff 75 08             	pushl  0x8(%ebp)
 5e6:	e8 33 fe ff ff       	call   41e <putc>
 5eb:	83 c4 10             	add    $0x10,%esp
          s++;
 5ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f5:	0f b6 00             	movzbl (%eax),%eax
 5f8:	84 c0                	test   %al,%al
 5fa:	75 da                	jne    5d6 <printf+0xe3>
 5fc:	eb 65                	jmp    663 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5fe:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 602:	75 1d                	jne    621 <printf+0x12e>
        putc(fd, *ap);
 604:	8b 45 e8             	mov    -0x18(%ebp),%eax
 607:	8b 00                	mov    (%eax),%eax
 609:	0f be c0             	movsbl %al,%eax
 60c:	83 ec 08             	sub    $0x8,%esp
 60f:	50                   	push   %eax
 610:	ff 75 08             	pushl  0x8(%ebp)
 613:	e8 06 fe ff ff       	call   41e <putc>
 618:	83 c4 10             	add    $0x10,%esp
        ap++;
 61b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61f:	eb 42                	jmp    663 <printf+0x170>
      } else if(c == '%'){
 621:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 625:	75 17                	jne    63e <printf+0x14b>
        putc(fd, c);
 627:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62a:	0f be c0             	movsbl %al,%eax
 62d:	83 ec 08             	sub    $0x8,%esp
 630:	50                   	push   %eax
 631:	ff 75 08             	pushl  0x8(%ebp)
 634:	e8 e5 fd ff ff       	call   41e <putc>
 639:	83 c4 10             	add    $0x10,%esp
 63c:	eb 25                	jmp    663 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63e:	83 ec 08             	sub    $0x8,%esp
 641:	6a 25                	push   $0x25
 643:	ff 75 08             	pushl  0x8(%ebp)
 646:	e8 d3 fd ff ff       	call   41e <putc>
 64b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 64e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 651:	0f be c0             	movsbl %al,%eax
 654:	83 ec 08             	sub    $0x8,%esp
 657:	50                   	push   %eax
 658:	ff 75 08             	pushl  0x8(%ebp)
 65b:	e8 be fd ff ff       	call   41e <putc>
 660:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 663:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 66e:	8b 55 0c             	mov    0xc(%ebp),%edx
 671:	8b 45 f0             	mov    -0x10(%ebp),%eax
 674:	01 d0                	add    %edx,%eax
 676:	0f b6 00             	movzbl (%eax),%eax
 679:	84 c0                	test   %al,%al
 67b:	0f 85 94 fe ff ff    	jne    515 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 681:	c9                   	leave  
 682:	c3                   	ret    

00000683 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 683:	55                   	push   %ebp
 684:	89 e5                	mov    %esp,%ebp
 686:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 689:	8b 45 08             	mov    0x8(%ebp),%eax
 68c:	83 e8 08             	sub    $0x8,%eax
 68f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 692:	a1 74 0b 00 00       	mov    0xb74,%eax
 697:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69a:	eb 24                	jmp    6c0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 00                	mov    (%eax),%eax
 6a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a4:	77 12                	ja     6b8 <free+0x35>
 6a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ac:	77 24                	ja     6d2 <free+0x4f>
 6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b1:	8b 00                	mov    (%eax),%eax
 6b3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b6:	77 1a                	ja     6d2 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bb:	8b 00                	mov    (%eax),%eax
 6bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c6:	76 d4                	jbe    69c <free+0x19>
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 00                	mov    (%eax),%eax
 6cd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d0:	76 ca                	jbe    69c <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d5:	8b 40 04             	mov    0x4(%eax),%eax
 6d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e2:	01 c2                	add    %eax,%edx
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 00                	mov    (%eax),%eax
 6e9:	39 c2                	cmp    %eax,%edx
 6eb:	75 24                	jne    711 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f0:	8b 50 04             	mov    0x4(%eax),%edx
 6f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f6:	8b 00                	mov    (%eax),%eax
 6f8:	8b 40 04             	mov    0x4(%eax),%eax
 6fb:	01 c2                	add    %eax,%edx
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 703:	8b 45 fc             	mov    -0x4(%ebp),%eax
 706:	8b 00                	mov    (%eax),%eax
 708:	8b 10                	mov    (%eax),%edx
 70a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70d:	89 10                	mov    %edx,(%eax)
 70f:	eb 0a                	jmp    71b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 10                	mov    (%eax),%edx
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71e:	8b 40 04             	mov    0x4(%eax),%eax
 721:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 728:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72b:	01 d0                	add    %edx,%eax
 72d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 730:	75 20                	jne    752 <free+0xcf>
    p->s.size += bp->s.size;
 732:	8b 45 fc             	mov    -0x4(%ebp),%eax
 735:	8b 50 04             	mov    0x4(%eax),%edx
 738:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	01 c2                	add    %eax,%edx
 740:	8b 45 fc             	mov    -0x4(%ebp),%eax
 743:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 746:	8b 45 f8             	mov    -0x8(%ebp),%eax
 749:	8b 10                	mov    (%eax),%edx
 74b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74e:	89 10                	mov    %edx,(%eax)
 750:	eb 08                	jmp    75a <free+0xd7>
  } else
    p->s.ptr = bp;
 752:	8b 45 fc             	mov    -0x4(%ebp),%eax
 755:	8b 55 f8             	mov    -0x8(%ebp),%edx
 758:	89 10                	mov    %edx,(%eax)
  freep = p;
 75a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75d:	a3 74 0b 00 00       	mov    %eax,0xb74
}
 762:	c9                   	leave  
 763:	c3                   	ret    

00000764 <morecore>:

static Header*
morecore(uint nu)
{
 764:	55                   	push   %ebp
 765:	89 e5                	mov    %esp,%ebp
 767:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 76a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 771:	77 07                	ja     77a <morecore+0x16>
    nu = 4096;
 773:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 77a:	8b 45 08             	mov    0x8(%ebp),%eax
 77d:	c1 e0 03             	shl    $0x3,%eax
 780:	83 ec 0c             	sub    $0xc,%esp
 783:	50                   	push   %eax
 784:	e8 75 fc ff ff       	call   3fe <sbrk>
 789:	83 c4 10             	add    $0x10,%esp
 78c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 78f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 793:	75 07                	jne    79c <morecore+0x38>
    return 0;
 795:	b8 00 00 00 00       	mov    $0x0,%eax
 79a:	eb 26                	jmp    7c2 <morecore+0x5e>
  hp = (Header*)p;
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a5:	8b 55 08             	mov    0x8(%ebp),%edx
 7a8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ae:	83 c0 08             	add    $0x8,%eax
 7b1:	83 ec 0c             	sub    $0xc,%esp
 7b4:	50                   	push   %eax
 7b5:	e8 c9 fe ff ff       	call   683 <free>
 7ba:	83 c4 10             	add    $0x10,%esp
  return freep;
 7bd:	a1 74 0b 00 00       	mov    0xb74,%eax
}
 7c2:	c9                   	leave  
 7c3:	c3                   	ret    

000007c4 <malloc>:

void*
malloc(uint nbytes)
{
 7c4:	55                   	push   %ebp
 7c5:	89 e5                	mov    %esp,%ebp
 7c7:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ca:	8b 45 08             	mov    0x8(%ebp),%eax
 7cd:	83 c0 07             	add    $0x7,%eax
 7d0:	c1 e8 03             	shr    $0x3,%eax
 7d3:	83 c0 01             	add    $0x1,%eax
 7d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7d9:	a1 74 0b 00 00       	mov    0xb74,%eax
 7de:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e5:	75 23                	jne    80a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7e7:	c7 45 f0 6c 0b 00 00 	movl   $0xb6c,-0x10(%ebp)
 7ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f1:	a3 74 0b 00 00       	mov    %eax,0xb74
 7f6:	a1 74 0b 00 00       	mov    0xb74,%eax
 7fb:	a3 6c 0b 00 00       	mov    %eax,0xb6c
    base.s.size = 0;
 800:	c7 05 70 0b 00 00 00 	movl   $0x0,0xb70
 807:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80d:	8b 00                	mov    (%eax),%eax
 80f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 812:	8b 45 f4             	mov    -0xc(%ebp),%eax
 815:	8b 40 04             	mov    0x4(%eax),%eax
 818:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81b:	72 4d                	jb     86a <malloc+0xa6>
      if(p->s.size == nunits)
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 826:	75 0c                	jne    834 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 828:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82b:	8b 10                	mov    (%eax),%edx
 82d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 830:	89 10                	mov    %edx,(%eax)
 832:	eb 26                	jmp    85a <malloc+0x96>
      else {
        p->s.size -= nunits;
 834:	8b 45 f4             	mov    -0xc(%ebp),%eax
 837:	8b 40 04             	mov    0x4(%eax),%eax
 83a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 83d:	89 c2                	mov    %eax,%edx
 83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 842:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 845:	8b 45 f4             	mov    -0xc(%ebp),%eax
 848:	8b 40 04             	mov    0x4(%eax),%eax
 84b:	c1 e0 03             	shl    $0x3,%eax
 84e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 851:	8b 45 f4             	mov    -0xc(%ebp),%eax
 854:	8b 55 ec             	mov    -0x14(%ebp),%edx
 857:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 85a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85d:	a3 74 0b 00 00       	mov    %eax,0xb74
      return (void*)(p + 1);
 862:	8b 45 f4             	mov    -0xc(%ebp),%eax
 865:	83 c0 08             	add    $0x8,%eax
 868:	eb 3b                	jmp    8a5 <malloc+0xe1>
    }
    if(p == freep)
 86a:	a1 74 0b 00 00       	mov    0xb74,%eax
 86f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 872:	75 1e                	jne    892 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 874:	83 ec 0c             	sub    $0xc,%esp
 877:	ff 75 ec             	pushl  -0x14(%ebp)
 87a:	e8 e5 fe ff ff       	call   764 <morecore>
 87f:	83 c4 10             	add    $0x10,%esp
 882:	89 45 f4             	mov    %eax,-0xc(%ebp)
 885:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 889:	75 07                	jne    892 <malloc+0xce>
        return 0;
 88b:	b8 00 00 00 00       	mov    $0x0,%eax
 890:	eb 13                	jmp    8a5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 892:	8b 45 f4             	mov    -0xc(%ebp),%eax
 895:	89 45 f0             	mov    %eax,-0x10(%ebp)
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	8b 00                	mov    (%eax),%eax
 89d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a0:	e9 6d ff ff ff       	jmp    812 <malloc+0x4e>
}
 8a5:	c9                   	leave  
 8a6:	c3                   	ret    
