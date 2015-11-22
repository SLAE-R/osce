
_backjob:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int main(int argc, char *argv[]){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
	while(1);
   3:	eb fe                	jmp    3 <main+0x3>

00000005 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
   5:	55                   	push   %ebp
   6:	89 e5                	mov    %esp,%ebp
   8:	57                   	push   %edi
   9:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
   a:	8b 4d 08             	mov    0x8(%ebp),%ecx
   d:	8b 55 10             	mov    0x10(%ebp),%edx
  10:	8b 45 0c             	mov    0xc(%ebp),%eax
  13:	89 cb                	mov    %ecx,%ebx
  15:	89 df                	mov    %ebx,%edi
  17:	89 d1                	mov    %edx,%ecx
  19:	fc                   	cld    
  1a:	f3 aa                	rep stos %al,%es:(%edi)
  1c:	89 ca                	mov    %ecx,%edx
  1e:	89 fb                	mov    %edi,%ebx
  20:	89 5d 08             	mov    %ebx,0x8(%ebp)
  23:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  26:	5b                   	pop    %ebx
  27:	5f                   	pop    %edi
  28:	5d                   	pop    %ebp
  29:	c3                   	ret    

0000002a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  2a:	55                   	push   %ebp
  2b:	89 e5                	mov    %esp,%ebp
  2d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  30:	8b 45 08             	mov    0x8(%ebp),%eax
  33:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  36:	90                   	nop
  37:	8b 45 08             	mov    0x8(%ebp),%eax
  3a:	8d 50 01             	lea    0x1(%eax),%edx
  3d:	89 55 08             	mov    %edx,0x8(%ebp)
  40:	8b 55 0c             	mov    0xc(%ebp),%edx
  43:	8d 4a 01             	lea    0x1(%edx),%ecx
  46:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  49:	0f b6 12             	movzbl (%edx),%edx
  4c:	88 10                	mov    %dl,(%eax)
  4e:	0f b6 00             	movzbl (%eax),%eax
  51:	84 c0                	test   %al,%al
  53:	75 e2                	jne    37 <strcpy+0xd>
    ;
  return os;
  55:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  58:	c9                   	leave  
  59:	c3                   	ret    

0000005a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  5a:	55                   	push   %ebp
  5b:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  5d:	eb 08                	jmp    67 <strcmp+0xd>
    p++, q++;
  5f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  63:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  67:	8b 45 08             	mov    0x8(%ebp),%eax
  6a:	0f b6 00             	movzbl (%eax),%eax
  6d:	84 c0                	test   %al,%al
  6f:	74 10                	je     81 <strcmp+0x27>
  71:	8b 45 08             	mov    0x8(%ebp),%eax
  74:	0f b6 10             	movzbl (%eax),%edx
  77:	8b 45 0c             	mov    0xc(%ebp),%eax
  7a:	0f b6 00             	movzbl (%eax),%eax
  7d:	38 c2                	cmp    %al,%dl
  7f:	74 de                	je     5f <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  81:	8b 45 08             	mov    0x8(%ebp),%eax
  84:	0f b6 00             	movzbl (%eax),%eax
  87:	0f b6 d0             	movzbl %al,%edx
  8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  8d:	0f b6 00             	movzbl (%eax),%eax
  90:	0f b6 c0             	movzbl %al,%eax
  93:	29 c2                	sub    %eax,%edx
  95:	89 d0                	mov    %edx,%eax
}
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    

00000099 <strlen>:

uint
strlen(char *s)
{
  99:	55                   	push   %ebp
  9a:	89 e5                	mov    %esp,%ebp
  9c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  9f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  a6:	eb 04                	jmp    ac <strlen+0x13>
  a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
  af:	8b 45 08             	mov    0x8(%ebp),%eax
  b2:	01 d0                	add    %edx,%eax
  b4:	0f b6 00             	movzbl (%eax),%eax
  b7:	84 c0                	test   %al,%al
  b9:	75 ed                	jne    a8 <strlen+0xf>
    ;
  return n;
  bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  be:	c9                   	leave  
  bf:	c3                   	ret    

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  c3:	8b 45 10             	mov    0x10(%ebp),%eax
  c6:	50                   	push   %eax
  c7:	ff 75 0c             	pushl  0xc(%ebp)
  ca:	ff 75 08             	pushl  0x8(%ebp)
  cd:	e8 33 ff ff ff       	call   5 <stosb>
  d2:	83 c4 0c             	add    $0xc,%esp
  return dst;
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  d8:	c9                   	leave  
  d9:	c3                   	ret    

000000da <strchr>:

char*
strchr(const char *s, char c)
{
  da:	55                   	push   %ebp
  db:	89 e5                	mov    %esp,%ebp
  dd:	83 ec 04             	sub    $0x4,%esp
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
  e6:	eb 14                	jmp    fc <strchr+0x22>
    if(*s == c)
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	3a 45 fc             	cmp    -0x4(%ebp),%al
  f1:	75 05                	jne    f8 <strchr+0x1e>
      return (char*)s;
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	eb 13                	jmp    10b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
  f8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 00             	movzbl (%eax),%eax
 102:	84 c0                	test   %al,%al
 104:	75 e2                	jne    e8 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 106:	b8 00 00 00 00       	mov    $0x0,%eax
}
 10b:	c9                   	leave  
 10c:	c3                   	ret    

0000010d <gets>:

char*
gets(char *buf, int max)
{
 10d:	55                   	push   %ebp
 10e:	89 e5                	mov    %esp,%ebp
 110:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 113:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 11a:	eb 44                	jmp    160 <gets+0x53>
    cc = read(0, &c, 1);
 11c:	83 ec 04             	sub    $0x4,%esp
 11f:	6a 01                	push   $0x1
 121:	8d 45 ef             	lea    -0x11(%ebp),%eax
 124:	50                   	push   %eax
 125:	6a 00                	push   $0x0
 127:	e8 46 01 00 00       	call   272 <read>
 12c:	83 c4 10             	add    $0x10,%esp
 12f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 132:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 136:	7f 02                	jg     13a <gets+0x2d>
      break;
 138:	eb 31                	jmp    16b <gets+0x5e>
    buf[i++] = c;
 13a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 13d:	8d 50 01             	lea    0x1(%eax),%edx
 140:	89 55 f4             	mov    %edx,-0xc(%ebp)
 143:	89 c2                	mov    %eax,%edx
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	01 c2                	add    %eax,%edx
 14a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 14e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 150:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 154:	3c 0a                	cmp    $0xa,%al
 156:	74 13                	je     16b <gets+0x5e>
 158:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 15c:	3c 0d                	cmp    $0xd,%al
 15e:	74 0b                	je     16b <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 160:	8b 45 f4             	mov    -0xc(%ebp),%eax
 163:	83 c0 01             	add    $0x1,%eax
 166:	3b 45 0c             	cmp    0xc(%ebp),%eax
 169:	7c b1                	jl     11c <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 16b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	01 d0                	add    %edx,%eax
 173:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 176:	8b 45 08             	mov    0x8(%ebp),%eax
}
 179:	c9                   	leave  
 17a:	c3                   	ret    

0000017b <stat>:

int
stat(char *n, struct stat *st)
{
 17b:	55                   	push   %ebp
 17c:	89 e5                	mov    %esp,%ebp
 17e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 181:	83 ec 08             	sub    $0x8,%esp
 184:	6a 00                	push   $0x0
 186:	ff 75 08             	pushl  0x8(%ebp)
 189:	e8 0c 01 00 00       	call   29a <open>
 18e:	83 c4 10             	add    $0x10,%esp
 191:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 194:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 198:	79 07                	jns    1a1 <stat+0x26>
    return -1;
 19a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 19f:	eb 25                	jmp    1c6 <stat+0x4b>
  r = fstat(fd, st);
 1a1:	83 ec 08             	sub    $0x8,%esp
 1a4:	ff 75 0c             	pushl  0xc(%ebp)
 1a7:	ff 75 f4             	pushl  -0xc(%ebp)
 1aa:	e8 03 01 00 00       	call   2b2 <fstat>
 1af:	83 c4 10             	add    $0x10,%esp
 1b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1b5:	83 ec 0c             	sub    $0xc,%esp
 1b8:	ff 75 f4             	pushl  -0xc(%ebp)
 1bb:	e8 c2 00 00 00       	call   282 <close>
 1c0:	83 c4 10             	add    $0x10,%esp
  return r;
 1c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1c6:	c9                   	leave  
 1c7:	c3                   	ret    

000001c8 <atoi>:

int
atoi(const char *s)
{
 1c8:	55                   	push   %ebp
 1c9:	89 e5                	mov    %esp,%ebp
 1cb:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1d5:	eb 25                	jmp    1fc <atoi+0x34>
    n = n*10 + *s++ - '0';
 1d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1da:	89 d0                	mov    %edx,%eax
 1dc:	c1 e0 02             	shl    $0x2,%eax
 1df:	01 d0                	add    %edx,%eax
 1e1:	01 c0                	add    %eax,%eax
 1e3:	89 c1                	mov    %eax,%ecx
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	8d 50 01             	lea    0x1(%eax),%edx
 1eb:	89 55 08             	mov    %edx,0x8(%ebp)
 1ee:	0f b6 00             	movzbl (%eax),%eax
 1f1:	0f be c0             	movsbl %al,%eax
 1f4:	01 c8                	add    %ecx,%eax
 1f6:	83 e8 30             	sub    $0x30,%eax
 1f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	0f b6 00             	movzbl (%eax),%eax
 202:	3c 2f                	cmp    $0x2f,%al
 204:	7e 0a                	jle    210 <atoi+0x48>
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	0f b6 00             	movzbl (%eax),%eax
 20c:	3c 39                	cmp    $0x39,%al
 20e:	7e c7                	jle    1d7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 210:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 213:	c9                   	leave  
 214:	c3                   	ret    

00000215 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 215:	55                   	push   %ebp
 216:	89 e5                	mov    %esp,%ebp
 218:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 21b:	8b 45 08             	mov    0x8(%ebp),%eax
 21e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 221:	8b 45 0c             	mov    0xc(%ebp),%eax
 224:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 227:	eb 17                	jmp    240 <memmove+0x2b>
    *dst++ = *src++;
 229:	8b 45 fc             	mov    -0x4(%ebp),%eax
 22c:	8d 50 01             	lea    0x1(%eax),%edx
 22f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 232:	8b 55 f8             	mov    -0x8(%ebp),%edx
 235:	8d 4a 01             	lea    0x1(%edx),%ecx
 238:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 23b:	0f b6 12             	movzbl (%edx),%edx
 23e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 240:	8b 45 10             	mov    0x10(%ebp),%eax
 243:	8d 50 ff             	lea    -0x1(%eax),%edx
 246:	89 55 10             	mov    %edx,0x10(%ebp)
 249:	85 c0                	test   %eax,%eax
 24b:	7f dc                	jg     229 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 250:	c9                   	leave  
 251:	c3                   	ret    

00000252 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 252:	b8 01 00 00 00       	mov    $0x1,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <exit>:
SYSCALL(exit)
 25a:	b8 02 00 00 00       	mov    $0x2,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <wait>:
SYSCALL(wait)
 262:	b8 03 00 00 00       	mov    $0x3,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <pipe>:
SYSCALL(pipe)
 26a:	b8 04 00 00 00       	mov    $0x4,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <read>:
SYSCALL(read)
 272:	b8 05 00 00 00       	mov    $0x5,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <write>:
SYSCALL(write)
 27a:	b8 10 00 00 00       	mov    $0x10,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <close>:
SYSCALL(close)
 282:	b8 15 00 00 00       	mov    $0x15,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <kill>:
SYSCALL(kill)
 28a:	b8 06 00 00 00       	mov    $0x6,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <exec>:
SYSCALL(exec)
 292:	b8 07 00 00 00       	mov    $0x7,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <open>:
SYSCALL(open)
 29a:	b8 0f 00 00 00       	mov    $0xf,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <mknod>:
SYSCALL(mknod)
 2a2:	b8 11 00 00 00       	mov    $0x11,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <unlink>:
SYSCALL(unlink)
 2aa:	b8 12 00 00 00       	mov    $0x12,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <fstat>:
SYSCALL(fstat)
 2b2:	b8 08 00 00 00       	mov    $0x8,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <link>:
SYSCALL(link)
 2ba:	b8 13 00 00 00       	mov    $0x13,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <mkdir>:
SYSCALL(mkdir)
 2c2:	b8 14 00 00 00       	mov    $0x14,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <chdir>:
SYSCALL(chdir)
 2ca:	b8 09 00 00 00       	mov    $0x9,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <dup>:
SYSCALL(dup)
 2d2:	b8 0a 00 00 00       	mov    $0xa,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <getpid>:
SYSCALL(getpid)
 2da:	b8 0b 00 00 00       	mov    $0xb,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <sbrk>:
SYSCALL(sbrk)
 2e2:	b8 0c 00 00 00       	mov    $0xc,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <sleep>:
SYSCALL(sleep)
 2ea:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <uptime>:
SYSCALL(uptime)
 2f2:	b8 0e 00 00 00       	mov    $0xe,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <pstat>:
SYSCALL(pstat)
 2fa:	b8 16 00 00 00       	mov    $0x16,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 302:	55                   	push   %ebp
 303:	89 e5                	mov    %esp,%ebp
 305:	83 ec 18             	sub    $0x18,%esp
 308:	8b 45 0c             	mov    0xc(%ebp),%eax
 30b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 30e:	83 ec 04             	sub    $0x4,%esp
 311:	6a 01                	push   $0x1
 313:	8d 45 f4             	lea    -0xc(%ebp),%eax
 316:	50                   	push   %eax
 317:	ff 75 08             	pushl  0x8(%ebp)
 31a:	e8 5b ff ff ff       	call   27a <write>
 31f:	83 c4 10             	add    $0x10,%esp
}
 322:	c9                   	leave  
 323:	c3                   	ret    

00000324 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	53                   	push   %ebx
 328:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 32b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 332:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 336:	74 17                	je     34f <printint+0x2b>
 338:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 33c:	79 11                	jns    34f <printint+0x2b>
    neg = 1;
 33e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 345:	8b 45 0c             	mov    0xc(%ebp),%eax
 348:	f7 d8                	neg    %eax
 34a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 34d:	eb 06                	jmp    355 <printint+0x31>
  } else {
    x = xx;
 34f:	8b 45 0c             	mov    0xc(%ebp),%eax
 352:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 355:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 35c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 35f:	8d 41 01             	lea    0x1(%ecx),%eax
 362:	89 45 f4             	mov    %eax,-0xc(%ebp)
 365:	8b 5d 10             	mov    0x10(%ebp),%ebx
 368:	8b 45 ec             	mov    -0x14(%ebp),%eax
 36b:	ba 00 00 00 00       	mov    $0x0,%edx
 370:	f7 f3                	div    %ebx
 372:	89 d0                	mov    %edx,%eax
 374:	0f b6 80 d4 09 00 00 	movzbl 0x9d4(%eax),%eax
 37b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 37f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 382:	8b 45 ec             	mov    -0x14(%ebp),%eax
 385:	ba 00 00 00 00       	mov    $0x0,%edx
 38a:	f7 f3                	div    %ebx
 38c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 38f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 393:	75 c7                	jne    35c <printint+0x38>
  if(neg)
 395:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 399:	74 0e                	je     3a9 <printint+0x85>
    buf[i++] = '-';
 39b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 39e:	8d 50 01             	lea    0x1(%eax),%edx
 3a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3a4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3a9:	eb 1d                	jmp    3c8 <printint+0xa4>
    putc(fd, buf[i]);
 3ab:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3b1:	01 d0                	add    %edx,%eax
 3b3:	0f b6 00             	movzbl (%eax),%eax
 3b6:	0f be c0             	movsbl %al,%eax
 3b9:	83 ec 08             	sub    $0x8,%esp
 3bc:	50                   	push   %eax
 3bd:	ff 75 08             	pushl  0x8(%ebp)
 3c0:	e8 3d ff ff ff       	call   302 <putc>
 3c5:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3c8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3d0:	79 d9                	jns    3ab <printint+0x87>
    putc(fd, buf[i]);
}
 3d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3d5:	c9                   	leave  
 3d6:	c3                   	ret    

000003d7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d7:	55                   	push   %ebp
 3d8:	89 e5                	mov    %esp,%ebp
 3da:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 3e4:	8d 45 0c             	lea    0xc(%ebp),%eax
 3e7:	83 c0 04             	add    $0x4,%eax
 3ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 3ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3f4:	e9 59 01 00 00       	jmp    552 <printf+0x17b>
    c = fmt[i] & 0xff;
 3f9:	8b 55 0c             	mov    0xc(%ebp),%edx
 3fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 3ff:	01 d0                	add    %edx,%eax
 401:	0f b6 00             	movzbl (%eax),%eax
 404:	0f be c0             	movsbl %al,%eax
 407:	25 ff 00 00 00       	and    $0xff,%eax
 40c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 40f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 413:	75 2c                	jne    441 <printf+0x6a>
      if(c == '%'){
 415:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 419:	75 0c                	jne    427 <printf+0x50>
        state = '%';
 41b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 422:	e9 27 01 00 00       	jmp    54e <printf+0x177>
      } else {
        putc(fd, c);
 427:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 42a:	0f be c0             	movsbl %al,%eax
 42d:	83 ec 08             	sub    $0x8,%esp
 430:	50                   	push   %eax
 431:	ff 75 08             	pushl  0x8(%ebp)
 434:	e8 c9 fe ff ff       	call   302 <putc>
 439:	83 c4 10             	add    $0x10,%esp
 43c:	e9 0d 01 00 00       	jmp    54e <printf+0x177>
      }
    } else if(state == '%'){
 441:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 445:	0f 85 03 01 00 00    	jne    54e <printf+0x177>
      if(c == 'd'){
 44b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 44f:	75 1e                	jne    46f <printf+0x98>
        printint(fd, *ap, 10, 1);
 451:	8b 45 e8             	mov    -0x18(%ebp),%eax
 454:	8b 00                	mov    (%eax),%eax
 456:	6a 01                	push   $0x1
 458:	6a 0a                	push   $0xa
 45a:	50                   	push   %eax
 45b:	ff 75 08             	pushl  0x8(%ebp)
 45e:	e8 c1 fe ff ff       	call   324 <printint>
 463:	83 c4 10             	add    $0x10,%esp
        ap++;
 466:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 46a:	e9 d8 00 00 00       	jmp    547 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 46f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 473:	74 06                	je     47b <printf+0xa4>
 475:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 479:	75 1e                	jne    499 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 47b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 47e:	8b 00                	mov    (%eax),%eax
 480:	6a 00                	push   $0x0
 482:	6a 10                	push   $0x10
 484:	50                   	push   %eax
 485:	ff 75 08             	pushl  0x8(%ebp)
 488:	e8 97 fe ff ff       	call   324 <printint>
 48d:	83 c4 10             	add    $0x10,%esp
        ap++;
 490:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 494:	e9 ae 00 00 00       	jmp    547 <printf+0x170>
      } else if(c == 's'){
 499:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 49d:	75 43                	jne    4e2 <printf+0x10b>
        s = (char*)*ap;
 49f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a2:	8b 00                	mov    (%eax),%eax
 4a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4af:	75 07                	jne    4b8 <printf+0xe1>
          s = "(null)";
 4b1:	c7 45 f4 8b 07 00 00 	movl   $0x78b,-0xc(%ebp)
        while(*s != 0){
 4b8:	eb 1c                	jmp    4d6 <printf+0xff>
          putc(fd, *s);
 4ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4bd:	0f b6 00             	movzbl (%eax),%eax
 4c0:	0f be c0             	movsbl %al,%eax
 4c3:	83 ec 08             	sub    $0x8,%esp
 4c6:	50                   	push   %eax
 4c7:	ff 75 08             	pushl  0x8(%ebp)
 4ca:	e8 33 fe ff ff       	call   302 <putc>
 4cf:	83 c4 10             	add    $0x10,%esp
          s++;
 4d2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d9:	0f b6 00             	movzbl (%eax),%eax
 4dc:	84 c0                	test   %al,%al
 4de:	75 da                	jne    4ba <printf+0xe3>
 4e0:	eb 65                	jmp    547 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4e2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 4e6:	75 1d                	jne    505 <printf+0x12e>
        putc(fd, *ap);
 4e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4eb:	8b 00                	mov    (%eax),%eax
 4ed:	0f be c0             	movsbl %al,%eax
 4f0:	83 ec 08             	sub    $0x8,%esp
 4f3:	50                   	push   %eax
 4f4:	ff 75 08             	pushl  0x8(%ebp)
 4f7:	e8 06 fe ff ff       	call   302 <putc>
 4fc:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 503:	eb 42                	jmp    547 <printf+0x170>
      } else if(c == '%'){
 505:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 509:	75 17                	jne    522 <printf+0x14b>
        putc(fd, c);
 50b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50e:	0f be c0             	movsbl %al,%eax
 511:	83 ec 08             	sub    $0x8,%esp
 514:	50                   	push   %eax
 515:	ff 75 08             	pushl  0x8(%ebp)
 518:	e8 e5 fd ff ff       	call   302 <putc>
 51d:	83 c4 10             	add    $0x10,%esp
 520:	eb 25                	jmp    547 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 522:	83 ec 08             	sub    $0x8,%esp
 525:	6a 25                	push   $0x25
 527:	ff 75 08             	pushl  0x8(%ebp)
 52a:	e8 d3 fd ff ff       	call   302 <putc>
 52f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 532:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 535:	0f be c0             	movsbl %al,%eax
 538:	83 ec 08             	sub    $0x8,%esp
 53b:	50                   	push   %eax
 53c:	ff 75 08             	pushl  0x8(%ebp)
 53f:	e8 be fd ff ff       	call   302 <putc>
 544:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 547:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 54e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 552:	8b 55 0c             	mov    0xc(%ebp),%edx
 555:	8b 45 f0             	mov    -0x10(%ebp),%eax
 558:	01 d0                	add    %edx,%eax
 55a:	0f b6 00             	movzbl (%eax),%eax
 55d:	84 c0                	test   %al,%al
 55f:	0f 85 94 fe ff ff    	jne    3f9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 565:	c9                   	leave  
 566:	c3                   	ret    

00000567 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 567:	55                   	push   %ebp
 568:	89 e5                	mov    %esp,%ebp
 56a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	83 e8 08             	sub    $0x8,%eax
 573:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 576:	a1 f0 09 00 00       	mov    0x9f0,%eax
 57b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 57e:	eb 24                	jmp    5a4 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 580:	8b 45 fc             	mov    -0x4(%ebp),%eax
 583:	8b 00                	mov    (%eax),%eax
 585:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 588:	77 12                	ja     59c <free+0x35>
 58a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 58d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 590:	77 24                	ja     5b6 <free+0x4f>
 592:	8b 45 fc             	mov    -0x4(%ebp),%eax
 595:	8b 00                	mov    (%eax),%eax
 597:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 59a:	77 1a                	ja     5b6 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 59c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59f:	8b 00                	mov    (%eax),%eax
 5a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5a7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5aa:	76 d4                	jbe    580 <free+0x19>
 5ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5af:	8b 00                	mov    (%eax),%eax
 5b1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5b4:	76 ca                	jbe    580 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5b9:	8b 40 04             	mov    0x4(%eax),%eax
 5bc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c6:	01 c2                	add    %eax,%edx
 5c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cb:	8b 00                	mov    (%eax),%eax
 5cd:	39 c2                	cmp    %eax,%edx
 5cf:	75 24                	jne    5f5 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d4:	8b 50 04             	mov    0x4(%eax),%edx
 5d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5da:	8b 00                	mov    (%eax),%eax
 5dc:	8b 40 04             	mov    0x4(%eax),%eax
 5df:	01 c2                	add    %eax,%edx
 5e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e4:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ea:	8b 00                	mov    (%eax),%eax
 5ec:	8b 10                	mov    (%eax),%edx
 5ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f1:	89 10                	mov    %edx,(%eax)
 5f3:	eb 0a                	jmp    5ff <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 5f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f8:	8b 10                	mov    (%eax),%edx
 5fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fd:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 5ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 602:	8b 40 04             	mov    0x4(%eax),%eax
 605:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60f:	01 d0                	add    %edx,%eax
 611:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 614:	75 20                	jne    636 <free+0xcf>
    p->s.size += bp->s.size;
 616:	8b 45 fc             	mov    -0x4(%ebp),%eax
 619:	8b 50 04             	mov    0x4(%eax),%edx
 61c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61f:	8b 40 04             	mov    0x4(%eax),%eax
 622:	01 c2                	add    %eax,%edx
 624:	8b 45 fc             	mov    -0x4(%ebp),%eax
 627:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 62a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62d:	8b 10                	mov    (%eax),%edx
 62f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 632:	89 10                	mov    %edx,(%eax)
 634:	eb 08                	jmp    63e <free+0xd7>
  } else
    p->s.ptr = bp;
 636:	8b 45 fc             	mov    -0x4(%ebp),%eax
 639:	8b 55 f8             	mov    -0x8(%ebp),%edx
 63c:	89 10                	mov    %edx,(%eax)
  freep = p;
 63e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 641:	a3 f0 09 00 00       	mov    %eax,0x9f0
}
 646:	c9                   	leave  
 647:	c3                   	ret    

00000648 <morecore>:

static Header*
morecore(uint nu)
{
 648:	55                   	push   %ebp
 649:	89 e5                	mov    %esp,%ebp
 64b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 64e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 655:	77 07                	ja     65e <morecore+0x16>
    nu = 4096;
 657:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 65e:	8b 45 08             	mov    0x8(%ebp),%eax
 661:	c1 e0 03             	shl    $0x3,%eax
 664:	83 ec 0c             	sub    $0xc,%esp
 667:	50                   	push   %eax
 668:	e8 75 fc ff ff       	call   2e2 <sbrk>
 66d:	83 c4 10             	add    $0x10,%esp
 670:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 673:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 677:	75 07                	jne    680 <morecore+0x38>
    return 0;
 679:	b8 00 00 00 00       	mov    $0x0,%eax
 67e:	eb 26                	jmp    6a6 <morecore+0x5e>
  hp = (Header*)p;
 680:	8b 45 f4             	mov    -0xc(%ebp),%eax
 683:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 686:	8b 45 f0             	mov    -0x10(%ebp),%eax
 689:	8b 55 08             	mov    0x8(%ebp),%edx
 68c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 68f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 692:	83 c0 08             	add    $0x8,%eax
 695:	83 ec 0c             	sub    $0xc,%esp
 698:	50                   	push   %eax
 699:	e8 c9 fe ff ff       	call   567 <free>
 69e:	83 c4 10             	add    $0x10,%esp
  return freep;
 6a1:	a1 f0 09 00 00       	mov    0x9f0,%eax
}
 6a6:	c9                   	leave  
 6a7:	c3                   	ret    

000006a8 <malloc>:

void*
malloc(uint nbytes)
{
 6a8:	55                   	push   %ebp
 6a9:	89 e5                	mov    %esp,%ebp
 6ab:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ae:	8b 45 08             	mov    0x8(%ebp),%eax
 6b1:	83 c0 07             	add    $0x7,%eax
 6b4:	c1 e8 03             	shr    $0x3,%eax
 6b7:	83 c0 01             	add    $0x1,%eax
 6ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6bd:	a1 f0 09 00 00       	mov    0x9f0,%eax
 6c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6c9:	75 23                	jne    6ee <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 6cb:	c7 45 f0 e8 09 00 00 	movl   $0x9e8,-0x10(%ebp)
 6d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d5:	a3 f0 09 00 00       	mov    %eax,0x9f0
 6da:	a1 f0 09 00 00       	mov    0x9f0,%eax
 6df:	a3 e8 09 00 00       	mov    %eax,0x9e8
    base.s.size = 0;
 6e4:	c7 05 ec 09 00 00 00 	movl   $0x0,0x9ec
 6eb:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f1:	8b 00                	mov    (%eax),%eax
 6f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 6f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f9:	8b 40 04             	mov    0x4(%eax),%eax
 6fc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 6ff:	72 4d                	jb     74e <malloc+0xa6>
      if(p->s.size == nunits)
 701:	8b 45 f4             	mov    -0xc(%ebp),%eax
 704:	8b 40 04             	mov    0x4(%eax),%eax
 707:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 70a:	75 0c                	jne    718 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 70c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 70f:	8b 10                	mov    (%eax),%edx
 711:	8b 45 f0             	mov    -0x10(%ebp),%eax
 714:	89 10                	mov    %edx,(%eax)
 716:	eb 26                	jmp    73e <malloc+0x96>
      else {
        p->s.size -= nunits;
 718:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71b:	8b 40 04             	mov    0x4(%eax),%eax
 71e:	2b 45 ec             	sub    -0x14(%ebp),%eax
 721:	89 c2                	mov    %eax,%edx
 723:	8b 45 f4             	mov    -0xc(%ebp),%eax
 726:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 729:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72c:	8b 40 04             	mov    0x4(%eax),%eax
 72f:	c1 e0 03             	shl    $0x3,%eax
 732:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 735:	8b 45 f4             	mov    -0xc(%ebp),%eax
 738:	8b 55 ec             	mov    -0x14(%ebp),%edx
 73b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 73e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 741:	a3 f0 09 00 00       	mov    %eax,0x9f0
      return (void*)(p + 1);
 746:	8b 45 f4             	mov    -0xc(%ebp),%eax
 749:	83 c0 08             	add    $0x8,%eax
 74c:	eb 3b                	jmp    789 <malloc+0xe1>
    }
    if(p == freep)
 74e:	a1 f0 09 00 00       	mov    0x9f0,%eax
 753:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 756:	75 1e                	jne    776 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 758:	83 ec 0c             	sub    $0xc,%esp
 75b:	ff 75 ec             	pushl  -0x14(%ebp)
 75e:	e8 e5 fe ff ff       	call   648 <morecore>
 763:	83 c4 10             	add    $0x10,%esp
 766:	89 45 f4             	mov    %eax,-0xc(%ebp)
 769:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 76d:	75 07                	jne    776 <malloc+0xce>
        return 0;
 76f:	b8 00 00 00 00       	mov    $0x0,%eax
 774:	eb 13                	jmp    789 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 776:	8b 45 f4             	mov    -0xc(%ebp),%eax
 779:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77f:	8b 00                	mov    (%eax),%eax
 781:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 784:	e9 6d ff ff ff       	jmp    6f6 <malloc+0x4e>
}
 789:	c9                   	leave  
 78a:	c3                   	ret    
