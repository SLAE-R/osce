
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 68 02 00 00       	call   27e <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 f2 02 00 00       	call   316 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
  27:	83 ec 0c             	sub    $0xc,%esp
  2a:	6a 01                	push   $0x1
  2c:	e8 55 02 00 00       	call   286 <exit>

00000031 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  31:	55                   	push   %ebp
  32:	89 e5                	mov    %esp,%ebp
  34:	57                   	push   %edi
  35:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  36:	8b 4d 08             	mov    0x8(%ebp),%ecx
  39:	8b 55 10             	mov    0x10(%ebp),%edx
  3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  3f:	89 cb                	mov    %ecx,%ebx
  41:	89 df                	mov    %ebx,%edi
  43:	89 d1                	mov    %edx,%ecx
  45:	fc                   	cld    
  46:	f3 aa                	rep stos %al,%es:(%edi)
  48:	89 ca                	mov    %ecx,%edx
  4a:	89 fb                	mov    %edi,%ebx
  4c:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  52:	5b                   	pop    %ebx
  53:	5f                   	pop    %edi
  54:	5d                   	pop    %ebp
  55:	c3                   	ret    

00000056 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  56:	55                   	push   %ebp
  57:	89 e5                	mov    %esp,%ebp
  59:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  62:	90                   	nop
  63:	8b 45 08             	mov    0x8(%ebp),%eax
  66:	8d 50 01             	lea    0x1(%eax),%edx
  69:	89 55 08             	mov    %edx,0x8(%ebp)
  6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  6f:	8d 4a 01             	lea    0x1(%edx),%ecx
  72:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  75:	0f b6 12             	movzbl (%edx),%edx
  78:	88 10                	mov    %dl,(%eax)
  7a:	0f b6 00             	movzbl (%eax),%eax
  7d:	84 c0                	test   %al,%al
  7f:	75 e2                	jne    63 <strcpy+0xd>
    ;
  return os;
  81:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  84:	c9                   	leave  
  85:	c3                   	ret    

00000086 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  86:	55                   	push   %ebp
  87:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  89:	eb 08                	jmp    93 <strcmp+0xd>
    p++, q++;
  8b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  93:	8b 45 08             	mov    0x8(%ebp),%eax
  96:	0f b6 00             	movzbl (%eax),%eax
  99:	84 c0                	test   %al,%al
  9b:	74 10                	je     ad <strcmp+0x27>
  9d:	8b 45 08             	mov    0x8(%ebp),%eax
  a0:	0f b6 10             	movzbl (%eax),%edx
  a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  a6:	0f b6 00             	movzbl (%eax),%eax
  a9:	38 c2                	cmp    %al,%dl
  ab:	74 de                	je     8b <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ad:	8b 45 08             	mov    0x8(%ebp),%eax
  b0:	0f b6 00             	movzbl (%eax),%eax
  b3:	0f b6 d0             	movzbl %al,%edx
  b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  b9:	0f b6 00             	movzbl (%eax),%eax
  bc:	0f b6 c0             	movzbl %al,%eax
  bf:	29 c2                	sub    %eax,%edx
  c1:	89 d0                	mov    %edx,%eax
}
  c3:	5d                   	pop    %ebp
  c4:	c3                   	ret    

000000c5 <strlen>:

uint
strlen(char *s)
{
  c5:	55                   	push   %ebp
  c6:	89 e5                	mov    %esp,%ebp
  c8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  d2:	eb 04                	jmp    d8 <strlen+0x13>
  d4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	01 d0                	add    %edx,%eax
  e0:	0f b6 00             	movzbl (%eax),%eax
  e3:	84 c0                	test   %al,%al
  e5:	75 ed                	jne    d4 <strlen+0xf>
    ;
  return n;
  e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ea:	c9                   	leave  
  eb:	c3                   	ret    

000000ec <memset>:

void*
memset(void *dst, int c, uint n)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  ef:	8b 45 10             	mov    0x10(%ebp),%eax
  f2:	50                   	push   %eax
  f3:	ff 75 0c             	pushl  0xc(%ebp)
  f6:	ff 75 08             	pushl  0x8(%ebp)
  f9:	e8 33 ff ff ff       	call   31 <stosb>
  fe:	83 c4 0c             	add    $0xc,%esp
  return dst;
 101:	8b 45 08             	mov    0x8(%ebp),%eax
}
 104:	c9                   	leave  
 105:	c3                   	ret    

00000106 <strchr>:

char*
strchr(const char *s, char c)
{
 106:	55                   	push   %ebp
 107:	89 e5                	mov    %esp,%ebp
 109:	83 ec 04             	sub    $0x4,%esp
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 112:	eb 14                	jmp    128 <strchr+0x22>
    if(*s == c)
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	0f b6 00             	movzbl (%eax),%eax
 11a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 11d:	75 05                	jne    124 <strchr+0x1e>
      return (char*)s;
 11f:	8b 45 08             	mov    0x8(%ebp),%eax
 122:	eb 13                	jmp    137 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 124:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	0f b6 00             	movzbl (%eax),%eax
 12e:	84 c0                	test   %al,%al
 130:	75 e2                	jne    114 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 132:	b8 00 00 00 00       	mov    $0x0,%eax
}
 137:	c9                   	leave  
 138:	c3                   	ret    

00000139 <gets>:

char*
gets(char *buf, int max)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 146:	eb 44                	jmp    18c <gets+0x53>
    cc = read(0, &c, 1);
 148:	83 ec 04             	sub    $0x4,%esp
 14b:	6a 01                	push   $0x1
 14d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 150:	50                   	push   %eax
 151:	6a 00                	push   $0x0
 153:	e8 46 01 00 00       	call   29e <read>
 158:	83 c4 10             	add    $0x10,%esp
 15b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 15e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 162:	7f 02                	jg     166 <gets+0x2d>
      break;
 164:	eb 31                	jmp    197 <gets+0x5e>
    buf[i++] = c;
 166:	8b 45 f4             	mov    -0xc(%ebp),%eax
 169:	8d 50 01             	lea    0x1(%eax),%edx
 16c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 16f:	89 c2                	mov    %eax,%edx
 171:	8b 45 08             	mov    0x8(%ebp),%eax
 174:	01 c2                	add    %eax,%edx
 176:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 17c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 180:	3c 0a                	cmp    $0xa,%al
 182:	74 13                	je     197 <gets+0x5e>
 184:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 188:	3c 0d                	cmp    $0xd,%al
 18a:	74 0b                	je     197 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18f:	83 c0 01             	add    $0x1,%eax
 192:	3b 45 0c             	cmp    0xc(%ebp),%eax
 195:	7c b1                	jl     148 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 197:	8b 55 f4             	mov    -0xc(%ebp),%edx
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	01 d0                	add    %edx,%eax
 19f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a5:	c9                   	leave  
 1a6:	c3                   	ret    

000001a7 <stat>:

int
stat(char *n, struct stat *st)
{
 1a7:	55                   	push   %ebp
 1a8:	89 e5                	mov    %esp,%ebp
 1aa:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ad:	83 ec 08             	sub    $0x8,%esp
 1b0:	6a 00                	push   $0x0
 1b2:	ff 75 08             	pushl  0x8(%ebp)
 1b5:	e8 0c 01 00 00       	call   2c6 <open>
 1ba:	83 c4 10             	add    $0x10,%esp
 1bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c4:	79 07                	jns    1cd <stat+0x26>
    return -1;
 1c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1cb:	eb 25                	jmp    1f2 <stat+0x4b>
  r = fstat(fd, st);
 1cd:	83 ec 08             	sub    $0x8,%esp
 1d0:	ff 75 0c             	pushl  0xc(%ebp)
 1d3:	ff 75 f4             	pushl  -0xc(%ebp)
 1d6:	e8 03 01 00 00       	call   2de <fstat>
 1db:	83 c4 10             	add    $0x10,%esp
 1de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e1:	83 ec 0c             	sub    $0xc,%esp
 1e4:	ff 75 f4             	pushl  -0xc(%ebp)
 1e7:	e8 c2 00 00 00       	call   2ae <close>
 1ec:	83 c4 10             	add    $0x10,%esp
  return r;
 1ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f2:	c9                   	leave  
 1f3:	c3                   	ret    

000001f4 <atoi>:

int
atoi(const char *s)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 201:	eb 25                	jmp    228 <atoi+0x34>
    n = n*10 + *s++ - '0';
 203:	8b 55 fc             	mov    -0x4(%ebp),%edx
 206:	89 d0                	mov    %edx,%eax
 208:	c1 e0 02             	shl    $0x2,%eax
 20b:	01 d0                	add    %edx,%eax
 20d:	01 c0                	add    %eax,%eax
 20f:	89 c1                	mov    %eax,%ecx
 211:	8b 45 08             	mov    0x8(%ebp),%eax
 214:	8d 50 01             	lea    0x1(%eax),%edx
 217:	89 55 08             	mov    %edx,0x8(%ebp)
 21a:	0f b6 00             	movzbl (%eax),%eax
 21d:	0f be c0             	movsbl %al,%eax
 220:	01 c8                	add    %ecx,%eax
 222:	83 e8 30             	sub    $0x30,%eax
 225:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 228:	8b 45 08             	mov    0x8(%ebp),%eax
 22b:	0f b6 00             	movzbl (%eax),%eax
 22e:	3c 2f                	cmp    $0x2f,%al
 230:	7e 0a                	jle    23c <atoi+0x48>
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	0f b6 00             	movzbl (%eax),%eax
 238:	3c 39                	cmp    $0x39,%al
 23a:	7e c7                	jle    203 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 23c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23f:	c9                   	leave  
 240:	c3                   	ret    

00000241 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 241:	55                   	push   %ebp
 242:	89 e5                	mov    %esp,%ebp
 244:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24d:	8b 45 0c             	mov    0xc(%ebp),%eax
 250:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 253:	eb 17                	jmp    26c <memmove+0x2b>
    *dst++ = *src++;
 255:	8b 45 fc             	mov    -0x4(%ebp),%eax
 258:	8d 50 01             	lea    0x1(%eax),%edx
 25b:	89 55 fc             	mov    %edx,-0x4(%ebp)
 25e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 261:	8d 4a 01             	lea    0x1(%edx),%ecx
 264:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 267:	0f b6 12             	movzbl (%edx),%edx
 26a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26c:	8b 45 10             	mov    0x10(%ebp),%eax
 26f:	8d 50 ff             	lea    -0x1(%eax),%edx
 272:	89 55 10             	mov    %edx,0x10(%ebp)
 275:	85 c0                	test   %eax,%eax
 277:	7f dc                	jg     255 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 279:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27c:	c9                   	leave  
 27d:	c3                   	ret    

0000027e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27e:	b8 01 00 00 00       	mov    $0x1,%eax
 283:	cd 40                	int    $0x40
 285:	c3                   	ret    

00000286 <exit>:
SYSCALL(exit)
 286:	b8 02 00 00 00       	mov    $0x2,%eax
 28b:	cd 40                	int    $0x40
 28d:	c3                   	ret    

0000028e <wait>:
SYSCALL(wait)
 28e:	b8 03 00 00 00       	mov    $0x3,%eax
 293:	cd 40                	int    $0x40
 295:	c3                   	ret    

00000296 <pipe>:
SYSCALL(pipe)
 296:	b8 04 00 00 00       	mov    $0x4,%eax
 29b:	cd 40                	int    $0x40
 29d:	c3                   	ret    

0000029e <read>:
SYSCALL(read)
 29e:	b8 05 00 00 00       	mov    $0x5,%eax
 2a3:	cd 40                	int    $0x40
 2a5:	c3                   	ret    

000002a6 <write>:
SYSCALL(write)
 2a6:	b8 10 00 00 00       	mov    $0x10,%eax
 2ab:	cd 40                	int    $0x40
 2ad:	c3                   	ret    

000002ae <close>:
SYSCALL(close)
 2ae:	b8 15 00 00 00       	mov    $0x15,%eax
 2b3:	cd 40                	int    $0x40
 2b5:	c3                   	ret    

000002b6 <kill>:
SYSCALL(kill)
 2b6:	b8 06 00 00 00       	mov    $0x6,%eax
 2bb:	cd 40                	int    $0x40
 2bd:	c3                   	ret    

000002be <exec>:
SYSCALL(exec)
 2be:	b8 07 00 00 00       	mov    $0x7,%eax
 2c3:	cd 40                	int    $0x40
 2c5:	c3                   	ret    

000002c6 <open>:
SYSCALL(open)
 2c6:	b8 0f 00 00 00       	mov    $0xf,%eax
 2cb:	cd 40                	int    $0x40
 2cd:	c3                   	ret    

000002ce <mknod>:
SYSCALL(mknod)
 2ce:	b8 11 00 00 00       	mov    $0x11,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <unlink>:
SYSCALL(unlink)
 2d6:	b8 12 00 00 00       	mov    $0x12,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <fstat>:
SYSCALL(fstat)
 2de:	b8 08 00 00 00       	mov    $0x8,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <link>:
SYSCALL(link)
 2e6:	b8 13 00 00 00       	mov    $0x13,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <mkdir>:
SYSCALL(mkdir)
 2ee:	b8 14 00 00 00       	mov    $0x14,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <chdir>:
SYSCALL(chdir)
 2f6:	b8 09 00 00 00       	mov    $0x9,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <dup>:
SYSCALL(dup)
 2fe:	b8 0a 00 00 00       	mov    $0xa,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <getpid>:
SYSCALL(getpid)
 306:	b8 0b 00 00 00       	mov    $0xb,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <sbrk>:
SYSCALL(sbrk)
 30e:	b8 0c 00 00 00       	mov    $0xc,%eax
 313:	cd 40                	int    $0x40
 315:	c3                   	ret    

00000316 <sleep>:
SYSCALL(sleep)
 316:	b8 0d 00 00 00       	mov    $0xd,%eax
 31b:	cd 40                	int    $0x40
 31d:	c3                   	ret    

0000031e <uptime>:
SYSCALL(uptime)
 31e:	b8 0e 00 00 00       	mov    $0xe,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <pstat>:
SYSCALL(pstat)
 326:	b8 16 00 00 00       	mov    $0x16,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 32e:	55                   	push   %ebp
 32f:	89 e5                	mov    %esp,%ebp
 331:	83 ec 18             	sub    $0x18,%esp
 334:	8b 45 0c             	mov    0xc(%ebp),%eax
 337:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 33a:	83 ec 04             	sub    $0x4,%esp
 33d:	6a 01                	push   $0x1
 33f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 342:	50                   	push   %eax
 343:	ff 75 08             	pushl  0x8(%ebp)
 346:	e8 5b ff ff ff       	call   2a6 <write>
 34b:	83 c4 10             	add    $0x10,%esp
}
 34e:	c9                   	leave  
 34f:	c3                   	ret    

00000350 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 357:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 35e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 362:	74 17                	je     37b <printint+0x2b>
 364:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 368:	79 11                	jns    37b <printint+0x2b>
    neg = 1;
 36a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 371:	8b 45 0c             	mov    0xc(%ebp),%eax
 374:	f7 d8                	neg    %eax
 376:	89 45 ec             	mov    %eax,-0x14(%ebp)
 379:	eb 06                	jmp    381 <printint+0x31>
  } else {
    x = xx;
 37b:	8b 45 0c             	mov    0xc(%ebp),%eax
 37e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 381:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 388:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 38b:	8d 41 01             	lea    0x1(%ecx),%eax
 38e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 391:	8b 5d 10             	mov    0x10(%ebp),%ebx
 394:	8b 45 ec             	mov    -0x14(%ebp),%eax
 397:	ba 00 00 00 00       	mov    $0x0,%edx
 39c:	f7 f3                	div    %ebx
 39e:	89 d0                	mov    %edx,%eax
 3a0:	0f b6 80 08 0a 00 00 	movzbl 0xa08(%eax),%eax
 3a7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3ab:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b1:	ba 00 00 00 00       	mov    $0x0,%edx
 3b6:	f7 f3                	div    %ebx
 3b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3bf:	75 c7                	jne    388 <printint+0x38>
  if(neg)
 3c1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3c5:	74 0e                	je     3d5 <printint+0x85>
    buf[i++] = '-';
 3c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ca:	8d 50 01             	lea    0x1(%eax),%edx
 3cd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3d0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3d5:	eb 1d                	jmp    3f4 <printint+0xa4>
    putc(fd, buf[i]);
 3d7:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3dd:	01 d0                	add    %edx,%eax
 3df:	0f b6 00             	movzbl (%eax),%eax
 3e2:	0f be c0             	movsbl %al,%eax
 3e5:	83 ec 08             	sub    $0x8,%esp
 3e8:	50                   	push   %eax
 3e9:	ff 75 08             	pushl  0x8(%ebp)
 3ec:	e8 3d ff ff ff       	call   32e <putc>
 3f1:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3f4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3fc:	79 d9                	jns    3d7 <printint+0x87>
    putc(fd, buf[i]);
}
 3fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 401:	c9                   	leave  
 402:	c3                   	ret    

00000403 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 403:	55                   	push   %ebp
 404:	89 e5                	mov    %esp,%ebp
 406:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 409:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 410:	8d 45 0c             	lea    0xc(%ebp),%eax
 413:	83 c0 04             	add    $0x4,%eax
 416:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 419:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 420:	e9 59 01 00 00       	jmp    57e <printf+0x17b>
    c = fmt[i] & 0xff;
 425:	8b 55 0c             	mov    0xc(%ebp),%edx
 428:	8b 45 f0             	mov    -0x10(%ebp),%eax
 42b:	01 d0                	add    %edx,%eax
 42d:	0f b6 00             	movzbl (%eax),%eax
 430:	0f be c0             	movsbl %al,%eax
 433:	25 ff 00 00 00       	and    $0xff,%eax
 438:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 43b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 43f:	75 2c                	jne    46d <printf+0x6a>
      if(c == '%'){
 441:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 445:	75 0c                	jne    453 <printf+0x50>
        state = '%';
 447:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 44e:	e9 27 01 00 00       	jmp    57a <printf+0x177>
      } else {
        putc(fd, c);
 453:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 456:	0f be c0             	movsbl %al,%eax
 459:	83 ec 08             	sub    $0x8,%esp
 45c:	50                   	push   %eax
 45d:	ff 75 08             	pushl  0x8(%ebp)
 460:	e8 c9 fe ff ff       	call   32e <putc>
 465:	83 c4 10             	add    $0x10,%esp
 468:	e9 0d 01 00 00       	jmp    57a <printf+0x177>
      }
    } else if(state == '%'){
 46d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 471:	0f 85 03 01 00 00    	jne    57a <printf+0x177>
      if(c == 'd'){
 477:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 47b:	75 1e                	jne    49b <printf+0x98>
        printint(fd, *ap, 10, 1);
 47d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 480:	8b 00                	mov    (%eax),%eax
 482:	6a 01                	push   $0x1
 484:	6a 0a                	push   $0xa
 486:	50                   	push   %eax
 487:	ff 75 08             	pushl  0x8(%ebp)
 48a:	e8 c1 fe ff ff       	call   350 <printint>
 48f:	83 c4 10             	add    $0x10,%esp
        ap++;
 492:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 496:	e9 d8 00 00 00       	jmp    573 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 49b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 49f:	74 06                	je     4a7 <printf+0xa4>
 4a1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4a5:	75 1e                	jne    4c5 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4aa:	8b 00                	mov    (%eax),%eax
 4ac:	6a 00                	push   $0x0
 4ae:	6a 10                	push   $0x10
 4b0:	50                   	push   %eax
 4b1:	ff 75 08             	pushl  0x8(%ebp)
 4b4:	e8 97 fe ff ff       	call   350 <printint>
 4b9:	83 c4 10             	add    $0x10,%esp
        ap++;
 4bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c0:	e9 ae 00 00 00       	jmp    573 <printf+0x170>
      } else if(c == 's'){
 4c5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4c9:	75 43                	jne    50e <printf+0x10b>
        s = (char*)*ap;
 4cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ce:	8b 00                	mov    (%eax),%eax
 4d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4db:	75 07                	jne    4e4 <printf+0xe1>
          s = "(null)";
 4dd:	c7 45 f4 b7 07 00 00 	movl   $0x7b7,-0xc(%ebp)
        while(*s != 0){
 4e4:	eb 1c                	jmp    502 <printf+0xff>
          putc(fd, *s);
 4e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e9:	0f b6 00             	movzbl (%eax),%eax
 4ec:	0f be c0             	movsbl %al,%eax
 4ef:	83 ec 08             	sub    $0x8,%esp
 4f2:	50                   	push   %eax
 4f3:	ff 75 08             	pushl  0x8(%ebp)
 4f6:	e8 33 fe ff ff       	call   32e <putc>
 4fb:	83 c4 10             	add    $0x10,%esp
          s++;
 4fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 502:	8b 45 f4             	mov    -0xc(%ebp),%eax
 505:	0f b6 00             	movzbl (%eax),%eax
 508:	84 c0                	test   %al,%al
 50a:	75 da                	jne    4e6 <printf+0xe3>
 50c:	eb 65                	jmp    573 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 50e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 512:	75 1d                	jne    531 <printf+0x12e>
        putc(fd, *ap);
 514:	8b 45 e8             	mov    -0x18(%ebp),%eax
 517:	8b 00                	mov    (%eax),%eax
 519:	0f be c0             	movsbl %al,%eax
 51c:	83 ec 08             	sub    $0x8,%esp
 51f:	50                   	push   %eax
 520:	ff 75 08             	pushl  0x8(%ebp)
 523:	e8 06 fe ff ff       	call   32e <putc>
 528:	83 c4 10             	add    $0x10,%esp
        ap++;
 52b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52f:	eb 42                	jmp    573 <printf+0x170>
      } else if(c == '%'){
 531:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 535:	75 17                	jne    54e <printf+0x14b>
        putc(fd, c);
 537:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 53a:	0f be c0             	movsbl %al,%eax
 53d:	83 ec 08             	sub    $0x8,%esp
 540:	50                   	push   %eax
 541:	ff 75 08             	pushl  0x8(%ebp)
 544:	e8 e5 fd ff ff       	call   32e <putc>
 549:	83 c4 10             	add    $0x10,%esp
 54c:	eb 25                	jmp    573 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 54e:	83 ec 08             	sub    $0x8,%esp
 551:	6a 25                	push   $0x25
 553:	ff 75 08             	pushl  0x8(%ebp)
 556:	e8 d3 fd ff ff       	call   32e <putc>
 55b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 55e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 561:	0f be c0             	movsbl %al,%eax
 564:	83 ec 08             	sub    $0x8,%esp
 567:	50                   	push   %eax
 568:	ff 75 08             	pushl  0x8(%ebp)
 56b:	e8 be fd ff ff       	call   32e <putc>
 570:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 573:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 57a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 57e:	8b 55 0c             	mov    0xc(%ebp),%edx
 581:	8b 45 f0             	mov    -0x10(%ebp),%eax
 584:	01 d0                	add    %edx,%eax
 586:	0f b6 00             	movzbl (%eax),%eax
 589:	84 c0                	test   %al,%al
 58b:	0f 85 94 fe ff ff    	jne    425 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 591:	c9                   	leave  
 592:	c3                   	ret    

00000593 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 593:	55                   	push   %ebp
 594:	89 e5                	mov    %esp,%ebp
 596:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 599:	8b 45 08             	mov    0x8(%ebp),%eax
 59c:	83 e8 08             	sub    $0x8,%eax
 59f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a2:	a1 24 0a 00 00       	mov    0xa24,%eax
 5a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5aa:	eb 24                	jmp    5d0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5af:	8b 00                	mov    (%eax),%eax
 5b1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5b4:	77 12                	ja     5c8 <free+0x35>
 5b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5b9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5bc:	77 24                	ja     5e2 <free+0x4f>
 5be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c1:	8b 00                	mov    (%eax),%eax
 5c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5c6:	77 1a                	ja     5e2 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cb:	8b 00                	mov    (%eax),%eax
 5cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d6:	76 d4                	jbe    5ac <free+0x19>
 5d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5db:	8b 00                	mov    (%eax),%eax
 5dd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e0:	76 ca                	jbe    5ac <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e5:	8b 40 04             	mov    0x4(%eax),%eax
 5e8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f2:	01 c2                	add    %eax,%edx
 5f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f7:	8b 00                	mov    (%eax),%eax
 5f9:	39 c2                	cmp    %eax,%edx
 5fb:	75 24                	jne    621 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 600:	8b 50 04             	mov    0x4(%eax),%edx
 603:	8b 45 fc             	mov    -0x4(%ebp),%eax
 606:	8b 00                	mov    (%eax),%eax
 608:	8b 40 04             	mov    0x4(%eax),%eax
 60b:	01 c2                	add    %eax,%edx
 60d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 610:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 613:	8b 45 fc             	mov    -0x4(%ebp),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	8b 10                	mov    (%eax),%edx
 61a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61d:	89 10                	mov    %edx,(%eax)
 61f:	eb 0a                	jmp    62b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 10                	mov    (%eax),%edx
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 62b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62e:	8b 40 04             	mov    0x4(%eax),%eax
 631:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 638:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63b:	01 d0                	add    %edx,%eax
 63d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 640:	75 20                	jne    662 <free+0xcf>
    p->s.size += bp->s.size;
 642:	8b 45 fc             	mov    -0x4(%ebp),%eax
 645:	8b 50 04             	mov    0x4(%eax),%edx
 648:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64b:	8b 40 04             	mov    0x4(%eax),%eax
 64e:	01 c2                	add    %eax,%edx
 650:	8b 45 fc             	mov    -0x4(%ebp),%eax
 653:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 656:	8b 45 f8             	mov    -0x8(%ebp),%eax
 659:	8b 10                	mov    (%eax),%edx
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	89 10                	mov    %edx,(%eax)
 660:	eb 08                	jmp    66a <free+0xd7>
  } else
    p->s.ptr = bp;
 662:	8b 45 fc             	mov    -0x4(%ebp),%eax
 665:	8b 55 f8             	mov    -0x8(%ebp),%edx
 668:	89 10                	mov    %edx,(%eax)
  freep = p;
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	a3 24 0a 00 00       	mov    %eax,0xa24
}
 672:	c9                   	leave  
 673:	c3                   	ret    

00000674 <morecore>:

static Header*
morecore(uint nu)
{
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 67a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 681:	77 07                	ja     68a <morecore+0x16>
    nu = 4096;
 683:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 68a:	8b 45 08             	mov    0x8(%ebp),%eax
 68d:	c1 e0 03             	shl    $0x3,%eax
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	50                   	push   %eax
 694:	e8 75 fc ff ff       	call   30e <sbrk>
 699:	83 c4 10             	add    $0x10,%esp
 69c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 69f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6a3:	75 07                	jne    6ac <morecore+0x38>
    return 0;
 6a5:	b8 00 00 00 00       	mov    $0x0,%eax
 6aa:	eb 26                	jmp    6d2 <morecore+0x5e>
  hp = (Header*)p;
 6ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b5:	8b 55 08             	mov    0x8(%ebp),%edx
 6b8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6be:	83 c0 08             	add    $0x8,%eax
 6c1:	83 ec 0c             	sub    $0xc,%esp
 6c4:	50                   	push   %eax
 6c5:	e8 c9 fe ff ff       	call   593 <free>
 6ca:	83 c4 10             	add    $0x10,%esp
  return freep;
 6cd:	a1 24 0a 00 00       	mov    0xa24,%eax
}
 6d2:	c9                   	leave  
 6d3:	c3                   	ret    

000006d4 <malloc>:

void*
malloc(uint nbytes)
{
 6d4:	55                   	push   %ebp
 6d5:	89 e5                	mov    %esp,%ebp
 6d7:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6da:	8b 45 08             	mov    0x8(%ebp),%eax
 6dd:	83 c0 07             	add    $0x7,%eax
 6e0:	c1 e8 03             	shr    $0x3,%eax
 6e3:	83 c0 01             	add    $0x1,%eax
 6e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6e9:	a1 24 0a 00 00       	mov    0xa24,%eax
 6ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6f5:	75 23                	jne    71a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 6f7:	c7 45 f0 1c 0a 00 00 	movl   $0xa1c,-0x10(%ebp)
 6fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 701:	a3 24 0a 00 00       	mov    %eax,0xa24
 706:	a1 24 0a 00 00       	mov    0xa24,%eax
 70b:	a3 1c 0a 00 00       	mov    %eax,0xa1c
    base.s.size = 0;
 710:	c7 05 20 0a 00 00 00 	movl   $0x0,0xa20
 717:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 71a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71d:	8b 00                	mov    (%eax),%eax
 71f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 722:	8b 45 f4             	mov    -0xc(%ebp),%eax
 725:	8b 40 04             	mov    0x4(%eax),%eax
 728:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 72b:	72 4d                	jb     77a <malloc+0xa6>
      if(p->s.size == nunits)
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8b 40 04             	mov    0x4(%eax),%eax
 733:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 736:	75 0c                	jne    744 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 738:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73b:	8b 10                	mov    (%eax),%edx
 73d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 740:	89 10                	mov    %edx,(%eax)
 742:	eb 26                	jmp    76a <malloc+0x96>
      else {
        p->s.size -= nunits;
 744:	8b 45 f4             	mov    -0xc(%ebp),%eax
 747:	8b 40 04             	mov    0x4(%eax),%eax
 74a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 74d:	89 c2                	mov    %eax,%edx
 74f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 752:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	8b 40 04             	mov    0x4(%eax),%eax
 75b:	c1 e0 03             	shl    $0x3,%eax
 75e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 761:	8b 45 f4             	mov    -0xc(%ebp),%eax
 764:	8b 55 ec             	mov    -0x14(%ebp),%edx
 767:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 76a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76d:	a3 24 0a 00 00       	mov    %eax,0xa24
      return (void*)(p + 1);
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	83 c0 08             	add    $0x8,%eax
 778:	eb 3b                	jmp    7b5 <malloc+0xe1>
    }
    if(p == freep)
 77a:	a1 24 0a 00 00       	mov    0xa24,%eax
 77f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 782:	75 1e                	jne    7a2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 784:	83 ec 0c             	sub    $0xc,%esp
 787:	ff 75 ec             	pushl  -0x14(%ebp)
 78a:	e8 e5 fe ff ff       	call   674 <morecore>
 78f:	83 c4 10             	add    $0x10,%esp
 792:	89 45 f4             	mov    %eax,-0xc(%ebp)
 795:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 799:	75 07                	jne    7a2 <malloc+0xce>
        return 0;
 79b:	b8 00 00 00 00       	mov    $0x0,%eax
 7a0:	eb 13                	jmp    7b5 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ab:	8b 00                	mov    (%eax),%eax
 7ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7b0:	e9 6d ff ff ff       	jmp    722 <malloc+0x4e>
}
 7b5:	c9                   	leave  
 7b6:	c3                   	ret    
