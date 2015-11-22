
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	83 ec 0c             	sub    $0xc,%esp
   a:	ff 75 08             	pushl  0x8(%ebp)
   d:	e8 d2 03 00 00       	call   3e4 <strlen>
  12:	83 c4 10             	add    $0x10,%esp
  15:	89 c2                	mov    %eax,%edx
  17:	8b 45 08             	mov    0x8(%ebp),%eax
  1a:	01 d0                	add    %edx,%eax
  1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1f:	eb 04                	jmp    25 <fmtname+0x25>
  21:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  28:	3b 45 08             	cmp    0x8(%ebp),%eax
  2b:	72 0a                	jb     37 <fmtname+0x37>
  2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  30:	0f b6 00             	movzbl (%eax),%eax
  33:	3c 2f                	cmp    $0x2f,%al
  35:	75 ea                	jne    21 <fmtname+0x21>
    ;
  p++;
  37:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	ff 75 f4             	pushl  -0xc(%ebp)
  41:	e8 9e 03 00 00       	call   3e4 <strlen>
  46:	83 c4 10             	add    $0x10,%esp
  49:	83 f8 0d             	cmp    $0xd,%eax
  4c:	76 05                	jbe    53 <fmtname+0x53>
    return p;
  4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  51:	eb 60                	jmp    b3 <fmtname+0xb3>
  memmove(buf, p, strlen(p));
  53:	83 ec 0c             	sub    $0xc,%esp
  56:	ff 75 f4             	pushl  -0xc(%ebp)
  59:	e8 86 03 00 00       	call   3e4 <strlen>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	83 ec 04             	sub    $0x4,%esp
  64:	50                   	push   %eax
  65:	ff 75 f4             	pushl  -0xc(%ebp)
  68:	68 dc 0d 00 00       	push   $0xddc
  6d:	e8 ee 04 00 00       	call   560 <memmove>
  72:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  75:	83 ec 0c             	sub    $0xc,%esp
  78:	ff 75 f4             	pushl  -0xc(%ebp)
  7b:	e8 64 03 00 00       	call   3e4 <strlen>
  80:	83 c4 10             	add    $0x10,%esp
  83:	ba 0e 00 00 00       	mov    $0xe,%edx
  88:	89 d3                	mov    %edx,%ebx
  8a:	29 c3                	sub    %eax,%ebx
  8c:	83 ec 0c             	sub    $0xc,%esp
  8f:	ff 75 f4             	pushl  -0xc(%ebp)
  92:	e8 4d 03 00 00       	call   3e4 <strlen>
  97:	83 c4 10             	add    $0x10,%esp
  9a:	05 dc 0d 00 00       	add    $0xddc,%eax
  9f:	83 ec 04             	sub    $0x4,%esp
  a2:	53                   	push   %ebx
  a3:	6a 20                	push   $0x20
  a5:	50                   	push   %eax
  a6:	e8 60 03 00 00       	call   40b <memset>
  ab:	83 c4 10             	add    $0x10,%esp
  return buf;
  ae:	b8 dc 0d 00 00       	mov    $0xddc,%eax
}
  b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b6:	c9                   	leave  
  b7:	c3                   	ret    

000000b8 <ls>:

void
ls(char *path)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	57                   	push   %edi
  bc:	56                   	push   %esi
  bd:	53                   	push   %ebx
  be:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  c4:	83 ec 08             	sub    $0x8,%esp
  c7:	6a 00                	push   $0x0
  c9:	ff 75 08             	pushl  0x8(%ebp)
  cc:	e8 14 05 00 00       	call   5e5 <open>
  d1:	83 c4 10             	add    $0x10,%esp
  d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  db:	79 1a                	jns    f7 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
  dd:	83 ec 04             	sub    $0x4,%esp
  e0:	ff 75 08             	pushl  0x8(%ebp)
  e3:	68 d6 0a 00 00       	push   $0xad6
  e8:	6a 02                	push   $0x2
  ea:	e8 33 06 00 00       	call   722 <printf>
  ef:	83 c4 10             	add    $0x10,%esp
    return;
  f2:	e9 e3 01 00 00       	jmp    2da <ls+0x222>
  }
  
  if(fstat(fd, &st) < 0){
  f7:	83 ec 08             	sub    $0x8,%esp
  fa:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 100:	50                   	push   %eax
 101:	ff 75 e4             	pushl  -0x1c(%ebp)
 104:	e8 f4 04 00 00       	call   5fd <fstat>
 109:	83 c4 10             	add    $0x10,%esp
 10c:	85 c0                	test   %eax,%eax
 10e:	79 28                	jns    138 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
 110:	83 ec 04             	sub    $0x4,%esp
 113:	ff 75 08             	pushl  0x8(%ebp)
 116:	68 ea 0a 00 00       	push   $0xaea
 11b:	6a 02                	push   $0x2
 11d:	e8 00 06 00 00       	call   722 <printf>
 122:	83 c4 10             	add    $0x10,%esp
    close(fd);
 125:	83 ec 0c             	sub    $0xc,%esp
 128:	ff 75 e4             	pushl  -0x1c(%ebp)
 12b:	e8 9d 04 00 00       	call   5cd <close>
 130:	83 c4 10             	add    $0x10,%esp
    return;
 133:	e9 a2 01 00 00       	jmp    2da <ls+0x222>
  }
  
  switch(st.type){
 138:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 13f:	98                   	cwtl   
 140:	83 f8 01             	cmp    $0x1,%eax
 143:	74 48                	je     18d <ls+0xd5>
 145:	83 f8 02             	cmp    $0x2,%eax
 148:	0f 85 7e 01 00 00    	jne    2cc <ls+0x214>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 14e:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 154:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 15a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 161:	0f bf d8             	movswl %ax,%ebx
 164:	83 ec 0c             	sub    $0xc,%esp
 167:	ff 75 08             	pushl  0x8(%ebp)
 16a:	e8 91 fe ff ff       	call   0 <fmtname>
 16f:	83 c4 10             	add    $0x10,%esp
 172:	83 ec 08             	sub    $0x8,%esp
 175:	57                   	push   %edi
 176:	56                   	push   %esi
 177:	53                   	push   %ebx
 178:	50                   	push   %eax
 179:	68 fe 0a 00 00       	push   $0xafe
 17e:	6a 01                	push   $0x1
 180:	e8 9d 05 00 00       	call   722 <printf>
 185:	83 c4 20             	add    $0x20,%esp
    break;
 188:	e9 3f 01 00 00       	jmp    2cc <ls+0x214>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 18d:	83 ec 0c             	sub    $0xc,%esp
 190:	ff 75 08             	pushl  0x8(%ebp)
 193:	e8 4c 02 00 00       	call   3e4 <strlen>
 198:	83 c4 10             	add    $0x10,%esp
 19b:	83 c0 10             	add    $0x10,%eax
 19e:	3d 00 02 00 00       	cmp    $0x200,%eax
 1a3:	76 17                	jbe    1bc <ls+0x104>
      printf(1, "ls: path too long\n");
 1a5:	83 ec 08             	sub    $0x8,%esp
 1a8:	68 0b 0b 00 00       	push   $0xb0b
 1ad:	6a 01                	push   $0x1
 1af:	e8 6e 05 00 00       	call   722 <printf>
 1b4:	83 c4 10             	add    $0x10,%esp
      break;
 1b7:	e9 10 01 00 00       	jmp    2cc <ls+0x214>
    }
    strcpy(buf, path);
 1bc:	83 ec 08             	sub    $0x8,%esp
 1bf:	ff 75 08             	pushl  0x8(%ebp)
 1c2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1c8:	50                   	push   %eax
 1c9:	e8 a7 01 00 00       	call   375 <strcpy>
 1ce:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1d1:	83 ec 0c             	sub    $0xc,%esp
 1d4:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1da:	50                   	push   %eax
 1db:	e8 04 02 00 00       	call   3e4 <strlen>
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	89 c2                	mov    %eax,%edx
 1e5:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1eb:	01 d0                	add    %edx,%eax
 1ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1f3:	8d 50 01             	lea    0x1(%eax),%edx
 1f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
 1f9:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fc:	e9 aa 00 00 00       	jmp    2ab <ls+0x1f3>
      if(de.inum == 0)
 201:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 208:	66 85 c0             	test   %ax,%ax
 20b:	75 05                	jne    212 <ls+0x15a>
        continue;
 20d:	e9 99 00 00 00       	jmp    2ab <ls+0x1f3>
      memmove(p, de.name, DIRSIZ);
 212:	83 ec 04             	sub    $0x4,%esp
 215:	6a 0e                	push   $0xe
 217:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 21d:	83 c0 02             	add    $0x2,%eax
 220:	50                   	push   %eax
 221:	ff 75 e0             	pushl  -0x20(%ebp)
 224:	e8 37 03 00 00       	call   560 <memmove>
 229:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
 22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
 22f:	83 c0 0e             	add    $0xe,%eax
 232:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 235:	83 ec 08             	sub    $0x8,%esp
 238:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 23e:	50                   	push   %eax
 23f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 245:	50                   	push   %eax
 246:	e8 7b 02 00 00       	call   4c6 <stat>
 24b:	83 c4 10             	add    $0x10,%esp
 24e:	85 c0                	test   %eax,%eax
 250:	79 1b                	jns    26d <ls+0x1b5>
        printf(1, "ls: cannot stat %s\n", buf);
 252:	83 ec 04             	sub    $0x4,%esp
 255:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 25b:	50                   	push   %eax
 25c:	68 ea 0a 00 00       	push   $0xaea
 261:	6a 01                	push   $0x1
 263:	e8 ba 04 00 00       	call   722 <printf>
 268:	83 c4 10             	add    $0x10,%esp
        continue;
 26b:	eb 3e                	jmp    2ab <ls+0x1f3>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 26d:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 273:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 279:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 280:	0f bf d8             	movswl %ax,%ebx
 283:	83 ec 0c             	sub    $0xc,%esp
 286:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 28c:	50                   	push   %eax
 28d:	e8 6e fd ff ff       	call   0 <fmtname>
 292:	83 c4 10             	add    $0x10,%esp
 295:	83 ec 08             	sub    $0x8,%esp
 298:	57                   	push   %edi
 299:	56                   	push   %esi
 29a:	53                   	push   %ebx
 29b:	50                   	push   %eax
 29c:	68 fe 0a 00 00       	push   $0xafe
 2a1:	6a 01                	push   $0x1
 2a3:	e8 7a 04 00 00       	call   722 <printf>
 2a8:	83 c4 20             	add    $0x20,%esp
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2ab:	83 ec 04             	sub    $0x4,%esp
 2ae:	6a 10                	push   $0x10
 2b0:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2b6:	50                   	push   %eax
 2b7:	ff 75 e4             	pushl  -0x1c(%ebp)
 2ba:	e8 fe 02 00 00       	call   5bd <read>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	83 f8 10             	cmp    $0x10,%eax
 2c5:	0f 84 36 ff ff ff    	je     201 <ls+0x149>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2cb:	90                   	nop
  }
  close(fd);
 2cc:	83 ec 0c             	sub    $0xc,%esp
 2cf:	ff 75 e4             	pushl  -0x1c(%ebp)
 2d2:	e8 f6 02 00 00       	call   5cd <close>
 2d7:	83 c4 10             	add    $0x10,%esp
}
 2da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2dd:	5b                   	pop    %ebx
 2de:	5e                   	pop    %esi
 2df:	5f                   	pop    %edi
 2e0:	5d                   	pop    %ebp
 2e1:	c3                   	ret    

000002e2 <main>:

int
main(int argc, char *argv[])
{
 2e2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2e6:	83 e4 f0             	and    $0xfffffff0,%esp
 2e9:	ff 71 fc             	pushl  -0x4(%ecx)
 2ec:	55                   	push   %ebp
 2ed:	89 e5                	mov    %esp,%ebp
 2ef:	53                   	push   %ebx
 2f0:	51                   	push   %ecx
 2f1:	83 ec 10             	sub    $0x10,%esp
 2f4:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
 2f6:	83 3b 01             	cmpl   $0x1,(%ebx)
 2f9:	7f 1a                	jg     315 <main+0x33>
    ls(".");
 2fb:	83 ec 0c             	sub    $0xc,%esp
 2fe:	68 1e 0b 00 00       	push   $0xb1e
 303:	e8 b0 fd ff ff       	call   b8 <ls>
 308:	83 c4 10             	add    $0x10,%esp
    exit(EXIT_STATUS_OK);
 30b:	83 ec 0c             	sub    $0xc,%esp
 30e:	6a 01                	push   $0x1
 310:	e8 90 02 00 00       	call   5a5 <exit>
  }
  for(i=1; i<argc; i++)
 315:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 31c:	eb 21                	jmp    33f <main+0x5d>
    ls(argv[i]);
 31e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 321:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 328:	8b 43 04             	mov    0x4(%ebx),%eax
 32b:	01 d0                	add    %edx,%eax
 32d:	8b 00                	mov    (%eax),%eax
 32f:	83 ec 0c             	sub    $0xc,%esp
 332:	50                   	push   %eax
 333:	e8 80 fd ff ff       	call   b8 <ls>
 338:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    ls(".");
    exit(EXIT_STATUS_OK);
  }
  for(i=1; i<argc; i++)
 33b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 33f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 342:	3b 03                	cmp    (%ebx),%eax
 344:	7c d8                	jl     31e <main+0x3c>
    ls(argv[i]);
  exit(EXIT_STATUS_OK);
 346:	83 ec 0c             	sub    $0xc,%esp
 349:	6a 01                	push   $0x1
 34b:	e8 55 02 00 00       	call   5a5 <exit>

00000350 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 355:	8b 4d 08             	mov    0x8(%ebp),%ecx
 358:	8b 55 10             	mov    0x10(%ebp),%edx
 35b:	8b 45 0c             	mov    0xc(%ebp),%eax
 35e:	89 cb                	mov    %ecx,%ebx
 360:	89 df                	mov    %ebx,%edi
 362:	89 d1                	mov    %edx,%ecx
 364:	fc                   	cld    
 365:	f3 aa                	rep stos %al,%es:(%edi)
 367:	89 ca                	mov    %ecx,%edx
 369:	89 fb                	mov    %edi,%ebx
 36b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 36e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 371:	5b                   	pop    %ebx
 372:	5f                   	pop    %edi
 373:	5d                   	pop    %ebp
 374:	c3                   	ret    

00000375 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 375:	55                   	push   %ebp
 376:	89 e5                	mov    %esp,%ebp
 378:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 37b:	8b 45 08             	mov    0x8(%ebp),%eax
 37e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 381:	90                   	nop
 382:	8b 45 08             	mov    0x8(%ebp),%eax
 385:	8d 50 01             	lea    0x1(%eax),%edx
 388:	89 55 08             	mov    %edx,0x8(%ebp)
 38b:	8b 55 0c             	mov    0xc(%ebp),%edx
 38e:	8d 4a 01             	lea    0x1(%edx),%ecx
 391:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 394:	0f b6 12             	movzbl (%edx),%edx
 397:	88 10                	mov    %dl,(%eax)
 399:	0f b6 00             	movzbl (%eax),%eax
 39c:	84 c0                	test   %al,%al
 39e:	75 e2                	jne    382 <strcpy+0xd>
    ;
  return os;
 3a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3a3:	c9                   	leave  
 3a4:	c3                   	ret    

000003a5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a5:	55                   	push   %ebp
 3a6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 3a8:	eb 08                	jmp    3b2 <strcmp+0xd>
    p++, q++;
 3aa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3ae:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3b2:	8b 45 08             	mov    0x8(%ebp),%eax
 3b5:	0f b6 00             	movzbl (%eax),%eax
 3b8:	84 c0                	test   %al,%al
 3ba:	74 10                	je     3cc <strcmp+0x27>
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	0f b6 10             	movzbl (%eax),%edx
 3c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c5:	0f b6 00             	movzbl (%eax),%eax
 3c8:	38 c2                	cmp    %al,%dl
 3ca:	74 de                	je     3aa <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3cc:	8b 45 08             	mov    0x8(%ebp),%eax
 3cf:	0f b6 00             	movzbl (%eax),%eax
 3d2:	0f b6 d0             	movzbl %al,%edx
 3d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d8:	0f b6 00             	movzbl (%eax),%eax
 3db:	0f b6 c0             	movzbl %al,%eax
 3de:	29 c2                	sub    %eax,%edx
 3e0:	89 d0                	mov    %edx,%eax
}
 3e2:	5d                   	pop    %ebp
 3e3:	c3                   	ret    

000003e4 <strlen>:

uint
strlen(char *s)
{
 3e4:	55                   	push   %ebp
 3e5:	89 e5                	mov    %esp,%ebp
 3e7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3f1:	eb 04                	jmp    3f7 <strlen+0x13>
 3f3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3fa:	8b 45 08             	mov    0x8(%ebp),%eax
 3fd:	01 d0                	add    %edx,%eax
 3ff:	0f b6 00             	movzbl (%eax),%eax
 402:	84 c0                	test   %al,%al
 404:	75 ed                	jne    3f3 <strlen+0xf>
    ;
  return n;
 406:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 409:	c9                   	leave  
 40a:	c3                   	ret    

0000040b <memset>:

void*
memset(void *dst, int c, uint n)
{
 40b:	55                   	push   %ebp
 40c:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 40e:	8b 45 10             	mov    0x10(%ebp),%eax
 411:	50                   	push   %eax
 412:	ff 75 0c             	pushl  0xc(%ebp)
 415:	ff 75 08             	pushl  0x8(%ebp)
 418:	e8 33 ff ff ff       	call   350 <stosb>
 41d:	83 c4 0c             	add    $0xc,%esp
  return dst;
 420:	8b 45 08             	mov    0x8(%ebp),%eax
}
 423:	c9                   	leave  
 424:	c3                   	ret    

00000425 <strchr>:

char*
strchr(const char *s, char c)
{
 425:	55                   	push   %ebp
 426:	89 e5                	mov    %esp,%ebp
 428:	83 ec 04             	sub    $0x4,%esp
 42b:	8b 45 0c             	mov    0xc(%ebp),%eax
 42e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 431:	eb 14                	jmp    447 <strchr+0x22>
    if(*s == c)
 433:	8b 45 08             	mov    0x8(%ebp),%eax
 436:	0f b6 00             	movzbl (%eax),%eax
 439:	3a 45 fc             	cmp    -0x4(%ebp),%al
 43c:	75 05                	jne    443 <strchr+0x1e>
      return (char*)s;
 43e:	8b 45 08             	mov    0x8(%ebp),%eax
 441:	eb 13                	jmp    456 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 443:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 447:	8b 45 08             	mov    0x8(%ebp),%eax
 44a:	0f b6 00             	movzbl (%eax),%eax
 44d:	84 c0                	test   %al,%al
 44f:	75 e2                	jne    433 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 451:	b8 00 00 00 00       	mov    $0x0,%eax
}
 456:	c9                   	leave  
 457:	c3                   	ret    

00000458 <gets>:

char*
gets(char *buf, int max)
{
 458:	55                   	push   %ebp
 459:	89 e5                	mov    %esp,%ebp
 45b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 45e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 465:	eb 44                	jmp    4ab <gets+0x53>
    cc = read(0, &c, 1);
 467:	83 ec 04             	sub    $0x4,%esp
 46a:	6a 01                	push   $0x1
 46c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 46f:	50                   	push   %eax
 470:	6a 00                	push   $0x0
 472:	e8 46 01 00 00       	call   5bd <read>
 477:	83 c4 10             	add    $0x10,%esp
 47a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 47d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 481:	7f 02                	jg     485 <gets+0x2d>
      break;
 483:	eb 31                	jmp    4b6 <gets+0x5e>
    buf[i++] = c;
 485:	8b 45 f4             	mov    -0xc(%ebp),%eax
 488:	8d 50 01             	lea    0x1(%eax),%edx
 48b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48e:	89 c2                	mov    %eax,%edx
 490:	8b 45 08             	mov    0x8(%ebp),%eax
 493:	01 c2                	add    %eax,%edx
 495:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 499:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 49b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 49f:	3c 0a                	cmp    $0xa,%al
 4a1:	74 13                	je     4b6 <gets+0x5e>
 4a3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 4a7:	3c 0d                	cmp    $0xd,%al
 4a9:	74 0b                	je     4b6 <gets+0x5e>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ae:	83 c0 01             	add    $0x1,%eax
 4b1:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4b4:	7c b1                	jl     467 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4b9:	8b 45 08             	mov    0x8(%ebp),%eax
 4bc:	01 d0                	add    %edx,%eax
 4be:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4c1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4c4:	c9                   	leave  
 4c5:	c3                   	ret    

000004c6 <stat>:

int
stat(char *n, struct stat *st)
{
 4c6:	55                   	push   %ebp
 4c7:	89 e5                	mov    %esp,%ebp
 4c9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4cc:	83 ec 08             	sub    $0x8,%esp
 4cf:	6a 00                	push   $0x0
 4d1:	ff 75 08             	pushl  0x8(%ebp)
 4d4:	e8 0c 01 00 00       	call   5e5 <open>
 4d9:	83 c4 10             	add    $0x10,%esp
 4dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e3:	79 07                	jns    4ec <stat+0x26>
    return -1;
 4e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4ea:	eb 25                	jmp    511 <stat+0x4b>
  r = fstat(fd, st);
 4ec:	83 ec 08             	sub    $0x8,%esp
 4ef:	ff 75 0c             	pushl  0xc(%ebp)
 4f2:	ff 75 f4             	pushl  -0xc(%ebp)
 4f5:	e8 03 01 00 00       	call   5fd <fstat>
 4fa:	83 c4 10             	add    $0x10,%esp
 4fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 500:	83 ec 0c             	sub    $0xc,%esp
 503:	ff 75 f4             	pushl  -0xc(%ebp)
 506:	e8 c2 00 00 00       	call   5cd <close>
 50b:	83 c4 10             	add    $0x10,%esp
  return r;
 50e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 511:	c9                   	leave  
 512:	c3                   	ret    

00000513 <atoi>:

int
atoi(const char *s)
{
 513:	55                   	push   %ebp
 514:	89 e5                	mov    %esp,%ebp
 516:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 519:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 520:	eb 25                	jmp    547 <atoi+0x34>
    n = n*10 + *s++ - '0';
 522:	8b 55 fc             	mov    -0x4(%ebp),%edx
 525:	89 d0                	mov    %edx,%eax
 527:	c1 e0 02             	shl    $0x2,%eax
 52a:	01 d0                	add    %edx,%eax
 52c:	01 c0                	add    %eax,%eax
 52e:	89 c1                	mov    %eax,%ecx
 530:	8b 45 08             	mov    0x8(%ebp),%eax
 533:	8d 50 01             	lea    0x1(%eax),%edx
 536:	89 55 08             	mov    %edx,0x8(%ebp)
 539:	0f b6 00             	movzbl (%eax),%eax
 53c:	0f be c0             	movsbl %al,%eax
 53f:	01 c8                	add    %ecx,%eax
 541:	83 e8 30             	sub    $0x30,%eax
 544:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 547:	8b 45 08             	mov    0x8(%ebp),%eax
 54a:	0f b6 00             	movzbl (%eax),%eax
 54d:	3c 2f                	cmp    $0x2f,%al
 54f:	7e 0a                	jle    55b <atoi+0x48>
 551:	8b 45 08             	mov    0x8(%ebp),%eax
 554:	0f b6 00             	movzbl (%eax),%eax
 557:	3c 39                	cmp    $0x39,%al
 559:	7e c7                	jle    522 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 55b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 55e:	c9                   	leave  
 55f:	c3                   	ret    

00000560 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 566:	8b 45 08             	mov    0x8(%ebp),%eax
 569:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 56c:	8b 45 0c             	mov    0xc(%ebp),%eax
 56f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 572:	eb 17                	jmp    58b <memmove+0x2b>
    *dst++ = *src++;
 574:	8b 45 fc             	mov    -0x4(%ebp),%eax
 577:	8d 50 01             	lea    0x1(%eax),%edx
 57a:	89 55 fc             	mov    %edx,-0x4(%ebp)
 57d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 580:	8d 4a 01             	lea    0x1(%edx),%ecx
 583:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 586:	0f b6 12             	movzbl (%edx),%edx
 589:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 58b:	8b 45 10             	mov    0x10(%ebp),%eax
 58e:	8d 50 ff             	lea    -0x1(%eax),%edx
 591:	89 55 10             	mov    %edx,0x10(%ebp)
 594:	85 c0                	test   %eax,%eax
 596:	7f dc                	jg     574 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 598:	8b 45 08             	mov    0x8(%ebp),%eax
}
 59b:	c9                   	leave  
 59c:	c3                   	ret    

0000059d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 59d:	b8 01 00 00 00       	mov    $0x1,%eax
 5a2:	cd 40                	int    $0x40
 5a4:	c3                   	ret    

000005a5 <exit>:
SYSCALL(exit)
 5a5:	b8 02 00 00 00       	mov    $0x2,%eax
 5aa:	cd 40                	int    $0x40
 5ac:	c3                   	ret    

000005ad <wait>:
SYSCALL(wait)
 5ad:	b8 03 00 00 00       	mov    $0x3,%eax
 5b2:	cd 40                	int    $0x40
 5b4:	c3                   	ret    

000005b5 <pipe>:
SYSCALL(pipe)
 5b5:	b8 04 00 00 00       	mov    $0x4,%eax
 5ba:	cd 40                	int    $0x40
 5bc:	c3                   	ret    

000005bd <read>:
SYSCALL(read)
 5bd:	b8 05 00 00 00       	mov    $0x5,%eax
 5c2:	cd 40                	int    $0x40
 5c4:	c3                   	ret    

000005c5 <write>:
SYSCALL(write)
 5c5:	b8 10 00 00 00       	mov    $0x10,%eax
 5ca:	cd 40                	int    $0x40
 5cc:	c3                   	ret    

000005cd <close>:
SYSCALL(close)
 5cd:	b8 15 00 00 00       	mov    $0x15,%eax
 5d2:	cd 40                	int    $0x40
 5d4:	c3                   	ret    

000005d5 <kill>:
SYSCALL(kill)
 5d5:	b8 06 00 00 00       	mov    $0x6,%eax
 5da:	cd 40                	int    $0x40
 5dc:	c3                   	ret    

000005dd <exec>:
SYSCALL(exec)
 5dd:	b8 07 00 00 00       	mov    $0x7,%eax
 5e2:	cd 40                	int    $0x40
 5e4:	c3                   	ret    

000005e5 <open>:
SYSCALL(open)
 5e5:	b8 0f 00 00 00       	mov    $0xf,%eax
 5ea:	cd 40                	int    $0x40
 5ec:	c3                   	ret    

000005ed <mknod>:
SYSCALL(mknod)
 5ed:	b8 11 00 00 00       	mov    $0x11,%eax
 5f2:	cd 40                	int    $0x40
 5f4:	c3                   	ret    

000005f5 <unlink>:
SYSCALL(unlink)
 5f5:	b8 12 00 00 00       	mov    $0x12,%eax
 5fa:	cd 40                	int    $0x40
 5fc:	c3                   	ret    

000005fd <fstat>:
SYSCALL(fstat)
 5fd:	b8 08 00 00 00       	mov    $0x8,%eax
 602:	cd 40                	int    $0x40
 604:	c3                   	ret    

00000605 <link>:
SYSCALL(link)
 605:	b8 13 00 00 00       	mov    $0x13,%eax
 60a:	cd 40                	int    $0x40
 60c:	c3                   	ret    

0000060d <mkdir>:
SYSCALL(mkdir)
 60d:	b8 14 00 00 00       	mov    $0x14,%eax
 612:	cd 40                	int    $0x40
 614:	c3                   	ret    

00000615 <chdir>:
SYSCALL(chdir)
 615:	b8 09 00 00 00       	mov    $0x9,%eax
 61a:	cd 40                	int    $0x40
 61c:	c3                   	ret    

0000061d <dup>:
SYSCALL(dup)
 61d:	b8 0a 00 00 00       	mov    $0xa,%eax
 622:	cd 40                	int    $0x40
 624:	c3                   	ret    

00000625 <getpid>:
SYSCALL(getpid)
 625:	b8 0b 00 00 00       	mov    $0xb,%eax
 62a:	cd 40                	int    $0x40
 62c:	c3                   	ret    

0000062d <sbrk>:
SYSCALL(sbrk)
 62d:	b8 0c 00 00 00       	mov    $0xc,%eax
 632:	cd 40                	int    $0x40
 634:	c3                   	ret    

00000635 <sleep>:
SYSCALL(sleep)
 635:	b8 0d 00 00 00       	mov    $0xd,%eax
 63a:	cd 40                	int    $0x40
 63c:	c3                   	ret    

0000063d <uptime>:
SYSCALL(uptime)
 63d:	b8 0e 00 00 00       	mov    $0xe,%eax
 642:	cd 40                	int    $0x40
 644:	c3                   	ret    

00000645 <pstat>:
SYSCALL(pstat)
 645:	b8 16 00 00 00       	mov    $0x16,%eax
 64a:	cd 40                	int    $0x40
 64c:	c3                   	ret    

0000064d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 64d:	55                   	push   %ebp
 64e:	89 e5                	mov    %esp,%ebp
 650:	83 ec 18             	sub    $0x18,%esp
 653:	8b 45 0c             	mov    0xc(%ebp),%eax
 656:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 659:	83 ec 04             	sub    $0x4,%esp
 65c:	6a 01                	push   $0x1
 65e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 661:	50                   	push   %eax
 662:	ff 75 08             	pushl  0x8(%ebp)
 665:	e8 5b ff ff ff       	call   5c5 <write>
 66a:	83 c4 10             	add    $0x10,%esp
}
 66d:	c9                   	leave  
 66e:	c3                   	ret    

0000066f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 66f:	55                   	push   %ebp
 670:	89 e5                	mov    %esp,%ebp
 672:	53                   	push   %ebx
 673:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 676:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 67d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 681:	74 17                	je     69a <printint+0x2b>
 683:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 687:	79 11                	jns    69a <printint+0x2b>
    neg = 1;
 689:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 690:	8b 45 0c             	mov    0xc(%ebp),%eax
 693:	f7 d8                	neg    %eax
 695:	89 45 ec             	mov    %eax,-0x14(%ebp)
 698:	eb 06                	jmp    6a0 <printint+0x31>
  } else {
    x = xx;
 69a:	8b 45 0c             	mov    0xc(%ebp),%eax
 69d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6a7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 6aa:	8d 41 01             	lea    0x1(%ecx),%eax
 6ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6b0:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6b6:	ba 00 00 00 00       	mov    $0x0,%edx
 6bb:	f7 f3                	div    %ebx
 6bd:	89 d0                	mov    %edx,%eax
 6bf:	0f b6 80 c8 0d 00 00 	movzbl 0xdc8(%eax),%eax
 6c6:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 6ca:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6d0:	ba 00 00 00 00       	mov    $0x0,%edx
 6d5:	f7 f3                	div    %ebx
 6d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6da:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6de:	75 c7                	jne    6a7 <printint+0x38>
  if(neg)
 6e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6e4:	74 0e                	je     6f4 <printint+0x85>
    buf[i++] = '-';
 6e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e9:	8d 50 01             	lea    0x1(%eax),%edx
 6ec:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6ef:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6f4:	eb 1d                	jmp    713 <printint+0xa4>
    putc(fd, buf[i]);
 6f6:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fc:	01 d0                	add    %edx,%eax
 6fe:	0f b6 00             	movzbl (%eax),%eax
 701:	0f be c0             	movsbl %al,%eax
 704:	83 ec 08             	sub    $0x8,%esp
 707:	50                   	push   %eax
 708:	ff 75 08             	pushl  0x8(%ebp)
 70b:	e8 3d ff ff ff       	call   64d <putc>
 710:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 713:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 717:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 71b:	79 d9                	jns    6f6 <printint+0x87>
    putc(fd, buf[i]);
}
 71d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 720:	c9                   	leave  
 721:	c3                   	ret    

00000722 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 722:	55                   	push   %ebp
 723:	89 e5                	mov    %esp,%ebp
 725:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 728:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 72f:	8d 45 0c             	lea    0xc(%ebp),%eax
 732:	83 c0 04             	add    $0x4,%eax
 735:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 738:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 73f:	e9 59 01 00 00       	jmp    89d <printf+0x17b>
    c = fmt[i] & 0xff;
 744:	8b 55 0c             	mov    0xc(%ebp),%edx
 747:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74a:	01 d0                	add    %edx,%eax
 74c:	0f b6 00             	movzbl (%eax),%eax
 74f:	0f be c0             	movsbl %al,%eax
 752:	25 ff 00 00 00       	and    $0xff,%eax
 757:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 75a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 75e:	75 2c                	jne    78c <printf+0x6a>
      if(c == '%'){
 760:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 764:	75 0c                	jne    772 <printf+0x50>
        state = '%';
 766:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 76d:	e9 27 01 00 00       	jmp    899 <printf+0x177>
      } else {
        putc(fd, c);
 772:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 775:	0f be c0             	movsbl %al,%eax
 778:	83 ec 08             	sub    $0x8,%esp
 77b:	50                   	push   %eax
 77c:	ff 75 08             	pushl  0x8(%ebp)
 77f:	e8 c9 fe ff ff       	call   64d <putc>
 784:	83 c4 10             	add    $0x10,%esp
 787:	e9 0d 01 00 00       	jmp    899 <printf+0x177>
      }
    } else if(state == '%'){
 78c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 790:	0f 85 03 01 00 00    	jne    899 <printf+0x177>
      if(c == 'd'){
 796:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 79a:	75 1e                	jne    7ba <printf+0x98>
        printint(fd, *ap, 10, 1);
 79c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 79f:	8b 00                	mov    (%eax),%eax
 7a1:	6a 01                	push   $0x1
 7a3:	6a 0a                	push   $0xa
 7a5:	50                   	push   %eax
 7a6:	ff 75 08             	pushl  0x8(%ebp)
 7a9:	e8 c1 fe ff ff       	call   66f <printint>
 7ae:	83 c4 10             	add    $0x10,%esp
        ap++;
 7b1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7b5:	e9 d8 00 00 00       	jmp    892 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 7ba:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7be:	74 06                	je     7c6 <printf+0xa4>
 7c0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 7c4:	75 1e                	jne    7e4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 7c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7c9:	8b 00                	mov    (%eax),%eax
 7cb:	6a 00                	push   $0x0
 7cd:	6a 10                	push   $0x10
 7cf:	50                   	push   %eax
 7d0:	ff 75 08             	pushl  0x8(%ebp)
 7d3:	e8 97 fe ff ff       	call   66f <printint>
 7d8:	83 c4 10             	add    $0x10,%esp
        ap++;
 7db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7df:	e9 ae 00 00 00       	jmp    892 <printf+0x170>
      } else if(c == 's'){
 7e4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7e8:	75 43                	jne    82d <printf+0x10b>
        s = (char*)*ap;
 7ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7ed:	8b 00                	mov    (%eax),%eax
 7ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7f2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7fa:	75 07                	jne    803 <printf+0xe1>
          s = "(null)";
 7fc:	c7 45 f4 20 0b 00 00 	movl   $0xb20,-0xc(%ebp)
        while(*s != 0){
 803:	eb 1c                	jmp    821 <printf+0xff>
          putc(fd, *s);
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	0f b6 00             	movzbl (%eax),%eax
 80b:	0f be c0             	movsbl %al,%eax
 80e:	83 ec 08             	sub    $0x8,%esp
 811:	50                   	push   %eax
 812:	ff 75 08             	pushl  0x8(%ebp)
 815:	e8 33 fe ff ff       	call   64d <putc>
 81a:	83 c4 10             	add    $0x10,%esp
          s++;
 81d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	0f b6 00             	movzbl (%eax),%eax
 827:	84 c0                	test   %al,%al
 829:	75 da                	jne    805 <printf+0xe3>
 82b:	eb 65                	jmp    892 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 82d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 831:	75 1d                	jne    850 <printf+0x12e>
        putc(fd, *ap);
 833:	8b 45 e8             	mov    -0x18(%ebp),%eax
 836:	8b 00                	mov    (%eax),%eax
 838:	0f be c0             	movsbl %al,%eax
 83b:	83 ec 08             	sub    $0x8,%esp
 83e:	50                   	push   %eax
 83f:	ff 75 08             	pushl  0x8(%ebp)
 842:	e8 06 fe ff ff       	call   64d <putc>
 847:	83 c4 10             	add    $0x10,%esp
        ap++;
 84a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 84e:	eb 42                	jmp    892 <printf+0x170>
      } else if(c == '%'){
 850:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 854:	75 17                	jne    86d <printf+0x14b>
        putc(fd, c);
 856:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 859:	0f be c0             	movsbl %al,%eax
 85c:	83 ec 08             	sub    $0x8,%esp
 85f:	50                   	push   %eax
 860:	ff 75 08             	pushl  0x8(%ebp)
 863:	e8 e5 fd ff ff       	call   64d <putc>
 868:	83 c4 10             	add    $0x10,%esp
 86b:	eb 25                	jmp    892 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 86d:	83 ec 08             	sub    $0x8,%esp
 870:	6a 25                	push   $0x25
 872:	ff 75 08             	pushl  0x8(%ebp)
 875:	e8 d3 fd ff ff       	call   64d <putc>
 87a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 87d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 880:	0f be c0             	movsbl %al,%eax
 883:	83 ec 08             	sub    $0x8,%esp
 886:	50                   	push   %eax
 887:	ff 75 08             	pushl  0x8(%ebp)
 88a:	e8 be fd ff ff       	call   64d <putc>
 88f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 892:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 899:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 89d:	8b 55 0c             	mov    0xc(%ebp),%edx
 8a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a3:	01 d0                	add    %edx,%eax
 8a5:	0f b6 00             	movzbl (%eax),%eax
 8a8:	84 c0                	test   %al,%al
 8aa:	0f 85 94 fe ff ff    	jne    744 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8b0:	c9                   	leave  
 8b1:	c3                   	ret    

000008b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b2:	55                   	push   %ebp
 8b3:	89 e5                	mov    %esp,%ebp
 8b5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8b8:	8b 45 08             	mov    0x8(%ebp),%eax
 8bb:	83 e8 08             	sub    $0x8,%eax
 8be:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c1:	a1 f4 0d 00 00       	mov    0xdf4,%eax
 8c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8c9:	eb 24                	jmp    8ef <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ce:	8b 00                	mov    (%eax),%eax
 8d0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8d3:	77 12                	ja     8e7 <free+0x35>
 8d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8db:	77 24                	ja     901 <free+0x4f>
 8dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e0:	8b 00                	mov    (%eax),%eax
 8e2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8e5:	77 1a                	ja     901 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ea:	8b 00                	mov    (%eax),%eax
 8ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8f5:	76 d4                	jbe    8cb <free+0x19>
 8f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fa:	8b 00                	mov    (%eax),%eax
 8fc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ff:	76 ca                	jbe    8cb <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 901:	8b 45 f8             	mov    -0x8(%ebp),%eax
 904:	8b 40 04             	mov    0x4(%eax),%eax
 907:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 90e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 911:	01 c2                	add    %eax,%edx
 913:	8b 45 fc             	mov    -0x4(%ebp),%eax
 916:	8b 00                	mov    (%eax),%eax
 918:	39 c2                	cmp    %eax,%edx
 91a:	75 24                	jne    940 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 91c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91f:	8b 50 04             	mov    0x4(%eax),%edx
 922:	8b 45 fc             	mov    -0x4(%ebp),%eax
 925:	8b 00                	mov    (%eax),%eax
 927:	8b 40 04             	mov    0x4(%eax),%eax
 92a:	01 c2                	add    %eax,%edx
 92c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 92f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 932:	8b 45 fc             	mov    -0x4(%ebp),%eax
 935:	8b 00                	mov    (%eax),%eax
 937:	8b 10                	mov    (%eax),%edx
 939:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93c:	89 10                	mov    %edx,(%eax)
 93e:	eb 0a                	jmp    94a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 940:	8b 45 fc             	mov    -0x4(%ebp),%eax
 943:	8b 10                	mov    (%eax),%edx
 945:	8b 45 f8             	mov    -0x8(%ebp),%eax
 948:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 94a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94d:	8b 40 04             	mov    0x4(%eax),%eax
 950:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 957:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95a:	01 d0                	add    %edx,%eax
 95c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 95f:	75 20                	jne    981 <free+0xcf>
    p->s.size += bp->s.size;
 961:	8b 45 fc             	mov    -0x4(%ebp),%eax
 964:	8b 50 04             	mov    0x4(%eax),%edx
 967:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96a:	8b 40 04             	mov    0x4(%eax),%eax
 96d:	01 c2                	add    %eax,%edx
 96f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 972:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 975:	8b 45 f8             	mov    -0x8(%ebp),%eax
 978:	8b 10                	mov    (%eax),%edx
 97a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97d:	89 10                	mov    %edx,(%eax)
 97f:	eb 08                	jmp    989 <free+0xd7>
  } else
    p->s.ptr = bp;
 981:	8b 45 fc             	mov    -0x4(%ebp),%eax
 984:	8b 55 f8             	mov    -0x8(%ebp),%edx
 987:	89 10                	mov    %edx,(%eax)
  freep = p;
 989:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98c:	a3 f4 0d 00 00       	mov    %eax,0xdf4
}
 991:	c9                   	leave  
 992:	c3                   	ret    

00000993 <morecore>:

static Header*
morecore(uint nu)
{
 993:	55                   	push   %ebp
 994:	89 e5                	mov    %esp,%ebp
 996:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 999:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9a0:	77 07                	ja     9a9 <morecore+0x16>
    nu = 4096;
 9a2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9a9:	8b 45 08             	mov    0x8(%ebp),%eax
 9ac:	c1 e0 03             	shl    $0x3,%eax
 9af:	83 ec 0c             	sub    $0xc,%esp
 9b2:	50                   	push   %eax
 9b3:	e8 75 fc ff ff       	call   62d <sbrk>
 9b8:	83 c4 10             	add    $0x10,%esp
 9bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 9be:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 9c2:	75 07                	jne    9cb <morecore+0x38>
    return 0;
 9c4:	b8 00 00 00 00       	mov    $0x0,%eax
 9c9:	eb 26                	jmp    9f1 <morecore+0x5e>
  hp = (Header*)p;
 9cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d4:	8b 55 08             	mov    0x8(%ebp),%edx
 9d7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9dd:	83 c0 08             	add    $0x8,%eax
 9e0:	83 ec 0c             	sub    $0xc,%esp
 9e3:	50                   	push   %eax
 9e4:	e8 c9 fe ff ff       	call   8b2 <free>
 9e9:	83 c4 10             	add    $0x10,%esp
  return freep;
 9ec:	a1 f4 0d 00 00       	mov    0xdf4,%eax
}
 9f1:	c9                   	leave  
 9f2:	c3                   	ret    

000009f3 <malloc>:

void*
malloc(uint nbytes)
{
 9f3:	55                   	push   %ebp
 9f4:	89 e5                	mov    %esp,%ebp
 9f6:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f9:	8b 45 08             	mov    0x8(%ebp),%eax
 9fc:	83 c0 07             	add    $0x7,%eax
 9ff:	c1 e8 03             	shr    $0x3,%eax
 a02:	83 c0 01             	add    $0x1,%eax
 a05:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a08:	a1 f4 0d 00 00       	mov    0xdf4,%eax
 a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a10:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a14:	75 23                	jne    a39 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a16:	c7 45 f0 ec 0d 00 00 	movl   $0xdec,-0x10(%ebp)
 a1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a20:	a3 f4 0d 00 00       	mov    %eax,0xdf4
 a25:	a1 f4 0d 00 00       	mov    0xdf4,%eax
 a2a:	a3 ec 0d 00 00       	mov    %eax,0xdec
    base.s.size = 0;
 a2f:	c7 05 f0 0d 00 00 00 	movl   $0x0,0xdf0
 a36:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a39:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a3c:	8b 00                	mov    (%eax),%eax
 a3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a44:	8b 40 04             	mov    0x4(%eax),%eax
 a47:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a4a:	72 4d                	jb     a99 <malloc+0xa6>
      if(p->s.size == nunits)
 a4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4f:	8b 40 04             	mov    0x4(%eax),%eax
 a52:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a55:	75 0c                	jne    a63 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5a:	8b 10                	mov    (%eax),%edx
 a5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a5f:	89 10                	mov    %edx,(%eax)
 a61:	eb 26                	jmp    a89 <malloc+0x96>
      else {
        p->s.size -= nunits;
 a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a66:	8b 40 04             	mov    0x4(%eax),%eax
 a69:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a6c:	89 c2                	mov    %eax,%edx
 a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a71:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a77:	8b 40 04             	mov    0x4(%eax),%eax
 a7a:	c1 e0 03             	shl    $0x3,%eax
 a7d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a83:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a86:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a89:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a8c:	a3 f4 0d 00 00       	mov    %eax,0xdf4
      return (void*)(p + 1);
 a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a94:	83 c0 08             	add    $0x8,%eax
 a97:	eb 3b                	jmp    ad4 <malloc+0xe1>
    }
    if(p == freep)
 a99:	a1 f4 0d 00 00       	mov    0xdf4,%eax
 a9e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 aa1:	75 1e                	jne    ac1 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 aa3:	83 ec 0c             	sub    $0xc,%esp
 aa6:	ff 75 ec             	pushl  -0x14(%ebp)
 aa9:	e8 e5 fe ff ff       	call   993 <morecore>
 aae:	83 c4 10             	add    $0x10,%esp
 ab1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 ab4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ab8:	75 07                	jne    ac1 <malloc+0xce>
        return 0;
 aba:	b8 00 00 00 00       	mov    $0x0,%eax
 abf:	eb 13                	jmp    ad4 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aca:	8b 00                	mov    (%eax),%eax
 acc:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 acf:	e9 6d ff ff ff       	jmp    a41 <malloc+0x4e>
}
 ad4:	c9                   	leave  
 ad5:	c3                   	ret    
