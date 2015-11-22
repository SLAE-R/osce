
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  for(i = 1; i < argc; i++)
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  20:	83 c0 01             	add    $0x1,%eax
  23:	3b 03                	cmp    (%ebx),%eax
  25:	7d 07                	jge    2e <main+0x2e>
  27:	ba f0 07 00 00       	mov    $0x7f0,%edx
  2c:	eb 05                	jmp    33 <main+0x33>
  2e:	ba f2 07 00 00       	mov    $0x7f2,%edx
  33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  3d:	8b 43 04             	mov    0x4(%ebx),%eax
  40:	01 c8                	add    %ecx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	52                   	push   %edx
  45:	50                   	push   %eax
  46:	68 f4 07 00 00       	push   $0x7f4
  4b:	6a 01                	push   $0x1
  4d:	e8 ea 03 00 00       	call   43c <printf>
  52:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5c:	3b 03                	cmp    (%ebx),%eax
  5e:	7c bd                	jl     1d <main+0x1d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit(EXIT_STATUS_OK);
  60:	83 ec 0c             	sub    $0xc,%esp
  63:	6a 01                	push   $0x1
  65:	e8 55 02 00 00       	call   2bf <exit>

0000006a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  6a:	55                   	push   %ebp
  6b:	89 e5                	mov    %esp,%ebp
  6d:	57                   	push   %edi
  6e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  72:	8b 55 10             	mov    0x10(%ebp),%edx
  75:	8b 45 0c             	mov    0xc(%ebp),%eax
  78:	89 cb                	mov    %ecx,%ebx
  7a:	89 df                	mov    %ebx,%edi
  7c:	89 d1                	mov    %edx,%ecx
  7e:	fc                   	cld    
  7f:	f3 aa                	rep stos %al,%es:(%edi)
  81:	89 ca                	mov    %ecx,%edx
  83:	89 fb                	mov    %edi,%ebx
  85:	89 5d 08             	mov    %ebx,0x8(%ebp)
  88:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  8b:	5b                   	pop    %ebx
  8c:	5f                   	pop    %edi
  8d:	5d                   	pop    %ebp
  8e:	c3                   	ret    

0000008f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8f:	55                   	push   %ebp
  90:	89 e5                	mov    %esp,%ebp
  92:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  95:	8b 45 08             	mov    0x8(%ebp),%eax
  98:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  9b:	90                   	nop
  9c:	8b 45 08             	mov    0x8(%ebp),%eax
  9f:	8d 50 01             	lea    0x1(%eax),%edx
  a2:	89 55 08             	mov    %edx,0x8(%ebp)
  a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  a8:	8d 4a 01             	lea    0x1(%edx),%ecx
  ab:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  ae:	0f b6 12             	movzbl (%edx),%edx
  b1:	88 10                	mov    %dl,(%eax)
  b3:	0f b6 00             	movzbl (%eax),%eax
  b6:	84 c0                	test   %al,%al
  b8:	75 e2                	jne    9c <strcpy+0xd>
    ;
  return os;
  ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bd:	c9                   	leave  
  be:	c3                   	ret    

000000bf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bf:	55                   	push   %ebp
  c0:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c2:	eb 08                	jmp    cc <strcmp+0xd>
    p++, q++;
  c4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  cc:	8b 45 08             	mov    0x8(%ebp),%eax
  cf:	0f b6 00             	movzbl (%eax),%eax
  d2:	84 c0                	test   %al,%al
  d4:	74 10                	je     e6 <strcmp+0x27>
  d6:	8b 45 08             	mov    0x8(%ebp),%eax
  d9:	0f b6 10             	movzbl (%eax),%edx
  dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  df:	0f b6 00             	movzbl (%eax),%eax
  e2:	38 c2                	cmp    %al,%dl
  e4:	74 de                	je     c4 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	0f b6 00             	movzbl (%eax),%eax
  ec:	0f b6 d0             	movzbl %al,%edx
  ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  f2:	0f b6 00             	movzbl (%eax),%eax
  f5:	0f b6 c0             	movzbl %al,%eax
  f8:	29 c2                	sub    %eax,%edx
  fa:	89 d0                	mov    %edx,%eax
}
  fc:	5d                   	pop    %ebp
  fd:	c3                   	ret    

000000fe <strlen>:

uint
strlen(char *s)
{
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 104:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10b:	eb 04                	jmp    111 <strlen+0x13>
 10d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 111:	8b 55 fc             	mov    -0x4(%ebp),%edx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	01 d0                	add    %edx,%eax
 119:	0f b6 00             	movzbl (%eax),%eax
 11c:	84 c0                	test   %al,%al
 11e:	75 ed                	jne    10d <strlen+0xf>
    ;
  return n;
 120:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 123:	c9                   	leave  
 124:	c3                   	ret    

00000125 <memset>:

void*
memset(void *dst, int c, uint n)
{
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 128:	8b 45 10             	mov    0x10(%ebp),%eax
 12b:	50                   	push   %eax
 12c:	ff 75 0c             	pushl  0xc(%ebp)
 12f:	ff 75 08             	pushl  0x8(%ebp)
 132:	e8 33 ff ff ff       	call   6a <stosb>
 137:	83 c4 0c             	add    $0xc,%esp
  return dst;
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 13d:	c9                   	leave  
 13e:	c3                   	ret    

0000013f <strchr>:

char*
strchr(const char *s, char c)
{
 13f:	55                   	push   %ebp
 140:	89 e5                	mov    %esp,%ebp
 142:	83 ec 04             	sub    $0x4,%esp
 145:	8b 45 0c             	mov    0xc(%ebp),%eax
 148:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 14b:	eb 14                	jmp    161 <strchr+0x22>
    if(*s == c)
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	0f b6 00             	movzbl (%eax),%eax
 153:	3a 45 fc             	cmp    -0x4(%ebp),%al
 156:	75 05                	jne    15d <strchr+0x1e>
      return (char*)s;
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	eb 13                	jmp    170 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 15d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	0f b6 00             	movzbl (%eax),%eax
 167:	84 c0                	test   %al,%al
 169:	75 e2                	jne    14d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 16b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 170:	c9                   	leave  
 171:	c3                   	ret    

00000172 <gets>:

char*
gets(char *buf, int max)
{
 172:	55                   	push   %ebp
 173:	89 e5                	mov    %esp,%ebp
 175:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 178:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17f:	eb 44                	jmp    1c5 <gets+0x53>
    cc = read(0, &c, 1);
 181:	83 ec 04             	sub    $0x4,%esp
 184:	6a 01                	push   $0x1
 186:	8d 45 ef             	lea    -0x11(%ebp),%eax
 189:	50                   	push   %eax
 18a:	6a 00                	push   $0x0
 18c:	e8 46 01 00 00       	call   2d7 <read>
 191:	83 c4 10             	add    $0x10,%esp
 194:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 197:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 19b:	7f 02                	jg     19f <gets+0x2d>
      break;
 19d:	eb 31                	jmp    1d0 <gets+0x5e>
    buf[i++] = c;
 19f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a2:	8d 50 01             	lea    0x1(%eax),%edx
 1a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a8:	89 c2                	mov    %eax,%edx
 1aa:	8b 45 08             	mov    0x8(%ebp),%eax
 1ad:	01 c2                	add    %eax,%edx
 1af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1b5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b9:	3c 0a                	cmp    $0xa,%al
 1bb:	74 13                	je     1d0 <gets+0x5e>
 1bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c1:	3c 0d                	cmp    $0xd,%al
 1c3:	74 0b                	je     1d0 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c8:	83 c0 01             	add    $0x1,%eax
 1cb:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1ce:	7c b1                	jl     181 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 d0                	add    %edx,%eax
 1d8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1db:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1de:	c9                   	leave  
 1df:	c3                   	ret    

000001e0 <stat>:

int
stat(char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e6:	83 ec 08             	sub    $0x8,%esp
 1e9:	6a 00                	push   $0x0
 1eb:	ff 75 08             	pushl  0x8(%ebp)
 1ee:	e8 0c 01 00 00       	call   2ff <open>
 1f3:	83 c4 10             	add    $0x10,%esp
 1f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1fd:	79 07                	jns    206 <stat+0x26>
    return -1;
 1ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 204:	eb 25                	jmp    22b <stat+0x4b>
  r = fstat(fd, st);
 206:	83 ec 08             	sub    $0x8,%esp
 209:	ff 75 0c             	pushl  0xc(%ebp)
 20c:	ff 75 f4             	pushl  -0xc(%ebp)
 20f:	e8 03 01 00 00       	call   317 <fstat>
 214:	83 c4 10             	add    $0x10,%esp
 217:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 21a:	83 ec 0c             	sub    $0xc,%esp
 21d:	ff 75 f4             	pushl  -0xc(%ebp)
 220:	e8 c2 00 00 00       	call   2e7 <close>
 225:	83 c4 10             	add    $0x10,%esp
  return r;
 228:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 22b:	c9                   	leave  
 22c:	c3                   	ret    

0000022d <atoi>:

int
atoi(const char *s)
{
 22d:	55                   	push   %ebp
 22e:	89 e5                	mov    %esp,%ebp
 230:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 233:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 23a:	eb 25                	jmp    261 <atoi+0x34>
    n = n*10 + *s++ - '0';
 23c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 23f:	89 d0                	mov    %edx,%eax
 241:	c1 e0 02             	shl    $0x2,%eax
 244:	01 d0                	add    %edx,%eax
 246:	01 c0                	add    %eax,%eax
 248:	89 c1                	mov    %eax,%ecx
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	8d 50 01             	lea    0x1(%eax),%edx
 250:	89 55 08             	mov    %edx,0x8(%ebp)
 253:	0f b6 00             	movzbl (%eax),%eax
 256:	0f be c0             	movsbl %al,%eax
 259:	01 c8                	add    %ecx,%eax
 25b:	83 e8 30             	sub    $0x30,%eax
 25e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	0f b6 00             	movzbl (%eax),%eax
 267:	3c 2f                	cmp    $0x2f,%al
 269:	7e 0a                	jle    275 <atoi+0x48>
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	3c 39                	cmp    $0x39,%al
 273:	7e c7                	jle    23c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 275:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 278:	c9                   	leave  
 279:	c3                   	ret    

0000027a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 27a:	55                   	push   %ebp
 27b:	89 e5                	mov    %esp,%ebp
 27d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 280:	8b 45 08             	mov    0x8(%ebp),%eax
 283:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 286:	8b 45 0c             	mov    0xc(%ebp),%eax
 289:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 28c:	eb 17                	jmp    2a5 <memmove+0x2b>
    *dst++ = *src++;
 28e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 291:	8d 50 01             	lea    0x1(%eax),%edx
 294:	89 55 fc             	mov    %edx,-0x4(%ebp)
 297:	8b 55 f8             	mov    -0x8(%ebp),%edx
 29a:	8d 4a 01             	lea    0x1(%edx),%ecx
 29d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2a0:	0f b6 12             	movzbl (%edx),%edx
 2a3:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a5:	8b 45 10             	mov    0x10(%ebp),%eax
 2a8:	8d 50 ff             	lea    -0x1(%eax),%edx
 2ab:	89 55 10             	mov    %edx,0x10(%ebp)
 2ae:	85 c0                	test   %eax,%eax
 2b0:	7f dc                	jg     28e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b5:	c9                   	leave  
 2b6:	c3                   	ret    

000002b7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b7:	b8 01 00 00 00       	mov    $0x1,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <exit>:
SYSCALL(exit)
 2bf:	b8 02 00 00 00       	mov    $0x2,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <wait>:
SYSCALL(wait)
 2c7:	b8 03 00 00 00       	mov    $0x3,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <pipe>:
SYSCALL(pipe)
 2cf:	b8 04 00 00 00       	mov    $0x4,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <read>:
SYSCALL(read)
 2d7:	b8 05 00 00 00       	mov    $0x5,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <write>:
SYSCALL(write)
 2df:	b8 10 00 00 00       	mov    $0x10,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <close>:
SYSCALL(close)
 2e7:	b8 15 00 00 00       	mov    $0x15,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <kill>:
SYSCALL(kill)
 2ef:	b8 06 00 00 00       	mov    $0x6,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <exec>:
SYSCALL(exec)
 2f7:	b8 07 00 00 00       	mov    $0x7,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <open>:
SYSCALL(open)
 2ff:	b8 0f 00 00 00       	mov    $0xf,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <mknod>:
SYSCALL(mknod)
 307:	b8 11 00 00 00       	mov    $0x11,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <unlink>:
SYSCALL(unlink)
 30f:	b8 12 00 00 00       	mov    $0x12,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <fstat>:
SYSCALL(fstat)
 317:	b8 08 00 00 00       	mov    $0x8,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <link>:
SYSCALL(link)
 31f:	b8 13 00 00 00       	mov    $0x13,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <mkdir>:
SYSCALL(mkdir)
 327:	b8 14 00 00 00       	mov    $0x14,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <chdir>:
SYSCALL(chdir)
 32f:	b8 09 00 00 00       	mov    $0x9,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <dup>:
SYSCALL(dup)
 337:	b8 0a 00 00 00       	mov    $0xa,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <getpid>:
SYSCALL(getpid)
 33f:	b8 0b 00 00 00       	mov    $0xb,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <sbrk>:
SYSCALL(sbrk)
 347:	b8 0c 00 00 00       	mov    $0xc,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <sleep>:
SYSCALL(sleep)
 34f:	b8 0d 00 00 00       	mov    $0xd,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <uptime>:
SYSCALL(uptime)
 357:	b8 0e 00 00 00       	mov    $0xe,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <pstat>:
SYSCALL(pstat)
 35f:	b8 16 00 00 00       	mov    $0x16,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 367:	55                   	push   %ebp
 368:	89 e5                	mov    %esp,%ebp
 36a:	83 ec 18             	sub    $0x18,%esp
 36d:	8b 45 0c             	mov    0xc(%ebp),%eax
 370:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 373:	83 ec 04             	sub    $0x4,%esp
 376:	6a 01                	push   $0x1
 378:	8d 45 f4             	lea    -0xc(%ebp),%eax
 37b:	50                   	push   %eax
 37c:	ff 75 08             	pushl  0x8(%ebp)
 37f:	e8 5b ff ff ff       	call   2df <write>
 384:	83 c4 10             	add    $0x10,%esp
}
 387:	c9                   	leave  
 388:	c3                   	ret    

00000389 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 389:	55                   	push   %ebp
 38a:	89 e5                	mov    %esp,%ebp
 38c:	53                   	push   %ebx
 38d:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 390:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 397:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 39b:	74 17                	je     3b4 <printint+0x2b>
 39d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3a1:	79 11                	jns    3b4 <printint+0x2b>
    neg = 1;
 3a3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ad:	f7 d8                	neg    %eax
 3af:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b2:	eb 06                	jmp    3ba <printint+0x31>
  } else {
    x = xx;
 3b4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3c1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3c4:	8d 41 01             	lea    0x1(%ecx),%eax
 3c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3ca:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d0:	ba 00 00 00 00       	mov    $0x0,%edx
 3d5:	f7 f3                	div    %ebx
 3d7:	89 d0                	mov    %edx,%eax
 3d9:	0f b6 80 4c 0a 00 00 	movzbl 0xa4c(%eax),%eax
 3e0:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3e4:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ea:	ba 00 00 00 00       	mov    $0x0,%edx
 3ef:	f7 f3                	div    %ebx
 3f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3f8:	75 c7                	jne    3c1 <printint+0x38>
  if(neg)
 3fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3fe:	74 0e                	je     40e <printint+0x85>
    buf[i++] = '-';
 400:	8b 45 f4             	mov    -0xc(%ebp),%eax
 403:	8d 50 01             	lea    0x1(%eax),%edx
 406:	89 55 f4             	mov    %edx,-0xc(%ebp)
 409:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 40e:	eb 1d                	jmp    42d <printint+0xa4>
    putc(fd, buf[i]);
 410:	8d 55 dc             	lea    -0x24(%ebp),%edx
 413:	8b 45 f4             	mov    -0xc(%ebp),%eax
 416:	01 d0                	add    %edx,%eax
 418:	0f b6 00             	movzbl (%eax),%eax
 41b:	0f be c0             	movsbl %al,%eax
 41e:	83 ec 08             	sub    $0x8,%esp
 421:	50                   	push   %eax
 422:	ff 75 08             	pushl  0x8(%ebp)
 425:	e8 3d ff ff ff       	call   367 <putc>
 42a:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 42d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 431:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 435:	79 d9                	jns    410 <printint+0x87>
    putc(fd, buf[i]);
}
 437:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43a:	c9                   	leave  
 43b:	c3                   	ret    

0000043c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 43c:	55                   	push   %ebp
 43d:	89 e5                	mov    %esp,%ebp
 43f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 442:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 449:	8d 45 0c             	lea    0xc(%ebp),%eax
 44c:	83 c0 04             	add    $0x4,%eax
 44f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 452:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 459:	e9 59 01 00 00       	jmp    5b7 <printf+0x17b>
    c = fmt[i] & 0xff;
 45e:	8b 55 0c             	mov    0xc(%ebp),%edx
 461:	8b 45 f0             	mov    -0x10(%ebp),%eax
 464:	01 d0                	add    %edx,%eax
 466:	0f b6 00             	movzbl (%eax),%eax
 469:	0f be c0             	movsbl %al,%eax
 46c:	25 ff 00 00 00       	and    $0xff,%eax
 471:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 474:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 478:	75 2c                	jne    4a6 <printf+0x6a>
      if(c == '%'){
 47a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 47e:	75 0c                	jne    48c <printf+0x50>
        state = '%';
 480:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 487:	e9 27 01 00 00       	jmp    5b3 <printf+0x177>
      } else {
        putc(fd, c);
 48c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 48f:	0f be c0             	movsbl %al,%eax
 492:	83 ec 08             	sub    $0x8,%esp
 495:	50                   	push   %eax
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 c9 fe ff ff       	call   367 <putc>
 49e:	83 c4 10             	add    $0x10,%esp
 4a1:	e9 0d 01 00 00       	jmp    5b3 <printf+0x177>
      }
    } else if(state == '%'){
 4a6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4aa:	0f 85 03 01 00 00    	jne    5b3 <printf+0x177>
      if(c == 'd'){
 4b0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4b4:	75 1e                	jne    4d4 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b9:	8b 00                	mov    (%eax),%eax
 4bb:	6a 01                	push   $0x1
 4bd:	6a 0a                	push   $0xa
 4bf:	50                   	push   %eax
 4c0:	ff 75 08             	pushl  0x8(%ebp)
 4c3:	e8 c1 fe ff ff       	call   389 <printint>
 4c8:	83 c4 10             	add    $0x10,%esp
        ap++;
 4cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4cf:	e9 d8 00 00 00       	jmp    5ac <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4d4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4d8:	74 06                	je     4e0 <printf+0xa4>
 4da:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4de:	75 1e                	jne    4fe <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e3:	8b 00                	mov    (%eax),%eax
 4e5:	6a 00                	push   $0x0
 4e7:	6a 10                	push   $0x10
 4e9:	50                   	push   %eax
 4ea:	ff 75 08             	pushl  0x8(%ebp)
 4ed:	e8 97 fe ff ff       	call   389 <printint>
 4f2:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f9:	e9 ae 00 00 00       	jmp    5ac <printf+0x170>
      } else if(c == 's'){
 4fe:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 502:	75 43                	jne    547 <printf+0x10b>
        s = (char*)*ap;
 504:	8b 45 e8             	mov    -0x18(%ebp),%eax
 507:	8b 00                	mov    (%eax),%eax
 509:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 50c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 510:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 514:	75 07                	jne    51d <printf+0xe1>
          s = "(null)";
 516:	c7 45 f4 f9 07 00 00 	movl   $0x7f9,-0xc(%ebp)
        while(*s != 0){
 51d:	eb 1c                	jmp    53b <printf+0xff>
          putc(fd, *s);
 51f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 522:	0f b6 00             	movzbl (%eax),%eax
 525:	0f be c0             	movsbl %al,%eax
 528:	83 ec 08             	sub    $0x8,%esp
 52b:	50                   	push   %eax
 52c:	ff 75 08             	pushl  0x8(%ebp)
 52f:	e8 33 fe ff ff       	call   367 <putc>
 534:	83 c4 10             	add    $0x10,%esp
          s++;
 537:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53e:	0f b6 00             	movzbl (%eax),%eax
 541:	84 c0                	test   %al,%al
 543:	75 da                	jne    51f <printf+0xe3>
 545:	eb 65                	jmp    5ac <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 547:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54b:	75 1d                	jne    56a <printf+0x12e>
        putc(fd, *ap);
 54d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 550:	8b 00                	mov    (%eax),%eax
 552:	0f be c0             	movsbl %al,%eax
 555:	83 ec 08             	sub    $0x8,%esp
 558:	50                   	push   %eax
 559:	ff 75 08             	pushl  0x8(%ebp)
 55c:	e8 06 fe ff ff       	call   367 <putc>
 561:	83 c4 10             	add    $0x10,%esp
        ap++;
 564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 568:	eb 42                	jmp    5ac <printf+0x170>
      } else if(c == '%'){
 56a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 56e:	75 17                	jne    587 <printf+0x14b>
        putc(fd, c);
 570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 573:	0f be c0             	movsbl %al,%eax
 576:	83 ec 08             	sub    $0x8,%esp
 579:	50                   	push   %eax
 57a:	ff 75 08             	pushl  0x8(%ebp)
 57d:	e8 e5 fd ff ff       	call   367 <putc>
 582:	83 c4 10             	add    $0x10,%esp
 585:	eb 25                	jmp    5ac <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 587:	83 ec 08             	sub    $0x8,%esp
 58a:	6a 25                	push   $0x25
 58c:	ff 75 08             	pushl  0x8(%ebp)
 58f:	e8 d3 fd ff ff       	call   367 <putc>
 594:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 597:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59a:	0f be c0             	movsbl %al,%eax
 59d:	83 ec 08             	sub    $0x8,%esp
 5a0:	50                   	push   %eax
 5a1:	ff 75 08             	pushl  0x8(%ebp)
 5a4:	e8 be fd ff ff       	call   367 <putc>
 5a9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5b7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bd:	01 d0                	add    %edx,%eax
 5bf:	0f b6 00             	movzbl (%eax),%eax
 5c2:	84 c0                	test   %al,%al
 5c4:	0f 85 94 fe ff ff    	jne    45e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5ca:	c9                   	leave  
 5cb:	c3                   	ret    

000005cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5cc:	55                   	push   %ebp
 5cd:	89 e5                	mov    %esp,%ebp
 5cf:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d2:	8b 45 08             	mov    0x8(%ebp),%eax
 5d5:	83 e8 08             	sub    $0x8,%eax
 5d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5db:	a1 68 0a 00 00       	mov    0xa68,%eax
 5e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e3:	eb 24                	jmp    609 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e8:	8b 00                	mov    (%eax),%eax
 5ea:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ed:	77 12                	ja     601 <free+0x35>
 5ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f5:	77 24                	ja     61b <free+0x4f>
 5f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fa:	8b 00                	mov    (%eax),%eax
 5fc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5ff:	77 1a                	ja     61b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	8b 45 fc             	mov    -0x4(%ebp),%eax
 604:	8b 00                	mov    (%eax),%eax
 606:	89 45 fc             	mov    %eax,-0x4(%ebp)
 609:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 60f:	76 d4                	jbe    5e5 <free+0x19>
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 619:	76 ca                	jbe    5e5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 61b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61e:	8b 40 04             	mov    0x4(%eax),%eax
 621:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 628:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62b:	01 c2                	add    %eax,%edx
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 00                	mov    (%eax),%eax
 632:	39 c2                	cmp    %eax,%edx
 634:	75 24                	jne    65a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 636:	8b 45 f8             	mov    -0x8(%ebp),%eax
 639:	8b 50 04             	mov    0x4(%eax),%edx
 63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63f:	8b 00                	mov    (%eax),%eax
 641:	8b 40 04             	mov    0x4(%eax),%eax
 644:	01 c2                	add    %eax,%edx
 646:	8b 45 f8             	mov    -0x8(%ebp),%eax
 649:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64f:	8b 00                	mov    (%eax),%eax
 651:	8b 10                	mov    (%eax),%edx
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	89 10                	mov    %edx,(%eax)
 658:	eb 0a                	jmp    664 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65d:	8b 10                	mov    (%eax),%edx
 65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 662:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 664:	8b 45 fc             	mov    -0x4(%ebp),%eax
 667:	8b 40 04             	mov    0x4(%eax),%eax
 66a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	01 d0                	add    %edx,%eax
 676:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 679:	75 20                	jne    69b <free+0xcf>
    p->s.size += bp->s.size;
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	8b 50 04             	mov    0x4(%eax),%edx
 681:	8b 45 f8             	mov    -0x8(%ebp),%eax
 684:	8b 40 04             	mov    0x4(%eax),%eax
 687:	01 c2                	add    %eax,%edx
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 692:	8b 10                	mov    (%eax),%edx
 694:	8b 45 fc             	mov    -0x4(%ebp),%eax
 697:	89 10                	mov    %edx,(%eax)
 699:	eb 08                	jmp    6a3 <free+0xd7>
  } else
    p->s.ptr = bp;
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6a1:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	a3 68 0a 00 00       	mov    %eax,0xa68
}
 6ab:	c9                   	leave  
 6ac:	c3                   	ret    

000006ad <morecore>:

static Header*
morecore(uint nu)
{
 6ad:	55                   	push   %ebp
 6ae:	89 e5                	mov    %esp,%ebp
 6b0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6b3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ba:	77 07                	ja     6c3 <morecore+0x16>
    nu = 4096;
 6bc:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6c3:	8b 45 08             	mov    0x8(%ebp),%eax
 6c6:	c1 e0 03             	shl    $0x3,%eax
 6c9:	83 ec 0c             	sub    $0xc,%esp
 6cc:	50                   	push   %eax
 6cd:	e8 75 fc ff ff       	call   347 <sbrk>
 6d2:	83 c4 10             	add    $0x10,%esp
 6d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6d8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6dc:	75 07                	jne    6e5 <morecore+0x38>
    return 0;
 6de:	b8 00 00 00 00       	mov    $0x0,%eax
 6e3:	eb 26                	jmp    70b <morecore+0x5e>
  hp = (Header*)p;
 6e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ee:	8b 55 08             	mov    0x8(%ebp),%edx
 6f1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f7:	83 c0 08             	add    $0x8,%eax
 6fa:	83 ec 0c             	sub    $0xc,%esp
 6fd:	50                   	push   %eax
 6fe:	e8 c9 fe ff ff       	call   5cc <free>
 703:	83 c4 10             	add    $0x10,%esp
  return freep;
 706:	a1 68 0a 00 00       	mov    0xa68,%eax
}
 70b:	c9                   	leave  
 70c:	c3                   	ret    

0000070d <malloc>:

void*
malloc(uint nbytes)
{
 70d:	55                   	push   %ebp
 70e:	89 e5                	mov    %esp,%ebp
 710:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 713:	8b 45 08             	mov    0x8(%ebp),%eax
 716:	83 c0 07             	add    $0x7,%eax
 719:	c1 e8 03             	shr    $0x3,%eax
 71c:	83 c0 01             	add    $0x1,%eax
 71f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 722:	a1 68 0a 00 00       	mov    0xa68,%eax
 727:	89 45 f0             	mov    %eax,-0x10(%ebp)
 72a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 72e:	75 23                	jne    753 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 730:	c7 45 f0 60 0a 00 00 	movl   $0xa60,-0x10(%ebp)
 737:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73a:	a3 68 0a 00 00       	mov    %eax,0xa68
 73f:	a1 68 0a 00 00       	mov    0xa68,%eax
 744:	a3 60 0a 00 00       	mov    %eax,0xa60
    base.s.size = 0;
 749:	c7 05 64 0a 00 00 00 	movl   $0x0,0xa64
 750:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 753:	8b 45 f0             	mov    -0x10(%ebp),%eax
 756:	8b 00                	mov    (%eax),%eax
 758:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 75b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75e:	8b 40 04             	mov    0x4(%eax),%eax
 761:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 764:	72 4d                	jb     7b3 <malloc+0xa6>
      if(p->s.size == nunits)
 766:	8b 45 f4             	mov    -0xc(%ebp),%eax
 769:	8b 40 04             	mov    0x4(%eax),%eax
 76c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 76f:	75 0c                	jne    77d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 771:	8b 45 f4             	mov    -0xc(%ebp),%eax
 774:	8b 10                	mov    (%eax),%edx
 776:	8b 45 f0             	mov    -0x10(%ebp),%eax
 779:	89 10                	mov    %edx,(%eax)
 77b:	eb 26                	jmp    7a3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	8b 40 04             	mov    0x4(%eax),%eax
 783:	2b 45 ec             	sub    -0x14(%ebp),%eax
 786:	89 c2                	mov    %eax,%edx
 788:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 78e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 791:	8b 40 04             	mov    0x4(%eax),%eax
 794:	c1 e0 03             	shl    $0x3,%eax
 797:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7a0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a6:	a3 68 0a 00 00       	mov    %eax,0xa68
      return (void*)(p + 1);
 7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ae:	83 c0 08             	add    $0x8,%eax
 7b1:	eb 3b                	jmp    7ee <malloc+0xe1>
    }
    if(p == freep)
 7b3:	a1 68 0a 00 00       	mov    0xa68,%eax
 7b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7bb:	75 1e                	jne    7db <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7bd:	83 ec 0c             	sub    $0xc,%esp
 7c0:	ff 75 ec             	pushl  -0x14(%ebp)
 7c3:	e8 e5 fe ff ff       	call   6ad <morecore>
 7c8:	83 c4 10             	add    $0x10,%esp
 7cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d2:	75 07                	jne    7db <malloc+0xce>
        return 0;
 7d4:	b8 00 00 00 00       	mov    $0x0,%eax
 7d9:	eb 13                	jmp    7ee <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e4:	8b 00                	mov    (%eax),%eax
 7e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7e9:	e9 6d ff ff ff       	jmp    75b <malloc+0x4e>
}
 7ee:	c9                   	leave  
 7ef:	c3                   	ret    
