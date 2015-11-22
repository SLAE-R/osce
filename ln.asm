
_ln:     file format elf32-i386


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
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 1c                	je     32 <main+0x32>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 04 08 00 00       	push   $0x804
  1e:	6a 02                	push   $0x2
  20:	e8 2b 04 00 00       	call   450 <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	6a 01                	push   $0x1
  2d:	e8 a1 02 00 00       	call   2d3 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  32:	8b 43 04             	mov    0x4(%ebx),%eax
  35:	83 c0 08             	add    $0x8,%eax
  38:	8b 10                	mov    (%eax),%edx
  3a:	8b 43 04             	mov    0x4(%ebx),%eax
  3d:	83 c0 04             	add    $0x4,%eax
  40:	8b 00                	mov    (%eax),%eax
  42:	83 ec 08             	sub    $0x8,%esp
  45:	52                   	push   %edx
  46:	50                   	push   %eax
  47:	e8 e7 02 00 00       	call   333 <link>
  4c:	83 c4 10             	add    $0x10,%esp
  4f:	85 c0                	test   %eax,%eax
  51:	79 21                	jns    74 <main+0x74>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  53:	8b 43 04             	mov    0x4(%ebx),%eax
  56:	83 c0 08             	add    $0x8,%eax
  59:	8b 10                	mov    (%eax),%edx
  5b:	8b 43 04             	mov    0x4(%ebx),%eax
  5e:	83 c0 04             	add    $0x4,%eax
  61:	8b 00                	mov    (%eax),%eax
  63:	52                   	push   %edx
  64:	50                   	push   %eax
  65:	68 17 08 00 00       	push   $0x817
  6a:	6a 02                	push   $0x2
  6c:	e8 df 03 00 00       	call   450 <printf>
  71:	83 c4 10             	add    $0x10,%esp
  exit(EXIT_STATUS_OK);
  74:	83 ec 0c             	sub    $0xc,%esp
  77:	6a 01                	push   $0x1
  79:	e8 55 02 00 00       	call   2d3 <exit>

0000007e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  7e:	55                   	push   %ebp
  7f:	89 e5                	mov    %esp,%ebp
  81:	57                   	push   %edi
  82:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  86:	8b 55 10             	mov    0x10(%ebp),%edx
  89:	8b 45 0c             	mov    0xc(%ebp),%eax
  8c:	89 cb                	mov    %ecx,%ebx
  8e:	89 df                	mov    %ebx,%edi
  90:	89 d1                	mov    %edx,%ecx
  92:	fc                   	cld    
  93:	f3 aa                	rep stos %al,%es:(%edi)
  95:	89 ca                	mov    %ecx,%edx
  97:	89 fb                	mov    %edi,%ebx
  99:	89 5d 08             	mov    %ebx,0x8(%ebp)
  9c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9f:	5b                   	pop    %ebx
  a0:	5f                   	pop    %edi
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    

000000a3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a3:	55                   	push   %ebp
  a4:	89 e5                	mov    %esp,%ebp
  a6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a9:	8b 45 08             	mov    0x8(%ebp),%eax
  ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  af:	90                   	nop
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	8d 50 01             	lea    0x1(%eax),%edx
  b6:	89 55 08             	mov    %edx,0x8(%ebp)
  b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  bc:	8d 4a 01             	lea    0x1(%edx),%ecx
  bf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  c2:	0f b6 12             	movzbl (%edx),%edx
  c5:	88 10                	mov    %dl,(%eax)
  c7:	0f b6 00             	movzbl (%eax),%eax
  ca:	84 c0                	test   %al,%al
  cc:	75 e2                	jne    b0 <strcpy+0xd>
    ;
  return os;
  ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d1:	c9                   	leave  
  d2:	c3                   	ret    

000000d3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d3:	55                   	push   %ebp
  d4:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d6:	eb 08                	jmp    e0 <strcmp+0xd>
    p++, q++;
  d8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  dc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e0:	8b 45 08             	mov    0x8(%ebp),%eax
  e3:	0f b6 00             	movzbl (%eax),%eax
  e6:	84 c0                	test   %al,%al
  e8:	74 10                	je     fa <strcmp+0x27>
  ea:	8b 45 08             	mov    0x8(%ebp),%eax
  ed:	0f b6 10             	movzbl (%eax),%edx
  f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  f3:	0f b6 00             	movzbl (%eax),%eax
  f6:	38 c2                	cmp    %al,%dl
  f8:	74 de                	je     d8 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  fa:	8b 45 08             	mov    0x8(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	0f b6 d0             	movzbl %al,%edx
 103:	8b 45 0c             	mov    0xc(%ebp),%eax
 106:	0f b6 00             	movzbl (%eax),%eax
 109:	0f b6 c0             	movzbl %al,%eax
 10c:	29 c2                	sub    %eax,%edx
 10e:	89 d0                	mov    %edx,%eax
}
 110:	5d                   	pop    %ebp
 111:	c3                   	ret    

00000112 <strlen>:

uint
strlen(char *s)
{
 112:	55                   	push   %ebp
 113:	89 e5                	mov    %esp,%ebp
 115:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 118:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 11f:	eb 04                	jmp    125 <strlen+0x13>
 121:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 125:	8b 55 fc             	mov    -0x4(%ebp),%edx
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	01 d0                	add    %edx,%eax
 12d:	0f b6 00             	movzbl (%eax),%eax
 130:	84 c0                	test   %al,%al
 132:	75 ed                	jne    121 <strlen+0xf>
    ;
  return n;
 134:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 137:	c9                   	leave  
 138:	c3                   	ret    

00000139 <memset>:

void*
memset(void *dst, int c, uint n)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 13c:	8b 45 10             	mov    0x10(%ebp),%eax
 13f:	50                   	push   %eax
 140:	ff 75 0c             	pushl  0xc(%ebp)
 143:	ff 75 08             	pushl  0x8(%ebp)
 146:	e8 33 ff ff ff       	call   7e <stosb>
 14b:	83 c4 0c             	add    $0xc,%esp
  return dst;
 14e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 151:	c9                   	leave  
 152:	c3                   	ret    

00000153 <strchr>:

char*
strchr(const char *s, char c)
{
 153:	55                   	push   %ebp
 154:	89 e5                	mov    %esp,%ebp
 156:	83 ec 04             	sub    $0x4,%esp
 159:	8b 45 0c             	mov    0xc(%ebp),%eax
 15c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 15f:	eb 14                	jmp    175 <strchr+0x22>
    if(*s == c)
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	0f b6 00             	movzbl (%eax),%eax
 167:	3a 45 fc             	cmp    -0x4(%ebp),%al
 16a:	75 05                	jne    171 <strchr+0x1e>
      return (char*)s;
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	eb 13                	jmp    184 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 171:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	0f b6 00             	movzbl (%eax),%eax
 17b:	84 c0                	test   %al,%al
 17d:	75 e2                	jne    161 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 17f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 184:	c9                   	leave  
 185:	c3                   	ret    

00000186 <gets>:

char*
gets(char *buf, int max)
{
 186:	55                   	push   %ebp
 187:	89 e5                	mov    %esp,%ebp
 189:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 193:	eb 44                	jmp    1d9 <gets+0x53>
    cc = read(0, &c, 1);
 195:	83 ec 04             	sub    $0x4,%esp
 198:	6a 01                	push   $0x1
 19a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 19d:	50                   	push   %eax
 19e:	6a 00                	push   $0x0
 1a0:	e8 46 01 00 00       	call   2eb <read>
 1a5:	83 c4 10             	add    $0x10,%esp
 1a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1af:	7f 02                	jg     1b3 <gets+0x2d>
      break;
 1b1:	eb 31                	jmp    1e4 <gets+0x5e>
    buf[i++] = c;
 1b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b6:	8d 50 01             	lea    0x1(%eax),%edx
 1b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1bc:	89 c2                	mov    %eax,%edx
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	01 c2                	add    %eax,%edx
 1c3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 13                	je     1e4 <gets+0x5e>
 1d1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d5:	3c 0d                	cmp    $0xd,%al
 1d7:	74 0b                	je     1e4 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1dc:	83 c0 01             	add    $0x1,%eax
 1df:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1e2:	7c b1                	jl     195 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	01 d0                	add    %edx,%eax
 1ec:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f2:	c9                   	leave  
 1f3:	c3                   	ret    

000001f4 <stat>:

int
stat(char *n, struct stat *st)
{
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fa:	83 ec 08             	sub    $0x8,%esp
 1fd:	6a 00                	push   $0x0
 1ff:	ff 75 08             	pushl  0x8(%ebp)
 202:	e8 0c 01 00 00       	call   313 <open>
 207:	83 c4 10             	add    $0x10,%esp
 20a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 211:	79 07                	jns    21a <stat+0x26>
    return -1;
 213:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 218:	eb 25                	jmp    23f <stat+0x4b>
  r = fstat(fd, st);
 21a:	83 ec 08             	sub    $0x8,%esp
 21d:	ff 75 0c             	pushl  0xc(%ebp)
 220:	ff 75 f4             	pushl  -0xc(%ebp)
 223:	e8 03 01 00 00       	call   32b <fstat>
 228:	83 c4 10             	add    $0x10,%esp
 22b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22e:	83 ec 0c             	sub    $0xc,%esp
 231:	ff 75 f4             	pushl  -0xc(%ebp)
 234:	e8 c2 00 00 00       	call   2fb <close>
 239:	83 c4 10             	add    $0x10,%esp
  return r;
 23c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23f:	c9                   	leave  
 240:	c3                   	ret    

00000241 <atoi>:

int
atoi(const char *s)
{
 241:	55                   	push   %ebp
 242:	89 e5                	mov    %esp,%ebp
 244:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 247:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24e:	eb 25                	jmp    275 <atoi+0x34>
    n = n*10 + *s++ - '0';
 250:	8b 55 fc             	mov    -0x4(%ebp),%edx
 253:	89 d0                	mov    %edx,%eax
 255:	c1 e0 02             	shl    $0x2,%eax
 258:	01 d0                	add    %edx,%eax
 25a:	01 c0                	add    %eax,%eax
 25c:	89 c1                	mov    %eax,%ecx
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	8d 50 01             	lea    0x1(%eax),%edx
 264:	89 55 08             	mov    %edx,0x8(%ebp)
 267:	0f b6 00             	movzbl (%eax),%eax
 26a:	0f be c0             	movsbl %al,%eax
 26d:	01 c8                	add    %ecx,%eax
 26f:	83 e8 30             	sub    $0x30,%eax
 272:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	0f b6 00             	movzbl (%eax),%eax
 27b:	3c 2f                	cmp    $0x2f,%al
 27d:	7e 0a                	jle    289 <atoi+0x48>
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
 282:	0f b6 00             	movzbl (%eax),%eax
 285:	3c 39                	cmp    $0x39,%al
 287:	7e c7                	jle    250 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 289:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 28c:	c9                   	leave  
 28d:	c3                   	ret    

0000028e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28e:	55                   	push   %ebp
 28f:	89 e5                	mov    %esp,%ebp
 291:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 29a:	8b 45 0c             	mov    0xc(%ebp),%eax
 29d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2a0:	eb 17                	jmp    2b9 <memmove+0x2b>
    *dst++ = *src++;
 2a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a5:	8d 50 01             	lea    0x1(%eax),%edx
 2a8:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2ae:	8d 4a 01             	lea    0x1(%edx),%ecx
 2b1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b4:	0f b6 12             	movzbl (%edx),%edx
 2b7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b9:	8b 45 10             	mov    0x10(%ebp),%eax
 2bc:	8d 50 ff             	lea    -0x1(%eax),%edx
 2bf:	89 55 10             	mov    %edx,0x10(%ebp)
 2c2:	85 c0                	test   %eax,%eax
 2c4:	7f dc                	jg     2a2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c9:	c9                   	leave  
 2ca:	c3                   	ret    

000002cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cb:	b8 01 00 00 00       	mov    $0x1,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <exit>:
SYSCALL(exit)
 2d3:	b8 02 00 00 00       	mov    $0x2,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <wait>:
SYSCALL(wait)
 2db:	b8 03 00 00 00       	mov    $0x3,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <pipe>:
SYSCALL(pipe)
 2e3:	b8 04 00 00 00       	mov    $0x4,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <read>:
SYSCALL(read)
 2eb:	b8 05 00 00 00       	mov    $0x5,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <write>:
SYSCALL(write)
 2f3:	b8 10 00 00 00       	mov    $0x10,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <close>:
SYSCALL(close)
 2fb:	b8 15 00 00 00       	mov    $0x15,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <kill>:
SYSCALL(kill)
 303:	b8 06 00 00 00       	mov    $0x6,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <exec>:
SYSCALL(exec)
 30b:	b8 07 00 00 00       	mov    $0x7,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <open>:
SYSCALL(open)
 313:	b8 0f 00 00 00       	mov    $0xf,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <mknod>:
SYSCALL(mknod)
 31b:	b8 11 00 00 00       	mov    $0x11,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <unlink>:
SYSCALL(unlink)
 323:	b8 12 00 00 00       	mov    $0x12,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <fstat>:
SYSCALL(fstat)
 32b:	b8 08 00 00 00       	mov    $0x8,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <link>:
SYSCALL(link)
 333:	b8 13 00 00 00       	mov    $0x13,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <mkdir>:
SYSCALL(mkdir)
 33b:	b8 14 00 00 00       	mov    $0x14,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <chdir>:
SYSCALL(chdir)
 343:	b8 09 00 00 00       	mov    $0x9,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <dup>:
SYSCALL(dup)
 34b:	b8 0a 00 00 00       	mov    $0xa,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <getpid>:
SYSCALL(getpid)
 353:	b8 0b 00 00 00       	mov    $0xb,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <sbrk>:
SYSCALL(sbrk)
 35b:	b8 0c 00 00 00       	mov    $0xc,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <sleep>:
SYSCALL(sleep)
 363:	b8 0d 00 00 00       	mov    $0xd,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <uptime>:
SYSCALL(uptime)
 36b:	b8 0e 00 00 00       	mov    $0xe,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <pstat>:
SYSCALL(pstat)
 373:	b8 16 00 00 00       	mov    $0x16,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 37b:	55                   	push   %ebp
 37c:	89 e5                	mov    %esp,%ebp
 37e:	83 ec 18             	sub    $0x18,%esp
 381:	8b 45 0c             	mov    0xc(%ebp),%eax
 384:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 387:	83 ec 04             	sub    $0x4,%esp
 38a:	6a 01                	push   $0x1
 38c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 38f:	50                   	push   %eax
 390:	ff 75 08             	pushl  0x8(%ebp)
 393:	e8 5b ff ff ff       	call   2f3 <write>
 398:	83 c4 10             	add    $0x10,%esp
}
 39b:	c9                   	leave  
 39c:	c3                   	ret    

0000039d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 39d:	55                   	push   %ebp
 39e:	89 e5                	mov    %esp,%ebp
 3a0:	53                   	push   %ebx
 3a1:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3ab:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3af:	74 17                	je     3c8 <printint+0x2b>
 3b1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3b5:	79 11                	jns    3c8 <printint+0x2b>
    neg = 1;
 3b7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3be:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c1:	f7 d8                	neg    %eax
 3c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3c6:	eb 06                	jmp    3ce <printint+0x31>
  } else {
    x = xx;
 3c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3d5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3d8:	8d 41 01             	lea    0x1(%ecx),%eax
 3db:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3de:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e4:	ba 00 00 00 00       	mov    $0x0,%edx
 3e9:	f7 f3                	div    %ebx
 3eb:	89 d0                	mov    %edx,%eax
 3ed:	0f b6 80 80 0a 00 00 	movzbl 0xa80(%eax),%eax
 3f4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fe:	ba 00 00 00 00       	mov    $0x0,%edx
 403:	f7 f3                	div    %ebx
 405:	89 45 ec             	mov    %eax,-0x14(%ebp)
 408:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 40c:	75 c7                	jne    3d5 <printint+0x38>
  if(neg)
 40e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 412:	74 0e                	je     422 <printint+0x85>
    buf[i++] = '-';
 414:	8b 45 f4             	mov    -0xc(%ebp),%eax
 417:	8d 50 01             	lea    0x1(%eax),%edx
 41a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 41d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 422:	eb 1d                	jmp    441 <printint+0xa4>
    putc(fd, buf[i]);
 424:	8d 55 dc             	lea    -0x24(%ebp),%edx
 427:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42a:	01 d0                	add    %edx,%eax
 42c:	0f b6 00             	movzbl (%eax),%eax
 42f:	0f be c0             	movsbl %al,%eax
 432:	83 ec 08             	sub    $0x8,%esp
 435:	50                   	push   %eax
 436:	ff 75 08             	pushl  0x8(%ebp)
 439:	e8 3d ff ff ff       	call   37b <putc>
 43e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 441:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 445:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 449:	79 d9                	jns    424 <printint+0x87>
    putc(fd, buf[i]);
}
 44b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44e:	c9                   	leave  
 44f:	c3                   	ret    

00000450 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 456:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 45d:	8d 45 0c             	lea    0xc(%ebp),%eax
 460:	83 c0 04             	add    $0x4,%eax
 463:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 466:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 46d:	e9 59 01 00 00       	jmp    5cb <printf+0x17b>
    c = fmt[i] & 0xff;
 472:	8b 55 0c             	mov    0xc(%ebp),%edx
 475:	8b 45 f0             	mov    -0x10(%ebp),%eax
 478:	01 d0                	add    %edx,%eax
 47a:	0f b6 00             	movzbl (%eax),%eax
 47d:	0f be c0             	movsbl %al,%eax
 480:	25 ff 00 00 00       	and    $0xff,%eax
 485:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 488:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48c:	75 2c                	jne    4ba <printf+0x6a>
      if(c == '%'){
 48e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 492:	75 0c                	jne    4a0 <printf+0x50>
        state = '%';
 494:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 49b:	e9 27 01 00 00       	jmp    5c7 <printf+0x177>
      } else {
        putc(fd, c);
 4a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4a3:	0f be c0             	movsbl %al,%eax
 4a6:	83 ec 08             	sub    $0x8,%esp
 4a9:	50                   	push   %eax
 4aa:	ff 75 08             	pushl  0x8(%ebp)
 4ad:	e8 c9 fe ff ff       	call   37b <putc>
 4b2:	83 c4 10             	add    $0x10,%esp
 4b5:	e9 0d 01 00 00       	jmp    5c7 <printf+0x177>
      }
    } else if(state == '%'){
 4ba:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4be:	0f 85 03 01 00 00    	jne    5c7 <printf+0x177>
      if(c == 'd'){
 4c4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4c8:	75 1e                	jne    4e8 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4cd:	8b 00                	mov    (%eax),%eax
 4cf:	6a 01                	push   $0x1
 4d1:	6a 0a                	push   $0xa
 4d3:	50                   	push   %eax
 4d4:	ff 75 08             	pushl  0x8(%ebp)
 4d7:	e8 c1 fe ff ff       	call   39d <printint>
 4dc:	83 c4 10             	add    $0x10,%esp
        ap++;
 4df:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e3:	e9 d8 00 00 00       	jmp    5c0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4e8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ec:	74 06                	je     4f4 <printf+0xa4>
 4ee:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4f2:	75 1e                	jne    512 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f7:	8b 00                	mov    (%eax),%eax
 4f9:	6a 00                	push   $0x0
 4fb:	6a 10                	push   $0x10
 4fd:	50                   	push   %eax
 4fe:	ff 75 08             	pushl  0x8(%ebp)
 501:	e8 97 fe ff ff       	call   39d <printint>
 506:	83 c4 10             	add    $0x10,%esp
        ap++;
 509:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 50d:	e9 ae 00 00 00       	jmp    5c0 <printf+0x170>
      } else if(c == 's'){
 512:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 516:	75 43                	jne    55b <printf+0x10b>
        s = (char*)*ap;
 518:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51b:	8b 00                	mov    (%eax),%eax
 51d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 520:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 524:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 528:	75 07                	jne    531 <printf+0xe1>
          s = "(null)";
 52a:	c7 45 f4 2b 08 00 00 	movl   $0x82b,-0xc(%ebp)
        while(*s != 0){
 531:	eb 1c                	jmp    54f <printf+0xff>
          putc(fd, *s);
 533:	8b 45 f4             	mov    -0xc(%ebp),%eax
 536:	0f b6 00             	movzbl (%eax),%eax
 539:	0f be c0             	movsbl %al,%eax
 53c:	83 ec 08             	sub    $0x8,%esp
 53f:	50                   	push   %eax
 540:	ff 75 08             	pushl  0x8(%ebp)
 543:	e8 33 fe ff ff       	call   37b <putc>
 548:	83 c4 10             	add    $0x10,%esp
          s++;
 54b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 54f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 552:	0f b6 00             	movzbl (%eax),%eax
 555:	84 c0                	test   %al,%al
 557:	75 da                	jne    533 <printf+0xe3>
 559:	eb 65                	jmp    5c0 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 55b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 55f:	75 1d                	jne    57e <printf+0x12e>
        putc(fd, *ap);
 561:	8b 45 e8             	mov    -0x18(%ebp),%eax
 564:	8b 00                	mov    (%eax),%eax
 566:	0f be c0             	movsbl %al,%eax
 569:	83 ec 08             	sub    $0x8,%esp
 56c:	50                   	push   %eax
 56d:	ff 75 08             	pushl  0x8(%ebp)
 570:	e8 06 fe ff ff       	call   37b <putc>
 575:	83 c4 10             	add    $0x10,%esp
        ap++;
 578:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57c:	eb 42                	jmp    5c0 <printf+0x170>
      } else if(c == '%'){
 57e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 582:	75 17                	jne    59b <printf+0x14b>
        putc(fd, c);
 584:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 587:	0f be c0             	movsbl %al,%eax
 58a:	83 ec 08             	sub    $0x8,%esp
 58d:	50                   	push   %eax
 58e:	ff 75 08             	pushl  0x8(%ebp)
 591:	e8 e5 fd ff ff       	call   37b <putc>
 596:	83 c4 10             	add    $0x10,%esp
 599:	eb 25                	jmp    5c0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 59b:	83 ec 08             	sub    $0x8,%esp
 59e:	6a 25                	push   $0x25
 5a0:	ff 75 08             	pushl  0x8(%ebp)
 5a3:	e8 d3 fd ff ff       	call   37b <putc>
 5a8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ae:	0f be c0             	movsbl %al,%eax
 5b1:	83 ec 08             	sub    $0x8,%esp
 5b4:	50                   	push   %eax
 5b5:	ff 75 08             	pushl  0x8(%ebp)
 5b8:	e8 be fd ff ff       	call   37b <putc>
 5bd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5cb:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d1:	01 d0                	add    %edx,%eax
 5d3:	0f b6 00             	movzbl (%eax),%eax
 5d6:	84 c0                	test   %al,%al
 5d8:	0f 85 94 fe ff ff    	jne    472 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5de:	c9                   	leave  
 5df:	c3                   	ret    

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e6:	8b 45 08             	mov    0x8(%ebp),%eax
 5e9:	83 e8 08             	sub    $0x8,%eax
 5ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ef:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 5f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f7:	eb 24                	jmp    61d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fc:	8b 00                	mov    (%eax),%eax
 5fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 601:	77 12                	ja     615 <free+0x35>
 603:	8b 45 f8             	mov    -0x8(%ebp),%eax
 606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 609:	77 24                	ja     62f <free+0x4f>
 60b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60e:	8b 00                	mov    (%eax),%eax
 610:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 613:	77 1a                	ja     62f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 615:	8b 45 fc             	mov    -0x4(%ebp),%eax
 618:	8b 00                	mov    (%eax),%eax
 61a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 61d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 620:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 623:	76 d4                	jbe    5f9 <free+0x19>
 625:	8b 45 fc             	mov    -0x4(%ebp),%eax
 628:	8b 00                	mov    (%eax),%eax
 62a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62d:	76 ca                	jbe    5f9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 62f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 632:	8b 40 04             	mov    0x4(%eax),%eax
 635:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 63c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63f:	01 c2                	add    %eax,%edx
 641:	8b 45 fc             	mov    -0x4(%ebp),%eax
 644:	8b 00                	mov    (%eax),%eax
 646:	39 c2                	cmp    %eax,%edx
 648:	75 24                	jne    66e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64d:	8b 50 04             	mov    0x4(%eax),%edx
 650:	8b 45 fc             	mov    -0x4(%ebp),%eax
 653:	8b 00                	mov    (%eax),%eax
 655:	8b 40 04             	mov    0x4(%eax),%eax
 658:	01 c2                	add    %eax,%edx
 65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 660:	8b 45 fc             	mov    -0x4(%ebp),%eax
 663:	8b 00                	mov    (%eax),%eax
 665:	8b 10                	mov    (%eax),%edx
 667:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66a:	89 10                	mov    %edx,(%eax)
 66c:	eb 0a                	jmp    678 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	8b 10                	mov    (%eax),%edx
 673:	8b 45 f8             	mov    -0x8(%ebp),%eax
 676:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 678:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67b:	8b 40 04             	mov    0x4(%eax),%eax
 67e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	01 d0                	add    %edx,%eax
 68a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68d:	75 20                	jne    6af <free+0xcf>
    p->s.size += bp->s.size;
 68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 692:	8b 50 04             	mov    0x4(%eax),%edx
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	8b 40 04             	mov    0x4(%eax),%eax
 69b:	01 c2                	add    %eax,%edx
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 10                	mov    (%eax),%edx
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	89 10                	mov    %edx,(%eax)
 6ad:	eb 08                	jmp    6b7 <free+0xd7>
  } else
    p->s.ptr = bp;
 6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6b5:	89 10                	mov    %edx,(%eax)
  freep = p;
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	a3 9c 0a 00 00       	mov    %eax,0xa9c
}
 6bf:	c9                   	leave  
 6c0:	c3                   	ret    

000006c1 <morecore>:

static Header*
morecore(uint nu)
{
 6c1:	55                   	push   %ebp
 6c2:	89 e5                	mov    %esp,%ebp
 6c4:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ce:	77 07                	ja     6d7 <morecore+0x16>
    nu = 4096;
 6d0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d7:	8b 45 08             	mov    0x8(%ebp),%eax
 6da:	c1 e0 03             	shl    $0x3,%eax
 6dd:	83 ec 0c             	sub    $0xc,%esp
 6e0:	50                   	push   %eax
 6e1:	e8 75 fc ff ff       	call   35b <sbrk>
 6e6:	83 c4 10             	add    $0x10,%esp
 6e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ec:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6f0:	75 07                	jne    6f9 <morecore+0x38>
    return 0;
 6f2:	b8 00 00 00 00       	mov    $0x0,%eax
 6f7:	eb 26                	jmp    71f <morecore+0x5e>
  hp = (Header*)p;
 6f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 702:	8b 55 08             	mov    0x8(%ebp),%edx
 705:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 708:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70b:	83 c0 08             	add    $0x8,%eax
 70e:	83 ec 0c             	sub    $0xc,%esp
 711:	50                   	push   %eax
 712:	e8 c9 fe ff ff       	call   5e0 <free>
 717:	83 c4 10             	add    $0x10,%esp
  return freep;
 71a:	a1 9c 0a 00 00       	mov    0xa9c,%eax
}
 71f:	c9                   	leave  
 720:	c3                   	ret    

00000721 <malloc>:

void*
malloc(uint nbytes)
{
 721:	55                   	push   %ebp
 722:	89 e5                	mov    %esp,%ebp
 724:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 727:	8b 45 08             	mov    0x8(%ebp),%eax
 72a:	83 c0 07             	add    $0x7,%eax
 72d:	c1 e8 03             	shr    $0x3,%eax
 730:	83 c0 01             	add    $0x1,%eax
 733:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 736:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 73b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 73e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 742:	75 23                	jne    767 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 744:	c7 45 f0 94 0a 00 00 	movl   $0xa94,-0x10(%ebp)
 74b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74e:	a3 9c 0a 00 00       	mov    %eax,0xa9c
 753:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 758:	a3 94 0a 00 00       	mov    %eax,0xa94
    base.s.size = 0;
 75d:	c7 05 98 0a 00 00 00 	movl   $0x0,0xa98
 764:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	8b 00                	mov    (%eax),%eax
 76c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	8b 40 04             	mov    0x4(%eax),%eax
 775:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 778:	72 4d                	jb     7c7 <malloc+0xa6>
      if(p->s.size == nunits)
 77a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77d:	8b 40 04             	mov    0x4(%eax),%eax
 780:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 783:	75 0c                	jne    791 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 785:	8b 45 f4             	mov    -0xc(%ebp),%eax
 788:	8b 10                	mov    (%eax),%edx
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	89 10                	mov    %edx,(%eax)
 78f:	eb 26                	jmp    7b7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 791:	8b 45 f4             	mov    -0xc(%ebp),%eax
 794:	8b 40 04             	mov    0x4(%eax),%eax
 797:	2b 45 ec             	sub    -0x14(%ebp),%eax
 79a:	89 c2                	mov    %eax,%edx
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	8b 40 04             	mov    0x4(%eax),%eax
 7a8:	c1 e0 03             	shl    $0x3,%eax
 7ab:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7b4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ba:	a3 9c 0a 00 00       	mov    %eax,0xa9c
      return (void*)(p + 1);
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	83 c0 08             	add    $0x8,%eax
 7c5:	eb 3b                	jmp    802 <malloc+0xe1>
    }
    if(p == freep)
 7c7:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 7cc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7cf:	75 1e                	jne    7ef <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7d1:	83 ec 0c             	sub    $0xc,%esp
 7d4:	ff 75 ec             	pushl  -0x14(%ebp)
 7d7:	e8 e5 fe ff ff       	call   6c1 <morecore>
 7dc:	83 c4 10             	add    $0x10,%esp
 7df:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e6:	75 07                	jne    7ef <malloc+0xce>
        return 0;
 7e8:	b8 00 00 00 00       	mov    $0x0,%eax
 7ed:	eb 13                	jmp    802 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7fd:	e9 6d ff ff ff       	jmp    76f <malloc+0x4e>
}
 802:	c9                   	leave  
 803:	c3                   	ret    
