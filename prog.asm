
_prog:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int findLenghtOfInput(char *buf);
int isExit(char *buf);
int readFromConsole(char *buf, int bufSize);


int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 14 01 00 00    	sub    $0x114,%esp
	char buf[BUFFER_SIZE];
	int shouldRun = 1;
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	int index = 0;
  1b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	while(shouldRun){
  22:	e9 ae 00 00 00       	jmp    d5 <main+0xd5>
		if (read (0 , buf , BUFFER_SIZE) && !isExit(buf)){
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	68 00 01 00 00       	push   $0x100
  2f:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
  35:	50                   	push   %eax
  36:	6a 00                	push   $0x0
  38:	e8 c8 03 00 00       	call   405 <read>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	85 c0                	test   %eax,%eax
  42:	74 78                	je     bc <main+0xbc>
  44:	83 ec 0c             	sub    $0xc,%esp
  47:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
  4d:	50                   	push   %eax
  4e:	e8 03 01 00 00       	call   156 <isExit>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	75 62                	jne    bc <main+0xbc>
			printf(1, "Entered argument from command line was : ");
  5a:	83 ec 08             	sub    $0x8,%esp
  5d:	68 20 09 00 00       	push   $0x920
  62:	6a 01                	push   $0x1
  64:	e8 01 05 00 00       	call   56a <printf>
  69:	83 c4 10             	add    $0x10,%esp
			int length = findLenghtOfInput(buf);
  6c:	83 ec 0c             	sub    $0xc,%esp
  6f:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
  75:	50                   	push   %eax
  76:	e8 b4 00 00 00       	call   12f <findLenghtOfInput>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	89 45 ec             	mov    %eax,-0x14(%ebp)
			for (index = 0; index < length; index++){
  81:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  88:	eb 28                	jmp    b2 <main+0xb2>
				printf(1, "%c", buf[index]);
  8a:	8d 95 ec fe ff ff    	lea    -0x114(%ebp),%edx
  90:	8b 45 f0             	mov    -0x10(%ebp),%eax
  93:	01 d0                	add    %edx,%eax
  95:	0f b6 00             	movzbl (%eax),%eax
  98:	0f be c0             	movsbl %al,%eax
  9b:	83 ec 04             	sub    $0x4,%esp
  9e:	50                   	push   %eax
  9f:	68 4a 09 00 00       	push   $0x94a
  a4:	6a 01                	push   $0x1
  a6:	e8 bf 04 00 00       	call   56a <printf>
  ab:	83 c4 10             	add    $0x10,%esp
	int index = 0;
	while(shouldRun){
		if (read (0 , buf , BUFFER_SIZE) && !isExit(buf)){
			printf(1, "Entered argument from command line was : ");
			int length = findLenghtOfInput(buf);
			for (index = 0; index < length; index++){
  ae:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  b5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  b8:	7c d0                	jl     8a <main+0x8a>
int main(int argc, char *argv[]){
	char buf[BUFFER_SIZE];
	int shouldRun = 1;
	int index = 0;
	while(shouldRun){
		if (read (0 , buf , BUFFER_SIZE) && !isExit(buf)){
  ba:	eb 19                	jmp    d5 <main+0xd5>
			for (index = 0; index < length; index++){
				printf(1, "%c", buf[index]);
			}
		}
		else {
			shouldRun = 0;
  bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
			printf(2, "Exiting prog ...\n");
  c3:	83 ec 08             	sub    $0x8,%esp
  c6:	68 4d 09 00 00       	push   $0x94d
  cb:	6a 02                	push   $0x2
  cd:	e8 98 04 00 00       	call   56a <printf>
  d2:	83 c4 10             	add    $0x10,%esp

int main(int argc, char *argv[]){
	char buf[BUFFER_SIZE];
	int shouldRun = 1;
	int index = 0;
	while(shouldRun){
  d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  d9:	0f 85 48 ff ff ff    	jne    27 <main+0x27>
			printf(2, "Exiting prog ...\n");

		}
	}

	return 123;
  df:	b8 7b 00 00 00       	mov    $0x7b,%eax
}
  e4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  e7:	c9                   	leave  
  e8:	8d 61 fc             	lea    -0x4(%ecx),%esp
  eb:	c3                   	ret    

000000ec <readFromConsole>:

int readFromConsole(char *buf, int bufSize){
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	83 ec 08             	sub    $0x8,%esp
	memset(buf, 0, bufSize);
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	83 ec 04             	sub    $0x4,%esp
  f8:	50                   	push   %eax
  f9:	6a 00                	push   $0x0
  fb:	ff 75 08             	pushl  0x8(%ebp)
  fe:	e8 50 01 00 00       	call   253 <memset>
 103:	83 c4 10             	add    $0x10,%esp
	gets(buf, bufSize);
 106:	83 ec 08             	sub    $0x8,%esp
 109:	ff 75 0c             	pushl  0xc(%ebp)
 10c:	ff 75 08             	pushl  0x8(%ebp)
 10f:	e8 8c 01 00 00       	call   2a0 <gets>
 114:	83 c4 10             	add    $0x10,%esp
	if(buf[0] == 0) // EOF
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	0f b6 00             	movzbl (%eax),%eax
 11d:	84 c0                	test   %al,%al
 11f:	75 07                	jne    128 <readFromConsole+0x3c>
		return -1;
 121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 126:	eb 05                	jmp    12d <readFromConsole+0x41>
	return 1;
 128:	b8 01 00 00 00       	mov    $0x1,%eax
}
 12d:	c9                   	leave  
 12e:	c3                   	ret    

0000012f <findLenghtOfInput>:

int findLenghtOfInput(char *buf){
 12f:	55                   	push   %ebp
 130:	89 e5                	mov    %esp,%ebp
 132:	83 ec 10             	sub    $0x10,%esp
	int length = 0;
 135:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (buf[length] != '\0'){
 13c:	eb 04                	jmp    142 <findLenghtOfInput+0x13>
		length++;
 13e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	return 1;
}

int findLenghtOfInput(char *buf){
	int length = 0;
	while (buf[length] != '\0'){
 142:	8b 55 fc             	mov    -0x4(%ebp),%edx
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	01 d0                	add    %edx,%eax
 14a:	0f b6 00             	movzbl (%eax),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 ed                	jne    13e <findLenghtOfInput+0xf>
		length++;
	}
	return length;
 151:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 154:	c9                   	leave  
 155:	c3                   	ret    

00000156 <isExit>:

int isExit(char *buf){
 156:	55                   	push   %ebp
 157:	89 e5                	mov    %esp,%ebp
	if (buf[0] == 'e' && buf[1] == 'x' && buf[2] == 'i' && buf[3] == 't'){
 159:	8b 45 08             	mov    0x8(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	3c 65                	cmp    $0x65,%al
 161:	75 2e                	jne    191 <isExit+0x3b>
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	83 c0 01             	add    $0x1,%eax
 169:	0f b6 00             	movzbl (%eax),%eax
 16c:	3c 78                	cmp    $0x78,%al
 16e:	75 21                	jne    191 <isExit+0x3b>
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	83 c0 02             	add    $0x2,%eax
 176:	0f b6 00             	movzbl (%eax),%eax
 179:	3c 69                	cmp    $0x69,%al
 17b:	75 14                	jne    191 <isExit+0x3b>
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
 180:	83 c0 03             	add    $0x3,%eax
 183:	0f b6 00             	movzbl (%eax),%eax
 186:	3c 74                	cmp    $0x74,%al
 188:	75 07                	jne    191 <isExit+0x3b>
		return 1;
 18a:	b8 01 00 00 00       	mov    $0x1,%eax
 18f:	eb 05                	jmp    196 <isExit+0x40>
	}
	return 0;
 191:	b8 00 00 00 00       	mov    $0x0,%eax
}
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    

00000198 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	57                   	push   %edi
 19c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 19d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a0:	8b 55 10             	mov    0x10(%ebp),%edx
 1a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a6:	89 cb                	mov    %ecx,%ebx
 1a8:	89 df                	mov    %ebx,%edi
 1aa:	89 d1                	mov    %edx,%ecx
 1ac:	fc                   	cld    
 1ad:	f3 aa                	rep stos %al,%es:(%edi)
 1af:	89 ca                	mov    %ecx,%edx
 1b1:	89 fb                	mov    %edi,%ebx
 1b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1b6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1b9:	5b                   	pop    %ebx
 1ba:	5f                   	pop    %edi
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    

000001bd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1c9:	90                   	nop
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	8d 50 01             	lea    0x1(%eax),%edx
 1d0:	89 55 08             	mov    %edx,0x8(%ebp)
 1d3:	8b 55 0c             	mov    0xc(%ebp),%edx
 1d6:	8d 4a 01             	lea    0x1(%edx),%ecx
 1d9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1dc:	0f b6 12             	movzbl (%edx),%edx
 1df:	88 10                	mov    %dl,(%eax)
 1e1:	0f b6 00             	movzbl (%eax),%eax
 1e4:	84 c0                	test   %al,%al
 1e6:	75 e2                	jne    1ca <strcpy+0xd>
    ;
  return os;
 1e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1eb:	c9                   	leave  
 1ec:	c3                   	ret    

000001ed <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ed:	55                   	push   %ebp
 1ee:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1f0:	eb 08                	jmp    1fa <strcmp+0xd>
    p++, q++;
 1f2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1f6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1fa:	8b 45 08             	mov    0x8(%ebp),%eax
 1fd:	0f b6 00             	movzbl (%eax),%eax
 200:	84 c0                	test   %al,%al
 202:	74 10                	je     214 <strcmp+0x27>
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	0f b6 10             	movzbl (%eax),%edx
 20a:	8b 45 0c             	mov    0xc(%ebp),%eax
 20d:	0f b6 00             	movzbl (%eax),%eax
 210:	38 c2                	cmp    %al,%dl
 212:	74 de                	je     1f2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	0f b6 00             	movzbl (%eax),%eax
 21a:	0f b6 d0             	movzbl %al,%edx
 21d:	8b 45 0c             	mov    0xc(%ebp),%eax
 220:	0f b6 00             	movzbl (%eax),%eax
 223:	0f b6 c0             	movzbl %al,%eax
 226:	29 c2                	sub    %eax,%edx
 228:	89 d0                	mov    %edx,%eax
}
 22a:	5d                   	pop    %ebp
 22b:	c3                   	ret    

0000022c <strlen>:

uint
strlen(char *s)
{
 22c:	55                   	push   %ebp
 22d:	89 e5                	mov    %esp,%ebp
 22f:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 232:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 239:	eb 04                	jmp    23f <strlen+0x13>
 23b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 23f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 242:	8b 45 08             	mov    0x8(%ebp),%eax
 245:	01 d0                	add    %edx,%eax
 247:	0f b6 00             	movzbl (%eax),%eax
 24a:	84 c0                	test   %al,%al
 24c:	75 ed                	jne    23b <strlen+0xf>
    ;
  return n;
 24e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 251:	c9                   	leave  
 252:	c3                   	ret    

00000253 <memset>:

void*
memset(void *dst, int c, uint n)
{
 253:	55                   	push   %ebp
 254:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 256:	8b 45 10             	mov    0x10(%ebp),%eax
 259:	50                   	push   %eax
 25a:	ff 75 0c             	pushl  0xc(%ebp)
 25d:	ff 75 08             	pushl  0x8(%ebp)
 260:	e8 33 ff ff ff       	call   198 <stosb>
 265:	83 c4 0c             	add    $0xc,%esp
  return dst;
 268:	8b 45 08             	mov    0x8(%ebp),%eax
}
 26b:	c9                   	leave  
 26c:	c3                   	ret    

0000026d <strchr>:

char*
strchr(const char *s, char c)
{
 26d:	55                   	push   %ebp
 26e:	89 e5                	mov    %esp,%ebp
 270:	83 ec 04             	sub    $0x4,%esp
 273:	8b 45 0c             	mov    0xc(%ebp),%eax
 276:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 279:	eb 14                	jmp    28f <strchr+0x22>
    if(*s == c)
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	0f b6 00             	movzbl (%eax),%eax
 281:	3a 45 fc             	cmp    -0x4(%ebp),%al
 284:	75 05                	jne    28b <strchr+0x1e>
      return (char*)s;
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	eb 13                	jmp    29e <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 28b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	0f b6 00             	movzbl (%eax),%eax
 295:	84 c0                	test   %al,%al
 297:	75 e2                	jne    27b <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 299:	b8 00 00 00 00       	mov    $0x0,%eax
}
 29e:	c9                   	leave  
 29f:	c3                   	ret    

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2ad:	eb 44                	jmp    2f3 <gets+0x53>
    cc = read(0, &c, 1);
 2af:	83 ec 04             	sub    $0x4,%esp
 2b2:	6a 01                	push   $0x1
 2b4:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2b7:	50                   	push   %eax
 2b8:	6a 00                	push   $0x0
 2ba:	e8 46 01 00 00       	call   405 <read>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2c9:	7f 02                	jg     2cd <gets+0x2d>
      break;
 2cb:	eb 31                	jmp    2fe <gets+0x5e>
    buf[i++] = c;
 2cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d0:	8d 50 01             	lea    0x1(%eax),%edx
 2d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2d6:	89 c2                	mov    %eax,%edx
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
 2db:	01 c2                	add    %eax,%edx
 2dd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2e1:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2e3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2e7:	3c 0a                	cmp    $0xa,%al
 2e9:	74 13                	je     2fe <gets+0x5e>
 2eb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2ef:	3c 0d                	cmp    $0xd,%al
 2f1:	74 0b                	je     2fe <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f6:	83 c0 01             	add    $0x1,%eax
 2f9:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2fc:	7c b1                	jl     2af <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
 301:	8b 45 08             	mov    0x8(%ebp),%eax
 304:	01 d0                	add    %edx,%eax
 306:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 309:	8b 45 08             	mov    0x8(%ebp),%eax
}
 30c:	c9                   	leave  
 30d:	c3                   	ret    

0000030e <stat>:

int
stat(char *n, struct stat *st)
{
 30e:	55                   	push   %ebp
 30f:	89 e5                	mov    %esp,%ebp
 311:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 314:	83 ec 08             	sub    $0x8,%esp
 317:	6a 00                	push   $0x0
 319:	ff 75 08             	pushl  0x8(%ebp)
 31c:	e8 0c 01 00 00       	call   42d <open>
 321:	83 c4 10             	add    $0x10,%esp
 324:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 327:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 32b:	79 07                	jns    334 <stat+0x26>
    return -1;
 32d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 332:	eb 25                	jmp    359 <stat+0x4b>
  r = fstat(fd, st);
 334:	83 ec 08             	sub    $0x8,%esp
 337:	ff 75 0c             	pushl  0xc(%ebp)
 33a:	ff 75 f4             	pushl  -0xc(%ebp)
 33d:	e8 03 01 00 00       	call   445 <fstat>
 342:	83 c4 10             	add    $0x10,%esp
 345:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 348:	83 ec 0c             	sub    $0xc,%esp
 34b:	ff 75 f4             	pushl  -0xc(%ebp)
 34e:	e8 c2 00 00 00       	call   415 <close>
 353:	83 c4 10             	add    $0x10,%esp
  return r;
 356:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 359:	c9                   	leave  
 35a:	c3                   	ret    

0000035b <atoi>:

int
atoi(const char *s)
{
 35b:	55                   	push   %ebp
 35c:	89 e5                	mov    %esp,%ebp
 35e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 361:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 368:	eb 25                	jmp    38f <atoi+0x34>
    n = n*10 + *s++ - '0';
 36a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 36d:	89 d0                	mov    %edx,%eax
 36f:	c1 e0 02             	shl    $0x2,%eax
 372:	01 d0                	add    %edx,%eax
 374:	01 c0                	add    %eax,%eax
 376:	89 c1                	mov    %eax,%ecx
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	8d 50 01             	lea    0x1(%eax),%edx
 37e:	89 55 08             	mov    %edx,0x8(%ebp)
 381:	0f b6 00             	movzbl (%eax),%eax
 384:	0f be c0             	movsbl %al,%eax
 387:	01 c8                	add    %ecx,%eax
 389:	83 e8 30             	sub    $0x30,%eax
 38c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 38f:	8b 45 08             	mov    0x8(%ebp),%eax
 392:	0f b6 00             	movzbl (%eax),%eax
 395:	3c 2f                	cmp    $0x2f,%al
 397:	7e 0a                	jle    3a3 <atoi+0x48>
 399:	8b 45 08             	mov    0x8(%ebp),%eax
 39c:	0f b6 00             	movzbl (%eax),%eax
 39f:	3c 39                	cmp    $0x39,%al
 3a1:	7e c7                	jle    36a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3a6:	c9                   	leave  
 3a7:	c3                   	ret    

000003a8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3a8:	55                   	push   %ebp
 3a9:	89 e5                	mov    %esp,%ebp
 3ab:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3ae:	8b 45 08             	mov    0x8(%ebp),%eax
 3b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3b4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3ba:	eb 17                	jmp    3d3 <memmove+0x2b>
    *dst++ = *src++;
 3bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3bf:	8d 50 01             	lea    0x1(%eax),%edx
 3c2:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3c5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3c8:	8d 4a 01             	lea    0x1(%edx),%ecx
 3cb:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3ce:	0f b6 12             	movzbl (%edx),%edx
 3d1:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d3:	8b 45 10             	mov    0x10(%ebp),%eax
 3d6:	8d 50 ff             	lea    -0x1(%eax),%edx
 3d9:	89 55 10             	mov    %edx,0x10(%ebp)
 3dc:	85 c0                	test   %eax,%eax
 3de:	7f dc                	jg     3bc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3e3:	c9                   	leave  
 3e4:	c3                   	ret    

000003e5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3e5:	b8 01 00 00 00       	mov    $0x1,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <exit>:
SYSCALL(exit)
 3ed:	b8 02 00 00 00       	mov    $0x2,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <wait>:
SYSCALL(wait)
 3f5:	b8 03 00 00 00       	mov    $0x3,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <pipe>:
SYSCALL(pipe)
 3fd:	b8 04 00 00 00       	mov    $0x4,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <read>:
SYSCALL(read)
 405:	b8 05 00 00 00       	mov    $0x5,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <write>:
SYSCALL(write)
 40d:	b8 10 00 00 00       	mov    $0x10,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret    

00000415 <close>:
SYSCALL(close)
 415:	b8 15 00 00 00       	mov    $0x15,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <kill>:
SYSCALL(kill)
 41d:	b8 06 00 00 00       	mov    $0x6,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <exec>:
SYSCALL(exec)
 425:	b8 07 00 00 00       	mov    $0x7,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <open>:
SYSCALL(open)
 42d:	b8 0f 00 00 00       	mov    $0xf,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <mknod>:
SYSCALL(mknod)
 435:	b8 11 00 00 00       	mov    $0x11,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <unlink>:
SYSCALL(unlink)
 43d:	b8 12 00 00 00       	mov    $0x12,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <fstat>:
SYSCALL(fstat)
 445:	b8 08 00 00 00       	mov    $0x8,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <link>:
SYSCALL(link)
 44d:	b8 13 00 00 00       	mov    $0x13,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <mkdir>:
SYSCALL(mkdir)
 455:	b8 14 00 00 00       	mov    $0x14,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <chdir>:
SYSCALL(chdir)
 45d:	b8 09 00 00 00       	mov    $0x9,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <dup>:
SYSCALL(dup)
 465:	b8 0a 00 00 00       	mov    $0xa,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <getpid>:
SYSCALL(getpid)
 46d:	b8 0b 00 00 00       	mov    $0xb,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <sbrk>:
SYSCALL(sbrk)
 475:	b8 0c 00 00 00       	mov    $0xc,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <sleep>:
SYSCALL(sleep)
 47d:	b8 0d 00 00 00       	mov    $0xd,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <uptime>:
SYSCALL(uptime)
 485:	b8 0e 00 00 00       	mov    $0xe,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <pstat>:
SYSCALL(pstat)
 48d:	b8 16 00 00 00       	mov    $0x16,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 495:	55                   	push   %ebp
 496:	89 e5                	mov    %esp,%ebp
 498:	83 ec 18             	sub    $0x18,%esp
 49b:	8b 45 0c             	mov    0xc(%ebp),%eax
 49e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4a1:	83 ec 04             	sub    $0x4,%esp
 4a4:	6a 01                	push   $0x1
 4a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4a9:	50                   	push   %eax
 4aa:	ff 75 08             	pushl  0x8(%ebp)
 4ad:	e8 5b ff ff ff       	call   40d <write>
 4b2:	83 c4 10             	add    $0x10,%esp
}
 4b5:	c9                   	leave  
 4b6:	c3                   	ret    

000004b7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b7:	55                   	push   %ebp
 4b8:	89 e5                	mov    %esp,%ebp
 4ba:	53                   	push   %ebx
 4bb:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4c5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4c9:	74 17                	je     4e2 <printint+0x2b>
 4cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4cf:	79 11                	jns    4e2 <printint+0x2b>
    neg = 1;
 4d1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 4db:	f7 d8                	neg    %eax
 4dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4e0:	eb 06                	jmp    4e8 <printint+0x31>
  } else {
    x = xx;
 4e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4ef:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4f2:	8d 41 01             	lea    0x1(%ecx),%eax
 4f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4fe:	ba 00 00 00 00       	mov    $0x0,%edx
 503:	f7 f3                	div    %ebx
 505:	89 d0                	mov    %edx,%eax
 507:	0f b6 80 18 0c 00 00 	movzbl 0xc18(%eax),%eax
 50e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 512:	8b 5d 10             	mov    0x10(%ebp),%ebx
 515:	8b 45 ec             	mov    -0x14(%ebp),%eax
 518:	ba 00 00 00 00       	mov    $0x0,%edx
 51d:	f7 f3                	div    %ebx
 51f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 522:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 526:	75 c7                	jne    4ef <printint+0x38>
  if(neg)
 528:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 52c:	74 0e                	je     53c <printint+0x85>
    buf[i++] = '-';
 52e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 531:	8d 50 01             	lea    0x1(%eax),%edx
 534:	89 55 f4             	mov    %edx,-0xc(%ebp)
 537:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 53c:	eb 1d                	jmp    55b <printint+0xa4>
    putc(fd, buf[i]);
 53e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 541:	8b 45 f4             	mov    -0xc(%ebp),%eax
 544:	01 d0                	add    %edx,%eax
 546:	0f b6 00             	movzbl (%eax),%eax
 549:	0f be c0             	movsbl %al,%eax
 54c:	83 ec 08             	sub    $0x8,%esp
 54f:	50                   	push   %eax
 550:	ff 75 08             	pushl  0x8(%ebp)
 553:	e8 3d ff ff ff       	call   495 <putc>
 558:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 55b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 55f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 563:	79 d9                	jns    53e <printint+0x87>
    putc(fd, buf[i]);
}
 565:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 568:	c9                   	leave  
 569:	c3                   	ret    

0000056a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 56a:	55                   	push   %ebp
 56b:	89 e5                	mov    %esp,%ebp
 56d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 570:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 577:	8d 45 0c             	lea    0xc(%ebp),%eax
 57a:	83 c0 04             	add    $0x4,%eax
 57d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 580:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 587:	e9 59 01 00 00       	jmp    6e5 <printf+0x17b>
    c = fmt[i] & 0xff;
 58c:	8b 55 0c             	mov    0xc(%ebp),%edx
 58f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 592:	01 d0                	add    %edx,%eax
 594:	0f b6 00             	movzbl (%eax),%eax
 597:	0f be c0             	movsbl %al,%eax
 59a:	25 ff 00 00 00       	and    $0xff,%eax
 59f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5a6:	75 2c                	jne    5d4 <printf+0x6a>
      if(c == '%'){
 5a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ac:	75 0c                	jne    5ba <printf+0x50>
        state = '%';
 5ae:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5b5:	e9 27 01 00 00       	jmp    6e1 <printf+0x177>
      } else {
        putc(fd, c);
 5ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5bd:	0f be c0             	movsbl %al,%eax
 5c0:	83 ec 08             	sub    $0x8,%esp
 5c3:	50                   	push   %eax
 5c4:	ff 75 08             	pushl  0x8(%ebp)
 5c7:	e8 c9 fe ff ff       	call   495 <putc>
 5cc:	83 c4 10             	add    $0x10,%esp
 5cf:	e9 0d 01 00 00       	jmp    6e1 <printf+0x177>
      }
    } else if(state == '%'){
 5d4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5d8:	0f 85 03 01 00 00    	jne    6e1 <printf+0x177>
      if(c == 'd'){
 5de:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5e2:	75 1e                	jne    602 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e7:	8b 00                	mov    (%eax),%eax
 5e9:	6a 01                	push   $0x1
 5eb:	6a 0a                	push   $0xa
 5ed:	50                   	push   %eax
 5ee:	ff 75 08             	pushl  0x8(%ebp)
 5f1:	e8 c1 fe ff ff       	call   4b7 <printint>
 5f6:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5fd:	e9 d8 00 00 00       	jmp    6da <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 602:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 606:	74 06                	je     60e <printf+0xa4>
 608:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 60c:	75 1e                	jne    62c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 60e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 611:	8b 00                	mov    (%eax),%eax
 613:	6a 00                	push   $0x0
 615:	6a 10                	push   $0x10
 617:	50                   	push   %eax
 618:	ff 75 08             	pushl  0x8(%ebp)
 61b:	e8 97 fe ff ff       	call   4b7 <printint>
 620:	83 c4 10             	add    $0x10,%esp
        ap++;
 623:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 627:	e9 ae 00 00 00       	jmp    6da <printf+0x170>
      } else if(c == 's'){
 62c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 630:	75 43                	jne    675 <printf+0x10b>
        s = (char*)*ap;
 632:	8b 45 e8             	mov    -0x18(%ebp),%eax
 635:	8b 00                	mov    (%eax),%eax
 637:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 63a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 63e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 642:	75 07                	jne    64b <printf+0xe1>
          s = "(null)";
 644:	c7 45 f4 5f 09 00 00 	movl   $0x95f,-0xc(%ebp)
        while(*s != 0){
 64b:	eb 1c                	jmp    669 <printf+0xff>
          putc(fd, *s);
 64d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 650:	0f b6 00             	movzbl (%eax),%eax
 653:	0f be c0             	movsbl %al,%eax
 656:	83 ec 08             	sub    $0x8,%esp
 659:	50                   	push   %eax
 65a:	ff 75 08             	pushl  0x8(%ebp)
 65d:	e8 33 fe ff ff       	call   495 <putc>
 662:	83 c4 10             	add    $0x10,%esp
          s++;
 665:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 669:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66c:	0f b6 00             	movzbl (%eax),%eax
 66f:	84 c0                	test   %al,%al
 671:	75 da                	jne    64d <printf+0xe3>
 673:	eb 65                	jmp    6da <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 675:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 679:	75 1d                	jne    698 <printf+0x12e>
        putc(fd, *ap);
 67b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67e:	8b 00                	mov    (%eax),%eax
 680:	0f be c0             	movsbl %al,%eax
 683:	83 ec 08             	sub    $0x8,%esp
 686:	50                   	push   %eax
 687:	ff 75 08             	pushl  0x8(%ebp)
 68a:	e8 06 fe ff ff       	call   495 <putc>
 68f:	83 c4 10             	add    $0x10,%esp
        ap++;
 692:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 696:	eb 42                	jmp    6da <printf+0x170>
      } else if(c == '%'){
 698:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 69c:	75 17                	jne    6b5 <printf+0x14b>
        putc(fd, c);
 69e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a1:	0f be c0             	movsbl %al,%eax
 6a4:	83 ec 08             	sub    $0x8,%esp
 6a7:	50                   	push   %eax
 6a8:	ff 75 08             	pushl  0x8(%ebp)
 6ab:	e8 e5 fd ff ff       	call   495 <putc>
 6b0:	83 c4 10             	add    $0x10,%esp
 6b3:	eb 25                	jmp    6da <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b5:	83 ec 08             	sub    $0x8,%esp
 6b8:	6a 25                	push   $0x25
 6ba:	ff 75 08             	pushl  0x8(%ebp)
 6bd:	e8 d3 fd ff ff       	call   495 <putc>
 6c2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c8:	0f be c0             	movsbl %al,%eax
 6cb:	83 ec 08             	sub    $0x8,%esp
 6ce:	50                   	push   %eax
 6cf:	ff 75 08             	pushl  0x8(%ebp)
 6d2:	e8 be fd ff ff       	call   495 <putc>
 6d7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6eb:	01 d0                	add    %edx,%eax
 6ed:	0f b6 00             	movzbl (%eax),%eax
 6f0:	84 c0                	test   %al,%al
 6f2:	0f 85 94 fe ff ff    	jne    58c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6f8:	c9                   	leave  
 6f9:	c3                   	ret    

000006fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6fa:	55                   	push   %ebp
 6fb:	89 e5                	mov    %esp,%ebp
 6fd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 700:	8b 45 08             	mov    0x8(%ebp),%eax
 703:	83 e8 08             	sub    $0x8,%eax
 706:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 709:	a1 34 0c 00 00       	mov    0xc34,%eax
 70e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 711:	eb 24                	jmp    737 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 713:	8b 45 fc             	mov    -0x4(%ebp),%eax
 716:	8b 00                	mov    (%eax),%eax
 718:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71b:	77 12                	ja     72f <free+0x35>
 71d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 720:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 723:	77 24                	ja     749 <free+0x4f>
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	8b 00                	mov    (%eax),%eax
 72a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72d:	77 1a                	ja     749 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	8b 00                	mov    (%eax),%eax
 734:	89 45 fc             	mov    %eax,-0x4(%ebp)
 737:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 73d:	76 d4                	jbe    713 <free+0x19>
 73f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 742:	8b 00                	mov    (%eax),%eax
 744:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 747:	76 ca                	jbe    713 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 749:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74c:	8b 40 04             	mov    0x4(%eax),%eax
 74f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 756:	8b 45 f8             	mov    -0x8(%ebp),%eax
 759:	01 c2                	add    %eax,%edx
 75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75e:	8b 00                	mov    (%eax),%eax
 760:	39 c2                	cmp    %eax,%edx
 762:	75 24                	jne    788 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 764:	8b 45 f8             	mov    -0x8(%ebp),%eax
 767:	8b 50 04             	mov    0x4(%eax),%edx
 76a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76d:	8b 00                	mov    (%eax),%eax
 76f:	8b 40 04             	mov    0x4(%eax),%eax
 772:	01 c2                	add    %eax,%edx
 774:	8b 45 f8             	mov    -0x8(%ebp),%eax
 777:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 77a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77d:	8b 00                	mov    (%eax),%eax
 77f:	8b 10                	mov    (%eax),%edx
 781:	8b 45 f8             	mov    -0x8(%ebp),%eax
 784:	89 10                	mov    %edx,(%eax)
 786:	eb 0a                	jmp    792 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 788:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78b:	8b 10                	mov    (%eax),%edx
 78d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 790:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 792:	8b 45 fc             	mov    -0x4(%ebp),%eax
 795:	8b 40 04             	mov    0x4(%eax),%eax
 798:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 79f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a2:	01 d0                	add    %edx,%eax
 7a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a7:	75 20                	jne    7c9 <free+0xcf>
    p->s.size += bp->s.size;
 7a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ac:	8b 50 04             	mov    0x4(%eax),%edx
 7af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b2:	8b 40 04             	mov    0x4(%eax),%eax
 7b5:	01 c2                	add    %eax,%edx
 7b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ba:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c0:	8b 10                	mov    (%eax),%edx
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	89 10                	mov    %edx,(%eax)
 7c7:	eb 08                	jmp    7d1 <free+0xd7>
  } else
    p->s.ptr = bp;
 7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7cf:	89 10                	mov    %edx,(%eax)
  freep = p;
 7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d4:	a3 34 0c 00 00       	mov    %eax,0xc34
}
 7d9:	c9                   	leave  
 7da:	c3                   	ret    

000007db <morecore>:

static Header*
morecore(uint nu)
{
 7db:	55                   	push   %ebp
 7dc:	89 e5                	mov    %esp,%ebp
 7de:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7e1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e8:	77 07                	ja     7f1 <morecore+0x16>
    nu = 4096;
 7ea:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7f1:	8b 45 08             	mov    0x8(%ebp),%eax
 7f4:	c1 e0 03             	shl    $0x3,%eax
 7f7:	83 ec 0c             	sub    $0xc,%esp
 7fa:	50                   	push   %eax
 7fb:	e8 75 fc ff ff       	call   475 <sbrk>
 800:	83 c4 10             	add    $0x10,%esp
 803:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 806:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 80a:	75 07                	jne    813 <morecore+0x38>
    return 0;
 80c:	b8 00 00 00 00       	mov    $0x0,%eax
 811:	eb 26                	jmp    839 <morecore+0x5e>
  hp = (Header*)p;
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 819:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81c:	8b 55 08             	mov    0x8(%ebp),%edx
 81f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 822:	8b 45 f0             	mov    -0x10(%ebp),%eax
 825:	83 c0 08             	add    $0x8,%eax
 828:	83 ec 0c             	sub    $0xc,%esp
 82b:	50                   	push   %eax
 82c:	e8 c9 fe ff ff       	call   6fa <free>
 831:	83 c4 10             	add    $0x10,%esp
  return freep;
 834:	a1 34 0c 00 00       	mov    0xc34,%eax
}
 839:	c9                   	leave  
 83a:	c3                   	ret    

0000083b <malloc>:

void*
malloc(uint nbytes)
{
 83b:	55                   	push   %ebp
 83c:	89 e5                	mov    %esp,%ebp
 83e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 841:	8b 45 08             	mov    0x8(%ebp),%eax
 844:	83 c0 07             	add    $0x7,%eax
 847:	c1 e8 03             	shr    $0x3,%eax
 84a:	83 c0 01             	add    $0x1,%eax
 84d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 850:	a1 34 0c 00 00       	mov    0xc34,%eax
 855:	89 45 f0             	mov    %eax,-0x10(%ebp)
 858:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 85c:	75 23                	jne    881 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 85e:	c7 45 f0 2c 0c 00 00 	movl   $0xc2c,-0x10(%ebp)
 865:	8b 45 f0             	mov    -0x10(%ebp),%eax
 868:	a3 34 0c 00 00       	mov    %eax,0xc34
 86d:	a1 34 0c 00 00       	mov    0xc34,%eax
 872:	a3 2c 0c 00 00       	mov    %eax,0xc2c
    base.s.size = 0;
 877:	c7 05 30 0c 00 00 00 	movl   $0x0,0xc30
 87e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 881:	8b 45 f0             	mov    -0x10(%ebp),%eax
 884:	8b 00                	mov    (%eax),%eax
 886:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 889:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88c:	8b 40 04             	mov    0x4(%eax),%eax
 88f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 892:	72 4d                	jb     8e1 <malloc+0xa6>
      if(p->s.size == nunits)
 894:	8b 45 f4             	mov    -0xc(%ebp),%eax
 897:	8b 40 04             	mov    0x4(%eax),%eax
 89a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 89d:	75 0c                	jne    8ab <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	8b 10                	mov    (%eax),%edx
 8a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a7:	89 10                	mov    %edx,(%eax)
 8a9:	eb 26                	jmp    8d1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ae:	8b 40 04             	mov    0x4(%eax),%eax
 8b1:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8b4:	89 c2                	mov    %eax,%edx
 8b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bf:	8b 40 04             	mov    0x4(%eax),%eax
 8c2:	c1 e0 03             	shl    $0x3,%eax
 8c5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cb:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8ce:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d4:	a3 34 0c 00 00       	mov    %eax,0xc34
      return (void*)(p + 1);
 8d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8dc:	83 c0 08             	add    $0x8,%eax
 8df:	eb 3b                	jmp    91c <malloc+0xe1>
    }
    if(p == freep)
 8e1:	a1 34 0c 00 00       	mov    0xc34,%eax
 8e6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8e9:	75 1e                	jne    909 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8eb:	83 ec 0c             	sub    $0xc,%esp
 8ee:	ff 75 ec             	pushl  -0x14(%ebp)
 8f1:	e8 e5 fe ff ff       	call   7db <morecore>
 8f6:	83 c4 10             	add    $0x10,%esp
 8f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 900:	75 07                	jne    909 <malloc+0xce>
        return 0;
 902:	b8 00 00 00 00       	mov    $0x0,%eax
 907:	eb 13                	jmp    91c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 909:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 90f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 912:	8b 00                	mov    (%eax),%eax
 914:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 917:	e9 6d ff ff ff       	jmp    889 <malloc+0x4e>
}
 91c:	c9                   	leave  
 91d:	c3                   	ret    
