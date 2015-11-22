
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 69                	jmp    8b <wc+0x8b>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 58                	jmp    83 <wc+0x83>
      c++;
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 80 0c 00 00       	add    $0xc80,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 80 0c 00 00       	add    $0xc80,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	83 ec 08             	sub    $0x8,%esp
  53:	50                   	push   %eax
  54:	68 56 09 00 00       	push   $0x956
  59:	e8 47 02 00 00       	call   2a5 <strchr>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	85 c0                	test   %eax,%eax
  63:	74 09                	je     6e <wc+0x6e>
        inword = 0;
  65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6c:	eb 11                	jmp    7f <wc+0x7f>
      else if(!inword){
  6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  72:	75 0b                	jne    7f <wc+0x7f>
        w++;
  74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  89:	7c a0                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8b:	83 ec 04             	sub    $0x4,%esp
  8e:	68 00 02 00 00       	push   $0x200
  93:	68 80 0c 00 00       	push   $0xc80
  98:	ff 75 08             	pushl  0x8(%ebp)
  9b:	e8 9d 03 00 00       	call   43d <read>
  a0:	83 c4 10             	add    $0x10,%esp
  a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b4:	79 1c                	jns    d2 <wc+0xd2>
    printf(1, "wc: read error\n");
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 5c 09 00 00       	push   $0x95c
  be:	6a 01                	push   $0x1
  c0:	e8 dd 04 00 00       	call   5a2 <printf>
  c5:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
  c8:	83 ec 0c             	sub    $0xc,%esp
  cb:	6a 01                	push   $0x1
  cd:	e8 53 03 00 00       	call   425 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  d2:	83 ec 08             	sub    $0x8,%esp
  d5:	ff 75 0c             	pushl  0xc(%ebp)
  d8:	ff 75 e8             	pushl  -0x18(%ebp)
  db:	ff 75 ec             	pushl  -0x14(%ebp)
  de:	ff 75 f0             	pushl  -0x10(%ebp)
  e1:	68 6c 09 00 00       	push   $0x96c
  e6:	6a 01                	push   $0x1
  e8:	e8 b5 04 00 00       	call   5a2 <printf>
  ed:	83 c4 20             	add    $0x20,%esp
}
  f0:	c9                   	leave  
  f1:	c3                   	ret    

000000f2 <main>:

int
main(int argc, char *argv[])
{
  f2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f6:	83 e4 f0             	and    $0xfffffff0,%esp
  f9:	ff 71 fc             	pushl  -0x4(%ecx)
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	53                   	push   %ebx
 100:	51                   	push   %ecx
 101:	83 ec 10             	sub    $0x10,%esp
 104:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
 106:	83 3b 01             	cmpl   $0x1,(%ebx)
 109:	7f 1c                	jg     127 <main+0x35>
    wc(0, "");
 10b:	83 ec 08             	sub    $0x8,%esp
 10e:	68 79 09 00 00       	push   $0x979
 113:	6a 00                	push   $0x0
 115:	e8 e6 fe ff ff       	call   0 <wc>
 11a:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
 11d:	83 ec 0c             	sub    $0xc,%esp
 120:	6a 01                	push   $0x1
 122:	e8 fe 02 00 00       	call   425 <exit>
  }

  for(i = 1; i < argc; i++){
 127:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 12e:	e9 88 00 00 00       	jmp    1bb <main+0xc9>
    if((fd = open(argv[i], 0)) < 0){
 133:	8b 45 f4             	mov    -0xc(%ebp),%eax
 136:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 13d:	8b 43 04             	mov    0x4(%ebx),%eax
 140:	01 d0                	add    %edx,%eax
 142:	8b 00                	mov    (%eax),%eax
 144:	83 ec 08             	sub    $0x8,%esp
 147:	6a 00                	push   $0x0
 149:	50                   	push   %eax
 14a:	e8 16 03 00 00       	call   465 <open>
 14f:	83 c4 10             	add    $0x10,%esp
 152:	89 45 f0             	mov    %eax,-0x10(%ebp)
 155:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 159:	79 2e                	jns    189 <main+0x97>
      printf(1, "wc: cannot open %s\n", argv[i]);
 15b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 165:	8b 43 04             	mov    0x4(%ebx),%eax
 168:	01 d0                	add    %edx,%eax
 16a:	8b 00                	mov    (%eax),%eax
 16c:	83 ec 04             	sub    $0x4,%esp
 16f:	50                   	push   %eax
 170:	68 7a 09 00 00       	push   $0x97a
 175:	6a 01                	push   $0x1
 177:	e8 26 04 00 00       	call   5a2 <printf>
 17c:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
 17f:	83 ec 0c             	sub    $0xc,%esp
 182:	6a 01                	push   $0x1
 184:	e8 9c 02 00 00       	call   425 <exit>
    }
    wc(fd, argv[i]);
 189:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 193:	8b 43 04             	mov    0x4(%ebx),%eax
 196:	01 d0                	add    %edx,%eax
 198:	8b 00                	mov    (%eax),%eax
 19a:	83 ec 08             	sub    $0x8,%esp
 19d:	50                   	push   %eax
 19e:	ff 75 f0             	pushl  -0x10(%ebp)
 1a1:	e8 5a fe ff ff       	call   0 <wc>
 1a6:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1a9:	83 ec 0c             	sub    $0xc,%esp
 1ac:	ff 75 f0             	pushl  -0x10(%ebp)
 1af:	e8 99 02 00 00       	call   44d <close>
 1b4:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    wc(0, "");
    exit(EXIT_STATUS_OK);
  }

  for(i = 1; i < argc; i++){
 1b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1be:	3b 03                	cmp    (%ebx),%eax
 1c0:	0f 8c 6d ff ff ff    	jl     133 <main+0x41>
      exit(EXIT_STATUS_OK);
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit(EXIT_STATUS_OK);
 1c6:	83 ec 0c             	sub    $0xc,%esp
 1c9:	6a 01                	push   $0x1
 1cb:	e8 55 02 00 00       	call   425 <exit>

000001d0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d8:	8b 55 10             	mov    0x10(%ebp),%edx
 1db:	8b 45 0c             	mov    0xc(%ebp),%eax
 1de:	89 cb                	mov    %ecx,%ebx
 1e0:	89 df                	mov    %ebx,%edi
 1e2:	89 d1                	mov    %edx,%ecx
 1e4:	fc                   	cld    
 1e5:	f3 aa                	rep stos %al,%es:(%edi)
 1e7:	89 ca                	mov    %ecx,%edx
 1e9:	89 fb                	mov    %edi,%ebx
 1eb:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1ee:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1f1:	5b                   	pop    %ebx
 1f2:	5f                   	pop    %edi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    

000001f5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1f5:	55                   	push   %ebp
 1f6:	89 e5                	mov    %esp,%ebp
 1f8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 201:	90                   	nop
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	8d 50 01             	lea    0x1(%eax),%edx
 208:	89 55 08             	mov    %edx,0x8(%ebp)
 20b:	8b 55 0c             	mov    0xc(%ebp),%edx
 20e:	8d 4a 01             	lea    0x1(%edx),%ecx
 211:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 214:	0f b6 12             	movzbl (%edx),%edx
 217:	88 10                	mov    %dl,(%eax)
 219:	0f b6 00             	movzbl (%eax),%eax
 21c:	84 c0                	test   %al,%al
 21e:	75 e2                	jne    202 <strcpy+0xd>
    ;
  return os;
 220:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 223:	c9                   	leave  
 224:	c3                   	ret    

00000225 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 225:	55                   	push   %ebp
 226:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 228:	eb 08                	jmp    232 <strcmp+0xd>
    p++, q++;
 22a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 22e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	0f b6 00             	movzbl (%eax),%eax
 238:	84 c0                	test   %al,%al
 23a:	74 10                	je     24c <strcmp+0x27>
 23c:	8b 45 08             	mov    0x8(%ebp),%eax
 23f:	0f b6 10             	movzbl (%eax),%edx
 242:	8b 45 0c             	mov    0xc(%ebp),%eax
 245:	0f b6 00             	movzbl (%eax),%eax
 248:	38 c2                	cmp    %al,%dl
 24a:	74 de                	je     22a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	0f b6 00             	movzbl (%eax),%eax
 252:	0f b6 d0             	movzbl %al,%edx
 255:	8b 45 0c             	mov    0xc(%ebp),%eax
 258:	0f b6 00             	movzbl (%eax),%eax
 25b:	0f b6 c0             	movzbl %al,%eax
 25e:	29 c2                	sub    %eax,%edx
 260:	89 d0                	mov    %edx,%eax
}
 262:	5d                   	pop    %ebp
 263:	c3                   	ret    

00000264 <strlen>:

uint
strlen(char *s)
{
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 26a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 271:	eb 04                	jmp    277 <strlen+0x13>
 273:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 277:	8b 55 fc             	mov    -0x4(%ebp),%edx
 27a:	8b 45 08             	mov    0x8(%ebp),%eax
 27d:	01 d0                	add    %edx,%eax
 27f:	0f b6 00             	movzbl (%eax),%eax
 282:	84 c0                	test   %al,%al
 284:	75 ed                	jne    273 <strlen+0xf>
    ;
  return n;
 286:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <memset>:

void*
memset(void *dst, int c, uint n)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 28e:	8b 45 10             	mov    0x10(%ebp),%eax
 291:	50                   	push   %eax
 292:	ff 75 0c             	pushl  0xc(%ebp)
 295:	ff 75 08             	pushl  0x8(%ebp)
 298:	e8 33 ff ff ff       	call   1d0 <stosb>
 29d:	83 c4 0c             	add    $0xc,%esp
  return dst;
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a3:	c9                   	leave  
 2a4:	c3                   	ret    

000002a5 <strchr>:

char*
strchr(const char *s, char c)
{
 2a5:	55                   	push   %ebp
 2a6:	89 e5                	mov    %esp,%ebp
 2a8:	83 ec 04             	sub    $0x4,%esp
 2ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ae:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2b1:	eb 14                	jmp    2c7 <strchr+0x22>
    if(*s == c)
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	0f b6 00             	movzbl (%eax),%eax
 2b9:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2bc:	75 05                	jne    2c3 <strchr+0x1e>
      return (char*)s;
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
 2c1:	eb 13                	jmp    2d6 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2c3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	0f b6 00             	movzbl (%eax),%eax
 2cd:	84 c0                	test   %al,%al
 2cf:	75 e2                	jne    2b3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2d6:	c9                   	leave  
 2d7:	c3                   	ret    

000002d8 <gets>:

char*
gets(char *buf, int max)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2e5:	eb 44                	jmp    32b <gets+0x53>
    cc = read(0, &c, 1);
 2e7:	83 ec 04             	sub    $0x4,%esp
 2ea:	6a 01                	push   $0x1
 2ec:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2ef:	50                   	push   %eax
 2f0:	6a 00                	push   $0x0
 2f2:	e8 46 01 00 00       	call   43d <read>
 2f7:	83 c4 10             	add    $0x10,%esp
 2fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2fd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 301:	7f 02                	jg     305 <gets+0x2d>
      break;
 303:	eb 31                	jmp    336 <gets+0x5e>
    buf[i++] = c;
 305:	8b 45 f4             	mov    -0xc(%ebp),%eax
 308:	8d 50 01             	lea    0x1(%eax),%edx
 30b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 30e:	89 c2                	mov    %eax,%edx
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	01 c2                	add    %eax,%edx
 315:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 319:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 31b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 31f:	3c 0a                	cmp    $0xa,%al
 321:	74 13                	je     336 <gets+0x5e>
 323:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 327:	3c 0d                	cmp    $0xd,%al
 329:	74 0b                	je     336 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 32b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 32e:	83 c0 01             	add    $0x1,%eax
 331:	3b 45 0c             	cmp    0xc(%ebp),%eax
 334:	7c b1                	jl     2e7 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 336:	8b 55 f4             	mov    -0xc(%ebp),%edx
 339:	8b 45 08             	mov    0x8(%ebp),%eax
 33c:	01 d0                	add    %edx,%eax
 33e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 341:	8b 45 08             	mov    0x8(%ebp),%eax
}
 344:	c9                   	leave  
 345:	c3                   	ret    

00000346 <stat>:

int
stat(char *n, struct stat *st)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 34c:	83 ec 08             	sub    $0x8,%esp
 34f:	6a 00                	push   $0x0
 351:	ff 75 08             	pushl  0x8(%ebp)
 354:	e8 0c 01 00 00       	call   465 <open>
 359:	83 c4 10             	add    $0x10,%esp
 35c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 35f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 363:	79 07                	jns    36c <stat+0x26>
    return -1;
 365:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 36a:	eb 25                	jmp    391 <stat+0x4b>
  r = fstat(fd, st);
 36c:	83 ec 08             	sub    $0x8,%esp
 36f:	ff 75 0c             	pushl  0xc(%ebp)
 372:	ff 75 f4             	pushl  -0xc(%ebp)
 375:	e8 03 01 00 00       	call   47d <fstat>
 37a:	83 c4 10             	add    $0x10,%esp
 37d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 380:	83 ec 0c             	sub    $0xc,%esp
 383:	ff 75 f4             	pushl  -0xc(%ebp)
 386:	e8 c2 00 00 00       	call   44d <close>
 38b:	83 c4 10             	add    $0x10,%esp
  return r;
 38e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 391:	c9                   	leave  
 392:	c3                   	ret    

00000393 <atoi>:

int
atoi(const char *s)
{
 393:	55                   	push   %ebp
 394:	89 e5                	mov    %esp,%ebp
 396:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 399:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3a0:	eb 25                	jmp    3c7 <atoi+0x34>
    n = n*10 + *s++ - '0';
 3a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3a5:	89 d0                	mov    %edx,%eax
 3a7:	c1 e0 02             	shl    $0x2,%eax
 3aa:	01 d0                	add    %edx,%eax
 3ac:	01 c0                	add    %eax,%eax
 3ae:	89 c1                	mov    %eax,%ecx
 3b0:	8b 45 08             	mov    0x8(%ebp),%eax
 3b3:	8d 50 01             	lea    0x1(%eax),%edx
 3b6:	89 55 08             	mov    %edx,0x8(%ebp)
 3b9:	0f b6 00             	movzbl (%eax),%eax
 3bc:	0f be c0             	movsbl %al,%eax
 3bf:	01 c8                	add    %ecx,%eax
 3c1:	83 e8 30             	sub    $0x30,%eax
 3c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3c7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ca:	0f b6 00             	movzbl (%eax),%eax
 3cd:	3c 2f                	cmp    $0x2f,%al
 3cf:	7e 0a                	jle    3db <atoi+0x48>
 3d1:	8b 45 08             	mov    0x8(%ebp),%eax
 3d4:	0f b6 00             	movzbl (%eax),%eax
 3d7:	3c 39                	cmp    $0x39,%al
 3d9:	7e c7                	jle    3a2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3db:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3de:	c9                   	leave  
 3df:	c3                   	ret    

000003e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3e6:	8b 45 08             	mov    0x8(%ebp),%eax
 3e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3f2:	eb 17                	jmp    40b <memmove+0x2b>
    *dst++ = *src++;
 3f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3f7:	8d 50 01             	lea    0x1(%eax),%edx
 3fa:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3fd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 400:	8d 4a 01             	lea    0x1(%edx),%ecx
 403:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 406:	0f b6 12             	movzbl (%edx),%edx
 409:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 40b:	8b 45 10             	mov    0x10(%ebp),%eax
 40e:	8d 50 ff             	lea    -0x1(%eax),%edx
 411:	89 55 10             	mov    %edx,0x10(%ebp)
 414:	85 c0                	test   %eax,%eax
 416:	7f dc                	jg     3f4 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 418:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41b:	c9                   	leave  
 41c:	c3                   	ret    

0000041d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 41d:	b8 01 00 00 00       	mov    $0x1,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <exit>:
SYSCALL(exit)
 425:	b8 02 00 00 00       	mov    $0x2,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <wait>:
SYSCALL(wait)
 42d:	b8 03 00 00 00       	mov    $0x3,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <pipe>:
SYSCALL(pipe)
 435:	b8 04 00 00 00       	mov    $0x4,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <read>:
SYSCALL(read)
 43d:	b8 05 00 00 00       	mov    $0x5,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <write>:
SYSCALL(write)
 445:	b8 10 00 00 00       	mov    $0x10,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <close>:
SYSCALL(close)
 44d:	b8 15 00 00 00       	mov    $0x15,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <kill>:
SYSCALL(kill)
 455:	b8 06 00 00 00       	mov    $0x6,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <exec>:
SYSCALL(exec)
 45d:	b8 07 00 00 00       	mov    $0x7,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <open>:
SYSCALL(open)
 465:	b8 0f 00 00 00       	mov    $0xf,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <mknod>:
SYSCALL(mknod)
 46d:	b8 11 00 00 00       	mov    $0x11,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <unlink>:
SYSCALL(unlink)
 475:	b8 12 00 00 00       	mov    $0x12,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <fstat>:
SYSCALL(fstat)
 47d:	b8 08 00 00 00       	mov    $0x8,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <link>:
SYSCALL(link)
 485:	b8 13 00 00 00       	mov    $0x13,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <mkdir>:
SYSCALL(mkdir)
 48d:	b8 14 00 00 00       	mov    $0x14,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <chdir>:
SYSCALL(chdir)
 495:	b8 09 00 00 00       	mov    $0x9,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret    

0000049d <dup>:
SYSCALL(dup)
 49d:	b8 0a 00 00 00       	mov    $0xa,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret    

000004a5 <getpid>:
SYSCALL(getpid)
 4a5:	b8 0b 00 00 00       	mov    $0xb,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret    

000004ad <sbrk>:
SYSCALL(sbrk)
 4ad:	b8 0c 00 00 00       	mov    $0xc,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret    

000004b5 <sleep>:
SYSCALL(sleep)
 4b5:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret    

000004bd <uptime>:
SYSCALL(uptime)
 4bd:	b8 0e 00 00 00       	mov    $0xe,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret    

000004c5 <pstat>:
SYSCALL(pstat)
 4c5:	b8 16 00 00 00       	mov    $0x16,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret    

000004cd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4cd:	55                   	push   %ebp
 4ce:	89 e5                	mov    %esp,%ebp
 4d0:	83 ec 18             	sub    $0x18,%esp
 4d3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4d9:	83 ec 04             	sub    $0x4,%esp
 4dc:	6a 01                	push   $0x1
 4de:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4e1:	50                   	push   %eax
 4e2:	ff 75 08             	pushl  0x8(%ebp)
 4e5:	e8 5b ff ff ff       	call   445 <write>
 4ea:	83 c4 10             	add    $0x10,%esp
}
 4ed:	c9                   	leave  
 4ee:	c3                   	ret    

000004ef <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4ef:	55                   	push   %ebp
 4f0:	89 e5                	mov    %esp,%ebp
 4f2:	53                   	push   %ebx
 4f3:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4fd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 501:	74 17                	je     51a <printint+0x2b>
 503:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 507:	79 11                	jns    51a <printint+0x2b>
    neg = 1;
 509:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 510:	8b 45 0c             	mov    0xc(%ebp),%eax
 513:	f7 d8                	neg    %eax
 515:	89 45 ec             	mov    %eax,-0x14(%ebp)
 518:	eb 06                	jmp    520 <printint+0x31>
  } else {
    x = xx;
 51a:	8b 45 0c             	mov    0xc(%ebp),%eax
 51d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 520:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 527:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 52a:	8d 41 01             	lea    0x1(%ecx),%eax
 52d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 530:	8b 5d 10             	mov    0x10(%ebp),%ebx
 533:	8b 45 ec             	mov    -0x14(%ebp),%eax
 536:	ba 00 00 00 00       	mov    $0x0,%edx
 53b:	f7 f3                	div    %ebx
 53d:	89 d0                	mov    %edx,%eax
 53f:	0f b6 80 04 0c 00 00 	movzbl 0xc04(%eax),%eax
 546:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 54a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 54d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 550:	ba 00 00 00 00       	mov    $0x0,%edx
 555:	f7 f3                	div    %ebx
 557:	89 45 ec             	mov    %eax,-0x14(%ebp)
 55a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 55e:	75 c7                	jne    527 <printint+0x38>
  if(neg)
 560:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 564:	74 0e                	je     574 <printint+0x85>
    buf[i++] = '-';
 566:	8b 45 f4             	mov    -0xc(%ebp),%eax
 569:	8d 50 01             	lea    0x1(%eax),%edx
 56c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 56f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 574:	eb 1d                	jmp    593 <printint+0xa4>
    putc(fd, buf[i]);
 576:	8d 55 dc             	lea    -0x24(%ebp),%edx
 579:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57c:	01 d0                	add    %edx,%eax
 57e:	0f b6 00             	movzbl (%eax),%eax
 581:	0f be c0             	movsbl %al,%eax
 584:	83 ec 08             	sub    $0x8,%esp
 587:	50                   	push   %eax
 588:	ff 75 08             	pushl  0x8(%ebp)
 58b:	e8 3d ff ff ff       	call   4cd <putc>
 590:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 593:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 597:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 59b:	79 d9                	jns    576 <printint+0x87>
    putc(fd, buf[i]);
}
 59d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5a0:	c9                   	leave  
 5a1:	c3                   	ret    

000005a2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5a2:	55                   	push   %ebp
 5a3:	89 e5                	mov    %esp,%ebp
 5a5:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5a8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5af:	8d 45 0c             	lea    0xc(%ebp),%eax
 5b2:	83 c0 04             	add    $0x4,%eax
 5b5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5bf:	e9 59 01 00 00       	jmp    71d <printf+0x17b>
    c = fmt[i] & 0xff;
 5c4:	8b 55 0c             	mov    0xc(%ebp),%edx
 5c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ca:	01 d0                	add    %edx,%eax
 5cc:	0f b6 00             	movzbl (%eax),%eax
 5cf:	0f be c0             	movsbl %al,%eax
 5d2:	25 ff 00 00 00       	and    $0xff,%eax
 5d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5da:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5de:	75 2c                	jne    60c <printf+0x6a>
      if(c == '%'){
 5e0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5e4:	75 0c                	jne    5f2 <printf+0x50>
        state = '%';
 5e6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5ed:	e9 27 01 00 00       	jmp    719 <printf+0x177>
      } else {
        putc(fd, c);
 5f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f5:	0f be c0             	movsbl %al,%eax
 5f8:	83 ec 08             	sub    $0x8,%esp
 5fb:	50                   	push   %eax
 5fc:	ff 75 08             	pushl  0x8(%ebp)
 5ff:	e8 c9 fe ff ff       	call   4cd <putc>
 604:	83 c4 10             	add    $0x10,%esp
 607:	e9 0d 01 00 00       	jmp    719 <printf+0x177>
      }
    } else if(state == '%'){
 60c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 610:	0f 85 03 01 00 00    	jne    719 <printf+0x177>
      if(c == 'd'){
 616:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 61a:	75 1e                	jne    63a <printf+0x98>
        printint(fd, *ap, 10, 1);
 61c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 61f:	8b 00                	mov    (%eax),%eax
 621:	6a 01                	push   $0x1
 623:	6a 0a                	push   $0xa
 625:	50                   	push   %eax
 626:	ff 75 08             	pushl  0x8(%ebp)
 629:	e8 c1 fe ff ff       	call   4ef <printint>
 62e:	83 c4 10             	add    $0x10,%esp
        ap++;
 631:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 635:	e9 d8 00 00 00       	jmp    712 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 63a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 63e:	74 06                	je     646 <printf+0xa4>
 640:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 644:	75 1e                	jne    664 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 646:	8b 45 e8             	mov    -0x18(%ebp),%eax
 649:	8b 00                	mov    (%eax),%eax
 64b:	6a 00                	push   $0x0
 64d:	6a 10                	push   $0x10
 64f:	50                   	push   %eax
 650:	ff 75 08             	pushl  0x8(%ebp)
 653:	e8 97 fe ff ff       	call   4ef <printint>
 658:	83 c4 10             	add    $0x10,%esp
        ap++;
 65b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 65f:	e9 ae 00 00 00       	jmp    712 <printf+0x170>
      } else if(c == 's'){
 664:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 668:	75 43                	jne    6ad <printf+0x10b>
        s = (char*)*ap;
 66a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66d:	8b 00                	mov    (%eax),%eax
 66f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 672:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 676:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 67a:	75 07                	jne    683 <printf+0xe1>
          s = "(null)";
 67c:	c7 45 f4 8e 09 00 00 	movl   $0x98e,-0xc(%ebp)
        while(*s != 0){
 683:	eb 1c                	jmp    6a1 <printf+0xff>
          putc(fd, *s);
 685:	8b 45 f4             	mov    -0xc(%ebp),%eax
 688:	0f b6 00             	movzbl (%eax),%eax
 68b:	0f be c0             	movsbl %al,%eax
 68e:	83 ec 08             	sub    $0x8,%esp
 691:	50                   	push   %eax
 692:	ff 75 08             	pushl  0x8(%ebp)
 695:	e8 33 fe ff ff       	call   4cd <putc>
 69a:	83 c4 10             	add    $0x10,%esp
          s++;
 69d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6a4:	0f b6 00             	movzbl (%eax),%eax
 6a7:	84 c0                	test   %al,%al
 6a9:	75 da                	jne    685 <printf+0xe3>
 6ab:	eb 65                	jmp    712 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ad:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6b1:	75 1d                	jne    6d0 <printf+0x12e>
        putc(fd, *ap);
 6b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6b6:	8b 00                	mov    (%eax),%eax
 6b8:	0f be c0             	movsbl %al,%eax
 6bb:	83 ec 08             	sub    $0x8,%esp
 6be:	50                   	push   %eax
 6bf:	ff 75 08             	pushl  0x8(%ebp)
 6c2:	e8 06 fe ff ff       	call   4cd <putc>
 6c7:	83 c4 10             	add    $0x10,%esp
        ap++;
 6ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6ce:	eb 42                	jmp    712 <printf+0x170>
      } else if(c == '%'){
 6d0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6d4:	75 17                	jne    6ed <printf+0x14b>
        putc(fd, c);
 6d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d9:	0f be c0             	movsbl %al,%eax
 6dc:	83 ec 08             	sub    $0x8,%esp
 6df:	50                   	push   %eax
 6e0:	ff 75 08             	pushl  0x8(%ebp)
 6e3:	e8 e5 fd ff ff       	call   4cd <putc>
 6e8:	83 c4 10             	add    $0x10,%esp
 6eb:	eb 25                	jmp    712 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ed:	83 ec 08             	sub    $0x8,%esp
 6f0:	6a 25                	push   $0x25
 6f2:	ff 75 08             	pushl  0x8(%ebp)
 6f5:	e8 d3 fd ff ff       	call   4cd <putc>
 6fa:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 700:	0f be c0             	movsbl %al,%eax
 703:	83 ec 08             	sub    $0x8,%esp
 706:	50                   	push   %eax
 707:	ff 75 08             	pushl  0x8(%ebp)
 70a:	e8 be fd ff ff       	call   4cd <putc>
 70f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 712:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 719:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 71d:	8b 55 0c             	mov    0xc(%ebp),%edx
 720:	8b 45 f0             	mov    -0x10(%ebp),%eax
 723:	01 d0                	add    %edx,%eax
 725:	0f b6 00             	movzbl (%eax),%eax
 728:	84 c0                	test   %al,%al
 72a:	0f 85 94 fe ff ff    	jne    5c4 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 730:	c9                   	leave  
 731:	c3                   	ret    

00000732 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 732:	55                   	push   %ebp
 733:	89 e5                	mov    %esp,%ebp
 735:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 738:	8b 45 08             	mov    0x8(%ebp),%eax
 73b:	83 e8 08             	sub    $0x8,%eax
 73e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 48 0c 00 00       	mov    0xc48,%eax
 746:	89 45 fc             	mov    %eax,-0x4(%ebp)
 749:	eb 24                	jmp    76f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74e:	8b 00                	mov    (%eax),%eax
 750:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 753:	77 12                	ja     767 <free+0x35>
 755:	8b 45 f8             	mov    -0x8(%ebp),%eax
 758:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 75b:	77 24                	ja     781 <free+0x4f>
 75d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 760:	8b 00                	mov    (%eax),%eax
 762:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 765:	77 1a                	ja     781 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 767:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76a:	8b 00                	mov    (%eax),%eax
 76c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 76f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 772:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 775:	76 d4                	jbe    74b <free+0x19>
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 00                	mov    (%eax),%eax
 77c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 77f:	76 ca                	jbe    74b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 781:	8b 45 f8             	mov    -0x8(%ebp),%eax
 784:	8b 40 04             	mov    0x4(%eax),%eax
 787:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 78e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 791:	01 c2                	add    %eax,%edx
 793:	8b 45 fc             	mov    -0x4(%ebp),%eax
 796:	8b 00                	mov    (%eax),%eax
 798:	39 c2                	cmp    %eax,%edx
 79a:	75 24                	jne    7c0 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 79c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79f:	8b 50 04             	mov    0x4(%eax),%edx
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 00                	mov    (%eax),%eax
 7a7:	8b 40 04             	mov    0x4(%eax),%eax
 7aa:	01 c2                	add    %eax,%edx
 7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7af:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b5:	8b 00                	mov    (%eax),%eax
 7b7:	8b 10                	mov    (%eax),%edx
 7b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bc:	89 10                	mov    %edx,(%eax)
 7be:	eb 0a                	jmp    7ca <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	8b 10                	mov    (%eax),%edx
 7c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c8:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	8b 40 04             	mov    0x4(%eax),%eax
 7d0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7da:	01 d0                	add    %edx,%eax
 7dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7df:	75 20                	jne    801 <free+0xcf>
    p->s.size += bp->s.size;
 7e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e4:	8b 50 04             	mov    0x4(%eax),%edx
 7e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ea:	8b 40 04             	mov    0x4(%eax),%eax
 7ed:	01 c2                	add    %eax,%edx
 7ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f8:	8b 10                	mov    (%eax),%edx
 7fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fd:	89 10                	mov    %edx,(%eax)
 7ff:	eb 08                	jmp    809 <free+0xd7>
  } else
    p->s.ptr = bp;
 801:	8b 45 fc             	mov    -0x4(%ebp),%eax
 804:	8b 55 f8             	mov    -0x8(%ebp),%edx
 807:	89 10                	mov    %edx,(%eax)
  freep = p;
 809:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80c:	a3 48 0c 00 00       	mov    %eax,0xc48
}
 811:	c9                   	leave  
 812:	c3                   	ret    

00000813 <morecore>:

static Header*
morecore(uint nu)
{
 813:	55                   	push   %ebp
 814:	89 e5                	mov    %esp,%ebp
 816:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 819:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 820:	77 07                	ja     829 <morecore+0x16>
    nu = 4096;
 822:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 829:	8b 45 08             	mov    0x8(%ebp),%eax
 82c:	c1 e0 03             	shl    $0x3,%eax
 82f:	83 ec 0c             	sub    $0xc,%esp
 832:	50                   	push   %eax
 833:	e8 75 fc ff ff       	call   4ad <sbrk>
 838:	83 c4 10             	add    $0x10,%esp
 83b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 83e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 842:	75 07                	jne    84b <morecore+0x38>
    return 0;
 844:	b8 00 00 00 00       	mov    $0x0,%eax
 849:	eb 26                	jmp    871 <morecore+0x5e>
  hp = (Header*)p;
 84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 851:	8b 45 f0             	mov    -0x10(%ebp),%eax
 854:	8b 55 08             	mov    0x8(%ebp),%edx
 857:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 85a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85d:	83 c0 08             	add    $0x8,%eax
 860:	83 ec 0c             	sub    $0xc,%esp
 863:	50                   	push   %eax
 864:	e8 c9 fe ff ff       	call   732 <free>
 869:	83 c4 10             	add    $0x10,%esp
  return freep;
 86c:	a1 48 0c 00 00       	mov    0xc48,%eax
}
 871:	c9                   	leave  
 872:	c3                   	ret    

00000873 <malloc>:

void*
malloc(uint nbytes)
{
 873:	55                   	push   %ebp
 874:	89 e5                	mov    %esp,%ebp
 876:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
 87c:	83 c0 07             	add    $0x7,%eax
 87f:	c1 e8 03             	shr    $0x3,%eax
 882:	83 c0 01             	add    $0x1,%eax
 885:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 888:	a1 48 0c 00 00       	mov    0xc48,%eax
 88d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 890:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 894:	75 23                	jne    8b9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 896:	c7 45 f0 40 0c 00 00 	movl   $0xc40,-0x10(%ebp)
 89d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a0:	a3 48 0c 00 00       	mov    %eax,0xc48
 8a5:	a1 48 0c 00 00       	mov    0xc48,%eax
 8aa:	a3 40 0c 00 00       	mov    %eax,0xc40
    base.s.size = 0;
 8af:	c7 05 44 0c 00 00 00 	movl   $0x0,0xc44
 8b6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bc:	8b 00                	mov    (%eax),%eax
 8be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c4:	8b 40 04             	mov    0x4(%eax),%eax
 8c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8ca:	72 4d                	jb     919 <malloc+0xa6>
      if(p->s.size == nunits)
 8cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cf:	8b 40 04             	mov    0x4(%eax),%eax
 8d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8d5:	75 0c                	jne    8e3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8da:	8b 10                	mov    (%eax),%edx
 8dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8df:	89 10                	mov    %edx,(%eax)
 8e1:	eb 26                	jmp    909 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e6:	8b 40 04             	mov    0x4(%eax),%eax
 8e9:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8ec:	89 c2                	mov    %eax,%edx
 8ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f7:	8b 40 04             	mov    0x4(%eax),%eax
 8fa:	c1 e0 03             	shl    $0x3,%eax
 8fd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 900:	8b 45 f4             	mov    -0xc(%ebp),%eax
 903:	8b 55 ec             	mov    -0x14(%ebp),%edx
 906:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 909:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90c:	a3 48 0c 00 00       	mov    %eax,0xc48
      return (void*)(p + 1);
 911:	8b 45 f4             	mov    -0xc(%ebp),%eax
 914:	83 c0 08             	add    $0x8,%eax
 917:	eb 3b                	jmp    954 <malloc+0xe1>
    }
    if(p == freep)
 919:	a1 48 0c 00 00       	mov    0xc48,%eax
 91e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 921:	75 1e                	jne    941 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 923:	83 ec 0c             	sub    $0xc,%esp
 926:	ff 75 ec             	pushl  -0x14(%ebp)
 929:	e8 e5 fe ff ff       	call   813 <morecore>
 92e:	83 c4 10             	add    $0x10,%esp
 931:	89 45 f4             	mov    %eax,-0xc(%ebp)
 934:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 938:	75 07                	jne    941 <malloc+0xce>
        return 0;
 93a:	b8 00 00 00 00       	mov    $0x0,%eax
 93f:	eb 13                	jmp    954 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 941:	8b 45 f4             	mov    -0xc(%ebp),%eax
 944:	89 45 f0             	mov    %eax,-0x10(%ebp)
 947:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94a:	8b 00                	mov    (%eax),%eax
 94c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 94f:	e9 6d ff ff ff       	jmp    8c1 <malloc+0x4e>
}
 954:	c9                   	leave  
 955:	c3                   	ret    
