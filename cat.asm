
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 15                	jmp    1d <cat+0x1d>
    write(1, buf, n);
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	pushl  -0xc(%ebp)
   e:	68 c0 0b 00 00       	push   $0xbc0
  13:	6a 01                	push   $0x1
  15:	e8 7d 03 00 00       	call   397 <write>
  1a:	83 c4 10             	add    $0x10,%esp
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  1d:	83 ec 04             	sub    $0x4,%esp
  20:	68 00 02 00 00       	push   $0x200
  25:	68 c0 0b 00 00       	push   $0xbc0
  2a:	ff 75 08             	pushl  0x8(%ebp)
  2d:	e8 5d 03 00 00       	call   38f <read>
  32:	83 c4 10             	add    $0x10,%esp
  35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  3c:	7f ca                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  42:	79 1c                	jns    60 <cat+0x60>
    printf(1, "cat: read error\n");
  44:	83 ec 08             	sub    $0x8,%esp
  47:	68 a8 08 00 00       	push   $0x8a8
  4c:	6a 01                	push   $0x1
  4e:	e8 a1 04 00 00       	call   4f4 <printf>
  53:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	6a 01                	push   $0x1
  5b:	e8 17 03 00 00       	call   377 <exit>
  }
}
  60:	c9                   	leave  
  61:	c3                   	ret    

00000062 <main>:

int
main(int argc, char *argv[])
{
  62:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  66:	83 e4 f0             	and    $0xfffffff0,%esp
  69:	ff 71 fc             	pushl  -0x4(%ecx)
  6c:	55                   	push   %ebp
  6d:	89 e5                	mov    %esp,%ebp
  6f:	53                   	push   %ebx
  70:	51                   	push   %ecx
  71:	83 ec 10             	sub    $0x10,%esp
  74:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  76:	83 3b 01             	cmpl   $0x1,(%ebx)
  79:	7f 17                	jg     92 <main+0x30>
    cat(0);
  7b:	83 ec 0c             	sub    $0xc,%esp
  7e:	6a 00                	push   $0x0
  80:	e8 7b ff ff ff       	call   0 <cat>
  85:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
  88:	83 ec 0c             	sub    $0xc,%esp
  8b:	6a 01                	push   $0x1
  8d:	e8 e5 02 00 00       	call   377 <exit>
  }

  for(i = 1; i < argc; i++){
  92:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  99:	eb 76                	jmp    111 <main+0xaf>
    if((fd = open(argv[i], 0)) < 0){
  9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  9e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  a5:	8b 43 04             	mov    0x4(%ebx),%eax
  a8:	01 d0                	add    %edx,%eax
  aa:	8b 00                	mov    (%eax),%eax
  ac:	83 ec 08             	sub    $0x8,%esp
  af:	6a 00                	push   $0x0
  b1:	50                   	push   %eax
  b2:	e8 00 03 00 00       	call   3b7 <open>
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  c1:	79 2e                	jns    f1 <main+0x8f>
      printf(1, "cat: cannot open %s\n", argv[i]);
  c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  cd:	8b 43 04             	mov    0x4(%ebx),%eax
  d0:	01 d0                	add    %edx,%eax
  d2:	8b 00                	mov    (%eax),%eax
  d4:	83 ec 04             	sub    $0x4,%esp
  d7:	50                   	push   %eax
  d8:	68 b9 08 00 00       	push   $0x8b9
  dd:	6a 01                	push   $0x1
  df:	e8 10 04 00 00       	call   4f4 <printf>
  e4:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
  e7:	83 ec 0c             	sub    $0xc,%esp
  ea:	6a 01                	push   $0x1
  ec:	e8 86 02 00 00       	call   377 <exit>
    }
    cat(fd);
  f1:	83 ec 0c             	sub    $0xc,%esp
  f4:	ff 75 f0             	pushl  -0x10(%ebp)
  f7:	e8 04 ff ff ff       	call   0 <cat>
  fc:	83 c4 10             	add    $0x10,%esp
    close(fd);
  ff:	83 ec 0c             	sub    $0xc,%esp
 102:	ff 75 f0             	pushl  -0x10(%ebp)
 105:	e8 95 02 00 00       	call   39f <close>
 10a:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit(EXIT_STATUS_OK);
  }

  for(i = 1; i < argc; i++){
 10d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 111:	8b 45 f4             	mov    -0xc(%ebp),%eax
 114:	3b 03                	cmp    (%ebx),%eax
 116:	7c 83                	jl     9b <main+0x39>
      exit(EXIT_STATUS_OK);
    }
    cat(fd);
    close(fd);
  }
  exit(EXIT_STATUS_OK);
 118:	83 ec 0c             	sub    $0xc,%esp
 11b:	6a 01                	push   $0x1
 11d:	e8 55 02 00 00       	call   377 <exit>

00000122 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 122:	55                   	push   %ebp
 123:	89 e5                	mov    %esp,%ebp
 125:	57                   	push   %edi
 126:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 127:	8b 4d 08             	mov    0x8(%ebp),%ecx
 12a:	8b 55 10             	mov    0x10(%ebp),%edx
 12d:	8b 45 0c             	mov    0xc(%ebp),%eax
 130:	89 cb                	mov    %ecx,%ebx
 132:	89 df                	mov    %ebx,%edi
 134:	89 d1                	mov    %edx,%ecx
 136:	fc                   	cld    
 137:	f3 aa                	rep stos %al,%es:(%edi)
 139:	89 ca                	mov    %ecx,%edx
 13b:	89 fb                	mov    %edi,%ebx
 13d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 140:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 143:	5b                   	pop    %ebx
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    

00000147 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 153:	90                   	nop
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	8d 50 01             	lea    0x1(%eax),%edx
 15a:	89 55 08             	mov    %edx,0x8(%ebp)
 15d:	8b 55 0c             	mov    0xc(%ebp),%edx
 160:	8d 4a 01             	lea    0x1(%edx),%ecx
 163:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 166:	0f b6 12             	movzbl (%edx),%edx
 169:	88 10                	mov    %dl,(%eax)
 16b:	0f b6 00             	movzbl (%eax),%eax
 16e:	84 c0                	test   %al,%al
 170:	75 e2                	jne    154 <strcpy+0xd>
    ;
  return os;
 172:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 175:	c9                   	leave  
 176:	c3                   	ret    

00000177 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 177:	55                   	push   %ebp
 178:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 17a:	eb 08                	jmp    184 <strcmp+0xd>
    p++, q++;
 17c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 180:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 00             	movzbl (%eax),%eax
 18a:	84 c0                	test   %al,%al
 18c:	74 10                	je     19e <strcmp+0x27>
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	0f b6 10             	movzbl (%eax),%edx
 194:	8b 45 0c             	mov    0xc(%ebp),%eax
 197:	0f b6 00             	movzbl (%eax),%eax
 19a:	38 c2                	cmp    %al,%dl
 19c:	74 de                	je     17c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19e:	8b 45 08             	mov    0x8(%ebp),%eax
 1a1:	0f b6 00             	movzbl (%eax),%eax
 1a4:	0f b6 d0             	movzbl %al,%edx
 1a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1aa:	0f b6 00             	movzbl (%eax),%eax
 1ad:	0f b6 c0             	movzbl %al,%eax
 1b0:	29 c2                	sub    %eax,%edx
 1b2:	89 d0                	mov    %edx,%eax
}
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    

000001b6 <strlen>:

uint
strlen(char *s)
{
 1b6:	55                   	push   %ebp
 1b7:	89 e5                	mov    %esp,%ebp
 1b9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c3:	eb 04                	jmp    1c9 <strlen+0x13>
 1c5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	01 d0                	add    %edx,%eax
 1d1:	0f b6 00             	movzbl (%eax),%eax
 1d4:	84 c0                	test   %al,%al
 1d6:	75 ed                	jne    1c5 <strlen+0xf>
    ;
  return n;
 1d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1db:	c9                   	leave  
 1dc:	c3                   	ret    

000001dd <memset>:

void*
memset(void *dst, int c, uint n)
{
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1e0:	8b 45 10             	mov    0x10(%ebp),%eax
 1e3:	50                   	push   %eax
 1e4:	ff 75 0c             	pushl  0xc(%ebp)
 1e7:	ff 75 08             	pushl  0x8(%ebp)
 1ea:	e8 33 ff ff ff       	call   122 <stosb>
 1ef:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f5:	c9                   	leave  
 1f6:	c3                   	ret    

000001f7 <strchr>:

char*
strchr(const char *s, char c)
{
 1f7:	55                   	push   %ebp
 1f8:	89 e5                	mov    %esp,%ebp
 1fa:	83 ec 04             	sub    $0x4,%esp
 1fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 200:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 203:	eb 14                	jmp    219 <strchr+0x22>
    if(*s == c)
 205:	8b 45 08             	mov    0x8(%ebp),%eax
 208:	0f b6 00             	movzbl (%eax),%eax
 20b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 20e:	75 05                	jne    215 <strchr+0x1e>
      return (char*)s;
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	eb 13                	jmp    228 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 215:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 219:	8b 45 08             	mov    0x8(%ebp),%eax
 21c:	0f b6 00             	movzbl (%eax),%eax
 21f:	84 c0                	test   %al,%al
 221:	75 e2                	jne    205 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 223:	b8 00 00 00 00       	mov    $0x0,%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <gets>:

char*
gets(char *buf, int max)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 230:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 237:	eb 44                	jmp    27d <gets+0x53>
    cc = read(0, &c, 1);
 239:	83 ec 04             	sub    $0x4,%esp
 23c:	6a 01                	push   $0x1
 23e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 241:	50                   	push   %eax
 242:	6a 00                	push   $0x0
 244:	e8 46 01 00 00       	call   38f <read>
 249:	83 c4 10             	add    $0x10,%esp
 24c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 253:	7f 02                	jg     257 <gets+0x2d>
      break;
 255:	eb 31                	jmp    288 <gets+0x5e>
    buf[i++] = c;
 257:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25a:	8d 50 01             	lea    0x1(%eax),%edx
 25d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 260:	89 c2                	mov    %eax,%edx
 262:	8b 45 08             	mov    0x8(%ebp),%eax
 265:	01 c2                	add    %eax,%edx
 267:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 26d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 271:	3c 0a                	cmp    $0xa,%al
 273:	74 13                	je     288 <gets+0x5e>
 275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 279:	3c 0d                	cmp    $0xd,%al
 27b:	74 0b                	je     288 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 280:	83 c0 01             	add    $0x1,%eax
 283:	3b 45 0c             	cmp    0xc(%ebp),%eax
 286:	7c b1                	jl     239 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 288:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	01 d0                	add    %edx,%eax
 290:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 293:	8b 45 08             	mov    0x8(%ebp),%eax
}
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <stat>:

int
stat(char *n, struct stat *st)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29e:	83 ec 08             	sub    $0x8,%esp
 2a1:	6a 00                	push   $0x0
 2a3:	ff 75 08             	pushl  0x8(%ebp)
 2a6:	e8 0c 01 00 00       	call   3b7 <open>
 2ab:	83 c4 10             	add    $0x10,%esp
 2ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b5:	79 07                	jns    2be <stat+0x26>
    return -1;
 2b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bc:	eb 25                	jmp    2e3 <stat+0x4b>
  r = fstat(fd, st);
 2be:	83 ec 08             	sub    $0x8,%esp
 2c1:	ff 75 0c             	pushl  0xc(%ebp)
 2c4:	ff 75 f4             	pushl  -0xc(%ebp)
 2c7:	e8 03 01 00 00       	call   3cf <fstat>
 2cc:	83 c4 10             	add    $0x10,%esp
 2cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d2:	83 ec 0c             	sub    $0xc,%esp
 2d5:	ff 75 f4             	pushl  -0xc(%ebp)
 2d8:	e8 c2 00 00 00       	call   39f <close>
 2dd:	83 c4 10             	add    $0x10,%esp
  return r;
 2e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e3:	c9                   	leave  
 2e4:	c3                   	ret    

000002e5 <atoi>:

int
atoi(const char *s)
{
 2e5:	55                   	push   %ebp
 2e6:	89 e5                	mov    %esp,%ebp
 2e8:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f2:	eb 25                	jmp    319 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f7:	89 d0                	mov    %edx,%eax
 2f9:	c1 e0 02             	shl    $0x2,%eax
 2fc:	01 d0                	add    %edx,%eax
 2fe:	01 c0                	add    %eax,%eax
 300:	89 c1                	mov    %eax,%ecx
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	8d 50 01             	lea    0x1(%eax),%edx
 308:	89 55 08             	mov    %edx,0x8(%ebp)
 30b:	0f b6 00             	movzbl (%eax),%eax
 30e:	0f be c0             	movsbl %al,%eax
 311:	01 c8                	add    %ecx,%eax
 313:	83 e8 30             	sub    $0x30,%eax
 316:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	0f b6 00             	movzbl (%eax),%eax
 31f:	3c 2f                	cmp    $0x2f,%al
 321:	7e 0a                	jle    32d <atoi+0x48>
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	0f b6 00             	movzbl (%eax),%eax
 329:	3c 39                	cmp    $0x39,%al
 32b:	7e c7                	jle    2f4 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 32d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 330:	c9                   	leave  
 331:	c3                   	ret    

00000332 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 332:	55                   	push   %ebp
 333:	89 e5                	mov    %esp,%ebp
 335:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33e:	8b 45 0c             	mov    0xc(%ebp),%eax
 341:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 344:	eb 17                	jmp    35d <memmove+0x2b>
    *dst++ = *src++;
 346:	8b 45 fc             	mov    -0x4(%ebp),%eax
 349:	8d 50 01             	lea    0x1(%eax),%edx
 34c:	89 55 fc             	mov    %edx,-0x4(%ebp)
 34f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 352:	8d 4a 01             	lea    0x1(%edx),%ecx
 355:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 358:	0f b6 12             	movzbl (%edx),%edx
 35b:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35d:	8b 45 10             	mov    0x10(%ebp),%eax
 360:	8d 50 ff             	lea    -0x1(%eax),%edx
 363:	89 55 10             	mov    %edx,0x10(%ebp)
 366:	85 c0                	test   %eax,%eax
 368:	7f dc                	jg     346 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 36a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 36d:	c9                   	leave  
 36e:	c3                   	ret    

0000036f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36f:	b8 01 00 00 00       	mov    $0x1,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <exit>:
SYSCALL(exit)
 377:	b8 02 00 00 00       	mov    $0x2,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <wait>:
SYSCALL(wait)
 37f:	b8 03 00 00 00       	mov    $0x3,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <pipe>:
SYSCALL(pipe)
 387:	b8 04 00 00 00       	mov    $0x4,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <read>:
SYSCALL(read)
 38f:	b8 05 00 00 00       	mov    $0x5,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <write>:
SYSCALL(write)
 397:	b8 10 00 00 00       	mov    $0x10,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <close>:
SYSCALL(close)
 39f:	b8 15 00 00 00       	mov    $0x15,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <kill>:
SYSCALL(kill)
 3a7:	b8 06 00 00 00       	mov    $0x6,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <exec>:
SYSCALL(exec)
 3af:	b8 07 00 00 00       	mov    $0x7,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <open>:
SYSCALL(open)
 3b7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <mknod>:
SYSCALL(mknod)
 3bf:	b8 11 00 00 00       	mov    $0x11,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <unlink>:
SYSCALL(unlink)
 3c7:	b8 12 00 00 00       	mov    $0x12,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <fstat>:
SYSCALL(fstat)
 3cf:	b8 08 00 00 00       	mov    $0x8,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <link>:
SYSCALL(link)
 3d7:	b8 13 00 00 00       	mov    $0x13,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <mkdir>:
SYSCALL(mkdir)
 3df:	b8 14 00 00 00       	mov    $0x14,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <chdir>:
SYSCALL(chdir)
 3e7:	b8 09 00 00 00       	mov    $0x9,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <dup>:
SYSCALL(dup)
 3ef:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <getpid>:
SYSCALL(getpid)
 3f7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <sbrk>:
SYSCALL(sbrk)
 3ff:	b8 0c 00 00 00       	mov    $0xc,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    

00000407 <sleep>:
SYSCALL(sleep)
 407:	b8 0d 00 00 00       	mov    $0xd,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret    

0000040f <uptime>:
SYSCALL(uptime)
 40f:	b8 0e 00 00 00       	mov    $0xe,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <pstat>:
SYSCALL(pstat)
 417:	b8 16 00 00 00       	mov    $0x16,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 41f:	55                   	push   %ebp
 420:	89 e5                	mov    %esp,%ebp
 422:	83 ec 18             	sub    $0x18,%esp
 425:	8b 45 0c             	mov    0xc(%ebp),%eax
 428:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 42b:	83 ec 04             	sub    $0x4,%esp
 42e:	6a 01                	push   $0x1
 430:	8d 45 f4             	lea    -0xc(%ebp),%eax
 433:	50                   	push   %eax
 434:	ff 75 08             	pushl  0x8(%ebp)
 437:	e8 5b ff ff ff       	call   397 <write>
 43c:	83 c4 10             	add    $0x10,%esp
}
 43f:	c9                   	leave  
 440:	c3                   	ret    

00000441 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 441:	55                   	push   %ebp
 442:	89 e5                	mov    %esp,%ebp
 444:	53                   	push   %ebx
 445:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 448:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 44f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 453:	74 17                	je     46c <printint+0x2b>
 455:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 459:	79 11                	jns    46c <printint+0x2b>
    neg = 1;
 45b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 462:	8b 45 0c             	mov    0xc(%ebp),%eax
 465:	f7 d8                	neg    %eax
 467:	89 45 ec             	mov    %eax,-0x14(%ebp)
 46a:	eb 06                	jmp    472 <printint+0x31>
  } else {
    x = xx;
 46c:	8b 45 0c             	mov    0xc(%ebp),%eax
 46f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 472:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 479:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 47c:	8d 41 01             	lea    0x1(%ecx),%eax
 47f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 482:	8b 5d 10             	mov    0x10(%ebp),%ebx
 485:	8b 45 ec             	mov    -0x14(%ebp),%eax
 488:	ba 00 00 00 00       	mov    $0x0,%edx
 48d:	f7 f3                	div    %ebx
 48f:	89 d0                	mov    %edx,%eax
 491:	0f b6 80 44 0b 00 00 	movzbl 0xb44(%eax),%eax
 498:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 49c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 49f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4a2:	ba 00 00 00 00       	mov    $0x0,%edx
 4a7:	f7 f3                	div    %ebx
 4a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b0:	75 c7                	jne    479 <printint+0x38>
  if(neg)
 4b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4b6:	74 0e                	je     4c6 <printint+0x85>
    buf[i++] = '-';
 4b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4bb:	8d 50 01             	lea    0x1(%eax),%edx
 4be:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4c1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4c6:	eb 1d                	jmp    4e5 <printint+0xa4>
    putc(fd, buf[i]);
 4c8:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ce:	01 d0                	add    %edx,%eax
 4d0:	0f b6 00             	movzbl (%eax),%eax
 4d3:	0f be c0             	movsbl %al,%eax
 4d6:	83 ec 08             	sub    $0x8,%esp
 4d9:	50                   	push   %eax
 4da:	ff 75 08             	pushl  0x8(%ebp)
 4dd:	e8 3d ff ff ff       	call   41f <putc>
 4e2:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ed:	79 d9                	jns    4c8 <printint+0x87>
    putc(fd, buf[i]);
}
 4ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4f2:	c9                   	leave  
 4f3:	c3                   	ret    

000004f4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4f4:	55                   	push   %ebp
 4f5:	89 e5                	mov    %esp,%ebp
 4f7:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 501:	8d 45 0c             	lea    0xc(%ebp),%eax
 504:	83 c0 04             	add    $0x4,%eax
 507:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 50a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 511:	e9 59 01 00 00       	jmp    66f <printf+0x17b>
    c = fmt[i] & 0xff;
 516:	8b 55 0c             	mov    0xc(%ebp),%edx
 519:	8b 45 f0             	mov    -0x10(%ebp),%eax
 51c:	01 d0                	add    %edx,%eax
 51e:	0f b6 00             	movzbl (%eax),%eax
 521:	0f be c0             	movsbl %al,%eax
 524:	25 ff 00 00 00       	and    $0xff,%eax
 529:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 52c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 530:	75 2c                	jne    55e <printf+0x6a>
      if(c == '%'){
 532:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 536:	75 0c                	jne    544 <printf+0x50>
        state = '%';
 538:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 53f:	e9 27 01 00 00       	jmp    66b <printf+0x177>
      } else {
        putc(fd, c);
 544:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 547:	0f be c0             	movsbl %al,%eax
 54a:	83 ec 08             	sub    $0x8,%esp
 54d:	50                   	push   %eax
 54e:	ff 75 08             	pushl  0x8(%ebp)
 551:	e8 c9 fe ff ff       	call   41f <putc>
 556:	83 c4 10             	add    $0x10,%esp
 559:	e9 0d 01 00 00       	jmp    66b <printf+0x177>
      }
    } else if(state == '%'){
 55e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 562:	0f 85 03 01 00 00    	jne    66b <printf+0x177>
      if(c == 'd'){
 568:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 56c:	75 1e                	jne    58c <printf+0x98>
        printint(fd, *ap, 10, 1);
 56e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 571:	8b 00                	mov    (%eax),%eax
 573:	6a 01                	push   $0x1
 575:	6a 0a                	push   $0xa
 577:	50                   	push   %eax
 578:	ff 75 08             	pushl  0x8(%ebp)
 57b:	e8 c1 fe ff ff       	call   441 <printint>
 580:	83 c4 10             	add    $0x10,%esp
        ap++;
 583:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 587:	e9 d8 00 00 00       	jmp    664 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 58c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 590:	74 06                	je     598 <printf+0xa4>
 592:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 596:	75 1e                	jne    5b6 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 598:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59b:	8b 00                	mov    (%eax),%eax
 59d:	6a 00                	push   $0x0
 59f:	6a 10                	push   $0x10
 5a1:	50                   	push   %eax
 5a2:	ff 75 08             	pushl  0x8(%ebp)
 5a5:	e8 97 fe ff ff       	call   441 <printint>
 5aa:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5b1:	e9 ae 00 00 00       	jmp    664 <printf+0x170>
      } else if(c == 's'){
 5b6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5ba:	75 43                	jne    5ff <printf+0x10b>
        s = (char*)*ap;
 5bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bf:	8b 00                	mov    (%eax),%eax
 5c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5cc:	75 07                	jne    5d5 <printf+0xe1>
          s = "(null)";
 5ce:	c7 45 f4 ce 08 00 00 	movl   $0x8ce,-0xc(%ebp)
        while(*s != 0){
 5d5:	eb 1c                	jmp    5f3 <printf+0xff>
          putc(fd, *s);
 5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5da:	0f b6 00             	movzbl (%eax),%eax
 5dd:	0f be c0             	movsbl %al,%eax
 5e0:	83 ec 08             	sub    $0x8,%esp
 5e3:	50                   	push   %eax
 5e4:	ff 75 08             	pushl  0x8(%ebp)
 5e7:	e8 33 fe ff ff       	call   41f <putc>
 5ec:	83 c4 10             	add    $0x10,%esp
          s++;
 5ef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5f6:	0f b6 00             	movzbl (%eax),%eax
 5f9:	84 c0                	test   %al,%al
 5fb:	75 da                	jne    5d7 <printf+0xe3>
 5fd:	eb 65                	jmp    664 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ff:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 603:	75 1d                	jne    622 <printf+0x12e>
        putc(fd, *ap);
 605:	8b 45 e8             	mov    -0x18(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	0f be c0             	movsbl %al,%eax
 60d:	83 ec 08             	sub    $0x8,%esp
 610:	50                   	push   %eax
 611:	ff 75 08             	pushl  0x8(%ebp)
 614:	e8 06 fe ff ff       	call   41f <putc>
 619:	83 c4 10             	add    $0x10,%esp
        ap++;
 61c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 620:	eb 42                	jmp    664 <printf+0x170>
      } else if(c == '%'){
 622:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 626:	75 17                	jne    63f <printf+0x14b>
        putc(fd, c);
 628:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62b:	0f be c0             	movsbl %al,%eax
 62e:	83 ec 08             	sub    $0x8,%esp
 631:	50                   	push   %eax
 632:	ff 75 08             	pushl  0x8(%ebp)
 635:	e8 e5 fd ff ff       	call   41f <putc>
 63a:	83 c4 10             	add    $0x10,%esp
 63d:	eb 25                	jmp    664 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63f:	83 ec 08             	sub    $0x8,%esp
 642:	6a 25                	push   $0x25
 644:	ff 75 08             	pushl  0x8(%ebp)
 647:	e8 d3 fd ff ff       	call   41f <putc>
 64c:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 64f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 652:	0f be c0             	movsbl %al,%eax
 655:	83 ec 08             	sub    $0x8,%esp
 658:	50                   	push   %eax
 659:	ff 75 08             	pushl  0x8(%ebp)
 65c:	e8 be fd ff ff       	call   41f <putc>
 661:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 664:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 66f:	8b 55 0c             	mov    0xc(%ebp),%edx
 672:	8b 45 f0             	mov    -0x10(%ebp),%eax
 675:	01 d0                	add    %edx,%eax
 677:	0f b6 00             	movzbl (%eax),%eax
 67a:	84 c0                	test   %al,%al
 67c:	0f 85 94 fe ff ff    	jne    516 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 682:	c9                   	leave  
 683:	c3                   	ret    

00000684 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 684:	55                   	push   %ebp
 685:	89 e5                	mov    %esp,%ebp
 687:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 68a:	8b 45 08             	mov    0x8(%ebp),%eax
 68d:	83 e8 08             	sub    $0x8,%eax
 690:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 693:	a1 88 0b 00 00       	mov    0xb88,%eax
 698:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69b:	eb 24                	jmp    6c1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a5:	77 12                	ja     6b9 <free+0x35>
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ad:	77 24                	ja     6d3 <free+0x4f>
 6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b2:	8b 00                	mov    (%eax),%eax
 6b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b7:	77 1a                	ja     6d3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6c7:	76 d4                	jbe    69d <free+0x19>
 6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cc:	8b 00                	mov    (%eax),%eax
 6ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d1:	76 ca                	jbe    69d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	8b 40 04             	mov    0x4(%eax),%eax
 6d9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e3:	01 c2                	add    %eax,%edx
 6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e8:	8b 00                	mov    (%eax),%eax
 6ea:	39 c2                	cmp    %eax,%edx
 6ec:	75 24                	jne    712 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f1:	8b 50 04             	mov    0x4(%eax),%edx
 6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f7:	8b 00                	mov    (%eax),%eax
 6f9:	8b 40 04             	mov    0x4(%eax),%eax
 6fc:	01 c2                	add    %eax,%edx
 6fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 701:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	8b 00                	mov    (%eax),%eax
 709:	8b 10                	mov    (%eax),%edx
 70b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70e:	89 10                	mov    %edx,(%eax)
 710:	eb 0a                	jmp    71c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 712:	8b 45 fc             	mov    -0x4(%ebp),%eax
 715:	8b 10                	mov    (%eax),%edx
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	8b 40 04             	mov    0x4(%eax),%eax
 722:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 729:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72c:	01 d0                	add    %edx,%eax
 72e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 731:	75 20                	jne    753 <free+0xcf>
    p->s.size += bp->s.size;
 733:	8b 45 fc             	mov    -0x4(%ebp),%eax
 736:	8b 50 04             	mov    0x4(%eax),%edx
 739:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73c:	8b 40 04             	mov    0x4(%eax),%eax
 73f:	01 c2                	add    %eax,%edx
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	8b 10                	mov    (%eax),%edx
 74c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74f:	89 10                	mov    %edx,(%eax)
 751:	eb 08                	jmp    75b <free+0xd7>
  } else
    p->s.ptr = bp;
 753:	8b 45 fc             	mov    -0x4(%ebp),%eax
 756:	8b 55 f8             	mov    -0x8(%ebp),%edx
 759:	89 10                	mov    %edx,(%eax)
  freep = p;
 75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75e:	a3 88 0b 00 00       	mov    %eax,0xb88
}
 763:	c9                   	leave  
 764:	c3                   	ret    

00000765 <morecore>:

static Header*
morecore(uint nu)
{
 765:	55                   	push   %ebp
 766:	89 e5                	mov    %esp,%ebp
 768:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 76b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 772:	77 07                	ja     77b <morecore+0x16>
    nu = 4096;
 774:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 77b:	8b 45 08             	mov    0x8(%ebp),%eax
 77e:	c1 e0 03             	shl    $0x3,%eax
 781:	83 ec 0c             	sub    $0xc,%esp
 784:	50                   	push   %eax
 785:	e8 75 fc ff ff       	call   3ff <sbrk>
 78a:	83 c4 10             	add    $0x10,%esp
 78d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 790:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 794:	75 07                	jne    79d <morecore+0x38>
    return 0;
 796:	b8 00 00 00 00       	mov    $0x0,%eax
 79b:	eb 26                	jmp    7c3 <morecore+0x5e>
  hp = (Header*)p;
 79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a6:	8b 55 08             	mov    0x8(%ebp),%edx
 7a9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7af:	83 c0 08             	add    $0x8,%eax
 7b2:	83 ec 0c             	sub    $0xc,%esp
 7b5:	50                   	push   %eax
 7b6:	e8 c9 fe ff ff       	call   684 <free>
 7bb:	83 c4 10             	add    $0x10,%esp
  return freep;
 7be:	a1 88 0b 00 00       	mov    0xb88,%eax
}
 7c3:	c9                   	leave  
 7c4:	c3                   	ret    

000007c5 <malloc>:

void*
malloc(uint nbytes)
{
 7c5:	55                   	push   %ebp
 7c6:	89 e5                	mov    %esp,%ebp
 7c8:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7cb:	8b 45 08             	mov    0x8(%ebp),%eax
 7ce:	83 c0 07             	add    $0x7,%eax
 7d1:	c1 e8 03             	shr    $0x3,%eax
 7d4:	83 c0 01             	add    $0x1,%eax
 7d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7da:	a1 88 0b 00 00       	mov    0xb88,%eax
 7df:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7e6:	75 23                	jne    80b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7e8:	c7 45 f0 80 0b 00 00 	movl   $0xb80,-0x10(%ebp)
 7ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f2:	a3 88 0b 00 00       	mov    %eax,0xb88
 7f7:	a1 88 0b 00 00       	mov    0xb88,%eax
 7fc:	a3 80 0b 00 00       	mov    %eax,0xb80
    base.s.size = 0;
 801:	c7 05 84 0b 00 00 00 	movl   $0x0,0xb84
 808:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80e:	8b 00                	mov    (%eax),%eax
 810:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	8b 40 04             	mov    0x4(%eax),%eax
 819:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 81c:	72 4d                	jb     86b <malloc+0xa6>
      if(p->s.size == nunits)
 81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 821:	8b 40 04             	mov    0x4(%eax),%eax
 824:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 827:	75 0c                	jne    835 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 829:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82c:	8b 10                	mov    (%eax),%edx
 82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 831:	89 10                	mov    %edx,(%eax)
 833:	eb 26                	jmp    85b <malloc+0x96>
      else {
        p->s.size -= nunits;
 835:	8b 45 f4             	mov    -0xc(%ebp),%eax
 838:	8b 40 04             	mov    0x4(%eax),%eax
 83b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 83e:	89 c2                	mov    %eax,%edx
 840:	8b 45 f4             	mov    -0xc(%ebp),%eax
 843:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 846:	8b 45 f4             	mov    -0xc(%ebp),%eax
 849:	8b 40 04             	mov    0x4(%eax),%eax
 84c:	c1 e0 03             	shl    $0x3,%eax
 84f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 852:	8b 45 f4             	mov    -0xc(%ebp),%eax
 855:	8b 55 ec             	mov    -0x14(%ebp),%edx
 858:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 85b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85e:	a3 88 0b 00 00       	mov    %eax,0xb88
      return (void*)(p + 1);
 863:	8b 45 f4             	mov    -0xc(%ebp),%eax
 866:	83 c0 08             	add    $0x8,%eax
 869:	eb 3b                	jmp    8a6 <malloc+0xe1>
    }
    if(p == freep)
 86b:	a1 88 0b 00 00       	mov    0xb88,%eax
 870:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 873:	75 1e                	jne    893 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 875:	83 ec 0c             	sub    $0xc,%esp
 878:	ff 75 ec             	pushl  -0x14(%ebp)
 87b:	e8 e5 fe ff ff       	call   765 <morecore>
 880:	83 c4 10             	add    $0x10,%esp
 883:	89 45 f4             	mov    %eax,-0xc(%ebp)
 886:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 88a:	75 07                	jne    893 <malloc+0xce>
        return 0;
 88c:	b8 00 00 00 00       	mov    $0x0,%eax
 891:	eb 13                	jmp    8a6 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 893:	8b 45 f4             	mov    -0xc(%ebp),%eax
 896:	89 45 f0             	mov    %eax,-0x10(%ebp)
 899:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89c:	8b 00                	mov    (%eax),%eax
 89e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8a1:	e9 6d ff ff ff       	jmp    813 <malloc+0x4e>
}
 8a6:	c9                   	leave  
 8a7:	c3                   	ret    
