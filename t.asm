
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
  16:	e8 ce 02 00 00       	call   2e9 <kill>
  1b:	83 c4 10             	add    $0x10,%esp
	sleep(1);
  1e:	83 ec 0c             	sub    $0xc,%esp
  21:	6a 01                	push   $0x1
  23:	e8 21 03 00 00       	call   349 <sleep>
  28:	83 c4 10             	add    $0x10,%esp
	if (fork()==0) {
  2b:	e8 81 02 00 00       	call   2b1 <fork>
  30:	85 c0                	test   %eax,%eax
  32:	75 16                	jne    4a <main+0x4a>
		exec(argv[0], argv);
  34:	a1 48 0a 00 00       	mov    0xa48,%eax
  39:	83 ec 08             	sub    $0x8,%esp
  3c:	68 48 0a 00 00       	push   $0xa48
  41:	50                   	push   %eax
  42:	e8 aa 02 00 00       	call   2f1 <exec>
  47:	83 c4 10             	add    $0x10,%esp
	}
	wait(0);
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	6a 00                	push   $0x0
  4f:	e8 6d 02 00 00       	call   2c1 <wait>
  54:	83 c4 10             	add    $0x10,%esp
	return 0;
  57:	b8 00 00 00 00       	mov    $0x0,%eax
}
  5c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  5f:	c9                   	leave  
  60:	8d 61 fc             	lea    -0x4(%ecx),%esp
  63:	c3                   	ret    

00000064 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	57                   	push   %edi
  68:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  69:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6c:	8b 55 10             	mov    0x10(%ebp),%edx
  6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  72:	89 cb                	mov    %ecx,%ebx
  74:	89 df                	mov    %ebx,%edi
  76:	89 d1                	mov    %edx,%ecx
  78:	fc                   	cld    
  79:	f3 aa                	rep stos %al,%es:(%edi)
  7b:	89 ca                	mov    %ecx,%edx
  7d:	89 fb                	mov    %edi,%ebx
  7f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  82:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  85:	5b                   	pop    %ebx
  86:	5f                   	pop    %edi
  87:	5d                   	pop    %ebp
  88:	c3                   	ret    

00000089 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  89:	55                   	push   %ebp
  8a:	89 e5                	mov    %esp,%ebp
  8c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  95:	90                   	nop
  96:	8b 45 08             	mov    0x8(%ebp),%eax
  99:	8d 50 01             	lea    0x1(%eax),%edx
  9c:	89 55 08             	mov    %edx,0x8(%ebp)
  9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  a2:	8d 4a 01             	lea    0x1(%edx),%ecx
  a5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  a8:	0f b6 12             	movzbl (%edx),%edx
  ab:	88 10                	mov    %dl,(%eax)
  ad:	0f b6 00             	movzbl (%eax),%eax
  b0:	84 c0                	test   %al,%al
  b2:	75 e2                	jne    96 <strcpy+0xd>
    ;
  return os;
  b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b7:	c9                   	leave  
  b8:	c3                   	ret    

000000b9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b9:	55                   	push   %ebp
  ba:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  bc:	eb 08                	jmp    c6 <strcmp+0xd>
    p++, q++;
  be:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c6:	8b 45 08             	mov    0x8(%ebp),%eax
  c9:	0f b6 00             	movzbl (%eax),%eax
  cc:	84 c0                	test   %al,%al
  ce:	74 10                	je     e0 <strcmp+0x27>
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	0f b6 10             	movzbl (%eax),%edx
  d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  d9:	0f b6 00             	movzbl (%eax),%eax
  dc:	38 c2                	cmp    %al,%dl
  de:	74 de                	je     be <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e0:	8b 45 08             	mov    0x8(%ebp),%eax
  e3:	0f b6 00             	movzbl (%eax),%eax
  e6:	0f b6 d0             	movzbl %al,%edx
  e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  ec:	0f b6 00             	movzbl (%eax),%eax
  ef:	0f b6 c0             	movzbl %al,%eax
  f2:	29 c2                	sub    %eax,%edx
  f4:	89 d0                	mov    %edx,%eax
}
  f6:	5d                   	pop    %ebp
  f7:	c3                   	ret    

000000f8 <strlen>:

uint
strlen(char *s)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 105:	eb 04                	jmp    10b <strlen+0x13>
 107:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 10e:	8b 45 08             	mov    0x8(%ebp),%eax
 111:	01 d0                	add    %edx,%eax
 113:	0f b6 00             	movzbl (%eax),%eax
 116:	84 c0                	test   %al,%al
 118:	75 ed                	jne    107 <strlen+0xf>
    ;
  return n;
 11a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11d:	c9                   	leave  
 11e:	c3                   	ret    

0000011f <memset>:

void*
memset(void *dst, int c, uint n)
{
 11f:	55                   	push   %ebp
 120:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 122:	8b 45 10             	mov    0x10(%ebp),%eax
 125:	50                   	push   %eax
 126:	ff 75 0c             	pushl  0xc(%ebp)
 129:	ff 75 08             	pushl  0x8(%ebp)
 12c:	e8 33 ff ff ff       	call   64 <stosb>
 131:	83 c4 0c             	add    $0xc,%esp
  return dst;
 134:	8b 45 08             	mov    0x8(%ebp),%eax
}
 137:	c9                   	leave  
 138:	c3                   	ret    

00000139 <strchr>:

char*
strchr(const char *s, char c)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 04             	sub    $0x4,%esp
 13f:	8b 45 0c             	mov    0xc(%ebp),%eax
 142:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 145:	eb 14                	jmp    15b <strchr+0x22>
    if(*s == c)
 147:	8b 45 08             	mov    0x8(%ebp),%eax
 14a:	0f b6 00             	movzbl (%eax),%eax
 14d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 150:	75 05                	jne    157 <strchr+0x1e>
      return (char*)s;
 152:	8b 45 08             	mov    0x8(%ebp),%eax
 155:	eb 13                	jmp    16a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 157:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15b:	8b 45 08             	mov    0x8(%ebp),%eax
 15e:	0f b6 00             	movzbl (%eax),%eax
 161:	84 c0                	test   %al,%al
 163:	75 e2                	jne    147 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 165:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16a:	c9                   	leave  
 16b:	c3                   	ret    

0000016c <gets>:

char*
gets(char *buf, int max)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 172:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 179:	eb 44                	jmp    1bf <gets+0x53>
    cc = read(0, &c, 1);
 17b:	83 ec 04             	sub    $0x4,%esp
 17e:	6a 01                	push   $0x1
 180:	8d 45 ef             	lea    -0x11(%ebp),%eax
 183:	50                   	push   %eax
 184:	6a 00                	push   $0x0
 186:	e8 46 01 00 00       	call   2d1 <read>
 18b:	83 c4 10             	add    $0x10,%esp
 18e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 191:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 195:	7f 02                	jg     199 <gets+0x2d>
      break;
 197:	eb 31                	jmp    1ca <gets+0x5e>
    buf[i++] = c;
 199:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19c:	8d 50 01             	lea    0x1(%eax),%edx
 19f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a2:	89 c2                	mov    %eax,%edx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	01 c2                	add    %eax,%edx
 1a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b3:	3c 0a                	cmp    $0xa,%al
 1b5:	74 13                	je     1ca <gets+0x5e>
 1b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bb:	3c 0d                	cmp    $0xd,%al
 1bd:	74 0b                	je     1ca <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c2:	83 c0 01             	add    $0x1,%eax
 1c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1c8:	7c b1                	jl     17b <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
 1d0:	01 d0                	add    %edx,%eax
 1d2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d8:	c9                   	leave  
 1d9:	c3                   	ret    

000001da <stat>:

int
stat(char *n, struct stat *st)
{
 1da:	55                   	push   %ebp
 1db:	89 e5                	mov    %esp,%ebp
 1dd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e0:	83 ec 08             	sub    $0x8,%esp
 1e3:	6a 00                	push   $0x0
 1e5:	ff 75 08             	pushl  0x8(%ebp)
 1e8:	e8 0c 01 00 00       	call   2f9 <open>
 1ed:	83 c4 10             	add    $0x10,%esp
 1f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1f7:	79 07                	jns    200 <stat+0x26>
    return -1;
 1f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1fe:	eb 25                	jmp    225 <stat+0x4b>
  r = fstat(fd, st);
 200:	83 ec 08             	sub    $0x8,%esp
 203:	ff 75 0c             	pushl  0xc(%ebp)
 206:	ff 75 f4             	pushl  -0xc(%ebp)
 209:	e8 03 01 00 00       	call   311 <fstat>
 20e:	83 c4 10             	add    $0x10,%esp
 211:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 214:	83 ec 0c             	sub    $0xc,%esp
 217:	ff 75 f4             	pushl  -0xc(%ebp)
 21a:	e8 c2 00 00 00       	call   2e1 <close>
 21f:	83 c4 10             	add    $0x10,%esp
  return r;
 222:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 225:	c9                   	leave  
 226:	c3                   	ret    

00000227 <atoi>:

int
atoi(const char *s)
{
 227:	55                   	push   %ebp
 228:	89 e5                	mov    %esp,%ebp
 22a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 22d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 234:	eb 25                	jmp    25b <atoi+0x34>
    n = n*10 + *s++ - '0';
 236:	8b 55 fc             	mov    -0x4(%ebp),%edx
 239:	89 d0                	mov    %edx,%eax
 23b:	c1 e0 02             	shl    $0x2,%eax
 23e:	01 d0                	add    %edx,%eax
 240:	01 c0                	add    %eax,%eax
 242:	89 c1                	mov    %eax,%ecx
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	8d 50 01             	lea    0x1(%eax),%edx
 24a:	89 55 08             	mov    %edx,0x8(%ebp)
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	0f be c0             	movsbl %al,%eax
 253:	01 c8                	add    %ecx,%eax
 255:	83 e8 30             	sub    $0x30,%eax
 258:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	0f b6 00             	movzbl (%eax),%eax
 261:	3c 2f                	cmp    $0x2f,%al
 263:	7e 0a                	jle    26f <atoi+0x48>
 265:	8b 45 08             	mov    0x8(%ebp),%eax
 268:	0f b6 00             	movzbl (%eax),%eax
 26b:	3c 39                	cmp    $0x39,%al
 26d:	7e c7                	jle    236 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 26f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 272:	c9                   	leave  
 273:	c3                   	ret    

00000274 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 27a:	8b 45 08             	mov    0x8(%ebp),%eax
 27d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 280:	8b 45 0c             	mov    0xc(%ebp),%eax
 283:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 286:	eb 17                	jmp    29f <memmove+0x2b>
    *dst++ = *src++;
 288:	8b 45 fc             	mov    -0x4(%ebp),%eax
 28b:	8d 50 01             	lea    0x1(%eax),%edx
 28e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 291:	8b 55 f8             	mov    -0x8(%ebp),%edx
 294:	8d 4a 01             	lea    0x1(%edx),%ecx
 297:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 29a:	0f b6 12             	movzbl (%edx),%edx
 29d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29f:	8b 45 10             	mov    0x10(%ebp),%eax
 2a2:	8d 50 ff             	lea    -0x1(%eax),%edx
 2a5:	89 55 10             	mov    %edx,0x10(%ebp)
 2a8:	85 c0                	test   %eax,%eax
 2aa:	7f dc                	jg     288 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2af:	c9                   	leave  
 2b0:	c3                   	ret    

000002b1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b1:	b8 01 00 00 00       	mov    $0x1,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <exit>:
SYSCALL(exit)
 2b9:	b8 02 00 00 00       	mov    $0x2,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <wait>:
SYSCALL(wait)
 2c1:	b8 03 00 00 00       	mov    $0x3,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <pipe>:
SYSCALL(pipe)
 2c9:	b8 04 00 00 00       	mov    $0x4,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <read>:
SYSCALL(read)
 2d1:	b8 05 00 00 00       	mov    $0x5,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <write>:
SYSCALL(write)
 2d9:	b8 10 00 00 00       	mov    $0x10,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <close>:
SYSCALL(close)
 2e1:	b8 15 00 00 00       	mov    $0x15,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <kill>:
SYSCALL(kill)
 2e9:	b8 06 00 00 00       	mov    $0x6,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <exec>:
SYSCALL(exec)
 2f1:	b8 07 00 00 00       	mov    $0x7,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <open>:
SYSCALL(open)
 2f9:	b8 0f 00 00 00       	mov    $0xf,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <mknod>:
SYSCALL(mknod)
 301:	b8 11 00 00 00       	mov    $0x11,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <unlink>:
SYSCALL(unlink)
 309:	b8 12 00 00 00       	mov    $0x12,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <fstat>:
SYSCALL(fstat)
 311:	b8 08 00 00 00       	mov    $0x8,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <link>:
SYSCALL(link)
 319:	b8 13 00 00 00       	mov    $0x13,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <mkdir>:
SYSCALL(mkdir)
 321:	b8 14 00 00 00       	mov    $0x14,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <chdir>:
SYSCALL(chdir)
 329:	b8 09 00 00 00       	mov    $0x9,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <dup>:
SYSCALL(dup)
 331:	b8 0a 00 00 00       	mov    $0xa,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <getpid>:
SYSCALL(getpid)
 339:	b8 0b 00 00 00       	mov    $0xb,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <sbrk>:
SYSCALL(sbrk)
 341:	b8 0c 00 00 00       	mov    $0xc,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <sleep>:
SYSCALL(sleep)
 349:	b8 0d 00 00 00       	mov    $0xd,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <uptime>:
SYSCALL(uptime)
 351:	b8 0e 00 00 00       	mov    $0xe,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <pstat>:
SYSCALL(pstat)
 359:	b8 16 00 00 00       	mov    $0x16,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 361:	55                   	push   %ebp
 362:	89 e5                	mov    %esp,%ebp
 364:	83 ec 18             	sub    $0x18,%esp
 367:	8b 45 0c             	mov    0xc(%ebp),%eax
 36a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 36d:	83 ec 04             	sub    $0x4,%esp
 370:	6a 01                	push   $0x1
 372:	8d 45 f4             	lea    -0xc(%ebp),%eax
 375:	50                   	push   %eax
 376:	ff 75 08             	pushl  0x8(%ebp)
 379:	e8 5b ff ff ff       	call   2d9 <write>
 37e:	83 c4 10             	add    $0x10,%esp
}
 381:	c9                   	leave  
 382:	c3                   	ret    

00000383 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 383:	55                   	push   %ebp
 384:	89 e5                	mov    %esp,%ebp
 386:	53                   	push   %ebx
 387:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 38a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 391:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 395:	74 17                	je     3ae <printint+0x2b>
 397:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 39b:	79 11                	jns    3ae <printint+0x2b>
    neg = 1;
 39d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a7:	f7 d8                	neg    %eax
 3a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ac:	eb 06                	jmp    3b4 <printint+0x31>
  } else {
    x = xx;
 3ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3bb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3be:	8d 41 01             	lea    0x1(%ecx),%eax
 3c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3c4:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ca:	ba 00 00 00 00       	mov    $0x0,%edx
 3cf:	f7 f3                	div    %ebx
 3d1:	89 d0                	mov    %edx,%eax
 3d3:	0f b6 80 50 0a 00 00 	movzbl 0xa50(%eax),%eax
 3da:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3de:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e4:	ba 00 00 00 00       	mov    $0x0,%edx
 3e9:	f7 f3                	div    %ebx
 3eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3f2:	75 c7                	jne    3bb <printint+0x38>
  if(neg)
 3f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3f8:	74 0e                	je     408 <printint+0x85>
    buf[i++] = '-';
 3fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3fd:	8d 50 01             	lea    0x1(%eax),%edx
 400:	89 55 f4             	mov    %edx,-0xc(%ebp)
 403:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 408:	eb 1d                	jmp    427 <printint+0xa4>
    putc(fd, buf[i]);
 40a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 40d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 410:	01 d0                	add    %edx,%eax
 412:	0f b6 00             	movzbl (%eax),%eax
 415:	0f be c0             	movsbl %al,%eax
 418:	83 ec 08             	sub    $0x8,%esp
 41b:	50                   	push   %eax
 41c:	ff 75 08             	pushl  0x8(%ebp)
 41f:	e8 3d ff ff ff       	call   361 <putc>
 424:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 427:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 42b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 42f:	79 d9                	jns    40a <printint+0x87>
    putc(fd, buf[i]);
}
 431:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 434:	c9                   	leave  
 435:	c3                   	ret    

00000436 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 436:	55                   	push   %ebp
 437:	89 e5                	mov    %esp,%ebp
 439:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 43c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 443:	8d 45 0c             	lea    0xc(%ebp),%eax
 446:	83 c0 04             	add    $0x4,%eax
 449:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 44c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 453:	e9 59 01 00 00       	jmp    5b1 <printf+0x17b>
    c = fmt[i] & 0xff;
 458:	8b 55 0c             	mov    0xc(%ebp),%edx
 45b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 45e:	01 d0                	add    %edx,%eax
 460:	0f b6 00             	movzbl (%eax),%eax
 463:	0f be c0             	movsbl %al,%eax
 466:	25 ff 00 00 00       	and    $0xff,%eax
 46b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 46e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 472:	75 2c                	jne    4a0 <printf+0x6a>
      if(c == '%'){
 474:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 478:	75 0c                	jne    486 <printf+0x50>
        state = '%';
 47a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 481:	e9 27 01 00 00       	jmp    5ad <printf+0x177>
      } else {
        putc(fd, c);
 486:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 489:	0f be c0             	movsbl %al,%eax
 48c:	83 ec 08             	sub    $0x8,%esp
 48f:	50                   	push   %eax
 490:	ff 75 08             	pushl  0x8(%ebp)
 493:	e8 c9 fe ff ff       	call   361 <putc>
 498:	83 c4 10             	add    $0x10,%esp
 49b:	e9 0d 01 00 00       	jmp    5ad <printf+0x177>
      }
    } else if(state == '%'){
 4a0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4a4:	0f 85 03 01 00 00    	jne    5ad <printf+0x177>
      if(c == 'd'){
 4aa:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ae:	75 1e                	jne    4ce <printf+0x98>
        printint(fd, *ap, 10, 1);
 4b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b3:	8b 00                	mov    (%eax),%eax
 4b5:	6a 01                	push   $0x1
 4b7:	6a 0a                	push   $0xa
 4b9:	50                   	push   %eax
 4ba:	ff 75 08             	pushl  0x8(%ebp)
 4bd:	e8 c1 fe ff ff       	call   383 <printint>
 4c2:	83 c4 10             	add    $0x10,%esp
        ap++;
 4c5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c9:	e9 d8 00 00 00       	jmp    5a6 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4ce:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4d2:	74 06                	je     4da <printf+0xa4>
 4d4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4d8:	75 1e                	jne    4f8 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4da:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4dd:	8b 00                	mov    (%eax),%eax
 4df:	6a 00                	push   $0x0
 4e1:	6a 10                	push   $0x10
 4e3:	50                   	push   %eax
 4e4:	ff 75 08             	pushl  0x8(%ebp)
 4e7:	e8 97 fe ff ff       	call   383 <printint>
 4ec:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f3:	e9 ae 00 00 00       	jmp    5a6 <printf+0x170>
      } else if(c == 's'){
 4f8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4fc:	75 43                	jne    541 <printf+0x10b>
        s = (char*)*ap;
 4fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
 501:	8b 00                	mov    (%eax),%eax
 503:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 506:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 50a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 50e:	75 07                	jne    517 <printf+0xe1>
          s = "(null)";
 510:	c7 45 f4 ee 07 00 00 	movl   $0x7ee,-0xc(%ebp)
        while(*s != 0){
 517:	eb 1c                	jmp    535 <printf+0xff>
          putc(fd, *s);
 519:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51c:	0f b6 00             	movzbl (%eax),%eax
 51f:	0f be c0             	movsbl %al,%eax
 522:	83 ec 08             	sub    $0x8,%esp
 525:	50                   	push   %eax
 526:	ff 75 08             	pushl  0x8(%ebp)
 529:	e8 33 fe ff ff       	call   361 <putc>
 52e:	83 c4 10             	add    $0x10,%esp
          s++;
 531:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 535:	8b 45 f4             	mov    -0xc(%ebp),%eax
 538:	0f b6 00             	movzbl (%eax),%eax
 53b:	84 c0                	test   %al,%al
 53d:	75 da                	jne    519 <printf+0xe3>
 53f:	eb 65                	jmp    5a6 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 541:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 545:	75 1d                	jne    564 <printf+0x12e>
        putc(fd, *ap);
 547:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54a:	8b 00                	mov    (%eax),%eax
 54c:	0f be c0             	movsbl %al,%eax
 54f:	83 ec 08             	sub    $0x8,%esp
 552:	50                   	push   %eax
 553:	ff 75 08             	pushl  0x8(%ebp)
 556:	e8 06 fe ff ff       	call   361 <putc>
 55b:	83 c4 10             	add    $0x10,%esp
        ap++;
 55e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 562:	eb 42                	jmp    5a6 <printf+0x170>
      } else if(c == '%'){
 564:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 568:	75 17                	jne    581 <printf+0x14b>
        putc(fd, c);
 56a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56d:	0f be c0             	movsbl %al,%eax
 570:	83 ec 08             	sub    $0x8,%esp
 573:	50                   	push   %eax
 574:	ff 75 08             	pushl  0x8(%ebp)
 577:	e8 e5 fd ff ff       	call   361 <putc>
 57c:	83 c4 10             	add    $0x10,%esp
 57f:	eb 25                	jmp    5a6 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 581:	83 ec 08             	sub    $0x8,%esp
 584:	6a 25                	push   $0x25
 586:	ff 75 08             	pushl  0x8(%ebp)
 589:	e8 d3 fd ff ff       	call   361 <putc>
 58e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 591:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 594:	0f be c0             	movsbl %al,%eax
 597:	83 ec 08             	sub    $0x8,%esp
 59a:	50                   	push   %eax
 59b:	ff 75 08             	pushl  0x8(%ebp)
 59e:	e8 be fd ff ff       	call   361 <putc>
 5a3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ad:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5b1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b7:	01 d0                	add    %edx,%eax
 5b9:	0f b6 00             	movzbl (%eax),%eax
 5bc:	84 c0                	test   %al,%al
 5be:	0f 85 94 fe ff ff    	jne    458 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c4:	c9                   	leave  
 5c5:	c3                   	ret    

000005c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c6:	55                   	push   %ebp
 5c7:	89 e5                	mov    %esp,%ebp
 5c9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5cc:	8b 45 08             	mov    0x8(%ebp),%eax
 5cf:	83 e8 08             	sub    $0x8,%eax
 5d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d5:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 5da:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5dd:	eb 24                	jmp    603 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e2:	8b 00                	mov    (%eax),%eax
 5e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e7:	77 12                	ja     5fb <free+0x35>
 5e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ef:	77 24                	ja     615 <free+0x4f>
 5f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f4:	8b 00                	mov    (%eax),%eax
 5f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f9:	77 1a                	ja     615 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fe:	8b 00                	mov    (%eax),%eax
 600:	89 45 fc             	mov    %eax,-0x4(%ebp)
 603:	8b 45 f8             	mov    -0x8(%ebp),%eax
 606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 609:	76 d4                	jbe    5df <free+0x19>
 60b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60e:	8b 00                	mov    (%eax),%eax
 610:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 613:	76 ca                	jbe    5df <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 615:	8b 45 f8             	mov    -0x8(%ebp),%eax
 618:	8b 40 04             	mov    0x4(%eax),%eax
 61b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 622:	8b 45 f8             	mov    -0x8(%ebp),%eax
 625:	01 c2                	add    %eax,%edx
 627:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62a:	8b 00                	mov    (%eax),%eax
 62c:	39 c2                	cmp    %eax,%edx
 62e:	75 24                	jne    654 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 630:	8b 45 f8             	mov    -0x8(%ebp),%eax
 633:	8b 50 04             	mov    0x4(%eax),%edx
 636:	8b 45 fc             	mov    -0x4(%ebp),%eax
 639:	8b 00                	mov    (%eax),%eax
 63b:	8b 40 04             	mov    0x4(%eax),%eax
 63e:	01 c2                	add    %eax,%edx
 640:	8b 45 f8             	mov    -0x8(%ebp),%eax
 643:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 646:	8b 45 fc             	mov    -0x4(%ebp),%eax
 649:	8b 00                	mov    (%eax),%eax
 64b:	8b 10                	mov    (%eax),%edx
 64d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 650:	89 10                	mov    %edx,(%eax)
 652:	eb 0a                	jmp    65e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 654:	8b 45 fc             	mov    -0x4(%ebp),%eax
 657:	8b 10                	mov    (%eax),%edx
 659:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	8b 40 04             	mov    0x4(%eax),%eax
 664:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66e:	01 d0                	add    %edx,%eax
 670:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 673:	75 20                	jne    695 <free+0xcf>
    p->s.size += bp->s.size;
 675:	8b 45 fc             	mov    -0x4(%ebp),%eax
 678:	8b 50 04             	mov    0x4(%eax),%edx
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	8b 40 04             	mov    0x4(%eax),%eax
 681:	01 c2                	add    %eax,%edx
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	8b 10                	mov    (%eax),%edx
 68e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 691:	89 10                	mov    %edx,(%eax)
 693:	eb 08                	jmp    69d <free+0xd7>
  } else
    p->s.ptr = bp;
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	8b 55 f8             	mov    -0x8(%ebp),%edx
 69b:	89 10                	mov    %edx,(%eax)
  freep = p;
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	a3 6c 0a 00 00       	mov    %eax,0xa6c
}
 6a5:	c9                   	leave  
 6a6:	c3                   	ret    

000006a7 <morecore>:

static Header*
morecore(uint nu)
{
 6a7:	55                   	push   %ebp
 6a8:	89 e5                	mov    %esp,%ebp
 6aa:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6ad:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6b4:	77 07                	ja     6bd <morecore+0x16>
    nu = 4096;
 6b6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6bd:	8b 45 08             	mov    0x8(%ebp),%eax
 6c0:	c1 e0 03             	shl    $0x3,%eax
 6c3:	83 ec 0c             	sub    $0xc,%esp
 6c6:	50                   	push   %eax
 6c7:	e8 75 fc ff ff       	call   341 <sbrk>
 6cc:	83 c4 10             	add    $0x10,%esp
 6cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6d2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6d6:	75 07                	jne    6df <morecore+0x38>
    return 0;
 6d8:	b8 00 00 00 00       	mov    $0x0,%eax
 6dd:	eb 26                	jmp    705 <morecore+0x5e>
  hp = (Header*)p;
 6df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e8:	8b 55 08             	mov    0x8(%ebp),%edx
 6eb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f1:	83 c0 08             	add    $0x8,%eax
 6f4:	83 ec 0c             	sub    $0xc,%esp
 6f7:	50                   	push   %eax
 6f8:	e8 c9 fe ff ff       	call   5c6 <free>
 6fd:	83 c4 10             	add    $0x10,%esp
  return freep;
 700:	a1 6c 0a 00 00       	mov    0xa6c,%eax
}
 705:	c9                   	leave  
 706:	c3                   	ret    

00000707 <malloc>:

void*
malloc(uint nbytes)
{
 707:	55                   	push   %ebp
 708:	89 e5                	mov    %esp,%ebp
 70a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70d:	8b 45 08             	mov    0x8(%ebp),%eax
 710:	83 c0 07             	add    $0x7,%eax
 713:	c1 e8 03             	shr    $0x3,%eax
 716:	83 c0 01             	add    $0x1,%eax
 719:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 71c:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 721:	89 45 f0             	mov    %eax,-0x10(%ebp)
 724:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 728:	75 23                	jne    74d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 72a:	c7 45 f0 64 0a 00 00 	movl   $0xa64,-0x10(%ebp)
 731:	8b 45 f0             	mov    -0x10(%ebp),%eax
 734:	a3 6c 0a 00 00       	mov    %eax,0xa6c
 739:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 73e:	a3 64 0a 00 00       	mov    %eax,0xa64
    base.s.size = 0;
 743:	c7 05 68 0a 00 00 00 	movl   $0x0,0xa68
 74a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 74d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 750:	8b 00                	mov    (%eax),%eax
 752:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	8b 40 04             	mov    0x4(%eax),%eax
 75b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 75e:	72 4d                	jb     7ad <malloc+0xa6>
      if(p->s.size == nunits)
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	8b 40 04             	mov    0x4(%eax),%eax
 766:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 769:	75 0c                	jne    777 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 76b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76e:	8b 10                	mov    (%eax),%edx
 770:	8b 45 f0             	mov    -0x10(%ebp),%eax
 773:	89 10                	mov    %edx,(%eax)
 775:	eb 26                	jmp    79d <malloc+0x96>
      else {
        p->s.size -= nunits;
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	8b 40 04             	mov    0x4(%eax),%eax
 77d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 780:	89 c2                	mov    %eax,%edx
 782:	8b 45 f4             	mov    -0xc(%ebp),%eax
 785:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 788:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78b:	8b 40 04             	mov    0x4(%eax),%eax
 78e:	c1 e0 03             	shl    $0x3,%eax
 791:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 794:	8b 45 f4             	mov    -0xc(%ebp),%eax
 797:	8b 55 ec             	mov    -0x14(%ebp),%edx
 79a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a0:	a3 6c 0a 00 00       	mov    %eax,0xa6c
      return (void*)(p + 1);
 7a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a8:	83 c0 08             	add    $0x8,%eax
 7ab:	eb 3b                	jmp    7e8 <malloc+0xe1>
    }
    if(p == freep)
 7ad:	a1 6c 0a 00 00       	mov    0xa6c,%eax
 7b2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7b5:	75 1e                	jne    7d5 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7b7:	83 ec 0c             	sub    $0xc,%esp
 7ba:	ff 75 ec             	pushl  -0x14(%ebp)
 7bd:	e8 e5 fe ff ff       	call   6a7 <morecore>
 7c2:	83 c4 10             	add    $0x10,%esp
 7c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7cc:	75 07                	jne    7d5 <malloc+0xce>
        return 0;
 7ce:	b8 00 00 00 00       	mov    $0x0,%eax
 7d3:	eb 13                	jmp    7e8 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	8b 00                	mov    (%eax),%eax
 7e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7e3:	e9 6d ff ff ff       	jmp    755 <malloc+0x4e>
}
 7e8:	c9                   	leave  
 7e9:	c3                   	ret    
