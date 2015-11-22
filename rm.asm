
_rm:     file format elf32-i386


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

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 1c                	jg     35 <main+0x35>
    printf(2, "Usage: rm files...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 20 08 00 00       	push   $0x820
  21:	6a 02                	push   $0x2
  23:	e8 44 04 00 00       	call   46c <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
  2b:	83 ec 0c             	sub    $0xc,%esp
  2e:	6a 01                	push   $0x1
  30:	e8 ba 02 00 00       	call   2ef <exit>
  }

  for(i = 1; i < argc; i++){
  35:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  3c:	eb 4b                	jmp    89 <main+0x89>
    if(unlink(argv[i]) < 0){
  3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  41:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  48:	8b 43 04             	mov    0x4(%ebx),%eax
  4b:	01 d0                	add    %edx,%eax
  4d:	8b 00                	mov    (%eax),%eax
  4f:	83 ec 0c             	sub    $0xc,%esp
  52:	50                   	push   %eax
  53:	e8 e7 02 00 00       	call   33f <unlink>
  58:	83 c4 10             	add    $0x10,%esp
  5b:	85 c0                	test   %eax,%eax
  5d:	79 26                	jns    85 <main+0x85>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  62:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  69:	8b 43 04             	mov    0x4(%ebx),%eax
  6c:	01 d0                	add    %edx,%eax
  6e:	8b 00                	mov    (%eax),%eax
  70:	83 ec 04             	sub    $0x4,%esp
  73:	50                   	push   %eax
  74:	68 34 08 00 00       	push   $0x834
  79:	6a 02                	push   $0x2
  7b:	e8 ec 03 00 00       	call   46c <printf>
  80:	83 c4 10             	add    $0x10,%esp
      break;
  83:	eb 0b                	jmp    90 <main+0x90>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit(EXIT_STATUS_OK);
  }

  for(i = 1; i < argc; i++){
  85:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  89:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8c:	3b 03                	cmp    (%ebx),%eax
  8e:	7c ae                	jl     3e <main+0x3e>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit(EXIT_STATUS_OK);
  90:	83 ec 0c             	sub    $0xc,%esp
  93:	6a 01                	push   $0x1
  95:	e8 55 02 00 00       	call   2ef <exit>

0000009a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  9a:	55                   	push   %ebp
  9b:	89 e5                	mov    %esp,%ebp
  9d:	57                   	push   %edi
  9e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  9f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a2:	8b 55 10             	mov    0x10(%ebp),%edx
  a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  a8:	89 cb                	mov    %ecx,%ebx
  aa:	89 df                	mov    %ebx,%edi
  ac:	89 d1                	mov    %edx,%ecx
  ae:	fc                   	cld    
  af:	f3 aa                	rep stos %al,%es:(%edi)
  b1:	89 ca                	mov    %ecx,%edx
  b3:	89 fb                	mov    %edi,%ebx
  b5:	89 5d 08             	mov    %ebx,0x8(%ebp)
  b8:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  bb:	5b                   	pop    %ebx
  bc:	5f                   	pop    %edi
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret    

000000bf <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  bf:	55                   	push   %ebp
  c0:	89 e5                	mov    %esp,%ebp
  c2:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  c5:	8b 45 08             	mov    0x8(%ebp),%eax
  c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  cb:	90                   	nop
  cc:	8b 45 08             	mov    0x8(%ebp),%eax
  cf:	8d 50 01             	lea    0x1(%eax),%edx
  d2:	89 55 08             	mov    %edx,0x8(%ebp)
  d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  d8:	8d 4a 01             	lea    0x1(%edx),%ecx
  db:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  de:	0f b6 12             	movzbl (%edx),%edx
  e1:	88 10                	mov    %dl,(%eax)
  e3:	0f b6 00             	movzbl (%eax),%eax
  e6:	84 c0                	test   %al,%al
  e8:	75 e2                	jne    cc <strcpy+0xd>
    ;
  return os;
  ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ed:	c9                   	leave  
  ee:	c3                   	ret    

000000ef <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ef:	55                   	push   %ebp
  f0:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  f2:	eb 08                	jmp    fc <strcmp+0xd>
    p++, q++;
  f4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  f8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 00             	movzbl (%eax),%eax
 102:	84 c0                	test   %al,%al
 104:	74 10                	je     116 <strcmp+0x27>
 106:	8b 45 08             	mov    0x8(%ebp),%eax
 109:	0f b6 10             	movzbl (%eax),%edx
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	0f b6 00             	movzbl (%eax),%eax
 112:	38 c2                	cmp    %al,%dl
 114:	74 de                	je     f4 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 116:	8b 45 08             	mov    0x8(%ebp),%eax
 119:	0f b6 00             	movzbl (%eax),%eax
 11c:	0f b6 d0             	movzbl %al,%edx
 11f:	8b 45 0c             	mov    0xc(%ebp),%eax
 122:	0f b6 00             	movzbl (%eax),%eax
 125:	0f b6 c0             	movzbl %al,%eax
 128:	29 c2                	sub    %eax,%edx
 12a:	89 d0                	mov    %edx,%eax
}
 12c:	5d                   	pop    %ebp
 12d:	c3                   	ret    

0000012e <strlen>:

uint
strlen(char *s)
{
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
 131:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 134:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 13b:	eb 04                	jmp    141 <strlen+0x13>
 13d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 141:	8b 55 fc             	mov    -0x4(%ebp),%edx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	01 d0                	add    %edx,%eax
 149:	0f b6 00             	movzbl (%eax),%eax
 14c:	84 c0                	test   %al,%al
 14e:	75 ed                	jne    13d <strlen+0xf>
    ;
  return n;
 150:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 153:	c9                   	leave  
 154:	c3                   	ret    

00000155 <memset>:

void*
memset(void *dst, int c, uint n)
{
 155:	55                   	push   %ebp
 156:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 158:	8b 45 10             	mov    0x10(%ebp),%eax
 15b:	50                   	push   %eax
 15c:	ff 75 0c             	pushl  0xc(%ebp)
 15f:	ff 75 08             	pushl  0x8(%ebp)
 162:	e8 33 ff ff ff       	call   9a <stosb>
 167:	83 c4 0c             	add    $0xc,%esp
  return dst;
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 16d:	c9                   	leave  
 16e:	c3                   	ret    

0000016f <strchr>:

char*
strchr(const char *s, char c)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	83 ec 04             	sub    $0x4,%esp
 175:	8b 45 0c             	mov    0xc(%ebp),%eax
 178:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 17b:	eb 14                	jmp    191 <strchr+0x22>
    if(*s == c)
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	0f b6 00             	movzbl (%eax),%eax
 183:	3a 45 fc             	cmp    -0x4(%ebp),%al
 186:	75 05                	jne    18d <strchr+0x1e>
      return (char*)s;
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	eb 13                	jmp    1a0 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 18d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 191:	8b 45 08             	mov    0x8(%ebp),%eax
 194:	0f b6 00             	movzbl (%eax),%eax
 197:	84 c0                	test   %al,%al
 199:	75 e2                	jne    17d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 19b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1a0:	c9                   	leave  
 1a1:	c3                   	ret    

000001a2 <gets>:

char*
gets(char *buf, int max)
{
 1a2:	55                   	push   %ebp
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1af:	eb 44                	jmp    1f5 <gets+0x53>
    cc = read(0, &c, 1);
 1b1:	83 ec 04             	sub    $0x4,%esp
 1b4:	6a 01                	push   $0x1
 1b6:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b9:	50                   	push   %eax
 1ba:	6a 00                	push   $0x0
 1bc:	e8 46 01 00 00       	call   307 <read>
 1c1:	83 c4 10             	add    $0x10,%esp
 1c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1cb:	7f 02                	jg     1cf <gets+0x2d>
      break;
 1cd:	eb 31                	jmp    200 <gets+0x5e>
    buf[i++] = c;
 1cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d2:	8d 50 01             	lea    0x1(%eax),%edx
 1d5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1d8:	89 c2                	mov    %eax,%edx
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	01 c2                	add    %eax,%edx
 1df:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1e5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e9:	3c 0a                	cmp    $0xa,%al
 1eb:	74 13                	je     200 <gets+0x5e>
 1ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f1:	3c 0d                	cmp    $0xd,%al
 1f3:	74 0b                	je     200 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f8:	83 c0 01             	add    $0x1,%eax
 1fb:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1fe:	7c b1                	jl     1b1 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 200:	8b 55 f4             	mov    -0xc(%ebp),%edx
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	01 d0                	add    %edx,%eax
 208:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 20e:	c9                   	leave  
 20f:	c3                   	ret    

00000210 <stat>:

int
stat(char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 216:	83 ec 08             	sub    $0x8,%esp
 219:	6a 00                	push   $0x0
 21b:	ff 75 08             	pushl  0x8(%ebp)
 21e:	e8 0c 01 00 00       	call   32f <open>
 223:	83 c4 10             	add    $0x10,%esp
 226:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 229:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 22d:	79 07                	jns    236 <stat+0x26>
    return -1;
 22f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 234:	eb 25                	jmp    25b <stat+0x4b>
  r = fstat(fd, st);
 236:	83 ec 08             	sub    $0x8,%esp
 239:	ff 75 0c             	pushl  0xc(%ebp)
 23c:	ff 75 f4             	pushl  -0xc(%ebp)
 23f:	e8 03 01 00 00       	call   347 <fstat>
 244:	83 c4 10             	add    $0x10,%esp
 247:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 24a:	83 ec 0c             	sub    $0xc,%esp
 24d:	ff 75 f4             	pushl  -0xc(%ebp)
 250:	e8 c2 00 00 00       	call   317 <close>
 255:	83 c4 10             	add    $0x10,%esp
  return r;
 258:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 25b:	c9                   	leave  
 25c:	c3                   	ret    

0000025d <atoi>:

int
atoi(const char *s)
{
 25d:	55                   	push   %ebp
 25e:	89 e5                	mov    %esp,%ebp
 260:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 263:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 26a:	eb 25                	jmp    291 <atoi+0x34>
    n = n*10 + *s++ - '0';
 26c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 26f:	89 d0                	mov    %edx,%eax
 271:	c1 e0 02             	shl    $0x2,%eax
 274:	01 d0                	add    %edx,%eax
 276:	01 c0                	add    %eax,%eax
 278:	89 c1                	mov    %eax,%ecx
 27a:	8b 45 08             	mov    0x8(%ebp),%eax
 27d:	8d 50 01             	lea    0x1(%eax),%edx
 280:	89 55 08             	mov    %edx,0x8(%ebp)
 283:	0f b6 00             	movzbl (%eax),%eax
 286:	0f be c0             	movsbl %al,%eax
 289:	01 c8                	add    %ecx,%eax
 28b:	83 e8 30             	sub    $0x30,%eax
 28e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	0f b6 00             	movzbl (%eax),%eax
 297:	3c 2f                	cmp    $0x2f,%al
 299:	7e 0a                	jle    2a5 <atoi+0x48>
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	0f b6 00             	movzbl (%eax),%eax
 2a1:	3c 39                	cmp    $0x39,%al
 2a3:	7e c7                	jle    26c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a8:	c9                   	leave  
 2a9:	c3                   	ret    

000002aa <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2aa:	55                   	push   %ebp
 2ab:	89 e5                	mov    %esp,%ebp
 2ad:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
 2b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2b6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2bc:	eb 17                	jmp    2d5 <memmove+0x2b>
    *dst++ = *src++;
 2be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c1:	8d 50 01             	lea    0x1(%eax),%edx
 2c4:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2c7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2ca:	8d 4a 01             	lea    0x1(%edx),%ecx
 2cd:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2d0:	0f b6 12             	movzbl (%edx),%edx
 2d3:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2d5:	8b 45 10             	mov    0x10(%ebp),%eax
 2d8:	8d 50 ff             	lea    -0x1(%eax),%edx
 2db:	89 55 10             	mov    %edx,0x10(%ebp)
 2de:	85 c0                	test   %eax,%eax
 2e0:	7f dc                	jg     2be <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2e2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2e5:	c9                   	leave  
 2e6:	c3                   	ret    

000002e7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2e7:	b8 01 00 00 00       	mov    $0x1,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <exit>:
SYSCALL(exit)
 2ef:	b8 02 00 00 00       	mov    $0x2,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <wait>:
SYSCALL(wait)
 2f7:	b8 03 00 00 00       	mov    $0x3,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <pipe>:
SYSCALL(pipe)
 2ff:	b8 04 00 00 00       	mov    $0x4,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <read>:
SYSCALL(read)
 307:	b8 05 00 00 00       	mov    $0x5,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <write>:
SYSCALL(write)
 30f:	b8 10 00 00 00       	mov    $0x10,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <close>:
SYSCALL(close)
 317:	b8 15 00 00 00       	mov    $0x15,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <kill>:
SYSCALL(kill)
 31f:	b8 06 00 00 00       	mov    $0x6,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <exec>:
SYSCALL(exec)
 327:	b8 07 00 00 00       	mov    $0x7,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <open>:
SYSCALL(open)
 32f:	b8 0f 00 00 00       	mov    $0xf,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <mknod>:
SYSCALL(mknod)
 337:	b8 11 00 00 00       	mov    $0x11,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <unlink>:
SYSCALL(unlink)
 33f:	b8 12 00 00 00       	mov    $0x12,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <fstat>:
SYSCALL(fstat)
 347:	b8 08 00 00 00       	mov    $0x8,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <link>:
SYSCALL(link)
 34f:	b8 13 00 00 00       	mov    $0x13,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <mkdir>:
SYSCALL(mkdir)
 357:	b8 14 00 00 00       	mov    $0x14,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <chdir>:
SYSCALL(chdir)
 35f:	b8 09 00 00 00       	mov    $0x9,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <dup>:
SYSCALL(dup)
 367:	b8 0a 00 00 00       	mov    $0xa,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <getpid>:
SYSCALL(getpid)
 36f:	b8 0b 00 00 00       	mov    $0xb,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <sbrk>:
SYSCALL(sbrk)
 377:	b8 0c 00 00 00       	mov    $0xc,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <sleep>:
SYSCALL(sleep)
 37f:	b8 0d 00 00 00       	mov    $0xd,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <uptime>:
SYSCALL(uptime)
 387:	b8 0e 00 00 00       	mov    $0xe,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <pstat>:
SYSCALL(pstat)
 38f:	b8 16 00 00 00       	mov    $0x16,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 397:	55                   	push   %ebp
 398:	89 e5                	mov    %esp,%ebp
 39a:	83 ec 18             	sub    $0x18,%esp
 39d:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3a3:	83 ec 04             	sub    $0x4,%esp
 3a6:	6a 01                	push   $0x1
 3a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ab:	50                   	push   %eax
 3ac:	ff 75 08             	pushl  0x8(%ebp)
 3af:	e8 5b ff ff ff       	call   30f <write>
 3b4:	83 c4 10             	add    $0x10,%esp
}
 3b7:	c9                   	leave  
 3b8:	c3                   	ret    

000003b9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b9:	55                   	push   %ebp
 3ba:	89 e5                	mov    %esp,%ebp
 3bc:	53                   	push   %ebx
 3bd:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3c7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3cb:	74 17                	je     3e4 <printint+0x2b>
 3cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3d1:	79 11                	jns    3e4 <printint+0x2b>
    neg = 1;
 3d3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	f7 d8                	neg    %eax
 3df:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e2:	eb 06                	jmp    3ea <printint+0x31>
  } else {
    x = xx;
 3e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3f1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3f4:	8d 41 01             	lea    0x1(%ecx),%eax
 3f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3fa:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 400:	ba 00 00 00 00       	mov    $0x0,%edx
 405:	f7 f3                	div    %ebx
 407:	89 d0                	mov    %edx,%eax
 409:	0f b6 80 a0 0a 00 00 	movzbl 0xaa0(%eax),%eax
 410:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 414:	8b 5d 10             	mov    0x10(%ebp),%ebx
 417:	8b 45 ec             	mov    -0x14(%ebp),%eax
 41a:	ba 00 00 00 00       	mov    $0x0,%edx
 41f:	f7 f3                	div    %ebx
 421:	89 45 ec             	mov    %eax,-0x14(%ebp)
 424:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 428:	75 c7                	jne    3f1 <printint+0x38>
  if(neg)
 42a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 42e:	74 0e                	je     43e <printint+0x85>
    buf[i++] = '-';
 430:	8b 45 f4             	mov    -0xc(%ebp),%eax
 433:	8d 50 01             	lea    0x1(%eax),%edx
 436:	89 55 f4             	mov    %edx,-0xc(%ebp)
 439:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 43e:	eb 1d                	jmp    45d <printint+0xa4>
    putc(fd, buf[i]);
 440:	8d 55 dc             	lea    -0x24(%ebp),%edx
 443:	8b 45 f4             	mov    -0xc(%ebp),%eax
 446:	01 d0                	add    %edx,%eax
 448:	0f b6 00             	movzbl (%eax),%eax
 44b:	0f be c0             	movsbl %al,%eax
 44e:	83 ec 08             	sub    $0x8,%esp
 451:	50                   	push   %eax
 452:	ff 75 08             	pushl  0x8(%ebp)
 455:	e8 3d ff ff ff       	call   397 <putc>
 45a:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 45d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 461:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 465:	79 d9                	jns    440 <printint+0x87>
    putc(fd, buf[i]);
}
 467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 46a:	c9                   	leave  
 46b:	c3                   	ret    

0000046c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 46c:	55                   	push   %ebp
 46d:	89 e5                	mov    %esp,%ebp
 46f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 472:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 479:	8d 45 0c             	lea    0xc(%ebp),%eax
 47c:	83 c0 04             	add    $0x4,%eax
 47f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 482:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 489:	e9 59 01 00 00       	jmp    5e7 <printf+0x17b>
    c = fmt[i] & 0xff;
 48e:	8b 55 0c             	mov    0xc(%ebp),%edx
 491:	8b 45 f0             	mov    -0x10(%ebp),%eax
 494:	01 d0                	add    %edx,%eax
 496:	0f b6 00             	movzbl (%eax),%eax
 499:	0f be c0             	movsbl %al,%eax
 49c:	25 ff 00 00 00       	and    $0xff,%eax
 4a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4a4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a8:	75 2c                	jne    4d6 <printf+0x6a>
      if(c == '%'){
 4aa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ae:	75 0c                	jne    4bc <printf+0x50>
        state = '%';
 4b0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b7:	e9 27 01 00 00       	jmp    5e3 <printf+0x177>
      } else {
        putc(fd, c);
 4bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4bf:	0f be c0             	movsbl %al,%eax
 4c2:	83 ec 08             	sub    $0x8,%esp
 4c5:	50                   	push   %eax
 4c6:	ff 75 08             	pushl  0x8(%ebp)
 4c9:	e8 c9 fe ff ff       	call   397 <putc>
 4ce:	83 c4 10             	add    $0x10,%esp
 4d1:	e9 0d 01 00 00       	jmp    5e3 <printf+0x177>
      }
    } else if(state == '%'){
 4d6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4da:	0f 85 03 01 00 00    	jne    5e3 <printf+0x177>
      if(c == 'd'){
 4e0:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e4:	75 1e                	jne    504 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e9:	8b 00                	mov    (%eax),%eax
 4eb:	6a 01                	push   $0x1
 4ed:	6a 0a                	push   $0xa
 4ef:	50                   	push   %eax
 4f0:	ff 75 08             	pushl  0x8(%ebp)
 4f3:	e8 c1 fe ff ff       	call   3b9 <printint>
 4f8:	83 c4 10             	add    $0x10,%esp
        ap++;
 4fb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ff:	e9 d8 00 00 00       	jmp    5dc <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 504:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 508:	74 06                	je     510 <printf+0xa4>
 50a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 50e:	75 1e                	jne    52e <printf+0xc2>
        printint(fd, *ap, 16, 0);
 510:	8b 45 e8             	mov    -0x18(%ebp),%eax
 513:	8b 00                	mov    (%eax),%eax
 515:	6a 00                	push   $0x0
 517:	6a 10                	push   $0x10
 519:	50                   	push   %eax
 51a:	ff 75 08             	pushl  0x8(%ebp)
 51d:	e8 97 fe ff ff       	call   3b9 <printint>
 522:	83 c4 10             	add    $0x10,%esp
        ap++;
 525:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 529:	e9 ae 00 00 00       	jmp    5dc <printf+0x170>
      } else if(c == 's'){
 52e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 532:	75 43                	jne    577 <printf+0x10b>
        s = (char*)*ap;
 534:	8b 45 e8             	mov    -0x18(%ebp),%eax
 537:	8b 00                	mov    (%eax),%eax
 539:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 53c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 540:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 544:	75 07                	jne    54d <printf+0xe1>
          s = "(null)";
 546:	c7 45 f4 4d 08 00 00 	movl   $0x84d,-0xc(%ebp)
        while(*s != 0){
 54d:	eb 1c                	jmp    56b <printf+0xff>
          putc(fd, *s);
 54f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 552:	0f b6 00             	movzbl (%eax),%eax
 555:	0f be c0             	movsbl %al,%eax
 558:	83 ec 08             	sub    $0x8,%esp
 55b:	50                   	push   %eax
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 33 fe ff ff       	call   397 <putc>
 564:	83 c4 10             	add    $0x10,%esp
          s++;
 567:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 56b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56e:	0f b6 00             	movzbl (%eax),%eax
 571:	84 c0                	test   %al,%al
 573:	75 da                	jne    54f <printf+0xe3>
 575:	eb 65                	jmp    5dc <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 577:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 57b:	75 1d                	jne    59a <printf+0x12e>
        putc(fd, *ap);
 57d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 580:	8b 00                	mov    (%eax),%eax
 582:	0f be c0             	movsbl %al,%eax
 585:	83 ec 08             	sub    $0x8,%esp
 588:	50                   	push   %eax
 589:	ff 75 08             	pushl  0x8(%ebp)
 58c:	e8 06 fe ff ff       	call   397 <putc>
 591:	83 c4 10             	add    $0x10,%esp
        ap++;
 594:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 598:	eb 42                	jmp    5dc <printf+0x170>
      } else if(c == '%'){
 59a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 59e:	75 17                	jne    5b7 <printf+0x14b>
        putc(fd, c);
 5a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a3:	0f be c0             	movsbl %al,%eax
 5a6:	83 ec 08             	sub    $0x8,%esp
 5a9:	50                   	push   %eax
 5aa:	ff 75 08             	pushl  0x8(%ebp)
 5ad:	e8 e5 fd ff ff       	call   397 <putc>
 5b2:	83 c4 10             	add    $0x10,%esp
 5b5:	eb 25                	jmp    5dc <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b7:	83 ec 08             	sub    $0x8,%esp
 5ba:	6a 25                	push   $0x25
 5bc:	ff 75 08             	pushl  0x8(%ebp)
 5bf:	e8 d3 fd ff ff       	call   397 <putc>
 5c4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ca:	0f be c0             	movsbl %al,%eax
 5cd:	83 ec 08             	sub    $0x8,%esp
 5d0:	50                   	push   %eax
 5d1:	ff 75 08             	pushl  0x8(%ebp)
 5d4:	e8 be fd ff ff       	call   397 <putc>
 5d9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e7:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ed:	01 d0                	add    %edx,%eax
 5ef:	0f b6 00             	movzbl (%eax),%eax
 5f2:	84 c0                	test   %al,%al
 5f4:	0f 85 94 fe ff ff    	jne    48e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5fa:	c9                   	leave  
 5fb:	c3                   	ret    

000005fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5fc:	55                   	push   %ebp
 5fd:	89 e5                	mov    %esp,%ebp
 5ff:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 602:	8b 45 08             	mov    0x8(%ebp),%eax
 605:	83 e8 08             	sub    $0x8,%eax
 608:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60b:	a1 bc 0a 00 00       	mov    0xabc,%eax
 610:	89 45 fc             	mov    %eax,-0x4(%ebp)
 613:	eb 24                	jmp    639 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 615:	8b 45 fc             	mov    -0x4(%ebp),%eax
 618:	8b 00                	mov    (%eax),%eax
 61a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61d:	77 12                	ja     631 <free+0x35>
 61f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 622:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 625:	77 24                	ja     64b <free+0x4f>
 627:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62a:	8b 00                	mov    (%eax),%eax
 62c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62f:	77 1a                	ja     64b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	8b 00                	mov    (%eax),%eax
 636:	89 45 fc             	mov    %eax,-0x4(%ebp)
 639:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63f:	76 d4                	jbe    615 <free+0x19>
 641:	8b 45 fc             	mov    -0x4(%ebp),%eax
 644:	8b 00                	mov    (%eax),%eax
 646:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 649:	76 ca                	jbe    615 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 64b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64e:	8b 40 04             	mov    0x4(%eax),%eax
 651:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 658:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65b:	01 c2                	add    %eax,%edx
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 00                	mov    (%eax),%eax
 662:	39 c2                	cmp    %eax,%edx
 664:	75 24                	jne    68a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 666:	8b 45 f8             	mov    -0x8(%ebp),%eax
 669:	8b 50 04             	mov    0x4(%eax),%edx
 66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66f:	8b 00                	mov    (%eax),%eax
 671:	8b 40 04             	mov    0x4(%eax),%eax
 674:	01 c2                	add    %eax,%edx
 676:	8b 45 f8             	mov    -0x8(%ebp),%eax
 679:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67f:	8b 00                	mov    (%eax),%eax
 681:	8b 10                	mov    (%eax),%edx
 683:	8b 45 f8             	mov    -0x8(%ebp),%eax
 686:	89 10                	mov    %edx,(%eax)
 688:	eb 0a                	jmp    694 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 68a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68d:	8b 10                	mov    (%eax),%edx
 68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 692:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 694:	8b 45 fc             	mov    -0x4(%ebp),%eax
 697:	8b 40 04             	mov    0x4(%eax),%eax
 69a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	01 d0                	add    %edx,%eax
 6a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a9:	75 20                	jne    6cb <free+0xcf>
    p->s.size += bp->s.size;
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 50 04             	mov    0x4(%eax),%edx
 6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b4:	8b 40 04             	mov    0x4(%eax),%eax
 6b7:	01 c2                	add    %eax,%edx
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c2:	8b 10                	mov    (%eax),%edx
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	89 10                	mov    %edx,(%eax)
 6c9:	eb 08                	jmp    6d3 <free+0xd7>
  } else
    p->s.ptr = bp;
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d1:	89 10                	mov    %edx,(%eax)
  freep = p;
 6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d6:	a3 bc 0a 00 00       	mov    %eax,0xabc
}
 6db:	c9                   	leave  
 6dc:	c3                   	ret    

000006dd <morecore>:

static Header*
morecore(uint nu)
{
 6dd:	55                   	push   %ebp
 6de:	89 e5                	mov    %esp,%ebp
 6e0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6e3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ea:	77 07                	ja     6f3 <morecore+0x16>
    nu = 4096;
 6ec:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6f3:	8b 45 08             	mov    0x8(%ebp),%eax
 6f6:	c1 e0 03             	shl    $0x3,%eax
 6f9:	83 ec 0c             	sub    $0xc,%esp
 6fc:	50                   	push   %eax
 6fd:	e8 75 fc ff ff       	call   377 <sbrk>
 702:	83 c4 10             	add    $0x10,%esp
 705:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 708:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 70c:	75 07                	jne    715 <morecore+0x38>
    return 0;
 70e:	b8 00 00 00 00       	mov    $0x0,%eax
 713:	eb 26                	jmp    73b <morecore+0x5e>
  hp = (Header*)p;
 715:	8b 45 f4             	mov    -0xc(%ebp),%eax
 718:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 71b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71e:	8b 55 08             	mov    0x8(%ebp),%edx
 721:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 724:	8b 45 f0             	mov    -0x10(%ebp),%eax
 727:	83 c0 08             	add    $0x8,%eax
 72a:	83 ec 0c             	sub    $0xc,%esp
 72d:	50                   	push   %eax
 72e:	e8 c9 fe ff ff       	call   5fc <free>
 733:	83 c4 10             	add    $0x10,%esp
  return freep;
 736:	a1 bc 0a 00 00       	mov    0xabc,%eax
}
 73b:	c9                   	leave  
 73c:	c3                   	ret    

0000073d <malloc>:

void*
malloc(uint nbytes)
{
 73d:	55                   	push   %ebp
 73e:	89 e5                	mov    %esp,%ebp
 740:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 743:	8b 45 08             	mov    0x8(%ebp),%eax
 746:	83 c0 07             	add    $0x7,%eax
 749:	c1 e8 03             	shr    $0x3,%eax
 74c:	83 c0 01             	add    $0x1,%eax
 74f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 752:	a1 bc 0a 00 00       	mov    0xabc,%eax
 757:	89 45 f0             	mov    %eax,-0x10(%ebp)
 75a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 75e:	75 23                	jne    783 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 760:	c7 45 f0 b4 0a 00 00 	movl   $0xab4,-0x10(%ebp)
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	a3 bc 0a 00 00       	mov    %eax,0xabc
 76f:	a1 bc 0a 00 00       	mov    0xabc,%eax
 774:	a3 b4 0a 00 00       	mov    %eax,0xab4
    base.s.size = 0;
 779:	c7 05 b8 0a 00 00 00 	movl   $0x0,0xab8
 780:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 783:	8b 45 f0             	mov    -0x10(%ebp),%eax
 786:	8b 00                	mov    (%eax),%eax
 788:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	8b 40 04             	mov    0x4(%eax),%eax
 791:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 794:	72 4d                	jb     7e3 <malloc+0xa6>
      if(p->s.size == nunits)
 796:	8b 45 f4             	mov    -0xc(%ebp),%eax
 799:	8b 40 04             	mov    0x4(%eax),%eax
 79c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 79f:	75 0c                	jne    7ad <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a4:	8b 10                	mov    (%eax),%edx
 7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a9:	89 10                	mov    %edx,(%eax)
 7ab:	eb 26                	jmp    7d3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	8b 40 04             	mov    0x4(%eax),%eax
 7b3:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b6:	89 c2                	mov    %eax,%edx
 7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c1:	8b 40 04             	mov    0x4(%eax),%eax
 7c4:	c1 e0 03             	shl    $0x3,%eax
 7c7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cd:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7d0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d6:	a3 bc 0a 00 00       	mov    %eax,0xabc
      return (void*)(p + 1);
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	83 c0 08             	add    $0x8,%eax
 7e1:	eb 3b                	jmp    81e <malloc+0xe1>
    }
    if(p == freep)
 7e3:	a1 bc 0a 00 00       	mov    0xabc,%eax
 7e8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7eb:	75 1e                	jne    80b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7ed:	83 ec 0c             	sub    $0xc,%esp
 7f0:	ff 75 ec             	pushl  -0x14(%ebp)
 7f3:	e8 e5 fe ff ff       	call   6dd <morecore>
 7f8:	83 c4 10             	add    $0x10,%esp
 7fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 802:	75 07                	jne    80b <malloc+0xce>
        return 0;
 804:	b8 00 00 00 00       	mov    $0x0,%eax
 809:	eb 13                	jmp    81e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	8b 00                	mov    (%eax),%eax
 816:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 819:	e9 6d ff ff ff       	jmp    78b <malloc+0x4e>
}
 81e:	c9                   	leave  
 81f:	c3                   	ret    
