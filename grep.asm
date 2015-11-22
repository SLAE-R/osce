
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
   d:	e9 ad 00 00 00       	jmp    bf <grep+0xbf>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
  18:	c7 45 f0 40 0e 00 00 	movl   $0xe40,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  1f:	eb 4a                	jmp    6b <grep+0x6b>
      *q = 0;
  21:	8b 45 e8             	mov    -0x18(%ebp),%eax
  24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  27:	83 ec 08             	sub    $0x8,%esp
  2a:	ff 75 f0             	pushl  -0x10(%ebp)
  2d:	ff 75 08             	pushl  0x8(%ebp)
  30:	e8 af 01 00 00       	call   1e4 <match>
  35:	83 c4 10             	add    $0x10,%esp
  38:	85 c0                	test   %eax,%eax
  3a:	74 26                	je     62 <grep+0x62>
        *q = '\n';
  3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  3f:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  42:	8b 45 e8             	mov    -0x18(%ebp),%eax
  45:	83 c0 01             	add    $0x1,%eax
  48:	89 c2                	mov    %eax,%edx
  4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4d:	29 c2                	sub    %eax,%edx
  4f:	89 d0                	mov    %edx,%eax
  51:	83 ec 04             	sub    $0x4,%esp
  54:	50                   	push   %eax
  55:	ff 75 f0             	pushl  -0x10(%ebp)
  58:	6a 01                	push   $0x1
  5a:	e8 56 05 00 00       	call   5b5 <write>
  5f:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  62:	8b 45 e8             	mov    -0x18(%ebp),%eax
  65:	83 c0 01             	add    $0x1,%eax
  68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	6a 0a                	push   $0xa
  70:	ff 75 f0             	pushl  -0x10(%ebp)
  73:	e8 9d 03 00 00       	call   415 <strchr>
  78:	83 c4 10             	add    $0x10,%esp
  7b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  7e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  82:	75 9d                	jne    21 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  84:	81 7d f0 40 0e 00 00 	cmpl   $0xe40,-0x10(%ebp)
  8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
  8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  98:	7e 25                	jle    bf <grep+0xbf>
      m -= p - buf;
  9a:	ba 40 0e 00 00       	mov    $0xe40,%edx
  9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  a2:	29 c2                	sub    %eax,%edx
  a4:	89 d0                	mov    %edx,%eax
  a6:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  a9:	83 ec 04             	sub    $0x4,%esp
  ac:	ff 75 f4             	pushl  -0xc(%ebp)
  af:	ff 75 f0             	pushl  -0x10(%ebp)
  b2:	68 40 0e 00 00       	push   $0xe40
  b7:	e8 94 04 00 00       	call   550 <memmove>
  bc:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c2:	ba 00 04 00 00       	mov    $0x400,%edx
  c7:	29 c2                	sub    %eax,%edx
  c9:	89 d0                	mov    %edx,%eax
  cb:	89 c2                	mov    %eax,%edx
  cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d0:	05 40 0e 00 00       	add    $0xe40,%eax
  d5:	83 ec 04             	sub    $0x4,%esp
  d8:	52                   	push   %edx
  d9:	50                   	push   %eax
  da:	ff 75 0c             	pushl  0xc(%ebp)
  dd:	e8 cb 04 00 00       	call   5ad <read>
  e2:	83 c4 10             	add    $0x10,%esp
  e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  ec:	0f 8f 20 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
  f2:	c9                   	leave  
  f3:	c3                   	ret    

000000f4 <main>:

int
main(int argc, char *argv[])
{
  f4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f8:	83 e4 f0             	and    $0xfffffff0,%esp
  fb:	ff 71 fc             	pushl  -0x4(%ecx)
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	53                   	push   %ebx
 102:	51                   	push   %ecx
 103:	83 ec 10             	sub    $0x10,%esp
 106:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 108:	83 3b 01             	cmpl   $0x1,(%ebx)
 10b:	7f 1c                	jg     129 <main+0x35>
    printf(2, "usage: grep pattern [file ...]\n");
 10d:	83 ec 08             	sub    $0x8,%esp
 110:	68 c8 0a 00 00       	push   $0xac8
 115:	6a 02                	push   $0x2
 117:	e8 f6 05 00 00       	call   712 <printf>
 11c:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
 11f:	83 ec 0c             	sub    $0xc,%esp
 122:	6a 01                	push   $0x1
 124:	e8 6c 04 00 00       	call   595 <exit>
  }
  pattern = argv[1];
 129:	8b 43 04             	mov    0x4(%ebx),%eax
 12c:	8b 40 04             	mov    0x4(%eax),%eax
 12f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
 132:	83 3b 02             	cmpl   $0x2,(%ebx)
 135:	7f 1a                	jg     151 <main+0x5d>
    grep(pattern, 0);
 137:	83 ec 08             	sub    $0x8,%esp
 13a:	6a 00                	push   $0x0
 13c:	ff 75 f0             	pushl  -0x10(%ebp)
 13f:	e8 bc fe ff ff       	call   0 <grep>
 144:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
 147:	83 ec 0c             	sub    $0xc,%esp
 14a:	6a 01                	push   $0x1
 14c:	e8 44 04 00 00       	call   595 <exit>
  }

  for(i = 2; i < argc; i++){
 151:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 158:	eb 79                	jmp    1d3 <main+0xdf>
    if((fd = open(argv[i], 0)) < 0){
 15a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 164:	8b 43 04             	mov    0x4(%ebx),%eax
 167:	01 d0                	add    %edx,%eax
 169:	8b 00                	mov    (%eax),%eax
 16b:	83 ec 08             	sub    $0x8,%esp
 16e:	6a 00                	push   $0x0
 170:	50                   	push   %eax
 171:	e8 5f 04 00 00       	call   5d5 <open>
 176:	83 c4 10             	add    $0x10,%esp
 179:	89 45 ec             	mov    %eax,-0x14(%ebp)
 17c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 180:	79 2e                	jns    1b0 <main+0xbc>
      printf(1, "grep: cannot open %s\n", argv[i]);
 182:	8b 45 f4             	mov    -0xc(%ebp),%eax
 185:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 18c:	8b 43 04             	mov    0x4(%ebx),%eax
 18f:	01 d0                	add    %edx,%eax
 191:	8b 00                	mov    (%eax),%eax
 193:	83 ec 04             	sub    $0x4,%esp
 196:	50                   	push   %eax
 197:	68 e8 0a 00 00       	push   $0xae8
 19c:	6a 01                	push   $0x1
 19e:	e8 6f 05 00 00       	call   712 <printf>
 1a3:	83 c4 10             	add    $0x10,%esp
      exit(EXIT_STATUS_OK);
 1a6:	83 ec 0c             	sub    $0xc,%esp
 1a9:	6a 01                	push   $0x1
 1ab:	e8 e5 03 00 00       	call   595 <exit>
    }
    grep(pattern, fd);
 1b0:	83 ec 08             	sub    $0x8,%esp
 1b3:	ff 75 ec             	pushl  -0x14(%ebp)
 1b6:	ff 75 f0             	pushl  -0x10(%ebp)
 1b9:	e8 42 fe ff ff       	call   0 <grep>
 1be:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1c1:	83 ec 0c             	sub    $0xc,%esp
 1c4:	ff 75 ec             	pushl  -0x14(%ebp)
 1c7:	e8 f1 03 00 00       	call   5bd <close>
 1cc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit(EXIT_STATUS_OK);
  }

  for(i = 2; i < argc; i++){
 1cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d6:	3b 03                	cmp    (%ebx),%eax
 1d8:	7c 80                	jl     15a <main+0x66>
      exit(EXIT_STATUS_OK);
    }
    grep(pattern, fd);
    close(fd);
  }
  exit(EXIT_STATUS_OK);
 1da:	83 ec 0c             	sub    $0xc,%esp
 1dd:	6a 01                	push   $0x1
 1df:	e8 b1 03 00 00       	call   595 <exit>

000001e4 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1ea:	8b 45 08             	mov    0x8(%ebp),%eax
 1ed:	0f b6 00             	movzbl (%eax),%eax
 1f0:	3c 5e                	cmp    $0x5e,%al
 1f2:	75 17                	jne    20b <match+0x27>
    return matchhere(re+1, text);
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
 1f7:	83 c0 01             	add    $0x1,%eax
 1fa:	83 ec 08             	sub    $0x8,%esp
 1fd:	ff 75 0c             	pushl  0xc(%ebp)
 200:	50                   	push   %eax
 201:	e8 38 00 00 00       	call   23e <matchhere>
 206:	83 c4 10             	add    $0x10,%esp
 209:	eb 31                	jmp    23c <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
 20b:	83 ec 08             	sub    $0x8,%esp
 20e:	ff 75 0c             	pushl  0xc(%ebp)
 211:	ff 75 08             	pushl  0x8(%ebp)
 214:	e8 25 00 00 00       	call   23e <matchhere>
 219:	83 c4 10             	add    $0x10,%esp
 21c:	85 c0                	test   %eax,%eax
 21e:	74 07                	je     227 <match+0x43>
      return 1;
 220:	b8 01 00 00 00       	mov    $0x1,%eax
 225:	eb 15                	jmp    23c <match+0x58>
  }while(*text++ != '\0');
 227:	8b 45 0c             	mov    0xc(%ebp),%eax
 22a:	8d 50 01             	lea    0x1(%eax),%edx
 22d:	89 55 0c             	mov    %edx,0xc(%ebp)
 230:	0f b6 00             	movzbl (%eax),%eax
 233:	84 c0                	test   %al,%al
 235:	75 d4                	jne    20b <match+0x27>
  return 0;
 237:	b8 00 00 00 00       	mov    $0x0,%eax
}
 23c:	c9                   	leave  
 23d:	c3                   	ret    

0000023e <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 23e:	55                   	push   %ebp
 23f:	89 e5                	mov    %esp,%ebp
 241:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	0f b6 00             	movzbl (%eax),%eax
 24a:	84 c0                	test   %al,%al
 24c:	75 0a                	jne    258 <matchhere+0x1a>
    return 1;
 24e:	b8 01 00 00 00       	mov    $0x1,%eax
 253:	e9 99 00 00 00       	jmp    2f1 <matchhere+0xb3>
  if(re[1] == '*')
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	83 c0 01             	add    $0x1,%eax
 25e:	0f b6 00             	movzbl (%eax),%eax
 261:	3c 2a                	cmp    $0x2a,%al
 263:	75 21                	jne    286 <matchhere+0x48>
    return matchstar(re[0], re+2, text);
 265:	8b 45 08             	mov    0x8(%ebp),%eax
 268:	8d 50 02             	lea    0x2(%eax),%edx
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	0f be c0             	movsbl %al,%eax
 274:	83 ec 04             	sub    $0x4,%esp
 277:	ff 75 0c             	pushl  0xc(%ebp)
 27a:	52                   	push   %edx
 27b:	50                   	push   %eax
 27c:	e8 72 00 00 00       	call   2f3 <matchstar>
 281:	83 c4 10             	add    $0x10,%esp
 284:	eb 6b                	jmp    2f1 <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	0f b6 00             	movzbl (%eax),%eax
 28c:	3c 24                	cmp    $0x24,%al
 28e:	75 1d                	jne    2ad <matchhere+0x6f>
 290:	8b 45 08             	mov    0x8(%ebp),%eax
 293:	83 c0 01             	add    $0x1,%eax
 296:	0f b6 00             	movzbl (%eax),%eax
 299:	84 c0                	test   %al,%al
 29b:	75 10                	jne    2ad <matchhere+0x6f>
    return *text == '\0';
 29d:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a0:	0f b6 00             	movzbl (%eax),%eax
 2a3:	84 c0                	test   %al,%al
 2a5:	0f 94 c0             	sete   %al
 2a8:	0f b6 c0             	movzbl %al,%eax
 2ab:	eb 44                	jmp    2f1 <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b0:	0f b6 00             	movzbl (%eax),%eax
 2b3:	84 c0                	test   %al,%al
 2b5:	74 35                	je     2ec <matchhere+0xae>
 2b7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ba:	0f b6 00             	movzbl (%eax),%eax
 2bd:	3c 2e                	cmp    $0x2e,%al
 2bf:	74 10                	je     2d1 <matchhere+0x93>
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	0f b6 10             	movzbl (%eax),%edx
 2c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ca:	0f b6 00             	movzbl (%eax),%eax
 2cd:	38 c2                	cmp    %al,%dl
 2cf:	75 1b                	jne    2ec <matchhere+0xae>
    return matchhere(re+1, text+1);
 2d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d4:	8d 50 01             	lea    0x1(%eax),%edx
 2d7:	8b 45 08             	mov    0x8(%ebp),%eax
 2da:	83 c0 01             	add    $0x1,%eax
 2dd:	83 ec 08             	sub    $0x8,%esp
 2e0:	52                   	push   %edx
 2e1:	50                   	push   %eax
 2e2:	e8 57 ff ff ff       	call   23e <matchhere>
 2e7:	83 c4 10             	add    $0x10,%esp
 2ea:	eb 05                	jmp    2f1 <matchhere+0xb3>
  return 0;
 2ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2f1:	c9                   	leave  
 2f2:	c3                   	ret    

000002f3 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2f3:	55                   	push   %ebp
 2f4:	89 e5                	mov    %esp,%ebp
 2f6:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2f9:	83 ec 08             	sub    $0x8,%esp
 2fc:	ff 75 10             	pushl  0x10(%ebp)
 2ff:	ff 75 0c             	pushl  0xc(%ebp)
 302:	e8 37 ff ff ff       	call   23e <matchhere>
 307:	83 c4 10             	add    $0x10,%esp
 30a:	85 c0                	test   %eax,%eax
 30c:	74 07                	je     315 <matchstar+0x22>
      return 1;
 30e:	b8 01 00 00 00       	mov    $0x1,%eax
 313:	eb 29                	jmp    33e <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
 315:	8b 45 10             	mov    0x10(%ebp),%eax
 318:	0f b6 00             	movzbl (%eax),%eax
 31b:	84 c0                	test   %al,%al
 31d:	74 1a                	je     339 <matchstar+0x46>
 31f:	8b 45 10             	mov    0x10(%ebp),%eax
 322:	8d 50 01             	lea    0x1(%eax),%edx
 325:	89 55 10             	mov    %edx,0x10(%ebp)
 328:	0f b6 00             	movzbl (%eax),%eax
 32b:	0f be c0             	movsbl %al,%eax
 32e:	3b 45 08             	cmp    0x8(%ebp),%eax
 331:	74 c6                	je     2f9 <matchstar+0x6>
 333:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 337:	74 c0                	je     2f9 <matchstar+0x6>
  return 0;
 339:	b8 00 00 00 00       	mov    $0x0,%eax
}
 33e:	c9                   	leave  
 33f:	c3                   	ret    

00000340 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 345:	8b 4d 08             	mov    0x8(%ebp),%ecx
 348:	8b 55 10             	mov    0x10(%ebp),%edx
 34b:	8b 45 0c             	mov    0xc(%ebp),%eax
 34e:	89 cb                	mov    %ecx,%ebx
 350:	89 df                	mov    %ebx,%edi
 352:	89 d1                	mov    %edx,%ecx
 354:	fc                   	cld    
 355:	f3 aa                	rep stos %al,%es:(%edi)
 357:	89 ca                	mov    %ecx,%edx
 359:	89 fb                	mov    %edi,%ebx
 35b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 35e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 361:	5b                   	pop    %ebx
 362:	5f                   	pop    %edi
 363:	5d                   	pop    %ebp
 364:	c3                   	ret    

00000365 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 365:	55                   	push   %ebp
 366:	89 e5                	mov    %esp,%ebp
 368:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
 36e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 371:	90                   	nop
 372:	8b 45 08             	mov    0x8(%ebp),%eax
 375:	8d 50 01             	lea    0x1(%eax),%edx
 378:	89 55 08             	mov    %edx,0x8(%ebp)
 37b:	8b 55 0c             	mov    0xc(%ebp),%edx
 37e:	8d 4a 01             	lea    0x1(%edx),%ecx
 381:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 384:	0f b6 12             	movzbl (%edx),%edx
 387:	88 10                	mov    %dl,(%eax)
 389:	0f b6 00             	movzbl (%eax),%eax
 38c:	84 c0                	test   %al,%al
 38e:	75 e2                	jne    372 <strcpy+0xd>
    ;
  return os;
 390:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 393:	c9                   	leave  
 394:	c3                   	ret    

00000395 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 395:	55                   	push   %ebp
 396:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 398:	eb 08                	jmp    3a2 <strcmp+0xd>
    p++, q++;
 39a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 39e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3a2:	8b 45 08             	mov    0x8(%ebp),%eax
 3a5:	0f b6 00             	movzbl (%eax),%eax
 3a8:	84 c0                	test   %al,%al
 3aa:	74 10                	je     3bc <strcmp+0x27>
 3ac:	8b 45 08             	mov    0x8(%ebp),%eax
 3af:	0f b6 10             	movzbl (%eax),%edx
 3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b5:	0f b6 00             	movzbl (%eax),%eax
 3b8:	38 c2                	cmp    %al,%dl
 3ba:	74 de                	je     39a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	0f b6 00             	movzbl (%eax),%eax
 3c2:	0f b6 d0             	movzbl %al,%edx
 3c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c8:	0f b6 00             	movzbl (%eax),%eax
 3cb:	0f b6 c0             	movzbl %al,%eax
 3ce:	29 c2                	sub    %eax,%edx
 3d0:	89 d0                	mov    %edx,%eax
}
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    

000003d4 <strlen>:

uint
strlen(char *s)
{
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3e1:	eb 04                	jmp    3e7 <strlen+0x13>
 3e3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3ea:	8b 45 08             	mov    0x8(%ebp),%eax
 3ed:	01 d0                	add    %edx,%eax
 3ef:	0f b6 00             	movzbl (%eax),%eax
 3f2:	84 c0                	test   %al,%al
 3f4:	75 ed                	jne    3e3 <strlen+0xf>
    ;
  return n;
 3f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3f9:	c9                   	leave  
 3fa:	c3                   	ret    

000003fb <memset>:

void*
memset(void *dst, int c, uint n)
{
 3fb:	55                   	push   %ebp
 3fc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3fe:	8b 45 10             	mov    0x10(%ebp),%eax
 401:	50                   	push   %eax
 402:	ff 75 0c             	pushl  0xc(%ebp)
 405:	ff 75 08             	pushl  0x8(%ebp)
 408:	e8 33 ff ff ff       	call   340 <stosb>
 40d:	83 c4 0c             	add    $0xc,%esp
  return dst;
 410:	8b 45 08             	mov    0x8(%ebp),%eax
}
 413:	c9                   	leave  
 414:	c3                   	ret    

00000415 <strchr>:

char*
strchr(const char *s, char c)
{
 415:	55                   	push   %ebp
 416:	89 e5                	mov    %esp,%ebp
 418:	83 ec 04             	sub    $0x4,%esp
 41b:	8b 45 0c             	mov    0xc(%ebp),%eax
 41e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 421:	eb 14                	jmp    437 <strchr+0x22>
    if(*s == c)
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	0f b6 00             	movzbl (%eax),%eax
 429:	3a 45 fc             	cmp    -0x4(%ebp),%al
 42c:	75 05                	jne    433 <strchr+0x1e>
      return (char*)s;
 42e:	8b 45 08             	mov    0x8(%ebp),%eax
 431:	eb 13                	jmp    446 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 433:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 437:	8b 45 08             	mov    0x8(%ebp),%eax
 43a:	0f b6 00             	movzbl (%eax),%eax
 43d:	84 c0                	test   %al,%al
 43f:	75 e2                	jne    423 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 441:	b8 00 00 00 00       	mov    $0x0,%eax
}
 446:	c9                   	leave  
 447:	c3                   	ret    

00000448 <gets>:

char*
gets(char *buf, int max)
{
 448:	55                   	push   %ebp
 449:	89 e5                	mov    %esp,%ebp
 44b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 44e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 455:	eb 44                	jmp    49b <gets+0x53>
    cc = read(0, &c, 1);
 457:	83 ec 04             	sub    $0x4,%esp
 45a:	6a 01                	push   $0x1
 45c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 45f:	50                   	push   %eax
 460:	6a 00                	push   $0x0
 462:	e8 46 01 00 00       	call   5ad <read>
 467:	83 c4 10             	add    $0x10,%esp
 46a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 46d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 471:	7f 02                	jg     475 <gets+0x2d>
      break;
 473:	eb 31                	jmp    4a6 <gets+0x5e>
    buf[i++] = c;
 475:	8b 45 f4             	mov    -0xc(%ebp),%eax
 478:	8d 50 01             	lea    0x1(%eax),%edx
 47b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 47e:	89 c2                	mov    %eax,%edx
 480:	8b 45 08             	mov    0x8(%ebp),%eax
 483:	01 c2                	add    %eax,%edx
 485:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 489:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 48b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 48f:	3c 0a                	cmp    $0xa,%al
 491:	74 13                	je     4a6 <gets+0x5e>
 493:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 497:	3c 0d                	cmp    $0xd,%al
 499:	74 0b                	je     4a6 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 49b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49e:	83 c0 01             	add    $0x1,%eax
 4a1:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4a4:	7c b1                	jl     457 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4a9:	8b 45 08             	mov    0x8(%ebp),%eax
 4ac:	01 d0                	add    %edx,%eax
 4ae:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4b4:	c9                   	leave  
 4b5:	c3                   	ret    

000004b6 <stat>:

int
stat(char *n, struct stat *st)
{
 4b6:	55                   	push   %ebp
 4b7:	89 e5                	mov    %esp,%ebp
 4b9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4bc:	83 ec 08             	sub    $0x8,%esp
 4bf:	6a 00                	push   $0x0
 4c1:	ff 75 08             	pushl  0x8(%ebp)
 4c4:	e8 0c 01 00 00       	call   5d5 <open>
 4c9:	83 c4 10             	add    $0x10,%esp
 4cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d3:	79 07                	jns    4dc <stat+0x26>
    return -1;
 4d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4da:	eb 25                	jmp    501 <stat+0x4b>
  r = fstat(fd, st);
 4dc:	83 ec 08             	sub    $0x8,%esp
 4df:	ff 75 0c             	pushl  0xc(%ebp)
 4e2:	ff 75 f4             	pushl  -0xc(%ebp)
 4e5:	e8 03 01 00 00       	call   5ed <fstat>
 4ea:	83 c4 10             	add    $0x10,%esp
 4ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4f0:	83 ec 0c             	sub    $0xc,%esp
 4f3:	ff 75 f4             	pushl  -0xc(%ebp)
 4f6:	e8 c2 00 00 00       	call   5bd <close>
 4fb:	83 c4 10             	add    $0x10,%esp
  return r;
 4fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 501:	c9                   	leave  
 502:	c3                   	ret    

00000503 <atoi>:

int
atoi(const char *s)
{
 503:	55                   	push   %ebp
 504:	89 e5                	mov    %esp,%ebp
 506:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 509:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 510:	eb 25                	jmp    537 <atoi+0x34>
    n = n*10 + *s++ - '0';
 512:	8b 55 fc             	mov    -0x4(%ebp),%edx
 515:	89 d0                	mov    %edx,%eax
 517:	c1 e0 02             	shl    $0x2,%eax
 51a:	01 d0                	add    %edx,%eax
 51c:	01 c0                	add    %eax,%eax
 51e:	89 c1                	mov    %eax,%ecx
 520:	8b 45 08             	mov    0x8(%ebp),%eax
 523:	8d 50 01             	lea    0x1(%eax),%edx
 526:	89 55 08             	mov    %edx,0x8(%ebp)
 529:	0f b6 00             	movzbl (%eax),%eax
 52c:	0f be c0             	movsbl %al,%eax
 52f:	01 c8                	add    %ecx,%eax
 531:	83 e8 30             	sub    $0x30,%eax
 534:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 537:	8b 45 08             	mov    0x8(%ebp),%eax
 53a:	0f b6 00             	movzbl (%eax),%eax
 53d:	3c 2f                	cmp    $0x2f,%al
 53f:	7e 0a                	jle    54b <atoi+0x48>
 541:	8b 45 08             	mov    0x8(%ebp),%eax
 544:	0f b6 00             	movzbl (%eax),%eax
 547:	3c 39                	cmp    $0x39,%al
 549:	7e c7                	jle    512 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 54b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 54e:	c9                   	leave  
 54f:	c3                   	ret    

00000550 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 556:	8b 45 08             	mov    0x8(%ebp),%eax
 559:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 55c:	8b 45 0c             	mov    0xc(%ebp),%eax
 55f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 562:	eb 17                	jmp    57b <memmove+0x2b>
    *dst++ = *src++;
 564:	8b 45 fc             	mov    -0x4(%ebp),%eax
 567:	8d 50 01             	lea    0x1(%eax),%edx
 56a:	89 55 fc             	mov    %edx,-0x4(%ebp)
 56d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 570:	8d 4a 01             	lea    0x1(%edx),%ecx
 573:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 576:	0f b6 12             	movzbl (%edx),%edx
 579:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 57b:	8b 45 10             	mov    0x10(%ebp),%eax
 57e:	8d 50 ff             	lea    -0x1(%eax),%edx
 581:	89 55 10             	mov    %edx,0x10(%ebp)
 584:	85 c0                	test   %eax,%eax
 586:	7f dc                	jg     564 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 588:	8b 45 08             	mov    0x8(%ebp),%eax
}
 58b:	c9                   	leave  
 58c:	c3                   	ret    

0000058d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 58d:	b8 01 00 00 00       	mov    $0x1,%eax
 592:	cd 40                	int    $0x40
 594:	c3                   	ret    

00000595 <exit>:
SYSCALL(exit)
 595:	b8 02 00 00 00       	mov    $0x2,%eax
 59a:	cd 40                	int    $0x40
 59c:	c3                   	ret    

0000059d <wait>:
SYSCALL(wait)
 59d:	b8 03 00 00 00       	mov    $0x3,%eax
 5a2:	cd 40                	int    $0x40
 5a4:	c3                   	ret    

000005a5 <pipe>:
SYSCALL(pipe)
 5a5:	b8 04 00 00 00       	mov    $0x4,%eax
 5aa:	cd 40                	int    $0x40
 5ac:	c3                   	ret    

000005ad <read>:
SYSCALL(read)
 5ad:	b8 05 00 00 00       	mov    $0x5,%eax
 5b2:	cd 40                	int    $0x40
 5b4:	c3                   	ret    

000005b5 <write>:
SYSCALL(write)
 5b5:	b8 10 00 00 00       	mov    $0x10,%eax
 5ba:	cd 40                	int    $0x40
 5bc:	c3                   	ret    

000005bd <close>:
SYSCALL(close)
 5bd:	b8 15 00 00 00       	mov    $0x15,%eax
 5c2:	cd 40                	int    $0x40
 5c4:	c3                   	ret    

000005c5 <kill>:
SYSCALL(kill)
 5c5:	b8 06 00 00 00       	mov    $0x6,%eax
 5ca:	cd 40                	int    $0x40
 5cc:	c3                   	ret    

000005cd <exec>:
SYSCALL(exec)
 5cd:	b8 07 00 00 00       	mov    $0x7,%eax
 5d2:	cd 40                	int    $0x40
 5d4:	c3                   	ret    

000005d5 <open>:
SYSCALL(open)
 5d5:	b8 0f 00 00 00       	mov    $0xf,%eax
 5da:	cd 40                	int    $0x40
 5dc:	c3                   	ret    

000005dd <mknod>:
SYSCALL(mknod)
 5dd:	b8 11 00 00 00       	mov    $0x11,%eax
 5e2:	cd 40                	int    $0x40
 5e4:	c3                   	ret    

000005e5 <unlink>:
SYSCALL(unlink)
 5e5:	b8 12 00 00 00       	mov    $0x12,%eax
 5ea:	cd 40                	int    $0x40
 5ec:	c3                   	ret    

000005ed <fstat>:
SYSCALL(fstat)
 5ed:	b8 08 00 00 00       	mov    $0x8,%eax
 5f2:	cd 40                	int    $0x40
 5f4:	c3                   	ret    

000005f5 <link>:
SYSCALL(link)
 5f5:	b8 13 00 00 00       	mov    $0x13,%eax
 5fa:	cd 40                	int    $0x40
 5fc:	c3                   	ret    

000005fd <mkdir>:
SYSCALL(mkdir)
 5fd:	b8 14 00 00 00       	mov    $0x14,%eax
 602:	cd 40                	int    $0x40
 604:	c3                   	ret    

00000605 <chdir>:
SYSCALL(chdir)
 605:	b8 09 00 00 00       	mov    $0x9,%eax
 60a:	cd 40                	int    $0x40
 60c:	c3                   	ret    

0000060d <dup>:
SYSCALL(dup)
 60d:	b8 0a 00 00 00       	mov    $0xa,%eax
 612:	cd 40                	int    $0x40
 614:	c3                   	ret    

00000615 <getpid>:
SYSCALL(getpid)
 615:	b8 0b 00 00 00       	mov    $0xb,%eax
 61a:	cd 40                	int    $0x40
 61c:	c3                   	ret    

0000061d <sbrk>:
SYSCALL(sbrk)
 61d:	b8 0c 00 00 00       	mov    $0xc,%eax
 622:	cd 40                	int    $0x40
 624:	c3                   	ret    

00000625 <sleep>:
SYSCALL(sleep)
 625:	b8 0d 00 00 00       	mov    $0xd,%eax
 62a:	cd 40                	int    $0x40
 62c:	c3                   	ret    

0000062d <uptime>:
SYSCALL(uptime)
 62d:	b8 0e 00 00 00       	mov    $0xe,%eax
 632:	cd 40                	int    $0x40
 634:	c3                   	ret    

00000635 <pstat>:
SYSCALL(pstat)
 635:	b8 16 00 00 00       	mov    $0x16,%eax
 63a:	cd 40                	int    $0x40
 63c:	c3                   	ret    

0000063d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 63d:	55                   	push   %ebp
 63e:	89 e5                	mov    %esp,%ebp
 640:	83 ec 18             	sub    $0x18,%esp
 643:	8b 45 0c             	mov    0xc(%ebp),%eax
 646:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 649:	83 ec 04             	sub    $0x4,%esp
 64c:	6a 01                	push   $0x1
 64e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 651:	50                   	push   %eax
 652:	ff 75 08             	pushl  0x8(%ebp)
 655:	e8 5b ff ff ff       	call   5b5 <write>
 65a:	83 c4 10             	add    $0x10,%esp
}
 65d:	c9                   	leave  
 65e:	c3                   	ret    

0000065f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 65f:	55                   	push   %ebp
 660:	89 e5                	mov    %esp,%ebp
 662:	53                   	push   %ebx
 663:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 666:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 66d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 671:	74 17                	je     68a <printint+0x2b>
 673:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 677:	79 11                	jns    68a <printint+0x2b>
    neg = 1;
 679:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 680:	8b 45 0c             	mov    0xc(%ebp),%eax
 683:	f7 d8                	neg    %eax
 685:	89 45 ec             	mov    %eax,-0x14(%ebp)
 688:	eb 06                	jmp    690 <printint+0x31>
  } else {
    x = xx;
 68a:	8b 45 0c             	mov    0xc(%ebp),%eax
 68d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 690:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 697:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 69a:	8d 41 01             	lea    0x1(%ecx),%eax
 69d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6a6:	ba 00 00 00 00       	mov    $0x0,%edx
 6ab:	f7 f3                	div    %ebx
 6ad:	89 d0                	mov    %edx,%eax
 6af:	0f b6 80 d4 0d 00 00 	movzbl 0xdd4(%eax),%eax
 6b6:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 6ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6c0:	ba 00 00 00 00       	mov    $0x0,%edx
 6c5:	f7 f3                	div    %ebx
 6c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6ca:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6ce:	75 c7                	jne    697 <printint+0x38>
  if(neg)
 6d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6d4:	74 0e                	je     6e4 <printint+0x85>
    buf[i++] = '-';
 6d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6d9:	8d 50 01             	lea    0x1(%eax),%edx
 6dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6df:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6e4:	eb 1d                	jmp    703 <printint+0xa4>
    putc(fd, buf[i]);
 6e6:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ec:	01 d0                	add    %edx,%eax
 6ee:	0f b6 00             	movzbl (%eax),%eax
 6f1:	0f be c0             	movsbl %al,%eax
 6f4:	83 ec 08             	sub    $0x8,%esp
 6f7:	50                   	push   %eax
 6f8:	ff 75 08             	pushl  0x8(%ebp)
 6fb:	e8 3d ff ff ff       	call   63d <putc>
 700:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 703:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 707:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 70b:	79 d9                	jns    6e6 <printint+0x87>
    putc(fd, buf[i]);
}
 70d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 710:	c9                   	leave  
 711:	c3                   	ret    

00000712 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 712:	55                   	push   %ebp
 713:	89 e5                	mov    %esp,%ebp
 715:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 718:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 71f:	8d 45 0c             	lea    0xc(%ebp),%eax
 722:	83 c0 04             	add    $0x4,%eax
 725:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 728:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 72f:	e9 59 01 00 00       	jmp    88d <printf+0x17b>
    c = fmt[i] & 0xff;
 734:	8b 55 0c             	mov    0xc(%ebp),%edx
 737:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73a:	01 d0                	add    %edx,%eax
 73c:	0f b6 00             	movzbl (%eax),%eax
 73f:	0f be c0             	movsbl %al,%eax
 742:	25 ff 00 00 00       	and    $0xff,%eax
 747:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 74a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 74e:	75 2c                	jne    77c <printf+0x6a>
      if(c == '%'){
 750:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 754:	75 0c                	jne    762 <printf+0x50>
        state = '%';
 756:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 75d:	e9 27 01 00 00       	jmp    889 <printf+0x177>
      } else {
        putc(fd, c);
 762:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 765:	0f be c0             	movsbl %al,%eax
 768:	83 ec 08             	sub    $0x8,%esp
 76b:	50                   	push   %eax
 76c:	ff 75 08             	pushl  0x8(%ebp)
 76f:	e8 c9 fe ff ff       	call   63d <putc>
 774:	83 c4 10             	add    $0x10,%esp
 777:	e9 0d 01 00 00       	jmp    889 <printf+0x177>
      }
    } else if(state == '%'){
 77c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 780:	0f 85 03 01 00 00    	jne    889 <printf+0x177>
      if(c == 'd'){
 786:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 78a:	75 1e                	jne    7aa <printf+0x98>
        printint(fd, *ap, 10, 1);
 78c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 78f:	8b 00                	mov    (%eax),%eax
 791:	6a 01                	push   $0x1
 793:	6a 0a                	push   $0xa
 795:	50                   	push   %eax
 796:	ff 75 08             	pushl  0x8(%ebp)
 799:	e8 c1 fe ff ff       	call   65f <printint>
 79e:	83 c4 10             	add    $0x10,%esp
        ap++;
 7a1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7a5:	e9 d8 00 00 00       	jmp    882 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 7aa:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7ae:	74 06                	je     7b6 <printf+0xa4>
 7b0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7b4:	75 1e                	jne    7d4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 7b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7b9:	8b 00                	mov    (%eax),%eax
 7bb:	6a 00                	push   $0x0
 7bd:	6a 10                	push   $0x10
 7bf:	50                   	push   %eax
 7c0:	ff 75 08             	pushl  0x8(%ebp)
 7c3:	e8 97 fe ff ff       	call   65f <printint>
 7c8:	83 c4 10             	add    $0x10,%esp
        ap++;
 7cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7cf:	e9 ae 00 00 00       	jmp    882 <printf+0x170>
      } else if(c == 's'){
 7d4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7d8:	75 43                	jne    81d <printf+0x10b>
        s = (char*)*ap;
 7da:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7dd:	8b 00                	mov    (%eax),%eax
 7df:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7ea:	75 07                	jne    7f3 <printf+0xe1>
          s = "(null)";
 7ec:	c7 45 f4 fe 0a 00 00 	movl   $0xafe,-0xc(%ebp)
        while(*s != 0){
 7f3:	eb 1c                	jmp    811 <printf+0xff>
          putc(fd, *s);
 7f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f8:	0f b6 00             	movzbl (%eax),%eax
 7fb:	0f be c0             	movsbl %al,%eax
 7fe:	83 ec 08             	sub    $0x8,%esp
 801:	50                   	push   %eax
 802:	ff 75 08             	pushl  0x8(%ebp)
 805:	e8 33 fe ff ff       	call   63d <putc>
 80a:	83 c4 10             	add    $0x10,%esp
          s++;
 80d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	0f b6 00             	movzbl (%eax),%eax
 817:	84 c0                	test   %al,%al
 819:	75 da                	jne    7f5 <printf+0xe3>
 81b:	eb 65                	jmp    882 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 81d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 821:	75 1d                	jne    840 <printf+0x12e>
        putc(fd, *ap);
 823:	8b 45 e8             	mov    -0x18(%ebp),%eax
 826:	8b 00                	mov    (%eax),%eax
 828:	0f be c0             	movsbl %al,%eax
 82b:	83 ec 08             	sub    $0x8,%esp
 82e:	50                   	push   %eax
 82f:	ff 75 08             	pushl  0x8(%ebp)
 832:	e8 06 fe ff ff       	call   63d <putc>
 837:	83 c4 10             	add    $0x10,%esp
        ap++;
 83a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 83e:	eb 42                	jmp    882 <printf+0x170>
      } else if(c == '%'){
 840:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 844:	75 17                	jne    85d <printf+0x14b>
        putc(fd, c);
 846:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 849:	0f be c0             	movsbl %al,%eax
 84c:	83 ec 08             	sub    $0x8,%esp
 84f:	50                   	push   %eax
 850:	ff 75 08             	pushl  0x8(%ebp)
 853:	e8 e5 fd ff ff       	call   63d <putc>
 858:	83 c4 10             	add    $0x10,%esp
 85b:	eb 25                	jmp    882 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 85d:	83 ec 08             	sub    $0x8,%esp
 860:	6a 25                	push   $0x25
 862:	ff 75 08             	pushl  0x8(%ebp)
 865:	e8 d3 fd ff ff       	call   63d <putc>
 86a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 86d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 870:	0f be c0             	movsbl %al,%eax
 873:	83 ec 08             	sub    $0x8,%esp
 876:	50                   	push   %eax
 877:	ff 75 08             	pushl  0x8(%ebp)
 87a:	e8 be fd ff ff       	call   63d <putc>
 87f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 882:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 889:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 88d:	8b 55 0c             	mov    0xc(%ebp),%edx
 890:	8b 45 f0             	mov    -0x10(%ebp),%eax
 893:	01 d0                	add    %edx,%eax
 895:	0f b6 00             	movzbl (%eax),%eax
 898:	84 c0                	test   %al,%al
 89a:	0f 85 94 fe ff ff    	jne    734 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8a0:	c9                   	leave  
 8a1:	c3                   	ret    

000008a2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a2:	55                   	push   %ebp
 8a3:	89 e5                	mov    %esp,%ebp
 8a5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a8:	8b 45 08             	mov    0x8(%ebp),%eax
 8ab:	83 e8 08             	sub    $0x8,%eax
 8ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b1:	a1 08 0e 00 00       	mov    0xe08,%eax
 8b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8b9:	eb 24                	jmp    8df <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8be:	8b 00                	mov    (%eax),%eax
 8c0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8c3:	77 12                	ja     8d7 <free+0x35>
 8c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8cb:	77 24                	ja     8f1 <free+0x4f>
 8cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d0:	8b 00                	mov    (%eax),%eax
 8d2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8d5:	77 1a                	ja     8f1 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8da:	8b 00                	mov    (%eax),%eax
 8dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8e5:	76 d4                	jbe    8bb <free+0x19>
 8e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ea:	8b 00                	mov    (%eax),%eax
 8ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ef:	76 ca                	jbe    8bb <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f4:	8b 40 04             	mov    0x4(%eax),%eax
 8f7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 901:	01 c2                	add    %eax,%edx
 903:	8b 45 fc             	mov    -0x4(%ebp),%eax
 906:	8b 00                	mov    (%eax),%eax
 908:	39 c2                	cmp    %eax,%edx
 90a:	75 24                	jne    930 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 90c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90f:	8b 50 04             	mov    0x4(%eax),%edx
 912:	8b 45 fc             	mov    -0x4(%ebp),%eax
 915:	8b 00                	mov    (%eax),%eax
 917:	8b 40 04             	mov    0x4(%eax),%eax
 91a:	01 c2                	add    %eax,%edx
 91c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 922:	8b 45 fc             	mov    -0x4(%ebp),%eax
 925:	8b 00                	mov    (%eax),%eax
 927:	8b 10                	mov    (%eax),%edx
 929:	8b 45 f8             	mov    -0x8(%ebp),%eax
 92c:	89 10                	mov    %edx,(%eax)
 92e:	eb 0a                	jmp    93a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 930:	8b 45 fc             	mov    -0x4(%ebp),%eax
 933:	8b 10                	mov    (%eax),%edx
 935:	8b 45 f8             	mov    -0x8(%ebp),%eax
 938:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 93a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93d:	8b 40 04             	mov    0x4(%eax),%eax
 940:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 947:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94a:	01 d0                	add    %edx,%eax
 94c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 94f:	75 20                	jne    971 <free+0xcf>
    p->s.size += bp->s.size;
 951:	8b 45 fc             	mov    -0x4(%ebp),%eax
 954:	8b 50 04             	mov    0x4(%eax),%edx
 957:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95a:	8b 40 04             	mov    0x4(%eax),%eax
 95d:	01 c2                	add    %eax,%edx
 95f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 962:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 965:	8b 45 f8             	mov    -0x8(%ebp),%eax
 968:	8b 10                	mov    (%eax),%edx
 96a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 96d:	89 10                	mov    %edx,(%eax)
 96f:	eb 08                	jmp    979 <free+0xd7>
  } else
    p->s.ptr = bp;
 971:	8b 45 fc             	mov    -0x4(%ebp),%eax
 974:	8b 55 f8             	mov    -0x8(%ebp),%edx
 977:	89 10                	mov    %edx,(%eax)
  freep = p;
 979:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97c:	a3 08 0e 00 00       	mov    %eax,0xe08
}
 981:	c9                   	leave  
 982:	c3                   	ret    

00000983 <morecore>:

static Header*
morecore(uint nu)
{
 983:	55                   	push   %ebp
 984:	89 e5                	mov    %esp,%ebp
 986:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 989:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 990:	77 07                	ja     999 <morecore+0x16>
    nu = 4096;
 992:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 999:	8b 45 08             	mov    0x8(%ebp),%eax
 99c:	c1 e0 03             	shl    $0x3,%eax
 99f:	83 ec 0c             	sub    $0xc,%esp
 9a2:	50                   	push   %eax
 9a3:	e8 75 fc ff ff       	call   61d <sbrk>
 9a8:	83 c4 10             	add    $0x10,%esp
 9ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9ae:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9b2:	75 07                	jne    9bb <morecore+0x38>
    return 0;
 9b4:	b8 00 00 00 00       	mov    $0x0,%eax
 9b9:	eb 26                	jmp    9e1 <morecore+0x5e>
  hp = (Header*)p;
 9bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c4:	8b 55 08             	mov    0x8(%ebp),%edx
 9c7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9cd:	83 c0 08             	add    $0x8,%eax
 9d0:	83 ec 0c             	sub    $0xc,%esp
 9d3:	50                   	push   %eax
 9d4:	e8 c9 fe ff ff       	call   8a2 <free>
 9d9:	83 c4 10             	add    $0x10,%esp
  return freep;
 9dc:	a1 08 0e 00 00       	mov    0xe08,%eax
}
 9e1:	c9                   	leave  
 9e2:	c3                   	ret    

000009e3 <malloc>:

void*
malloc(uint nbytes)
{
 9e3:	55                   	push   %ebp
 9e4:	89 e5                	mov    %esp,%ebp
 9e6:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e9:	8b 45 08             	mov    0x8(%ebp),%eax
 9ec:	83 c0 07             	add    $0x7,%eax
 9ef:	c1 e8 03             	shr    $0x3,%eax
 9f2:	83 c0 01             	add    $0x1,%eax
 9f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9f8:	a1 08 0e 00 00       	mov    0xe08,%eax
 9fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a00:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a04:	75 23                	jne    a29 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a06:	c7 45 f0 00 0e 00 00 	movl   $0xe00,-0x10(%ebp)
 a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a10:	a3 08 0e 00 00       	mov    %eax,0xe08
 a15:	a1 08 0e 00 00       	mov    0xe08,%eax
 a1a:	a3 00 0e 00 00       	mov    %eax,0xe00
    base.s.size = 0;
 a1f:	c7 05 04 0e 00 00 00 	movl   $0x0,0xe04
 a26:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2c:	8b 00                	mov    (%eax),%eax
 a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a34:	8b 40 04             	mov    0x4(%eax),%eax
 a37:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a3a:	72 4d                	jb     a89 <malloc+0xa6>
      if(p->s.size == nunits)
 a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3f:	8b 40 04             	mov    0x4(%eax),%eax
 a42:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a45:	75 0c                	jne    a53 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4a:	8b 10                	mov    (%eax),%edx
 a4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a4f:	89 10                	mov    %edx,(%eax)
 a51:	eb 26                	jmp    a79 <malloc+0x96>
      else {
        p->s.size -= nunits;
 a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a56:	8b 40 04             	mov    0x4(%eax),%eax
 a59:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a5c:	89 c2                	mov    %eax,%edx
 a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a61:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a67:	8b 40 04             	mov    0x4(%eax),%eax
 a6a:	c1 e0 03             	shl    $0x3,%eax
 a6d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a73:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a76:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a7c:	a3 08 0e 00 00       	mov    %eax,0xe08
      return (void*)(p + 1);
 a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a84:	83 c0 08             	add    $0x8,%eax
 a87:	eb 3b                	jmp    ac4 <malloc+0xe1>
    }
    if(p == freep)
 a89:	a1 08 0e 00 00       	mov    0xe08,%eax
 a8e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a91:	75 1e                	jne    ab1 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a93:	83 ec 0c             	sub    $0xc,%esp
 a96:	ff 75 ec             	pushl  -0x14(%ebp)
 a99:	e8 e5 fe ff ff       	call   983 <morecore>
 a9e:	83 c4 10             	add    $0x10,%esp
 aa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 aa4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 aa8:	75 07                	jne    ab1 <malloc+0xce>
        return 0;
 aaa:	b8 00 00 00 00       	mov    $0x0,%eax
 aaf:	eb 13                	jmp    ac4 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 ab7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aba:	8b 00                	mov    (%eax),%eax
 abc:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 abf:	e9 6d ff ff ff       	jmp    a31 <malloc+0x4e>
}
 ac4:	c9                   	leave  
 ac5:	c3                   	ret    
