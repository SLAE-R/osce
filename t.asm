
_t:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

char *argv[] ={"cat", 0};

int main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
	kill(2);
  11:	83 ec 0c             	sub    $0xc,%esp
  14:	6a 02                	push   $0x2
  16:	e8 c1 02 00 00       	call   2dc <kill>
  1b:	83 c4 10             	add    $0x10,%esp
	sleep(1);
  1e:	83 ec 0c             	sub    $0xc,%esp
  21:	6a 01                	push   $0x1
  23:	e8 14 03 00 00       	call   33c <sleep>
  28:	83 c4 10             	add    $0x10,%esp
	if (fork()==0) {
  2b:	e8 74 02 00 00       	call   2a4 <fork>
  30:	85 c0                	test   %eax,%eax
  32:	75 16                	jne    4a <main+0x4a>
		exec(argv[0], argv);
  34:	a1 38 0a 00 00       	mov    0xa38,%eax
  39:	83 ec 08             	sub    $0x8,%esp
  3c:	68 38 0a 00 00       	push   $0xa38
  41:	50                   	push   %eax
  42:	e8 9d 02 00 00       	call   2e4 <exec>
  47:	83 c4 10             	add    $0x10,%esp
	}
	return 0;
  4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  4f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  52:	c9                   	leave  
  53:	8d 61 fc             	lea    -0x4(%ecx),%esp
  56:	c3                   	ret    

00000057 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  57:	55                   	push   %ebp
  58:	89 e5                	mov    %esp,%ebp
  5a:	57                   	push   %edi
  5b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  5c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  5f:	8b 55 10             	mov    0x10(%ebp),%edx
  62:	8b 45 0c             	mov    0xc(%ebp),%eax
  65:	89 cb                	mov    %ecx,%ebx
  67:	89 df                	mov    %ebx,%edi
  69:	89 d1                	mov    %edx,%ecx
  6b:	fc                   	cld    
  6c:	f3 aa                	rep stos %al,%es:(%edi)
  6e:	89 ca                	mov    %ecx,%edx
  70:	89 fb                	mov    %edi,%ebx
  72:	89 5d 08             	mov    %ebx,0x8(%ebp)
  75:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  78:	5b                   	pop    %ebx
  79:	5f                   	pop    %edi
  7a:	5d                   	pop    %ebp
  7b:	c3                   	ret    

0000007c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  7c:	55                   	push   %ebp
  7d:	89 e5                	mov    %esp,%ebp
  7f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  82:	8b 45 08             	mov    0x8(%ebp),%eax
  85:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  88:	90                   	nop
  89:	8b 45 08             	mov    0x8(%ebp),%eax
  8c:	8d 50 01             	lea    0x1(%eax),%edx
  8f:	89 55 08             	mov    %edx,0x8(%ebp)
  92:	8b 55 0c             	mov    0xc(%ebp),%edx
  95:	8d 4a 01             	lea    0x1(%edx),%ecx
  98:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  9b:	0f b6 12             	movzbl (%edx),%edx
  9e:	88 10                	mov    %dl,(%eax)
  a0:	0f b6 00             	movzbl (%eax),%eax
  a3:	84 c0                	test   %al,%al
  a5:	75 e2                	jne    89 <strcpy+0xd>
    ;
  return os;
  a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  aa:	c9                   	leave  
  ab:	c3                   	ret    

000000ac <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ac:	55                   	push   %ebp
  ad:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  af:	eb 08                	jmp    b9 <strcmp+0xd>
    p++, q++;
  b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b9:	8b 45 08             	mov    0x8(%ebp),%eax
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	84 c0                	test   %al,%al
  c1:	74 10                	je     d3 <strcmp+0x27>
  c3:	8b 45 08             	mov    0x8(%ebp),%eax
  c6:	0f b6 10             	movzbl (%eax),%edx
  c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  cc:	0f b6 00             	movzbl (%eax),%eax
  cf:	38 c2                	cmp    %al,%dl
  d1:	74 de                	je     b1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	0f b6 00             	movzbl (%eax),%eax
  d9:	0f b6 d0             	movzbl %al,%edx
  dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  df:	0f b6 00             	movzbl (%eax),%eax
  e2:	0f b6 c0             	movzbl %al,%eax
  e5:	29 c2                	sub    %eax,%edx
  e7:	89 d0                	mov    %edx,%eax
}
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    

000000eb <strlen>:

uint
strlen(char *s)
{
  eb:	55                   	push   %ebp
  ec:	89 e5                	mov    %esp,%ebp
  ee:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  f8:	eb 04                	jmp    fe <strlen+0x13>
  fa:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
 101:	8b 45 08             	mov    0x8(%ebp),%eax
 104:	01 d0                	add    %edx,%eax
 106:	0f b6 00             	movzbl (%eax),%eax
 109:	84 c0                	test   %al,%al
 10b:	75 ed                	jne    fa <strlen+0xf>
    ;
  return n;
 10d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 110:	c9                   	leave  
 111:	c3                   	ret    

00000112 <memset>:

void*
memset(void *dst, int c, uint n)
{
 112:	55                   	push   %ebp
 113:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 115:	8b 45 10             	mov    0x10(%ebp),%eax
 118:	50                   	push   %eax
 119:	ff 75 0c             	pushl  0xc(%ebp)
 11c:	ff 75 08             	pushl  0x8(%ebp)
 11f:	e8 33 ff ff ff       	call   57 <stosb>
 124:	83 c4 0c             	add    $0xc,%esp
  return dst;
 127:	8b 45 08             	mov    0x8(%ebp),%eax
}
 12a:	c9                   	leave  
 12b:	c3                   	ret    

0000012c <strchr>:

char*
strchr(const char *s, char c)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	83 ec 04             	sub    $0x4,%esp
 132:	8b 45 0c             	mov    0xc(%ebp),%eax
 135:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 138:	eb 14                	jmp    14e <strchr+0x22>
    if(*s == c)
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
 13d:	0f b6 00             	movzbl (%eax),%eax
 140:	3a 45 fc             	cmp    -0x4(%ebp),%al
 143:	75 05                	jne    14a <strchr+0x1e>
      return (char*)s;
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	eb 13                	jmp    15d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 14a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
 151:	0f b6 00             	movzbl (%eax),%eax
 154:	84 c0                	test   %al,%al
 156:	75 e2                	jne    13a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 158:	b8 00 00 00 00       	mov    $0x0,%eax
}
 15d:	c9                   	leave  
 15e:	c3                   	ret    

0000015f <gets>:

char*
gets(char *buf, int max)
{
 15f:	55                   	push   %ebp
 160:	89 e5                	mov    %esp,%ebp
 162:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 165:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 16c:	eb 44                	jmp    1b2 <gets+0x53>
    cc = read(0, &c, 1);
 16e:	83 ec 04             	sub    $0x4,%esp
 171:	6a 01                	push   $0x1
 173:	8d 45 ef             	lea    -0x11(%ebp),%eax
 176:	50                   	push   %eax
 177:	6a 00                	push   $0x0
 179:	e8 46 01 00 00       	call   2c4 <read>
 17e:	83 c4 10             	add    $0x10,%esp
 181:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 184:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 188:	7f 02                	jg     18c <gets+0x2d>
      break;
 18a:	eb 31                	jmp    1bd <gets+0x5e>
    buf[i++] = c;
 18c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18f:	8d 50 01             	lea    0x1(%eax),%edx
 192:	89 55 f4             	mov    %edx,-0xc(%ebp)
 195:	89 c2                	mov    %eax,%edx
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	01 c2                	add    %eax,%edx
 19c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1a2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a6:	3c 0a                	cmp    $0xa,%al
 1a8:	74 13                	je     1bd <gets+0x5e>
 1aa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ae:	3c 0d                	cmp    $0xd,%al
 1b0:	74 0b                	je     1bd <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b5:	83 c0 01             	add    $0x1,%eax
 1b8:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1bb:	7c b1                	jl     16e <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	01 d0                	add    %edx,%eax
 1c5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1cb:	c9                   	leave  
 1cc:	c3                   	ret    

000001cd <stat>:

int
stat(char *n, struct stat *st)
{
 1cd:	55                   	push   %ebp
 1ce:	89 e5                	mov    %esp,%ebp
 1d0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d3:	83 ec 08             	sub    $0x8,%esp
 1d6:	6a 00                	push   $0x0
 1d8:	ff 75 08             	pushl  0x8(%ebp)
 1db:	e8 0c 01 00 00       	call   2ec <open>
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1ea:	79 07                	jns    1f3 <stat+0x26>
    return -1;
 1ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1f1:	eb 25                	jmp    218 <stat+0x4b>
  r = fstat(fd, st);
 1f3:	83 ec 08             	sub    $0x8,%esp
 1f6:	ff 75 0c             	pushl  0xc(%ebp)
 1f9:	ff 75 f4             	pushl  -0xc(%ebp)
 1fc:	e8 03 01 00 00       	call   304 <fstat>
 201:	83 c4 10             	add    $0x10,%esp
 204:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 207:	83 ec 0c             	sub    $0xc,%esp
 20a:	ff 75 f4             	pushl  -0xc(%ebp)
 20d:	e8 c2 00 00 00       	call   2d4 <close>
 212:	83 c4 10             	add    $0x10,%esp
  return r;
 215:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 218:	c9                   	leave  
 219:	c3                   	ret    

0000021a <atoi>:

int
atoi(const char *s)
{
 21a:	55                   	push   %ebp
 21b:	89 e5                	mov    %esp,%ebp
 21d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 220:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 227:	eb 25                	jmp    24e <atoi+0x34>
    n = n*10 + *s++ - '0';
 229:	8b 55 fc             	mov    -0x4(%ebp),%edx
 22c:	89 d0                	mov    %edx,%eax
 22e:	c1 e0 02             	shl    $0x2,%eax
 231:	01 d0                	add    %edx,%eax
 233:	01 c0                	add    %eax,%eax
 235:	89 c1                	mov    %eax,%ecx
 237:	8b 45 08             	mov    0x8(%ebp),%eax
 23a:	8d 50 01             	lea    0x1(%eax),%edx
 23d:	89 55 08             	mov    %edx,0x8(%ebp)
 240:	0f b6 00             	movzbl (%eax),%eax
 243:	0f be c0             	movsbl %al,%eax
 246:	01 c8                	add    %ecx,%eax
 248:	83 e8 30             	sub    $0x30,%eax
 24b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	0f b6 00             	movzbl (%eax),%eax
 254:	3c 2f                	cmp    $0x2f,%al
 256:	7e 0a                	jle    262 <atoi+0x48>
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	0f b6 00             	movzbl (%eax),%eax
 25e:	3c 39                	cmp    $0x39,%al
 260:	7e c7                	jle    229 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 262:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 265:	c9                   	leave  
 266:	c3                   	ret    

00000267 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 267:	55                   	push   %ebp
 268:	89 e5                	mov    %esp,%ebp
 26a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 273:	8b 45 0c             	mov    0xc(%ebp),%eax
 276:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 279:	eb 17                	jmp    292 <memmove+0x2b>
    *dst++ = *src++;
 27b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 27e:	8d 50 01             	lea    0x1(%eax),%edx
 281:	89 55 fc             	mov    %edx,-0x4(%ebp)
 284:	8b 55 f8             	mov    -0x8(%ebp),%edx
 287:	8d 4a 01             	lea    0x1(%edx),%ecx
 28a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 28d:	0f b6 12             	movzbl (%edx),%edx
 290:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 292:	8b 45 10             	mov    0x10(%ebp),%eax
 295:	8d 50 ff             	lea    -0x1(%eax),%edx
 298:	89 55 10             	mov    %edx,0x10(%ebp)
 29b:	85 c0                	test   %eax,%eax
 29d:	7f dc                	jg     27b <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 29f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a2:	c9                   	leave  
 2a3:	c3                   	ret    

000002a4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a4:	b8 01 00 00 00       	mov    $0x1,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <exit>:
SYSCALL(exit)
 2ac:	b8 02 00 00 00       	mov    $0x2,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <wait>:
SYSCALL(wait)
 2b4:	b8 03 00 00 00       	mov    $0x3,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <pipe>:
SYSCALL(pipe)
 2bc:	b8 04 00 00 00       	mov    $0x4,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <read>:
SYSCALL(read)
 2c4:	b8 05 00 00 00       	mov    $0x5,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <write>:
SYSCALL(write)
 2cc:	b8 10 00 00 00       	mov    $0x10,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <close>:
SYSCALL(close)
 2d4:	b8 15 00 00 00       	mov    $0x15,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <kill>:
SYSCALL(kill)
 2dc:	b8 06 00 00 00       	mov    $0x6,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <exec>:
SYSCALL(exec)
 2e4:	b8 07 00 00 00       	mov    $0x7,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <open>:
SYSCALL(open)
 2ec:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <mknod>:
SYSCALL(mknod)
 2f4:	b8 11 00 00 00       	mov    $0x11,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <unlink>:
SYSCALL(unlink)
 2fc:	b8 12 00 00 00       	mov    $0x12,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <fstat>:
SYSCALL(fstat)
 304:	b8 08 00 00 00       	mov    $0x8,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <link>:
SYSCALL(link)
 30c:	b8 13 00 00 00       	mov    $0x13,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <mkdir>:
SYSCALL(mkdir)
 314:	b8 14 00 00 00       	mov    $0x14,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <chdir>:
SYSCALL(chdir)
 31c:	b8 09 00 00 00       	mov    $0x9,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <dup>:
SYSCALL(dup)
 324:	b8 0a 00 00 00       	mov    $0xa,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <getpid>:
SYSCALL(getpid)
 32c:	b8 0b 00 00 00       	mov    $0xb,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <sbrk>:
SYSCALL(sbrk)
 334:	b8 0c 00 00 00       	mov    $0xc,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <sleep>:
SYSCALL(sleep)
 33c:	b8 0d 00 00 00       	mov    $0xd,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <uptime>:
SYSCALL(uptime)
 344:	b8 0e 00 00 00       	mov    $0xe,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <pstat>:
SYSCALL(pstat)
 34c:	b8 16 00 00 00       	mov    $0x16,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	83 ec 18             	sub    $0x18,%esp
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 360:	83 ec 04             	sub    $0x4,%esp
 363:	6a 01                	push   $0x1
 365:	8d 45 f4             	lea    -0xc(%ebp),%eax
 368:	50                   	push   %eax
 369:	ff 75 08             	pushl  0x8(%ebp)
 36c:	e8 5b ff ff ff       	call   2cc <write>
 371:	83 c4 10             	add    $0x10,%esp
}
 374:	c9                   	leave  
 375:	c3                   	ret    

00000376 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 376:	55                   	push   %ebp
 377:	89 e5                	mov    %esp,%ebp
 379:	53                   	push   %ebx
 37a:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 37d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 384:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 388:	74 17                	je     3a1 <printint+0x2b>
 38a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 38e:	79 11                	jns    3a1 <printint+0x2b>
    neg = 1;
 390:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 397:	8b 45 0c             	mov    0xc(%ebp),%eax
 39a:	f7 d8                	neg    %eax
 39c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39f:	eb 06                	jmp    3a7 <printint+0x31>
  } else {
    x = xx;
 3a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ae:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3b1:	8d 41 01             	lea    0x1(%ecx),%eax
 3b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3b7:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3bd:	ba 00 00 00 00       	mov    $0x0,%edx
 3c2:	f7 f3                	div    %ebx
 3c4:	89 d0                	mov    %edx,%eax
 3c6:	0f b6 80 40 0a 00 00 	movzbl 0xa40(%eax),%eax
 3cd:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3d1:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d7:	ba 00 00 00 00       	mov    $0x0,%edx
 3dc:	f7 f3                	div    %ebx
 3de:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3e5:	75 c7                	jne    3ae <printint+0x38>
  if(neg)
 3e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3eb:	74 0e                	je     3fb <printint+0x85>
    buf[i++] = '-';
 3ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f0:	8d 50 01             	lea    0x1(%eax),%edx
 3f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3fb:	eb 1d                	jmp    41a <printint+0xa4>
    putc(fd, buf[i]);
 3fd:	8d 55 dc             	lea    -0x24(%ebp),%edx
 400:	8b 45 f4             	mov    -0xc(%ebp),%eax
 403:	01 d0                	add    %edx,%eax
 405:	0f b6 00             	movzbl (%eax),%eax
 408:	0f be c0             	movsbl %al,%eax
 40b:	83 ec 08             	sub    $0x8,%esp
 40e:	50                   	push   %eax
 40f:	ff 75 08             	pushl  0x8(%ebp)
 412:	e8 3d ff ff ff       	call   354 <putc>
 417:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 41a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 41e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 422:	79 d9                	jns    3fd <printint+0x87>
    putc(fd, buf[i]);
}
 424:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 427:	c9                   	leave  
 428:	c3                   	ret    

00000429 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 429:	55                   	push   %ebp
 42a:	89 e5                	mov    %esp,%ebp
 42c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 42f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 436:	8d 45 0c             	lea    0xc(%ebp),%eax
 439:	83 c0 04             	add    $0x4,%eax
 43c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 43f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 446:	e9 59 01 00 00       	jmp    5a4 <printf+0x17b>
    c = fmt[i] & 0xff;
 44b:	8b 55 0c             	mov    0xc(%ebp),%edx
 44e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 451:	01 d0                	add    %edx,%eax
 453:	0f b6 00             	movzbl (%eax),%eax
 456:	0f be c0             	movsbl %al,%eax
 459:	25 ff 00 00 00       	and    $0xff,%eax
 45e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 461:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 465:	75 2c                	jne    493 <printf+0x6a>
      if(c == '%'){
 467:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 46b:	75 0c                	jne    479 <printf+0x50>
        state = '%';
 46d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 474:	e9 27 01 00 00       	jmp    5a0 <printf+0x177>
      } else {
        putc(fd, c);
 479:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 47c:	0f be c0             	movsbl %al,%eax
 47f:	83 ec 08             	sub    $0x8,%esp
 482:	50                   	push   %eax
 483:	ff 75 08             	pushl  0x8(%ebp)
 486:	e8 c9 fe ff ff       	call   354 <putc>
 48b:	83 c4 10             	add    $0x10,%esp
 48e:	e9 0d 01 00 00       	jmp    5a0 <printf+0x177>
      }
    } else if(state == '%'){
 493:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 497:	0f 85 03 01 00 00    	jne    5a0 <printf+0x177>
      if(c == 'd'){
 49d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4a1:	75 1e                	jne    4c1 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a6:	8b 00                	mov    (%eax),%eax
 4a8:	6a 01                	push   $0x1
 4aa:	6a 0a                	push   $0xa
 4ac:	50                   	push   %eax
 4ad:	ff 75 08             	pushl  0x8(%ebp)
 4b0:	e8 c1 fe ff ff       	call   376 <printint>
 4b5:	83 c4 10             	add    $0x10,%esp
        ap++;
 4b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4bc:	e9 d8 00 00 00       	jmp    599 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4c1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4c5:	74 06                	je     4cd <printf+0xa4>
 4c7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4cb:	75 1e                	jne    4eb <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d0:	8b 00                	mov    (%eax),%eax
 4d2:	6a 00                	push   $0x0
 4d4:	6a 10                	push   $0x10
 4d6:	50                   	push   %eax
 4d7:	ff 75 08             	pushl  0x8(%ebp)
 4da:	e8 97 fe ff ff       	call   376 <printint>
 4df:	83 c4 10             	add    $0x10,%esp
        ap++;
 4e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e6:	e9 ae 00 00 00       	jmp    599 <printf+0x170>
      } else if(c == 's'){
 4eb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4ef:	75 43                	jne    534 <printf+0x10b>
        s = (char*)*ap;
 4f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f4:	8b 00                	mov    (%eax),%eax
 4f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 501:	75 07                	jne    50a <printf+0xe1>
          s = "(null)";
 503:	c7 45 f4 e1 07 00 00 	movl   $0x7e1,-0xc(%ebp)
        while(*s != 0){
 50a:	eb 1c                	jmp    528 <printf+0xff>
          putc(fd, *s);
 50c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50f:	0f b6 00             	movzbl (%eax),%eax
 512:	0f be c0             	movsbl %al,%eax
 515:	83 ec 08             	sub    $0x8,%esp
 518:	50                   	push   %eax
 519:	ff 75 08             	pushl  0x8(%ebp)
 51c:	e8 33 fe ff ff       	call   354 <putc>
 521:	83 c4 10             	add    $0x10,%esp
          s++;
 524:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 528:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52b:	0f b6 00             	movzbl (%eax),%eax
 52e:	84 c0                	test   %al,%al
 530:	75 da                	jne    50c <printf+0xe3>
 532:	eb 65                	jmp    599 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 534:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 538:	75 1d                	jne    557 <printf+0x12e>
        putc(fd, *ap);
 53a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53d:	8b 00                	mov    (%eax),%eax
 53f:	0f be c0             	movsbl %al,%eax
 542:	83 ec 08             	sub    $0x8,%esp
 545:	50                   	push   %eax
 546:	ff 75 08             	pushl  0x8(%ebp)
 549:	e8 06 fe ff ff       	call   354 <putc>
 54e:	83 c4 10             	add    $0x10,%esp
        ap++;
 551:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 555:	eb 42                	jmp    599 <printf+0x170>
      } else if(c == '%'){
 557:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 55b:	75 17                	jne    574 <printf+0x14b>
        putc(fd, c);
 55d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 560:	0f be c0             	movsbl %al,%eax
 563:	83 ec 08             	sub    $0x8,%esp
 566:	50                   	push   %eax
 567:	ff 75 08             	pushl  0x8(%ebp)
 56a:	e8 e5 fd ff ff       	call   354 <putc>
 56f:	83 c4 10             	add    $0x10,%esp
 572:	eb 25                	jmp    599 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 574:	83 ec 08             	sub    $0x8,%esp
 577:	6a 25                	push   $0x25
 579:	ff 75 08             	pushl  0x8(%ebp)
 57c:	e8 d3 fd ff ff       	call   354 <putc>
 581:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 584:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 587:	0f be c0             	movsbl %al,%eax
 58a:	83 ec 08             	sub    $0x8,%esp
 58d:	50                   	push   %eax
 58e:	ff 75 08             	pushl  0x8(%ebp)
 591:	e8 be fd ff ff       	call   354 <putc>
 596:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 599:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5a4:	8b 55 0c             	mov    0xc(%ebp),%edx
 5a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5aa:	01 d0                	add    %edx,%eax
 5ac:	0f b6 00             	movzbl (%eax),%eax
 5af:	84 c0                	test   %al,%al
 5b1:	0f 85 94 fe ff ff    	jne    44b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b7:	c9                   	leave  
 5b8:	c3                   	ret    

000005b9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5b9:	55                   	push   %ebp
 5ba:	89 e5                	mov    %esp,%ebp
 5bc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5bf:	8b 45 08             	mov    0x8(%ebp),%eax
 5c2:	83 e8 08             	sub    $0x8,%eax
 5c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c8:	a1 5c 0a 00 00       	mov    0xa5c,%eax
 5cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5d0:	eb 24                	jmp    5f6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d5:	8b 00                	mov    (%eax),%eax
 5d7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5da:	77 12                	ja     5ee <free+0x35>
 5dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5df:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e2:	77 24                	ja     608 <free+0x4f>
 5e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e7:	8b 00                	mov    (%eax),%eax
 5e9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5ec:	77 1a                	ja     608 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f1:	8b 00                	mov    (%eax),%eax
 5f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5fc:	76 d4                	jbe    5d2 <free+0x19>
 5fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 601:	8b 00                	mov    (%eax),%eax
 603:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 606:	76 ca                	jbe    5d2 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 608:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60b:	8b 40 04             	mov    0x4(%eax),%eax
 60e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 615:	8b 45 f8             	mov    -0x8(%ebp),%eax
 618:	01 c2                	add    %eax,%edx
 61a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61d:	8b 00                	mov    (%eax),%eax
 61f:	39 c2                	cmp    %eax,%edx
 621:	75 24                	jne    647 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 623:	8b 45 f8             	mov    -0x8(%ebp),%eax
 626:	8b 50 04             	mov    0x4(%eax),%edx
 629:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62c:	8b 00                	mov    (%eax),%eax
 62e:	8b 40 04             	mov    0x4(%eax),%eax
 631:	01 c2                	add    %eax,%edx
 633:	8b 45 f8             	mov    -0x8(%ebp),%eax
 636:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	8b 10                	mov    (%eax),%edx
 640:	8b 45 f8             	mov    -0x8(%ebp),%eax
 643:	89 10                	mov    %edx,(%eax)
 645:	eb 0a                	jmp    651 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 647:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64a:	8b 10                	mov    (%eax),%edx
 64c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 651:	8b 45 fc             	mov    -0x4(%ebp),%eax
 654:	8b 40 04             	mov    0x4(%eax),%eax
 657:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	01 d0                	add    %edx,%eax
 663:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 666:	75 20                	jne    688 <free+0xcf>
    p->s.size += bp->s.size;
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 50 04             	mov    0x4(%eax),%edx
 66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 671:	8b 40 04             	mov    0x4(%eax),%eax
 674:	01 c2                	add    %eax,%edx
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 67c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67f:	8b 10                	mov    (%eax),%edx
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	89 10                	mov    %edx,(%eax)
 686:	eb 08                	jmp    690 <free+0xd7>
  } else
    p->s.ptr = bp;
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 68e:	89 10                	mov    %edx,(%eax)
  freep = p;
 690:	8b 45 fc             	mov    -0x4(%ebp),%eax
 693:	a3 5c 0a 00 00       	mov    %eax,0xa5c
}
 698:	c9                   	leave  
 699:	c3                   	ret    

0000069a <morecore>:

static Header*
morecore(uint nu)
{
 69a:	55                   	push   %ebp
 69b:	89 e5                	mov    %esp,%ebp
 69d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6a0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6a7:	77 07                	ja     6b0 <morecore+0x16>
    nu = 4096;
 6a9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6b0:	8b 45 08             	mov    0x8(%ebp),%eax
 6b3:	c1 e0 03             	shl    $0x3,%eax
 6b6:	83 ec 0c             	sub    $0xc,%esp
 6b9:	50                   	push   %eax
 6ba:	e8 75 fc ff ff       	call   334 <sbrk>
 6bf:	83 c4 10             	add    $0x10,%esp
 6c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6c5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6c9:	75 07                	jne    6d2 <morecore+0x38>
    return 0;
 6cb:	b8 00 00 00 00       	mov    $0x0,%eax
 6d0:	eb 26                	jmp    6f8 <morecore+0x5e>
  hp = (Header*)p;
 6d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6db:	8b 55 08             	mov    0x8(%ebp),%edx
 6de:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e4:	83 c0 08             	add    $0x8,%eax
 6e7:	83 ec 0c             	sub    $0xc,%esp
 6ea:	50                   	push   %eax
 6eb:	e8 c9 fe ff ff       	call   5b9 <free>
 6f0:	83 c4 10             	add    $0x10,%esp
  return freep;
 6f3:	a1 5c 0a 00 00       	mov    0xa5c,%eax
}
 6f8:	c9                   	leave  
 6f9:	c3                   	ret    

000006fa <malloc>:

void*
malloc(uint nbytes)
{
 6fa:	55                   	push   %ebp
 6fb:	89 e5                	mov    %esp,%ebp
 6fd:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 700:	8b 45 08             	mov    0x8(%ebp),%eax
 703:	83 c0 07             	add    $0x7,%eax
 706:	c1 e8 03             	shr    $0x3,%eax
 709:	83 c0 01             	add    $0x1,%eax
 70c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 70f:	a1 5c 0a 00 00       	mov    0xa5c,%eax
 714:	89 45 f0             	mov    %eax,-0x10(%ebp)
 717:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 71b:	75 23                	jne    740 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 71d:	c7 45 f0 54 0a 00 00 	movl   $0xa54,-0x10(%ebp)
 724:	8b 45 f0             	mov    -0x10(%ebp),%eax
 727:	a3 5c 0a 00 00       	mov    %eax,0xa5c
 72c:	a1 5c 0a 00 00       	mov    0xa5c,%eax
 731:	a3 54 0a 00 00       	mov    %eax,0xa54
    base.s.size = 0;
 736:	c7 05 58 0a 00 00 00 	movl   $0x0,0xa58
 73d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	8b 45 f0             	mov    -0x10(%ebp),%eax
 743:	8b 00                	mov    (%eax),%eax
 745:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 748:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74b:	8b 40 04             	mov    0x4(%eax),%eax
 74e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 751:	72 4d                	jb     7a0 <malloc+0xa6>
      if(p->s.size == nunits)
 753:	8b 45 f4             	mov    -0xc(%ebp),%eax
 756:	8b 40 04             	mov    0x4(%eax),%eax
 759:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 75c:	75 0c                	jne    76a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 761:	8b 10                	mov    (%eax),%edx
 763:	8b 45 f0             	mov    -0x10(%ebp),%eax
 766:	89 10                	mov    %edx,(%eax)
 768:	eb 26                	jmp    790 <malloc+0x96>
      else {
        p->s.size -= nunits;
 76a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76d:	8b 40 04             	mov    0x4(%eax),%eax
 770:	2b 45 ec             	sub    -0x14(%ebp),%eax
 773:	89 c2                	mov    %eax,%edx
 775:	8b 45 f4             	mov    -0xc(%ebp),%eax
 778:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 77b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77e:	8b 40 04             	mov    0x4(%eax),%eax
 781:	c1 e0 03             	shl    $0x3,%eax
 784:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 787:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 78d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 790:	8b 45 f0             	mov    -0x10(%ebp),%eax
 793:	a3 5c 0a 00 00       	mov    %eax,0xa5c
      return (void*)(p + 1);
 798:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79b:	83 c0 08             	add    $0x8,%eax
 79e:	eb 3b                	jmp    7db <malloc+0xe1>
    }
    if(p == freep)
 7a0:	a1 5c 0a 00 00       	mov    0xa5c,%eax
 7a5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7a8:	75 1e                	jne    7c8 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7aa:	83 ec 0c             	sub    $0xc,%esp
 7ad:	ff 75 ec             	pushl  -0x14(%ebp)
 7b0:	e8 e5 fe ff ff       	call   69a <morecore>
 7b5:	83 c4 10             	add    $0x10,%esp
 7b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7bf:	75 07                	jne    7c8 <malloc+0xce>
        return 0;
 7c1:	b8 00 00 00 00       	mov    $0x0,%eax
 7c6:	eb 13                	jmp    7db <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7d6:	e9 6d ff ff ff       	jmp    748 <malloc+0x4e>
}
 7db:	c9                   	leave  
 7dc:	c3                   	ret    
