
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
  14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
  1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
  22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 e4 08 00 00       	push   $0x8e4
  30:	6a 01                	push   $0x1
  32:	e8 f9 04 00 00       	call   530 <printf>
  37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  3a:	83 ec 04             	sub    $0x4,%esp
  3d:	68 00 02 00 00       	push   $0x200
  42:	6a 61                	push   $0x61
  44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  4a:	50                   	push   %eax
  4b:	e8 c9 01 00 00       	call   219 <memset>
  50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  5a:	eb 0f                	jmp    6b <main+0x6b>
    if(fork() > 0)
  5c:	e8 4a 03 00 00       	call   3ab <fork>
  61:	85 c0                	test   %eax,%eax
  63:	7e 02                	jle    67 <main+0x67>
      break;
  65:	eb 0a                	jmp    71 <main+0x71>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  67:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  6b:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
  6f:	7e eb                	jle    5c <main+0x5c>
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  71:	83 ec 04             	sub    $0x4,%esp
  74:	ff 75 f4             	pushl  -0xc(%ebp)
  77:	68 f7 08 00 00       	push   $0x8f7
  7c:	6a 01                	push   $0x1
  7e:	e8 ad 04 00 00       	call   530 <printf>
  83:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  86:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  8a:	89 c2                	mov    %eax,%edx
  8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8f:	01 d0                	add    %edx,%eax
  91:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  94:	83 ec 08             	sub    $0x8,%esp
  97:	68 02 02 00 00       	push   $0x202
  9c:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  9f:	50                   	push   %eax
  a0:	e8 4e 03 00 00       	call   3f3 <open>
  a5:	83 c4 10             	add    $0x10,%esp
  a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
  ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  b2:	eb 1e                	jmp    d2 <main+0xd2>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b4:	83 ec 04             	sub    $0x4,%esp
  b7:	68 00 02 00 00       	push   $0x200
  bc:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  c2:	50                   	push   %eax
  c3:	ff 75 f0             	pushl  -0x10(%ebp)
  c6:	e8 08 03 00 00       	call   3d3 <write>
  cb:	83 c4 10             	add    $0x10,%esp

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  ce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  d2:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  d6:	7e dc                	jle    b4 <main+0xb4>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  d8:	83 ec 0c             	sub    $0xc,%esp
  db:	ff 75 f0             	pushl  -0x10(%ebp)
  de:	e8 f8 02 00 00       	call   3db <close>
  e3:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  e6:	83 ec 08             	sub    $0x8,%esp
  e9:	68 01 09 00 00       	push   $0x901
  ee:	6a 01                	push   $0x1
  f0:	e8 3b 04 00 00       	call   530 <printf>
  f5:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
  f8:	83 ec 08             	sub    $0x8,%esp
  fb:	6a 00                	push   $0x0
  fd:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 100:	50                   	push   %eax
 101:	e8 ed 02 00 00       	call   3f3 <open>
 106:	83 c4 10             	add    $0x10,%esp
 109:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
 10c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 113:	eb 1e                	jmp    133 <main+0x133>
    read(fd, data, sizeof(data));
 115:	83 ec 04             	sub    $0x4,%esp
 118:	68 00 02 00 00       	push   $0x200
 11d:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
 123:	50                   	push   %eax
 124:	ff 75 f0             	pushl  -0x10(%ebp)
 127:	e8 9f 02 00 00       	call   3cb <read>
 12c:	83 c4 10             	add    $0x10,%esp
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 12f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 133:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
 137:	7e dc                	jle    115 <main+0x115>
    read(fd, data, sizeof(data));
  close(fd);
 139:	83 ec 0c             	sub    $0xc,%esp
 13c:	ff 75 f0             	pushl  -0x10(%ebp)
 13f:	e8 97 02 00 00       	call   3db <close>
 144:	83 c4 10             	add    $0x10,%esp

  wait(0);
 147:	83 ec 0c             	sub    $0xc,%esp
 14a:	6a 00                	push   $0x0
 14c:	e8 6a 02 00 00       	call   3bb <wait>
 151:	83 c4 10             	add    $0x10,%esp
  
  exit(EXIT_STATUS_OK);
 154:	83 ec 0c             	sub    $0xc,%esp
 157:	6a 01                	push   $0x1
 159:	e8 55 02 00 00       	call   3b3 <exit>

0000015e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 15e:	55                   	push   %ebp
 15f:	89 e5                	mov    %esp,%ebp
 161:	57                   	push   %edi
 162:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 163:	8b 4d 08             	mov    0x8(%ebp),%ecx
 166:	8b 55 10             	mov    0x10(%ebp),%edx
 169:	8b 45 0c             	mov    0xc(%ebp),%eax
 16c:	89 cb                	mov    %ecx,%ebx
 16e:	89 df                	mov    %ebx,%edi
 170:	89 d1                	mov    %edx,%ecx
 172:	fc                   	cld    
 173:	f3 aa                	rep stos %al,%es:(%edi)
 175:	89 ca                	mov    %ecx,%edx
 177:	89 fb                	mov    %edi,%ebx
 179:	89 5d 08             	mov    %ebx,0x8(%ebp)
 17c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 17f:	5b                   	pop    %ebx
 180:	5f                   	pop    %edi
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    

00000183 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 183:	55                   	push   %ebp
 184:	89 e5                	mov    %esp,%ebp
 186:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 18f:	90                   	nop
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	8d 50 01             	lea    0x1(%eax),%edx
 196:	89 55 08             	mov    %edx,0x8(%ebp)
 199:	8b 55 0c             	mov    0xc(%ebp),%edx
 19c:	8d 4a 01             	lea    0x1(%edx),%ecx
 19f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1a2:	0f b6 12             	movzbl (%edx),%edx
 1a5:	88 10                	mov    %dl,(%eax)
 1a7:	0f b6 00             	movzbl (%eax),%eax
 1aa:	84 c0                	test   %al,%al
 1ac:	75 e2                	jne    190 <strcpy+0xd>
    ;
  return os;
 1ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1b1:	c9                   	leave  
 1b2:	c3                   	ret    

000001b3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1b6:	eb 08                	jmp    1c0 <strcmp+0xd>
    p++, q++;
 1b8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1bc:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	74 10                	je     1da <strcmp+0x27>
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	0f b6 10             	movzbl (%eax),%edx
 1d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d3:	0f b6 00             	movzbl (%eax),%eax
 1d6:	38 c2                	cmp    %al,%dl
 1d8:	74 de                	je     1b8 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1da:	8b 45 08             	mov    0x8(%ebp),%eax
 1dd:	0f b6 00             	movzbl (%eax),%eax
 1e0:	0f b6 d0             	movzbl %al,%edx
 1e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e6:	0f b6 00             	movzbl (%eax),%eax
 1e9:	0f b6 c0             	movzbl %al,%eax
 1ec:	29 c2                	sub    %eax,%edx
 1ee:	89 d0                	mov    %edx,%eax
}
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret    

000001f2 <strlen>:

uint
strlen(char *s)
{
 1f2:	55                   	push   %ebp
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1ff:	eb 04                	jmp    205 <strlen+0x13>
 201:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 205:	8b 55 fc             	mov    -0x4(%ebp),%edx
 208:	8b 45 08             	mov    0x8(%ebp),%eax
 20b:	01 d0                	add    %edx,%eax
 20d:	0f b6 00             	movzbl (%eax),%eax
 210:	84 c0                	test   %al,%al
 212:	75 ed                	jne    201 <strlen+0xf>
    ;
  return n;
 214:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 217:	c9                   	leave  
 218:	c3                   	ret    

00000219 <memset>:

void*
memset(void *dst, int c, uint n)
{
 219:	55                   	push   %ebp
 21a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 21c:	8b 45 10             	mov    0x10(%ebp),%eax
 21f:	50                   	push   %eax
 220:	ff 75 0c             	pushl  0xc(%ebp)
 223:	ff 75 08             	pushl  0x8(%ebp)
 226:	e8 33 ff ff ff       	call   15e <stosb>
 22b:	83 c4 0c             	add    $0xc,%esp
  return dst;
 22e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 231:	c9                   	leave  
 232:	c3                   	ret    

00000233 <strchr>:

char*
strchr(const char *s, char c)
{
 233:	55                   	push   %ebp
 234:	89 e5                	mov    %esp,%ebp
 236:	83 ec 04             	sub    $0x4,%esp
 239:	8b 45 0c             	mov    0xc(%ebp),%eax
 23c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 23f:	eb 14                	jmp    255 <strchr+0x22>
    if(*s == c)
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	0f b6 00             	movzbl (%eax),%eax
 247:	3a 45 fc             	cmp    -0x4(%ebp),%al
 24a:	75 05                	jne    251 <strchr+0x1e>
      return (char*)s;
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	eb 13                	jmp    264 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 251:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 255:	8b 45 08             	mov    0x8(%ebp),%eax
 258:	0f b6 00             	movzbl (%eax),%eax
 25b:	84 c0                	test   %al,%al
 25d:	75 e2                	jne    241 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 25f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 264:	c9                   	leave  
 265:	c3                   	ret    

00000266 <gets>:

char*
gets(char *buf, int max)
{
 266:	55                   	push   %ebp
 267:	89 e5                	mov    %esp,%ebp
 269:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 273:	eb 44                	jmp    2b9 <gets+0x53>
    cc = read(0, &c, 1);
 275:	83 ec 04             	sub    $0x4,%esp
 278:	6a 01                	push   $0x1
 27a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 27d:	50                   	push   %eax
 27e:	6a 00                	push   $0x0
 280:	e8 46 01 00 00       	call   3cb <read>
 285:	83 c4 10             	add    $0x10,%esp
 288:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 28b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 28f:	7f 02                	jg     293 <gets+0x2d>
      break;
 291:	eb 31                	jmp    2c4 <gets+0x5e>
    buf[i++] = c;
 293:	8b 45 f4             	mov    -0xc(%ebp),%eax
 296:	8d 50 01             	lea    0x1(%eax),%edx
 299:	89 55 f4             	mov    %edx,-0xc(%ebp)
 29c:	89 c2                	mov    %eax,%edx
 29e:	8b 45 08             	mov    0x8(%ebp),%eax
 2a1:	01 c2                	add    %eax,%edx
 2a3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a7:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2ad:	3c 0a                	cmp    $0xa,%al
 2af:	74 13                	je     2c4 <gets+0x5e>
 2b1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2b5:	3c 0d                	cmp    $0xd,%al
 2b7:	74 0b                	je     2c4 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2bc:	83 c0 01             	add    $0x1,%eax
 2bf:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2c2:	7c b1                	jl     275 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	01 d0                	add    %edx,%eax
 2cc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d2:	c9                   	leave  
 2d3:	c3                   	ret    

000002d4 <stat>:

int
stat(char *n, struct stat *st)
{
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2da:	83 ec 08             	sub    $0x8,%esp
 2dd:	6a 00                	push   $0x0
 2df:	ff 75 08             	pushl  0x8(%ebp)
 2e2:	e8 0c 01 00 00       	call   3f3 <open>
 2e7:	83 c4 10             	add    $0x10,%esp
 2ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2f1:	79 07                	jns    2fa <stat+0x26>
    return -1;
 2f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2f8:	eb 25                	jmp    31f <stat+0x4b>
  r = fstat(fd, st);
 2fa:	83 ec 08             	sub    $0x8,%esp
 2fd:	ff 75 0c             	pushl  0xc(%ebp)
 300:	ff 75 f4             	pushl  -0xc(%ebp)
 303:	e8 03 01 00 00       	call   40b <fstat>
 308:	83 c4 10             	add    $0x10,%esp
 30b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 30e:	83 ec 0c             	sub    $0xc,%esp
 311:	ff 75 f4             	pushl  -0xc(%ebp)
 314:	e8 c2 00 00 00       	call   3db <close>
 319:	83 c4 10             	add    $0x10,%esp
  return r;
 31c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 31f:	c9                   	leave  
 320:	c3                   	ret    

00000321 <atoi>:

int
atoi(const char *s)
{
 321:	55                   	push   %ebp
 322:	89 e5                	mov    %esp,%ebp
 324:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 327:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 32e:	eb 25                	jmp    355 <atoi+0x34>
    n = n*10 + *s++ - '0';
 330:	8b 55 fc             	mov    -0x4(%ebp),%edx
 333:	89 d0                	mov    %edx,%eax
 335:	c1 e0 02             	shl    $0x2,%eax
 338:	01 d0                	add    %edx,%eax
 33a:	01 c0                	add    %eax,%eax
 33c:	89 c1                	mov    %eax,%ecx
 33e:	8b 45 08             	mov    0x8(%ebp),%eax
 341:	8d 50 01             	lea    0x1(%eax),%edx
 344:	89 55 08             	mov    %edx,0x8(%ebp)
 347:	0f b6 00             	movzbl (%eax),%eax
 34a:	0f be c0             	movsbl %al,%eax
 34d:	01 c8                	add    %ecx,%eax
 34f:	83 e8 30             	sub    $0x30,%eax
 352:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 355:	8b 45 08             	mov    0x8(%ebp),%eax
 358:	0f b6 00             	movzbl (%eax),%eax
 35b:	3c 2f                	cmp    $0x2f,%al
 35d:	7e 0a                	jle    369 <atoi+0x48>
 35f:	8b 45 08             	mov    0x8(%ebp),%eax
 362:	0f b6 00             	movzbl (%eax),%eax
 365:	3c 39                	cmp    $0x39,%al
 367:	7e c7                	jle    330 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 369:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 36c:	c9                   	leave  
 36d:	c3                   	ret    

0000036e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 36e:	55                   	push   %ebp
 36f:	89 e5                	mov    %esp,%ebp
 371:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 374:	8b 45 08             	mov    0x8(%ebp),%eax
 377:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 37a:	8b 45 0c             	mov    0xc(%ebp),%eax
 37d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 380:	eb 17                	jmp    399 <memmove+0x2b>
    *dst++ = *src++;
 382:	8b 45 fc             	mov    -0x4(%ebp),%eax
 385:	8d 50 01             	lea    0x1(%eax),%edx
 388:	89 55 fc             	mov    %edx,-0x4(%ebp)
 38b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 38e:	8d 4a 01             	lea    0x1(%edx),%ecx
 391:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 394:	0f b6 12             	movzbl (%edx),%edx
 397:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 399:	8b 45 10             	mov    0x10(%ebp),%eax
 39c:	8d 50 ff             	lea    -0x1(%eax),%edx
 39f:	89 55 10             	mov    %edx,0x10(%ebp)
 3a2:	85 c0                	test   %eax,%eax
 3a4:	7f dc                	jg     382 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3a9:	c9                   	leave  
 3aa:	c3                   	ret    

000003ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ab:	b8 01 00 00 00       	mov    $0x1,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <exit>:
SYSCALL(exit)
 3b3:	b8 02 00 00 00       	mov    $0x2,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <wait>:
SYSCALL(wait)
 3bb:	b8 03 00 00 00       	mov    $0x3,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <pipe>:
SYSCALL(pipe)
 3c3:	b8 04 00 00 00       	mov    $0x4,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <read>:
SYSCALL(read)
 3cb:	b8 05 00 00 00       	mov    $0x5,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <write>:
SYSCALL(write)
 3d3:	b8 10 00 00 00       	mov    $0x10,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <close>:
SYSCALL(close)
 3db:	b8 15 00 00 00       	mov    $0x15,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <kill>:
SYSCALL(kill)
 3e3:	b8 06 00 00 00       	mov    $0x6,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <exec>:
SYSCALL(exec)
 3eb:	b8 07 00 00 00       	mov    $0x7,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <open>:
SYSCALL(open)
 3f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mknod>:
SYSCALL(mknod)
 3fb:	b8 11 00 00 00       	mov    $0x11,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <unlink>:
SYSCALL(unlink)
 403:	b8 12 00 00 00       	mov    $0x12,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <fstat>:
SYSCALL(fstat)
 40b:	b8 08 00 00 00       	mov    $0x8,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <link>:
SYSCALL(link)
 413:	b8 13 00 00 00       	mov    $0x13,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mkdir>:
SYSCALL(mkdir)
 41b:	b8 14 00 00 00       	mov    $0x14,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <chdir>:
SYSCALL(chdir)
 423:	b8 09 00 00 00       	mov    $0x9,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <dup>:
SYSCALL(dup)
 42b:	b8 0a 00 00 00       	mov    $0xa,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <getpid>:
SYSCALL(getpid)
 433:	b8 0b 00 00 00       	mov    $0xb,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <sbrk>:
SYSCALL(sbrk)
 43b:	b8 0c 00 00 00       	mov    $0xc,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <sleep>:
SYSCALL(sleep)
 443:	b8 0d 00 00 00       	mov    $0xd,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <uptime>:
SYSCALL(uptime)
 44b:	b8 0e 00 00 00       	mov    $0xe,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <pstat>:
SYSCALL(pstat)
 453:	b8 16 00 00 00       	mov    $0x16,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 45b:	55                   	push   %ebp
 45c:	89 e5                	mov    %esp,%ebp
 45e:	83 ec 18             	sub    $0x18,%esp
 461:	8b 45 0c             	mov    0xc(%ebp),%eax
 464:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 467:	83 ec 04             	sub    $0x4,%esp
 46a:	6a 01                	push   $0x1
 46c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 46f:	50                   	push   %eax
 470:	ff 75 08             	pushl  0x8(%ebp)
 473:	e8 5b ff ff ff       	call   3d3 <write>
 478:	83 c4 10             	add    $0x10,%esp
}
 47b:	c9                   	leave  
 47c:	c3                   	ret    

0000047d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 47d:	55                   	push   %ebp
 47e:	89 e5                	mov    %esp,%ebp
 480:	53                   	push   %ebx
 481:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 484:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 48b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 48f:	74 17                	je     4a8 <printint+0x2b>
 491:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 495:	79 11                	jns    4a8 <printint+0x2b>
    neg = 1;
 497:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 49e:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a1:	f7 d8                	neg    %eax
 4a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4a6:	eb 06                	jmp    4ae <printint+0x31>
  } else {
    x = xx;
 4a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4b8:	8d 41 01             	lea    0x1(%ecx),%eax
 4bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4be:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4c4:	ba 00 00 00 00       	mov    $0x0,%edx
 4c9:	f7 f3                	div    %ebx
 4cb:	89 d0                	mov    %edx,%eax
 4cd:	0f b6 80 58 0b 00 00 	movzbl 0xb58(%eax),%eax
 4d4:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4db:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4de:	ba 00 00 00 00       	mov    $0x0,%edx
 4e3:	f7 f3                	div    %ebx
 4e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ec:	75 c7                	jne    4b5 <printint+0x38>
  if(neg)
 4ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4f2:	74 0e                	je     502 <printint+0x85>
    buf[i++] = '-';
 4f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f7:	8d 50 01             	lea    0x1(%eax),%edx
 4fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4fd:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 502:	eb 1d                	jmp    521 <printint+0xa4>
    putc(fd, buf[i]);
 504:	8d 55 dc             	lea    -0x24(%ebp),%edx
 507:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50a:	01 d0                	add    %edx,%eax
 50c:	0f b6 00             	movzbl (%eax),%eax
 50f:	0f be c0             	movsbl %al,%eax
 512:	83 ec 08             	sub    $0x8,%esp
 515:	50                   	push   %eax
 516:	ff 75 08             	pushl  0x8(%ebp)
 519:	e8 3d ff ff ff       	call   45b <putc>
 51e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 521:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 525:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 529:	79 d9                	jns    504 <printint+0x87>
    putc(fd, buf[i]);
}
 52b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 52e:	c9                   	leave  
 52f:	c3                   	ret    

00000530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 536:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 53d:	8d 45 0c             	lea    0xc(%ebp),%eax
 540:	83 c0 04             	add    $0x4,%eax
 543:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 546:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 54d:	e9 59 01 00 00       	jmp    6ab <printf+0x17b>
    c = fmt[i] & 0xff;
 552:	8b 55 0c             	mov    0xc(%ebp),%edx
 555:	8b 45 f0             	mov    -0x10(%ebp),%eax
 558:	01 d0                	add    %edx,%eax
 55a:	0f b6 00             	movzbl (%eax),%eax
 55d:	0f be c0             	movsbl %al,%eax
 560:	25 ff 00 00 00       	and    $0xff,%eax
 565:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 568:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 56c:	75 2c                	jne    59a <printf+0x6a>
      if(c == '%'){
 56e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 572:	75 0c                	jne    580 <printf+0x50>
        state = '%';
 574:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 57b:	e9 27 01 00 00       	jmp    6a7 <printf+0x177>
      } else {
        putc(fd, c);
 580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 583:	0f be c0             	movsbl %al,%eax
 586:	83 ec 08             	sub    $0x8,%esp
 589:	50                   	push   %eax
 58a:	ff 75 08             	pushl  0x8(%ebp)
 58d:	e8 c9 fe ff ff       	call   45b <putc>
 592:	83 c4 10             	add    $0x10,%esp
 595:	e9 0d 01 00 00       	jmp    6a7 <printf+0x177>
      }
    } else if(state == '%'){
 59a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 59e:	0f 85 03 01 00 00    	jne    6a7 <printf+0x177>
      if(c == 'd'){
 5a4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5a8:	75 1e                	jne    5c8 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ad:	8b 00                	mov    (%eax),%eax
 5af:	6a 01                	push   $0x1
 5b1:	6a 0a                	push   $0xa
 5b3:	50                   	push   %eax
 5b4:	ff 75 08             	pushl  0x8(%ebp)
 5b7:	e8 c1 fe ff ff       	call   47d <printint>
 5bc:	83 c4 10             	add    $0x10,%esp
        ap++;
 5bf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c3:	e9 d8 00 00 00       	jmp    6a0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5c8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5cc:	74 06                	je     5d4 <printf+0xa4>
 5ce:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5d2:	75 1e                	jne    5f2 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d7:	8b 00                	mov    (%eax),%eax
 5d9:	6a 00                	push   $0x0
 5db:	6a 10                	push   $0x10
 5dd:	50                   	push   %eax
 5de:	ff 75 08             	pushl  0x8(%ebp)
 5e1:	e8 97 fe ff ff       	call   47d <printint>
 5e6:	83 c4 10             	add    $0x10,%esp
        ap++;
 5e9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ed:	e9 ae 00 00 00       	jmp    6a0 <printf+0x170>
      } else if(c == 's'){
 5f2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5f6:	75 43                	jne    63b <printf+0x10b>
        s = (char*)*ap;
 5f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5fb:	8b 00                	mov    (%eax),%eax
 5fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 600:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 604:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 608:	75 07                	jne    611 <printf+0xe1>
          s = "(null)";
 60a:	c7 45 f4 07 09 00 00 	movl   $0x907,-0xc(%ebp)
        while(*s != 0){
 611:	eb 1c                	jmp    62f <printf+0xff>
          putc(fd, *s);
 613:	8b 45 f4             	mov    -0xc(%ebp),%eax
 616:	0f b6 00             	movzbl (%eax),%eax
 619:	0f be c0             	movsbl %al,%eax
 61c:	83 ec 08             	sub    $0x8,%esp
 61f:	50                   	push   %eax
 620:	ff 75 08             	pushl  0x8(%ebp)
 623:	e8 33 fe ff ff       	call   45b <putc>
 628:	83 c4 10             	add    $0x10,%esp
          s++;
 62b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 62f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 632:	0f b6 00             	movzbl (%eax),%eax
 635:	84 c0                	test   %al,%al
 637:	75 da                	jne    613 <printf+0xe3>
 639:	eb 65                	jmp    6a0 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 63b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 63f:	75 1d                	jne    65e <printf+0x12e>
        putc(fd, *ap);
 641:	8b 45 e8             	mov    -0x18(%ebp),%eax
 644:	8b 00                	mov    (%eax),%eax
 646:	0f be c0             	movsbl %al,%eax
 649:	83 ec 08             	sub    $0x8,%esp
 64c:	50                   	push   %eax
 64d:	ff 75 08             	pushl  0x8(%ebp)
 650:	e8 06 fe ff ff       	call   45b <putc>
 655:	83 c4 10             	add    $0x10,%esp
        ap++;
 658:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 65c:	eb 42                	jmp    6a0 <printf+0x170>
      } else if(c == '%'){
 65e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 662:	75 17                	jne    67b <printf+0x14b>
        putc(fd, c);
 664:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 667:	0f be c0             	movsbl %al,%eax
 66a:	83 ec 08             	sub    $0x8,%esp
 66d:	50                   	push   %eax
 66e:	ff 75 08             	pushl  0x8(%ebp)
 671:	e8 e5 fd ff ff       	call   45b <putc>
 676:	83 c4 10             	add    $0x10,%esp
 679:	eb 25                	jmp    6a0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 67b:	83 ec 08             	sub    $0x8,%esp
 67e:	6a 25                	push   $0x25
 680:	ff 75 08             	pushl  0x8(%ebp)
 683:	e8 d3 fd ff ff       	call   45b <putc>
 688:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 68b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 68e:	0f be c0             	movsbl %al,%eax
 691:	83 ec 08             	sub    $0x8,%esp
 694:	50                   	push   %eax
 695:	ff 75 08             	pushl  0x8(%ebp)
 698:	e8 be fd ff ff       	call   45b <putc>
 69d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6a0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ab:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b1:	01 d0                	add    %edx,%eax
 6b3:	0f b6 00             	movzbl (%eax),%eax
 6b6:	84 c0                	test   %al,%al
 6b8:	0f 85 94 fe ff ff    	jne    552 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6be:	c9                   	leave  
 6bf:	c3                   	ret    

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c6:	8b 45 08             	mov    0x8(%ebp),%eax
 6c9:	83 e8 08             	sub    $0x8,%eax
 6cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6cf:	a1 74 0b 00 00       	mov    0xb74,%eax
 6d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6d7:	eb 24                	jmp    6fd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dc:	8b 00                	mov    (%eax),%eax
 6de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6e1:	77 12                	ja     6f5 <free+0x35>
 6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6e9:	77 24                	ja     70f <free+0x4f>
 6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ee:	8b 00                	mov    (%eax),%eax
 6f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f3:	77 1a                	ja     70f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	8b 00                	mov    (%eax),%eax
 6fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 703:	76 d4                	jbe    6d9 <free+0x19>
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	8b 00                	mov    (%eax),%eax
 70a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70d:	76 ca                	jbe    6d9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 70f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 712:	8b 40 04             	mov    0x4(%eax),%eax
 715:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 71c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71f:	01 c2                	add    %eax,%edx
 721:	8b 45 fc             	mov    -0x4(%ebp),%eax
 724:	8b 00                	mov    (%eax),%eax
 726:	39 c2                	cmp    %eax,%edx
 728:	75 24                	jne    74e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 72a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72d:	8b 50 04             	mov    0x4(%eax),%edx
 730:	8b 45 fc             	mov    -0x4(%ebp),%eax
 733:	8b 00                	mov    (%eax),%eax
 735:	8b 40 04             	mov    0x4(%eax),%eax
 738:	01 c2                	add    %eax,%edx
 73a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 740:	8b 45 fc             	mov    -0x4(%ebp),%eax
 743:	8b 00                	mov    (%eax),%eax
 745:	8b 10                	mov    (%eax),%edx
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	89 10                	mov    %edx,(%eax)
 74c:	eb 0a                	jmp    758 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 74e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 751:	8b 10                	mov    (%eax),%edx
 753:	8b 45 f8             	mov    -0x8(%ebp),%eax
 756:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 758:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75b:	8b 40 04             	mov    0x4(%eax),%eax
 75e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	01 d0                	add    %edx,%eax
 76a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 76d:	75 20                	jne    78f <free+0xcf>
    p->s.size += bp->s.size;
 76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 772:	8b 50 04             	mov    0x4(%eax),%edx
 775:	8b 45 f8             	mov    -0x8(%ebp),%eax
 778:	8b 40 04             	mov    0x4(%eax),%eax
 77b:	01 c2                	add    %eax,%edx
 77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 780:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 783:	8b 45 f8             	mov    -0x8(%ebp),%eax
 786:	8b 10                	mov    (%eax),%edx
 788:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78b:	89 10                	mov    %edx,(%eax)
 78d:	eb 08                	jmp    797 <free+0xd7>
  } else
    p->s.ptr = bp;
 78f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 792:	8b 55 f8             	mov    -0x8(%ebp),%edx
 795:	89 10                	mov    %edx,(%eax)
  freep = p;
 797:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79a:	a3 74 0b 00 00       	mov    %eax,0xb74
}
 79f:	c9                   	leave  
 7a0:	c3                   	ret    

000007a1 <morecore>:

static Header*
morecore(uint nu)
{
 7a1:	55                   	push   %ebp
 7a2:	89 e5                	mov    %esp,%ebp
 7a4:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7a7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7ae:	77 07                	ja     7b7 <morecore+0x16>
    nu = 4096;
 7b0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7b7:	8b 45 08             	mov    0x8(%ebp),%eax
 7ba:	c1 e0 03             	shl    $0x3,%eax
 7bd:	83 ec 0c             	sub    $0xc,%esp
 7c0:	50                   	push   %eax
 7c1:	e8 75 fc ff ff       	call   43b <sbrk>
 7c6:	83 c4 10             	add    $0x10,%esp
 7c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7cc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7d0:	75 07                	jne    7d9 <morecore+0x38>
    return 0;
 7d2:	b8 00 00 00 00       	mov    $0x0,%eax
 7d7:	eb 26                	jmp    7ff <morecore+0x5e>
  hp = (Header*)p;
 7d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e2:	8b 55 08             	mov    0x8(%ebp),%edx
 7e5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7eb:	83 c0 08             	add    $0x8,%eax
 7ee:	83 ec 0c             	sub    $0xc,%esp
 7f1:	50                   	push   %eax
 7f2:	e8 c9 fe ff ff       	call   6c0 <free>
 7f7:	83 c4 10             	add    $0x10,%esp
  return freep;
 7fa:	a1 74 0b 00 00       	mov    0xb74,%eax
}
 7ff:	c9                   	leave  
 800:	c3                   	ret    

00000801 <malloc>:

void*
malloc(uint nbytes)
{
 801:	55                   	push   %ebp
 802:	89 e5                	mov    %esp,%ebp
 804:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 807:	8b 45 08             	mov    0x8(%ebp),%eax
 80a:	83 c0 07             	add    $0x7,%eax
 80d:	c1 e8 03             	shr    $0x3,%eax
 810:	83 c0 01             	add    $0x1,%eax
 813:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 816:	a1 74 0b 00 00       	mov    0xb74,%eax
 81b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 81e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 822:	75 23                	jne    847 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 824:	c7 45 f0 6c 0b 00 00 	movl   $0xb6c,-0x10(%ebp)
 82b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82e:	a3 74 0b 00 00       	mov    %eax,0xb74
 833:	a1 74 0b 00 00       	mov    0xb74,%eax
 838:	a3 6c 0b 00 00       	mov    %eax,0xb6c
    base.s.size = 0;
 83d:	c7 05 70 0b 00 00 00 	movl   $0x0,0xb70
 844:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 847:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84a:	8b 00                	mov    (%eax),%eax
 84c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 84f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 852:	8b 40 04             	mov    0x4(%eax),%eax
 855:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 858:	72 4d                	jb     8a7 <malloc+0xa6>
      if(p->s.size == nunits)
 85a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85d:	8b 40 04             	mov    0x4(%eax),%eax
 860:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 863:	75 0c                	jne    871 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 865:	8b 45 f4             	mov    -0xc(%ebp),%eax
 868:	8b 10                	mov    (%eax),%edx
 86a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86d:	89 10                	mov    %edx,(%eax)
 86f:	eb 26                	jmp    897 <malloc+0x96>
      else {
        p->s.size -= nunits;
 871:	8b 45 f4             	mov    -0xc(%ebp),%eax
 874:	8b 40 04             	mov    0x4(%eax),%eax
 877:	2b 45 ec             	sub    -0x14(%ebp),%eax
 87a:	89 c2                	mov    %eax,%edx
 87c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 882:	8b 45 f4             	mov    -0xc(%ebp),%eax
 885:	8b 40 04             	mov    0x4(%eax),%eax
 888:	c1 e0 03             	shl    $0x3,%eax
 88b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 88e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 891:	8b 55 ec             	mov    -0x14(%ebp),%edx
 894:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 897:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89a:	a3 74 0b 00 00       	mov    %eax,0xb74
      return (void*)(p + 1);
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	83 c0 08             	add    $0x8,%eax
 8a5:	eb 3b                	jmp    8e2 <malloc+0xe1>
    }
    if(p == freep)
 8a7:	a1 74 0b 00 00       	mov    0xb74,%eax
 8ac:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8af:	75 1e                	jne    8cf <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8b1:	83 ec 0c             	sub    $0xc,%esp
 8b4:	ff 75 ec             	pushl  -0x14(%ebp)
 8b7:	e8 e5 fe ff ff       	call   7a1 <morecore>
 8bc:	83 c4 10             	add    $0x10,%esp
 8bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8c6:	75 07                	jne    8cf <malloc+0xce>
        return 0;
 8c8:	b8 00 00 00 00       	mov    $0x0,%eax
 8cd:	eb 13                	jmp    8e2 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d8:	8b 00                	mov    (%eax),%eax
 8da:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8dd:	e9 6d ff ff ff       	jmp    84f <malloc+0x4e>
}
 8e2:	c9                   	leave  
 8e3:	c3                   	ret    
