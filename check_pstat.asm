
_check_pstat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
//#include "procstat.h"


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
   f:	83 ec 20             	sub    $0x20,%esp
  12:	89 cb                	mov    %ecx,%ebx
   struct procstat p_stat;
   int pid = getpid();
  14:	e8 90 03 00 00       	call   3a9 <getpid>
  19:	89 45 f4             	mov    %eax,-0xc(%ebp)
   if (argc > 1) {
  1c:	83 3b 01             	cmpl   $0x1,(%ebx)
  1f:	7e 17                	jle    38 <main+0x38>
      pid = atoi(argv[1]);
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c0 04             	add    $0x4,%eax
  27:	8b 00                	mov    (%eax),%eax
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	50                   	push   %eax
  2d:	e8 65 02 00 00       	call   297 <atoi>
  32:	83 c4 10             	add    $0x10,%esp
  35:	89 45 f4             	mov    %eax,-0xc(%ebp)
   }
   printf(1, "Entered pid : %d\n", pid);
  38:	83 ec 04             	sub    $0x4,%esp
  3b:	ff 75 f4             	pushl  -0xc(%ebp)
  3e:	68 5c 08 00 00       	push   $0x85c
  43:	6a 01                	push   $0x1
  45:	e8 5c 04 00 00       	call   4a6 <printf>
  4a:	83 c4 10             	add    $0x10,%esp

   if (pstat(pid,&p_stat) == -1) {
  4d:	83 ec 08             	sub    $0x8,%esp
  50:	8d 45 d8             	lea    -0x28(%ebp),%eax
  53:	50                   	push   %eax
  54:	ff 75 f4             	pushl  -0xc(%ebp)
  57:	e8 6d 03 00 00       	call   3c9 <pstat>
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	83 f8 ff             	cmp    $0xffffffff,%eax
  62:	75 1d                	jne    81 <main+0x81>
      printf(1,"BALAGAN! %s\n",argv[1]);
  64:	8b 43 04             	mov    0x4(%ebx),%eax
  67:	83 c0 04             	add    $0x4,%eax
  6a:	8b 00                	mov    (%eax),%eax
  6c:	83 ec 04             	sub    $0x4,%esp
  6f:	50                   	push   %eax
  70:	68 6e 08 00 00       	push   $0x86e
  75:	6a 01                	push   $0x1
  77:	e8 2a 04 00 00       	call   4a6 <printf>
  7c:	83 c4 10             	add    $0x10,%esp
  7f:	eb 44                	jmp    c5 <main+0xc5>
   } else {
	 printf(1,"Process name : ");
  81:	83 ec 08             	sub    $0x8,%esp
  84:	68 7b 08 00 00       	push   $0x87b
  89:	6a 01                	push   $0x1
  8b:	e8 16 04 00 00       	call   4a6 <printf>
  90:	83 c4 10             	add    $0x10,%esp
     printf(1,p_stat.name);
  93:	83 ec 08             	sub    $0x8,%esp
  96:	8d 45 d8             	lea    -0x28(%ebp),%eax
  99:	50                   	push   %eax
  9a:	6a 01                	push   $0x1
  9c:	e8 05 04 00 00       	call   4a6 <printf>
  a1:	83 c4 10             	add    $0x10,%esp
     printf(1,"\nSize: %d\nNum of files: %d\nState value: %d\nPID: %d\n",p_stat.sz,p_stat.nofile,p_stat.state,pid);
  a4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  a7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  ad:	83 ec 08             	sub    $0x8,%esp
  b0:	ff 75 f4             	pushl  -0xc(%ebp)
  b3:	51                   	push   %ecx
  b4:	52                   	push   %edx
  b5:	50                   	push   %eax
  b6:	68 8c 08 00 00       	push   $0x88c
  bb:	6a 01                	push   $0x1
  bd:	e8 e4 03 00 00       	call   4a6 <printf>
  c2:	83 c4 20             	add    $0x20,%esp

   }

   return 1;
  c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
  cd:	59                   	pop    %ecx
  ce:	5b                   	pop    %ebx
  cf:	5d                   	pop    %ebp
  d0:	8d 61 fc             	lea    -0x4(%ecx),%esp
  d3:	c3                   	ret    

000000d4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  dc:	8b 55 10             	mov    0x10(%ebp),%edx
  df:	8b 45 0c             	mov    0xc(%ebp),%eax
  e2:	89 cb                	mov    %ecx,%ebx
  e4:	89 df                	mov    %ebx,%edi
  e6:	89 d1                	mov    %edx,%ecx
  e8:	fc                   	cld    
  e9:	f3 aa                	rep stos %al,%es:(%edi)
  eb:	89 ca                	mov    %ecx,%edx
  ed:	89 fb                	mov    %edi,%ebx
  ef:	89 5d 08             	mov    %ebx,0x8(%ebp)
  f2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  f5:	5b                   	pop    %ebx
  f6:	5f                   	pop    %edi
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    

000000f9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  f9:	55                   	push   %ebp
  fa:	89 e5                	mov    %esp,%ebp
  fc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 105:	90                   	nop
 106:	8b 45 08             	mov    0x8(%ebp),%eax
 109:	8d 50 01             	lea    0x1(%eax),%edx
 10c:	89 55 08             	mov    %edx,0x8(%ebp)
 10f:	8b 55 0c             	mov    0xc(%ebp),%edx
 112:	8d 4a 01             	lea    0x1(%edx),%ecx
 115:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 118:	0f b6 12             	movzbl (%edx),%edx
 11b:	88 10                	mov    %dl,(%eax)
 11d:	0f b6 00             	movzbl (%eax),%eax
 120:	84 c0                	test   %al,%al
 122:	75 e2                	jne    106 <strcpy+0xd>
    ;
  return os;
 124:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 127:	c9                   	leave  
 128:	c3                   	ret    

00000129 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 129:	55                   	push   %ebp
 12a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 12c:	eb 08                	jmp    136 <strcmp+0xd>
    p++, q++;
 12e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 132:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 136:	8b 45 08             	mov    0x8(%ebp),%eax
 139:	0f b6 00             	movzbl (%eax),%eax
 13c:	84 c0                	test   %al,%al
 13e:	74 10                	je     150 <strcmp+0x27>
 140:	8b 45 08             	mov    0x8(%ebp),%eax
 143:	0f b6 10             	movzbl (%eax),%edx
 146:	8b 45 0c             	mov    0xc(%ebp),%eax
 149:	0f b6 00             	movzbl (%eax),%eax
 14c:	38 c2                	cmp    %al,%dl
 14e:	74 de                	je     12e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 150:	8b 45 08             	mov    0x8(%ebp),%eax
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	0f b6 d0             	movzbl %al,%edx
 159:	8b 45 0c             	mov    0xc(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	0f b6 c0             	movzbl %al,%eax
 162:	29 c2                	sub    %eax,%edx
 164:	89 d0                	mov    %edx,%eax
}
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    

00000168 <strlen>:

uint
strlen(char *s)
{
 168:	55                   	push   %ebp
 169:	89 e5                	mov    %esp,%ebp
 16b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 16e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 175:	eb 04                	jmp    17b <strlen+0x13>
 177:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 17b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	01 d0                	add    %edx,%eax
 183:	0f b6 00             	movzbl (%eax),%eax
 186:	84 c0                	test   %al,%al
 188:	75 ed                	jne    177 <strlen+0xf>
    ;
  return n;
 18a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 18d:	c9                   	leave  
 18e:	c3                   	ret    

0000018f <memset>:

void*
memset(void *dst, int c, uint n)
{
 18f:	55                   	push   %ebp
 190:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 192:	8b 45 10             	mov    0x10(%ebp),%eax
 195:	50                   	push   %eax
 196:	ff 75 0c             	pushl  0xc(%ebp)
 199:	ff 75 08             	pushl  0x8(%ebp)
 19c:	e8 33 ff ff ff       	call   d4 <stosb>
 1a1:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a7:	c9                   	leave  
 1a8:	c3                   	ret    

000001a9 <strchr>:

char*
strchr(const char *s, char c)
{
 1a9:	55                   	push   %ebp
 1aa:	89 e5                	mov    %esp,%ebp
 1ac:	83 ec 04             	sub    $0x4,%esp
 1af:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1b5:	eb 14                	jmp    1cb <strchr+0x22>
    if(*s == c)
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	0f b6 00             	movzbl (%eax),%eax
 1bd:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1c0:	75 05                	jne    1c7 <strchr+0x1e>
      return (char*)s;
 1c2:	8b 45 08             	mov    0x8(%ebp),%eax
 1c5:	eb 13                	jmp    1da <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1c7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	0f b6 00             	movzbl (%eax),%eax
 1d1:	84 c0                	test   %al,%al
 1d3:	75 e2                	jne    1b7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1da:	c9                   	leave  
 1db:	c3                   	ret    

000001dc <gets>:

char*
gets(char *buf, int max)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1e9:	eb 44                	jmp    22f <gets+0x53>
    cc = read(0, &c, 1);
 1eb:	83 ec 04             	sub    $0x4,%esp
 1ee:	6a 01                	push   $0x1
 1f0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1f3:	50                   	push   %eax
 1f4:	6a 00                	push   $0x0
 1f6:	e8 46 01 00 00       	call   341 <read>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 201:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 205:	7f 02                	jg     209 <gets+0x2d>
      break;
 207:	eb 31                	jmp    23a <gets+0x5e>
    buf[i++] = c;
 209:	8b 45 f4             	mov    -0xc(%ebp),%eax
 20c:	8d 50 01             	lea    0x1(%eax),%edx
 20f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 212:	89 c2                	mov    %eax,%edx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	01 c2                	add    %eax,%edx
 219:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 21d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 21f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 223:	3c 0a                	cmp    $0xa,%al
 225:	74 13                	je     23a <gets+0x5e>
 227:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 22b:	3c 0d                	cmp    $0xd,%al
 22d:	74 0b                	je     23a <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 232:	83 c0 01             	add    $0x1,%eax
 235:	3b 45 0c             	cmp    0xc(%ebp),%eax
 238:	7c b1                	jl     1eb <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 23a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 23d:	8b 45 08             	mov    0x8(%ebp),%eax
 240:	01 d0                	add    %edx,%eax
 242:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 245:	8b 45 08             	mov    0x8(%ebp),%eax
}
 248:	c9                   	leave  
 249:	c3                   	ret    

0000024a <stat>:

int
stat(char *n, struct stat *st)
{
 24a:	55                   	push   %ebp
 24b:	89 e5                	mov    %esp,%ebp
 24d:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 250:	83 ec 08             	sub    $0x8,%esp
 253:	6a 00                	push   $0x0
 255:	ff 75 08             	pushl  0x8(%ebp)
 258:	e8 0c 01 00 00       	call   369 <open>
 25d:	83 c4 10             	add    $0x10,%esp
 260:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 263:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 267:	79 07                	jns    270 <stat+0x26>
    return -1;
 269:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 26e:	eb 25                	jmp    295 <stat+0x4b>
  r = fstat(fd, st);
 270:	83 ec 08             	sub    $0x8,%esp
 273:	ff 75 0c             	pushl  0xc(%ebp)
 276:	ff 75 f4             	pushl  -0xc(%ebp)
 279:	e8 03 01 00 00       	call   381 <fstat>
 27e:	83 c4 10             	add    $0x10,%esp
 281:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 284:	83 ec 0c             	sub    $0xc,%esp
 287:	ff 75 f4             	pushl  -0xc(%ebp)
 28a:	e8 c2 00 00 00       	call   351 <close>
 28f:	83 c4 10             	add    $0x10,%esp
  return r;
 292:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <atoi>:

int
atoi(const char *s)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 29d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2a4:	eb 25                	jmp    2cb <atoi+0x34>
    n = n*10 + *s++ - '0';
 2a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2a9:	89 d0                	mov    %edx,%eax
 2ab:	c1 e0 02             	shl    $0x2,%eax
 2ae:	01 d0                	add    %edx,%eax
 2b0:	01 c0                	add    %eax,%eax
 2b2:	89 c1                	mov    %eax,%ecx
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	8d 50 01             	lea    0x1(%eax),%edx
 2ba:	89 55 08             	mov    %edx,0x8(%ebp)
 2bd:	0f b6 00             	movzbl (%eax),%eax
 2c0:	0f be c0             	movsbl %al,%eax
 2c3:	01 c8                	add    %ecx,%eax
 2c5:	83 e8 30             	sub    $0x30,%eax
 2c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2cb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ce:	0f b6 00             	movzbl (%eax),%eax
 2d1:	3c 2f                	cmp    $0x2f,%al
 2d3:	7e 0a                	jle    2df <atoi+0x48>
 2d5:	8b 45 08             	mov    0x8(%ebp),%eax
 2d8:	0f b6 00             	movzbl (%eax),%eax
 2db:	3c 39                	cmp    $0x39,%al
 2dd:	7e c7                	jle    2a6 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2df:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2e2:	c9                   	leave  
 2e3:	c3                   	ret    

000002e4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
 2ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2f6:	eb 17                	jmp    30f <memmove+0x2b>
    *dst++ = *src++;
 2f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2fb:	8d 50 01             	lea    0x1(%eax),%edx
 2fe:	89 55 fc             	mov    %edx,-0x4(%ebp)
 301:	8b 55 f8             	mov    -0x8(%ebp),%edx
 304:	8d 4a 01             	lea    0x1(%edx),%ecx
 307:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 30a:	0f b6 12             	movzbl (%edx),%edx
 30d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 30f:	8b 45 10             	mov    0x10(%ebp),%eax
 312:	8d 50 ff             	lea    -0x1(%eax),%edx
 315:	89 55 10             	mov    %edx,0x10(%ebp)
 318:	85 c0                	test   %eax,%eax
 31a:	7f dc                	jg     2f8 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 31c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 31f:	c9                   	leave  
 320:	c3                   	ret    

00000321 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 321:	b8 01 00 00 00       	mov    $0x1,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <exit>:
SYSCALL(exit)
 329:	b8 02 00 00 00       	mov    $0x2,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <wait>:
SYSCALL(wait)
 331:	b8 03 00 00 00       	mov    $0x3,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <pipe>:
SYSCALL(pipe)
 339:	b8 04 00 00 00       	mov    $0x4,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <read>:
SYSCALL(read)
 341:	b8 05 00 00 00       	mov    $0x5,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <write>:
SYSCALL(write)
 349:	b8 10 00 00 00       	mov    $0x10,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <close>:
SYSCALL(close)
 351:	b8 15 00 00 00       	mov    $0x15,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <kill>:
SYSCALL(kill)
 359:	b8 06 00 00 00       	mov    $0x6,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <exec>:
SYSCALL(exec)
 361:	b8 07 00 00 00       	mov    $0x7,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <open>:
SYSCALL(open)
 369:	b8 0f 00 00 00       	mov    $0xf,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <mknod>:
SYSCALL(mknod)
 371:	b8 11 00 00 00       	mov    $0x11,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <unlink>:
SYSCALL(unlink)
 379:	b8 12 00 00 00       	mov    $0x12,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <fstat>:
SYSCALL(fstat)
 381:	b8 08 00 00 00       	mov    $0x8,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <link>:
SYSCALL(link)
 389:	b8 13 00 00 00       	mov    $0x13,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <mkdir>:
SYSCALL(mkdir)
 391:	b8 14 00 00 00       	mov    $0x14,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <chdir>:
SYSCALL(chdir)
 399:	b8 09 00 00 00       	mov    $0x9,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <dup>:
SYSCALL(dup)
 3a1:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <getpid>:
SYSCALL(getpid)
 3a9:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <sbrk>:
SYSCALL(sbrk)
 3b1:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <sleep>:
SYSCALL(sleep)
 3b9:	b8 0d 00 00 00       	mov    $0xd,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <uptime>:
SYSCALL(uptime)
 3c1:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <pstat>:
SYSCALL(pstat)
 3c9:	b8 16 00 00 00       	mov    $0x16,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d1:	55                   	push   %ebp
 3d2:	89 e5                	mov    %esp,%ebp
 3d4:	83 ec 18             	sub    $0x18,%esp
 3d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3da:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3dd:	83 ec 04             	sub    $0x4,%esp
 3e0:	6a 01                	push   $0x1
 3e2:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e5:	50                   	push   %eax
 3e6:	ff 75 08             	pushl  0x8(%ebp)
 3e9:	e8 5b ff ff ff       	call   349 <write>
 3ee:	83 c4 10             	add    $0x10,%esp
}
 3f1:	c9                   	leave  
 3f2:	c3                   	ret    

000003f3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f3:	55                   	push   %ebp
 3f4:	89 e5                	mov    %esp,%ebp
 3f6:	53                   	push   %ebx
 3f7:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 401:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 405:	74 17                	je     41e <printint+0x2b>
 407:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40b:	79 11                	jns    41e <printint+0x2b>
    neg = 1;
 40d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 414:	8b 45 0c             	mov    0xc(%ebp),%eax
 417:	f7 d8                	neg    %eax
 419:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41c:	eb 06                	jmp    424 <printint+0x31>
  } else {
    x = xx;
 41e:	8b 45 0c             	mov    0xc(%ebp),%eax
 421:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 424:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 42e:	8d 41 01             	lea    0x1(%ecx),%eax
 431:	89 45 f4             	mov    %eax,-0xc(%ebp)
 434:	8b 5d 10             	mov    0x10(%ebp),%ebx
 437:	8b 45 ec             	mov    -0x14(%ebp),%eax
 43a:	ba 00 00 00 00       	mov    $0x0,%edx
 43f:	f7 f3                	div    %ebx
 441:	89 d0                	mov    %edx,%eax
 443:	0f b6 80 20 0b 00 00 	movzbl 0xb20(%eax),%eax
 44a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 44e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 451:	8b 45 ec             	mov    -0x14(%ebp),%eax
 454:	ba 00 00 00 00       	mov    $0x0,%edx
 459:	f7 f3                	div    %ebx
 45b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 45e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 462:	75 c7                	jne    42b <printint+0x38>
  if(neg)
 464:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 468:	74 0e                	je     478 <printint+0x85>
    buf[i++] = '-';
 46a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46d:	8d 50 01             	lea    0x1(%eax),%edx
 470:	89 55 f4             	mov    %edx,-0xc(%ebp)
 473:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 478:	eb 1d                	jmp    497 <printint+0xa4>
    putc(fd, buf[i]);
 47a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 47d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 480:	01 d0                	add    %edx,%eax
 482:	0f b6 00             	movzbl (%eax),%eax
 485:	0f be c0             	movsbl %al,%eax
 488:	83 ec 08             	sub    $0x8,%esp
 48b:	50                   	push   %eax
 48c:	ff 75 08             	pushl  0x8(%ebp)
 48f:	e8 3d ff ff ff       	call   3d1 <putc>
 494:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 497:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49f:	79 d9                	jns    47a <printint+0x87>
    putc(fd, buf[i]);
}
 4a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4a4:	c9                   	leave  
 4a5:	c3                   	ret    

000004a6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a6:	55                   	push   %ebp
 4a7:	89 e5                	mov    %esp,%ebp
 4a9:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b3:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b6:	83 c0 04             	add    $0x4,%eax
 4b9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c3:	e9 59 01 00 00       	jmp    621 <printf+0x17b>
    c = fmt[i] & 0xff;
 4c8:	8b 55 0c             	mov    0xc(%ebp),%edx
 4cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ce:	01 d0                	add    %edx,%eax
 4d0:	0f b6 00             	movzbl (%eax),%eax
 4d3:	0f be c0             	movsbl %al,%eax
 4d6:	25 ff 00 00 00       	and    $0xff,%eax
 4db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4de:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e2:	75 2c                	jne    510 <printf+0x6a>
      if(c == '%'){
 4e4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e8:	75 0c                	jne    4f6 <printf+0x50>
        state = '%';
 4ea:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f1:	e9 27 01 00 00       	jmp    61d <printf+0x177>
      } else {
        putc(fd, c);
 4f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f9:	0f be c0             	movsbl %al,%eax
 4fc:	83 ec 08             	sub    $0x8,%esp
 4ff:	50                   	push   %eax
 500:	ff 75 08             	pushl  0x8(%ebp)
 503:	e8 c9 fe ff ff       	call   3d1 <putc>
 508:	83 c4 10             	add    $0x10,%esp
 50b:	e9 0d 01 00 00       	jmp    61d <printf+0x177>
      }
    } else if(state == '%'){
 510:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 514:	0f 85 03 01 00 00    	jne    61d <printf+0x177>
      if(c == 'd'){
 51a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 51e:	75 1e                	jne    53e <printf+0x98>
        printint(fd, *ap, 10, 1);
 520:	8b 45 e8             	mov    -0x18(%ebp),%eax
 523:	8b 00                	mov    (%eax),%eax
 525:	6a 01                	push   $0x1
 527:	6a 0a                	push   $0xa
 529:	50                   	push   %eax
 52a:	ff 75 08             	pushl  0x8(%ebp)
 52d:	e8 c1 fe ff ff       	call   3f3 <printint>
 532:	83 c4 10             	add    $0x10,%esp
        ap++;
 535:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 539:	e9 d8 00 00 00       	jmp    616 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 53e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 542:	74 06                	je     54a <printf+0xa4>
 544:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 548:	75 1e                	jne    568 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 54a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54d:	8b 00                	mov    (%eax),%eax
 54f:	6a 00                	push   $0x0
 551:	6a 10                	push   $0x10
 553:	50                   	push   %eax
 554:	ff 75 08             	pushl  0x8(%ebp)
 557:	e8 97 fe ff ff       	call   3f3 <printint>
 55c:	83 c4 10             	add    $0x10,%esp
        ap++;
 55f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 563:	e9 ae 00 00 00       	jmp    616 <printf+0x170>
      } else if(c == 's'){
 568:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 56c:	75 43                	jne    5b1 <printf+0x10b>
        s = (char*)*ap;
 56e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 571:	8b 00                	mov    (%eax),%eax
 573:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 576:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 57e:	75 07                	jne    587 <printf+0xe1>
          s = "(null)";
 580:	c7 45 f4 c0 08 00 00 	movl   $0x8c0,-0xc(%ebp)
        while(*s != 0){
 587:	eb 1c                	jmp    5a5 <printf+0xff>
          putc(fd, *s);
 589:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58c:	0f b6 00             	movzbl (%eax),%eax
 58f:	0f be c0             	movsbl %al,%eax
 592:	83 ec 08             	sub    $0x8,%esp
 595:	50                   	push   %eax
 596:	ff 75 08             	pushl  0x8(%ebp)
 599:	e8 33 fe ff ff       	call   3d1 <putc>
 59e:	83 c4 10             	add    $0x10,%esp
          s++;
 5a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a8:	0f b6 00             	movzbl (%eax),%eax
 5ab:	84 c0                	test   %al,%al
 5ad:	75 da                	jne    589 <printf+0xe3>
 5af:	eb 65                	jmp    616 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5b5:	75 1d                	jne    5d4 <printf+0x12e>
        putc(fd, *ap);
 5b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ba:	8b 00                	mov    (%eax),%eax
 5bc:	0f be c0             	movsbl %al,%eax
 5bf:	83 ec 08             	sub    $0x8,%esp
 5c2:	50                   	push   %eax
 5c3:	ff 75 08             	pushl  0x8(%ebp)
 5c6:	e8 06 fe ff ff       	call   3d1 <putc>
 5cb:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d2:	eb 42                	jmp    616 <printf+0x170>
      } else if(c == '%'){
 5d4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d8:	75 17                	jne    5f1 <printf+0x14b>
        putc(fd, c);
 5da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5dd:	0f be c0             	movsbl %al,%eax
 5e0:	83 ec 08             	sub    $0x8,%esp
 5e3:	50                   	push   %eax
 5e4:	ff 75 08             	pushl  0x8(%ebp)
 5e7:	e8 e5 fd ff ff       	call   3d1 <putc>
 5ec:	83 c4 10             	add    $0x10,%esp
 5ef:	eb 25                	jmp    616 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f1:	83 ec 08             	sub    $0x8,%esp
 5f4:	6a 25                	push   $0x25
 5f6:	ff 75 08             	pushl  0x8(%ebp)
 5f9:	e8 d3 fd ff ff       	call   3d1 <putc>
 5fe:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 601:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 604:	0f be c0             	movsbl %al,%eax
 607:	83 ec 08             	sub    $0x8,%esp
 60a:	50                   	push   %eax
 60b:	ff 75 08             	pushl  0x8(%ebp)
 60e:	e8 be fd ff ff       	call   3d1 <putc>
 613:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 616:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 61d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 621:	8b 55 0c             	mov    0xc(%ebp),%edx
 624:	8b 45 f0             	mov    -0x10(%ebp),%eax
 627:	01 d0                	add    %edx,%eax
 629:	0f b6 00             	movzbl (%eax),%eax
 62c:	84 c0                	test   %al,%al
 62e:	0f 85 94 fe ff ff    	jne    4c8 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 634:	c9                   	leave  
 635:	c3                   	ret    

00000636 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 636:	55                   	push   %ebp
 637:	89 e5                	mov    %esp,%ebp
 639:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 63c:	8b 45 08             	mov    0x8(%ebp),%eax
 63f:	83 e8 08             	sub    $0x8,%eax
 642:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 645:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 64a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 64d:	eb 24                	jmp    673 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 652:	8b 00                	mov    (%eax),%eax
 654:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 657:	77 12                	ja     66b <free+0x35>
 659:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 65f:	77 24                	ja     685 <free+0x4f>
 661:	8b 45 fc             	mov    -0x4(%ebp),%eax
 664:	8b 00                	mov    (%eax),%eax
 666:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 669:	77 1a                	ja     685 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66e:	8b 00                	mov    (%eax),%eax
 670:	89 45 fc             	mov    %eax,-0x4(%ebp)
 673:	8b 45 f8             	mov    -0x8(%ebp),%eax
 676:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 679:	76 d4                	jbe    64f <free+0x19>
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	8b 00                	mov    (%eax),%eax
 680:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 683:	76 ca                	jbe    64f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 685:	8b 45 f8             	mov    -0x8(%ebp),%eax
 688:	8b 40 04             	mov    0x4(%eax),%eax
 68b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 692:	8b 45 f8             	mov    -0x8(%ebp),%eax
 695:	01 c2                	add    %eax,%edx
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	39 c2                	cmp    %eax,%edx
 69e:	75 24                	jne    6c4 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a3:	8b 50 04             	mov    0x4(%eax),%edx
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	8b 00                	mov    (%eax),%eax
 6ab:	8b 40 04             	mov    0x4(%eax),%eax
 6ae:	01 c2                	add    %eax,%edx
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b9:	8b 00                	mov    (%eax),%eax
 6bb:	8b 10                	mov    (%eax),%edx
 6bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c0:	89 10                	mov    %edx,(%eax)
 6c2:	eb 0a                	jmp    6ce <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 10                	mov    (%eax),%edx
 6c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cc:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d1:	8b 40 04             	mov    0x4(%eax),%eax
 6d4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6de:	01 d0                	add    %edx,%eax
 6e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e3:	75 20                	jne    705 <free+0xcf>
    p->s.size += bp->s.size;
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	8b 50 04             	mov    0x4(%eax),%edx
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	8b 40 04             	mov    0x4(%eax),%eax
 6f1:	01 c2                	add    %eax,%edx
 6f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fc:	8b 10                	mov    (%eax),%edx
 6fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 701:	89 10                	mov    %edx,(%eax)
 703:	eb 08                	jmp    70d <free+0xd7>
  } else
    p->s.ptr = bp;
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70b:	89 10                	mov    %edx,(%eax)
  freep = p;
 70d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 710:	a3 3c 0b 00 00       	mov    %eax,0xb3c
}
 715:	c9                   	leave  
 716:	c3                   	ret    

00000717 <morecore>:

static Header*
morecore(uint nu)
{
 717:	55                   	push   %ebp
 718:	89 e5                	mov    %esp,%ebp
 71a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 71d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 724:	77 07                	ja     72d <morecore+0x16>
    nu = 4096;
 726:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
 730:	c1 e0 03             	shl    $0x3,%eax
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	50                   	push   %eax
 737:	e8 75 fc ff ff       	call   3b1 <sbrk>
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 742:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 746:	75 07                	jne    74f <morecore+0x38>
    return 0;
 748:	b8 00 00 00 00       	mov    $0x0,%eax
 74d:	eb 26                	jmp    775 <morecore+0x5e>
  hp = (Header*)p;
 74f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 752:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 755:	8b 45 f0             	mov    -0x10(%ebp),%eax
 758:	8b 55 08             	mov    0x8(%ebp),%edx
 75b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 75e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 761:	83 c0 08             	add    $0x8,%eax
 764:	83 ec 0c             	sub    $0xc,%esp
 767:	50                   	push   %eax
 768:	e8 c9 fe ff ff       	call   636 <free>
 76d:	83 c4 10             	add    $0x10,%esp
  return freep;
 770:	a1 3c 0b 00 00       	mov    0xb3c,%eax
}
 775:	c9                   	leave  
 776:	c3                   	ret    

00000777 <malloc>:

void*
malloc(uint nbytes)
{
 777:	55                   	push   %ebp
 778:	89 e5                	mov    %esp,%ebp
 77a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 77d:	8b 45 08             	mov    0x8(%ebp),%eax
 780:	83 c0 07             	add    $0x7,%eax
 783:	c1 e8 03             	shr    $0x3,%eax
 786:	83 c0 01             	add    $0x1,%eax
 789:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 78c:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 791:	89 45 f0             	mov    %eax,-0x10(%ebp)
 794:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 798:	75 23                	jne    7bd <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 79a:	c7 45 f0 34 0b 00 00 	movl   $0xb34,-0x10(%ebp)
 7a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a4:	a3 3c 0b 00 00       	mov    %eax,0xb3c
 7a9:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 7ae:	a3 34 0b 00 00       	mov    %eax,0xb34
    base.s.size = 0;
 7b3:	c7 05 38 0b 00 00 00 	movl   $0x0,0xb38
 7ba:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c0:	8b 00                	mov    (%eax),%eax
 7c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	8b 40 04             	mov    0x4(%eax),%eax
 7cb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ce:	72 4d                	jb     81d <malloc+0xa6>
      if(p->s.size == nunits)
 7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d3:	8b 40 04             	mov    0x4(%eax),%eax
 7d6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d9:	75 0c                	jne    7e7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	8b 10                	mov    (%eax),%edx
 7e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e3:	89 10                	mov    %edx,(%eax)
 7e5:	eb 26                	jmp    80d <malloc+0x96>
      else {
        p->s.size -= nunits;
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	8b 40 04             	mov    0x4(%eax),%eax
 7ed:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f0:	89 c2                	mov    %eax,%edx
 7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fb:	8b 40 04             	mov    0x4(%eax),%eax
 7fe:	c1 e0 03             	shl    $0x3,%eax
 801:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 804:	8b 45 f4             	mov    -0xc(%ebp),%eax
 807:	8b 55 ec             	mov    -0x14(%ebp),%edx
 80a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 80d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 810:	a3 3c 0b 00 00       	mov    %eax,0xb3c
      return (void*)(p + 1);
 815:	8b 45 f4             	mov    -0xc(%ebp),%eax
 818:	83 c0 08             	add    $0x8,%eax
 81b:	eb 3b                	jmp    858 <malloc+0xe1>
    }
    if(p == freep)
 81d:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 822:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 825:	75 1e                	jne    845 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 827:	83 ec 0c             	sub    $0xc,%esp
 82a:	ff 75 ec             	pushl  -0x14(%ebp)
 82d:	e8 e5 fe ff ff       	call   717 <morecore>
 832:	83 c4 10             	add    $0x10,%esp
 835:	89 45 f4             	mov    %eax,-0xc(%ebp)
 838:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 83c:	75 07                	jne    845 <malloc+0xce>
        return 0;
 83e:	b8 00 00 00 00       	mov    $0x0,%eax
 843:	eb 13                	jmp    858 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 845:	8b 45 f4             	mov    -0xc(%ebp),%eax
 848:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84e:	8b 00                	mov    (%eax),%eax
 850:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 853:	e9 6d ff ff ff       	jmp    7c5 <malloc+0x4e>
}
 858:	c9                   	leave  
 859:	c3                   	ret    
