
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
  22:	e9 ac 00 00 00       	jmp    d3 <main+0xd3>
		if (gets(buf, BUFFER_SIZE) > 0 && !isExit(buf)){
  27:	83 ec 08             	sub    $0x8,%esp
  2a:	68 00 01 00 00       	push   $0x100
  2f:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
  35:	50                   	push   %eax
  36:	e8 63 02 00 00       	call   29e <gets>
  3b:	83 c4 10             	add    $0x10,%esp
  3e:	85 c0                	test   %eax,%eax
  40:	74 78                	je     ba <main+0xba>
  42:	83 ec 0c             	sub    $0xc,%esp
  45:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
  4b:	50                   	push   %eax
  4c:	e8 03 01 00 00       	call   154 <isExit>
  51:	83 c4 10             	add    $0x10,%esp
  54:	85 c0                	test   %eax,%eax
  56:	75 62                	jne    ba <main+0xba>
			printf(0, "Entered argument from command line was : ");
  58:	83 ec 08             	sub    $0x8,%esp
  5b:	68 1c 09 00 00       	push   $0x91c
  60:	6a 00                	push   $0x0
  62:	e8 01 05 00 00       	call   568 <printf>
  67:	83 c4 10             	add    $0x10,%esp
			int length = findLenghtOfInput(buf);
  6a:	83 ec 0c             	sub    $0xc,%esp
  6d:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
  73:	50                   	push   %eax
  74:	e8 b4 00 00 00       	call   12d <findLenghtOfInput>
  79:	83 c4 10             	add    $0x10,%esp
  7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
			for (index = 0; index < length; index++){
  7f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  86:	eb 28                	jmp    b0 <main+0xb0>
				printf(0, "%c", buf[index]);
  88:	8d 95 ec fe ff ff    	lea    -0x114(%ebp),%edx
  8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  91:	01 d0                	add    %edx,%eax
  93:	0f b6 00             	movzbl (%eax),%eax
  96:	0f be c0             	movsbl %al,%eax
  99:	83 ec 04             	sub    $0x4,%esp
  9c:	50                   	push   %eax
  9d:	68 46 09 00 00       	push   $0x946
  a2:	6a 00                	push   $0x0
  a4:	e8 bf 04 00 00       	call   568 <printf>
  a9:	83 c4 10             	add    $0x10,%esp
	int index = 0;
	while(shouldRun){
		if (gets(buf, BUFFER_SIZE) > 0 && !isExit(buf)){
			printf(0, "Entered argument from command line was : ");
			int length = findLenghtOfInput(buf);
			for (index = 0; index < length; index++){
  ac:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  b3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  b6:	7c d0                	jl     88 <main+0x88>
int main(int argc, char *argv[]){
	char buf[BUFFER_SIZE];
	int shouldRun = 1;
	int index = 0;
	while(shouldRun){
		if (gets(buf, BUFFER_SIZE) > 0 && !isExit(buf)){
  b8:	eb 19                	jmp    d3 <main+0xd3>
			for (index = 0; index < length; index++){
				printf(0, "%c", buf[index]);
			}
		}
		else {
			shouldRun = 0;
  ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
			printf(0, "Exiting prog ...\n");
  c1:	83 ec 08             	sub    $0x8,%esp
  c4:	68 49 09 00 00       	push   $0x949
  c9:	6a 00                	push   $0x0
  cb:	e8 98 04 00 00       	call   568 <printf>
  d0:	83 c4 10             	add    $0x10,%esp

int main(int argc, char *argv[]){
	char buf[BUFFER_SIZE];
	int shouldRun = 1;
	int index = 0;
	while(shouldRun){
  d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  d7:	0f 85 4a ff ff ff    	jne    27 <main+0x27>
			printf(0, "Exiting prog ...\n");

		}
	}

	return 123;
  dd:	b8 7b 00 00 00       	mov    $0x7b,%eax
}
  e2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  e5:	c9                   	leave  
  e6:	8d 61 fc             	lea    -0x4(%ecx),%esp
  e9:	c3                   	ret    

000000ea <readFromConsole>:

int readFromConsole(char *buf, int bufSize){
  ea:	55                   	push   %ebp
  eb:	89 e5                	mov    %esp,%ebp
  ed:	83 ec 08             	sub    $0x8,%esp
	memset(buf, 0, bufSize);
  f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  f3:	83 ec 04             	sub    $0x4,%esp
  f6:	50                   	push   %eax
  f7:	6a 00                	push   $0x0
  f9:	ff 75 08             	pushl  0x8(%ebp)
  fc:	e8 50 01 00 00       	call   251 <memset>
 101:	83 c4 10             	add    $0x10,%esp
	gets(buf, bufSize);
 104:	83 ec 08             	sub    $0x8,%esp
 107:	ff 75 0c             	pushl  0xc(%ebp)
 10a:	ff 75 08             	pushl  0x8(%ebp)
 10d:	e8 8c 01 00 00       	call   29e <gets>
 112:	83 c4 10             	add    $0x10,%esp
	if(buf[0] == 0) // EOF
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	84 c0                	test   %al,%al
 11d:	75 07                	jne    126 <readFromConsole+0x3c>
		return -1;
 11f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 124:	eb 05                	jmp    12b <readFromConsole+0x41>
	return 1;
 126:	b8 01 00 00 00       	mov    $0x1,%eax
}
 12b:	c9                   	leave  
 12c:	c3                   	ret    

0000012d <findLenghtOfInput>:

int findLenghtOfInput(char *buf){
 12d:	55                   	push   %ebp
 12e:	89 e5                	mov    %esp,%ebp
 130:	83 ec 10             	sub    $0x10,%esp
	int length = 0;
 133:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (buf[length] != '\0'){
 13a:	eb 04                	jmp    140 <findLenghtOfInput+0x13>
		length++;
 13c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	return 1;
}

int findLenghtOfInput(char *buf){
	int length = 0;
	while (buf[length] != '\0'){
 140:	8b 55 fc             	mov    -0x4(%ebp),%edx
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	01 d0                	add    %edx,%eax
 148:	0f b6 00             	movzbl (%eax),%eax
 14b:	84 c0                	test   %al,%al
 14d:	75 ed                	jne    13c <findLenghtOfInput+0xf>
		length++;
	}
	return length;
 14f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 152:	c9                   	leave  
 153:	c3                   	ret    

00000154 <isExit>:

int isExit(char *buf){
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
	if (buf[0] == 'e' && buf[1] == 'x' && buf[2] == 'i' && buf[3] == 't'){
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	0f b6 00             	movzbl (%eax),%eax
 15d:	3c 65                	cmp    $0x65,%al
 15f:	75 2e                	jne    18f <isExit+0x3b>
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	83 c0 01             	add    $0x1,%eax
 167:	0f b6 00             	movzbl (%eax),%eax
 16a:	3c 78                	cmp    $0x78,%al
 16c:	75 21                	jne    18f <isExit+0x3b>
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	83 c0 02             	add    $0x2,%eax
 174:	0f b6 00             	movzbl (%eax),%eax
 177:	3c 69                	cmp    $0x69,%al
 179:	75 14                	jne    18f <isExit+0x3b>
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	83 c0 03             	add    $0x3,%eax
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	3c 74                	cmp    $0x74,%al
 186:	75 07                	jne    18f <isExit+0x3b>
		return 1;
 188:	b8 01 00 00 00       	mov    $0x1,%eax
 18d:	eb 05                	jmp    194 <isExit+0x40>
	}
	return 0;
 18f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    

00000196 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	57                   	push   %edi
 19a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 19b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 19e:	8b 55 10             	mov    0x10(%ebp),%edx
 1a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a4:	89 cb                	mov    %ecx,%ebx
 1a6:	89 df                	mov    %ebx,%edi
 1a8:	89 d1                	mov    %edx,%ecx
 1aa:	fc                   	cld    
 1ab:	f3 aa                	rep stos %al,%es:(%edi)
 1ad:	89 ca                	mov    %ecx,%edx
 1af:	89 fb                	mov    %edi,%ebx
 1b1:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1b4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1b7:	5b                   	pop    %ebx
 1b8:	5f                   	pop    %edi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    

000001bb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1bb:	55                   	push   %ebp
 1bc:	89 e5                	mov    %esp,%ebp
 1be:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1c1:	8b 45 08             	mov    0x8(%ebp),%eax
 1c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1c7:	90                   	nop
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	8d 50 01             	lea    0x1(%eax),%edx
 1ce:	89 55 08             	mov    %edx,0x8(%ebp)
 1d1:	8b 55 0c             	mov    0xc(%ebp),%edx
 1d4:	8d 4a 01             	lea    0x1(%edx),%ecx
 1d7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1da:	0f b6 12             	movzbl (%edx),%edx
 1dd:	88 10                	mov    %dl,(%eax)
 1df:	0f b6 00             	movzbl (%eax),%eax
 1e2:	84 c0                	test   %al,%al
 1e4:	75 e2                	jne    1c8 <strcpy+0xd>
    ;
  return os;
 1e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1e9:	c9                   	leave  
 1ea:	c3                   	ret    

000001eb <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1eb:	55                   	push   %ebp
 1ec:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1ee:	eb 08                	jmp    1f8 <strcmp+0xd>
    p++, q++;
 1f0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1f4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	0f b6 00             	movzbl (%eax),%eax
 1fe:	84 c0                	test   %al,%al
 200:	74 10                	je     212 <strcmp+0x27>
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	0f b6 10             	movzbl (%eax),%edx
 208:	8b 45 0c             	mov    0xc(%ebp),%eax
 20b:	0f b6 00             	movzbl (%eax),%eax
 20e:	38 c2                	cmp    %al,%dl
 210:	74 de                	je     1f0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 212:	8b 45 08             	mov    0x8(%ebp),%eax
 215:	0f b6 00             	movzbl (%eax),%eax
 218:	0f b6 d0             	movzbl %al,%edx
 21b:	8b 45 0c             	mov    0xc(%ebp),%eax
 21e:	0f b6 00             	movzbl (%eax),%eax
 221:	0f b6 c0             	movzbl %al,%eax
 224:	29 c2                	sub    %eax,%edx
 226:	89 d0                	mov    %edx,%eax
}
 228:	5d                   	pop    %ebp
 229:	c3                   	ret    

0000022a <strlen>:

uint
strlen(char *s)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 237:	eb 04                	jmp    23d <strlen+0x13>
 239:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 23d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	01 d0                	add    %edx,%eax
 245:	0f b6 00             	movzbl (%eax),%eax
 248:	84 c0                	test   %al,%al
 24a:	75 ed                	jne    239 <strlen+0xf>
    ;
  return n;
 24c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 24f:	c9                   	leave  
 250:	c3                   	ret    

00000251 <memset>:

void*
memset(void *dst, int c, uint n)
{
 251:	55                   	push   %ebp
 252:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 254:	8b 45 10             	mov    0x10(%ebp),%eax
 257:	50                   	push   %eax
 258:	ff 75 0c             	pushl  0xc(%ebp)
 25b:	ff 75 08             	pushl  0x8(%ebp)
 25e:	e8 33 ff ff ff       	call   196 <stosb>
 263:	83 c4 0c             	add    $0xc,%esp
  return dst;
 266:	8b 45 08             	mov    0x8(%ebp),%eax
}
 269:	c9                   	leave  
 26a:	c3                   	ret    

0000026b <strchr>:

char*
strchr(const char *s, char c)
{
 26b:	55                   	push   %ebp
 26c:	89 e5                	mov    %esp,%ebp
 26e:	83 ec 04             	sub    $0x4,%esp
 271:	8b 45 0c             	mov    0xc(%ebp),%eax
 274:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 277:	eb 14                	jmp    28d <strchr+0x22>
    if(*s == c)
 279:	8b 45 08             	mov    0x8(%ebp),%eax
 27c:	0f b6 00             	movzbl (%eax),%eax
 27f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 282:	75 05                	jne    289 <strchr+0x1e>
      return (char*)s;
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	eb 13                	jmp    29c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 289:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
 290:	0f b6 00             	movzbl (%eax),%eax
 293:	84 c0                	test   %al,%al
 295:	75 e2                	jne    279 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 297:	b8 00 00 00 00       	mov    $0x0,%eax
}
 29c:	c9                   	leave  
 29d:	c3                   	ret    

0000029e <gets>:

char*
gets(char *buf, int max)
{
 29e:	55                   	push   %ebp
 29f:	89 e5                	mov    %esp,%ebp
 2a1:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2ab:	eb 44                	jmp    2f1 <gets+0x53>
    cc = read(0, &c, 1);
 2ad:	83 ec 04             	sub    $0x4,%esp
 2b0:	6a 01                	push   $0x1
 2b2:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2b5:	50                   	push   %eax
 2b6:	6a 00                	push   $0x0
 2b8:	e8 46 01 00 00       	call   403 <read>
 2bd:	83 c4 10             	add    $0x10,%esp
 2c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2c7:	7f 02                	jg     2cb <gets+0x2d>
      break;
 2c9:	eb 31                	jmp    2fc <gets+0x5e>
    buf[i++] = c;
 2cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ce:	8d 50 01             	lea    0x1(%eax),%edx
 2d1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2d4:	89 c2                	mov    %eax,%edx
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
 2d9:	01 c2                	add    %eax,%edx
 2db:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2df:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2e1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2e5:	3c 0a                	cmp    $0xa,%al
 2e7:	74 13                	je     2fc <gets+0x5e>
 2e9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2ed:	3c 0d                	cmp    $0xd,%al
 2ef:	74 0b                	je     2fc <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f4:	83 c0 01             	add    $0x1,%eax
 2f7:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2fa:	7c b1                	jl     2ad <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2ff:	8b 45 08             	mov    0x8(%ebp),%eax
 302:	01 d0                	add    %edx,%eax
 304:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 307:	8b 45 08             	mov    0x8(%ebp),%eax
}
 30a:	c9                   	leave  
 30b:	c3                   	ret    

0000030c <stat>:

int
stat(char *n, struct stat *st)
{
 30c:	55                   	push   %ebp
 30d:	89 e5                	mov    %esp,%ebp
 30f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 312:	83 ec 08             	sub    $0x8,%esp
 315:	6a 00                	push   $0x0
 317:	ff 75 08             	pushl  0x8(%ebp)
 31a:	e8 0c 01 00 00       	call   42b <open>
 31f:	83 c4 10             	add    $0x10,%esp
 322:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 325:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 329:	79 07                	jns    332 <stat+0x26>
    return -1;
 32b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 330:	eb 25                	jmp    357 <stat+0x4b>
  r = fstat(fd, st);
 332:	83 ec 08             	sub    $0x8,%esp
 335:	ff 75 0c             	pushl  0xc(%ebp)
 338:	ff 75 f4             	pushl  -0xc(%ebp)
 33b:	e8 03 01 00 00       	call   443 <fstat>
 340:	83 c4 10             	add    $0x10,%esp
 343:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 346:	83 ec 0c             	sub    $0xc,%esp
 349:	ff 75 f4             	pushl  -0xc(%ebp)
 34c:	e8 c2 00 00 00       	call   413 <close>
 351:	83 c4 10             	add    $0x10,%esp
  return r;
 354:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 357:	c9                   	leave  
 358:	c3                   	ret    

00000359 <atoi>:

int
atoi(const char *s)
{
 359:	55                   	push   %ebp
 35a:	89 e5                	mov    %esp,%ebp
 35c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 35f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 366:	eb 25                	jmp    38d <atoi+0x34>
    n = n*10 + *s++ - '0';
 368:	8b 55 fc             	mov    -0x4(%ebp),%edx
 36b:	89 d0                	mov    %edx,%eax
 36d:	c1 e0 02             	shl    $0x2,%eax
 370:	01 d0                	add    %edx,%eax
 372:	01 c0                	add    %eax,%eax
 374:	89 c1                	mov    %eax,%ecx
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	8d 50 01             	lea    0x1(%eax),%edx
 37c:	89 55 08             	mov    %edx,0x8(%ebp)
 37f:	0f b6 00             	movzbl (%eax),%eax
 382:	0f be c0             	movsbl %al,%eax
 385:	01 c8                	add    %ecx,%eax
 387:	83 e8 30             	sub    $0x30,%eax
 38a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 38d:	8b 45 08             	mov    0x8(%ebp),%eax
 390:	0f b6 00             	movzbl (%eax),%eax
 393:	3c 2f                	cmp    $0x2f,%al
 395:	7e 0a                	jle    3a1 <atoi+0x48>
 397:	8b 45 08             	mov    0x8(%ebp),%eax
 39a:	0f b6 00             	movzbl (%eax),%eax
 39d:	3c 39                	cmp    $0x39,%al
 39f:	7e c7                	jle    368 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3a4:	c9                   	leave  
 3a5:	c3                   	ret    

000003a6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3a6:	55                   	push   %ebp
 3a7:	89 e5                	mov    %esp,%ebp
 3a9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3ac:	8b 45 08             	mov    0x8(%ebp),%eax
 3af:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3b8:	eb 17                	jmp    3d1 <memmove+0x2b>
    *dst++ = *src++;
 3ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3bd:	8d 50 01             	lea    0x1(%eax),%edx
 3c0:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3c6:	8d 4a 01             	lea    0x1(%edx),%ecx
 3c9:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3cc:	0f b6 12             	movzbl (%edx),%edx
 3cf:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d1:	8b 45 10             	mov    0x10(%ebp),%eax
 3d4:	8d 50 ff             	lea    -0x1(%eax),%edx
 3d7:	89 55 10             	mov    %edx,0x10(%ebp)
 3da:	85 c0                	test   %eax,%eax
 3dc:	7f dc                	jg     3ba <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3de:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3e1:	c9                   	leave  
 3e2:	c3                   	ret    

000003e3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3e3:	b8 01 00 00 00       	mov    $0x1,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <exit>:
SYSCALL(exit)
 3eb:	b8 02 00 00 00       	mov    $0x2,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <wait>:
SYSCALL(wait)
 3f3:	b8 03 00 00 00       	mov    $0x3,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <pipe>:
SYSCALL(pipe)
 3fb:	b8 04 00 00 00       	mov    $0x4,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <read>:
SYSCALL(read)
 403:	b8 05 00 00 00       	mov    $0x5,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <write>:
SYSCALL(write)
 40b:	b8 10 00 00 00       	mov    $0x10,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <close>:
SYSCALL(close)
 413:	b8 15 00 00 00       	mov    $0x15,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <kill>:
SYSCALL(kill)
 41b:	b8 06 00 00 00       	mov    $0x6,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <exec>:
SYSCALL(exec)
 423:	b8 07 00 00 00       	mov    $0x7,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <open>:
SYSCALL(open)
 42b:	b8 0f 00 00 00       	mov    $0xf,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <mknod>:
SYSCALL(mknod)
 433:	b8 11 00 00 00       	mov    $0x11,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <unlink>:
SYSCALL(unlink)
 43b:	b8 12 00 00 00       	mov    $0x12,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <fstat>:
SYSCALL(fstat)
 443:	b8 08 00 00 00       	mov    $0x8,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <link>:
SYSCALL(link)
 44b:	b8 13 00 00 00       	mov    $0x13,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <mkdir>:
SYSCALL(mkdir)
 453:	b8 14 00 00 00       	mov    $0x14,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <chdir>:
SYSCALL(chdir)
 45b:	b8 09 00 00 00       	mov    $0x9,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <dup>:
SYSCALL(dup)
 463:	b8 0a 00 00 00       	mov    $0xa,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <getpid>:
SYSCALL(getpid)
 46b:	b8 0b 00 00 00       	mov    $0xb,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <sbrk>:
SYSCALL(sbrk)
 473:	b8 0c 00 00 00       	mov    $0xc,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <sleep>:
SYSCALL(sleep)
 47b:	b8 0d 00 00 00       	mov    $0xd,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <uptime>:
SYSCALL(uptime)
 483:	b8 0e 00 00 00       	mov    $0xe,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <pstat>:
SYSCALL(pstat)
 48b:	b8 16 00 00 00       	mov    $0x16,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 493:	55                   	push   %ebp
 494:	89 e5                	mov    %esp,%ebp
 496:	83 ec 18             	sub    $0x18,%esp
 499:	8b 45 0c             	mov    0xc(%ebp),%eax
 49c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 49f:	83 ec 04             	sub    $0x4,%esp
 4a2:	6a 01                	push   $0x1
 4a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4a7:	50                   	push   %eax
 4a8:	ff 75 08             	pushl  0x8(%ebp)
 4ab:	e8 5b ff ff ff       	call   40b <write>
 4b0:	83 c4 10             	add    $0x10,%esp
}
 4b3:	c9                   	leave  
 4b4:	c3                   	ret    

000004b5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b5:	55                   	push   %ebp
 4b6:	89 e5                	mov    %esp,%ebp
 4b8:	53                   	push   %ebx
 4b9:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4c3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4c7:	74 17                	je     4e0 <printint+0x2b>
 4c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4cd:	79 11                	jns    4e0 <printint+0x2b>
    neg = 1;
 4cf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d9:	f7 d8                	neg    %eax
 4db:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4de:	eb 06                	jmp    4e6 <printint+0x31>
  } else {
    x = xx;
 4e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4f0:	8d 41 01             	lea    0x1(%ecx),%eax
 4f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4fc:	ba 00 00 00 00       	mov    $0x0,%edx
 501:	f7 f3                	div    %ebx
 503:	89 d0                	mov    %edx,%eax
 505:	0f b6 80 14 0c 00 00 	movzbl 0xc14(%eax),%eax
 50c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 510:	8b 5d 10             	mov    0x10(%ebp),%ebx
 513:	8b 45 ec             	mov    -0x14(%ebp),%eax
 516:	ba 00 00 00 00       	mov    $0x0,%edx
 51b:	f7 f3                	div    %ebx
 51d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 520:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 524:	75 c7                	jne    4ed <printint+0x38>
  if(neg)
 526:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 52a:	74 0e                	je     53a <printint+0x85>
    buf[i++] = '-';
 52c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52f:	8d 50 01             	lea    0x1(%eax),%edx
 532:	89 55 f4             	mov    %edx,-0xc(%ebp)
 535:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 53a:	eb 1d                	jmp    559 <printint+0xa4>
    putc(fd, buf[i]);
 53c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 542:	01 d0                	add    %edx,%eax
 544:	0f b6 00             	movzbl (%eax),%eax
 547:	0f be c0             	movsbl %al,%eax
 54a:	83 ec 08             	sub    $0x8,%esp
 54d:	50                   	push   %eax
 54e:	ff 75 08             	pushl  0x8(%ebp)
 551:	e8 3d ff ff ff       	call   493 <putc>
 556:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 559:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 55d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 561:	79 d9                	jns    53c <printint+0x87>
    putc(fd, buf[i]);
}
 563:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 566:	c9                   	leave  
 567:	c3                   	ret    

00000568 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 568:	55                   	push   %ebp
 569:	89 e5                	mov    %esp,%ebp
 56b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 56e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 575:	8d 45 0c             	lea    0xc(%ebp),%eax
 578:	83 c0 04             	add    $0x4,%eax
 57b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 57e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 585:	e9 59 01 00 00       	jmp    6e3 <printf+0x17b>
    c = fmt[i] & 0xff;
 58a:	8b 55 0c             	mov    0xc(%ebp),%edx
 58d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 590:	01 d0                	add    %edx,%eax
 592:	0f b6 00             	movzbl (%eax),%eax
 595:	0f be c0             	movsbl %al,%eax
 598:	25 ff 00 00 00       	and    $0xff,%eax
 59d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5a4:	75 2c                	jne    5d2 <printf+0x6a>
      if(c == '%'){
 5a6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5aa:	75 0c                	jne    5b8 <printf+0x50>
        state = '%';
 5ac:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5b3:	e9 27 01 00 00       	jmp    6df <printf+0x177>
      } else {
        putc(fd, c);
 5b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5bb:	0f be c0             	movsbl %al,%eax
 5be:	83 ec 08             	sub    $0x8,%esp
 5c1:	50                   	push   %eax
 5c2:	ff 75 08             	pushl  0x8(%ebp)
 5c5:	e8 c9 fe ff ff       	call   493 <putc>
 5ca:	83 c4 10             	add    $0x10,%esp
 5cd:	e9 0d 01 00 00       	jmp    6df <printf+0x177>
      }
    } else if(state == '%'){
 5d2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5d6:	0f 85 03 01 00 00    	jne    6df <printf+0x177>
      if(c == 'd'){
 5dc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5e0:	75 1e                	jne    600 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e5:	8b 00                	mov    (%eax),%eax
 5e7:	6a 01                	push   $0x1
 5e9:	6a 0a                	push   $0xa
 5eb:	50                   	push   %eax
 5ec:	ff 75 08             	pushl  0x8(%ebp)
 5ef:	e8 c1 fe ff ff       	call   4b5 <printint>
 5f4:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5fb:	e9 d8 00 00 00       	jmp    6d8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 600:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 604:	74 06                	je     60c <printf+0xa4>
 606:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 60a:	75 1e                	jne    62a <printf+0xc2>
        printint(fd, *ap, 16, 0);
 60c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60f:	8b 00                	mov    (%eax),%eax
 611:	6a 00                	push   $0x0
 613:	6a 10                	push   $0x10
 615:	50                   	push   %eax
 616:	ff 75 08             	pushl  0x8(%ebp)
 619:	e8 97 fe ff ff       	call   4b5 <printint>
 61e:	83 c4 10             	add    $0x10,%esp
        ap++;
 621:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 625:	e9 ae 00 00 00       	jmp    6d8 <printf+0x170>
      } else if(c == 's'){
 62a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 62e:	75 43                	jne    673 <printf+0x10b>
        s = (char*)*ap;
 630:	8b 45 e8             	mov    -0x18(%ebp),%eax
 633:	8b 00                	mov    (%eax),%eax
 635:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 638:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 63c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 640:	75 07                	jne    649 <printf+0xe1>
          s = "(null)";
 642:	c7 45 f4 5b 09 00 00 	movl   $0x95b,-0xc(%ebp)
        while(*s != 0){
 649:	eb 1c                	jmp    667 <printf+0xff>
          putc(fd, *s);
 64b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 64e:	0f b6 00             	movzbl (%eax),%eax
 651:	0f be c0             	movsbl %al,%eax
 654:	83 ec 08             	sub    $0x8,%esp
 657:	50                   	push   %eax
 658:	ff 75 08             	pushl  0x8(%ebp)
 65b:	e8 33 fe ff ff       	call   493 <putc>
 660:	83 c4 10             	add    $0x10,%esp
          s++;
 663:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 667:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66a:	0f b6 00             	movzbl (%eax),%eax
 66d:	84 c0                	test   %al,%al
 66f:	75 da                	jne    64b <printf+0xe3>
 671:	eb 65                	jmp    6d8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 673:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 677:	75 1d                	jne    696 <printf+0x12e>
        putc(fd, *ap);
 679:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	0f be c0             	movsbl %al,%eax
 681:	83 ec 08             	sub    $0x8,%esp
 684:	50                   	push   %eax
 685:	ff 75 08             	pushl  0x8(%ebp)
 688:	e8 06 fe ff ff       	call   493 <putc>
 68d:	83 c4 10             	add    $0x10,%esp
        ap++;
 690:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 694:	eb 42                	jmp    6d8 <printf+0x170>
      } else if(c == '%'){
 696:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 69a:	75 17                	jne    6b3 <printf+0x14b>
        putc(fd, c);
 69c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 69f:	0f be c0             	movsbl %al,%eax
 6a2:	83 ec 08             	sub    $0x8,%esp
 6a5:	50                   	push   %eax
 6a6:	ff 75 08             	pushl  0x8(%ebp)
 6a9:	e8 e5 fd ff ff       	call   493 <putc>
 6ae:	83 c4 10             	add    $0x10,%esp
 6b1:	eb 25                	jmp    6d8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b3:	83 ec 08             	sub    $0x8,%esp
 6b6:	6a 25                	push   $0x25
 6b8:	ff 75 08             	pushl  0x8(%ebp)
 6bb:	e8 d3 fd ff ff       	call   493 <putc>
 6c0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c6:	0f be c0             	movsbl %al,%eax
 6c9:	83 ec 08             	sub    $0x8,%esp
 6cc:	50                   	push   %eax
 6cd:	ff 75 08             	pushl  0x8(%ebp)
 6d0:	e8 be fd ff ff       	call   493 <putc>
 6d5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6df:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6e3:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e9:	01 d0                	add    %edx,%eax
 6eb:	0f b6 00             	movzbl (%eax),%eax
 6ee:	84 c0                	test   %al,%al
 6f0:	0f 85 94 fe ff ff    	jne    58a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6f6:	c9                   	leave  
 6f7:	c3                   	ret    

000006f8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f8:	55                   	push   %ebp
 6f9:	89 e5                	mov    %esp,%ebp
 6fb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6fe:	8b 45 08             	mov    0x8(%ebp),%eax
 701:	83 e8 08             	sub    $0x8,%eax
 704:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 707:	a1 30 0c 00 00       	mov    0xc30,%eax
 70c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 70f:	eb 24                	jmp    735 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 00                	mov    (%eax),%eax
 716:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 719:	77 12                	ja     72d <free+0x35>
 71b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 721:	77 24                	ja     747 <free+0x4f>
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	8b 00                	mov    (%eax),%eax
 728:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72b:	77 1a                	ja     747 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 72d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 730:	8b 00                	mov    (%eax),%eax
 732:	89 45 fc             	mov    %eax,-0x4(%ebp)
 735:	8b 45 f8             	mov    -0x8(%ebp),%eax
 738:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 73b:	76 d4                	jbe    711 <free+0x19>
 73d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 740:	8b 00                	mov    (%eax),%eax
 742:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 745:	76 ca                	jbe    711 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 747:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74a:	8b 40 04             	mov    0x4(%eax),%eax
 74d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 754:	8b 45 f8             	mov    -0x8(%ebp),%eax
 757:	01 c2                	add    %eax,%edx
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 00                	mov    (%eax),%eax
 75e:	39 c2                	cmp    %eax,%edx
 760:	75 24                	jne    786 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 762:	8b 45 f8             	mov    -0x8(%ebp),%eax
 765:	8b 50 04             	mov    0x4(%eax),%edx
 768:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76b:	8b 00                	mov    (%eax),%eax
 76d:	8b 40 04             	mov    0x4(%eax),%eax
 770:	01 c2                	add    %eax,%edx
 772:	8b 45 f8             	mov    -0x8(%ebp),%eax
 775:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 778:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77b:	8b 00                	mov    (%eax),%eax
 77d:	8b 10                	mov    (%eax),%edx
 77f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 782:	89 10                	mov    %edx,(%eax)
 784:	eb 0a                	jmp    790 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 786:	8b 45 fc             	mov    -0x4(%ebp),%eax
 789:	8b 10                	mov    (%eax),%edx
 78b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 790:	8b 45 fc             	mov    -0x4(%ebp),%eax
 793:	8b 40 04             	mov    0x4(%eax),%eax
 796:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a0:	01 d0                	add    %edx,%eax
 7a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a5:	75 20                	jne    7c7 <free+0xcf>
    p->s.size += bp->s.size;
 7a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7aa:	8b 50 04             	mov    0x4(%eax),%edx
 7ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b0:	8b 40 04             	mov    0x4(%eax),%eax
 7b3:	01 c2                	add    %eax,%edx
 7b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7be:	8b 10                	mov    (%eax),%edx
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	89 10                	mov    %edx,(%eax)
 7c5:	eb 08                	jmp    7cf <free+0xd7>
  } else
    p->s.ptr = bp;
 7c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7cd:	89 10                	mov    %edx,(%eax)
  freep = p;
 7cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d2:	a3 30 0c 00 00       	mov    %eax,0xc30
}
 7d7:	c9                   	leave  
 7d8:	c3                   	ret    

000007d9 <morecore>:

static Header*
morecore(uint nu)
{
 7d9:	55                   	push   %ebp
 7da:	89 e5                	mov    %esp,%ebp
 7dc:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7df:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e6:	77 07                	ja     7ef <morecore+0x16>
    nu = 4096;
 7e8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7ef:	8b 45 08             	mov    0x8(%ebp),%eax
 7f2:	c1 e0 03             	shl    $0x3,%eax
 7f5:	83 ec 0c             	sub    $0xc,%esp
 7f8:	50                   	push   %eax
 7f9:	e8 75 fc ff ff       	call   473 <sbrk>
 7fe:	83 c4 10             	add    $0x10,%esp
 801:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 804:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 808:	75 07                	jne    811 <morecore+0x38>
    return 0;
 80a:	b8 00 00 00 00       	mov    $0x0,%eax
 80f:	eb 26                	jmp    837 <morecore+0x5e>
  hp = (Header*)p;
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 817:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81a:	8b 55 08             	mov    0x8(%ebp),%edx
 81d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 820:	8b 45 f0             	mov    -0x10(%ebp),%eax
 823:	83 c0 08             	add    $0x8,%eax
 826:	83 ec 0c             	sub    $0xc,%esp
 829:	50                   	push   %eax
 82a:	e8 c9 fe ff ff       	call   6f8 <free>
 82f:	83 c4 10             	add    $0x10,%esp
  return freep;
 832:	a1 30 0c 00 00       	mov    0xc30,%eax
}
 837:	c9                   	leave  
 838:	c3                   	ret    

00000839 <malloc>:

void*
malloc(uint nbytes)
{
 839:	55                   	push   %ebp
 83a:	89 e5                	mov    %esp,%ebp
 83c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83f:	8b 45 08             	mov    0x8(%ebp),%eax
 842:	83 c0 07             	add    $0x7,%eax
 845:	c1 e8 03             	shr    $0x3,%eax
 848:	83 c0 01             	add    $0x1,%eax
 84b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 84e:	a1 30 0c 00 00       	mov    0xc30,%eax
 853:	89 45 f0             	mov    %eax,-0x10(%ebp)
 856:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 85a:	75 23                	jne    87f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 85c:	c7 45 f0 28 0c 00 00 	movl   $0xc28,-0x10(%ebp)
 863:	8b 45 f0             	mov    -0x10(%ebp),%eax
 866:	a3 30 0c 00 00       	mov    %eax,0xc30
 86b:	a1 30 0c 00 00       	mov    0xc30,%eax
 870:	a3 28 0c 00 00       	mov    %eax,0xc28
    base.s.size = 0;
 875:	c7 05 2c 0c 00 00 00 	movl   $0x0,0xc2c
 87c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 882:	8b 00                	mov    (%eax),%eax
 884:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	8b 40 04             	mov    0x4(%eax),%eax
 88d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 890:	72 4d                	jb     8df <malloc+0xa6>
      if(p->s.size == nunits)
 892:	8b 45 f4             	mov    -0xc(%ebp),%eax
 895:	8b 40 04             	mov    0x4(%eax),%eax
 898:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 89b:	75 0c                	jne    8a9 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 89d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a0:	8b 10                	mov    (%eax),%edx
 8a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a5:	89 10                	mov    %edx,(%eax)
 8a7:	eb 26                	jmp    8cf <malloc+0x96>
      else {
        p->s.size -= nunits;
 8a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ac:	8b 40 04             	mov    0x4(%eax),%eax
 8af:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8b2:	89 c2                	mov    %eax,%edx
 8b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b7:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bd:	8b 40 04             	mov    0x4(%eax),%eax
 8c0:	c1 e0 03             	shl    $0x3,%eax
 8c3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c9:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8cc:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d2:	a3 30 0c 00 00       	mov    %eax,0xc30
      return (void*)(p + 1);
 8d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8da:	83 c0 08             	add    $0x8,%eax
 8dd:	eb 3b                	jmp    91a <malloc+0xe1>
    }
    if(p == freep)
 8df:	a1 30 0c 00 00       	mov    0xc30,%eax
 8e4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8e7:	75 1e                	jne    907 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8e9:	83 ec 0c             	sub    $0xc,%esp
 8ec:	ff 75 ec             	pushl  -0x14(%ebp)
 8ef:	e8 e5 fe ff ff       	call   7d9 <morecore>
 8f4:	83 c4 10             	add    $0x10,%esp
 8f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8fe:	75 07                	jne    907 <malloc+0xce>
        return 0;
 900:	b8 00 00 00 00       	mov    $0x0,%eax
 905:	eb 13                	jmp    91a <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 907:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 90d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 910:	8b 00                	mov    (%eax),%eax
 912:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 915:	e9 6d ff ff ff       	jmp    887 <malloc+0x4e>
}
 91a:	c9                   	leave  
 91b:	c3                   	ret    
