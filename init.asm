
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
  16:	68 a7 08 00 00       	push   $0x8a7
  1b:	e8 93 03 00 00       	call   3b3 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 a7 08 00 00       	push   $0x8a7
  33:	e8 83 03 00 00       	call   3bb <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 a7 08 00 00       	push   $0x8a7
  45:	e8 69 03 00 00       	call   3b3 <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 94 03 00 00       	call   3eb <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 87 03 00 00       	call   3eb <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 af 08 00 00       	push   $0x8af
  6f:	6a 01                	push   $0x1
  71:	e8 7a 04 00 00       	call   4f0 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    sleep(50);
  79:	83 ec 0c             	sub    $0xc,%esp
  7c:	6a 32                	push   $0x32
  7e:	e8 80 03 00 00       	call   403 <sleep>
  83:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  86:	e8 e0 02 00 00       	call   36b <fork>
  8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  8e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  92:	79 1c                	jns    b0 <main+0xb0>
      printf(1, "init: fork failed\n");
  94:	83 ec 08             	sub    $0x8,%esp
  97:	68 c2 08 00 00       	push   $0x8c2
  9c:	6a 01                	push   $0x1
  9e:	e8 4d 04 00 00       	call   4f0 <printf>
  a3:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
  a6:	83 ec 0c             	sub    $0xc,%esp
  a9:	6a 01                	push   $0x1
  ab:	e8 c3 02 00 00       	call   373 <exit>
    }
    if(pid == 0){
  b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  b4:	75 31                	jne    e7 <main+0xe7>
      exec("sh", argv);
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 44 0b 00 00       	push   $0xb44
  be:	68 a4 08 00 00       	push   $0x8a4
  c3:	e8 e3 02 00 00       	call   3ab <exec>
  c8:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  cb:	83 ec 08             	sub    $0x8,%esp
  ce:	68 d5 08 00 00       	push   $0x8d5
  d3:	6a 01                	push   $0x1
  d5:	e8 16 04 00 00       	call   4f0 <printf>
  da:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
  dd:	83 ec 0c             	sub    $0xc,%esp
  e0:	6a 01                	push   $0x1
  e2:	e8 8c 02 00 00       	call   373 <exit>
    }
    while((wpid=wait(0)) >= 0 && wpid != pid)
  e7:	eb 12                	jmp    fb <main+0xfb>
      printf(1, "zombie!\n");
  e9:	83 ec 08             	sub    $0x8,%esp
  ec:	68 eb 08 00 00       	push   $0x8eb
  f1:	6a 01                	push   $0x1
  f3:	e8 f8 03 00 00       	call   4f0 <printf>
  f8:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit(EXIT_STATUS_OK);
    }
    while((wpid=wait(0)) >= 0 && wpid != pid)
  fb:	83 ec 0c             	sub    $0xc,%esp
  fe:	6a 00                	push   $0x0
 100:	e8 76 02 00 00       	call   37b <wait>
 105:	83 c4 10             	add    $0x10,%esp
 108:	89 45 f0             	mov    %eax,-0x10(%ebp)
 10b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 10f:	78 08                	js     119 <main+0x119>
 111:	8b 45 f0             	mov    -0x10(%ebp),%eax
 114:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 117:	75 d0                	jne    e9 <main+0xe9>
      printf(1, "zombie!\n");
  }
 119:	e9 49 ff ff ff       	jmp    67 <main+0x67>

0000011e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 11e:	55                   	push   %ebp
 11f:	89 e5                	mov    %esp,%ebp
 121:	57                   	push   %edi
 122:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
 126:	8b 55 10             	mov    0x10(%ebp),%edx
 129:	8b 45 0c             	mov    0xc(%ebp),%eax
 12c:	89 cb                	mov    %ecx,%ebx
 12e:	89 df                	mov    %ebx,%edi
 130:	89 d1                	mov    %edx,%ecx
 132:	fc                   	cld    
 133:	f3 aa                	rep stos %al,%es:(%edi)
 135:	89 ca                	mov    %ecx,%edx
 137:	89 fb                	mov    %edi,%ebx
 139:	89 5d 08             	mov    %ebx,0x8(%ebp)
 13c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 13f:	5b                   	pop    %ebx
 140:	5f                   	pop    %edi
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    

00000143 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 143:	55                   	push   %ebp
 144:	89 e5                	mov    %esp,%ebp
 146:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 149:	8b 45 08             	mov    0x8(%ebp),%eax
 14c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 14f:	90                   	nop
 150:	8b 45 08             	mov    0x8(%ebp),%eax
 153:	8d 50 01             	lea    0x1(%eax),%edx
 156:	89 55 08             	mov    %edx,0x8(%ebp)
 159:	8b 55 0c             	mov    0xc(%ebp),%edx
 15c:	8d 4a 01             	lea    0x1(%edx),%ecx
 15f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 162:	0f b6 12             	movzbl (%edx),%edx
 165:	88 10                	mov    %dl,(%eax)
 167:	0f b6 00             	movzbl (%eax),%eax
 16a:	84 c0                	test   %al,%al
 16c:	75 e2                	jne    150 <strcpy+0xd>
    ;
  return os;
 16e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 171:	c9                   	leave  
 172:	c3                   	ret    

00000173 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 173:	55                   	push   %ebp
 174:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 176:	eb 08                	jmp    180 <strcmp+0xd>
    p++, q++;
 178:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 00             	movzbl (%eax),%eax
 186:	84 c0                	test   %al,%al
 188:	74 10                	je     19a <strcmp+0x27>
 18a:	8b 45 08             	mov    0x8(%ebp),%eax
 18d:	0f b6 10             	movzbl (%eax),%edx
 190:	8b 45 0c             	mov    0xc(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	38 c2                	cmp    %al,%dl
 198:	74 de                	je     178 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	0f b6 00             	movzbl (%eax),%eax
 1a0:	0f b6 d0             	movzbl %al,%edx
 1a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a6:	0f b6 00             	movzbl (%eax),%eax
 1a9:	0f b6 c0             	movzbl %al,%eax
 1ac:	29 c2                	sub    %eax,%edx
 1ae:	89 d0                	mov    %edx,%eax
}
 1b0:	5d                   	pop    %ebp
 1b1:	c3                   	ret    

000001b2 <strlen>:

uint
strlen(char *s)
{
 1b2:	55                   	push   %ebp
 1b3:	89 e5                	mov    %esp,%ebp
 1b5:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1bf:	eb 04                	jmp    1c5 <strlen+0x13>
 1c1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	01 d0                	add    %edx,%eax
 1cd:	0f b6 00             	movzbl (%eax),%eax
 1d0:	84 c0                	test   %al,%al
 1d2:	75 ed                	jne    1c1 <strlen+0xf>
    ;
  return n;
 1d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1d7:	c9                   	leave  
 1d8:	c3                   	ret    

000001d9 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d9:	55                   	push   %ebp
 1da:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1dc:	8b 45 10             	mov    0x10(%ebp),%eax
 1df:	50                   	push   %eax
 1e0:	ff 75 0c             	pushl  0xc(%ebp)
 1e3:	ff 75 08             	pushl  0x8(%ebp)
 1e6:	e8 33 ff ff ff       	call   11e <stosb>
 1eb:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f1:	c9                   	leave  
 1f2:	c3                   	ret    

000001f3 <strchr>:

char*
strchr(const char *s, char c)
{
 1f3:	55                   	push   %ebp
 1f4:	89 e5                	mov    %esp,%ebp
 1f6:	83 ec 04             	sub    $0x4,%esp
 1f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1ff:	eb 14                	jmp    215 <strchr+0x22>
    if(*s == c)
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	0f b6 00             	movzbl (%eax),%eax
 207:	3a 45 fc             	cmp    -0x4(%ebp),%al
 20a:	75 05                	jne    211 <strchr+0x1e>
      return (char*)s;
 20c:	8b 45 08             	mov    0x8(%ebp),%eax
 20f:	eb 13                	jmp    224 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 211:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	84 c0                	test   %al,%al
 21d:	75 e2                	jne    201 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 224:	c9                   	leave  
 225:	c3                   	ret    

00000226 <gets>:

char*
gets(char *buf, int max)
{
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 233:	eb 44                	jmp    279 <gets+0x53>
    cc = read(0, &c, 1);
 235:	83 ec 04             	sub    $0x4,%esp
 238:	6a 01                	push   $0x1
 23a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23d:	50                   	push   %eax
 23e:	6a 00                	push   $0x0
 240:	e8 46 01 00 00       	call   38b <read>
 245:	83 c4 10             	add    $0x10,%esp
 248:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 24f:	7f 02                	jg     253 <gets+0x2d>
      break;
 251:	eb 31                	jmp    284 <gets+0x5e>
    buf[i++] = c;
 253:	8b 45 f4             	mov    -0xc(%ebp),%eax
 256:	8d 50 01             	lea    0x1(%eax),%edx
 259:	89 55 f4             	mov    %edx,-0xc(%ebp)
 25c:	89 c2                	mov    %eax,%edx
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	01 c2                	add    %eax,%edx
 263:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 267:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 269:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26d:	3c 0a                	cmp    $0xa,%al
 26f:	74 13                	je     284 <gets+0x5e>
 271:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 275:	3c 0d                	cmp    $0xd,%al
 277:	74 0b                	je     284 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 279:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 282:	7c b1                	jl     235 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 284:	8b 55 f4             	mov    -0xc(%ebp),%edx
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	01 d0                	add    %edx,%eax
 28c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 292:	c9                   	leave  
 293:	c3                   	ret    

00000294 <stat>:

int
stat(char *n, struct stat *st)
{
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29a:	83 ec 08             	sub    $0x8,%esp
 29d:	6a 00                	push   $0x0
 29f:	ff 75 08             	pushl  0x8(%ebp)
 2a2:	e8 0c 01 00 00       	call   3b3 <open>
 2a7:	83 c4 10             	add    $0x10,%esp
 2aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b1:	79 07                	jns    2ba <stat+0x26>
    return -1;
 2b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2b8:	eb 25                	jmp    2df <stat+0x4b>
  r = fstat(fd, st);
 2ba:	83 ec 08             	sub    $0x8,%esp
 2bd:	ff 75 0c             	pushl  0xc(%ebp)
 2c0:	ff 75 f4             	pushl  -0xc(%ebp)
 2c3:	e8 03 01 00 00       	call   3cb <fstat>
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2ce:	83 ec 0c             	sub    $0xc,%esp
 2d1:	ff 75 f4             	pushl  -0xc(%ebp)
 2d4:	e8 c2 00 00 00       	call   39b <close>
 2d9:	83 c4 10             	add    $0x10,%esp
  return r;
 2dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2df:	c9                   	leave  
 2e0:	c3                   	ret    

000002e1 <atoi>:

int
atoi(const char *s)
{
 2e1:	55                   	push   %ebp
 2e2:	89 e5                	mov    %esp,%ebp
 2e4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2ee:	eb 25                	jmp    315 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f3:	89 d0                	mov    %edx,%eax
 2f5:	c1 e0 02             	shl    $0x2,%eax
 2f8:	01 d0                	add    %edx,%eax
 2fa:	01 c0                	add    %eax,%eax
 2fc:	89 c1                	mov    %eax,%ecx
 2fe:	8b 45 08             	mov    0x8(%ebp),%eax
 301:	8d 50 01             	lea    0x1(%eax),%edx
 304:	89 55 08             	mov    %edx,0x8(%ebp)
 307:	0f b6 00             	movzbl (%eax),%eax
 30a:	0f be c0             	movsbl %al,%eax
 30d:	01 c8                	add    %ecx,%eax
 30f:	83 e8 30             	sub    $0x30,%eax
 312:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 315:	8b 45 08             	mov    0x8(%ebp),%eax
 318:	0f b6 00             	movzbl (%eax),%eax
 31b:	3c 2f                	cmp    $0x2f,%al
 31d:	7e 0a                	jle    329 <atoi+0x48>
 31f:	8b 45 08             	mov    0x8(%ebp),%eax
 322:	0f b6 00             	movzbl (%eax),%eax
 325:	3c 39                	cmp    $0x39,%al
 327:	7e c7                	jle    2f0 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 329:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 32c:	c9                   	leave  
 32d:	c3                   	ret    

0000032e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 32e:	55                   	push   %ebp
 32f:	89 e5                	mov    %esp,%ebp
 331:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 340:	eb 17                	jmp    359 <memmove+0x2b>
    *dst++ = *src++;
 342:	8b 45 fc             	mov    -0x4(%ebp),%eax
 345:	8d 50 01             	lea    0x1(%eax),%edx
 348:	89 55 fc             	mov    %edx,-0x4(%ebp)
 34b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 34e:	8d 4a 01             	lea    0x1(%edx),%ecx
 351:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 354:	0f b6 12             	movzbl (%edx),%edx
 357:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 359:	8b 45 10             	mov    0x10(%ebp),%eax
 35c:	8d 50 ff             	lea    -0x1(%eax),%edx
 35f:	89 55 10             	mov    %edx,0x10(%ebp)
 362:	85 c0                	test   %eax,%eax
 364:	7f dc                	jg     342 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 366:	8b 45 08             	mov    0x8(%ebp),%eax
}
 369:	c9                   	leave  
 36a:	c3                   	ret    

0000036b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36b:	b8 01 00 00 00       	mov    $0x1,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <exit>:
SYSCALL(exit)
 373:	b8 02 00 00 00       	mov    $0x2,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <wait>:
SYSCALL(wait)
 37b:	b8 03 00 00 00       	mov    $0x3,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <pipe>:
SYSCALL(pipe)
 383:	b8 04 00 00 00       	mov    $0x4,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <read>:
SYSCALL(read)
 38b:	b8 05 00 00 00       	mov    $0x5,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <write>:
SYSCALL(write)
 393:	b8 10 00 00 00       	mov    $0x10,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <close>:
SYSCALL(close)
 39b:	b8 15 00 00 00       	mov    $0x15,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <kill>:
SYSCALL(kill)
 3a3:	b8 06 00 00 00       	mov    $0x6,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <exec>:
SYSCALL(exec)
 3ab:	b8 07 00 00 00       	mov    $0x7,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <open>:
SYSCALL(open)
 3b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mknod>:
SYSCALL(mknod)
 3bb:	b8 11 00 00 00       	mov    $0x11,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <unlink>:
SYSCALL(unlink)
 3c3:	b8 12 00 00 00       	mov    $0x12,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <fstat>:
SYSCALL(fstat)
 3cb:	b8 08 00 00 00       	mov    $0x8,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <link>:
SYSCALL(link)
 3d3:	b8 13 00 00 00       	mov    $0x13,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <mkdir>:
SYSCALL(mkdir)
 3db:	b8 14 00 00 00       	mov    $0x14,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <chdir>:
SYSCALL(chdir)
 3e3:	b8 09 00 00 00       	mov    $0x9,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <dup>:
SYSCALL(dup)
 3eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <getpid>:
SYSCALL(getpid)
 3f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <sbrk>:
SYSCALL(sbrk)
 3fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <sleep>:
SYSCALL(sleep)
 403:	b8 0d 00 00 00       	mov    $0xd,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <uptime>:
SYSCALL(uptime)
 40b:	b8 0e 00 00 00       	mov    $0xe,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <pstat>:
SYSCALL(pstat)
 413:	b8 16 00 00 00       	mov    $0x16,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 41b:	55                   	push   %ebp
 41c:	89 e5                	mov    %esp,%ebp
 41e:	83 ec 18             	sub    $0x18,%esp
 421:	8b 45 0c             	mov    0xc(%ebp),%eax
 424:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 427:	83 ec 04             	sub    $0x4,%esp
 42a:	6a 01                	push   $0x1
 42c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 42f:	50                   	push   %eax
 430:	ff 75 08             	pushl  0x8(%ebp)
 433:	e8 5b ff ff ff       	call   393 <write>
 438:	83 c4 10             	add    $0x10,%esp
}
 43b:	c9                   	leave  
 43c:	c3                   	ret    

0000043d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 43d:	55                   	push   %ebp
 43e:	89 e5                	mov    %esp,%ebp
 440:	53                   	push   %ebx
 441:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 444:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 44b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 44f:	74 17                	je     468 <printint+0x2b>
 451:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 455:	79 11                	jns    468 <printint+0x2b>
    neg = 1;
 457:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 45e:	8b 45 0c             	mov    0xc(%ebp),%eax
 461:	f7 d8                	neg    %eax
 463:	89 45 ec             	mov    %eax,-0x14(%ebp)
 466:	eb 06                	jmp    46e <printint+0x31>
  } else {
    x = xx;
 468:	8b 45 0c             	mov    0xc(%ebp),%eax
 46b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 46e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 475:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 478:	8d 41 01             	lea    0x1(%ecx),%eax
 47b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 47e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 481:	8b 45 ec             	mov    -0x14(%ebp),%eax
 484:	ba 00 00 00 00       	mov    $0x0,%edx
 489:	f7 f3                	div    %ebx
 48b:	89 d0                	mov    %edx,%eax
 48d:	0f b6 80 4c 0b 00 00 	movzbl 0xb4c(%eax),%eax
 494:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 498:	8b 5d 10             	mov    0x10(%ebp),%ebx
 49b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 49e:	ba 00 00 00 00       	mov    $0x0,%edx
 4a3:	f7 f3                	div    %ebx
 4a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ac:	75 c7                	jne    475 <printint+0x38>
  if(neg)
 4ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b2:	74 0e                	je     4c2 <printint+0x85>
    buf[i++] = '-';
 4b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4b7:	8d 50 01             	lea    0x1(%eax),%edx
 4ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4bd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4c2:	eb 1d                	jmp    4e1 <printint+0xa4>
    putc(fd, buf[i]);
 4c4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ca:	01 d0                	add    %edx,%eax
 4cc:	0f b6 00             	movzbl (%eax),%eax
 4cf:	0f be c0             	movsbl %al,%eax
 4d2:	83 ec 08             	sub    $0x8,%esp
 4d5:	50                   	push   %eax
 4d6:	ff 75 08             	pushl  0x8(%ebp)
 4d9:	e8 3d ff ff ff       	call   41b <putc>
 4de:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e9:	79 d9                	jns    4c4 <printint+0x87>
    putc(fd, buf[i]);
}
 4eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4ee:	c9                   	leave  
 4ef:	c3                   	ret    

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4fd:	8d 45 0c             	lea    0xc(%ebp),%eax
 500:	83 c0 04             	add    $0x4,%eax
 503:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 506:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 50d:	e9 59 01 00 00       	jmp    66b <printf+0x17b>
    c = fmt[i] & 0xff;
 512:	8b 55 0c             	mov    0xc(%ebp),%edx
 515:	8b 45 f0             	mov    -0x10(%ebp),%eax
 518:	01 d0                	add    %edx,%eax
 51a:	0f b6 00             	movzbl (%eax),%eax
 51d:	0f be c0             	movsbl %al,%eax
 520:	25 ff 00 00 00       	and    $0xff,%eax
 525:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 528:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 52c:	75 2c                	jne    55a <printf+0x6a>
      if(c == '%'){
 52e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 532:	75 0c                	jne    540 <printf+0x50>
        state = '%';
 534:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 53b:	e9 27 01 00 00       	jmp    667 <printf+0x177>
      } else {
        putc(fd, c);
 540:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 543:	0f be c0             	movsbl %al,%eax
 546:	83 ec 08             	sub    $0x8,%esp
 549:	50                   	push   %eax
 54a:	ff 75 08             	pushl  0x8(%ebp)
 54d:	e8 c9 fe ff ff       	call   41b <putc>
 552:	83 c4 10             	add    $0x10,%esp
 555:	e9 0d 01 00 00       	jmp    667 <printf+0x177>
      }
    } else if(state == '%'){
 55a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 55e:	0f 85 03 01 00 00    	jne    667 <printf+0x177>
      if(c == 'd'){
 564:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 568:	75 1e                	jne    588 <printf+0x98>
        printint(fd, *ap, 10, 1);
 56a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56d:	8b 00                	mov    (%eax),%eax
 56f:	6a 01                	push   $0x1
 571:	6a 0a                	push   $0xa
 573:	50                   	push   %eax
 574:	ff 75 08             	pushl  0x8(%ebp)
 577:	e8 c1 fe ff ff       	call   43d <printint>
 57c:	83 c4 10             	add    $0x10,%esp
        ap++;
 57f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 583:	e9 d8 00 00 00       	jmp    660 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 588:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 58c:	74 06                	je     594 <printf+0xa4>
 58e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 592:	75 1e                	jne    5b2 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 594:	8b 45 e8             	mov    -0x18(%ebp),%eax
 597:	8b 00                	mov    (%eax),%eax
 599:	6a 00                	push   $0x0
 59b:	6a 10                	push   $0x10
 59d:	50                   	push   %eax
 59e:	ff 75 08             	pushl  0x8(%ebp)
 5a1:	e8 97 fe ff ff       	call   43d <printint>
 5a6:	83 c4 10             	add    $0x10,%esp
        ap++;
 5a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ad:	e9 ae 00 00 00       	jmp    660 <printf+0x170>
      } else if(c == 's'){
 5b2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5b6:	75 43                	jne    5fb <printf+0x10b>
        s = (char*)*ap;
 5b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bb:	8b 00                	mov    (%eax),%eax
 5bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c8:	75 07                	jne    5d1 <printf+0xe1>
          s = "(null)";
 5ca:	c7 45 f4 f4 08 00 00 	movl   $0x8f4,-0xc(%ebp)
        while(*s != 0){
 5d1:	eb 1c                	jmp    5ef <printf+0xff>
          putc(fd, *s);
 5d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d6:	0f b6 00             	movzbl (%eax),%eax
 5d9:	0f be c0             	movsbl %al,%eax
 5dc:	83 ec 08             	sub    $0x8,%esp
 5df:	50                   	push   %eax
 5e0:	ff 75 08             	pushl  0x8(%ebp)
 5e3:	e8 33 fe ff ff       	call   41b <putc>
 5e8:	83 c4 10             	add    $0x10,%esp
          s++;
 5eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f2:	0f b6 00             	movzbl (%eax),%eax
 5f5:	84 c0                	test   %al,%al
 5f7:	75 da                	jne    5d3 <printf+0xe3>
 5f9:	eb 65                	jmp    660 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5fb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ff:	75 1d                	jne    61e <printf+0x12e>
        putc(fd, *ap);
 601:	8b 45 e8             	mov    -0x18(%ebp),%eax
 604:	8b 00                	mov    (%eax),%eax
 606:	0f be c0             	movsbl %al,%eax
 609:	83 ec 08             	sub    $0x8,%esp
 60c:	50                   	push   %eax
 60d:	ff 75 08             	pushl  0x8(%ebp)
 610:	e8 06 fe ff ff       	call   41b <putc>
 615:	83 c4 10             	add    $0x10,%esp
        ap++;
 618:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61c:	eb 42                	jmp    660 <printf+0x170>
      } else if(c == '%'){
 61e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 622:	75 17                	jne    63b <printf+0x14b>
        putc(fd, c);
 624:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 627:	0f be c0             	movsbl %al,%eax
 62a:	83 ec 08             	sub    $0x8,%esp
 62d:	50                   	push   %eax
 62e:	ff 75 08             	pushl  0x8(%ebp)
 631:	e8 e5 fd ff ff       	call   41b <putc>
 636:	83 c4 10             	add    $0x10,%esp
 639:	eb 25                	jmp    660 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63b:	83 ec 08             	sub    $0x8,%esp
 63e:	6a 25                	push   $0x25
 640:	ff 75 08             	pushl  0x8(%ebp)
 643:	e8 d3 fd ff ff       	call   41b <putc>
 648:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 64b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64e:	0f be c0             	movsbl %al,%eax
 651:	83 ec 08             	sub    $0x8,%esp
 654:	50                   	push   %eax
 655:	ff 75 08             	pushl  0x8(%ebp)
 658:	e8 be fd ff ff       	call   41b <putc>
 65d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 660:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 667:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 66b:	8b 55 0c             	mov    0xc(%ebp),%edx
 66e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 671:	01 d0                	add    %edx,%eax
 673:	0f b6 00             	movzbl (%eax),%eax
 676:	84 c0                	test   %al,%al
 678:	0f 85 94 fe ff ff    	jne    512 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 67e:	c9                   	leave  
 67f:	c3                   	ret    

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 686:	8b 45 08             	mov    0x8(%ebp),%eax
 689:	83 e8 08             	sub    $0x8,%eax
 68c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68f:	a1 68 0b 00 00       	mov    0xb68,%eax
 694:	89 45 fc             	mov    %eax,-0x4(%ebp)
 697:	eb 24                	jmp    6bd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a1:	77 12                	ja     6b5 <free+0x35>
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a9:	77 24                	ja     6cf <free+0x4f>
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 00                	mov    (%eax),%eax
 6b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b3:	77 1a                	ja     6cf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c3:	76 d4                	jbe    699 <free+0x19>
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	8b 00                	mov    (%eax),%eax
 6ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cd:	76 ca                	jbe    699 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d2:	8b 40 04             	mov    0x4(%eax),%eax
 6d5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6df:	01 c2                	add    %eax,%edx
 6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e4:	8b 00                	mov    (%eax),%eax
 6e6:	39 c2                	cmp    %eax,%edx
 6e8:	75 24                	jne    70e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 00                	mov    (%eax),%eax
 6f5:	8b 40 04             	mov    0x4(%eax),%eax
 6f8:	01 c2                	add    %eax,%edx
 6fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 700:	8b 45 fc             	mov    -0x4(%ebp),%eax
 703:	8b 00                	mov    (%eax),%eax
 705:	8b 10                	mov    (%eax),%edx
 707:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70a:	89 10                	mov    %edx,(%eax)
 70c:	eb 0a                	jmp    718 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 711:	8b 10                	mov    (%eax),%edx
 713:	8b 45 f8             	mov    -0x8(%ebp),%eax
 716:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 718:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71b:	8b 40 04             	mov    0x4(%eax),%eax
 71e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	01 d0                	add    %edx,%eax
 72a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72d:	75 20                	jne    74f <free+0xcf>
    p->s.size += bp->s.size;
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	8b 50 04             	mov    0x4(%eax),%edx
 735:	8b 45 f8             	mov    -0x8(%ebp),%eax
 738:	8b 40 04             	mov    0x4(%eax),%eax
 73b:	01 c2                	add    %eax,%edx
 73d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 740:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 743:	8b 45 f8             	mov    -0x8(%ebp),%eax
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74b:	89 10                	mov    %edx,(%eax)
 74d:	eb 08                	jmp    757 <free+0xd7>
  } else
    p->s.ptr = bp;
 74f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 752:	8b 55 f8             	mov    -0x8(%ebp),%edx
 755:	89 10                	mov    %edx,(%eax)
  freep = p;
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	a3 68 0b 00 00       	mov    %eax,0xb68
}
 75f:	c9                   	leave  
 760:	c3                   	ret    

00000761 <morecore>:

static Header*
morecore(uint nu)
{
 761:	55                   	push   %ebp
 762:	89 e5                	mov    %esp,%ebp
 764:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 767:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 76e:	77 07                	ja     777 <morecore+0x16>
    nu = 4096;
 770:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 777:	8b 45 08             	mov    0x8(%ebp),%eax
 77a:	c1 e0 03             	shl    $0x3,%eax
 77d:	83 ec 0c             	sub    $0xc,%esp
 780:	50                   	push   %eax
 781:	e8 75 fc ff ff       	call   3fb <sbrk>
 786:	83 c4 10             	add    $0x10,%esp
 789:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 78c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 790:	75 07                	jne    799 <morecore+0x38>
    return 0;
 792:	b8 00 00 00 00       	mov    $0x0,%eax
 797:	eb 26                	jmp    7bf <morecore+0x5e>
  hp = (Header*)p;
 799:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a2:	8b 55 08             	mov    0x8(%ebp),%edx
 7a5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	83 c0 08             	add    $0x8,%eax
 7ae:	83 ec 0c             	sub    $0xc,%esp
 7b1:	50                   	push   %eax
 7b2:	e8 c9 fe ff ff       	call   680 <free>
 7b7:	83 c4 10             	add    $0x10,%esp
  return freep;
 7ba:	a1 68 0b 00 00       	mov    0xb68,%eax
}
 7bf:	c9                   	leave  
 7c0:	c3                   	ret    

000007c1 <malloc>:

void*
malloc(uint nbytes)
{
 7c1:	55                   	push   %ebp
 7c2:	89 e5                	mov    %esp,%ebp
 7c4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c7:	8b 45 08             	mov    0x8(%ebp),%eax
 7ca:	83 c0 07             	add    $0x7,%eax
 7cd:	c1 e8 03             	shr    $0x3,%eax
 7d0:	83 c0 01             	add    $0x1,%eax
 7d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7d6:	a1 68 0b 00 00       	mov    0xb68,%eax
 7db:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e2:	75 23                	jne    807 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7e4:	c7 45 f0 60 0b 00 00 	movl   $0xb60,-0x10(%ebp)
 7eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ee:	a3 68 0b 00 00       	mov    %eax,0xb68
 7f3:	a1 68 0b 00 00       	mov    0xb68,%eax
 7f8:	a3 60 0b 00 00       	mov    %eax,0xb60
    base.s.size = 0;
 7fd:	c7 05 64 0b 00 00 00 	movl   $0x0,0xb64
 804:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 807:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80a:	8b 00                	mov    (%eax),%eax
 80c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	8b 40 04             	mov    0x4(%eax),%eax
 815:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 818:	72 4d                	jb     867 <malloc+0xa6>
      if(p->s.size == nunits)
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	8b 40 04             	mov    0x4(%eax),%eax
 820:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 823:	75 0c                	jne    831 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 825:	8b 45 f4             	mov    -0xc(%ebp),%eax
 828:	8b 10                	mov    (%eax),%edx
 82a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82d:	89 10                	mov    %edx,(%eax)
 82f:	eb 26                	jmp    857 <malloc+0x96>
      else {
        p->s.size -= nunits;
 831:	8b 45 f4             	mov    -0xc(%ebp),%eax
 834:	8b 40 04             	mov    0x4(%eax),%eax
 837:	2b 45 ec             	sub    -0x14(%ebp),%eax
 83a:	89 c2                	mov    %eax,%edx
 83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 842:	8b 45 f4             	mov    -0xc(%ebp),%eax
 845:	8b 40 04             	mov    0x4(%eax),%eax
 848:	c1 e0 03             	shl    $0x3,%eax
 84b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 84e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 851:	8b 55 ec             	mov    -0x14(%ebp),%edx
 854:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 857:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85a:	a3 68 0b 00 00       	mov    %eax,0xb68
      return (void*)(p + 1);
 85f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 862:	83 c0 08             	add    $0x8,%eax
 865:	eb 3b                	jmp    8a2 <malloc+0xe1>
    }
    if(p == freep)
 867:	a1 68 0b 00 00       	mov    0xb68,%eax
 86c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 86f:	75 1e                	jne    88f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 871:	83 ec 0c             	sub    $0xc,%esp
 874:	ff 75 ec             	pushl  -0x14(%ebp)
 877:	e8 e5 fe ff ff       	call   761 <morecore>
 87c:	83 c4 10             	add    $0x10,%esp
 87f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 882:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 886:	75 07                	jne    88f <malloc+0xce>
        return 0;
 888:	b8 00 00 00 00       	mov    $0x0,%eax
 88d:	eb 13                	jmp    8a2 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 892:	89 45 f0             	mov    %eax,-0x10(%ebp)
 895:	8b 45 f4             	mov    -0xc(%ebp),%eax
 898:	8b 00                	mov    (%eax),%eax
 89a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 89d:	e9 6d ff ff ff       	jmp    80f <malloc+0x4e>
}
 8a2:	c9                   	leave  
 8a3:	c3                   	ret    
