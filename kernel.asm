
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 c6 10 80       	mov    $0x8010c670,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 c8 37 10 80       	mov    $0x801037c8,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 f8 85 10 80       	push   $0x801085f8
80100042:	68 80 c6 10 80       	push   $0x8010c680
80100047:	e8 b1 4f 00 00       	call   80104ffd <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 90 05 11 80 84 	movl   $0x80110584,0x80110590
80100056:	05 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 94 05 11 80 84 	movl   $0x80110584,0x80110594
80100060:	05 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 b4 c6 10 80 	movl   $0x8010c6b4,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 94 05 11 80    	mov    0x80110594,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c 84 05 11 80 	movl   $0x80110584,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 94 05 11 80       	mov    0x80110594,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 94 05 11 80       	mov    %eax,0x80110594

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	81 7d f4 84 05 11 80 	cmpl   $0x80110584,-0xc(%ebp)
801000ad:	72 bd                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000af:	c9                   	leave  
801000b0:	c3                   	ret    

801000b1 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b1:	55                   	push   %ebp
801000b2:	89 e5                	mov    %esp,%ebp
801000b4:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b7:	83 ec 0c             	sub    $0xc,%esp
801000ba:	68 80 c6 10 80       	push   $0x8010c680
801000bf:	e8 5a 4f 00 00       	call   8010501e <acquire>
801000c4:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c7:	a1 94 05 11 80       	mov    0x80110594,%eax
801000cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000cf:	eb 67                	jmp    80100138 <bget+0x87>
    if(b->dev == dev && b->sector == sector){
801000d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d4:	8b 40 04             	mov    0x4(%eax),%eax
801000d7:	3b 45 08             	cmp    0x8(%ebp),%eax
801000da:	75 53                	jne    8010012f <bget+0x7e>
801000dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000df:	8b 40 08             	mov    0x8(%eax),%eax
801000e2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e5:	75 48                	jne    8010012f <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ea:	8b 00                	mov    (%eax),%eax
801000ec:	83 e0 01             	and    $0x1,%eax
801000ef:	85 c0                	test   %eax,%eax
801000f1:	75 27                	jne    8010011a <bget+0x69>
        b->flags |= B_BUSY;
801000f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f6:	8b 00                	mov    (%eax),%eax
801000f8:	83 c8 01             	or     $0x1,%eax
801000fb:	89 c2                	mov    %eax,%edx
801000fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100100:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100102:	83 ec 0c             	sub    $0xc,%esp
80100105:	68 80 c6 10 80       	push   $0x8010c680
8010010a:	e8 75 4f 00 00       	call   80105084 <release>
8010010f:	83 c4 10             	add    $0x10,%esp
        return b;
80100112:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100115:	e9 98 00 00 00       	jmp    801001b2 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011a:	83 ec 08             	sub    $0x8,%esp
8010011d:	68 80 c6 10 80       	push   $0x8010c680
80100122:	ff 75 f4             	pushl  -0xc(%ebp)
80100125:	e8 19 4b 00 00       	call   80104c43 <sleep>
8010012a:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012d:	eb 98                	jmp    801000c7 <bget+0x16>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	8b 40 10             	mov    0x10(%eax),%eax
80100135:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100138:	81 7d f4 84 05 11 80 	cmpl   $0x80110584,-0xc(%ebp)
8010013f:	75 90                	jne    801000d1 <bget+0x20>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100141:	a1 90 05 11 80       	mov    0x80110590,%eax
80100146:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100149:	eb 51                	jmp    8010019c <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014e:	8b 00                	mov    (%eax),%eax
80100150:	83 e0 01             	and    $0x1,%eax
80100153:	85 c0                	test   %eax,%eax
80100155:	75 3c                	jne    80100193 <bget+0xe2>
80100157:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015a:	8b 00                	mov    (%eax),%eax
8010015c:	83 e0 04             	and    $0x4,%eax
8010015f:	85 c0                	test   %eax,%eax
80100161:	75 30                	jne    80100193 <bget+0xe2>
      b->dev = dev;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 08             	mov    0x8(%ebp),%edx
80100169:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100172:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100175:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100178:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
8010017e:	83 ec 0c             	sub    $0xc,%esp
80100181:	68 80 c6 10 80       	push   $0x8010c680
80100186:	e8 f9 4e 00 00       	call   80105084 <release>
8010018b:	83 c4 10             	add    $0x10,%esp
      return b;
8010018e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100191:	eb 1f                	jmp    801001b2 <bget+0x101>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100196:	8b 40 0c             	mov    0xc(%eax),%eax
80100199:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019c:	81 7d f4 84 05 11 80 	cmpl   $0x80110584,-0xc(%ebp)
801001a3:	75 a6                	jne    8010014b <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a5:	83 ec 0c             	sub    $0xc,%esp
801001a8:	68 ff 85 10 80       	push   $0x801085ff
801001ad:	e8 aa 03 00 00       	call   8010055c <panic>
}
801001b2:	c9                   	leave  
801001b3:	c3                   	ret    

801001b4 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, sector);
801001ba:	83 ec 08             	sub    $0x8,%esp
801001bd:	ff 75 0c             	pushl  0xc(%ebp)
801001c0:	ff 75 08             	pushl  0x8(%ebp)
801001c3:	e8 e9 fe ff ff       	call   801000b1 <bget>
801001c8:	83 c4 10             	add    $0x10,%esp
801001cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d1:	8b 00                	mov    (%eax),%eax
801001d3:	83 e0 02             	and    $0x2,%eax
801001d6:	85 c0                	test   %eax,%eax
801001d8:	75 0e                	jne    801001e8 <bread+0x34>
    iderw(b);
801001da:	83 ec 0c             	sub    $0xc,%esp
801001dd:	ff 75 f4             	pushl  -0xc(%ebp)
801001e0:	e8 73 26 00 00       	call   80102858 <iderw>
801001e5:	83 c4 10             	add    $0x10,%esp
  return b;
801001e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001eb:	c9                   	leave  
801001ec:	c3                   	ret    

801001ed <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ed:	55                   	push   %ebp
801001ee:	89 e5                	mov    %esp,%ebp
801001f0:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f3:	8b 45 08             	mov    0x8(%ebp),%eax
801001f6:	8b 00                	mov    (%eax),%eax
801001f8:	83 e0 01             	and    $0x1,%eax
801001fb:	85 c0                	test   %eax,%eax
801001fd:	75 0d                	jne    8010020c <bwrite+0x1f>
    panic("bwrite");
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	68 10 86 10 80       	push   $0x80108610
80100207:	e8 50 03 00 00       	call   8010055c <panic>
  b->flags |= B_DIRTY;
8010020c:	8b 45 08             	mov    0x8(%ebp),%eax
8010020f:	8b 00                	mov    (%eax),%eax
80100211:	83 c8 04             	or     $0x4,%eax
80100214:	89 c2                	mov    %eax,%edx
80100216:	8b 45 08             	mov    0x8(%ebp),%eax
80100219:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	ff 75 08             	pushl  0x8(%ebp)
80100221:	e8 32 26 00 00       	call   80102858 <iderw>
80100226:	83 c4 10             	add    $0x10,%esp
}
80100229:	c9                   	leave  
8010022a:	c3                   	ret    

8010022b <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022b:	55                   	push   %ebp
8010022c:	89 e5                	mov    %esp,%ebp
8010022e:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100231:	8b 45 08             	mov    0x8(%ebp),%eax
80100234:	8b 00                	mov    (%eax),%eax
80100236:	83 e0 01             	and    $0x1,%eax
80100239:	85 c0                	test   %eax,%eax
8010023b:	75 0d                	jne    8010024a <brelse+0x1f>
    panic("brelse");
8010023d:	83 ec 0c             	sub    $0xc,%esp
80100240:	68 17 86 10 80       	push   $0x80108617
80100245:	e8 12 03 00 00       	call   8010055c <panic>

  acquire(&bcache.lock);
8010024a:	83 ec 0c             	sub    $0xc,%esp
8010024d:	68 80 c6 10 80       	push   $0x8010c680
80100252:	e8 c7 4d 00 00       	call   8010501e <acquire>
80100257:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025a:	8b 45 08             	mov    0x8(%ebp),%eax
8010025d:	8b 40 10             	mov    0x10(%eax),%eax
80100260:	8b 55 08             	mov    0x8(%ebp),%edx
80100263:	8b 52 0c             	mov    0xc(%edx),%edx
80100266:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100269:	8b 45 08             	mov    0x8(%ebp),%eax
8010026c:	8b 40 0c             	mov    0xc(%eax),%eax
8010026f:	8b 55 08             	mov    0x8(%ebp),%edx
80100272:	8b 52 10             	mov    0x10(%edx),%edx
80100275:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100278:	8b 15 94 05 11 80    	mov    0x80110594,%edx
8010027e:	8b 45 08             	mov    0x8(%ebp),%eax
80100281:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100284:	8b 45 08             	mov    0x8(%ebp),%eax
80100287:	c7 40 0c 84 05 11 80 	movl   $0x80110584,0xc(%eax)
  bcache.head.next->prev = b;
8010028e:	a1 94 05 11 80       	mov    0x80110594,%eax
80100293:	8b 55 08             	mov    0x8(%ebp),%edx
80100296:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100299:	8b 45 08             	mov    0x8(%ebp),%eax
8010029c:	a3 94 05 11 80       	mov    %eax,0x80110594

  b->flags &= ~B_BUSY;
801002a1:	8b 45 08             	mov    0x8(%ebp),%eax
801002a4:	8b 00                	mov    (%eax),%eax
801002a6:	83 e0 fe             	and    $0xfffffffe,%eax
801002a9:	89 c2                	mov    %eax,%edx
801002ab:	8b 45 08             	mov    0x8(%ebp),%eax
801002ae:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b0:	83 ec 0c             	sub    $0xc,%esp
801002b3:	ff 75 08             	pushl  0x8(%ebp)
801002b6:	e8 71 4a 00 00       	call   80104d2c <wakeup>
801002bb:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002be:	83 ec 0c             	sub    $0xc,%esp
801002c1:	68 80 c6 10 80       	push   $0x8010c680
801002c6:	e8 b9 4d 00 00       	call   80105084 <release>
801002cb:	83 c4 10             	add    $0x10,%esp
}
801002ce:	c9                   	leave  
801002cf:	c3                   	ret    

801002d0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d0:	55                   	push   %ebp
801002d1:	89 e5                	mov    %esp,%ebp
801002d3:	83 ec 14             	sub    $0x14,%esp
801002d6:	8b 45 08             	mov    0x8(%ebp),%eax
801002d9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002dd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e1:	89 c2                	mov    %eax,%edx
801002e3:	ec                   	in     (%dx),%al
801002e4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002e7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002eb:	c9                   	leave  
801002ec:	c3                   	ret    

801002ed <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002ed:	55                   	push   %ebp
801002ee:	89 e5                	mov    %esp,%ebp
801002f0:	83 ec 08             	sub    $0x8,%esp
801002f3:	8b 55 08             	mov    0x8(%ebp),%edx
801002f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801002f9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002fd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100300:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100304:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100308:	ee                   	out    %al,(%dx)
}
80100309:	c9                   	leave  
8010030a:	c3                   	ret    

8010030b <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
8010030b:	55                   	push   %ebp
8010030c:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010030e:	fa                   	cli    
}
8010030f:	5d                   	pop    %ebp
80100310:	c3                   	ret    

80100311 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100311:	55                   	push   %ebp
80100312:	89 e5                	mov    %esp,%ebp
80100314:	53                   	push   %ebx
80100315:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100318:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010031c:	74 1c                	je     8010033a <printint+0x29>
8010031e:	8b 45 08             	mov    0x8(%ebp),%eax
80100321:	c1 e8 1f             	shr    $0x1f,%eax
80100324:	0f b6 c0             	movzbl %al,%eax
80100327:	89 45 10             	mov    %eax,0x10(%ebp)
8010032a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010032e:	74 0a                	je     8010033a <printint+0x29>
    x = -xx;
80100330:	8b 45 08             	mov    0x8(%ebp),%eax
80100333:	f7 d8                	neg    %eax
80100335:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100338:	eb 06                	jmp    80100340 <printint+0x2f>
  else
    x = xx;
8010033a:	8b 45 08             	mov    0x8(%ebp),%eax
8010033d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100340:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100347:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010034a:	8d 41 01             	lea    0x1(%ecx),%eax
8010034d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100350:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100353:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100356:	ba 00 00 00 00       	mov    $0x0,%edx
8010035b:	f7 f3                	div    %ebx
8010035d:	89 d0                	mov    %edx,%eax
8010035f:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100366:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
8010036a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010036d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100370:	ba 00 00 00 00       	mov    $0x0,%edx
80100375:	f7 f3                	div    %ebx
80100377:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010037a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010037e:	75 c7                	jne    80100347 <printint+0x36>

  if(sign)
80100380:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100384:	74 0e                	je     80100394 <printint+0x83>
    buf[i++] = '-';
80100386:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100389:	8d 50 01             	lea    0x1(%eax),%edx
8010038c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010038f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
80100394:	eb 1a                	jmp    801003b0 <printint+0x9f>
    consputc(buf[i]);
80100396:	8d 55 e0             	lea    -0x20(%ebp),%edx
80100399:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010039c:	01 d0                	add    %edx,%eax
8010039e:	0f b6 00             	movzbl (%eax),%eax
801003a1:	0f be c0             	movsbl %al,%eax
801003a4:	83 ec 0c             	sub    $0xc,%esp
801003a7:	50                   	push   %eax
801003a8:	e8 be 03 00 00       	call   8010076b <consputc>
801003ad:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003b8:	79 dc                	jns    80100396 <printint+0x85>
    consputc(buf[i]);
}
801003ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003bd:	c9                   	leave  
801003be:	c3                   	ret    

801003bf <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003bf:	55                   	push   %ebp
801003c0:	89 e5                	mov    %esp,%ebp
801003c2:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003c5:	a1 14 b6 10 80       	mov    0x8010b614,%eax
801003ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003cd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d1:	74 10                	je     801003e3 <cprintf+0x24>
    acquire(&cons.lock);
801003d3:	83 ec 0c             	sub    $0xc,%esp
801003d6:	68 e0 b5 10 80       	push   $0x8010b5e0
801003db:	e8 3e 4c 00 00       	call   8010501e <acquire>
801003e0:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003e3:	8b 45 08             	mov    0x8(%ebp),%eax
801003e6:	85 c0                	test   %eax,%eax
801003e8:	75 0d                	jne    801003f7 <cprintf+0x38>
    panic("null fmt");
801003ea:	83 ec 0c             	sub    $0xc,%esp
801003ed:	68 1e 86 10 80       	push   $0x8010861e
801003f2:	e8 65 01 00 00       	call   8010055c <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003f7:	8d 45 0c             	lea    0xc(%ebp),%eax
801003fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100404:	e9 1b 01 00 00       	jmp    80100524 <cprintf+0x165>
    if(c != '%'){
80100409:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010040d:	74 13                	je     80100422 <cprintf+0x63>
      consputc(c);
8010040f:	83 ec 0c             	sub    $0xc,%esp
80100412:	ff 75 e4             	pushl  -0x1c(%ebp)
80100415:	e8 51 03 00 00       	call   8010076b <consputc>
8010041a:	83 c4 10             	add    $0x10,%esp
      continue;
8010041d:	e9 fe 00 00 00       	jmp    80100520 <cprintf+0x161>
    }
    c = fmt[++i] & 0xff;
80100422:	8b 55 08             	mov    0x8(%ebp),%edx
80100425:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100429:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010042c:	01 d0                	add    %edx,%eax
8010042e:	0f b6 00             	movzbl (%eax),%eax
80100431:	0f be c0             	movsbl %al,%eax
80100434:	25 ff 00 00 00       	and    $0xff,%eax
80100439:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010043c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100440:	75 05                	jne    80100447 <cprintf+0x88>
      break;
80100442:	e9 fd 00 00 00       	jmp    80100544 <cprintf+0x185>
    switch(c){
80100447:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010044a:	83 f8 70             	cmp    $0x70,%eax
8010044d:	74 47                	je     80100496 <cprintf+0xd7>
8010044f:	83 f8 70             	cmp    $0x70,%eax
80100452:	7f 13                	jg     80100467 <cprintf+0xa8>
80100454:	83 f8 25             	cmp    $0x25,%eax
80100457:	0f 84 98 00 00 00    	je     801004f5 <cprintf+0x136>
8010045d:	83 f8 64             	cmp    $0x64,%eax
80100460:	74 14                	je     80100476 <cprintf+0xb7>
80100462:	e9 9d 00 00 00       	jmp    80100504 <cprintf+0x145>
80100467:	83 f8 73             	cmp    $0x73,%eax
8010046a:	74 47                	je     801004b3 <cprintf+0xf4>
8010046c:	83 f8 78             	cmp    $0x78,%eax
8010046f:	74 25                	je     80100496 <cprintf+0xd7>
80100471:	e9 8e 00 00 00       	jmp    80100504 <cprintf+0x145>
    case 'd':
      printint(*argp++, 10, 1);
80100476:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100479:	8d 50 04             	lea    0x4(%eax),%edx
8010047c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010047f:	8b 00                	mov    (%eax),%eax
80100481:	83 ec 04             	sub    $0x4,%esp
80100484:	6a 01                	push   $0x1
80100486:	6a 0a                	push   $0xa
80100488:	50                   	push   %eax
80100489:	e8 83 fe ff ff       	call   80100311 <printint>
8010048e:	83 c4 10             	add    $0x10,%esp
      break;
80100491:	e9 8a 00 00 00       	jmp    80100520 <cprintf+0x161>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100496:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100499:	8d 50 04             	lea    0x4(%eax),%edx
8010049c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010049f:	8b 00                	mov    (%eax),%eax
801004a1:	83 ec 04             	sub    $0x4,%esp
801004a4:	6a 00                	push   $0x0
801004a6:	6a 10                	push   $0x10
801004a8:	50                   	push   %eax
801004a9:	e8 63 fe ff ff       	call   80100311 <printint>
801004ae:	83 c4 10             	add    $0x10,%esp
      break;
801004b1:	eb 6d                	jmp    80100520 <cprintf+0x161>
    case 's':
      if((s = (char*)*argp++) == 0)
801004b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b6:	8d 50 04             	lea    0x4(%eax),%edx
801004b9:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004bc:	8b 00                	mov    (%eax),%eax
801004be:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004c5:	75 07                	jne    801004ce <cprintf+0x10f>
        s = "(null)";
801004c7:	c7 45 ec 27 86 10 80 	movl   $0x80108627,-0x14(%ebp)
      for(; *s; s++)
801004ce:	eb 19                	jmp    801004e9 <cprintf+0x12a>
        consputc(*s);
801004d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d3:	0f b6 00             	movzbl (%eax),%eax
801004d6:	0f be c0             	movsbl %al,%eax
801004d9:	83 ec 0c             	sub    $0xc,%esp
801004dc:	50                   	push   %eax
801004dd:	e8 89 02 00 00       	call   8010076b <consputc>
801004e2:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004e5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004ec:	0f b6 00             	movzbl (%eax),%eax
801004ef:	84 c0                	test   %al,%al
801004f1:	75 dd                	jne    801004d0 <cprintf+0x111>
        consputc(*s);
      break;
801004f3:	eb 2b                	jmp    80100520 <cprintf+0x161>
    case '%':
      consputc('%');
801004f5:	83 ec 0c             	sub    $0xc,%esp
801004f8:	6a 25                	push   $0x25
801004fa:	e8 6c 02 00 00       	call   8010076b <consputc>
801004ff:	83 c4 10             	add    $0x10,%esp
      break;
80100502:	eb 1c                	jmp    80100520 <cprintf+0x161>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100504:	83 ec 0c             	sub    $0xc,%esp
80100507:	6a 25                	push   $0x25
80100509:	e8 5d 02 00 00       	call   8010076b <consputc>
8010050e:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100511:	83 ec 0c             	sub    $0xc,%esp
80100514:	ff 75 e4             	pushl  -0x1c(%ebp)
80100517:	e8 4f 02 00 00       	call   8010076b <consputc>
8010051c:	83 c4 10             	add    $0x10,%esp
      break;
8010051f:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100520:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100524:	8b 55 08             	mov    0x8(%ebp),%edx
80100527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010052a:	01 d0                	add    %edx,%eax
8010052c:	0f b6 00             	movzbl (%eax),%eax
8010052f:	0f be c0             	movsbl %al,%eax
80100532:	25 ff 00 00 00       	and    $0xff,%eax
80100537:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010053a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010053e:	0f 85 c5 fe ff ff    	jne    80100409 <cprintf+0x4a>
      consputc(c);
      break;
    }
  }

  if(locking)
80100544:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100548:	74 10                	je     8010055a <cprintf+0x19b>
    release(&cons.lock);
8010054a:	83 ec 0c             	sub    $0xc,%esp
8010054d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100552:	e8 2d 4b 00 00       	call   80105084 <release>
80100557:	83 c4 10             	add    $0x10,%esp
}
8010055a:	c9                   	leave  
8010055b:	c3                   	ret    

8010055c <panic>:

void
panic(char *s)
{
8010055c:	55                   	push   %ebp
8010055d:	89 e5                	mov    %esp,%ebp
8010055f:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
80100562:	e8 a4 fd ff ff       	call   8010030b <cli>
  cons.locking = 0;
80100567:	c7 05 14 b6 10 80 00 	movl   $0x0,0x8010b614
8010056e:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100571:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100577:	0f b6 00             	movzbl (%eax),%eax
8010057a:	0f b6 c0             	movzbl %al,%eax
8010057d:	83 ec 08             	sub    $0x8,%esp
80100580:	50                   	push   %eax
80100581:	68 2e 86 10 80       	push   $0x8010862e
80100586:	e8 34 fe ff ff       	call   801003bf <cprintf>
8010058b:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
8010058e:	8b 45 08             	mov    0x8(%ebp),%eax
80100591:	83 ec 0c             	sub    $0xc,%esp
80100594:	50                   	push   %eax
80100595:	e8 25 fe ff ff       	call   801003bf <cprintf>
8010059a:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
8010059d:	83 ec 0c             	sub    $0xc,%esp
801005a0:	68 3d 86 10 80       	push   $0x8010863d
801005a5:	e8 15 fe ff ff       	call   801003bf <cprintf>
801005aa:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ad:	83 ec 08             	sub    $0x8,%esp
801005b0:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005b3:	50                   	push   %eax
801005b4:	8d 45 08             	lea    0x8(%ebp),%eax
801005b7:	50                   	push   %eax
801005b8:	e8 18 4b 00 00       	call   801050d5 <getcallerpcs>
801005bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005c7:	eb 1c                	jmp    801005e5 <panic+0x89>
    cprintf(" %p", pcs[i]);
801005c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005cc:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005d0:	83 ec 08             	sub    $0x8,%esp
801005d3:	50                   	push   %eax
801005d4:	68 3f 86 10 80       	push   $0x8010863f
801005d9:	e8 e1 fd ff ff       	call   801003bf <cprintf>
801005de:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005e5:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005e9:	7e de                	jle    801005c9 <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005eb:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
801005f2:	00 00 00 
  for(;;)
    ;
801005f5:	eb fe                	jmp    801005f5 <panic+0x99>

801005f7 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005f7:	55                   	push   %ebp
801005f8:	89 e5                	mov    %esp,%ebp
801005fa:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005fd:	6a 0e                	push   $0xe
801005ff:	68 d4 03 00 00       	push   $0x3d4
80100604:	e8 e4 fc ff ff       	call   801002ed <outb>
80100609:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
8010060c:	68 d5 03 00 00       	push   $0x3d5
80100611:	e8 ba fc ff ff       	call   801002d0 <inb>
80100616:	83 c4 04             	add    $0x4,%esp
80100619:	0f b6 c0             	movzbl %al,%eax
8010061c:	c1 e0 08             	shl    $0x8,%eax
8010061f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100622:	6a 0f                	push   $0xf
80100624:	68 d4 03 00 00       	push   $0x3d4
80100629:	e8 bf fc ff ff       	call   801002ed <outb>
8010062e:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100631:	68 d5 03 00 00       	push   $0x3d5
80100636:	e8 95 fc ff ff       	call   801002d0 <inb>
8010063b:	83 c4 04             	add    $0x4,%esp
8010063e:	0f b6 c0             	movzbl %al,%eax
80100641:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100644:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100648:	75 30                	jne    8010067a <cgaputc+0x83>
    pos += 80 - pos%80;
8010064a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010064d:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100652:	89 c8                	mov    %ecx,%eax
80100654:	f7 ea                	imul   %edx
80100656:	c1 fa 05             	sar    $0x5,%edx
80100659:	89 c8                	mov    %ecx,%eax
8010065b:	c1 f8 1f             	sar    $0x1f,%eax
8010065e:	29 c2                	sub    %eax,%edx
80100660:	89 d0                	mov    %edx,%eax
80100662:	c1 e0 02             	shl    $0x2,%eax
80100665:	01 d0                	add    %edx,%eax
80100667:	c1 e0 04             	shl    $0x4,%eax
8010066a:	29 c1                	sub    %eax,%ecx
8010066c:	89 ca                	mov    %ecx,%edx
8010066e:	b8 50 00 00 00       	mov    $0x50,%eax
80100673:	29 d0                	sub    %edx,%eax
80100675:	01 45 f4             	add    %eax,-0xc(%ebp)
80100678:	eb 34                	jmp    801006ae <cgaputc+0xb7>
  else if(c == BACKSPACE){
8010067a:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100681:	75 0c                	jne    8010068f <cgaputc+0x98>
    if(pos > 0) --pos;
80100683:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100687:	7e 25                	jle    801006ae <cgaputc+0xb7>
80100689:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
8010068d:	eb 1f                	jmp    801006ae <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010068f:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
80100695:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100698:	8d 50 01             	lea    0x1(%eax),%edx
8010069b:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010069e:	01 c0                	add    %eax,%eax
801006a0:	01 c8                	add    %ecx,%eax
801006a2:	8b 55 08             	mov    0x8(%ebp),%edx
801006a5:	0f b6 d2             	movzbl %dl,%edx
801006a8:	80 ce 07             	or     $0x7,%dh
801006ab:	66 89 10             	mov    %dx,(%eax)
  
  if((pos/80) >= 24){  // Scroll up.
801006ae:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006b5:	7e 4c                	jle    80100703 <cgaputc+0x10c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006b7:	a1 00 90 10 80       	mov    0x80109000,%eax
801006bc:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006c2:	a1 00 90 10 80       	mov    0x80109000,%eax
801006c7:	83 ec 04             	sub    $0x4,%esp
801006ca:	68 60 0e 00 00       	push   $0xe60
801006cf:	52                   	push   %edx
801006d0:	50                   	push   %eax
801006d1:	e8 63 4c 00 00       	call   80105339 <memmove>
801006d6:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006d9:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006dd:	b8 80 07 00 00       	mov    $0x780,%eax
801006e2:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006e5:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006e8:	a1 00 90 10 80       	mov    0x80109000,%eax
801006ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006f0:	01 c9                	add    %ecx,%ecx
801006f2:	01 c8                	add    %ecx,%eax
801006f4:	83 ec 04             	sub    $0x4,%esp
801006f7:	52                   	push   %edx
801006f8:	6a 00                	push   $0x0
801006fa:	50                   	push   %eax
801006fb:	e8 7a 4b 00 00       	call   8010527a <memset>
80100700:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
80100703:	83 ec 08             	sub    $0x8,%esp
80100706:	6a 0e                	push   $0xe
80100708:	68 d4 03 00 00       	push   $0x3d4
8010070d:	e8 db fb ff ff       	call   801002ed <outb>
80100712:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80100715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100718:	c1 f8 08             	sar    $0x8,%eax
8010071b:	0f b6 c0             	movzbl %al,%eax
8010071e:	83 ec 08             	sub    $0x8,%esp
80100721:	50                   	push   %eax
80100722:	68 d5 03 00 00       	push   $0x3d5
80100727:	e8 c1 fb ff ff       	call   801002ed <outb>
8010072c:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
8010072f:	83 ec 08             	sub    $0x8,%esp
80100732:	6a 0f                	push   $0xf
80100734:	68 d4 03 00 00       	push   $0x3d4
80100739:	e8 af fb ff ff       	call   801002ed <outb>
8010073e:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100741:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100744:	0f b6 c0             	movzbl %al,%eax
80100747:	83 ec 08             	sub    $0x8,%esp
8010074a:	50                   	push   %eax
8010074b:	68 d5 03 00 00       	push   $0x3d5
80100750:	e8 98 fb ff ff       	call   801002ed <outb>
80100755:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
80100758:	a1 00 90 10 80       	mov    0x80109000,%eax
8010075d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100760:	01 d2                	add    %edx,%edx
80100762:	01 d0                	add    %edx,%eax
80100764:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100769:	c9                   	leave  
8010076a:	c3                   	ret    

8010076b <consputc>:

void
consputc(int c)
{
8010076b:	55                   	push   %ebp
8010076c:	89 e5                	mov    %esp,%ebp
8010076e:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100771:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
80100776:	85 c0                	test   %eax,%eax
80100778:	74 07                	je     80100781 <consputc+0x16>
    cli();
8010077a:	e8 8c fb ff ff       	call   8010030b <cli>
    for(;;)
      ;
8010077f:	eb fe                	jmp    8010077f <consputc+0x14>
  }

  if(c == BACKSPACE){
80100781:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100788:	75 29                	jne    801007b3 <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010078a:	83 ec 0c             	sub    $0xc,%esp
8010078d:	6a 08                	push   $0x8
8010078f:	e8 ee 64 00 00       	call   80106c82 <uartputc>
80100794:	83 c4 10             	add    $0x10,%esp
80100797:	83 ec 0c             	sub    $0xc,%esp
8010079a:	6a 20                	push   $0x20
8010079c:	e8 e1 64 00 00       	call   80106c82 <uartputc>
801007a1:	83 c4 10             	add    $0x10,%esp
801007a4:	83 ec 0c             	sub    $0xc,%esp
801007a7:	6a 08                	push   $0x8
801007a9:	e8 d4 64 00 00       	call   80106c82 <uartputc>
801007ae:	83 c4 10             	add    $0x10,%esp
801007b1:	eb 0e                	jmp    801007c1 <consputc+0x56>
  } else
    uartputc(c);
801007b3:	83 ec 0c             	sub    $0xc,%esp
801007b6:	ff 75 08             	pushl  0x8(%ebp)
801007b9:	e8 c4 64 00 00       	call   80106c82 <uartputc>
801007be:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007c1:	83 ec 0c             	sub    $0xc,%esp
801007c4:	ff 75 08             	pushl  0x8(%ebp)
801007c7:	e8 2b fe ff ff       	call   801005f7 <cgaputc>
801007cc:	83 c4 10             	add    $0x10,%esp
}
801007cf:	c9                   	leave  
801007d0:	c3                   	ret    

801007d1 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d1:	55                   	push   %ebp
801007d2:	89 e5                	mov    %esp,%ebp
801007d4:	83 ec 18             	sub    $0x18,%esp
  int c;

  acquire(&input.lock);
801007d7:	83 ec 0c             	sub    $0xc,%esp
801007da:	68 c0 07 11 80       	push   $0x801107c0
801007df:	e8 3a 48 00 00       	call   8010501e <acquire>
801007e4:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007e7:	e9 43 01 00 00       	jmp    8010092f <consoleintr+0x15e>
    switch(c){
801007ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007ef:	83 f8 10             	cmp    $0x10,%eax
801007f2:	74 1e                	je     80100812 <consoleintr+0x41>
801007f4:	83 f8 10             	cmp    $0x10,%eax
801007f7:	7f 0a                	jg     80100803 <consoleintr+0x32>
801007f9:	83 f8 08             	cmp    $0x8,%eax
801007fc:	74 67                	je     80100865 <consoleintr+0x94>
801007fe:	e9 93 00 00 00       	jmp    80100896 <consoleintr+0xc5>
80100803:	83 f8 15             	cmp    $0x15,%eax
80100806:	74 31                	je     80100839 <consoleintr+0x68>
80100808:	83 f8 7f             	cmp    $0x7f,%eax
8010080b:	74 58                	je     80100865 <consoleintr+0x94>
8010080d:	e9 84 00 00 00       	jmp    80100896 <consoleintr+0xc5>
    case C('P'):  // Process listing.
      procdump();
80100812:	e8 cf 45 00 00       	call   80104de6 <procdump>
      break;
80100817:	e9 13 01 00 00       	jmp    8010092f <consoleintr+0x15e>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
8010081c:	a1 7c 08 11 80       	mov    0x8011087c,%eax
80100821:	83 e8 01             	sub    $0x1,%eax
80100824:	a3 7c 08 11 80       	mov    %eax,0x8011087c
        consputc(BACKSPACE);
80100829:	83 ec 0c             	sub    $0xc,%esp
8010082c:	68 00 01 00 00       	push   $0x100
80100831:	e8 35 ff ff ff       	call   8010076b <consputc>
80100836:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100839:	8b 15 7c 08 11 80    	mov    0x8011087c,%edx
8010083f:	a1 78 08 11 80       	mov    0x80110878,%eax
80100844:	39 c2                	cmp    %eax,%edx
80100846:	74 18                	je     80100860 <consoleintr+0x8f>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100848:	a1 7c 08 11 80       	mov    0x8011087c,%eax
8010084d:	83 e8 01             	sub    $0x1,%eax
80100850:	83 e0 7f             	and    $0x7f,%eax
80100853:	05 c0 07 11 80       	add    $0x801107c0,%eax
80100858:	0f b6 40 34          	movzbl 0x34(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010085c:	3c 0a                	cmp    $0xa,%al
8010085e:	75 bc                	jne    8010081c <consoleintr+0x4b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100860:	e9 ca 00 00 00       	jmp    8010092f <consoleintr+0x15e>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100865:	8b 15 7c 08 11 80    	mov    0x8011087c,%edx
8010086b:	a1 78 08 11 80       	mov    0x80110878,%eax
80100870:	39 c2                	cmp    %eax,%edx
80100872:	74 1d                	je     80100891 <consoleintr+0xc0>
        input.e--;
80100874:	a1 7c 08 11 80       	mov    0x8011087c,%eax
80100879:	83 e8 01             	sub    $0x1,%eax
8010087c:	a3 7c 08 11 80       	mov    %eax,0x8011087c
        consputc(BACKSPACE);
80100881:	83 ec 0c             	sub    $0xc,%esp
80100884:	68 00 01 00 00       	push   $0x100
80100889:	e8 dd fe ff ff       	call   8010076b <consputc>
8010088e:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100891:	e9 99 00 00 00       	jmp    8010092f <consoleintr+0x15e>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100896:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010089a:	0f 84 8e 00 00 00    	je     8010092e <consoleintr+0x15d>
801008a0:	8b 15 7c 08 11 80    	mov    0x8011087c,%edx
801008a6:	a1 74 08 11 80       	mov    0x80110874,%eax
801008ab:	29 c2                	sub    %eax,%edx
801008ad:	89 d0                	mov    %edx,%eax
801008af:	83 f8 7f             	cmp    $0x7f,%eax
801008b2:	77 7a                	ja     8010092e <consoleintr+0x15d>
        c = (c == '\r') ? '\n' : c;
801008b4:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801008b8:	74 05                	je     801008bf <consoleintr+0xee>
801008ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008bd:	eb 05                	jmp    801008c4 <consoleintr+0xf3>
801008bf:	b8 0a 00 00 00       	mov    $0xa,%eax
801008c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008c7:	a1 7c 08 11 80       	mov    0x8011087c,%eax
801008cc:	8d 50 01             	lea    0x1(%eax),%edx
801008cf:	89 15 7c 08 11 80    	mov    %edx,0x8011087c
801008d5:	83 e0 7f             	and    $0x7f,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008dd:	89 c1                	mov    %eax,%ecx
801008df:	8d 82 c0 07 11 80    	lea    -0x7feef840(%edx),%eax
801008e5:	88 48 34             	mov    %cl,0x34(%eax)
        consputc(c);
801008e8:	83 ec 0c             	sub    $0xc,%esp
801008eb:	ff 75 f4             	pushl  -0xc(%ebp)
801008ee:	e8 78 fe ff ff       	call   8010076b <consputc>
801008f3:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008f6:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008fa:	74 18                	je     80100914 <consoleintr+0x143>
801008fc:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
80100900:	74 12                	je     80100914 <consoleintr+0x143>
80100902:	a1 7c 08 11 80       	mov    0x8011087c,%eax
80100907:	8b 15 74 08 11 80    	mov    0x80110874,%edx
8010090d:	83 ea 80             	sub    $0xffffff80,%edx
80100910:	39 d0                	cmp    %edx,%eax
80100912:	75 1a                	jne    8010092e <consoleintr+0x15d>
          input.w = input.e;
80100914:	a1 7c 08 11 80       	mov    0x8011087c,%eax
80100919:	a3 78 08 11 80       	mov    %eax,0x80110878
          wakeup(&input.r);
8010091e:	83 ec 0c             	sub    $0xc,%esp
80100921:	68 74 08 11 80       	push   $0x80110874
80100926:	e8 01 44 00 00       	call   80104d2c <wakeup>
8010092b:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
8010092e:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
8010092f:	8b 45 08             	mov    0x8(%ebp),%eax
80100932:	ff d0                	call   *%eax
80100934:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100937:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010093b:	0f 89 ab fe ff ff    	jns    801007ec <consoleintr+0x1b>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100941:	83 ec 0c             	sub    $0xc,%esp
80100944:	68 c0 07 11 80       	push   $0x801107c0
80100949:	e8 36 47 00 00       	call   80105084 <release>
8010094e:	83 c4 10             	add    $0x10,%esp
}
80100951:	c9                   	leave  
80100952:	c3                   	ret    

80100953 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100953:	55                   	push   %ebp
80100954:	89 e5                	mov    %esp,%ebp
80100956:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100959:	83 ec 0c             	sub    $0xc,%esp
8010095c:	ff 75 08             	pushl  0x8(%ebp)
8010095f:	e8 f2 10 00 00       	call   80101a56 <iunlock>
80100964:	83 c4 10             	add    $0x10,%esp
  target = n;
80100967:	8b 45 10             	mov    0x10(%ebp),%eax
8010096a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
8010096d:	83 ec 0c             	sub    $0xc,%esp
80100970:	68 c0 07 11 80       	push   $0x801107c0
80100975:	e8 a4 46 00 00       	call   8010501e <acquire>
8010097a:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
8010097d:	e9 b4 00 00 00       	jmp    80100a36 <consoleread+0xe3>
    while(input.r == input.w){
80100982:	eb 4a                	jmp    801009ce <consoleread+0x7b>
      if(proc->killed){
80100984:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010098a:	8b 40 24             	mov    0x24(%eax),%eax
8010098d:	85 c0                	test   %eax,%eax
8010098f:	74 28                	je     801009b9 <consoleread+0x66>
        release(&input.lock);
80100991:	83 ec 0c             	sub    $0xc,%esp
80100994:	68 c0 07 11 80       	push   $0x801107c0
80100999:	e8 e6 46 00 00       	call   80105084 <release>
8010099e:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009a1:	83 ec 0c             	sub    $0xc,%esp
801009a4:	ff 75 08             	pushl  0x8(%ebp)
801009a7:	e8 53 0f 00 00       	call   801018ff <ilock>
801009ac:	83 c4 10             	add    $0x10,%esp
        return -1;
801009af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009b4:	e9 af 00 00 00       	jmp    80100a68 <consoleread+0x115>
      }
      sleep(&input.r, &input.lock);
801009b9:	83 ec 08             	sub    $0x8,%esp
801009bc:	68 c0 07 11 80       	push   $0x801107c0
801009c1:	68 74 08 11 80       	push   $0x80110874
801009c6:	e8 78 42 00 00       	call   80104c43 <sleep>
801009cb:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801009ce:	8b 15 74 08 11 80    	mov    0x80110874,%edx
801009d4:	a1 78 08 11 80       	mov    0x80110878,%eax
801009d9:	39 c2                	cmp    %eax,%edx
801009db:	74 a7                	je     80100984 <consoleread+0x31>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009dd:	a1 74 08 11 80       	mov    0x80110874,%eax
801009e2:	8d 50 01             	lea    0x1(%eax),%edx
801009e5:	89 15 74 08 11 80    	mov    %edx,0x80110874
801009eb:	83 e0 7f             	and    $0x7f,%eax
801009ee:	05 c0 07 11 80       	add    $0x801107c0,%eax
801009f3:	0f b6 40 34          	movzbl 0x34(%eax),%eax
801009f7:	0f be c0             	movsbl %al,%eax
801009fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801009fd:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a01:	75 19                	jne    80100a1c <consoleread+0xc9>
      if(n < target){
80100a03:	8b 45 10             	mov    0x10(%ebp),%eax
80100a06:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a09:	73 0f                	jae    80100a1a <consoleread+0xc7>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a0b:	a1 74 08 11 80       	mov    0x80110874,%eax
80100a10:	83 e8 01             	sub    $0x1,%eax
80100a13:	a3 74 08 11 80       	mov    %eax,0x80110874
      }
      break;
80100a18:	eb 26                	jmp    80100a40 <consoleread+0xed>
80100a1a:	eb 24                	jmp    80100a40 <consoleread+0xed>
    }
    *dst++ = c;
80100a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a1f:	8d 50 01             	lea    0x1(%eax),%edx
80100a22:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a25:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a28:	88 10                	mov    %dl,(%eax)
    --n;
80100a2a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a2e:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a32:	75 02                	jne    80100a36 <consoleread+0xe3>
      break;
80100a34:	eb 0a                	jmp    80100a40 <consoleread+0xed>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100a36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a3a:	0f 8f 42 ff ff ff    	jg     80100982 <consoleread+0x2f>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
80100a40:	83 ec 0c             	sub    $0xc,%esp
80100a43:	68 c0 07 11 80       	push   $0x801107c0
80100a48:	e8 37 46 00 00       	call   80105084 <release>
80100a4d:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a50:	83 ec 0c             	sub    $0xc,%esp
80100a53:	ff 75 08             	pushl  0x8(%ebp)
80100a56:	e8 a4 0e 00 00       	call   801018ff <ilock>
80100a5b:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a5e:	8b 45 10             	mov    0x10(%ebp),%eax
80100a61:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a64:	29 c2                	sub    %eax,%edx
80100a66:	89 d0                	mov    %edx,%eax
}
80100a68:	c9                   	leave  
80100a69:	c3                   	ret    

80100a6a <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a6a:	55                   	push   %ebp
80100a6b:	89 e5                	mov    %esp,%ebp
80100a6d:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a70:	83 ec 0c             	sub    $0xc,%esp
80100a73:	ff 75 08             	pushl  0x8(%ebp)
80100a76:	e8 db 0f 00 00       	call   80101a56 <iunlock>
80100a7b:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a7e:	83 ec 0c             	sub    $0xc,%esp
80100a81:	68 e0 b5 10 80       	push   $0x8010b5e0
80100a86:	e8 93 45 00 00       	call   8010501e <acquire>
80100a8b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a95:	eb 21                	jmp    80100ab8 <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100a97:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a9d:	01 d0                	add    %edx,%eax
80100a9f:	0f b6 00             	movzbl (%eax),%eax
80100aa2:	0f be c0             	movsbl %al,%eax
80100aa5:	0f b6 c0             	movzbl %al,%eax
80100aa8:	83 ec 0c             	sub    $0xc,%esp
80100aab:	50                   	push   %eax
80100aac:	e8 ba fc ff ff       	call   8010076b <consputc>
80100ab1:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100ab4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100abb:	3b 45 10             	cmp    0x10(%ebp),%eax
80100abe:	7c d7                	jl     80100a97 <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ac0:	83 ec 0c             	sub    $0xc,%esp
80100ac3:	68 e0 b5 10 80       	push   $0x8010b5e0
80100ac8:	e8 b7 45 00 00       	call   80105084 <release>
80100acd:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ad0:	83 ec 0c             	sub    $0xc,%esp
80100ad3:	ff 75 08             	pushl  0x8(%ebp)
80100ad6:	e8 24 0e 00 00       	call   801018ff <ilock>
80100adb:	83 c4 10             	add    $0x10,%esp

  return n;
80100ade:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ae1:	c9                   	leave  
80100ae2:	c3                   	ret    

80100ae3 <consoleinit>:

void
consoleinit(void)
{
80100ae3:	55                   	push   %ebp
80100ae4:	89 e5                	mov    %esp,%ebp
80100ae6:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100ae9:	83 ec 08             	sub    $0x8,%esp
80100aec:	68 43 86 10 80       	push   $0x80108643
80100af1:	68 e0 b5 10 80       	push   $0x8010b5e0
80100af6:	e8 02 45 00 00       	call   80104ffd <initlock>
80100afb:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100afe:	83 ec 08             	sub    $0x8,%esp
80100b01:	68 4b 86 10 80       	push   $0x8010864b
80100b06:	68 c0 07 11 80       	push   $0x801107c0
80100b0b:	e8 ed 44 00 00       	call   80104ffd <initlock>
80100b10:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b13:	c7 05 4c 12 11 80 6a 	movl   $0x80100a6a,0x8011124c
80100b1a:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b1d:	c7 05 48 12 11 80 53 	movl   $0x80100953,0x80111248
80100b24:	09 10 80 
  cons.locking = 1;
80100b27:	c7 05 14 b6 10 80 01 	movl   $0x1,0x8010b614
80100b2e:	00 00 00 

  picenable(IRQ_KBD);
80100b31:	83 ec 0c             	sub    $0xc,%esp
80100b34:	6a 01                	push   $0x1
80100b36:	e8 27 33 00 00       	call   80103e62 <picenable>
80100b3b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b3e:	83 ec 08             	sub    $0x8,%esp
80100b41:	6a 00                	push   $0x0
80100b43:	6a 01                	push   $0x1
80100b45:	e8 d7 1e 00 00       	call   80102a21 <ioapicenable>
80100b4a:	83 c4 10             	add    $0x10,%esp
}
80100b4d:	c9                   	leave  
80100b4e:	c3                   	ret    

80100b4f <exec>:

extern int EXIT_BEGIN(void);

int
exec(char *path, char **argv)
{
80100b4f:	55                   	push   %ebp
80100b50:	89 e5                	mov    %esp,%ebp
80100b52:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b58:	e8 2c 29 00 00       	call   80103489 <begin_op>
  if((ip = namei(path)) == 0){
80100b5d:	83 ec 0c             	sub    $0xc,%esp
80100b60:	ff 75 08             	pushl  0x8(%ebp)
80100b63:	e8 4c 19 00 00       	call   801024b4 <namei>
80100b68:	83 c4 10             	add    $0x10,%esp
80100b6b:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b6e:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b72:	75 0f                	jne    80100b83 <exec+0x34>
    end_op();
80100b74:	e8 9e 29 00 00       	call   80103517 <end_op>
    return -1;
80100b79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b7e:	e9 d1 03 00 00       	jmp    80100f54 <exec+0x405>
  }
  ilock(ip);
80100b83:	83 ec 0c             	sub    $0xc,%esp
80100b86:	ff 75 d8             	pushl  -0x28(%ebp)
80100b89:	e8 71 0d 00 00       	call   801018ff <ilock>
80100b8e:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100b91:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b98:	6a 34                	push   $0x34
80100b9a:	6a 00                	push   $0x0
80100b9c:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100ba2:	50                   	push   %eax
80100ba3:	ff 75 d8             	pushl  -0x28(%ebp)
80100ba6:	e8 b6 12 00 00       	call   80101e61 <readi>
80100bab:	83 c4 10             	add    $0x10,%esp
80100bae:	83 f8 33             	cmp    $0x33,%eax
80100bb1:	77 05                	ja     80100bb8 <exec+0x69>
    goto bad;
80100bb3:	e9 6a 03 00 00       	jmp    80100f22 <exec+0x3d3>
  if(elf.magic != ELF_MAGIC)
80100bb8:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbe:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bc3:	74 05                	je     80100bca <exec+0x7b>
    goto bad;
80100bc5:	e9 58 03 00 00       	jmp    80100f22 <exec+0x3d3>

  if((pgdir = setupkvm()) == 0)
80100bca:	e8 03 72 00 00       	call   80107dd2 <setupkvm>
80100bcf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bd2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bd6:	75 05                	jne    80100bdd <exec+0x8e>
    goto bad;
80100bd8:	e9 45 03 00 00       	jmp    80100f22 <exec+0x3d3>

  // Load program into memory.
  sz = 0;
80100bdd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100beb:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100bf1:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bf4:	e9 ae 00 00 00       	jmp    80100ca7 <exec+0x158>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	50                   	push   %eax
80100bff:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c05:	50                   	push   %eax
80100c06:	ff 75 d8             	pushl  -0x28(%ebp)
80100c09:	e8 53 12 00 00       	call   80101e61 <readi>
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	83 f8 20             	cmp    $0x20,%eax
80100c14:	74 05                	je     80100c1b <exec+0xcc>
      goto bad;
80100c16:	e9 07 03 00 00       	jmp    80100f22 <exec+0x3d3>
    if(ph.type != ELF_PROG_LOAD)
80100c1b:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c21:	83 f8 01             	cmp    $0x1,%eax
80100c24:	74 02                	je     80100c28 <exec+0xd9>
      continue;
80100c26:	eb 72                	jmp    80100c9a <exec+0x14b>
    if(ph.memsz < ph.filesz)
80100c28:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c2e:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c34:	39 c2                	cmp    %eax,%edx
80100c36:	73 05                	jae    80100c3d <exec+0xee>
      goto bad;
80100c38:	e9 e5 02 00 00       	jmp    80100f22 <exec+0x3d3>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c3d:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c43:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c49:	01 d0                	add    %edx,%eax
80100c4b:	83 ec 04             	sub    $0x4,%esp
80100c4e:	50                   	push   %eax
80100c4f:	ff 75 e0             	pushl  -0x20(%ebp)
80100c52:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c55:	e8 1b 75 00 00       	call   80108175 <allocuvm>
80100c5a:	83 c4 10             	add    $0x10,%esp
80100c5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c60:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c64:	75 05                	jne    80100c6b <exec+0x11c>
      goto bad;
80100c66:	e9 b7 02 00 00       	jmp    80100f22 <exec+0x3d3>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c6b:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c71:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c77:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c7d:	83 ec 0c             	sub    $0xc,%esp
80100c80:	52                   	push   %edx
80100c81:	50                   	push   %eax
80100c82:	ff 75 d8             	pushl  -0x28(%ebp)
80100c85:	51                   	push   %ecx
80100c86:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c89:	e8 10 74 00 00       	call   8010809e <loaduvm>
80100c8e:	83 c4 20             	add    $0x20,%esp
80100c91:	85 c0                	test   %eax,%eax
80100c93:	79 05                	jns    80100c9a <exec+0x14b>
      goto bad;
80100c95:	e9 88 02 00 00       	jmp    80100f22 <exec+0x3d3>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c9a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100ca1:	83 c0 20             	add    $0x20,%eax
80100ca4:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100ca7:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100cae:	0f b7 c0             	movzwl %ax,%eax
80100cb1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100cb4:	0f 8f 3f ff ff ff    	jg     80100bf9 <exec+0xaa>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cba:	83 ec 0c             	sub    $0xc,%esp
80100cbd:	ff 75 d8             	pushl  -0x28(%ebp)
80100cc0:	e8 f1 0e 00 00       	call   80101bb6 <iunlockput>
80100cc5:	83 c4 10             	add    $0x10,%esp
  end_op();
80100cc8:	e8 4a 28 00 00       	call   80103517 <end_op>
  ip = 0;
80100ccd:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)


  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd7:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cdc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100ce1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ce4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ce7:	05 00 20 00 00       	add    $0x2000,%eax
80100cec:	83 ec 04             	sub    $0x4,%esp
80100cef:	50                   	push   %eax
80100cf0:	ff 75 e0             	pushl  -0x20(%ebp)
80100cf3:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cf6:	e8 7a 74 00 00       	call   80108175 <allocuvm>
80100cfb:	83 c4 10             	add    $0x10,%esp
80100cfe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d01:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d05:	75 05                	jne    80100d0c <exec+0x1bd>
    goto bad;
80100d07:	e9 16 02 00 00       	jmp    80100f22 <exec+0x3d3>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d0c:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d0f:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d14:	83 ec 08             	sub    $0x8,%esp
80100d17:	50                   	push   %eax
80100d18:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d1b:	e8 7a 76 00 00       	call   8010839a <clearpteu>
80100d20:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d23:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d26:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d29:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d30:	e9 98 00 00 00       	jmp    80100dcd <exec+0x27e>
    if(argc >= MAXARG)
80100d35:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d39:	76 05                	jbe    80100d40 <exec+0x1f1>
      goto bad;
80100d3b:	e9 e2 01 00 00       	jmp    80100f22 <exec+0x3d3>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d4d:	01 d0                	add    %edx,%eax
80100d4f:	8b 00                	mov    (%eax),%eax
80100d51:	83 ec 0c             	sub    $0xc,%esp
80100d54:	50                   	push   %eax
80100d55:	e8 6f 47 00 00       	call   801054c9 <strlen>
80100d5a:	83 c4 10             	add    $0x10,%esp
80100d5d:	89 c2                	mov    %eax,%edx
80100d5f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d62:	29 d0                	sub    %edx,%eax
80100d64:	83 e8 01             	sub    $0x1,%eax
80100d67:	83 e0 fc             	and    $0xfffffffc,%eax
80100d6a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d77:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d7a:	01 d0                	add    %edx,%eax
80100d7c:	8b 00                	mov    (%eax),%eax
80100d7e:	83 ec 0c             	sub    $0xc,%esp
80100d81:	50                   	push   %eax
80100d82:	e8 42 47 00 00       	call   801054c9 <strlen>
80100d87:	83 c4 10             	add    $0x10,%esp
80100d8a:	83 c0 01             	add    $0x1,%eax
80100d8d:	89 c1                	mov    %eax,%ecx
80100d8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d99:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d9c:	01 d0                	add    %edx,%eax
80100d9e:	8b 00                	mov    (%eax),%eax
80100da0:	51                   	push   %ecx
80100da1:	50                   	push   %eax
80100da2:	ff 75 dc             	pushl  -0x24(%ebp)
80100da5:	ff 75 d4             	pushl  -0x2c(%ebp)
80100da8:	e8 a3 77 00 00       	call   80108550 <copyout>
80100dad:	83 c4 10             	add    $0x10,%esp
80100db0:	85 c0                	test   %eax,%eax
80100db2:	79 05                	jns    80100db9 <exec+0x26a>
      goto bad;
80100db4:	e9 69 01 00 00       	jmp    80100f22 <exec+0x3d3>
    ustack[3+argc] = sp;
80100db9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dbc:	8d 50 03             	lea    0x3(%eax),%edx
80100dbf:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100dc2:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100dc9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100dcd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dda:	01 d0                	add    %edx,%eax
80100ddc:	8b 00                	mov    (%eax),%eax
80100dde:	85 c0                	test   %eax,%eax
80100de0:	0f 85 4f ff ff ff    	jne    80100d35 <exec+0x1e6>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100de6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de9:	83 c0 03             	add    $0x3,%eax
80100dec:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100df3:	00 00 00 00 

  sp = sp - 16;
80100df7:	83 6d dc 10          	subl   $0x10,-0x24(%ebp)
  copyout(pgdir,sp,EXIT_BEGIN,16);
80100dfb:	6a 10                	push   $0x10
80100dfd:	68 ee 85 10 80       	push   $0x801085ee
80100e02:	ff 75 dc             	pushl  -0x24(%ebp)
80100e05:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e08:	e8 43 77 00 00       	call   80108550 <copyout>
80100e0d:	83 c4 10             	add    $0x10,%esp
  ustack[0] = sp;
80100e10:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e13:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)

  //ustack[0] = 0xffffffff;
  ustack[1] = argc;
80100e19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e1c:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e25:	83 c0 01             	add    $0x1,%eax
80100e28:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e2f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e32:	29 d0                	sub    %edx,%eax
80100e34:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e3d:	83 c0 04             	add    $0x4,%eax
80100e40:	c1 e0 02             	shl    $0x2,%eax
80100e43:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e49:	83 c0 04             	add    $0x4,%eax
80100e4c:	c1 e0 02             	shl    $0x2,%eax
80100e4f:	50                   	push   %eax
80100e50:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e56:	50                   	push   %eax
80100e57:	ff 75 dc             	pushl  -0x24(%ebp)
80100e5a:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e5d:	e8 ee 76 00 00       	call   80108550 <copyout>
80100e62:	83 c4 10             	add    $0x10,%esp
80100e65:	85 c0                	test   %eax,%eax
80100e67:	79 05                	jns    80100e6e <exec+0x31f>
    goto bad;
80100e69:	e9 b4 00 00 00       	jmp    80100f22 <exec+0x3d3>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e6e:	8b 45 08             	mov    0x8(%ebp),%eax
80100e71:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e77:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e7a:	eb 17                	jmp    80100e93 <exec+0x344>
    if(*s == '/')
80100e7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e7f:	0f b6 00             	movzbl (%eax),%eax
80100e82:	3c 2f                	cmp    $0x2f,%al
80100e84:	75 09                	jne    80100e8f <exec+0x340>
      last = s+1;
80100e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e89:	83 c0 01             	add    $0x1,%eax
80100e8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e8f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e96:	0f b6 00             	movzbl (%eax),%eax
80100e99:	84 c0                	test   %al,%al
80100e9b:	75 df                	jne    80100e7c <exec+0x32d>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e9d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea3:	83 c0 6c             	add    $0x6c,%eax
80100ea6:	83 ec 04             	sub    $0x4,%esp
80100ea9:	6a 10                	push   $0x10
80100eab:	ff 75 f0             	pushl  -0x10(%ebp)
80100eae:	50                   	push   %eax
80100eaf:	e8 cb 45 00 00       	call   8010547f <safestrcpy>
80100eb4:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100eb7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ebd:	8b 40 04             	mov    0x4(%eax),%eax
80100ec0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100ec3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ecc:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100ecf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ed5:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100ed8:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100eda:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ee0:	8b 40 18             	mov    0x18(%eax),%eax
80100ee3:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ee9:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100eec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ef2:	8b 40 18             	mov    0x18(%eax),%eax
80100ef5:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ef8:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100efb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f01:	83 ec 0c             	sub    $0xc,%esp
80100f04:	50                   	push   %eax
80100f05:	e8 ad 6f 00 00       	call   80107eb7 <switchuvm>
80100f0a:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f0d:	83 ec 0c             	sub    $0xc,%esp
80100f10:	ff 75 d0             	pushl  -0x30(%ebp)
80100f13:	e8 e3 73 00 00       	call   801082fb <freevm>
80100f18:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f1b:	b8 00 00 00 00       	mov    $0x0,%eax
80100f20:	eb 32                	jmp    80100f54 <exec+0x405>

 bad:
  if(pgdir)
80100f22:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f26:	74 0e                	je     80100f36 <exec+0x3e7>
    freevm(pgdir);
80100f28:	83 ec 0c             	sub    $0xc,%esp
80100f2b:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f2e:	e8 c8 73 00 00       	call   801082fb <freevm>
80100f33:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100f36:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f3a:	74 13                	je     80100f4f <exec+0x400>
    iunlockput(ip);
80100f3c:	83 ec 0c             	sub    $0xc,%esp
80100f3f:	ff 75 d8             	pushl  -0x28(%ebp)
80100f42:	e8 6f 0c 00 00       	call   80101bb6 <iunlockput>
80100f47:	83 c4 10             	add    $0x10,%esp
    end_op();
80100f4a:	e8 c8 25 00 00       	call   80103517 <end_op>
  }
  return -1;
80100f4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f54:	c9                   	leave  
80100f55:	c3                   	ret    

80100f56 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f56:	55                   	push   %ebp
80100f57:	89 e5                	mov    %esp,%ebp
80100f59:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f5c:	83 ec 08             	sub    $0x8,%esp
80100f5f:	68 51 86 10 80       	push   $0x80108651
80100f64:	68 80 08 11 80       	push   $0x80110880
80100f69:	e8 8f 40 00 00       	call   80104ffd <initlock>
80100f6e:	83 c4 10             	add    $0x10,%esp
}
80100f71:	c9                   	leave  
80100f72:	c3                   	ret    

80100f73 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f73:	55                   	push   %ebp
80100f74:	89 e5                	mov    %esp,%ebp
80100f76:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f79:	83 ec 0c             	sub    $0xc,%esp
80100f7c:	68 80 08 11 80       	push   $0x80110880
80100f81:	e8 98 40 00 00       	call   8010501e <acquire>
80100f86:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f89:	c7 45 f4 b4 08 11 80 	movl   $0x801108b4,-0xc(%ebp)
80100f90:	eb 2d                	jmp    80100fbf <filealloc+0x4c>
    if(f->ref == 0){
80100f92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f95:	8b 40 04             	mov    0x4(%eax),%eax
80100f98:	85 c0                	test   %eax,%eax
80100f9a:	75 1f                	jne    80100fbb <filealloc+0x48>
      f->ref = 1;
80100f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f9f:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	68 80 08 11 80       	push   $0x80110880
80100fae:	e8 d1 40 00 00       	call   80105084 <release>
80100fb3:	83 c4 10             	add    $0x10,%esp
      return f;
80100fb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fb9:	eb 22                	jmp    80100fdd <filealloc+0x6a>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fbb:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fbf:	81 7d f4 14 12 11 80 	cmpl   $0x80111214,-0xc(%ebp)
80100fc6:	72 ca                	jb     80100f92 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fc8:	83 ec 0c             	sub    $0xc,%esp
80100fcb:	68 80 08 11 80       	push   $0x80110880
80100fd0:	e8 af 40 00 00       	call   80105084 <release>
80100fd5:	83 c4 10             	add    $0x10,%esp
  return 0;
80100fd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100fdd:	c9                   	leave  
80100fde:	c3                   	ret    

80100fdf <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fdf:	55                   	push   %ebp
80100fe0:	89 e5                	mov    %esp,%ebp
80100fe2:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80100fe5:	83 ec 0c             	sub    $0xc,%esp
80100fe8:	68 80 08 11 80       	push   $0x80110880
80100fed:	e8 2c 40 00 00       	call   8010501e <acquire>
80100ff2:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100ff5:	8b 45 08             	mov    0x8(%ebp),%eax
80100ff8:	8b 40 04             	mov    0x4(%eax),%eax
80100ffb:	85 c0                	test   %eax,%eax
80100ffd:	7f 0d                	jg     8010100c <filedup+0x2d>
    panic("filedup");
80100fff:	83 ec 0c             	sub    $0xc,%esp
80101002:	68 58 86 10 80       	push   $0x80108658
80101007:	e8 50 f5 ff ff       	call   8010055c <panic>
  f->ref++;
8010100c:	8b 45 08             	mov    0x8(%ebp),%eax
8010100f:	8b 40 04             	mov    0x4(%eax),%eax
80101012:	8d 50 01             	lea    0x1(%eax),%edx
80101015:	8b 45 08             	mov    0x8(%ebp),%eax
80101018:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
8010101b:	83 ec 0c             	sub    $0xc,%esp
8010101e:	68 80 08 11 80       	push   $0x80110880
80101023:	e8 5c 40 00 00       	call   80105084 <release>
80101028:	83 c4 10             	add    $0x10,%esp
  return f;
8010102b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010102e:	c9                   	leave  
8010102f:	c3                   	ret    

80101030 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
80101036:	83 ec 0c             	sub    $0xc,%esp
80101039:	68 80 08 11 80       	push   $0x80110880
8010103e:	e8 db 3f 00 00       	call   8010501e <acquire>
80101043:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101046:	8b 45 08             	mov    0x8(%ebp),%eax
80101049:	8b 40 04             	mov    0x4(%eax),%eax
8010104c:	85 c0                	test   %eax,%eax
8010104e:	7f 0d                	jg     8010105d <fileclose+0x2d>
    panic("fileclose");
80101050:	83 ec 0c             	sub    $0xc,%esp
80101053:	68 60 86 10 80       	push   $0x80108660
80101058:	e8 ff f4 ff ff       	call   8010055c <panic>
  if(--f->ref > 0){
8010105d:	8b 45 08             	mov    0x8(%ebp),%eax
80101060:	8b 40 04             	mov    0x4(%eax),%eax
80101063:	8d 50 ff             	lea    -0x1(%eax),%edx
80101066:	8b 45 08             	mov    0x8(%ebp),%eax
80101069:	89 50 04             	mov    %edx,0x4(%eax)
8010106c:	8b 45 08             	mov    0x8(%ebp),%eax
8010106f:	8b 40 04             	mov    0x4(%eax),%eax
80101072:	85 c0                	test   %eax,%eax
80101074:	7e 15                	jle    8010108b <fileclose+0x5b>
    release(&ftable.lock);
80101076:	83 ec 0c             	sub    $0xc,%esp
80101079:	68 80 08 11 80       	push   $0x80110880
8010107e:	e8 01 40 00 00       	call   80105084 <release>
80101083:	83 c4 10             	add    $0x10,%esp
80101086:	e9 8b 00 00 00       	jmp    80101116 <fileclose+0xe6>
    return;
  }
  ff = *f;
8010108b:	8b 45 08             	mov    0x8(%ebp),%eax
8010108e:	8b 10                	mov    (%eax),%edx
80101090:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101093:	8b 50 04             	mov    0x4(%eax),%edx
80101096:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101099:	8b 50 08             	mov    0x8(%eax),%edx
8010109c:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010109f:	8b 50 0c             	mov    0xc(%eax),%edx
801010a2:	89 55 ec             	mov    %edx,-0x14(%ebp)
801010a5:	8b 50 10             	mov    0x10(%eax),%edx
801010a8:	89 55 f0             	mov    %edx,-0x10(%ebp)
801010ab:	8b 40 14             	mov    0x14(%eax),%eax
801010ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
801010b1:	8b 45 08             	mov    0x8(%ebp),%eax
801010b4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801010bb:	8b 45 08             	mov    0x8(%ebp),%eax
801010be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801010c4:	83 ec 0c             	sub    $0xc,%esp
801010c7:	68 80 08 11 80       	push   $0x80110880
801010cc:	e8 b3 3f 00 00       	call   80105084 <release>
801010d1:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
801010d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010d7:	83 f8 01             	cmp    $0x1,%eax
801010da:	75 19                	jne    801010f5 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
801010dc:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010e0:	0f be d0             	movsbl %al,%edx
801010e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010e6:	83 ec 08             	sub    $0x8,%esp
801010e9:	52                   	push   %edx
801010ea:	50                   	push   %eax
801010eb:	e8 d9 2f 00 00       	call   801040c9 <pipeclose>
801010f0:	83 c4 10             	add    $0x10,%esp
801010f3:	eb 21                	jmp    80101116 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f8:	83 f8 02             	cmp    $0x2,%eax
801010fb:	75 19                	jne    80101116 <fileclose+0xe6>
    begin_op();
801010fd:	e8 87 23 00 00       	call   80103489 <begin_op>
    iput(ff.ip);
80101102:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101105:	83 ec 0c             	sub    $0xc,%esp
80101108:	50                   	push   %eax
80101109:	e8 b9 09 00 00       	call   80101ac7 <iput>
8010110e:	83 c4 10             	add    $0x10,%esp
    end_op();
80101111:	e8 01 24 00 00       	call   80103517 <end_op>
  }
}
80101116:	c9                   	leave  
80101117:	c3                   	ret    

80101118 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101118:	55                   	push   %ebp
80101119:	89 e5                	mov    %esp,%ebp
8010111b:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
8010111e:	8b 45 08             	mov    0x8(%ebp),%eax
80101121:	8b 00                	mov    (%eax),%eax
80101123:	83 f8 02             	cmp    $0x2,%eax
80101126:	75 40                	jne    80101168 <filestat+0x50>
    ilock(f->ip);
80101128:	8b 45 08             	mov    0x8(%ebp),%eax
8010112b:	8b 40 10             	mov    0x10(%eax),%eax
8010112e:	83 ec 0c             	sub    $0xc,%esp
80101131:	50                   	push   %eax
80101132:	e8 c8 07 00 00       	call   801018ff <ilock>
80101137:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010113a:	8b 45 08             	mov    0x8(%ebp),%eax
8010113d:	8b 40 10             	mov    0x10(%eax),%eax
80101140:	83 ec 08             	sub    $0x8,%esp
80101143:	ff 75 0c             	pushl  0xc(%ebp)
80101146:	50                   	push   %eax
80101147:	e8 d0 0c 00 00       	call   80101e1c <stati>
8010114c:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
8010114f:	8b 45 08             	mov    0x8(%ebp),%eax
80101152:	8b 40 10             	mov    0x10(%eax),%eax
80101155:	83 ec 0c             	sub    $0xc,%esp
80101158:	50                   	push   %eax
80101159:	e8 f8 08 00 00       	call   80101a56 <iunlock>
8010115e:	83 c4 10             	add    $0x10,%esp
    return 0;
80101161:	b8 00 00 00 00       	mov    $0x0,%eax
80101166:	eb 05                	jmp    8010116d <filestat+0x55>
  }
  return -1;
80101168:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010116d:	c9                   	leave  
8010116e:	c3                   	ret    

8010116f <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
8010116f:	55                   	push   %ebp
80101170:	89 e5                	mov    %esp,%ebp
80101172:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101175:	8b 45 08             	mov    0x8(%ebp),%eax
80101178:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010117c:	84 c0                	test   %al,%al
8010117e:	75 0a                	jne    8010118a <fileread+0x1b>
    return -1;
80101180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101185:	e9 9b 00 00 00       	jmp    80101225 <fileread+0xb6>
  if(f->type == FD_PIPE)
8010118a:	8b 45 08             	mov    0x8(%ebp),%eax
8010118d:	8b 00                	mov    (%eax),%eax
8010118f:	83 f8 01             	cmp    $0x1,%eax
80101192:	75 1a                	jne    801011ae <fileread+0x3f>
    return piperead(f->pipe, addr, n);
80101194:	8b 45 08             	mov    0x8(%ebp),%eax
80101197:	8b 40 0c             	mov    0xc(%eax),%eax
8010119a:	83 ec 04             	sub    $0x4,%esp
8010119d:	ff 75 10             	pushl  0x10(%ebp)
801011a0:	ff 75 0c             	pushl  0xc(%ebp)
801011a3:	50                   	push   %eax
801011a4:	e8 cd 30 00 00       	call   80104276 <piperead>
801011a9:	83 c4 10             	add    $0x10,%esp
801011ac:	eb 77                	jmp    80101225 <fileread+0xb6>
  if(f->type == FD_INODE){
801011ae:	8b 45 08             	mov    0x8(%ebp),%eax
801011b1:	8b 00                	mov    (%eax),%eax
801011b3:	83 f8 02             	cmp    $0x2,%eax
801011b6:	75 60                	jne    80101218 <fileread+0xa9>
    ilock(f->ip);
801011b8:	8b 45 08             	mov    0x8(%ebp),%eax
801011bb:	8b 40 10             	mov    0x10(%eax),%eax
801011be:	83 ec 0c             	sub    $0xc,%esp
801011c1:	50                   	push   %eax
801011c2:	e8 38 07 00 00       	call   801018ff <ilock>
801011c7:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011cd:	8b 45 08             	mov    0x8(%ebp),%eax
801011d0:	8b 50 14             	mov    0x14(%eax),%edx
801011d3:	8b 45 08             	mov    0x8(%ebp),%eax
801011d6:	8b 40 10             	mov    0x10(%eax),%eax
801011d9:	51                   	push   %ecx
801011da:	52                   	push   %edx
801011db:	ff 75 0c             	pushl  0xc(%ebp)
801011de:	50                   	push   %eax
801011df:	e8 7d 0c 00 00       	call   80101e61 <readi>
801011e4:	83 c4 10             	add    $0x10,%esp
801011e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011ee:	7e 11                	jle    80101201 <fileread+0x92>
      f->off += r;
801011f0:	8b 45 08             	mov    0x8(%ebp),%eax
801011f3:	8b 50 14             	mov    0x14(%eax),%edx
801011f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011f9:	01 c2                	add    %eax,%edx
801011fb:	8b 45 08             	mov    0x8(%ebp),%eax
801011fe:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101201:	8b 45 08             	mov    0x8(%ebp),%eax
80101204:	8b 40 10             	mov    0x10(%eax),%eax
80101207:	83 ec 0c             	sub    $0xc,%esp
8010120a:	50                   	push   %eax
8010120b:	e8 46 08 00 00       	call   80101a56 <iunlock>
80101210:	83 c4 10             	add    $0x10,%esp
    return r;
80101213:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101216:	eb 0d                	jmp    80101225 <fileread+0xb6>
  }
  panic("fileread");
80101218:	83 ec 0c             	sub    $0xc,%esp
8010121b:	68 6a 86 10 80       	push   $0x8010866a
80101220:	e8 37 f3 ff ff       	call   8010055c <panic>
}
80101225:	c9                   	leave  
80101226:	c3                   	ret    

80101227 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101227:	55                   	push   %ebp
80101228:	89 e5                	mov    %esp,%ebp
8010122a:	53                   	push   %ebx
8010122b:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
8010122e:	8b 45 08             	mov    0x8(%ebp),%eax
80101231:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101235:	84 c0                	test   %al,%al
80101237:	75 0a                	jne    80101243 <filewrite+0x1c>
    return -1;
80101239:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010123e:	e9 1a 01 00 00       	jmp    8010135d <filewrite+0x136>
  if(f->type == FD_PIPE)
80101243:	8b 45 08             	mov    0x8(%ebp),%eax
80101246:	8b 00                	mov    (%eax),%eax
80101248:	83 f8 01             	cmp    $0x1,%eax
8010124b:	75 1d                	jne    8010126a <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
8010124d:	8b 45 08             	mov    0x8(%ebp),%eax
80101250:	8b 40 0c             	mov    0xc(%eax),%eax
80101253:	83 ec 04             	sub    $0x4,%esp
80101256:	ff 75 10             	pushl  0x10(%ebp)
80101259:	ff 75 0c             	pushl  0xc(%ebp)
8010125c:	50                   	push   %eax
8010125d:	e8 10 2f 00 00       	call   80104172 <pipewrite>
80101262:	83 c4 10             	add    $0x10,%esp
80101265:	e9 f3 00 00 00       	jmp    8010135d <filewrite+0x136>
  if(f->type == FD_INODE){
8010126a:	8b 45 08             	mov    0x8(%ebp),%eax
8010126d:	8b 00                	mov    (%eax),%eax
8010126f:	83 f8 02             	cmp    $0x2,%eax
80101272:	0f 85 d8 00 00 00    	jne    80101350 <filewrite+0x129>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101278:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
8010127f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101286:	e9 a5 00 00 00       	jmp    80101330 <filewrite+0x109>
      int n1 = n - i;
8010128b:	8b 45 10             	mov    0x10(%ebp),%eax
8010128e:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101291:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101294:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101297:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010129a:	7e 06                	jle    801012a2 <filewrite+0x7b>
        n1 = max;
8010129c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010129f:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
801012a2:	e8 e2 21 00 00       	call   80103489 <begin_op>
      ilock(f->ip);
801012a7:	8b 45 08             	mov    0x8(%ebp),%eax
801012aa:	8b 40 10             	mov    0x10(%eax),%eax
801012ad:	83 ec 0c             	sub    $0xc,%esp
801012b0:	50                   	push   %eax
801012b1:	e8 49 06 00 00       	call   801018ff <ilock>
801012b6:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012b9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012bc:	8b 45 08             	mov    0x8(%ebp),%eax
801012bf:	8b 50 14             	mov    0x14(%eax),%edx
801012c2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801012c8:	01 c3                	add    %eax,%ebx
801012ca:	8b 45 08             	mov    0x8(%ebp),%eax
801012cd:	8b 40 10             	mov    0x10(%eax),%eax
801012d0:	51                   	push   %ecx
801012d1:	52                   	push   %edx
801012d2:	53                   	push   %ebx
801012d3:	50                   	push   %eax
801012d4:	e8 e2 0c 00 00       	call   80101fbb <writei>
801012d9:	83 c4 10             	add    $0x10,%esp
801012dc:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012df:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012e3:	7e 11                	jle    801012f6 <filewrite+0xcf>
        f->off += r;
801012e5:	8b 45 08             	mov    0x8(%ebp),%eax
801012e8:	8b 50 14             	mov    0x14(%eax),%edx
801012eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012ee:	01 c2                	add    %eax,%edx
801012f0:	8b 45 08             	mov    0x8(%ebp),%eax
801012f3:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012f6:	8b 45 08             	mov    0x8(%ebp),%eax
801012f9:	8b 40 10             	mov    0x10(%eax),%eax
801012fc:	83 ec 0c             	sub    $0xc,%esp
801012ff:	50                   	push   %eax
80101300:	e8 51 07 00 00       	call   80101a56 <iunlock>
80101305:	83 c4 10             	add    $0x10,%esp
      end_op();
80101308:	e8 0a 22 00 00       	call   80103517 <end_op>

      if(r < 0)
8010130d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101311:	79 02                	jns    80101315 <filewrite+0xee>
        break;
80101313:	eb 27                	jmp    8010133c <filewrite+0x115>
      if(r != n1)
80101315:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101318:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010131b:	74 0d                	je     8010132a <filewrite+0x103>
        panic("short filewrite");
8010131d:	83 ec 0c             	sub    $0xc,%esp
80101320:	68 73 86 10 80       	push   $0x80108673
80101325:	e8 32 f2 ff ff       	call   8010055c <panic>
      i += r;
8010132a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010132d:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101330:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101333:	3b 45 10             	cmp    0x10(%ebp),%eax
80101336:	0f 8c 4f ff ff ff    	jl     8010128b <filewrite+0x64>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010133c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010133f:	3b 45 10             	cmp    0x10(%ebp),%eax
80101342:	75 05                	jne    80101349 <filewrite+0x122>
80101344:	8b 45 10             	mov    0x10(%ebp),%eax
80101347:	eb 14                	jmp    8010135d <filewrite+0x136>
80101349:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010134e:	eb 0d                	jmp    8010135d <filewrite+0x136>
  }
  panic("filewrite");
80101350:	83 ec 0c             	sub    $0xc,%esp
80101353:	68 83 86 10 80       	push   $0x80108683
80101358:	e8 ff f1 ff ff       	call   8010055c <panic>
}
8010135d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101360:	c9                   	leave  
80101361:	c3                   	ret    

80101362 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101362:	55                   	push   %ebp
80101363:	89 e5                	mov    %esp,%ebp
80101365:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101368:	8b 45 08             	mov    0x8(%ebp),%eax
8010136b:	83 ec 08             	sub    $0x8,%esp
8010136e:	6a 01                	push   $0x1
80101370:	50                   	push   %eax
80101371:	e8 3e ee ff ff       	call   801001b4 <bread>
80101376:	83 c4 10             	add    $0x10,%esp
80101379:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010137c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010137f:	83 c0 18             	add    $0x18,%eax
80101382:	83 ec 04             	sub    $0x4,%esp
80101385:	6a 10                	push   $0x10
80101387:	50                   	push   %eax
80101388:	ff 75 0c             	pushl  0xc(%ebp)
8010138b:	e8 a9 3f 00 00       	call   80105339 <memmove>
80101390:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101393:	83 ec 0c             	sub    $0xc,%esp
80101396:	ff 75 f4             	pushl  -0xc(%ebp)
80101399:	e8 8d ee ff ff       	call   8010022b <brelse>
8010139e:	83 c4 10             	add    $0x10,%esp
}
801013a1:	c9                   	leave  
801013a2:	c3                   	ret    

801013a3 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
801013a3:	55                   	push   %ebp
801013a4:	89 e5                	mov    %esp,%ebp
801013a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
801013a9:	8b 55 0c             	mov    0xc(%ebp),%edx
801013ac:	8b 45 08             	mov    0x8(%ebp),%eax
801013af:	83 ec 08             	sub    $0x8,%esp
801013b2:	52                   	push   %edx
801013b3:	50                   	push   %eax
801013b4:	e8 fb ed ff ff       	call   801001b4 <bread>
801013b9:	83 c4 10             	add    $0x10,%esp
801013bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013c2:	83 c0 18             	add    $0x18,%eax
801013c5:	83 ec 04             	sub    $0x4,%esp
801013c8:	68 00 02 00 00       	push   $0x200
801013cd:	6a 00                	push   $0x0
801013cf:	50                   	push   %eax
801013d0:	e8 a5 3e 00 00       	call   8010527a <memset>
801013d5:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013d8:	83 ec 0c             	sub    $0xc,%esp
801013db:	ff 75 f4             	pushl  -0xc(%ebp)
801013de:	e8 dd 22 00 00       	call   801036c0 <log_write>
801013e3:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013e6:	83 ec 0c             	sub    $0xc,%esp
801013e9:	ff 75 f4             	pushl  -0xc(%ebp)
801013ec:	e8 3a ee ff ff       	call   8010022b <brelse>
801013f1:	83 c4 10             	add    $0x10,%esp
}
801013f4:	c9                   	leave  
801013f5:	c3                   	ret    

801013f6 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013f6:	55                   	push   %ebp
801013f7:	89 e5                	mov    %esp,%ebp
801013f9:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
801013fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
80101403:	8b 45 08             	mov    0x8(%ebp),%eax
80101406:	83 ec 08             	sub    $0x8,%esp
80101409:	8d 55 d8             	lea    -0x28(%ebp),%edx
8010140c:	52                   	push   %edx
8010140d:	50                   	push   %eax
8010140e:	e8 4f ff ff ff       	call   80101362 <readsb>
80101413:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
80101416:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010141d:	e9 15 01 00 00       	jmp    80101537 <balloc+0x141>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
80101422:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101425:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
8010142b:	85 c0                	test   %eax,%eax
8010142d:	0f 48 c2             	cmovs  %edx,%eax
80101430:	c1 f8 0c             	sar    $0xc,%eax
80101433:	89 c2                	mov    %eax,%edx
80101435:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101438:	c1 e8 03             	shr    $0x3,%eax
8010143b:	01 d0                	add    %edx,%eax
8010143d:	83 c0 03             	add    $0x3,%eax
80101440:	83 ec 08             	sub    $0x8,%esp
80101443:	50                   	push   %eax
80101444:	ff 75 08             	pushl  0x8(%ebp)
80101447:	e8 68 ed ff ff       	call   801001b4 <bread>
8010144c:	83 c4 10             	add    $0x10,%esp
8010144f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101452:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101459:	e9 a6 00 00 00       	jmp    80101504 <balloc+0x10e>
      m = 1 << (bi % 8);
8010145e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101461:	99                   	cltd   
80101462:	c1 ea 1d             	shr    $0x1d,%edx
80101465:	01 d0                	add    %edx,%eax
80101467:	83 e0 07             	and    $0x7,%eax
8010146a:	29 d0                	sub    %edx,%eax
8010146c:	ba 01 00 00 00       	mov    $0x1,%edx
80101471:	89 c1                	mov    %eax,%ecx
80101473:	d3 e2                	shl    %cl,%edx
80101475:	89 d0                	mov    %edx,%eax
80101477:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010147a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010147d:	8d 50 07             	lea    0x7(%eax),%edx
80101480:	85 c0                	test   %eax,%eax
80101482:	0f 48 c2             	cmovs  %edx,%eax
80101485:	c1 f8 03             	sar    $0x3,%eax
80101488:	89 c2                	mov    %eax,%edx
8010148a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010148d:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101492:	0f b6 c0             	movzbl %al,%eax
80101495:	23 45 e8             	and    -0x18(%ebp),%eax
80101498:	85 c0                	test   %eax,%eax
8010149a:	75 64                	jne    80101500 <balloc+0x10a>
        bp->data[bi/8] |= m;  // Mark block in use.
8010149c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010149f:	8d 50 07             	lea    0x7(%eax),%edx
801014a2:	85 c0                	test   %eax,%eax
801014a4:	0f 48 c2             	cmovs  %edx,%eax
801014a7:	c1 f8 03             	sar    $0x3,%eax
801014aa:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014ad:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801014b2:	89 d1                	mov    %edx,%ecx
801014b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014b7:	09 ca                	or     %ecx,%edx
801014b9:	89 d1                	mov    %edx,%ecx
801014bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014be:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
801014c2:	83 ec 0c             	sub    $0xc,%esp
801014c5:	ff 75 ec             	pushl  -0x14(%ebp)
801014c8:	e8 f3 21 00 00       	call   801036c0 <log_write>
801014cd:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014d0:	83 ec 0c             	sub    $0xc,%esp
801014d3:	ff 75 ec             	pushl  -0x14(%ebp)
801014d6:	e8 50 ed ff ff       	call   8010022b <brelse>
801014db:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014de:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014e4:	01 c2                	add    %eax,%edx
801014e6:	8b 45 08             	mov    0x8(%ebp),%eax
801014e9:	83 ec 08             	sub    $0x8,%esp
801014ec:	52                   	push   %edx
801014ed:	50                   	push   %eax
801014ee:	e8 b0 fe ff ff       	call   801013a3 <bzero>
801014f3:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801014f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fc:	01 d0                	add    %edx,%eax
801014fe:	eb 52                	jmp    80101552 <balloc+0x15c>

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101500:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101504:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010150b:	7f 15                	jg     80101522 <balloc+0x12c>
8010150d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101510:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101513:	01 d0                	add    %edx,%eax
80101515:	89 c2                	mov    %eax,%edx
80101517:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010151a:	39 c2                	cmp    %eax,%edx
8010151c:	0f 82 3c ff ff ff    	jb     8010145e <balloc+0x68>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101522:	83 ec 0c             	sub    $0xc,%esp
80101525:	ff 75 ec             	pushl  -0x14(%ebp)
80101528:	e8 fe ec ff ff       	call   8010022b <brelse>
8010152d:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
80101530:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80101537:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010153a:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010153d:	39 c2                	cmp    %eax,%edx
8010153f:	0f 82 dd fe ff ff    	jb     80101422 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101545:	83 ec 0c             	sub    $0xc,%esp
80101548:	68 8d 86 10 80       	push   $0x8010868d
8010154d:	e8 0a f0 ff ff       	call   8010055c <panic>
}
80101552:	c9                   	leave  
80101553:	c3                   	ret    

80101554 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101554:	55                   	push   %ebp
80101555:	89 e5                	mov    %esp,%ebp
80101557:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
8010155a:	83 ec 08             	sub    $0x8,%esp
8010155d:	8d 45 dc             	lea    -0x24(%ebp),%eax
80101560:	50                   	push   %eax
80101561:	ff 75 08             	pushl  0x8(%ebp)
80101564:	e8 f9 fd ff ff       	call   80101362 <readsb>
80101569:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
8010156c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010156f:	c1 e8 0c             	shr    $0xc,%eax
80101572:	89 c2                	mov    %eax,%edx
80101574:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101577:	c1 e8 03             	shr    $0x3,%eax
8010157a:	01 d0                	add    %edx,%eax
8010157c:	8d 50 03             	lea    0x3(%eax),%edx
8010157f:	8b 45 08             	mov    0x8(%ebp),%eax
80101582:	83 ec 08             	sub    $0x8,%esp
80101585:	52                   	push   %edx
80101586:	50                   	push   %eax
80101587:	e8 28 ec ff ff       	call   801001b4 <bread>
8010158c:	83 c4 10             	add    $0x10,%esp
8010158f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101592:	8b 45 0c             	mov    0xc(%ebp),%eax
80101595:	25 ff 0f 00 00       	and    $0xfff,%eax
8010159a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010159d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015a0:	99                   	cltd   
801015a1:	c1 ea 1d             	shr    $0x1d,%edx
801015a4:	01 d0                	add    %edx,%eax
801015a6:	83 e0 07             	and    $0x7,%eax
801015a9:	29 d0                	sub    %edx,%eax
801015ab:	ba 01 00 00 00       	mov    $0x1,%edx
801015b0:	89 c1                	mov    %eax,%ecx
801015b2:	d3 e2                	shl    %cl,%edx
801015b4:	89 d0                	mov    %edx,%eax
801015b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801015b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015bc:	8d 50 07             	lea    0x7(%eax),%edx
801015bf:	85 c0                	test   %eax,%eax
801015c1:	0f 48 c2             	cmovs  %edx,%eax
801015c4:	c1 f8 03             	sar    $0x3,%eax
801015c7:	89 c2                	mov    %eax,%edx
801015c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015cc:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801015d1:	0f b6 c0             	movzbl %al,%eax
801015d4:	23 45 ec             	and    -0x14(%ebp),%eax
801015d7:	85 c0                	test   %eax,%eax
801015d9:	75 0d                	jne    801015e8 <bfree+0x94>
    panic("freeing free block");
801015db:	83 ec 0c             	sub    $0xc,%esp
801015de:	68 a3 86 10 80       	push   $0x801086a3
801015e3:	e8 74 ef ff ff       	call   8010055c <panic>
  bp->data[bi/8] &= ~m;
801015e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015eb:	8d 50 07             	lea    0x7(%eax),%edx
801015ee:	85 c0                	test   %eax,%eax
801015f0:	0f 48 c2             	cmovs  %edx,%eax
801015f3:	c1 f8 03             	sar    $0x3,%eax
801015f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015f9:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015fe:	89 d1                	mov    %edx,%ecx
80101600:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101603:	f7 d2                	not    %edx
80101605:	21 ca                	and    %ecx,%edx
80101607:	89 d1                	mov    %edx,%ecx
80101609:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010160c:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101610:	83 ec 0c             	sub    $0xc,%esp
80101613:	ff 75 f4             	pushl  -0xc(%ebp)
80101616:	e8 a5 20 00 00       	call   801036c0 <log_write>
8010161b:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010161e:	83 ec 0c             	sub    $0xc,%esp
80101621:	ff 75 f4             	pushl  -0xc(%ebp)
80101624:	e8 02 ec ff ff       	call   8010022b <brelse>
80101629:	83 c4 10             	add    $0x10,%esp
}
8010162c:	c9                   	leave  
8010162d:	c3                   	ret    

8010162e <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
8010162e:	55                   	push   %ebp
8010162f:	89 e5                	mov    %esp,%ebp
80101631:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
80101634:	83 ec 08             	sub    $0x8,%esp
80101637:	68 b6 86 10 80       	push   $0x801086b6
8010163c:	68 c0 12 11 80       	push   $0x801112c0
80101641:	e8 b7 39 00 00       	call   80104ffd <initlock>
80101646:	83 c4 10             	add    $0x10,%esp
}
80101649:	c9                   	leave  
8010164a:	c3                   	ret    

8010164b <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
8010164b:	55                   	push   %ebp
8010164c:	89 e5                	mov    %esp,%ebp
8010164e:	83 ec 38             	sub    $0x38,%esp
80101651:	8b 45 0c             	mov    0xc(%ebp),%eax
80101654:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
80101658:	8b 45 08             	mov    0x8(%ebp),%eax
8010165b:	83 ec 08             	sub    $0x8,%esp
8010165e:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101661:	52                   	push   %edx
80101662:	50                   	push   %eax
80101663:	e8 fa fc ff ff       	call   80101362 <readsb>
80101668:	83 c4 10             	add    $0x10,%esp

  for(inum = 1; inum < sb.ninodes; inum++){
8010166b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101672:	e9 98 00 00 00       	jmp    8010170f <ialloc+0xc4>
    bp = bread(dev, IBLOCK(inum));
80101677:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010167a:	c1 e8 03             	shr    $0x3,%eax
8010167d:	83 c0 02             	add    $0x2,%eax
80101680:	83 ec 08             	sub    $0x8,%esp
80101683:	50                   	push   %eax
80101684:	ff 75 08             	pushl  0x8(%ebp)
80101687:	e8 28 eb ff ff       	call   801001b4 <bread>
8010168c:	83 c4 10             	add    $0x10,%esp
8010168f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101692:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101695:	8d 50 18             	lea    0x18(%eax),%edx
80101698:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010169b:	83 e0 07             	and    $0x7,%eax
8010169e:	c1 e0 06             	shl    $0x6,%eax
801016a1:	01 d0                	add    %edx,%eax
801016a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801016a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016a9:	0f b7 00             	movzwl (%eax),%eax
801016ac:	66 85 c0             	test   %ax,%ax
801016af:	75 4c                	jne    801016fd <ialloc+0xb2>
      memset(dip, 0, sizeof(*dip));
801016b1:	83 ec 04             	sub    $0x4,%esp
801016b4:	6a 40                	push   $0x40
801016b6:	6a 00                	push   $0x0
801016b8:	ff 75 ec             	pushl  -0x14(%ebp)
801016bb:	e8 ba 3b 00 00       	call   8010527a <memset>
801016c0:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801016c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016c6:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
801016ca:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801016cd:	83 ec 0c             	sub    $0xc,%esp
801016d0:	ff 75 f0             	pushl  -0x10(%ebp)
801016d3:	e8 e8 1f 00 00       	call   801036c0 <log_write>
801016d8:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801016db:	83 ec 0c             	sub    $0xc,%esp
801016de:	ff 75 f0             	pushl  -0x10(%ebp)
801016e1:	e8 45 eb ff ff       	call   8010022b <brelse>
801016e6:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
801016e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016ec:	83 ec 08             	sub    $0x8,%esp
801016ef:	50                   	push   %eax
801016f0:	ff 75 08             	pushl  0x8(%ebp)
801016f3:	e8 ee 00 00 00       	call   801017e6 <iget>
801016f8:	83 c4 10             	add    $0x10,%esp
801016fb:	eb 2d                	jmp    8010172a <ialloc+0xdf>
    }
    brelse(bp);
801016fd:	83 ec 0c             	sub    $0xc,%esp
80101700:	ff 75 f0             	pushl  -0x10(%ebp)
80101703:	e8 23 eb ff ff       	call   8010022b <brelse>
80101708:	83 c4 10             	add    $0x10,%esp
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
8010170b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010170f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101712:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101715:	39 c2                	cmp    %eax,%edx
80101717:	0f 82 5a ff ff ff    	jb     80101677 <ialloc+0x2c>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
8010171d:	83 ec 0c             	sub    $0xc,%esp
80101720:	68 bd 86 10 80       	push   $0x801086bd
80101725:	e8 32 ee ff ff       	call   8010055c <panic>
}
8010172a:	c9                   	leave  
8010172b:	c3                   	ret    

8010172c <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
8010172c:	55                   	push   %ebp
8010172d:	89 e5                	mov    %esp,%ebp
8010172f:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
80101732:	8b 45 08             	mov    0x8(%ebp),%eax
80101735:	8b 40 04             	mov    0x4(%eax),%eax
80101738:	c1 e8 03             	shr    $0x3,%eax
8010173b:	8d 50 02             	lea    0x2(%eax),%edx
8010173e:	8b 45 08             	mov    0x8(%ebp),%eax
80101741:	8b 00                	mov    (%eax),%eax
80101743:	83 ec 08             	sub    $0x8,%esp
80101746:	52                   	push   %edx
80101747:	50                   	push   %eax
80101748:	e8 67 ea ff ff       	call   801001b4 <bread>
8010174d:	83 c4 10             	add    $0x10,%esp
80101750:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101756:	8d 50 18             	lea    0x18(%eax),%edx
80101759:	8b 45 08             	mov    0x8(%ebp),%eax
8010175c:	8b 40 04             	mov    0x4(%eax),%eax
8010175f:	83 e0 07             	and    $0x7,%eax
80101762:	c1 e0 06             	shl    $0x6,%eax
80101765:	01 d0                	add    %edx,%eax
80101767:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
8010176a:	8b 45 08             	mov    0x8(%ebp),%eax
8010176d:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101771:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101774:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101777:	8b 45 08             	mov    0x8(%ebp),%eax
8010177a:	0f b7 50 12          	movzwl 0x12(%eax),%edx
8010177e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101781:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101785:	8b 45 08             	mov    0x8(%ebp),%eax
80101788:	0f b7 50 14          	movzwl 0x14(%eax),%edx
8010178c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010178f:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101793:	8b 45 08             	mov    0x8(%ebp),%eax
80101796:	0f b7 50 16          	movzwl 0x16(%eax),%edx
8010179a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010179d:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801017a1:	8b 45 08             	mov    0x8(%ebp),%eax
801017a4:	8b 50 18             	mov    0x18(%eax),%edx
801017a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017aa:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ad:	8b 45 08             	mov    0x8(%ebp),%eax
801017b0:	8d 50 1c             	lea    0x1c(%eax),%edx
801017b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017b6:	83 c0 0c             	add    $0xc,%eax
801017b9:	83 ec 04             	sub    $0x4,%esp
801017bc:	6a 34                	push   $0x34
801017be:	52                   	push   %edx
801017bf:	50                   	push   %eax
801017c0:	e8 74 3b 00 00       	call   80105339 <memmove>
801017c5:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017c8:	83 ec 0c             	sub    $0xc,%esp
801017cb:	ff 75 f4             	pushl  -0xc(%ebp)
801017ce:	e8 ed 1e 00 00       	call   801036c0 <log_write>
801017d3:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801017d6:	83 ec 0c             	sub    $0xc,%esp
801017d9:	ff 75 f4             	pushl  -0xc(%ebp)
801017dc:	e8 4a ea ff ff       	call   8010022b <brelse>
801017e1:	83 c4 10             	add    $0x10,%esp
}
801017e4:	c9                   	leave  
801017e5:	c3                   	ret    

801017e6 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801017e6:	55                   	push   %ebp
801017e7:	89 e5                	mov    %esp,%ebp
801017e9:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801017ec:	83 ec 0c             	sub    $0xc,%esp
801017ef:	68 c0 12 11 80       	push   $0x801112c0
801017f4:	e8 25 38 00 00       	call   8010501e <acquire>
801017f9:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801017fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101803:	c7 45 f4 f4 12 11 80 	movl   $0x801112f4,-0xc(%ebp)
8010180a:	eb 5d                	jmp    80101869 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010180c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010180f:	8b 40 08             	mov    0x8(%eax),%eax
80101812:	85 c0                	test   %eax,%eax
80101814:	7e 39                	jle    8010184f <iget+0x69>
80101816:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101819:	8b 00                	mov    (%eax),%eax
8010181b:	3b 45 08             	cmp    0x8(%ebp),%eax
8010181e:	75 2f                	jne    8010184f <iget+0x69>
80101820:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101823:	8b 40 04             	mov    0x4(%eax),%eax
80101826:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101829:	75 24                	jne    8010184f <iget+0x69>
      ip->ref++;
8010182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010182e:	8b 40 08             	mov    0x8(%eax),%eax
80101831:	8d 50 01             	lea    0x1(%eax),%edx
80101834:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101837:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
8010183a:	83 ec 0c             	sub    $0xc,%esp
8010183d:	68 c0 12 11 80       	push   $0x801112c0
80101842:	e8 3d 38 00 00       	call   80105084 <release>
80101847:	83 c4 10             	add    $0x10,%esp
      return ip;
8010184a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010184d:	eb 74                	jmp    801018c3 <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
8010184f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101853:	75 10                	jne    80101865 <iget+0x7f>
80101855:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101858:	8b 40 08             	mov    0x8(%eax),%eax
8010185b:	85 c0                	test   %eax,%eax
8010185d:	75 06                	jne    80101865 <iget+0x7f>
      empty = ip;
8010185f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101862:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101865:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101869:	81 7d f4 94 22 11 80 	cmpl   $0x80112294,-0xc(%ebp)
80101870:	72 9a                	jb     8010180c <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101872:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101876:	75 0d                	jne    80101885 <iget+0x9f>
    panic("iget: no inodes");
80101878:	83 ec 0c             	sub    $0xc,%esp
8010187b:	68 cf 86 10 80       	push   $0x801086cf
80101880:	e8 d7 ec ff ff       	call   8010055c <panic>

  ip = empty;
80101885:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101888:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
8010188b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010188e:	8b 55 08             	mov    0x8(%ebp),%edx
80101891:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101893:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101896:	8b 55 0c             	mov    0xc(%ebp),%edx
80101899:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
8010189c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010189f:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
801018a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a9:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
801018b0:	83 ec 0c             	sub    $0xc,%esp
801018b3:	68 c0 12 11 80       	push   $0x801112c0
801018b8:	e8 c7 37 00 00       	call   80105084 <release>
801018bd:	83 c4 10             	add    $0x10,%esp

  return ip;
801018c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801018c3:	c9                   	leave  
801018c4:	c3                   	ret    

801018c5 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801018c5:	55                   	push   %ebp
801018c6:	89 e5                	mov    %esp,%ebp
801018c8:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801018cb:	83 ec 0c             	sub    $0xc,%esp
801018ce:	68 c0 12 11 80       	push   $0x801112c0
801018d3:	e8 46 37 00 00       	call   8010501e <acquire>
801018d8:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801018db:	8b 45 08             	mov    0x8(%ebp),%eax
801018de:	8b 40 08             	mov    0x8(%eax),%eax
801018e1:	8d 50 01             	lea    0x1(%eax),%edx
801018e4:	8b 45 08             	mov    0x8(%ebp),%eax
801018e7:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801018ea:	83 ec 0c             	sub    $0xc,%esp
801018ed:	68 c0 12 11 80       	push   $0x801112c0
801018f2:	e8 8d 37 00 00       	call   80105084 <release>
801018f7:	83 c4 10             	add    $0x10,%esp
  return ip;
801018fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
801018fd:	c9                   	leave  
801018fe:	c3                   	ret    

801018ff <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801018ff:	55                   	push   %ebp
80101900:	89 e5                	mov    %esp,%ebp
80101902:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101905:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101909:	74 0a                	je     80101915 <ilock+0x16>
8010190b:	8b 45 08             	mov    0x8(%ebp),%eax
8010190e:	8b 40 08             	mov    0x8(%eax),%eax
80101911:	85 c0                	test   %eax,%eax
80101913:	7f 0d                	jg     80101922 <ilock+0x23>
    panic("ilock");
80101915:	83 ec 0c             	sub    $0xc,%esp
80101918:	68 df 86 10 80       	push   $0x801086df
8010191d:	e8 3a ec ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
80101922:	83 ec 0c             	sub    $0xc,%esp
80101925:	68 c0 12 11 80       	push   $0x801112c0
8010192a:	e8 ef 36 00 00       	call   8010501e <acquire>
8010192f:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
80101932:	eb 13                	jmp    80101947 <ilock+0x48>
    sleep(ip, &icache.lock);
80101934:	83 ec 08             	sub    $0x8,%esp
80101937:	68 c0 12 11 80       	push   $0x801112c0
8010193c:	ff 75 08             	pushl  0x8(%ebp)
8010193f:	e8 ff 32 00 00       	call   80104c43 <sleep>
80101944:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101947:	8b 45 08             	mov    0x8(%ebp),%eax
8010194a:	8b 40 0c             	mov    0xc(%eax),%eax
8010194d:	83 e0 01             	and    $0x1,%eax
80101950:	85 c0                	test   %eax,%eax
80101952:	75 e0                	jne    80101934 <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
80101954:	8b 45 08             	mov    0x8(%ebp),%eax
80101957:	8b 40 0c             	mov    0xc(%eax),%eax
8010195a:	83 c8 01             	or     $0x1,%eax
8010195d:	89 c2                	mov    %eax,%edx
8010195f:	8b 45 08             	mov    0x8(%ebp),%eax
80101962:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101965:	83 ec 0c             	sub    $0xc,%esp
80101968:	68 c0 12 11 80       	push   $0x801112c0
8010196d:	e8 12 37 00 00       	call   80105084 <release>
80101972:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101975:	8b 45 08             	mov    0x8(%ebp),%eax
80101978:	8b 40 0c             	mov    0xc(%eax),%eax
8010197b:	83 e0 02             	and    $0x2,%eax
8010197e:	85 c0                	test   %eax,%eax
80101980:	0f 85 ce 00 00 00    	jne    80101a54 <ilock+0x155>
    bp = bread(ip->dev, IBLOCK(ip->inum));
80101986:	8b 45 08             	mov    0x8(%ebp),%eax
80101989:	8b 40 04             	mov    0x4(%eax),%eax
8010198c:	c1 e8 03             	shr    $0x3,%eax
8010198f:	8d 50 02             	lea    0x2(%eax),%edx
80101992:	8b 45 08             	mov    0x8(%ebp),%eax
80101995:	8b 00                	mov    (%eax),%eax
80101997:	83 ec 08             	sub    $0x8,%esp
8010199a:	52                   	push   %edx
8010199b:	50                   	push   %eax
8010199c:	e8 13 e8 ff ff       	call   801001b4 <bread>
801019a1:	83 c4 10             	add    $0x10,%esp
801019a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019aa:	8d 50 18             	lea    0x18(%eax),%edx
801019ad:	8b 45 08             	mov    0x8(%ebp),%eax
801019b0:	8b 40 04             	mov    0x4(%eax),%eax
801019b3:	83 e0 07             	and    $0x7,%eax
801019b6:	c1 e0 06             	shl    $0x6,%eax
801019b9:	01 d0                	add    %edx,%eax
801019bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801019be:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019c1:	0f b7 10             	movzwl (%eax),%edx
801019c4:	8b 45 08             	mov    0x8(%ebp),%eax
801019c7:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
801019cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019ce:	0f b7 50 02          	movzwl 0x2(%eax),%edx
801019d2:	8b 45 08             	mov    0x8(%ebp),%eax
801019d5:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
801019d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019dc:	0f b7 50 04          	movzwl 0x4(%eax),%edx
801019e0:	8b 45 08             	mov    0x8(%ebp),%eax
801019e3:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
801019e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019ea:	0f b7 50 06          	movzwl 0x6(%eax),%edx
801019ee:	8b 45 08             	mov    0x8(%ebp),%eax
801019f1:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
801019f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f8:	8b 50 08             	mov    0x8(%eax),%edx
801019fb:	8b 45 08             	mov    0x8(%ebp),%eax
801019fe:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a01:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a04:	8d 50 0c             	lea    0xc(%eax),%edx
80101a07:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0a:	83 c0 1c             	add    $0x1c,%eax
80101a0d:	83 ec 04             	sub    $0x4,%esp
80101a10:	6a 34                	push   $0x34
80101a12:	52                   	push   %edx
80101a13:	50                   	push   %eax
80101a14:	e8 20 39 00 00       	call   80105339 <memmove>
80101a19:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a1c:	83 ec 0c             	sub    $0xc,%esp
80101a1f:	ff 75 f4             	pushl  -0xc(%ebp)
80101a22:	e8 04 e8 ff ff       	call   8010022b <brelse>
80101a27:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101a2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2d:	8b 40 0c             	mov    0xc(%eax),%eax
80101a30:	83 c8 02             	or     $0x2,%eax
80101a33:	89 c2                	mov    %eax,%edx
80101a35:	8b 45 08             	mov    0x8(%ebp),%eax
80101a38:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a42:	66 85 c0             	test   %ax,%ax
80101a45:	75 0d                	jne    80101a54 <ilock+0x155>
      panic("ilock: no type");
80101a47:	83 ec 0c             	sub    $0xc,%esp
80101a4a:	68 e5 86 10 80       	push   $0x801086e5
80101a4f:	e8 08 eb ff ff       	call   8010055c <panic>
  }
}
80101a54:	c9                   	leave  
80101a55:	c3                   	ret    

80101a56 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a56:	55                   	push   %ebp
80101a57:	89 e5                	mov    %esp,%ebp
80101a59:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101a5c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a60:	74 17                	je     80101a79 <iunlock+0x23>
80101a62:	8b 45 08             	mov    0x8(%ebp),%eax
80101a65:	8b 40 0c             	mov    0xc(%eax),%eax
80101a68:	83 e0 01             	and    $0x1,%eax
80101a6b:	85 c0                	test   %eax,%eax
80101a6d:	74 0a                	je     80101a79 <iunlock+0x23>
80101a6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a72:	8b 40 08             	mov    0x8(%eax),%eax
80101a75:	85 c0                	test   %eax,%eax
80101a77:	7f 0d                	jg     80101a86 <iunlock+0x30>
    panic("iunlock");
80101a79:	83 ec 0c             	sub    $0xc,%esp
80101a7c:	68 f4 86 10 80       	push   $0x801086f4
80101a81:	e8 d6 ea ff ff       	call   8010055c <panic>

  acquire(&icache.lock);
80101a86:	83 ec 0c             	sub    $0xc,%esp
80101a89:	68 c0 12 11 80       	push   $0x801112c0
80101a8e:	e8 8b 35 00 00       	call   8010501e <acquire>
80101a93:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101a96:	8b 45 08             	mov    0x8(%ebp),%eax
80101a99:	8b 40 0c             	mov    0xc(%eax),%eax
80101a9c:	83 e0 fe             	and    $0xfffffffe,%eax
80101a9f:	89 c2                	mov    %eax,%edx
80101aa1:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa4:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101aa7:	83 ec 0c             	sub    $0xc,%esp
80101aaa:	ff 75 08             	pushl  0x8(%ebp)
80101aad:	e8 7a 32 00 00       	call   80104d2c <wakeup>
80101ab2:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101ab5:	83 ec 0c             	sub    $0xc,%esp
80101ab8:	68 c0 12 11 80       	push   $0x801112c0
80101abd:	e8 c2 35 00 00       	call   80105084 <release>
80101ac2:	83 c4 10             	add    $0x10,%esp
}
80101ac5:	c9                   	leave  
80101ac6:	c3                   	ret    

80101ac7 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101ac7:	55                   	push   %ebp
80101ac8:	89 e5                	mov    %esp,%ebp
80101aca:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101acd:	83 ec 0c             	sub    $0xc,%esp
80101ad0:	68 c0 12 11 80       	push   $0x801112c0
80101ad5:	e8 44 35 00 00       	call   8010501e <acquire>
80101ada:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101add:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae0:	8b 40 08             	mov    0x8(%eax),%eax
80101ae3:	83 f8 01             	cmp    $0x1,%eax
80101ae6:	0f 85 a9 00 00 00    	jne    80101b95 <iput+0xce>
80101aec:	8b 45 08             	mov    0x8(%ebp),%eax
80101aef:	8b 40 0c             	mov    0xc(%eax),%eax
80101af2:	83 e0 02             	and    $0x2,%eax
80101af5:	85 c0                	test   %eax,%eax
80101af7:	0f 84 98 00 00 00    	je     80101b95 <iput+0xce>
80101afd:	8b 45 08             	mov    0x8(%ebp),%eax
80101b00:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101b04:	66 85 c0             	test   %ax,%ax
80101b07:	0f 85 88 00 00 00    	jne    80101b95 <iput+0xce>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101b0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b10:	8b 40 0c             	mov    0xc(%eax),%eax
80101b13:	83 e0 01             	and    $0x1,%eax
80101b16:	85 c0                	test   %eax,%eax
80101b18:	74 0d                	je     80101b27 <iput+0x60>
      panic("iput busy");
80101b1a:	83 ec 0c             	sub    $0xc,%esp
80101b1d:	68 fc 86 10 80       	push   $0x801086fc
80101b22:	e8 35 ea ff ff       	call   8010055c <panic>
    ip->flags |= I_BUSY;
80101b27:	8b 45 08             	mov    0x8(%ebp),%eax
80101b2a:	8b 40 0c             	mov    0xc(%eax),%eax
80101b2d:	83 c8 01             	or     $0x1,%eax
80101b30:	89 c2                	mov    %eax,%edx
80101b32:	8b 45 08             	mov    0x8(%ebp),%eax
80101b35:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101b38:	83 ec 0c             	sub    $0xc,%esp
80101b3b:	68 c0 12 11 80       	push   $0x801112c0
80101b40:	e8 3f 35 00 00       	call   80105084 <release>
80101b45:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101b48:	83 ec 0c             	sub    $0xc,%esp
80101b4b:	ff 75 08             	pushl  0x8(%ebp)
80101b4e:	e8 a6 01 00 00       	call   80101cf9 <itrunc>
80101b53:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101b56:	8b 45 08             	mov    0x8(%ebp),%eax
80101b59:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101b5f:	83 ec 0c             	sub    $0xc,%esp
80101b62:	ff 75 08             	pushl  0x8(%ebp)
80101b65:	e8 c2 fb ff ff       	call   8010172c <iupdate>
80101b6a:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101b6d:	83 ec 0c             	sub    $0xc,%esp
80101b70:	68 c0 12 11 80       	push   $0x801112c0
80101b75:	e8 a4 34 00 00       	call   8010501e <acquire>
80101b7a:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b80:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b87:	83 ec 0c             	sub    $0xc,%esp
80101b8a:	ff 75 08             	pushl  0x8(%ebp)
80101b8d:	e8 9a 31 00 00       	call   80104d2c <wakeup>
80101b92:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101b95:	8b 45 08             	mov    0x8(%ebp),%eax
80101b98:	8b 40 08             	mov    0x8(%eax),%eax
80101b9b:	8d 50 ff             	lea    -0x1(%eax),%edx
80101b9e:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba1:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101ba4:	83 ec 0c             	sub    $0xc,%esp
80101ba7:	68 c0 12 11 80       	push   $0x801112c0
80101bac:	e8 d3 34 00 00       	call   80105084 <release>
80101bb1:	83 c4 10             	add    $0x10,%esp
}
80101bb4:	c9                   	leave  
80101bb5:	c3                   	ret    

80101bb6 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101bb6:	55                   	push   %ebp
80101bb7:	89 e5                	mov    %esp,%ebp
80101bb9:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101bbc:	83 ec 0c             	sub    $0xc,%esp
80101bbf:	ff 75 08             	pushl  0x8(%ebp)
80101bc2:	e8 8f fe ff ff       	call   80101a56 <iunlock>
80101bc7:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101bca:	83 ec 0c             	sub    $0xc,%esp
80101bcd:	ff 75 08             	pushl  0x8(%ebp)
80101bd0:	e8 f2 fe ff ff       	call   80101ac7 <iput>
80101bd5:	83 c4 10             	add    $0x10,%esp
}
80101bd8:	c9                   	leave  
80101bd9:	c3                   	ret    

80101bda <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101bda:	55                   	push   %ebp
80101bdb:	89 e5                	mov    %esp,%ebp
80101bdd:	53                   	push   %ebx
80101bde:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101be1:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101be5:	77 42                	ja     80101c29 <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101be7:	8b 45 08             	mov    0x8(%ebp),%eax
80101bea:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bed:	83 c2 04             	add    $0x4,%edx
80101bf0:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101bf4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bf7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bfb:	75 24                	jne    80101c21 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101bfd:	8b 45 08             	mov    0x8(%ebp),%eax
80101c00:	8b 00                	mov    (%eax),%eax
80101c02:	83 ec 0c             	sub    $0xc,%esp
80101c05:	50                   	push   %eax
80101c06:	e8 eb f7 ff ff       	call   801013f6 <balloc>
80101c0b:	83 c4 10             	add    $0x10,%esp
80101c0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c11:	8b 45 08             	mov    0x8(%ebp),%eax
80101c14:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c17:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c1d:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c24:	e9 cb 00 00 00       	jmp    80101cf4 <bmap+0x11a>
  }
  bn -= NDIRECT;
80101c29:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c2d:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c31:	0f 87 b0 00 00 00    	ja     80101ce7 <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c37:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3a:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c40:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c44:	75 1d                	jne    80101c63 <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c46:	8b 45 08             	mov    0x8(%ebp),%eax
80101c49:	8b 00                	mov    (%eax),%eax
80101c4b:	83 ec 0c             	sub    $0xc,%esp
80101c4e:	50                   	push   %eax
80101c4f:	e8 a2 f7 ff ff       	call   801013f6 <balloc>
80101c54:	83 c4 10             	add    $0x10,%esp
80101c57:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c5a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c60:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101c63:	8b 45 08             	mov    0x8(%ebp),%eax
80101c66:	8b 00                	mov    (%eax),%eax
80101c68:	83 ec 08             	sub    $0x8,%esp
80101c6b:	ff 75 f4             	pushl  -0xc(%ebp)
80101c6e:	50                   	push   %eax
80101c6f:	e8 40 e5 ff ff       	call   801001b4 <bread>
80101c74:	83 c4 10             	add    $0x10,%esp
80101c77:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c7d:	83 c0 18             	add    $0x18,%eax
80101c80:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c83:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c86:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c90:	01 d0                	add    %edx,%eax
80101c92:	8b 00                	mov    (%eax),%eax
80101c94:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c9b:	75 37                	jne    80101cd4 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101c9d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ca0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ca7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101caa:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101cad:	8b 45 08             	mov    0x8(%ebp),%eax
80101cb0:	8b 00                	mov    (%eax),%eax
80101cb2:	83 ec 0c             	sub    $0xc,%esp
80101cb5:	50                   	push   %eax
80101cb6:	e8 3b f7 ff ff       	call   801013f6 <balloc>
80101cbb:	83 c4 10             	add    $0x10,%esp
80101cbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cc4:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101cc6:	83 ec 0c             	sub    $0xc,%esp
80101cc9:	ff 75 f0             	pushl  -0x10(%ebp)
80101ccc:	e8 ef 19 00 00       	call   801036c0 <log_write>
80101cd1:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101cd4:	83 ec 0c             	sub    $0xc,%esp
80101cd7:	ff 75 f0             	pushl  -0x10(%ebp)
80101cda:	e8 4c e5 ff ff       	call   8010022b <brelse>
80101cdf:	83 c4 10             	add    $0x10,%esp
    return addr;
80101ce2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ce5:	eb 0d                	jmp    80101cf4 <bmap+0x11a>
  }

  panic("bmap: out of range");
80101ce7:	83 ec 0c             	sub    $0xc,%esp
80101cea:	68 06 87 10 80       	push   $0x80108706
80101cef:	e8 68 e8 ff ff       	call   8010055c <panic>
}
80101cf4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cf7:	c9                   	leave  
80101cf8:	c3                   	ret    

80101cf9 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101cf9:	55                   	push   %ebp
80101cfa:	89 e5                	mov    %esp,%ebp
80101cfc:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101cff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d06:	eb 45                	jmp    80101d4d <itrunc+0x54>
    if(ip->addrs[i]){
80101d08:	8b 45 08             	mov    0x8(%ebp),%eax
80101d0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d0e:	83 c2 04             	add    $0x4,%edx
80101d11:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d15:	85 c0                	test   %eax,%eax
80101d17:	74 30                	je     80101d49 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101d19:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d1f:	83 c2 04             	add    $0x4,%edx
80101d22:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d26:	8b 55 08             	mov    0x8(%ebp),%edx
80101d29:	8b 12                	mov    (%edx),%edx
80101d2b:	83 ec 08             	sub    $0x8,%esp
80101d2e:	50                   	push   %eax
80101d2f:	52                   	push   %edx
80101d30:	e8 1f f8 ff ff       	call   80101554 <bfree>
80101d35:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101d38:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d3e:	83 c2 04             	add    $0x4,%edx
80101d41:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d48:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101d4d:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d51:	7e b5                	jle    80101d08 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101d53:	8b 45 08             	mov    0x8(%ebp),%eax
80101d56:	8b 40 4c             	mov    0x4c(%eax),%eax
80101d59:	85 c0                	test   %eax,%eax
80101d5b:	0f 84 a1 00 00 00    	je     80101e02 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d61:	8b 45 08             	mov    0x8(%ebp),%eax
80101d64:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d67:	8b 45 08             	mov    0x8(%ebp),%eax
80101d6a:	8b 00                	mov    (%eax),%eax
80101d6c:	83 ec 08             	sub    $0x8,%esp
80101d6f:	52                   	push   %edx
80101d70:	50                   	push   %eax
80101d71:	e8 3e e4 ff ff       	call   801001b4 <bread>
80101d76:	83 c4 10             	add    $0x10,%esp
80101d79:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d7f:	83 c0 18             	add    $0x18,%eax
80101d82:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d85:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d8c:	eb 3c                	jmp    80101dca <itrunc+0xd1>
      if(a[j])
80101d8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d91:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d98:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d9b:	01 d0                	add    %edx,%eax
80101d9d:	8b 00                	mov    (%eax),%eax
80101d9f:	85 c0                	test   %eax,%eax
80101da1:	74 23                	je     80101dc6 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101da3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101da6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101dad:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101db0:	01 d0                	add    %edx,%eax
80101db2:	8b 00                	mov    (%eax),%eax
80101db4:	8b 55 08             	mov    0x8(%ebp),%edx
80101db7:	8b 12                	mov    (%edx),%edx
80101db9:	83 ec 08             	sub    $0x8,%esp
80101dbc:	50                   	push   %eax
80101dbd:	52                   	push   %edx
80101dbe:	e8 91 f7 ff ff       	call   80101554 <bfree>
80101dc3:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101dc6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101dca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dcd:	83 f8 7f             	cmp    $0x7f,%eax
80101dd0:	76 bc                	jbe    80101d8e <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101dd2:	83 ec 0c             	sub    $0xc,%esp
80101dd5:	ff 75 ec             	pushl  -0x14(%ebp)
80101dd8:	e8 4e e4 ff ff       	call   8010022b <brelse>
80101ddd:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101de0:	8b 45 08             	mov    0x8(%ebp),%eax
80101de3:	8b 40 4c             	mov    0x4c(%eax),%eax
80101de6:	8b 55 08             	mov    0x8(%ebp),%edx
80101de9:	8b 12                	mov    (%edx),%edx
80101deb:	83 ec 08             	sub    $0x8,%esp
80101dee:	50                   	push   %eax
80101def:	52                   	push   %edx
80101df0:	e8 5f f7 ff ff       	call   80101554 <bfree>
80101df5:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101df8:	8b 45 08             	mov    0x8(%ebp),%eax
80101dfb:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101e02:	8b 45 08             	mov    0x8(%ebp),%eax
80101e05:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101e0c:	83 ec 0c             	sub    $0xc,%esp
80101e0f:	ff 75 08             	pushl  0x8(%ebp)
80101e12:	e8 15 f9 ff ff       	call   8010172c <iupdate>
80101e17:	83 c4 10             	add    $0x10,%esp
}
80101e1a:	c9                   	leave  
80101e1b:	c3                   	ret    

80101e1c <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101e1c:	55                   	push   %ebp
80101e1d:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e1f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e22:	8b 00                	mov    (%eax),%eax
80101e24:	89 c2                	mov    %eax,%edx
80101e26:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e29:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e2c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2f:	8b 50 04             	mov    0x4(%eax),%edx
80101e32:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e35:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e38:	8b 45 08             	mov    0x8(%ebp),%eax
80101e3b:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e42:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101e45:	8b 45 08             	mov    0x8(%ebp),%eax
80101e48:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101e4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e4f:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101e53:	8b 45 08             	mov    0x8(%ebp),%eax
80101e56:	8b 50 18             	mov    0x18(%eax),%edx
80101e59:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e5c:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e5f:	5d                   	pop    %ebp
80101e60:	c3                   	ret    

80101e61 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e61:	55                   	push   %ebp
80101e62:	89 e5                	mov    %esp,%ebp
80101e64:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e67:	8b 45 08             	mov    0x8(%ebp),%eax
80101e6a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101e6e:	66 83 f8 03          	cmp    $0x3,%ax
80101e72:	75 5c                	jne    80101ed0 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e74:	8b 45 08             	mov    0x8(%ebp),%eax
80101e77:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e7b:	66 85 c0             	test   %ax,%ax
80101e7e:	78 20                	js     80101ea0 <readi+0x3f>
80101e80:	8b 45 08             	mov    0x8(%ebp),%eax
80101e83:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e87:	66 83 f8 09          	cmp    $0x9,%ax
80101e8b:	7f 13                	jg     80101ea0 <readi+0x3f>
80101e8d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e90:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e94:	98                   	cwtl   
80101e95:	8b 04 c5 40 12 11 80 	mov    -0x7feeedc0(,%eax,8),%eax
80101e9c:	85 c0                	test   %eax,%eax
80101e9e:	75 0a                	jne    80101eaa <readi+0x49>
      return -1;
80101ea0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ea5:	e9 0f 01 00 00       	jmp    80101fb9 <readi+0x158>
    return devsw[ip->major].read(ip, dst, n);
80101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
80101ead:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101eb1:	98                   	cwtl   
80101eb2:	8b 04 c5 40 12 11 80 	mov    -0x7feeedc0(,%eax,8),%eax
80101eb9:	8b 55 14             	mov    0x14(%ebp),%edx
80101ebc:	83 ec 04             	sub    $0x4,%esp
80101ebf:	52                   	push   %edx
80101ec0:	ff 75 0c             	pushl  0xc(%ebp)
80101ec3:	ff 75 08             	pushl  0x8(%ebp)
80101ec6:	ff d0                	call   *%eax
80101ec8:	83 c4 10             	add    $0x10,%esp
80101ecb:	e9 e9 00 00 00       	jmp    80101fb9 <readi+0x158>
  }

  if(off > ip->size || off + n < off)
80101ed0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed3:	8b 40 18             	mov    0x18(%eax),%eax
80101ed6:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ed9:	72 0d                	jb     80101ee8 <readi+0x87>
80101edb:	8b 55 10             	mov    0x10(%ebp),%edx
80101ede:	8b 45 14             	mov    0x14(%ebp),%eax
80101ee1:	01 d0                	add    %edx,%eax
80101ee3:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ee6:	73 0a                	jae    80101ef2 <readi+0x91>
    return -1;
80101ee8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eed:	e9 c7 00 00 00       	jmp    80101fb9 <readi+0x158>
  if(off + n > ip->size)
80101ef2:	8b 55 10             	mov    0x10(%ebp),%edx
80101ef5:	8b 45 14             	mov    0x14(%ebp),%eax
80101ef8:	01 c2                	add    %eax,%edx
80101efa:	8b 45 08             	mov    0x8(%ebp),%eax
80101efd:	8b 40 18             	mov    0x18(%eax),%eax
80101f00:	39 c2                	cmp    %eax,%edx
80101f02:	76 0c                	jbe    80101f10 <readi+0xaf>
    n = ip->size - off;
80101f04:	8b 45 08             	mov    0x8(%ebp),%eax
80101f07:	8b 40 18             	mov    0x18(%eax),%eax
80101f0a:	2b 45 10             	sub    0x10(%ebp),%eax
80101f0d:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f17:	e9 8e 00 00 00       	jmp    80101faa <readi+0x149>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f1c:	8b 45 10             	mov    0x10(%ebp),%eax
80101f1f:	c1 e8 09             	shr    $0x9,%eax
80101f22:	83 ec 08             	sub    $0x8,%esp
80101f25:	50                   	push   %eax
80101f26:	ff 75 08             	pushl  0x8(%ebp)
80101f29:	e8 ac fc ff ff       	call   80101bda <bmap>
80101f2e:	83 c4 10             	add    $0x10,%esp
80101f31:	89 c2                	mov    %eax,%edx
80101f33:	8b 45 08             	mov    0x8(%ebp),%eax
80101f36:	8b 00                	mov    (%eax),%eax
80101f38:	83 ec 08             	sub    $0x8,%esp
80101f3b:	52                   	push   %edx
80101f3c:	50                   	push   %eax
80101f3d:	e8 72 e2 ff ff       	call   801001b4 <bread>
80101f42:	83 c4 10             	add    $0x10,%esp
80101f45:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f48:	8b 45 10             	mov    0x10(%ebp),%eax
80101f4b:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f50:	ba 00 02 00 00       	mov    $0x200,%edx
80101f55:	29 c2                	sub    %eax,%edx
80101f57:	8b 45 14             	mov    0x14(%ebp),%eax
80101f5a:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101f5d:	39 c2                	cmp    %eax,%edx
80101f5f:	0f 46 c2             	cmovbe %edx,%eax
80101f62:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101f65:	8b 45 10             	mov    0x10(%ebp),%eax
80101f68:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f6d:	8d 50 10             	lea    0x10(%eax),%edx
80101f70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f73:	01 d0                	add    %edx,%eax
80101f75:	83 c0 08             	add    $0x8,%eax
80101f78:	83 ec 04             	sub    $0x4,%esp
80101f7b:	ff 75 ec             	pushl  -0x14(%ebp)
80101f7e:	50                   	push   %eax
80101f7f:	ff 75 0c             	pushl  0xc(%ebp)
80101f82:	e8 b2 33 00 00       	call   80105339 <memmove>
80101f87:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101f8a:	83 ec 0c             	sub    $0xc,%esp
80101f8d:	ff 75 f0             	pushl  -0x10(%ebp)
80101f90:	e8 96 e2 ff ff       	call   8010022b <brelse>
80101f95:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f98:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f9b:	01 45 f4             	add    %eax,-0xc(%ebp)
80101f9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fa1:	01 45 10             	add    %eax,0x10(%ebp)
80101fa4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fa7:	01 45 0c             	add    %eax,0xc(%ebp)
80101faa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fad:	3b 45 14             	cmp    0x14(%ebp),%eax
80101fb0:	0f 82 66 ff ff ff    	jb     80101f1c <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101fb6:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101fb9:	c9                   	leave  
80101fba:	c3                   	ret    

80101fbb <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101fbb:	55                   	push   %ebp
80101fbc:	89 e5                	mov    %esp,%ebp
80101fbe:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fc1:	8b 45 08             	mov    0x8(%ebp),%eax
80101fc4:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101fc8:	66 83 f8 03          	cmp    $0x3,%ax
80101fcc:	75 5c                	jne    8010202a <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101fce:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd1:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fd5:	66 85 c0             	test   %ax,%ax
80101fd8:	78 20                	js     80101ffa <writei+0x3f>
80101fda:	8b 45 08             	mov    0x8(%ebp),%eax
80101fdd:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fe1:	66 83 f8 09          	cmp    $0x9,%ax
80101fe5:	7f 13                	jg     80101ffa <writei+0x3f>
80101fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80101fea:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fee:	98                   	cwtl   
80101fef:	8b 04 c5 44 12 11 80 	mov    -0x7feeedbc(,%eax,8),%eax
80101ff6:	85 c0                	test   %eax,%eax
80101ff8:	75 0a                	jne    80102004 <writei+0x49>
      return -1;
80101ffa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fff:	e9 40 01 00 00       	jmp    80102144 <writei+0x189>
    return devsw[ip->major].write(ip, src, n);
80102004:	8b 45 08             	mov    0x8(%ebp),%eax
80102007:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010200b:	98                   	cwtl   
8010200c:	8b 04 c5 44 12 11 80 	mov    -0x7feeedbc(,%eax,8),%eax
80102013:	8b 55 14             	mov    0x14(%ebp),%edx
80102016:	83 ec 04             	sub    $0x4,%esp
80102019:	52                   	push   %edx
8010201a:	ff 75 0c             	pushl  0xc(%ebp)
8010201d:	ff 75 08             	pushl  0x8(%ebp)
80102020:	ff d0                	call   *%eax
80102022:	83 c4 10             	add    $0x10,%esp
80102025:	e9 1a 01 00 00       	jmp    80102144 <writei+0x189>
  }

  if(off > ip->size || off + n < off)
8010202a:	8b 45 08             	mov    0x8(%ebp),%eax
8010202d:	8b 40 18             	mov    0x18(%eax),%eax
80102030:	3b 45 10             	cmp    0x10(%ebp),%eax
80102033:	72 0d                	jb     80102042 <writei+0x87>
80102035:	8b 55 10             	mov    0x10(%ebp),%edx
80102038:	8b 45 14             	mov    0x14(%ebp),%eax
8010203b:	01 d0                	add    %edx,%eax
8010203d:	3b 45 10             	cmp    0x10(%ebp),%eax
80102040:	73 0a                	jae    8010204c <writei+0x91>
    return -1;
80102042:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102047:	e9 f8 00 00 00       	jmp    80102144 <writei+0x189>
  if(off + n > MAXFILE*BSIZE)
8010204c:	8b 55 10             	mov    0x10(%ebp),%edx
8010204f:	8b 45 14             	mov    0x14(%ebp),%eax
80102052:	01 d0                	add    %edx,%eax
80102054:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102059:	76 0a                	jbe    80102065 <writei+0xaa>
    return -1;
8010205b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102060:	e9 df 00 00 00       	jmp    80102144 <writei+0x189>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102065:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010206c:	e9 9c 00 00 00       	jmp    8010210d <writei+0x152>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102071:	8b 45 10             	mov    0x10(%ebp),%eax
80102074:	c1 e8 09             	shr    $0x9,%eax
80102077:	83 ec 08             	sub    $0x8,%esp
8010207a:	50                   	push   %eax
8010207b:	ff 75 08             	pushl  0x8(%ebp)
8010207e:	e8 57 fb ff ff       	call   80101bda <bmap>
80102083:	83 c4 10             	add    $0x10,%esp
80102086:	89 c2                	mov    %eax,%edx
80102088:	8b 45 08             	mov    0x8(%ebp),%eax
8010208b:	8b 00                	mov    (%eax),%eax
8010208d:	83 ec 08             	sub    $0x8,%esp
80102090:	52                   	push   %edx
80102091:	50                   	push   %eax
80102092:	e8 1d e1 ff ff       	call   801001b4 <bread>
80102097:	83 c4 10             	add    $0x10,%esp
8010209a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010209d:	8b 45 10             	mov    0x10(%ebp),%eax
801020a0:	25 ff 01 00 00       	and    $0x1ff,%eax
801020a5:	ba 00 02 00 00       	mov    $0x200,%edx
801020aa:	29 c2                	sub    %eax,%edx
801020ac:	8b 45 14             	mov    0x14(%ebp),%eax
801020af:	2b 45 f4             	sub    -0xc(%ebp),%eax
801020b2:	39 c2                	cmp    %eax,%edx
801020b4:	0f 46 c2             	cmovbe %edx,%eax
801020b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801020ba:	8b 45 10             	mov    0x10(%ebp),%eax
801020bd:	25 ff 01 00 00       	and    $0x1ff,%eax
801020c2:	8d 50 10             	lea    0x10(%eax),%edx
801020c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020c8:	01 d0                	add    %edx,%eax
801020ca:	83 c0 08             	add    $0x8,%eax
801020cd:	83 ec 04             	sub    $0x4,%esp
801020d0:	ff 75 ec             	pushl  -0x14(%ebp)
801020d3:	ff 75 0c             	pushl  0xc(%ebp)
801020d6:	50                   	push   %eax
801020d7:	e8 5d 32 00 00       	call   80105339 <memmove>
801020dc:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
801020df:	83 ec 0c             	sub    $0xc,%esp
801020e2:	ff 75 f0             	pushl  -0x10(%ebp)
801020e5:	e8 d6 15 00 00       	call   801036c0 <log_write>
801020ea:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801020ed:	83 ec 0c             	sub    $0xc,%esp
801020f0:	ff 75 f0             	pushl  -0x10(%ebp)
801020f3:	e8 33 e1 ff ff       	call   8010022b <brelse>
801020f8:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020fe:	01 45 f4             	add    %eax,-0xc(%ebp)
80102101:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102104:	01 45 10             	add    %eax,0x10(%ebp)
80102107:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010210a:	01 45 0c             	add    %eax,0xc(%ebp)
8010210d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102110:	3b 45 14             	cmp    0x14(%ebp),%eax
80102113:	0f 82 58 ff ff ff    	jb     80102071 <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102119:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010211d:	74 22                	je     80102141 <writei+0x186>
8010211f:	8b 45 08             	mov    0x8(%ebp),%eax
80102122:	8b 40 18             	mov    0x18(%eax),%eax
80102125:	3b 45 10             	cmp    0x10(%ebp),%eax
80102128:	73 17                	jae    80102141 <writei+0x186>
    ip->size = off;
8010212a:	8b 45 08             	mov    0x8(%ebp),%eax
8010212d:	8b 55 10             	mov    0x10(%ebp),%edx
80102130:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102133:	83 ec 0c             	sub    $0xc,%esp
80102136:	ff 75 08             	pushl  0x8(%ebp)
80102139:	e8 ee f5 ff ff       	call   8010172c <iupdate>
8010213e:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102141:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102144:	c9                   	leave  
80102145:	c3                   	ret    

80102146 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102146:	55                   	push   %ebp
80102147:	89 e5                	mov    %esp,%ebp
80102149:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
8010214c:	83 ec 04             	sub    $0x4,%esp
8010214f:	6a 0e                	push   $0xe
80102151:	ff 75 0c             	pushl  0xc(%ebp)
80102154:	ff 75 08             	pushl  0x8(%ebp)
80102157:	e8 75 32 00 00       	call   801053d1 <strncmp>
8010215c:	83 c4 10             	add    $0x10,%esp
}
8010215f:	c9                   	leave  
80102160:	c3                   	ret    

80102161 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102161:	55                   	push   %ebp
80102162:	89 e5                	mov    %esp,%ebp
80102164:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102167:	8b 45 08             	mov    0x8(%ebp),%eax
8010216a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010216e:	66 83 f8 01          	cmp    $0x1,%ax
80102172:	74 0d                	je     80102181 <dirlookup+0x20>
    panic("dirlookup not DIR");
80102174:	83 ec 0c             	sub    $0xc,%esp
80102177:	68 19 87 10 80       	push   $0x80108719
8010217c:	e8 db e3 ff ff       	call   8010055c <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102181:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102188:	eb 7c                	jmp    80102206 <dirlookup+0xa5>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010218a:	6a 10                	push   $0x10
8010218c:	ff 75 f4             	pushl  -0xc(%ebp)
8010218f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102192:	50                   	push   %eax
80102193:	ff 75 08             	pushl  0x8(%ebp)
80102196:	e8 c6 fc ff ff       	call   80101e61 <readi>
8010219b:	83 c4 10             	add    $0x10,%esp
8010219e:	83 f8 10             	cmp    $0x10,%eax
801021a1:	74 0d                	je     801021b0 <dirlookup+0x4f>
      panic("dirlink read");
801021a3:	83 ec 0c             	sub    $0xc,%esp
801021a6:	68 2b 87 10 80       	push   $0x8010872b
801021ab:	e8 ac e3 ff ff       	call   8010055c <panic>
    if(de.inum == 0)
801021b0:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021b4:	66 85 c0             	test   %ax,%ax
801021b7:	75 02                	jne    801021bb <dirlookup+0x5a>
      continue;
801021b9:	eb 47                	jmp    80102202 <dirlookup+0xa1>
    if(namecmp(name, de.name) == 0){
801021bb:	83 ec 08             	sub    $0x8,%esp
801021be:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021c1:	83 c0 02             	add    $0x2,%eax
801021c4:	50                   	push   %eax
801021c5:	ff 75 0c             	pushl  0xc(%ebp)
801021c8:	e8 79 ff ff ff       	call   80102146 <namecmp>
801021cd:	83 c4 10             	add    $0x10,%esp
801021d0:	85 c0                	test   %eax,%eax
801021d2:	75 2e                	jne    80102202 <dirlookup+0xa1>
      // entry matches path element
      if(poff)
801021d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801021d8:	74 08                	je     801021e2 <dirlookup+0x81>
        *poff = off;
801021da:	8b 45 10             	mov    0x10(%ebp),%eax
801021dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021e0:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801021e2:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021e6:	0f b7 c0             	movzwl %ax,%eax
801021e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801021ec:	8b 45 08             	mov    0x8(%ebp),%eax
801021ef:	8b 00                	mov    (%eax),%eax
801021f1:	83 ec 08             	sub    $0x8,%esp
801021f4:	ff 75 f0             	pushl  -0x10(%ebp)
801021f7:	50                   	push   %eax
801021f8:	e8 e9 f5 ff ff       	call   801017e6 <iget>
801021fd:	83 c4 10             	add    $0x10,%esp
80102200:	eb 18                	jmp    8010221a <dirlookup+0xb9>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102202:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102206:	8b 45 08             	mov    0x8(%ebp),%eax
80102209:	8b 40 18             	mov    0x18(%eax),%eax
8010220c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010220f:	0f 87 75 ff ff ff    	ja     8010218a <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102215:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010221a:	c9                   	leave  
8010221b:	c3                   	ret    

8010221c <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010221c:	55                   	push   %ebp
8010221d:	89 e5                	mov    %esp,%ebp
8010221f:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102222:	83 ec 04             	sub    $0x4,%esp
80102225:	6a 00                	push   $0x0
80102227:	ff 75 0c             	pushl  0xc(%ebp)
8010222a:	ff 75 08             	pushl  0x8(%ebp)
8010222d:	e8 2f ff ff ff       	call   80102161 <dirlookup>
80102232:	83 c4 10             	add    $0x10,%esp
80102235:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102238:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010223c:	74 18                	je     80102256 <dirlink+0x3a>
    iput(ip);
8010223e:	83 ec 0c             	sub    $0xc,%esp
80102241:	ff 75 f0             	pushl  -0x10(%ebp)
80102244:	e8 7e f8 ff ff       	call   80101ac7 <iput>
80102249:	83 c4 10             	add    $0x10,%esp
    return -1;
8010224c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102251:	e9 9b 00 00 00       	jmp    801022f1 <dirlink+0xd5>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102256:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010225d:	eb 3b                	jmp    8010229a <dirlink+0x7e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010225f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102262:	6a 10                	push   $0x10
80102264:	50                   	push   %eax
80102265:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102268:	50                   	push   %eax
80102269:	ff 75 08             	pushl  0x8(%ebp)
8010226c:	e8 f0 fb ff ff       	call   80101e61 <readi>
80102271:	83 c4 10             	add    $0x10,%esp
80102274:	83 f8 10             	cmp    $0x10,%eax
80102277:	74 0d                	je     80102286 <dirlink+0x6a>
      panic("dirlink read");
80102279:	83 ec 0c             	sub    $0xc,%esp
8010227c:	68 2b 87 10 80       	push   $0x8010872b
80102281:	e8 d6 e2 ff ff       	call   8010055c <panic>
    if(de.inum == 0)
80102286:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010228a:	66 85 c0             	test   %ax,%ax
8010228d:	75 02                	jne    80102291 <dirlink+0x75>
      break;
8010228f:	eb 16                	jmp    801022a7 <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102291:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102294:	83 c0 10             	add    $0x10,%eax
80102297:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010229a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010229d:	8b 45 08             	mov    0x8(%ebp),%eax
801022a0:	8b 40 18             	mov    0x18(%eax),%eax
801022a3:	39 c2                	cmp    %eax,%edx
801022a5:	72 b8                	jb     8010225f <dirlink+0x43>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
801022a7:	83 ec 04             	sub    $0x4,%esp
801022aa:	6a 0e                	push   $0xe
801022ac:	ff 75 0c             	pushl  0xc(%ebp)
801022af:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022b2:	83 c0 02             	add    $0x2,%eax
801022b5:	50                   	push   %eax
801022b6:	e8 6c 31 00 00       	call   80105427 <strncpy>
801022bb:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
801022be:	8b 45 10             	mov    0x10(%ebp),%eax
801022c1:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022c8:	6a 10                	push   $0x10
801022ca:	50                   	push   %eax
801022cb:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022ce:	50                   	push   %eax
801022cf:	ff 75 08             	pushl  0x8(%ebp)
801022d2:	e8 e4 fc ff ff       	call   80101fbb <writei>
801022d7:	83 c4 10             	add    $0x10,%esp
801022da:	83 f8 10             	cmp    $0x10,%eax
801022dd:	74 0d                	je     801022ec <dirlink+0xd0>
    panic("dirlink");
801022df:	83 ec 0c             	sub    $0xc,%esp
801022e2:	68 38 87 10 80       	push   $0x80108738
801022e7:	e8 70 e2 ff ff       	call   8010055c <panic>
  
  return 0;
801022ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022f1:	c9                   	leave  
801022f2:	c3                   	ret    

801022f3 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
801022f3:	55                   	push   %ebp
801022f4:	89 e5                	mov    %esp,%ebp
801022f6:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
801022f9:	eb 04                	jmp    801022ff <skipelem+0xc>
    path++;
801022fb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
801022ff:	8b 45 08             	mov    0x8(%ebp),%eax
80102302:	0f b6 00             	movzbl (%eax),%eax
80102305:	3c 2f                	cmp    $0x2f,%al
80102307:	74 f2                	je     801022fb <skipelem+0x8>
    path++;
  if(*path == 0)
80102309:	8b 45 08             	mov    0x8(%ebp),%eax
8010230c:	0f b6 00             	movzbl (%eax),%eax
8010230f:	84 c0                	test   %al,%al
80102311:	75 07                	jne    8010231a <skipelem+0x27>
    return 0;
80102313:	b8 00 00 00 00       	mov    $0x0,%eax
80102318:	eb 7b                	jmp    80102395 <skipelem+0xa2>
  s = path;
8010231a:	8b 45 08             	mov    0x8(%ebp),%eax
8010231d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102320:	eb 04                	jmp    80102326 <skipelem+0x33>
    path++;
80102322:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102326:	8b 45 08             	mov    0x8(%ebp),%eax
80102329:	0f b6 00             	movzbl (%eax),%eax
8010232c:	3c 2f                	cmp    $0x2f,%al
8010232e:	74 0a                	je     8010233a <skipelem+0x47>
80102330:	8b 45 08             	mov    0x8(%ebp),%eax
80102333:	0f b6 00             	movzbl (%eax),%eax
80102336:	84 c0                	test   %al,%al
80102338:	75 e8                	jne    80102322 <skipelem+0x2f>
    path++;
  len = path - s;
8010233a:	8b 55 08             	mov    0x8(%ebp),%edx
8010233d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102340:	29 c2                	sub    %eax,%edx
80102342:	89 d0                	mov    %edx,%eax
80102344:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102347:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
8010234b:	7e 15                	jle    80102362 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
8010234d:	83 ec 04             	sub    $0x4,%esp
80102350:	6a 0e                	push   $0xe
80102352:	ff 75 f4             	pushl  -0xc(%ebp)
80102355:	ff 75 0c             	pushl  0xc(%ebp)
80102358:	e8 dc 2f 00 00       	call   80105339 <memmove>
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	eb 20                	jmp    80102382 <skipelem+0x8f>
  else {
    memmove(name, s, len);
80102362:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102365:	83 ec 04             	sub    $0x4,%esp
80102368:	50                   	push   %eax
80102369:	ff 75 f4             	pushl  -0xc(%ebp)
8010236c:	ff 75 0c             	pushl  0xc(%ebp)
8010236f:	e8 c5 2f 00 00       	call   80105339 <memmove>
80102374:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
80102377:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010237a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010237d:	01 d0                	add    %edx,%eax
8010237f:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102382:	eb 04                	jmp    80102388 <skipelem+0x95>
    path++;
80102384:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102388:	8b 45 08             	mov    0x8(%ebp),%eax
8010238b:	0f b6 00             	movzbl (%eax),%eax
8010238e:	3c 2f                	cmp    $0x2f,%al
80102390:	74 f2                	je     80102384 <skipelem+0x91>
    path++;
  return path;
80102392:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102395:	c9                   	leave  
80102396:	c3                   	ret    

80102397 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102397:	55                   	push   %ebp
80102398:	89 e5                	mov    %esp,%ebp
8010239a:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010239d:	8b 45 08             	mov    0x8(%ebp),%eax
801023a0:	0f b6 00             	movzbl (%eax),%eax
801023a3:	3c 2f                	cmp    $0x2f,%al
801023a5:	75 14                	jne    801023bb <namex+0x24>
    ip = iget(ROOTDEV, ROOTINO);
801023a7:	83 ec 08             	sub    $0x8,%esp
801023aa:	6a 01                	push   $0x1
801023ac:	6a 01                	push   $0x1
801023ae:	e8 33 f4 ff ff       	call   801017e6 <iget>
801023b3:	83 c4 10             	add    $0x10,%esp
801023b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023b9:	eb 18                	jmp    801023d3 <namex+0x3c>
  else
    ip = idup(proc->cwd);
801023bb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801023c1:	8b 40 68             	mov    0x68(%eax),%eax
801023c4:	83 ec 0c             	sub    $0xc,%esp
801023c7:	50                   	push   %eax
801023c8:	e8 f8 f4 ff ff       	call   801018c5 <idup>
801023cd:	83 c4 10             	add    $0x10,%esp
801023d0:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
801023d3:	e9 9e 00 00 00       	jmp    80102476 <namex+0xdf>
    ilock(ip);
801023d8:	83 ec 0c             	sub    $0xc,%esp
801023db:	ff 75 f4             	pushl  -0xc(%ebp)
801023de:	e8 1c f5 ff ff       	call   801018ff <ilock>
801023e3:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
801023e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023e9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801023ed:	66 83 f8 01          	cmp    $0x1,%ax
801023f1:	74 18                	je     8010240b <namex+0x74>
      iunlockput(ip);
801023f3:	83 ec 0c             	sub    $0xc,%esp
801023f6:	ff 75 f4             	pushl  -0xc(%ebp)
801023f9:	e8 b8 f7 ff ff       	call   80101bb6 <iunlockput>
801023fe:	83 c4 10             	add    $0x10,%esp
      return 0;
80102401:	b8 00 00 00 00       	mov    $0x0,%eax
80102406:	e9 a7 00 00 00       	jmp    801024b2 <namex+0x11b>
    }
    if(nameiparent && *path == '\0'){
8010240b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010240f:	74 20                	je     80102431 <namex+0x9a>
80102411:	8b 45 08             	mov    0x8(%ebp),%eax
80102414:	0f b6 00             	movzbl (%eax),%eax
80102417:	84 c0                	test   %al,%al
80102419:	75 16                	jne    80102431 <namex+0x9a>
      // Stop one level early.
      iunlock(ip);
8010241b:	83 ec 0c             	sub    $0xc,%esp
8010241e:	ff 75 f4             	pushl  -0xc(%ebp)
80102421:	e8 30 f6 ff ff       	call   80101a56 <iunlock>
80102426:	83 c4 10             	add    $0x10,%esp
      return ip;
80102429:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010242c:	e9 81 00 00 00       	jmp    801024b2 <namex+0x11b>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102431:	83 ec 04             	sub    $0x4,%esp
80102434:	6a 00                	push   $0x0
80102436:	ff 75 10             	pushl  0x10(%ebp)
80102439:	ff 75 f4             	pushl  -0xc(%ebp)
8010243c:	e8 20 fd ff ff       	call   80102161 <dirlookup>
80102441:	83 c4 10             	add    $0x10,%esp
80102444:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102447:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010244b:	75 15                	jne    80102462 <namex+0xcb>
      iunlockput(ip);
8010244d:	83 ec 0c             	sub    $0xc,%esp
80102450:	ff 75 f4             	pushl  -0xc(%ebp)
80102453:	e8 5e f7 ff ff       	call   80101bb6 <iunlockput>
80102458:	83 c4 10             	add    $0x10,%esp
      return 0;
8010245b:	b8 00 00 00 00       	mov    $0x0,%eax
80102460:	eb 50                	jmp    801024b2 <namex+0x11b>
    }
    iunlockput(ip);
80102462:	83 ec 0c             	sub    $0xc,%esp
80102465:	ff 75 f4             	pushl  -0xc(%ebp)
80102468:	e8 49 f7 ff ff       	call   80101bb6 <iunlockput>
8010246d:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102470:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102473:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102476:	83 ec 08             	sub    $0x8,%esp
80102479:	ff 75 10             	pushl  0x10(%ebp)
8010247c:	ff 75 08             	pushl  0x8(%ebp)
8010247f:	e8 6f fe ff ff       	call   801022f3 <skipelem>
80102484:	83 c4 10             	add    $0x10,%esp
80102487:	89 45 08             	mov    %eax,0x8(%ebp)
8010248a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010248e:	0f 85 44 ff ff ff    	jne    801023d8 <namex+0x41>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102494:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102498:	74 15                	je     801024af <namex+0x118>
    iput(ip);
8010249a:	83 ec 0c             	sub    $0xc,%esp
8010249d:	ff 75 f4             	pushl  -0xc(%ebp)
801024a0:	e8 22 f6 ff ff       	call   80101ac7 <iput>
801024a5:	83 c4 10             	add    $0x10,%esp
    return 0;
801024a8:	b8 00 00 00 00       	mov    $0x0,%eax
801024ad:	eb 03                	jmp    801024b2 <namex+0x11b>
  }
  return ip;
801024af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801024b2:	c9                   	leave  
801024b3:	c3                   	ret    

801024b4 <namei>:

struct inode*
namei(char *path)
{
801024b4:	55                   	push   %ebp
801024b5:	89 e5                	mov    %esp,%ebp
801024b7:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801024ba:	83 ec 04             	sub    $0x4,%esp
801024bd:	8d 45 ea             	lea    -0x16(%ebp),%eax
801024c0:	50                   	push   %eax
801024c1:	6a 00                	push   $0x0
801024c3:	ff 75 08             	pushl  0x8(%ebp)
801024c6:	e8 cc fe ff ff       	call   80102397 <namex>
801024cb:	83 c4 10             	add    $0x10,%esp
}
801024ce:	c9                   	leave  
801024cf:	c3                   	ret    

801024d0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
801024d6:	83 ec 04             	sub    $0x4,%esp
801024d9:	ff 75 0c             	pushl  0xc(%ebp)
801024dc:	6a 01                	push   $0x1
801024de:	ff 75 08             	pushl  0x8(%ebp)
801024e1:	e8 b1 fe ff ff       	call   80102397 <namex>
801024e6:	83 c4 10             	add    $0x10,%esp
}
801024e9:	c9                   	leave  
801024ea:	c3                   	ret    

801024eb <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801024eb:	55                   	push   %ebp
801024ec:	89 e5                	mov    %esp,%ebp
801024ee:	83 ec 14             	sub    $0x14,%esp
801024f1:	8b 45 08             	mov    0x8(%ebp),%eax
801024f4:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024f8:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801024fc:	89 c2                	mov    %eax,%edx
801024fe:	ec                   	in     (%dx),%al
801024ff:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102502:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102506:	c9                   	leave  
80102507:	c3                   	ret    

80102508 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102508:	55                   	push   %ebp
80102509:	89 e5                	mov    %esp,%ebp
8010250b:	57                   	push   %edi
8010250c:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010250d:	8b 55 08             	mov    0x8(%ebp),%edx
80102510:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102513:	8b 45 10             	mov    0x10(%ebp),%eax
80102516:	89 cb                	mov    %ecx,%ebx
80102518:	89 df                	mov    %ebx,%edi
8010251a:	89 c1                	mov    %eax,%ecx
8010251c:	fc                   	cld    
8010251d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010251f:	89 c8                	mov    %ecx,%eax
80102521:	89 fb                	mov    %edi,%ebx
80102523:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102526:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102529:	5b                   	pop    %ebx
8010252a:	5f                   	pop    %edi
8010252b:	5d                   	pop    %ebp
8010252c:	c3                   	ret    

8010252d <outb>:

static inline void
outb(ushort port, uchar data)
{
8010252d:	55                   	push   %ebp
8010252e:	89 e5                	mov    %esp,%ebp
80102530:	83 ec 08             	sub    $0x8,%esp
80102533:	8b 55 08             	mov    0x8(%ebp),%edx
80102536:	8b 45 0c             	mov    0xc(%ebp),%eax
80102539:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010253d:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102540:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102544:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102548:	ee                   	out    %al,(%dx)
}
80102549:	c9                   	leave  
8010254a:	c3                   	ret    

8010254b <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
8010254b:	55                   	push   %ebp
8010254c:	89 e5                	mov    %esp,%ebp
8010254e:	56                   	push   %esi
8010254f:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102550:	8b 55 08             	mov    0x8(%ebp),%edx
80102553:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102556:	8b 45 10             	mov    0x10(%ebp),%eax
80102559:	89 cb                	mov    %ecx,%ebx
8010255b:	89 de                	mov    %ebx,%esi
8010255d:	89 c1                	mov    %eax,%ecx
8010255f:	fc                   	cld    
80102560:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102562:	89 c8                	mov    %ecx,%eax
80102564:	89 f3                	mov    %esi,%ebx
80102566:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102569:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
8010256c:	5b                   	pop    %ebx
8010256d:	5e                   	pop    %esi
8010256e:	5d                   	pop    %ebp
8010256f:	c3                   	ret    

80102570 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
80102576:	90                   	nop
80102577:	68 f7 01 00 00       	push   $0x1f7
8010257c:	e8 6a ff ff ff       	call   801024eb <inb>
80102581:	83 c4 04             	add    $0x4,%esp
80102584:	0f b6 c0             	movzbl %al,%eax
80102587:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010258a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010258d:	25 c0 00 00 00       	and    $0xc0,%eax
80102592:	83 f8 40             	cmp    $0x40,%eax
80102595:	75 e0                	jne    80102577 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102597:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010259b:	74 11                	je     801025ae <idewait+0x3e>
8010259d:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025a0:	83 e0 21             	and    $0x21,%eax
801025a3:	85 c0                	test   %eax,%eax
801025a5:	74 07                	je     801025ae <idewait+0x3e>
    return -1;
801025a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025ac:	eb 05                	jmp    801025b3 <idewait+0x43>
  return 0;
801025ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
801025b3:	c9                   	leave  
801025b4:	c3                   	ret    

801025b5 <ideinit>:

void
ideinit(void)
{
801025b5:	55                   	push   %ebp
801025b6:	89 e5                	mov    %esp,%ebp
801025b8:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801025bb:	83 ec 08             	sub    $0x8,%esp
801025be:	68 40 87 10 80       	push   $0x80108740
801025c3:	68 20 b6 10 80       	push   $0x8010b620
801025c8:	e8 30 2a 00 00       	call   80104ffd <initlock>
801025cd:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
801025d0:	83 ec 0c             	sub    $0xc,%esp
801025d3:	6a 0e                	push   $0xe
801025d5:	e8 88 18 00 00       	call   80103e62 <picenable>
801025da:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
801025dd:	a1 20 2a 11 80       	mov    0x80112a20,%eax
801025e2:	83 e8 01             	sub    $0x1,%eax
801025e5:	83 ec 08             	sub    $0x8,%esp
801025e8:	50                   	push   %eax
801025e9:	6a 0e                	push   $0xe
801025eb:	e8 31 04 00 00       	call   80102a21 <ioapicenable>
801025f0:	83 c4 10             	add    $0x10,%esp
  idewait(0);
801025f3:	83 ec 0c             	sub    $0xc,%esp
801025f6:	6a 00                	push   $0x0
801025f8:	e8 73 ff ff ff       	call   80102570 <idewait>
801025fd:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102600:	83 ec 08             	sub    $0x8,%esp
80102603:	68 f0 00 00 00       	push   $0xf0
80102608:	68 f6 01 00 00       	push   $0x1f6
8010260d:	e8 1b ff ff ff       	call   8010252d <outb>
80102612:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102615:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010261c:	eb 24                	jmp    80102642 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
8010261e:	83 ec 0c             	sub    $0xc,%esp
80102621:	68 f7 01 00 00       	push   $0x1f7
80102626:	e8 c0 fe ff ff       	call   801024eb <inb>
8010262b:	83 c4 10             	add    $0x10,%esp
8010262e:	84 c0                	test   %al,%al
80102630:	74 0c                	je     8010263e <ideinit+0x89>
      havedisk1 = 1;
80102632:	c7 05 58 b6 10 80 01 	movl   $0x1,0x8010b658
80102639:	00 00 00 
      break;
8010263c:	eb 0d                	jmp    8010264b <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
8010263e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102642:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102649:	7e d3                	jle    8010261e <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
8010264b:	83 ec 08             	sub    $0x8,%esp
8010264e:	68 e0 00 00 00       	push   $0xe0
80102653:	68 f6 01 00 00       	push   $0x1f6
80102658:	e8 d0 fe ff ff       	call   8010252d <outb>
8010265d:	83 c4 10             	add    $0x10,%esp
}
80102660:	c9                   	leave  
80102661:	c3                   	ret    

80102662 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102662:	55                   	push   %ebp
80102663:	89 e5                	mov    %esp,%ebp
80102665:	83 ec 08             	sub    $0x8,%esp
  if(b == 0)
80102668:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010266c:	75 0d                	jne    8010267b <idestart+0x19>
    panic("idestart");
8010266e:	83 ec 0c             	sub    $0xc,%esp
80102671:	68 44 87 10 80       	push   $0x80108744
80102676:	e8 e1 de ff ff       	call   8010055c <panic>

  idewait(0);
8010267b:	83 ec 0c             	sub    $0xc,%esp
8010267e:	6a 00                	push   $0x0
80102680:	e8 eb fe ff ff       	call   80102570 <idewait>
80102685:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102688:	83 ec 08             	sub    $0x8,%esp
8010268b:	6a 00                	push   $0x0
8010268d:	68 f6 03 00 00       	push   $0x3f6
80102692:	e8 96 fe ff ff       	call   8010252d <outb>
80102697:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, 1);  // number of sectors
8010269a:	83 ec 08             	sub    $0x8,%esp
8010269d:	6a 01                	push   $0x1
8010269f:	68 f2 01 00 00       	push   $0x1f2
801026a4:	e8 84 fe ff ff       	call   8010252d <outb>
801026a9:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, b->sector & 0xff);
801026ac:	8b 45 08             	mov    0x8(%ebp),%eax
801026af:	8b 40 08             	mov    0x8(%eax),%eax
801026b2:	0f b6 c0             	movzbl %al,%eax
801026b5:	83 ec 08             	sub    $0x8,%esp
801026b8:	50                   	push   %eax
801026b9:	68 f3 01 00 00       	push   $0x1f3
801026be:	e8 6a fe ff ff       	call   8010252d <outb>
801026c3:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (b->sector >> 8) & 0xff);
801026c6:	8b 45 08             	mov    0x8(%ebp),%eax
801026c9:	8b 40 08             	mov    0x8(%eax),%eax
801026cc:	c1 e8 08             	shr    $0x8,%eax
801026cf:	0f b6 c0             	movzbl %al,%eax
801026d2:	83 ec 08             	sub    $0x8,%esp
801026d5:	50                   	push   %eax
801026d6:	68 f4 01 00 00       	push   $0x1f4
801026db:	e8 4d fe ff ff       	call   8010252d <outb>
801026e0:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (b->sector >> 16) & 0xff);
801026e3:	8b 45 08             	mov    0x8(%ebp),%eax
801026e6:	8b 40 08             	mov    0x8(%eax),%eax
801026e9:	c1 e8 10             	shr    $0x10,%eax
801026ec:	0f b6 c0             	movzbl %al,%eax
801026ef:	83 ec 08             	sub    $0x8,%esp
801026f2:	50                   	push   %eax
801026f3:	68 f5 01 00 00       	push   $0x1f5
801026f8:	e8 30 fe ff ff       	call   8010252d <outb>
801026fd:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102700:	8b 45 08             	mov    0x8(%ebp),%eax
80102703:	8b 40 04             	mov    0x4(%eax),%eax
80102706:	83 e0 01             	and    $0x1,%eax
80102709:	c1 e0 04             	shl    $0x4,%eax
8010270c:	89 c2                	mov    %eax,%edx
8010270e:	8b 45 08             	mov    0x8(%ebp),%eax
80102711:	8b 40 08             	mov    0x8(%eax),%eax
80102714:	c1 e8 18             	shr    $0x18,%eax
80102717:	83 e0 0f             	and    $0xf,%eax
8010271a:	09 d0                	or     %edx,%eax
8010271c:	83 c8 e0             	or     $0xffffffe0,%eax
8010271f:	0f b6 c0             	movzbl %al,%eax
80102722:	83 ec 08             	sub    $0x8,%esp
80102725:	50                   	push   %eax
80102726:	68 f6 01 00 00       	push   $0x1f6
8010272b:	e8 fd fd ff ff       	call   8010252d <outb>
80102730:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102733:	8b 45 08             	mov    0x8(%ebp),%eax
80102736:	8b 00                	mov    (%eax),%eax
80102738:	83 e0 04             	and    $0x4,%eax
8010273b:	85 c0                	test   %eax,%eax
8010273d:	74 30                	je     8010276f <idestart+0x10d>
    outb(0x1f7, IDE_CMD_WRITE);
8010273f:	83 ec 08             	sub    $0x8,%esp
80102742:	6a 30                	push   $0x30
80102744:	68 f7 01 00 00       	push   $0x1f7
80102749:	e8 df fd ff ff       	call   8010252d <outb>
8010274e:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, 512/4);
80102751:	8b 45 08             	mov    0x8(%ebp),%eax
80102754:	83 c0 18             	add    $0x18,%eax
80102757:	83 ec 04             	sub    $0x4,%esp
8010275a:	68 80 00 00 00       	push   $0x80
8010275f:	50                   	push   %eax
80102760:	68 f0 01 00 00       	push   $0x1f0
80102765:	e8 e1 fd ff ff       	call   8010254b <outsl>
8010276a:	83 c4 10             	add    $0x10,%esp
8010276d:	eb 12                	jmp    80102781 <idestart+0x11f>
  } else {
    outb(0x1f7, IDE_CMD_READ);
8010276f:	83 ec 08             	sub    $0x8,%esp
80102772:	6a 20                	push   $0x20
80102774:	68 f7 01 00 00       	push   $0x1f7
80102779:	e8 af fd ff ff       	call   8010252d <outb>
8010277e:	83 c4 10             	add    $0x10,%esp
  }
}
80102781:	c9                   	leave  
80102782:	c3                   	ret    

80102783 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102783:	55                   	push   %ebp
80102784:	89 e5                	mov    %esp,%ebp
80102786:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102789:	83 ec 0c             	sub    $0xc,%esp
8010278c:	68 20 b6 10 80       	push   $0x8010b620
80102791:	e8 88 28 00 00       	call   8010501e <acquire>
80102796:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102799:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010279e:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801027a5:	75 15                	jne    801027bc <ideintr+0x39>
    release(&idelock);
801027a7:	83 ec 0c             	sub    $0xc,%esp
801027aa:	68 20 b6 10 80       	push   $0x8010b620
801027af:	e8 d0 28 00 00       	call   80105084 <release>
801027b4:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
801027b7:	e9 9a 00 00 00       	jmp    80102856 <ideintr+0xd3>
  }
  idequeue = b->qnext;
801027bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027bf:	8b 40 14             	mov    0x14(%eax),%eax
801027c2:	a3 54 b6 10 80       	mov    %eax,0x8010b654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801027c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027ca:	8b 00                	mov    (%eax),%eax
801027cc:	83 e0 04             	and    $0x4,%eax
801027cf:	85 c0                	test   %eax,%eax
801027d1:	75 2d                	jne    80102800 <ideintr+0x7d>
801027d3:	83 ec 0c             	sub    $0xc,%esp
801027d6:	6a 01                	push   $0x1
801027d8:	e8 93 fd ff ff       	call   80102570 <idewait>
801027dd:	83 c4 10             	add    $0x10,%esp
801027e0:	85 c0                	test   %eax,%eax
801027e2:	78 1c                	js     80102800 <ideintr+0x7d>
    insl(0x1f0, b->data, 512/4);
801027e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027e7:	83 c0 18             	add    $0x18,%eax
801027ea:	83 ec 04             	sub    $0x4,%esp
801027ed:	68 80 00 00 00       	push   $0x80
801027f2:	50                   	push   %eax
801027f3:	68 f0 01 00 00       	push   $0x1f0
801027f8:	e8 0b fd ff ff       	call   80102508 <insl>
801027fd:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102800:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102803:	8b 00                	mov    (%eax),%eax
80102805:	83 c8 02             	or     $0x2,%eax
80102808:	89 c2                	mov    %eax,%edx
8010280a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010280d:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010280f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102812:	8b 00                	mov    (%eax),%eax
80102814:	83 e0 fb             	and    $0xfffffffb,%eax
80102817:	89 c2                	mov    %eax,%edx
80102819:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010281c:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010281e:	83 ec 0c             	sub    $0xc,%esp
80102821:	ff 75 f4             	pushl  -0xc(%ebp)
80102824:	e8 03 25 00 00       	call   80104d2c <wakeup>
80102829:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010282c:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102831:	85 c0                	test   %eax,%eax
80102833:	74 11                	je     80102846 <ideintr+0xc3>
    idestart(idequeue);
80102835:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010283a:	83 ec 0c             	sub    $0xc,%esp
8010283d:	50                   	push   %eax
8010283e:	e8 1f fe ff ff       	call   80102662 <idestart>
80102843:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102846:	83 ec 0c             	sub    $0xc,%esp
80102849:	68 20 b6 10 80       	push   $0x8010b620
8010284e:	e8 31 28 00 00       	call   80105084 <release>
80102853:	83 c4 10             	add    $0x10,%esp
}
80102856:	c9                   	leave  
80102857:	c3                   	ret    

80102858 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102858:	55                   	push   %ebp
80102859:	89 e5                	mov    %esp,%ebp
8010285b:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010285e:	8b 45 08             	mov    0x8(%ebp),%eax
80102861:	8b 00                	mov    (%eax),%eax
80102863:	83 e0 01             	and    $0x1,%eax
80102866:	85 c0                	test   %eax,%eax
80102868:	75 0d                	jne    80102877 <iderw+0x1f>
    panic("iderw: buf not busy");
8010286a:	83 ec 0c             	sub    $0xc,%esp
8010286d:	68 4d 87 10 80       	push   $0x8010874d
80102872:	e8 e5 dc ff ff       	call   8010055c <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102877:	8b 45 08             	mov    0x8(%ebp),%eax
8010287a:	8b 00                	mov    (%eax),%eax
8010287c:	83 e0 06             	and    $0x6,%eax
8010287f:	83 f8 02             	cmp    $0x2,%eax
80102882:	75 0d                	jne    80102891 <iderw+0x39>
    panic("iderw: nothing to do");
80102884:	83 ec 0c             	sub    $0xc,%esp
80102887:	68 61 87 10 80       	push   $0x80108761
8010288c:	e8 cb dc ff ff       	call   8010055c <panic>
  if(b->dev != 0 && !havedisk1)
80102891:	8b 45 08             	mov    0x8(%ebp),%eax
80102894:	8b 40 04             	mov    0x4(%eax),%eax
80102897:	85 c0                	test   %eax,%eax
80102899:	74 16                	je     801028b1 <iderw+0x59>
8010289b:	a1 58 b6 10 80       	mov    0x8010b658,%eax
801028a0:	85 c0                	test   %eax,%eax
801028a2:	75 0d                	jne    801028b1 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
801028a4:	83 ec 0c             	sub    $0xc,%esp
801028a7:	68 76 87 10 80       	push   $0x80108776
801028ac:	e8 ab dc ff ff       	call   8010055c <panic>

  acquire(&idelock);  //DOC:acquire-lock
801028b1:	83 ec 0c             	sub    $0xc,%esp
801028b4:	68 20 b6 10 80       	push   $0x8010b620
801028b9:	e8 60 27 00 00       	call   8010501e <acquire>
801028be:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801028c1:	8b 45 08             	mov    0x8(%ebp),%eax
801028c4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801028cb:	c7 45 f4 54 b6 10 80 	movl   $0x8010b654,-0xc(%ebp)
801028d2:	eb 0b                	jmp    801028df <iderw+0x87>
801028d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028d7:	8b 00                	mov    (%eax),%eax
801028d9:	83 c0 14             	add    $0x14,%eax
801028dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028e2:	8b 00                	mov    (%eax),%eax
801028e4:	85 c0                	test   %eax,%eax
801028e6:	75 ec                	jne    801028d4 <iderw+0x7c>
    ;
  *pp = b;
801028e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028eb:	8b 55 08             	mov    0x8(%ebp),%edx
801028ee:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
801028f0:	a1 54 b6 10 80       	mov    0x8010b654,%eax
801028f5:	3b 45 08             	cmp    0x8(%ebp),%eax
801028f8:	75 0e                	jne    80102908 <iderw+0xb0>
    idestart(b);
801028fa:	83 ec 0c             	sub    $0xc,%esp
801028fd:	ff 75 08             	pushl  0x8(%ebp)
80102900:	e8 5d fd ff ff       	call   80102662 <idestart>
80102905:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102908:	eb 13                	jmp    8010291d <iderw+0xc5>
    sleep(b, &idelock);
8010290a:	83 ec 08             	sub    $0x8,%esp
8010290d:	68 20 b6 10 80       	push   $0x8010b620
80102912:	ff 75 08             	pushl  0x8(%ebp)
80102915:	e8 29 23 00 00       	call   80104c43 <sleep>
8010291a:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010291d:	8b 45 08             	mov    0x8(%ebp),%eax
80102920:	8b 00                	mov    (%eax),%eax
80102922:	83 e0 06             	and    $0x6,%eax
80102925:	83 f8 02             	cmp    $0x2,%eax
80102928:	75 e0                	jne    8010290a <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
8010292a:	83 ec 0c             	sub    $0xc,%esp
8010292d:	68 20 b6 10 80       	push   $0x8010b620
80102932:	e8 4d 27 00 00       	call   80105084 <release>
80102937:	83 c4 10             	add    $0x10,%esp
}
8010293a:	c9                   	leave  
8010293b:	c3                   	ret    

8010293c <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
8010293c:	55                   	push   %ebp
8010293d:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010293f:	a1 94 22 11 80       	mov    0x80112294,%eax
80102944:	8b 55 08             	mov    0x8(%ebp),%edx
80102947:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102949:	a1 94 22 11 80       	mov    0x80112294,%eax
8010294e:	8b 40 10             	mov    0x10(%eax),%eax
}
80102951:	5d                   	pop    %ebp
80102952:	c3                   	ret    

80102953 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102953:	55                   	push   %ebp
80102954:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102956:	a1 94 22 11 80       	mov    0x80112294,%eax
8010295b:	8b 55 08             	mov    0x8(%ebp),%edx
8010295e:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102960:	a1 94 22 11 80       	mov    0x80112294,%eax
80102965:	8b 55 0c             	mov    0xc(%ebp),%edx
80102968:	89 50 10             	mov    %edx,0x10(%eax)
}
8010296b:	5d                   	pop    %ebp
8010296c:	c3                   	ret    

8010296d <ioapicinit>:

void
ioapicinit(void)
{
8010296d:	55                   	push   %ebp
8010296e:	89 e5                	mov    %esp,%ebp
80102970:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102973:	a1 04 24 11 80       	mov    0x80112404,%eax
80102978:	85 c0                	test   %eax,%eax
8010297a:	75 05                	jne    80102981 <ioapicinit+0x14>
    return;
8010297c:	e9 9e 00 00 00       	jmp    80102a1f <ioapicinit+0xb2>

  ioapic = (volatile struct ioapic*)IOAPIC;
80102981:	c7 05 94 22 11 80 00 	movl   $0xfec00000,0x80112294
80102988:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010298b:	6a 01                	push   $0x1
8010298d:	e8 aa ff ff ff       	call   8010293c <ioapicread>
80102992:	83 c4 04             	add    $0x4,%esp
80102995:	c1 e8 10             	shr    $0x10,%eax
80102998:	25 ff 00 00 00       	and    $0xff,%eax
8010299d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
801029a0:	6a 00                	push   $0x0
801029a2:	e8 95 ff ff ff       	call   8010293c <ioapicread>
801029a7:	83 c4 04             	add    $0x4,%esp
801029aa:	c1 e8 18             	shr    $0x18,%eax
801029ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
801029b0:	0f b6 05 00 24 11 80 	movzbl 0x80112400,%eax
801029b7:	0f b6 c0             	movzbl %al,%eax
801029ba:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801029bd:	74 10                	je     801029cf <ioapicinit+0x62>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801029bf:	83 ec 0c             	sub    $0xc,%esp
801029c2:	68 94 87 10 80       	push   $0x80108794
801029c7:	e8 f3 d9 ff ff       	call   801003bf <cprintf>
801029cc:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801029cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801029d6:	eb 3f                	jmp    80102a17 <ioapicinit+0xaa>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801029d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029db:	83 c0 20             	add    $0x20,%eax
801029de:	0d 00 00 01 00       	or     $0x10000,%eax
801029e3:	89 c2                	mov    %eax,%edx
801029e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029e8:	83 c0 08             	add    $0x8,%eax
801029eb:	01 c0                	add    %eax,%eax
801029ed:	83 ec 08             	sub    $0x8,%esp
801029f0:	52                   	push   %edx
801029f1:	50                   	push   %eax
801029f2:	e8 5c ff ff ff       	call   80102953 <ioapicwrite>
801029f7:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
801029fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029fd:	83 c0 08             	add    $0x8,%eax
80102a00:	01 c0                	add    %eax,%eax
80102a02:	83 c0 01             	add    $0x1,%eax
80102a05:	83 ec 08             	sub    $0x8,%esp
80102a08:	6a 00                	push   $0x0
80102a0a:	50                   	push   %eax
80102a0b:	e8 43 ff ff ff       	call   80102953 <ioapicwrite>
80102a10:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a13:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a1a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102a1d:	7e b9                	jle    801029d8 <ioapicinit+0x6b>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102a1f:	c9                   	leave  
80102a20:	c3                   	ret    

80102a21 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a21:	55                   	push   %ebp
80102a22:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102a24:	a1 04 24 11 80       	mov    0x80112404,%eax
80102a29:	85 c0                	test   %eax,%eax
80102a2b:	75 02                	jne    80102a2f <ioapicenable+0xe>
    return;
80102a2d:	eb 37                	jmp    80102a66 <ioapicenable+0x45>

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a2f:	8b 45 08             	mov    0x8(%ebp),%eax
80102a32:	83 c0 20             	add    $0x20,%eax
80102a35:	89 c2                	mov    %eax,%edx
80102a37:	8b 45 08             	mov    0x8(%ebp),%eax
80102a3a:	83 c0 08             	add    $0x8,%eax
80102a3d:	01 c0                	add    %eax,%eax
80102a3f:	52                   	push   %edx
80102a40:	50                   	push   %eax
80102a41:	e8 0d ff ff ff       	call   80102953 <ioapicwrite>
80102a46:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a49:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a4c:	c1 e0 18             	shl    $0x18,%eax
80102a4f:	89 c2                	mov    %eax,%edx
80102a51:	8b 45 08             	mov    0x8(%ebp),%eax
80102a54:	83 c0 08             	add    $0x8,%eax
80102a57:	01 c0                	add    %eax,%eax
80102a59:	83 c0 01             	add    $0x1,%eax
80102a5c:	52                   	push   %edx
80102a5d:	50                   	push   %eax
80102a5e:	e8 f0 fe ff ff       	call   80102953 <ioapicwrite>
80102a63:	83 c4 08             	add    $0x8,%esp
}
80102a66:	c9                   	leave  
80102a67:	c3                   	ret    

80102a68 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102a68:	55                   	push   %ebp
80102a69:	89 e5                	mov    %esp,%ebp
80102a6b:	8b 45 08             	mov    0x8(%ebp),%eax
80102a6e:	05 00 00 00 80       	add    $0x80000000,%eax
80102a73:	5d                   	pop    %ebp
80102a74:	c3                   	ret    

80102a75 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102a75:	55                   	push   %ebp
80102a76:	89 e5                	mov    %esp,%ebp
80102a78:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102a7b:	83 ec 08             	sub    $0x8,%esp
80102a7e:	68 c6 87 10 80       	push   $0x801087c6
80102a83:	68 a0 22 11 80       	push   $0x801122a0
80102a88:	e8 70 25 00 00       	call   80104ffd <initlock>
80102a8d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a90:	c7 05 d4 22 11 80 00 	movl   $0x0,0x801122d4
80102a97:	00 00 00 
  freerange(vstart, vend);
80102a9a:	83 ec 08             	sub    $0x8,%esp
80102a9d:	ff 75 0c             	pushl  0xc(%ebp)
80102aa0:	ff 75 08             	pushl  0x8(%ebp)
80102aa3:	e8 28 00 00 00       	call   80102ad0 <freerange>
80102aa8:	83 c4 10             	add    $0x10,%esp
}
80102aab:	c9                   	leave  
80102aac:	c3                   	ret    

80102aad <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102aad:	55                   	push   %ebp
80102aae:	89 e5                	mov    %esp,%ebp
80102ab0:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102ab3:	83 ec 08             	sub    $0x8,%esp
80102ab6:	ff 75 0c             	pushl  0xc(%ebp)
80102ab9:	ff 75 08             	pushl  0x8(%ebp)
80102abc:	e8 0f 00 00 00       	call   80102ad0 <freerange>
80102ac1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102ac4:	c7 05 d4 22 11 80 01 	movl   $0x1,0x801122d4
80102acb:	00 00 00 
}
80102ace:	c9                   	leave  
80102acf:	c3                   	ret    

80102ad0 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102ad6:	8b 45 08             	mov    0x8(%ebp),%eax
80102ad9:	05 ff 0f 00 00       	add    $0xfff,%eax
80102ade:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102ae3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ae6:	eb 15                	jmp    80102afd <freerange+0x2d>
    kfree(p);
80102ae8:	83 ec 0c             	sub    $0xc,%esp
80102aeb:	ff 75 f4             	pushl  -0xc(%ebp)
80102aee:	e8 19 00 00 00       	call   80102b0c <kfree>
80102af3:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102af6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102afd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b00:	05 00 10 00 00       	add    $0x1000,%eax
80102b05:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b08:	76 de                	jbe    80102ae8 <freerange+0x18>
    kfree(p);
}
80102b0a:	c9                   	leave  
80102b0b:	c3                   	ret    

80102b0c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102b0c:	55                   	push   %ebp
80102b0d:	89 e5                	mov    %esp,%ebp
80102b0f:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102b12:	8b 45 08             	mov    0x8(%ebp),%eax
80102b15:	25 ff 0f 00 00       	and    $0xfff,%eax
80102b1a:	85 c0                	test   %eax,%eax
80102b1c:	75 1b                	jne    80102b39 <kfree+0x2d>
80102b1e:	81 7d 08 1c 53 11 80 	cmpl   $0x8011531c,0x8(%ebp)
80102b25:	72 12                	jb     80102b39 <kfree+0x2d>
80102b27:	ff 75 08             	pushl  0x8(%ebp)
80102b2a:	e8 39 ff ff ff       	call   80102a68 <v2p>
80102b2f:	83 c4 04             	add    $0x4,%esp
80102b32:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b37:	76 0d                	jbe    80102b46 <kfree+0x3a>
    panic("kfree");
80102b39:	83 ec 0c             	sub    $0xc,%esp
80102b3c:	68 cb 87 10 80       	push   $0x801087cb
80102b41:	e8 16 da ff ff       	call   8010055c <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102b46:	83 ec 04             	sub    $0x4,%esp
80102b49:	68 00 10 00 00       	push   $0x1000
80102b4e:	6a 01                	push   $0x1
80102b50:	ff 75 08             	pushl  0x8(%ebp)
80102b53:	e8 22 27 00 00       	call   8010527a <memset>
80102b58:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102b5b:	a1 d4 22 11 80       	mov    0x801122d4,%eax
80102b60:	85 c0                	test   %eax,%eax
80102b62:	74 10                	je     80102b74 <kfree+0x68>
    acquire(&kmem.lock);
80102b64:	83 ec 0c             	sub    $0xc,%esp
80102b67:	68 a0 22 11 80       	push   $0x801122a0
80102b6c:	e8 ad 24 00 00       	call   8010501e <acquire>
80102b71:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102b74:	8b 45 08             	mov    0x8(%ebp),%eax
80102b77:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102b7a:	8b 15 d8 22 11 80    	mov    0x801122d8,%edx
80102b80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b83:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102b85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b88:	a3 d8 22 11 80       	mov    %eax,0x801122d8
  if(kmem.use_lock)
80102b8d:	a1 d4 22 11 80       	mov    0x801122d4,%eax
80102b92:	85 c0                	test   %eax,%eax
80102b94:	74 10                	je     80102ba6 <kfree+0x9a>
    release(&kmem.lock);
80102b96:	83 ec 0c             	sub    $0xc,%esp
80102b99:	68 a0 22 11 80       	push   $0x801122a0
80102b9e:	e8 e1 24 00 00       	call   80105084 <release>
80102ba3:	83 c4 10             	add    $0x10,%esp
}
80102ba6:	c9                   	leave  
80102ba7:	c3                   	ret    

80102ba8 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102ba8:	55                   	push   %ebp
80102ba9:	89 e5                	mov    %esp,%ebp
80102bab:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102bae:	a1 d4 22 11 80       	mov    0x801122d4,%eax
80102bb3:	85 c0                	test   %eax,%eax
80102bb5:	74 10                	je     80102bc7 <kalloc+0x1f>
    acquire(&kmem.lock);
80102bb7:	83 ec 0c             	sub    $0xc,%esp
80102bba:	68 a0 22 11 80       	push   $0x801122a0
80102bbf:	e8 5a 24 00 00       	call   8010501e <acquire>
80102bc4:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102bc7:	a1 d8 22 11 80       	mov    0x801122d8,%eax
80102bcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102bcf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102bd3:	74 0a                	je     80102bdf <kalloc+0x37>
    kmem.freelist = r->next;
80102bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bd8:	8b 00                	mov    (%eax),%eax
80102bda:	a3 d8 22 11 80       	mov    %eax,0x801122d8
  if(kmem.use_lock)
80102bdf:	a1 d4 22 11 80       	mov    0x801122d4,%eax
80102be4:	85 c0                	test   %eax,%eax
80102be6:	74 10                	je     80102bf8 <kalloc+0x50>
    release(&kmem.lock);
80102be8:	83 ec 0c             	sub    $0xc,%esp
80102beb:	68 a0 22 11 80       	push   $0x801122a0
80102bf0:	e8 8f 24 00 00       	call   80105084 <release>
80102bf5:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102bfb:	c9                   	leave  
80102bfc:	c3                   	ret    

80102bfd <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102bfd:	55                   	push   %ebp
80102bfe:	89 e5                	mov    %esp,%ebp
80102c00:	83 ec 14             	sub    $0x14,%esp
80102c03:	8b 45 08             	mov    0x8(%ebp),%eax
80102c06:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c0a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102c0e:	89 c2                	mov    %eax,%edx
80102c10:	ec                   	in     (%dx),%al
80102c11:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102c14:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102c18:	c9                   	leave  
80102c19:	c3                   	ret    

80102c1a <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102c1a:	55                   	push   %ebp
80102c1b:	89 e5                	mov    %esp,%ebp
80102c1d:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102c20:	6a 64                	push   $0x64
80102c22:	e8 d6 ff ff ff       	call   80102bfd <inb>
80102c27:	83 c4 04             	add    $0x4,%esp
80102c2a:	0f b6 c0             	movzbl %al,%eax
80102c2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c33:	83 e0 01             	and    $0x1,%eax
80102c36:	85 c0                	test   %eax,%eax
80102c38:	75 0a                	jne    80102c44 <kbdgetc+0x2a>
    return -1;
80102c3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c3f:	e9 23 01 00 00       	jmp    80102d67 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102c44:	6a 60                	push   $0x60
80102c46:	e8 b2 ff ff ff       	call   80102bfd <inb>
80102c4b:	83 c4 04             	add    $0x4,%esp
80102c4e:	0f b6 c0             	movzbl %al,%eax
80102c51:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102c54:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102c5b:	75 17                	jne    80102c74 <kbdgetc+0x5a>
    shift |= E0ESC;
80102c5d:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c62:	83 c8 40             	or     $0x40,%eax
80102c65:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102c6a:	b8 00 00 00 00       	mov    $0x0,%eax
80102c6f:	e9 f3 00 00 00       	jmp    80102d67 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102c74:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c77:	25 80 00 00 00       	and    $0x80,%eax
80102c7c:	85 c0                	test   %eax,%eax
80102c7e:	74 45                	je     80102cc5 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102c80:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c85:	83 e0 40             	and    $0x40,%eax
80102c88:	85 c0                	test   %eax,%eax
80102c8a:	75 08                	jne    80102c94 <kbdgetc+0x7a>
80102c8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c8f:	83 e0 7f             	and    $0x7f,%eax
80102c92:	eb 03                	jmp    80102c97 <kbdgetc+0x7d>
80102c94:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c97:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102c9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c9d:	05 40 90 10 80       	add    $0x80109040,%eax
80102ca2:	0f b6 00             	movzbl (%eax),%eax
80102ca5:	83 c8 40             	or     $0x40,%eax
80102ca8:	0f b6 c0             	movzbl %al,%eax
80102cab:	f7 d0                	not    %eax
80102cad:	89 c2                	mov    %eax,%edx
80102caf:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cb4:	21 d0                	and    %edx,%eax
80102cb6:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102cbb:	b8 00 00 00 00       	mov    $0x0,%eax
80102cc0:	e9 a2 00 00 00       	jmp    80102d67 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102cc5:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cca:	83 e0 40             	and    $0x40,%eax
80102ccd:	85 c0                	test   %eax,%eax
80102ccf:	74 14                	je     80102ce5 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102cd1:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102cd8:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cdd:	83 e0 bf             	and    $0xffffffbf,%eax
80102ce0:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  }

  shift |= shiftcode[data];
80102ce5:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ce8:	05 40 90 10 80       	add    $0x80109040,%eax
80102ced:	0f b6 00             	movzbl (%eax),%eax
80102cf0:	0f b6 d0             	movzbl %al,%edx
80102cf3:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cf8:	09 d0                	or     %edx,%eax
80102cfa:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  shift ^= togglecode[data];
80102cff:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d02:	05 40 91 10 80       	add    $0x80109140,%eax
80102d07:	0f b6 00             	movzbl (%eax),%eax
80102d0a:	0f b6 d0             	movzbl %al,%edx
80102d0d:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d12:	31 d0                	xor    %edx,%eax
80102d14:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  c = charcode[shift & (CTL | SHIFT)][data];
80102d19:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d1e:	83 e0 03             	and    $0x3,%eax
80102d21:	8b 14 85 40 95 10 80 	mov    -0x7fef6ac0(,%eax,4),%edx
80102d28:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d2b:	01 d0                	add    %edx,%eax
80102d2d:	0f b6 00             	movzbl (%eax),%eax
80102d30:	0f b6 c0             	movzbl %al,%eax
80102d33:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102d36:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d3b:	83 e0 08             	and    $0x8,%eax
80102d3e:	85 c0                	test   %eax,%eax
80102d40:	74 22                	je     80102d64 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102d42:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102d46:	76 0c                	jbe    80102d54 <kbdgetc+0x13a>
80102d48:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102d4c:	77 06                	ja     80102d54 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102d4e:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102d52:	eb 10                	jmp    80102d64 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102d54:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102d58:	76 0a                	jbe    80102d64 <kbdgetc+0x14a>
80102d5a:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102d5e:	77 04                	ja     80102d64 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102d60:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102d64:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102d67:	c9                   	leave  
80102d68:	c3                   	ret    

80102d69 <kbdintr>:

void
kbdintr(void)
{
80102d69:	55                   	push   %ebp
80102d6a:	89 e5                	mov    %esp,%ebp
80102d6c:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102d6f:	83 ec 0c             	sub    $0xc,%esp
80102d72:	68 1a 2c 10 80       	push   $0x80102c1a
80102d77:	e8 55 da ff ff       	call   801007d1 <consoleintr>
80102d7c:	83 c4 10             	add    $0x10,%esp
}
80102d7f:	c9                   	leave  
80102d80:	c3                   	ret    

80102d81 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102d81:	55                   	push   %ebp
80102d82:	89 e5                	mov    %esp,%ebp
80102d84:	83 ec 14             	sub    $0x14,%esp
80102d87:	8b 45 08             	mov    0x8(%ebp),%eax
80102d8a:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d8e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102d92:	89 c2                	mov    %eax,%edx
80102d94:	ec                   	in     (%dx),%al
80102d95:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102d98:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102d9c:	c9                   	leave  
80102d9d:	c3                   	ret    

80102d9e <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102d9e:	55                   	push   %ebp
80102d9f:	89 e5                	mov    %esp,%ebp
80102da1:	83 ec 08             	sub    $0x8,%esp
80102da4:	8b 55 08             	mov    0x8(%ebp),%edx
80102da7:	8b 45 0c             	mov    0xc(%ebp),%eax
80102daa:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102dae:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102db1:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102db5:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102db9:	ee                   	out    %al,(%dx)
}
80102dba:	c9                   	leave  
80102dbb:	c3                   	ret    

80102dbc <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102dbc:	55                   	push   %ebp
80102dbd:	89 e5                	mov    %esp,%ebp
80102dbf:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102dc2:	9c                   	pushf  
80102dc3:	58                   	pop    %eax
80102dc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102dc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102dca:	c9                   	leave  
80102dcb:	c3                   	ret    

80102dcc <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102dcc:	55                   	push   %ebp
80102dcd:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102dcf:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102dd4:	8b 55 08             	mov    0x8(%ebp),%edx
80102dd7:	c1 e2 02             	shl    $0x2,%edx
80102dda:	01 c2                	add    %eax,%edx
80102ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ddf:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102de1:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102de6:	83 c0 20             	add    $0x20,%eax
80102de9:	8b 00                	mov    (%eax),%eax
}
80102deb:	5d                   	pop    %ebp
80102dec:	c3                   	ret    

80102ded <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102ded:	55                   	push   %ebp
80102dee:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80102df0:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102df5:	85 c0                	test   %eax,%eax
80102df7:	75 05                	jne    80102dfe <lapicinit+0x11>
    return;
80102df9:	e9 09 01 00 00       	jmp    80102f07 <lapicinit+0x11a>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102dfe:	68 3f 01 00 00       	push   $0x13f
80102e03:	6a 3c                	push   $0x3c
80102e05:	e8 c2 ff ff ff       	call   80102dcc <lapicw>
80102e0a:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102e0d:	6a 0b                	push   $0xb
80102e0f:	68 f8 00 00 00       	push   $0xf8
80102e14:	e8 b3 ff ff ff       	call   80102dcc <lapicw>
80102e19:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102e1c:	68 20 00 02 00       	push   $0x20020
80102e21:	68 c8 00 00 00       	push   $0xc8
80102e26:	e8 a1 ff ff ff       	call   80102dcc <lapicw>
80102e2b:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80102e2e:	68 80 96 98 00       	push   $0x989680
80102e33:	68 e0 00 00 00       	push   $0xe0
80102e38:	e8 8f ff ff ff       	call   80102dcc <lapicw>
80102e3d:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102e40:	68 00 00 01 00       	push   $0x10000
80102e45:	68 d4 00 00 00       	push   $0xd4
80102e4a:	e8 7d ff ff ff       	call   80102dcc <lapicw>
80102e4f:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102e52:	68 00 00 01 00       	push   $0x10000
80102e57:	68 d8 00 00 00       	push   $0xd8
80102e5c:	e8 6b ff ff ff       	call   80102dcc <lapicw>
80102e61:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102e64:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102e69:	83 c0 30             	add    $0x30,%eax
80102e6c:	8b 00                	mov    (%eax),%eax
80102e6e:	c1 e8 10             	shr    $0x10,%eax
80102e71:	0f b6 c0             	movzbl %al,%eax
80102e74:	83 f8 03             	cmp    $0x3,%eax
80102e77:	76 12                	jbe    80102e8b <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
80102e79:	68 00 00 01 00       	push   $0x10000
80102e7e:	68 d0 00 00 00       	push   $0xd0
80102e83:	e8 44 ff ff ff       	call   80102dcc <lapicw>
80102e88:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102e8b:	6a 33                	push   $0x33
80102e8d:	68 dc 00 00 00       	push   $0xdc
80102e92:	e8 35 ff ff ff       	call   80102dcc <lapicw>
80102e97:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102e9a:	6a 00                	push   $0x0
80102e9c:	68 a0 00 00 00       	push   $0xa0
80102ea1:	e8 26 ff ff ff       	call   80102dcc <lapicw>
80102ea6:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102ea9:	6a 00                	push   $0x0
80102eab:	68 a0 00 00 00       	push   $0xa0
80102eb0:	e8 17 ff ff ff       	call   80102dcc <lapicw>
80102eb5:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102eb8:	6a 00                	push   $0x0
80102eba:	6a 2c                	push   $0x2c
80102ebc:	e8 0b ff ff ff       	call   80102dcc <lapicw>
80102ec1:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102ec4:	6a 00                	push   $0x0
80102ec6:	68 c4 00 00 00       	push   $0xc4
80102ecb:	e8 fc fe ff ff       	call   80102dcc <lapicw>
80102ed0:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102ed3:	68 00 85 08 00       	push   $0x88500
80102ed8:	68 c0 00 00 00       	push   $0xc0
80102edd:	e8 ea fe ff ff       	call   80102dcc <lapicw>
80102ee2:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102ee5:	90                   	nop
80102ee6:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102eeb:	05 00 03 00 00       	add    $0x300,%eax
80102ef0:	8b 00                	mov    (%eax),%eax
80102ef2:	25 00 10 00 00       	and    $0x1000,%eax
80102ef7:	85 c0                	test   %eax,%eax
80102ef9:	75 eb                	jne    80102ee6 <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102efb:	6a 00                	push   $0x0
80102efd:	6a 20                	push   $0x20
80102eff:	e8 c8 fe ff ff       	call   80102dcc <lapicw>
80102f04:	83 c4 08             	add    $0x8,%esp
}
80102f07:	c9                   	leave  
80102f08:	c3                   	ret    

80102f09 <cpunum>:

int
cpunum(void)
{
80102f09:	55                   	push   %ebp
80102f0a:	89 e5                	mov    %esp,%ebp
80102f0c:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102f0f:	e8 a8 fe ff ff       	call   80102dbc <readeflags>
80102f14:	25 00 02 00 00       	and    $0x200,%eax
80102f19:	85 c0                	test   %eax,%eax
80102f1b:	74 26                	je     80102f43 <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80102f1d:	a1 60 b6 10 80       	mov    0x8010b660,%eax
80102f22:	8d 50 01             	lea    0x1(%eax),%edx
80102f25:	89 15 60 b6 10 80    	mov    %edx,0x8010b660
80102f2b:	85 c0                	test   %eax,%eax
80102f2d:	75 14                	jne    80102f43 <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80102f2f:	8b 45 04             	mov    0x4(%ebp),%eax
80102f32:	83 ec 08             	sub    $0x8,%esp
80102f35:	50                   	push   %eax
80102f36:	68 d4 87 10 80       	push   $0x801087d4
80102f3b:	e8 7f d4 ff ff       	call   801003bf <cprintf>
80102f40:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80102f43:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102f48:	85 c0                	test   %eax,%eax
80102f4a:	74 0f                	je     80102f5b <cpunum+0x52>
    return lapic[ID]>>24;
80102f4c:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102f51:	83 c0 20             	add    $0x20,%eax
80102f54:	8b 00                	mov    (%eax),%eax
80102f56:	c1 e8 18             	shr    $0x18,%eax
80102f59:	eb 05                	jmp    80102f60 <cpunum+0x57>
  return 0;
80102f5b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102f60:	c9                   	leave  
80102f61:	c3                   	ret    

80102f62 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102f62:	55                   	push   %ebp
80102f63:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102f65:	a1 dc 22 11 80       	mov    0x801122dc,%eax
80102f6a:	85 c0                	test   %eax,%eax
80102f6c:	74 0c                	je     80102f7a <lapiceoi+0x18>
    lapicw(EOI, 0);
80102f6e:	6a 00                	push   $0x0
80102f70:	6a 2c                	push   $0x2c
80102f72:	e8 55 fe ff ff       	call   80102dcc <lapicw>
80102f77:	83 c4 08             	add    $0x8,%esp
}
80102f7a:	c9                   	leave  
80102f7b:	c3                   	ret    

80102f7c <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f7c:	55                   	push   %ebp
80102f7d:	89 e5                	mov    %esp,%ebp
}
80102f7f:	5d                   	pop    %ebp
80102f80:	c3                   	ret    

80102f81 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f81:	55                   	push   %ebp
80102f82:	89 e5                	mov    %esp,%ebp
80102f84:	83 ec 14             	sub    $0x14,%esp
80102f87:	8b 45 08             	mov    0x8(%ebp),%eax
80102f8a:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80102f8d:	6a 0f                	push   $0xf
80102f8f:	6a 70                	push   $0x70
80102f91:	e8 08 fe ff ff       	call   80102d9e <outb>
80102f96:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80102f99:	6a 0a                	push   $0xa
80102f9b:	6a 71                	push   $0x71
80102f9d:	e8 fc fd ff ff       	call   80102d9e <outb>
80102fa2:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102fa5:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80102fac:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102faf:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102fb4:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102fb7:	83 c0 02             	add    $0x2,%eax
80102fba:	8b 55 0c             	mov    0xc(%ebp),%edx
80102fbd:	c1 ea 04             	shr    $0x4,%edx
80102fc0:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102fc3:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102fc7:	c1 e0 18             	shl    $0x18,%eax
80102fca:	50                   	push   %eax
80102fcb:	68 c4 00 00 00       	push   $0xc4
80102fd0:	e8 f7 fd ff ff       	call   80102dcc <lapicw>
80102fd5:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102fd8:	68 00 c5 00 00       	push   $0xc500
80102fdd:	68 c0 00 00 00       	push   $0xc0
80102fe2:	e8 e5 fd ff ff       	call   80102dcc <lapicw>
80102fe7:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80102fea:	68 c8 00 00 00       	push   $0xc8
80102fef:	e8 88 ff ff ff       	call   80102f7c <microdelay>
80102ff4:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80102ff7:	68 00 85 00 00       	push   $0x8500
80102ffc:	68 c0 00 00 00       	push   $0xc0
80103001:	e8 c6 fd ff ff       	call   80102dcc <lapicw>
80103006:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103009:	6a 64                	push   $0x64
8010300b:	e8 6c ff ff ff       	call   80102f7c <microdelay>
80103010:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103013:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010301a:	eb 3d                	jmp    80103059 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
8010301c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103020:	c1 e0 18             	shl    $0x18,%eax
80103023:	50                   	push   %eax
80103024:	68 c4 00 00 00       	push   $0xc4
80103029:	e8 9e fd ff ff       	call   80102dcc <lapicw>
8010302e:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80103031:	8b 45 0c             	mov    0xc(%ebp),%eax
80103034:	c1 e8 0c             	shr    $0xc,%eax
80103037:	80 cc 06             	or     $0x6,%ah
8010303a:	50                   	push   %eax
8010303b:	68 c0 00 00 00       	push   $0xc0
80103040:	e8 87 fd ff ff       	call   80102dcc <lapicw>
80103045:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103048:	68 c8 00 00 00       	push   $0xc8
8010304d:	e8 2a ff ff ff       	call   80102f7c <microdelay>
80103052:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103055:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103059:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
8010305d:	7e bd                	jle    8010301c <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010305f:	c9                   	leave  
80103060:	c3                   	ret    

80103061 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
80103061:	55                   	push   %ebp
80103062:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
80103064:	8b 45 08             	mov    0x8(%ebp),%eax
80103067:	0f b6 c0             	movzbl %al,%eax
8010306a:	50                   	push   %eax
8010306b:	6a 70                	push   $0x70
8010306d:	e8 2c fd ff ff       	call   80102d9e <outb>
80103072:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103075:	68 c8 00 00 00       	push   $0xc8
8010307a:	e8 fd fe ff ff       	call   80102f7c <microdelay>
8010307f:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
80103082:	6a 71                	push   $0x71
80103084:	e8 f8 fc ff ff       	call   80102d81 <inb>
80103089:	83 c4 04             	add    $0x4,%esp
8010308c:	0f b6 c0             	movzbl %al,%eax
}
8010308f:	c9                   	leave  
80103090:	c3                   	ret    

80103091 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
80103091:	55                   	push   %ebp
80103092:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
80103094:	6a 00                	push   $0x0
80103096:	e8 c6 ff ff ff       	call   80103061 <cmos_read>
8010309b:	83 c4 04             	add    $0x4,%esp
8010309e:	89 c2                	mov    %eax,%edx
801030a0:	8b 45 08             	mov    0x8(%ebp),%eax
801030a3:	89 10                	mov    %edx,(%eax)
  r->minute = cmos_read(MINS);
801030a5:	6a 02                	push   $0x2
801030a7:	e8 b5 ff ff ff       	call   80103061 <cmos_read>
801030ac:	83 c4 04             	add    $0x4,%esp
801030af:	89 c2                	mov    %eax,%edx
801030b1:	8b 45 08             	mov    0x8(%ebp),%eax
801030b4:	89 50 04             	mov    %edx,0x4(%eax)
  r->hour   = cmos_read(HOURS);
801030b7:	6a 04                	push   $0x4
801030b9:	e8 a3 ff ff ff       	call   80103061 <cmos_read>
801030be:	83 c4 04             	add    $0x4,%esp
801030c1:	89 c2                	mov    %eax,%edx
801030c3:	8b 45 08             	mov    0x8(%ebp),%eax
801030c6:	89 50 08             	mov    %edx,0x8(%eax)
  r->day    = cmos_read(DAY);
801030c9:	6a 07                	push   $0x7
801030cb:	e8 91 ff ff ff       	call   80103061 <cmos_read>
801030d0:	83 c4 04             	add    $0x4,%esp
801030d3:	89 c2                	mov    %eax,%edx
801030d5:	8b 45 08             	mov    0x8(%ebp),%eax
801030d8:	89 50 0c             	mov    %edx,0xc(%eax)
  r->month  = cmos_read(MONTH);
801030db:	6a 08                	push   $0x8
801030dd:	e8 7f ff ff ff       	call   80103061 <cmos_read>
801030e2:	83 c4 04             	add    $0x4,%esp
801030e5:	89 c2                	mov    %eax,%edx
801030e7:	8b 45 08             	mov    0x8(%ebp),%eax
801030ea:	89 50 10             	mov    %edx,0x10(%eax)
  r->year   = cmos_read(YEAR);
801030ed:	6a 09                	push   $0x9
801030ef:	e8 6d ff ff ff       	call   80103061 <cmos_read>
801030f4:	83 c4 04             	add    $0x4,%esp
801030f7:	89 c2                	mov    %eax,%edx
801030f9:	8b 45 08             	mov    0x8(%ebp),%eax
801030fc:	89 50 14             	mov    %edx,0x14(%eax)
}
801030ff:	c9                   	leave  
80103100:	c3                   	ret    

80103101 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80103101:	55                   	push   %ebp
80103102:	89 e5                	mov    %esp,%ebp
80103104:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
80103107:	6a 0b                	push   $0xb
80103109:	e8 53 ff ff ff       	call   80103061 <cmos_read>
8010310e:	83 c4 04             	add    $0x4,%esp
80103111:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
80103114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103117:	83 e0 04             	and    $0x4,%eax
8010311a:	85 c0                	test   %eax,%eax
8010311c:	0f 94 c0             	sete   %al
8010311f:	0f b6 c0             	movzbl %al,%eax
80103122:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
80103125:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103128:	50                   	push   %eax
80103129:	e8 63 ff ff ff       	call   80103091 <fill_rtcdate>
8010312e:	83 c4 04             	add    $0x4,%esp
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
80103131:	6a 0a                	push   $0xa
80103133:	e8 29 ff ff ff       	call   80103061 <cmos_read>
80103138:	83 c4 04             	add    $0x4,%esp
8010313b:	25 80 00 00 00       	and    $0x80,%eax
80103140:	85 c0                	test   %eax,%eax
80103142:	74 02                	je     80103146 <cmostime+0x45>
        continue;
80103144:	eb 32                	jmp    80103178 <cmostime+0x77>
    fill_rtcdate(&t2);
80103146:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103149:	50                   	push   %eax
8010314a:	e8 42 ff ff ff       	call   80103091 <fill_rtcdate>
8010314f:	83 c4 04             	add    $0x4,%esp
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
80103152:	83 ec 04             	sub    $0x4,%esp
80103155:	6a 18                	push   $0x18
80103157:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010315a:	50                   	push   %eax
8010315b:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010315e:	50                   	push   %eax
8010315f:	e8 7d 21 00 00       	call   801052e1 <memcmp>
80103164:	83 c4 10             	add    $0x10,%esp
80103167:	85 c0                	test   %eax,%eax
80103169:	75 0d                	jne    80103178 <cmostime+0x77>
      break;
8010316b:	90                   	nop
  }

  // convert
  if (bcd) {
8010316c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103170:	0f 84 b8 00 00 00    	je     8010322e <cmostime+0x12d>
80103176:	eb 02                	jmp    8010317a <cmostime+0x79>
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
80103178:	eb ab                	jmp    80103125 <cmostime+0x24>

  // convert
  if (bcd) {
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010317a:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010317d:	c1 e8 04             	shr    $0x4,%eax
80103180:	89 c2                	mov    %eax,%edx
80103182:	89 d0                	mov    %edx,%eax
80103184:	c1 e0 02             	shl    $0x2,%eax
80103187:	01 d0                	add    %edx,%eax
80103189:	01 c0                	add    %eax,%eax
8010318b:	89 c2                	mov    %eax,%edx
8010318d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103190:	83 e0 0f             	and    $0xf,%eax
80103193:	01 d0                	add    %edx,%eax
80103195:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
80103198:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010319b:	c1 e8 04             	shr    $0x4,%eax
8010319e:	89 c2                	mov    %eax,%edx
801031a0:	89 d0                	mov    %edx,%eax
801031a2:	c1 e0 02             	shl    $0x2,%eax
801031a5:	01 d0                	add    %edx,%eax
801031a7:	01 c0                	add    %eax,%eax
801031a9:	89 c2                	mov    %eax,%edx
801031ab:	8b 45 dc             	mov    -0x24(%ebp),%eax
801031ae:	83 e0 0f             	and    $0xf,%eax
801031b1:	01 d0                	add    %edx,%eax
801031b3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
801031b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801031b9:	c1 e8 04             	shr    $0x4,%eax
801031bc:	89 c2                	mov    %eax,%edx
801031be:	89 d0                	mov    %edx,%eax
801031c0:	c1 e0 02             	shl    $0x2,%eax
801031c3:	01 d0                	add    %edx,%eax
801031c5:	01 c0                	add    %eax,%eax
801031c7:	89 c2                	mov    %eax,%edx
801031c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801031cc:	83 e0 0f             	and    $0xf,%eax
801031cf:	01 d0                	add    %edx,%eax
801031d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
801031d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801031d7:	c1 e8 04             	shr    $0x4,%eax
801031da:	89 c2                	mov    %eax,%edx
801031dc:	89 d0                	mov    %edx,%eax
801031de:	c1 e0 02             	shl    $0x2,%eax
801031e1:	01 d0                	add    %edx,%eax
801031e3:	01 c0                	add    %eax,%eax
801031e5:	89 c2                	mov    %eax,%edx
801031e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801031ea:	83 e0 0f             	and    $0xf,%eax
801031ed:	01 d0                	add    %edx,%eax
801031ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
801031f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
801031f5:	c1 e8 04             	shr    $0x4,%eax
801031f8:	89 c2                	mov    %eax,%edx
801031fa:	89 d0                	mov    %edx,%eax
801031fc:	c1 e0 02             	shl    $0x2,%eax
801031ff:	01 d0                	add    %edx,%eax
80103201:	01 c0                	add    %eax,%eax
80103203:	89 c2                	mov    %eax,%edx
80103205:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103208:	83 e0 0f             	and    $0xf,%eax
8010320b:	01 d0                	add    %edx,%eax
8010320d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
80103210:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103213:	c1 e8 04             	shr    $0x4,%eax
80103216:	89 c2                	mov    %eax,%edx
80103218:	89 d0                	mov    %edx,%eax
8010321a:	c1 e0 02             	shl    $0x2,%eax
8010321d:	01 d0                	add    %edx,%eax
8010321f:	01 c0                	add    %eax,%eax
80103221:	89 c2                	mov    %eax,%edx
80103223:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103226:	83 e0 0f             	and    $0xf,%eax
80103229:	01 d0                	add    %edx,%eax
8010322b:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
8010322e:	8b 45 08             	mov    0x8(%ebp),%eax
80103231:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103234:	89 10                	mov    %edx,(%eax)
80103236:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103239:	89 50 04             	mov    %edx,0x4(%eax)
8010323c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010323f:	89 50 08             	mov    %edx,0x8(%eax)
80103242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103245:	89 50 0c             	mov    %edx,0xc(%eax)
80103248:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010324b:	89 50 10             	mov    %edx,0x10(%eax)
8010324e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103251:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
80103254:	8b 45 08             	mov    0x8(%ebp),%eax
80103257:	8b 40 14             	mov    0x14(%eax),%eax
8010325a:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
80103260:	8b 45 08             	mov    0x8(%ebp),%eax
80103263:	89 50 14             	mov    %edx,0x14(%eax)
}
80103266:	c9                   	leave  
80103267:	c3                   	ret    

80103268 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(void)
{
80103268:	55                   	push   %ebp
80103269:	89 e5                	mov    %esp,%ebp
8010326b:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010326e:	83 ec 08             	sub    $0x8,%esp
80103271:	68 00 88 10 80       	push   $0x80108800
80103276:	68 00 23 11 80       	push   $0x80112300
8010327b:	e8 7d 1d 00 00       	call   80104ffd <initlock>
80103280:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
80103283:	83 ec 08             	sub    $0x8,%esp
80103286:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103289:	50                   	push   %eax
8010328a:	6a 01                	push   $0x1
8010328c:	e8 d1 e0 ff ff       	call   80101362 <readsb>
80103291:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
80103294:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103297:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010329a:	29 c2                	sub    %eax,%edx
8010329c:	89 d0                	mov    %edx,%eax
8010329e:	a3 34 23 11 80       	mov    %eax,0x80112334
  log.size = sb.nlog;
801032a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032a6:	a3 38 23 11 80       	mov    %eax,0x80112338
  log.dev = ROOTDEV;
801032ab:	c7 05 44 23 11 80 01 	movl   $0x1,0x80112344
801032b2:	00 00 00 
  recover_from_log();
801032b5:	e8 ae 01 00 00       	call   80103468 <recover_from_log>
}
801032ba:	c9                   	leave  
801032bb:	c3                   	ret    

801032bc <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
801032bc:	55                   	push   %ebp
801032bd:	89 e5                	mov    %esp,%ebp
801032bf:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801032c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801032c9:	e9 95 00 00 00       	jmp    80103363 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801032ce:	8b 15 34 23 11 80    	mov    0x80112334,%edx
801032d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032d7:	01 d0                	add    %edx,%eax
801032d9:	83 c0 01             	add    $0x1,%eax
801032dc:	89 c2                	mov    %eax,%edx
801032de:	a1 44 23 11 80       	mov    0x80112344,%eax
801032e3:	83 ec 08             	sub    $0x8,%esp
801032e6:	52                   	push   %edx
801032e7:	50                   	push   %eax
801032e8:	e8 c7 ce ff ff       	call   801001b4 <bread>
801032ed:	83 c4 10             	add    $0x10,%esp
801032f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
801032f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032f6:	83 c0 10             	add    $0x10,%eax
801032f9:	8b 04 85 0c 23 11 80 	mov    -0x7feedcf4(,%eax,4),%eax
80103300:	89 c2                	mov    %eax,%edx
80103302:	a1 44 23 11 80       	mov    0x80112344,%eax
80103307:	83 ec 08             	sub    $0x8,%esp
8010330a:	52                   	push   %edx
8010330b:	50                   	push   %eax
8010330c:	e8 a3 ce ff ff       	call   801001b4 <bread>
80103311:	83 c4 10             	add    $0x10,%esp
80103314:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103317:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010331a:	8d 50 18             	lea    0x18(%eax),%edx
8010331d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103320:	83 c0 18             	add    $0x18,%eax
80103323:	83 ec 04             	sub    $0x4,%esp
80103326:	68 00 02 00 00       	push   $0x200
8010332b:	52                   	push   %edx
8010332c:	50                   	push   %eax
8010332d:	e8 07 20 00 00       	call   80105339 <memmove>
80103332:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103335:	83 ec 0c             	sub    $0xc,%esp
80103338:	ff 75 ec             	pushl  -0x14(%ebp)
8010333b:	e8 ad ce ff ff       	call   801001ed <bwrite>
80103340:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
80103343:	83 ec 0c             	sub    $0xc,%esp
80103346:	ff 75 f0             	pushl  -0x10(%ebp)
80103349:	e8 dd ce ff ff       	call   8010022b <brelse>
8010334e:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
80103351:	83 ec 0c             	sub    $0xc,%esp
80103354:	ff 75 ec             	pushl  -0x14(%ebp)
80103357:	e8 cf ce ff ff       	call   8010022b <brelse>
8010335c:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010335f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103363:	a1 48 23 11 80       	mov    0x80112348,%eax
80103368:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010336b:	0f 8f 5d ff ff ff    	jg     801032ce <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
80103371:	c9                   	leave  
80103372:	c3                   	ret    

80103373 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103373:	55                   	push   %ebp
80103374:	89 e5                	mov    %esp,%ebp
80103376:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103379:	a1 34 23 11 80       	mov    0x80112334,%eax
8010337e:	89 c2                	mov    %eax,%edx
80103380:	a1 44 23 11 80       	mov    0x80112344,%eax
80103385:	83 ec 08             	sub    $0x8,%esp
80103388:	52                   	push   %edx
80103389:	50                   	push   %eax
8010338a:	e8 25 ce ff ff       	call   801001b4 <bread>
8010338f:	83 c4 10             	add    $0x10,%esp
80103392:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103395:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103398:	83 c0 18             	add    $0x18,%eax
8010339b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
8010339e:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033a1:	8b 00                	mov    (%eax),%eax
801033a3:	a3 48 23 11 80       	mov    %eax,0x80112348
  for (i = 0; i < log.lh.n; i++) {
801033a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801033af:	eb 1b                	jmp    801033cc <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
801033b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801033b7:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
801033bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801033be:	83 c2 10             	add    $0x10,%edx
801033c1:	89 04 95 0c 23 11 80 	mov    %eax,-0x7feedcf4(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
801033c8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033cc:	a1 48 23 11 80       	mov    0x80112348,%eax
801033d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033d4:	7f db                	jg     801033b1 <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
801033d6:	83 ec 0c             	sub    $0xc,%esp
801033d9:	ff 75 f0             	pushl  -0x10(%ebp)
801033dc:	e8 4a ce ff ff       	call   8010022b <brelse>
801033e1:	83 c4 10             	add    $0x10,%esp
}
801033e4:	c9                   	leave  
801033e5:	c3                   	ret    

801033e6 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801033e6:	55                   	push   %ebp
801033e7:	89 e5                	mov    %esp,%ebp
801033e9:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801033ec:	a1 34 23 11 80       	mov    0x80112334,%eax
801033f1:	89 c2                	mov    %eax,%edx
801033f3:	a1 44 23 11 80       	mov    0x80112344,%eax
801033f8:	83 ec 08             	sub    $0x8,%esp
801033fb:	52                   	push   %edx
801033fc:	50                   	push   %eax
801033fd:	e8 b2 cd ff ff       	call   801001b4 <bread>
80103402:	83 c4 10             	add    $0x10,%esp
80103405:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103408:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010340b:	83 c0 18             	add    $0x18,%eax
8010340e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103411:	8b 15 48 23 11 80    	mov    0x80112348,%edx
80103417:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010341a:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010341c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103423:	eb 1b                	jmp    80103440 <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
80103425:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103428:	83 c0 10             	add    $0x10,%eax
8010342b:	8b 0c 85 0c 23 11 80 	mov    -0x7feedcf4(,%eax,4),%ecx
80103432:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103435:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103438:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
8010343c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103440:	a1 48 23 11 80       	mov    0x80112348,%eax
80103445:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103448:	7f db                	jg     80103425 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
8010344a:	83 ec 0c             	sub    $0xc,%esp
8010344d:	ff 75 f0             	pushl  -0x10(%ebp)
80103450:	e8 98 cd ff ff       	call   801001ed <bwrite>
80103455:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103458:	83 ec 0c             	sub    $0xc,%esp
8010345b:	ff 75 f0             	pushl  -0x10(%ebp)
8010345e:	e8 c8 cd ff ff       	call   8010022b <brelse>
80103463:	83 c4 10             	add    $0x10,%esp
}
80103466:	c9                   	leave  
80103467:	c3                   	ret    

80103468 <recover_from_log>:

static void
recover_from_log(void)
{
80103468:	55                   	push   %ebp
80103469:	89 e5                	mov    %esp,%ebp
8010346b:	83 ec 08             	sub    $0x8,%esp
  read_head();      
8010346e:	e8 00 ff ff ff       	call   80103373 <read_head>
  install_trans(); // if committed, copy from log to disk
80103473:	e8 44 fe ff ff       	call   801032bc <install_trans>
  log.lh.n = 0;
80103478:	c7 05 48 23 11 80 00 	movl   $0x0,0x80112348
8010347f:	00 00 00 
  write_head(); // clear the log
80103482:	e8 5f ff ff ff       	call   801033e6 <write_head>
}
80103487:	c9                   	leave  
80103488:	c3                   	ret    

80103489 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103489:	55                   	push   %ebp
8010348a:	89 e5                	mov    %esp,%ebp
8010348c:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
8010348f:	83 ec 0c             	sub    $0xc,%esp
80103492:	68 00 23 11 80       	push   $0x80112300
80103497:	e8 82 1b 00 00       	call   8010501e <acquire>
8010349c:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
8010349f:	a1 40 23 11 80       	mov    0x80112340,%eax
801034a4:	85 c0                	test   %eax,%eax
801034a6:	74 17                	je     801034bf <begin_op+0x36>
      sleep(&log, &log.lock);
801034a8:	83 ec 08             	sub    $0x8,%esp
801034ab:	68 00 23 11 80       	push   $0x80112300
801034b0:	68 00 23 11 80       	push   $0x80112300
801034b5:	e8 89 17 00 00       	call   80104c43 <sleep>
801034ba:	83 c4 10             	add    $0x10,%esp
801034bd:	eb 54                	jmp    80103513 <begin_op+0x8a>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801034bf:	8b 0d 48 23 11 80    	mov    0x80112348,%ecx
801034c5:	a1 3c 23 11 80       	mov    0x8011233c,%eax
801034ca:	8d 50 01             	lea    0x1(%eax),%edx
801034cd:	89 d0                	mov    %edx,%eax
801034cf:	c1 e0 02             	shl    $0x2,%eax
801034d2:	01 d0                	add    %edx,%eax
801034d4:	01 c0                	add    %eax,%eax
801034d6:	01 c8                	add    %ecx,%eax
801034d8:	83 f8 1e             	cmp    $0x1e,%eax
801034db:	7e 17                	jle    801034f4 <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
801034dd:	83 ec 08             	sub    $0x8,%esp
801034e0:	68 00 23 11 80       	push   $0x80112300
801034e5:	68 00 23 11 80       	push   $0x80112300
801034ea:	e8 54 17 00 00       	call   80104c43 <sleep>
801034ef:	83 c4 10             	add    $0x10,%esp
801034f2:	eb 1f                	jmp    80103513 <begin_op+0x8a>
    } else {
      log.outstanding += 1;
801034f4:	a1 3c 23 11 80       	mov    0x8011233c,%eax
801034f9:	83 c0 01             	add    $0x1,%eax
801034fc:	a3 3c 23 11 80       	mov    %eax,0x8011233c
      release(&log.lock);
80103501:	83 ec 0c             	sub    $0xc,%esp
80103504:	68 00 23 11 80       	push   $0x80112300
80103509:	e8 76 1b 00 00       	call   80105084 <release>
8010350e:	83 c4 10             	add    $0x10,%esp
      break;
80103511:	eb 02                	jmp    80103515 <begin_op+0x8c>
    }
  }
80103513:	eb 8a                	jmp    8010349f <begin_op+0x16>
}
80103515:	c9                   	leave  
80103516:	c3                   	ret    

80103517 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103517:	55                   	push   %ebp
80103518:	89 e5                	mov    %esp,%ebp
8010351a:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
8010351d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
80103524:	83 ec 0c             	sub    $0xc,%esp
80103527:	68 00 23 11 80       	push   $0x80112300
8010352c:	e8 ed 1a 00 00       	call   8010501e <acquire>
80103531:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103534:	a1 3c 23 11 80       	mov    0x8011233c,%eax
80103539:	83 e8 01             	sub    $0x1,%eax
8010353c:	a3 3c 23 11 80       	mov    %eax,0x8011233c
  if(log.committing)
80103541:	a1 40 23 11 80       	mov    0x80112340,%eax
80103546:	85 c0                	test   %eax,%eax
80103548:	74 0d                	je     80103557 <end_op+0x40>
    panic("log.committing");
8010354a:	83 ec 0c             	sub    $0xc,%esp
8010354d:	68 04 88 10 80       	push   $0x80108804
80103552:	e8 05 d0 ff ff       	call   8010055c <panic>
  if(log.outstanding == 0){
80103557:	a1 3c 23 11 80       	mov    0x8011233c,%eax
8010355c:	85 c0                	test   %eax,%eax
8010355e:	75 13                	jne    80103573 <end_op+0x5c>
    do_commit = 1;
80103560:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80103567:	c7 05 40 23 11 80 01 	movl   $0x1,0x80112340
8010356e:	00 00 00 
80103571:	eb 10                	jmp    80103583 <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80103573:	83 ec 0c             	sub    $0xc,%esp
80103576:	68 00 23 11 80       	push   $0x80112300
8010357b:	e8 ac 17 00 00       	call   80104d2c <wakeup>
80103580:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
80103583:	83 ec 0c             	sub    $0xc,%esp
80103586:	68 00 23 11 80       	push   $0x80112300
8010358b:	e8 f4 1a 00 00       	call   80105084 <release>
80103590:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
80103593:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103597:	74 3f                	je     801035d8 <end_op+0xc1>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
80103599:	e8 f3 00 00 00       	call   80103691 <commit>
    acquire(&log.lock);
8010359e:	83 ec 0c             	sub    $0xc,%esp
801035a1:	68 00 23 11 80       	push   $0x80112300
801035a6:	e8 73 1a 00 00       	call   8010501e <acquire>
801035ab:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
801035ae:	c7 05 40 23 11 80 00 	movl   $0x0,0x80112340
801035b5:	00 00 00 
    wakeup(&log);
801035b8:	83 ec 0c             	sub    $0xc,%esp
801035bb:	68 00 23 11 80       	push   $0x80112300
801035c0:	e8 67 17 00 00       	call   80104d2c <wakeup>
801035c5:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
801035c8:	83 ec 0c             	sub    $0xc,%esp
801035cb:	68 00 23 11 80       	push   $0x80112300
801035d0:	e8 af 1a 00 00       	call   80105084 <release>
801035d5:	83 c4 10             	add    $0x10,%esp
  }
}
801035d8:	c9                   	leave  
801035d9:	c3                   	ret    

801035da <write_log>:

// Copy modified blocks from cache to log.
static void 
write_log(void)
{
801035da:	55                   	push   %ebp
801035db:	89 e5                	mov    %esp,%ebp
801035dd:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801035e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801035e7:	e9 95 00 00 00       	jmp    80103681 <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801035ec:	8b 15 34 23 11 80    	mov    0x80112334,%edx
801035f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801035f5:	01 d0                	add    %edx,%eax
801035f7:	83 c0 01             	add    $0x1,%eax
801035fa:	89 c2                	mov    %eax,%edx
801035fc:	a1 44 23 11 80       	mov    0x80112344,%eax
80103601:	83 ec 08             	sub    $0x8,%esp
80103604:	52                   	push   %edx
80103605:	50                   	push   %eax
80103606:	e8 a9 cb ff ff       	call   801001b4 <bread>
8010360b:	83 c4 10             	add    $0x10,%esp
8010360e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.sector[tail]); // cache block
80103611:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103614:	83 c0 10             	add    $0x10,%eax
80103617:	8b 04 85 0c 23 11 80 	mov    -0x7feedcf4(,%eax,4),%eax
8010361e:	89 c2                	mov    %eax,%edx
80103620:	a1 44 23 11 80       	mov    0x80112344,%eax
80103625:	83 ec 08             	sub    $0x8,%esp
80103628:	52                   	push   %edx
80103629:	50                   	push   %eax
8010362a:	e8 85 cb ff ff       	call   801001b4 <bread>
8010362f:	83 c4 10             	add    $0x10,%esp
80103632:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
80103635:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103638:	8d 50 18             	lea    0x18(%eax),%edx
8010363b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010363e:	83 c0 18             	add    $0x18,%eax
80103641:	83 ec 04             	sub    $0x4,%esp
80103644:	68 00 02 00 00       	push   $0x200
80103649:	52                   	push   %edx
8010364a:	50                   	push   %eax
8010364b:	e8 e9 1c 00 00       	call   80105339 <memmove>
80103650:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
80103653:	83 ec 0c             	sub    $0xc,%esp
80103656:	ff 75 f0             	pushl  -0x10(%ebp)
80103659:	e8 8f cb ff ff       	call   801001ed <bwrite>
8010365e:	83 c4 10             	add    $0x10,%esp
    brelse(from); 
80103661:	83 ec 0c             	sub    $0xc,%esp
80103664:	ff 75 ec             	pushl  -0x14(%ebp)
80103667:	e8 bf cb ff ff       	call   8010022b <brelse>
8010366c:	83 c4 10             	add    $0x10,%esp
    brelse(to);
8010366f:	83 ec 0c             	sub    $0xc,%esp
80103672:	ff 75 f0             	pushl  -0x10(%ebp)
80103675:	e8 b1 cb ff ff       	call   8010022b <brelse>
8010367a:	83 c4 10             	add    $0x10,%esp
static void 
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010367d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103681:	a1 48 23 11 80       	mov    0x80112348,%eax
80103686:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103689:	0f 8f 5d ff ff ff    	jg     801035ec <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from); 
    brelse(to);
  }
}
8010368f:	c9                   	leave  
80103690:	c3                   	ret    

80103691 <commit>:

static void
commit()
{
80103691:	55                   	push   %ebp
80103692:	89 e5                	mov    %esp,%ebp
80103694:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103697:	a1 48 23 11 80       	mov    0x80112348,%eax
8010369c:	85 c0                	test   %eax,%eax
8010369e:	7e 1e                	jle    801036be <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
801036a0:	e8 35 ff ff ff       	call   801035da <write_log>
    write_head();    // Write header to disk -- the real commit
801036a5:	e8 3c fd ff ff       	call   801033e6 <write_head>
    install_trans(); // Now install writes to home locations
801036aa:	e8 0d fc ff ff       	call   801032bc <install_trans>
    log.lh.n = 0; 
801036af:	c7 05 48 23 11 80 00 	movl   $0x0,0x80112348
801036b6:	00 00 00 
    write_head();    // Erase the transaction from the log
801036b9:	e8 28 fd ff ff       	call   801033e6 <write_head>
  }
}
801036be:	c9                   	leave  
801036bf:	c3                   	ret    

801036c0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801036c6:	a1 48 23 11 80       	mov    0x80112348,%eax
801036cb:	83 f8 1d             	cmp    $0x1d,%eax
801036ce:	7f 12                	jg     801036e2 <log_write+0x22>
801036d0:	a1 48 23 11 80       	mov    0x80112348,%eax
801036d5:	8b 15 38 23 11 80    	mov    0x80112338,%edx
801036db:	83 ea 01             	sub    $0x1,%edx
801036de:	39 d0                	cmp    %edx,%eax
801036e0:	7c 0d                	jl     801036ef <log_write+0x2f>
    panic("too big a transaction");
801036e2:	83 ec 0c             	sub    $0xc,%esp
801036e5:	68 13 88 10 80       	push   $0x80108813
801036ea:	e8 6d ce ff ff       	call   8010055c <panic>
  if (log.outstanding < 1)
801036ef:	a1 3c 23 11 80       	mov    0x8011233c,%eax
801036f4:	85 c0                	test   %eax,%eax
801036f6:	7f 0d                	jg     80103705 <log_write+0x45>
    panic("log_write outside of trans");
801036f8:	83 ec 0c             	sub    $0xc,%esp
801036fb:	68 29 88 10 80       	push   $0x80108829
80103700:	e8 57 ce ff ff       	call   8010055c <panic>

  acquire(&log.lock);
80103705:	83 ec 0c             	sub    $0xc,%esp
80103708:	68 00 23 11 80       	push   $0x80112300
8010370d:	e8 0c 19 00 00       	call   8010501e <acquire>
80103712:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
80103715:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010371c:	eb 1f                	jmp    8010373d <log_write+0x7d>
    if (log.lh.sector[i] == b->sector)   // log absorbtion
8010371e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103721:	83 c0 10             	add    $0x10,%eax
80103724:	8b 04 85 0c 23 11 80 	mov    -0x7feedcf4(,%eax,4),%eax
8010372b:	89 c2                	mov    %eax,%edx
8010372d:	8b 45 08             	mov    0x8(%ebp),%eax
80103730:	8b 40 08             	mov    0x8(%eax),%eax
80103733:	39 c2                	cmp    %eax,%edx
80103735:	75 02                	jne    80103739 <log_write+0x79>
      break;
80103737:	eb 0e                	jmp    80103747 <log_write+0x87>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103739:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010373d:	a1 48 23 11 80       	mov    0x80112348,%eax
80103742:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103745:	7f d7                	jg     8010371e <log_write+0x5e>
    if (log.lh.sector[i] == b->sector)   // log absorbtion
      break;
  }
  log.lh.sector[i] = b->sector;
80103747:	8b 45 08             	mov    0x8(%ebp),%eax
8010374a:	8b 40 08             	mov    0x8(%eax),%eax
8010374d:	89 c2                	mov    %eax,%edx
8010374f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103752:	83 c0 10             	add    $0x10,%eax
80103755:	89 14 85 0c 23 11 80 	mov    %edx,-0x7feedcf4(,%eax,4)
  if (i == log.lh.n)
8010375c:	a1 48 23 11 80       	mov    0x80112348,%eax
80103761:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103764:	75 0d                	jne    80103773 <log_write+0xb3>
    log.lh.n++;
80103766:	a1 48 23 11 80       	mov    0x80112348,%eax
8010376b:	83 c0 01             	add    $0x1,%eax
8010376e:	a3 48 23 11 80       	mov    %eax,0x80112348
  b->flags |= B_DIRTY; // prevent eviction
80103773:	8b 45 08             	mov    0x8(%ebp),%eax
80103776:	8b 00                	mov    (%eax),%eax
80103778:	83 c8 04             	or     $0x4,%eax
8010377b:	89 c2                	mov    %eax,%edx
8010377d:	8b 45 08             	mov    0x8(%ebp),%eax
80103780:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
80103782:	83 ec 0c             	sub    $0xc,%esp
80103785:	68 00 23 11 80       	push   $0x80112300
8010378a:	e8 f5 18 00 00       	call   80105084 <release>
8010378f:	83 c4 10             	add    $0x10,%esp
}
80103792:	c9                   	leave  
80103793:	c3                   	ret    

80103794 <v2p>:
80103794:	55                   	push   %ebp
80103795:	89 e5                	mov    %esp,%ebp
80103797:	8b 45 08             	mov    0x8(%ebp),%eax
8010379a:	05 00 00 00 80       	add    $0x80000000,%eax
8010379f:	5d                   	pop    %ebp
801037a0:	c3                   	ret    

801037a1 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801037a1:	55                   	push   %ebp
801037a2:	89 e5                	mov    %esp,%ebp
801037a4:	8b 45 08             	mov    0x8(%ebp),%eax
801037a7:	05 00 00 00 80       	add    $0x80000000,%eax
801037ac:	5d                   	pop    %ebp
801037ad:	c3                   	ret    

801037ae <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801037ae:	55                   	push   %ebp
801037af:	89 e5                	mov    %esp,%ebp
801037b1:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801037b4:	8b 55 08             	mov    0x8(%ebp),%edx
801037b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801037ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
801037bd:	f0 87 02             	lock xchg %eax,(%edx)
801037c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801037c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801037c6:	c9                   	leave  
801037c7:	c3                   	ret    

801037c8 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801037c8:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801037cc:	83 e4 f0             	and    $0xfffffff0,%esp
801037cf:	ff 71 fc             	pushl  -0x4(%ecx)
801037d2:	55                   	push   %ebp
801037d3:	89 e5                	mov    %esp,%ebp
801037d5:	51                   	push   %ecx
801037d6:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801037d9:	83 ec 08             	sub    $0x8,%esp
801037dc:	68 00 00 40 80       	push   $0x80400000
801037e1:	68 1c 53 11 80       	push   $0x8011531c
801037e6:	e8 8a f2 ff ff       	call   80102a75 <kinit1>
801037eb:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801037ee:	e8 91 46 00 00       	call   80107e84 <kvmalloc>
  mpinit();        // collect info about this machine
801037f3:	e8 45 04 00 00       	call   80103c3d <mpinit>
  lapicinit();
801037f8:	e8 f0 f5 ff ff       	call   80102ded <lapicinit>
  seginit();       // set up segments
801037fd:	e8 2a 40 00 00       	call   8010782c <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103802:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103808:	0f b6 00             	movzbl (%eax),%eax
8010380b:	0f b6 c0             	movzbl %al,%eax
8010380e:	83 ec 08             	sub    $0x8,%esp
80103811:	50                   	push   %eax
80103812:	68 44 88 10 80       	push   $0x80108844
80103817:	e8 a3 cb ff ff       	call   801003bf <cprintf>
8010381c:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
8010381f:	e8 6a 06 00 00       	call   80103e8e <picinit>
  ioapicinit();    // another interrupt controller
80103824:	e8 44 f1 ff ff       	call   8010296d <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103829:	e8 b5 d2 ff ff       	call   80100ae3 <consoleinit>
  uartinit();      // serial port
8010382e:	e8 5c 33 00 00       	call   80106b8f <uartinit>
  pinit();         // process table
80103833:	e8 55 0b 00 00       	call   8010438d <pinit>
  tvinit();        // trap vectors
80103838:	e8 01 2f 00 00       	call   8010673e <tvinit>
  binit();         // buffer cache
8010383d:	e8 f2 c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103842:	e8 0f d7 ff ff       	call   80100f56 <fileinit>
  iinit();         // inode cache
80103847:	e8 e2 dd ff ff       	call   8010162e <iinit>
  ideinit();       // disk
8010384c:	e8 64 ed ff ff       	call   801025b5 <ideinit>
  if(!ismp)
80103851:	a1 04 24 11 80       	mov    0x80112404,%eax
80103856:	85 c0                	test   %eax,%eax
80103858:	75 05                	jne    8010385f <main+0x97>
    timerinit();   // uniprocessor timer
8010385a:	e8 3e 2e 00 00       	call   8010669d <timerinit>
  startothers();   // start other processors
8010385f:	e8 7f 00 00 00       	call   801038e3 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103864:	83 ec 08             	sub    $0x8,%esp
80103867:	68 00 00 00 8e       	push   $0x8e000000
8010386c:	68 00 00 40 80       	push   $0x80400000
80103871:	e8 37 f2 ff ff       	call   80102aad <kinit2>
80103876:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103879:	e8 31 0c 00 00       	call   801044af <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
8010387e:	e8 1a 00 00 00       	call   8010389d <mpmain>

80103883 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103883:	55                   	push   %ebp
80103884:	89 e5                	mov    %esp,%ebp
80103886:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103889:	e8 0d 46 00 00       	call   80107e9b <switchkvm>
  seginit();
8010388e:	e8 99 3f 00 00       	call   8010782c <seginit>
  lapicinit();
80103893:	e8 55 f5 ff ff       	call   80102ded <lapicinit>
  mpmain();
80103898:	e8 00 00 00 00       	call   8010389d <mpmain>

8010389d <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
8010389d:	55                   	push   %ebp
8010389e:	89 e5                	mov    %esp,%ebp
801038a0:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
801038a3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801038a9:	0f b6 00             	movzbl (%eax),%eax
801038ac:	0f b6 c0             	movzbl %al,%eax
801038af:	83 ec 08             	sub    $0x8,%esp
801038b2:	50                   	push   %eax
801038b3:	68 5b 88 10 80       	push   $0x8010885b
801038b8:	e8 02 cb ff ff       	call   801003bf <cprintf>
801038bd:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
801038c0:	e8 ee 2f 00 00       	call   801068b3 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801038c5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801038cb:	05 a8 00 00 00       	add    $0xa8,%eax
801038d0:	83 ec 08             	sub    $0x8,%esp
801038d3:	6a 01                	push   $0x1
801038d5:	50                   	push   %eax
801038d6:	e8 d3 fe ff ff       	call   801037ae <xchg>
801038db:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
801038de:	e8 97 11 00 00       	call   80104a7a <scheduler>

801038e3 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801038e3:	55                   	push   %ebp
801038e4:	89 e5                	mov    %esp,%ebp
801038e6:	53                   	push   %ebx
801038e7:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
801038ea:	68 00 70 00 00       	push   $0x7000
801038ef:	e8 ad fe ff ff       	call   801037a1 <p2v>
801038f4:	83 c4 04             	add    $0x4,%esp
801038f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801038fa:	b8 8a 00 00 00       	mov    $0x8a,%eax
801038ff:	83 ec 04             	sub    $0x4,%esp
80103902:	50                   	push   %eax
80103903:	68 2c b5 10 80       	push   $0x8010b52c
80103908:	ff 75 f0             	pushl  -0x10(%ebp)
8010390b:	e8 29 1a 00 00       	call   80105339 <memmove>
80103910:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103913:	c7 45 f4 40 24 11 80 	movl   $0x80112440,-0xc(%ebp)
8010391a:	e9 8f 00 00 00       	jmp    801039ae <startothers+0xcb>
    if(c == cpus+cpunum())  // We've started already.
8010391f:	e8 e5 f5 ff ff       	call   80102f09 <cpunum>
80103924:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010392a:	05 40 24 11 80       	add    $0x80112440,%eax
8010392f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103932:	75 02                	jne    80103936 <startothers+0x53>
      continue;
80103934:	eb 71                	jmp    801039a7 <startothers+0xc4>

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103936:	e8 6d f2 ff ff       	call   80102ba8 <kalloc>
8010393b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010393e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103941:	83 e8 04             	sub    $0x4,%eax
80103944:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103947:	81 c2 00 10 00 00    	add    $0x1000,%edx
8010394d:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
8010394f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103952:	83 e8 08             	sub    $0x8,%eax
80103955:	c7 00 83 38 10 80    	movl   $0x80103883,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
8010395b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010395e:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103961:	83 ec 0c             	sub    $0xc,%esp
80103964:	68 00 a0 10 80       	push   $0x8010a000
80103969:	e8 26 fe ff ff       	call   80103794 <v2p>
8010396e:	83 c4 10             	add    $0x10,%esp
80103971:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103973:	83 ec 0c             	sub    $0xc,%esp
80103976:	ff 75 f0             	pushl  -0x10(%ebp)
80103979:	e8 16 fe ff ff       	call   80103794 <v2p>
8010397e:	83 c4 10             	add    $0x10,%esp
80103981:	89 c2                	mov    %eax,%edx
80103983:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103986:	0f b6 00             	movzbl (%eax),%eax
80103989:	0f b6 c0             	movzbl %al,%eax
8010398c:	83 ec 08             	sub    $0x8,%esp
8010398f:	52                   	push   %edx
80103990:	50                   	push   %eax
80103991:	e8 eb f5 ff ff       	call   80102f81 <lapicstartap>
80103996:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103999:	90                   	nop
8010399a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010399d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801039a3:	85 c0                	test   %eax,%eax
801039a5:	74 f3                	je     8010399a <startothers+0xb7>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801039a7:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
801039ae:	a1 20 2a 11 80       	mov    0x80112a20,%eax
801039b3:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039b9:	05 40 24 11 80       	add    $0x80112440,%eax
801039be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801039c1:	0f 87 58 ff ff ff    	ja     8010391f <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
801039c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ca:	c9                   	leave  
801039cb:	c3                   	ret    

801039cc <p2v>:
801039cc:	55                   	push   %ebp
801039cd:	89 e5                	mov    %esp,%ebp
801039cf:	8b 45 08             	mov    0x8(%ebp),%eax
801039d2:	05 00 00 00 80       	add    $0x80000000,%eax
801039d7:	5d                   	pop    %ebp
801039d8:	c3                   	ret    

801039d9 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801039d9:	55                   	push   %ebp
801039da:	89 e5                	mov    %esp,%ebp
801039dc:	83 ec 14             	sub    $0x14,%esp
801039df:	8b 45 08             	mov    0x8(%ebp),%eax
801039e2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039e6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801039ea:	89 c2                	mov    %eax,%edx
801039ec:	ec                   	in     (%dx),%al
801039ed:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801039f0:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801039f4:	c9                   	leave  
801039f5:	c3                   	ret    

801039f6 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801039f6:	55                   	push   %ebp
801039f7:	89 e5                	mov    %esp,%ebp
801039f9:	83 ec 08             	sub    $0x8,%esp
801039fc:	8b 55 08             	mov    0x8(%ebp),%edx
801039ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a02:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a06:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a09:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a0d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a11:	ee                   	out    %al,(%dx)
}
80103a12:	c9                   	leave  
80103a13:	c3                   	ret    

80103a14 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103a14:	55                   	push   %ebp
80103a15:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103a17:	a1 64 b6 10 80       	mov    0x8010b664,%eax
80103a1c:	89 c2                	mov    %eax,%edx
80103a1e:	b8 40 24 11 80       	mov    $0x80112440,%eax
80103a23:	29 c2                	sub    %eax,%edx
80103a25:	89 d0                	mov    %edx,%eax
80103a27:	c1 f8 02             	sar    $0x2,%eax
80103a2a:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103a30:	5d                   	pop    %ebp
80103a31:	c3                   	ret    

80103a32 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103a32:	55                   	push   %ebp
80103a33:	89 e5                	mov    %esp,%ebp
80103a35:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103a38:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103a3f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103a46:	eb 15                	jmp    80103a5d <sum+0x2b>
    sum += addr[i];
80103a48:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103a4b:	8b 45 08             	mov    0x8(%ebp),%eax
80103a4e:	01 d0                	add    %edx,%eax
80103a50:	0f b6 00             	movzbl (%eax),%eax
80103a53:	0f b6 c0             	movzbl %al,%eax
80103a56:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103a59:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103a5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103a60:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103a63:	7c e3                	jl     80103a48 <sum+0x16>
    sum += addr[i];
  return sum;
80103a65:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103a68:	c9                   	leave  
80103a69:	c3                   	ret    

80103a6a <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103a6a:	55                   	push   %ebp
80103a6b:	89 e5                	mov    %esp,%ebp
80103a6d:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103a70:	ff 75 08             	pushl  0x8(%ebp)
80103a73:	e8 54 ff ff ff       	call   801039cc <p2v>
80103a78:	83 c4 04             	add    $0x4,%esp
80103a7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103a7e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a84:	01 d0                	add    %edx,%eax
80103a86:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103a89:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103a8f:	eb 36                	jmp    80103ac7 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103a91:	83 ec 04             	sub    $0x4,%esp
80103a94:	6a 04                	push   $0x4
80103a96:	68 6c 88 10 80       	push   $0x8010886c
80103a9b:	ff 75 f4             	pushl  -0xc(%ebp)
80103a9e:	e8 3e 18 00 00       	call   801052e1 <memcmp>
80103aa3:	83 c4 10             	add    $0x10,%esp
80103aa6:	85 c0                	test   %eax,%eax
80103aa8:	75 19                	jne    80103ac3 <mpsearch1+0x59>
80103aaa:	83 ec 08             	sub    $0x8,%esp
80103aad:	6a 10                	push   $0x10
80103aaf:	ff 75 f4             	pushl  -0xc(%ebp)
80103ab2:	e8 7b ff ff ff       	call   80103a32 <sum>
80103ab7:	83 c4 10             	add    $0x10,%esp
80103aba:	84 c0                	test   %al,%al
80103abc:	75 05                	jne    80103ac3 <mpsearch1+0x59>
      return (struct mp*)p;
80103abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ac1:	eb 11                	jmp    80103ad4 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103ac3:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aca:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103acd:	72 c2                	jb     80103a91 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103acf:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103ad4:	c9                   	leave  
80103ad5:	c3                   	ret    

80103ad6 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103ad6:	55                   	push   %ebp
80103ad7:	89 e5                	mov    %esp,%ebp
80103ad9:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103adc:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ae6:	83 c0 0f             	add    $0xf,%eax
80103ae9:	0f b6 00             	movzbl (%eax),%eax
80103aec:	0f b6 c0             	movzbl %al,%eax
80103aef:	c1 e0 08             	shl    $0x8,%eax
80103af2:	89 c2                	mov    %eax,%edx
80103af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103af7:	83 c0 0e             	add    $0xe,%eax
80103afa:	0f b6 00             	movzbl (%eax),%eax
80103afd:	0f b6 c0             	movzbl %al,%eax
80103b00:	09 d0                	or     %edx,%eax
80103b02:	c1 e0 04             	shl    $0x4,%eax
80103b05:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103b0c:	74 21                	je     80103b2f <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103b0e:	83 ec 08             	sub    $0x8,%esp
80103b11:	68 00 04 00 00       	push   $0x400
80103b16:	ff 75 f0             	pushl  -0x10(%ebp)
80103b19:	e8 4c ff ff ff       	call   80103a6a <mpsearch1>
80103b1e:	83 c4 10             	add    $0x10,%esp
80103b21:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b24:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b28:	74 51                	je     80103b7b <mpsearch+0xa5>
      return mp;
80103b2a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b2d:	eb 61                	jmp    80103b90 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b32:	83 c0 14             	add    $0x14,%eax
80103b35:	0f b6 00             	movzbl (%eax),%eax
80103b38:	0f b6 c0             	movzbl %al,%eax
80103b3b:	c1 e0 08             	shl    $0x8,%eax
80103b3e:	89 c2                	mov    %eax,%edx
80103b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b43:	83 c0 13             	add    $0x13,%eax
80103b46:	0f b6 00             	movzbl (%eax),%eax
80103b49:	0f b6 c0             	movzbl %al,%eax
80103b4c:	09 d0                	or     %edx,%eax
80103b4e:	c1 e0 0a             	shl    $0xa,%eax
80103b51:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103b54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b57:	2d 00 04 00 00       	sub    $0x400,%eax
80103b5c:	83 ec 08             	sub    $0x8,%esp
80103b5f:	68 00 04 00 00       	push   $0x400
80103b64:	50                   	push   %eax
80103b65:	e8 00 ff ff ff       	call   80103a6a <mpsearch1>
80103b6a:	83 c4 10             	add    $0x10,%esp
80103b6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b70:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b74:	74 05                	je     80103b7b <mpsearch+0xa5>
      return mp;
80103b76:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b79:	eb 15                	jmp    80103b90 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103b7b:	83 ec 08             	sub    $0x8,%esp
80103b7e:	68 00 00 01 00       	push   $0x10000
80103b83:	68 00 00 0f 00       	push   $0xf0000
80103b88:	e8 dd fe ff ff       	call   80103a6a <mpsearch1>
80103b8d:	83 c4 10             	add    $0x10,%esp
}
80103b90:	c9                   	leave  
80103b91:	c3                   	ret    

80103b92 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103b92:	55                   	push   %ebp
80103b93:	89 e5                	mov    %esp,%ebp
80103b95:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103b98:	e8 39 ff ff ff       	call   80103ad6 <mpsearch>
80103b9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ba0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103ba4:	74 0a                	je     80103bb0 <mpconfig+0x1e>
80103ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ba9:	8b 40 04             	mov    0x4(%eax),%eax
80103bac:	85 c0                	test   %eax,%eax
80103bae:	75 0a                	jne    80103bba <mpconfig+0x28>
    return 0;
80103bb0:	b8 00 00 00 00       	mov    $0x0,%eax
80103bb5:	e9 81 00 00 00       	jmp    80103c3b <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bbd:	8b 40 04             	mov    0x4(%eax),%eax
80103bc0:	83 ec 0c             	sub    $0xc,%esp
80103bc3:	50                   	push   %eax
80103bc4:	e8 03 fe ff ff       	call   801039cc <p2v>
80103bc9:	83 c4 10             	add    $0x10,%esp
80103bcc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103bcf:	83 ec 04             	sub    $0x4,%esp
80103bd2:	6a 04                	push   $0x4
80103bd4:	68 71 88 10 80       	push   $0x80108871
80103bd9:	ff 75 f0             	pushl  -0x10(%ebp)
80103bdc:	e8 00 17 00 00       	call   801052e1 <memcmp>
80103be1:	83 c4 10             	add    $0x10,%esp
80103be4:	85 c0                	test   %eax,%eax
80103be6:	74 07                	je     80103bef <mpconfig+0x5d>
    return 0;
80103be8:	b8 00 00 00 00       	mov    $0x0,%eax
80103bed:	eb 4c                	jmp    80103c3b <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
80103bef:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bf2:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103bf6:	3c 01                	cmp    $0x1,%al
80103bf8:	74 12                	je     80103c0c <mpconfig+0x7a>
80103bfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bfd:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c01:	3c 04                	cmp    $0x4,%al
80103c03:	74 07                	je     80103c0c <mpconfig+0x7a>
    return 0;
80103c05:	b8 00 00 00 00       	mov    $0x0,%eax
80103c0a:	eb 2f                	jmp    80103c3b <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
80103c0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c0f:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c13:	0f b7 c0             	movzwl %ax,%eax
80103c16:	83 ec 08             	sub    $0x8,%esp
80103c19:	50                   	push   %eax
80103c1a:	ff 75 f0             	pushl  -0x10(%ebp)
80103c1d:	e8 10 fe ff ff       	call   80103a32 <sum>
80103c22:	83 c4 10             	add    $0x10,%esp
80103c25:	84 c0                	test   %al,%al
80103c27:	74 07                	je     80103c30 <mpconfig+0x9e>
    return 0;
80103c29:	b8 00 00 00 00       	mov    $0x0,%eax
80103c2e:	eb 0b                	jmp    80103c3b <mpconfig+0xa9>
  *pmp = mp;
80103c30:	8b 45 08             	mov    0x8(%ebp),%eax
80103c33:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c36:	89 10                	mov    %edx,(%eax)
  return conf;
80103c38:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103c3b:	c9                   	leave  
80103c3c:	c3                   	ret    

80103c3d <mpinit>:

void
mpinit(void)
{
80103c3d:	55                   	push   %ebp
80103c3e:	89 e5                	mov    %esp,%ebp
80103c40:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103c43:	c7 05 64 b6 10 80 40 	movl   $0x80112440,0x8010b664
80103c4a:	24 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103c4d:	83 ec 0c             	sub    $0xc,%esp
80103c50:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103c53:	50                   	push   %eax
80103c54:	e8 39 ff ff ff       	call   80103b92 <mpconfig>
80103c59:	83 c4 10             	add    $0x10,%esp
80103c5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c5f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103c63:	75 05                	jne    80103c6a <mpinit+0x2d>
    return;
80103c65:	e9 94 01 00 00       	jmp    80103dfe <mpinit+0x1c1>
  ismp = 1;
80103c6a:	c7 05 04 24 11 80 01 	movl   $0x1,0x80112404
80103c71:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c77:	8b 40 24             	mov    0x24(%eax),%eax
80103c7a:	a3 dc 22 11 80       	mov    %eax,0x801122dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103c7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c82:	83 c0 2c             	add    $0x2c,%eax
80103c85:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c8b:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c8f:	0f b7 d0             	movzwl %ax,%edx
80103c92:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c95:	01 d0                	add    %edx,%eax
80103c97:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c9a:	e9 f2 00 00 00       	jmp    80103d91 <mpinit+0x154>
    switch(*p){
80103c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca2:	0f b6 00             	movzbl (%eax),%eax
80103ca5:	0f b6 c0             	movzbl %al,%eax
80103ca8:	83 f8 04             	cmp    $0x4,%eax
80103cab:	0f 87 bc 00 00 00    	ja     80103d6d <mpinit+0x130>
80103cb1:	8b 04 85 b4 88 10 80 	mov    -0x7fef774c(,%eax,4),%eax
80103cb8:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cbd:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103cc0:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103cc3:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cc7:	0f b6 d0             	movzbl %al,%edx
80103cca:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80103ccf:	39 c2                	cmp    %eax,%edx
80103cd1:	74 2b                	je     80103cfe <mpinit+0xc1>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103cd3:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103cd6:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cda:	0f b6 d0             	movzbl %al,%edx
80103cdd:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80103ce2:	83 ec 04             	sub    $0x4,%esp
80103ce5:	52                   	push   %edx
80103ce6:	50                   	push   %eax
80103ce7:	68 76 88 10 80       	push   $0x80108876
80103cec:	e8 ce c6 ff ff       	call   801003bf <cprintf>
80103cf1:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103cf4:	c7 05 04 24 11 80 00 	movl   $0x0,0x80112404
80103cfb:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103cfe:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d01:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103d05:	0f b6 c0             	movzbl %al,%eax
80103d08:	83 e0 02             	and    $0x2,%eax
80103d0b:	85 c0                	test   %eax,%eax
80103d0d:	74 15                	je     80103d24 <mpinit+0xe7>
        bcpu = &cpus[ncpu];
80103d0f:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80103d14:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d1a:	05 40 24 11 80       	add    $0x80112440,%eax
80103d1f:	a3 64 b6 10 80       	mov    %eax,0x8010b664
      cpus[ncpu].id = ncpu;
80103d24:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80103d29:	8b 15 20 2a 11 80    	mov    0x80112a20,%edx
80103d2f:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d35:	05 40 24 11 80       	add    $0x80112440,%eax
80103d3a:	88 10                	mov    %dl,(%eax)
      ncpu++;
80103d3c:	a1 20 2a 11 80       	mov    0x80112a20,%eax
80103d41:	83 c0 01             	add    $0x1,%eax
80103d44:	a3 20 2a 11 80       	mov    %eax,0x80112a20
      p += sizeof(struct mpproc);
80103d49:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103d4d:	eb 42                	jmp    80103d91 <mpinit+0x154>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103d55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103d58:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d5c:	a2 00 24 11 80       	mov    %al,0x80112400
      p += sizeof(struct mpioapic);
80103d61:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d65:	eb 2a                	jmp    80103d91 <mpinit+0x154>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103d67:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d6b:	eb 24                	jmp    80103d91 <mpinit+0x154>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103d6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d70:	0f b6 00             	movzbl (%eax),%eax
80103d73:	0f b6 c0             	movzbl %al,%eax
80103d76:	83 ec 08             	sub    $0x8,%esp
80103d79:	50                   	push   %eax
80103d7a:	68 94 88 10 80       	push   $0x80108894
80103d7f:	e8 3b c6 ff ff       	call   801003bf <cprintf>
80103d84:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103d87:	c7 05 04 24 11 80 00 	movl   $0x0,0x80112404
80103d8e:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d94:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103d97:	0f 82 02 ff ff ff    	jb     80103c9f <mpinit+0x62>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103d9d:	a1 04 24 11 80       	mov    0x80112404,%eax
80103da2:	85 c0                	test   %eax,%eax
80103da4:	75 1d                	jne    80103dc3 <mpinit+0x186>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103da6:	c7 05 20 2a 11 80 01 	movl   $0x1,0x80112a20
80103dad:	00 00 00 
    lapic = 0;
80103db0:	c7 05 dc 22 11 80 00 	movl   $0x0,0x801122dc
80103db7:	00 00 00 
    ioapicid = 0;
80103dba:	c6 05 00 24 11 80 00 	movb   $0x0,0x80112400
    return;
80103dc1:	eb 3b                	jmp    80103dfe <mpinit+0x1c1>
  }

  if(mp->imcrp){
80103dc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103dc6:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103dca:	84 c0                	test   %al,%al
80103dcc:	74 30                	je     80103dfe <mpinit+0x1c1>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103dce:	83 ec 08             	sub    $0x8,%esp
80103dd1:	6a 70                	push   $0x70
80103dd3:	6a 22                	push   $0x22
80103dd5:	e8 1c fc ff ff       	call   801039f6 <outb>
80103dda:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103ddd:	83 ec 0c             	sub    $0xc,%esp
80103de0:	6a 23                	push   $0x23
80103de2:	e8 f2 fb ff ff       	call   801039d9 <inb>
80103de7:	83 c4 10             	add    $0x10,%esp
80103dea:	83 c8 01             	or     $0x1,%eax
80103ded:	0f b6 c0             	movzbl %al,%eax
80103df0:	83 ec 08             	sub    $0x8,%esp
80103df3:	50                   	push   %eax
80103df4:	6a 23                	push   $0x23
80103df6:	e8 fb fb ff ff       	call   801039f6 <outb>
80103dfb:	83 c4 10             	add    $0x10,%esp
  }
}
80103dfe:	c9                   	leave  
80103dff:	c3                   	ret    

80103e00 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103e00:	55                   	push   %ebp
80103e01:	89 e5                	mov    %esp,%ebp
80103e03:	83 ec 08             	sub    $0x8,%esp
80103e06:	8b 55 08             	mov    0x8(%ebp),%edx
80103e09:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e0c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103e10:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103e13:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103e17:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103e1b:	ee                   	out    %al,(%dx)
}
80103e1c:	c9                   	leave  
80103e1d:	c3                   	ret    

80103e1e <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103e1e:	55                   	push   %ebp
80103e1f:	89 e5                	mov    %esp,%ebp
80103e21:	83 ec 04             	sub    $0x4,%esp
80103e24:	8b 45 08             	mov    0x8(%ebp),%eax
80103e27:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103e2b:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e2f:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103e35:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e39:	0f b6 c0             	movzbl %al,%eax
80103e3c:	50                   	push   %eax
80103e3d:	6a 21                	push   $0x21
80103e3f:	e8 bc ff ff ff       	call   80103e00 <outb>
80103e44:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103e47:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e4b:	66 c1 e8 08          	shr    $0x8,%ax
80103e4f:	0f b6 c0             	movzbl %al,%eax
80103e52:	50                   	push   %eax
80103e53:	68 a1 00 00 00       	push   $0xa1
80103e58:	e8 a3 ff ff ff       	call   80103e00 <outb>
80103e5d:	83 c4 08             	add    $0x8,%esp
}
80103e60:	c9                   	leave  
80103e61:	c3                   	ret    

80103e62 <picenable>:

void
picenable(int irq)
{
80103e62:	55                   	push   %ebp
80103e63:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103e65:	8b 45 08             	mov    0x8(%ebp),%eax
80103e68:	ba 01 00 00 00       	mov    $0x1,%edx
80103e6d:	89 c1                	mov    %eax,%ecx
80103e6f:	d3 e2                	shl    %cl,%edx
80103e71:	89 d0                	mov    %edx,%eax
80103e73:	f7 d0                	not    %eax
80103e75:	89 c2                	mov    %eax,%edx
80103e77:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103e7e:	21 d0                	and    %edx,%eax
80103e80:	0f b7 c0             	movzwl %ax,%eax
80103e83:	50                   	push   %eax
80103e84:	e8 95 ff ff ff       	call   80103e1e <picsetmask>
80103e89:	83 c4 04             	add    $0x4,%esp
}
80103e8c:	c9                   	leave  
80103e8d:	c3                   	ret    

80103e8e <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103e8e:	55                   	push   %ebp
80103e8f:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103e91:	68 ff 00 00 00       	push   $0xff
80103e96:	6a 21                	push   $0x21
80103e98:	e8 63 ff ff ff       	call   80103e00 <outb>
80103e9d:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103ea0:	68 ff 00 00 00       	push   $0xff
80103ea5:	68 a1 00 00 00       	push   $0xa1
80103eaa:	e8 51 ff ff ff       	call   80103e00 <outb>
80103eaf:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103eb2:	6a 11                	push   $0x11
80103eb4:	6a 20                	push   $0x20
80103eb6:	e8 45 ff ff ff       	call   80103e00 <outb>
80103ebb:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103ebe:	6a 20                	push   $0x20
80103ec0:	6a 21                	push   $0x21
80103ec2:	e8 39 ff ff ff       	call   80103e00 <outb>
80103ec7:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103eca:	6a 04                	push   $0x4
80103ecc:	6a 21                	push   $0x21
80103ece:	e8 2d ff ff ff       	call   80103e00 <outb>
80103ed3:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103ed6:	6a 03                	push   $0x3
80103ed8:	6a 21                	push   $0x21
80103eda:	e8 21 ff ff ff       	call   80103e00 <outb>
80103edf:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103ee2:	6a 11                	push   $0x11
80103ee4:	68 a0 00 00 00       	push   $0xa0
80103ee9:	e8 12 ff ff ff       	call   80103e00 <outb>
80103eee:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103ef1:	6a 28                	push   $0x28
80103ef3:	68 a1 00 00 00       	push   $0xa1
80103ef8:	e8 03 ff ff ff       	call   80103e00 <outb>
80103efd:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103f00:	6a 02                	push   $0x2
80103f02:	68 a1 00 00 00       	push   $0xa1
80103f07:	e8 f4 fe ff ff       	call   80103e00 <outb>
80103f0c:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103f0f:	6a 03                	push   $0x3
80103f11:	68 a1 00 00 00       	push   $0xa1
80103f16:	e8 e5 fe ff ff       	call   80103e00 <outb>
80103f1b:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103f1e:	6a 68                	push   $0x68
80103f20:	6a 20                	push   $0x20
80103f22:	e8 d9 fe ff ff       	call   80103e00 <outb>
80103f27:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103f2a:	6a 0a                	push   $0xa
80103f2c:	6a 20                	push   $0x20
80103f2e:	e8 cd fe ff ff       	call   80103e00 <outb>
80103f33:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103f36:	6a 68                	push   $0x68
80103f38:	68 a0 00 00 00       	push   $0xa0
80103f3d:	e8 be fe ff ff       	call   80103e00 <outb>
80103f42:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103f45:	6a 0a                	push   $0xa
80103f47:	68 a0 00 00 00       	push   $0xa0
80103f4c:	e8 af fe ff ff       	call   80103e00 <outb>
80103f51:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103f54:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f5b:	66 83 f8 ff          	cmp    $0xffff,%ax
80103f5f:	74 13                	je     80103f74 <picinit+0xe6>
    picsetmask(irqmask);
80103f61:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103f68:	0f b7 c0             	movzwl %ax,%eax
80103f6b:	50                   	push   %eax
80103f6c:	e8 ad fe ff ff       	call   80103e1e <picsetmask>
80103f71:	83 c4 04             	add    $0x4,%esp
}
80103f74:	c9                   	leave  
80103f75:	c3                   	ret    

80103f76 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103f76:	55                   	push   %ebp
80103f77:	89 e5                	mov    %esp,%ebp
80103f79:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103f7c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103f83:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f86:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f8f:	8b 10                	mov    (%eax),%edx
80103f91:	8b 45 08             	mov    0x8(%ebp),%eax
80103f94:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103f96:	e8 d8 cf ff ff       	call   80100f73 <filealloc>
80103f9b:	89 c2                	mov    %eax,%edx
80103f9d:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa0:	89 10                	mov    %edx,(%eax)
80103fa2:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa5:	8b 00                	mov    (%eax),%eax
80103fa7:	85 c0                	test   %eax,%eax
80103fa9:	0f 84 cb 00 00 00    	je     8010407a <pipealloc+0x104>
80103faf:	e8 bf cf ff ff       	call   80100f73 <filealloc>
80103fb4:	89 c2                	mov    %eax,%edx
80103fb6:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fb9:	89 10                	mov    %edx,(%eax)
80103fbb:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fbe:	8b 00                	mov    (%eax),%eax
80103fc0:	85 c0                	test   %eax,%eax
80103fc2:	0f 84 b2 00 00 00    	je     8010407a <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103fc8:	e8 db eb ff ff       	call   80102ba8 <kalloc>
80103fcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103fd0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103fd4:	75 05                	jne    80103fdb <pipealloc+0x65>
    goto bad;
80103fd6:	e9 9f 00 00 00       	jmp    8010407a <pipealloc+0x104>
  p->readopen = 1;
80103fdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fde:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103fe5:	00 00 00 
  p->writeopen = 1;
80103fe8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103feb:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103ff2:	00 00 00 
  p->nwrite = 0;
80103ff5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ff8:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103fff:	00 00 00 
  p->nread = 0;
80104002:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104005:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010400c:	00 00 00 
  initlock(&p->lock, "pipe");
8010400f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104012:	83 ec 08             	sub    $0x8,%esp
80104015:	68 c8 88 10 80       	push   $0x801088c8
8010401a:	50                   	push   %eax
8010401b:	e8 dd 0f 00 00       	call   80104ffd <initlock>
80104020:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104023:	8b 45 08             	mov    0x8(%ebp),%eax
80104026:	8b 00                	mov    (%eax),%eax
80104028:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010402e:	8b 45 08             	mov    0x8(%ebp),%eax
80104031:	8b 00                	mov    (%eax),%eax
80104033:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104037:	8b 45 08             	mov    0x8(%ebp),%eax
8010403a:	8b 00                	mov    (%eax),%eax
8010403c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104040:	8b 45 08             	mov    0x8(%ebp),%eax
80104043:	8b 00                	mov    (%eax),%eax
80104045:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104048:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010404b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010404e:	8b 00                	mov    (%eax),%eax
80104050:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104056:	8b 45 0c             	mov    0xc(%ebp),%eax
80104059:	8b 00                	mov    (%eax),%eax
8010405b:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010405f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104062:	8b 00                	mov    (%eax),%eax
80104064:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104068:	8b 45 0c             	mov    0xc(%ebp),%eax
8010406b:	8b 00                	mov    (%eax),%eax
8010406d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104070:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104073:	b8 00 00 00 00       	mov    $0x0,%eax
80104078:	eb 4d                	jmp    801040c7 <pipealloc+0x151>

//PAGEBREAK: 20
 bad:
  if(p)
8010407a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010407e:	74 0e                	je     8010408e <pipealloc+0x118>
    kfree((char*)p);
80104080:	83 ec 0c             	sub    $0xc,%esp
80104083:	ff 75 f4             	pushl  -0xc(%ebp)
80104086:	e8 81 ea ff ff       	call   80102b0c <kfree>
8010408b:	83 c4 10             	add    $0x10,%esp
  if(*f0)
8010408e:	8b 45 08             	mov    0x8(%ebp),%eax
80104091:	8b 00                	mov    (%eax),%eax
80104093:	85 c0                	test   %eax,%eax
80104095:	74 11                	je     801040a8 <pipealloc+0x132>
    fileclose(*f0);
80104097:	8b 45 08             	mov    0x8(%ebp),%eax
8010409a:	8b 00                	mov    (%eax),%eax
8010409c:	83 ec 0c             	sub    $0xc,%esp
8010409f:	50                   	push   %eax
801040a0:	e8 8b cf ff ff       	call   80101030 <fileclose>
801040a5:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801040a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801040ab:	8b 00                	mov    (%eax),%eax
801040ad:	85 c0                	test   %eax,%eax
801040af:	74 11                	je     801040c2 <pipealloc+0x14c>
    fileclose(*f1);
801040b1:	8b 45 0c             	mov    0xc(%ebp),%eax
801040b4:	8b 00                	mov    (%eax),%eax
801040b6:	83 ec 0c             	sub    $0xc,%esp
801040b9:	50                   	push   %eax
801040ba:	e8 71 cf ff ff       	call   80101030 <fileclose>
801040bf:	83 c4 10             	add    $0x10,%esp
  return -1;
801040c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040c7:	c9                   	leave  
801040c8:	c3                   	ret    

801040c9 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801040c9:	55                   	push   %ebp
801040ca:	89 e5                	mov    %esp,%ebp
801040cc:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
801040cf:	8b 45 08             	mov    0x8(%ebp),%eax
801040d2:	83 ec 0c             	sub    $0xc,%esp
801040d5:	50                   	push   %eax
801040d6:	e8 43 0f 00 00       	call   8010501e <acquire>
801040db:	83 c4 10             	add    $0x10,%esp
  if(writable){
801040de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801040e2:	74 23                	je     80104107 <pipeclose+0x3e>
    p->writeopen = 0;
801040e4:	8b 45 08             	mov    0x8(%ebp),%eax
801040e7:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801040ee:	00 00 00 
    wakeup(&p->nread);
801040f1:	8b 45 08             	mov    0x8(%ebp),%eax
801040f4:	05 34 02 00 00       	add    $0x234,%eax
801040f9:	83 ec 0c             	sub    $0xc,%esp
801040fc:	50                   	push   %eax
801040fd:	e8 2a 0c 00 00       	call   80104d2c <wakeup>
80104102:	83 c4 10             	add    $0x10,%esp
80104105:	eb 21                	jmp    80104128 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104107:	8b 45 08             	mov    0x8(%ebp),%eax
8010410a:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104111:	00 00 00 
    wakeup(&p->nwrite);
80104114:	8b 45 08             	mov    0x8(%ebp),%eax
80104117:	05 38 02 00 00       	add    $0x238,%eax
8010411c:	83 ec 0c             	sub    $0xc,%esp
8010411f:	50                   	push   %eax
80104120:	e8 07 0c 00 00       	call   80104d2c <wakeup>
80104125:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104128:	8b 45 08             	mov    0x8(%ebp),%eax
8010412b:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104131:	85 c0                	test   %eax,%eax
80104133:	75 2c                	jne    80104161 <pipeclose+0x98>
80104135:	8b 45 08             	mov    0x8(%ebp),%eax
80104138:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010413e:	85 c0                	test   %eax,%eax
80104140:	75 1f                	jne    80104161 <pipeclose+0x98>
    release(&p->lock);
80104142:	8b 45 08             	mov    0x8(%ebp),%eax
80104145:	83 ec 0c             	sub    $0xc,%esp
80104148:	50                   	push   %eax
80104149:	e8 36 0f 00 00       	call   80105084 <release>
8010414e:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80104151:	83 ec 0c             	sub    $0xc,%esp
80104154:	ff 75 08             	pushl  0x8(%ebp)
80104157:	e8 b0 e9 ff ff       	call   80102b0c <kfree>
8010415c:	83 c4 10             	add    $0x10,%esp
8010415f:	eb 0f                	jmp    80104170 <pipeclose+0xa7>
  } else
    release(&p->lock);
80104161:	8b 45 08             	mov    0x8(%ebp),%eax
80104164:	83 ec 0c             	sub    $0xc,%esp
80104167:	50                   	push   %eax
80104168:	e8 17 0f 00 00       	call   80105084 <release>
8010416d:	83 c4 10             	add    $0x10,%esp
}
80104170:	c9                   	leave  
80104171:	c3                   	ret    

80104172 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104172:	55                   	push   %ebp
80104173:	89 e5                	mov    %esp,%ebp
80104175:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
80104178:	8b 45 08             	mov    0x8(%ebp),%eax
8010417b:	83 ec 0c             	sub    $0xc,%esp
8010417e:	50                   	push   %eax
8010417f:	e8 9a 0e 00 00       	call   8010501e <acquire>
80104184:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104187:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010418e:	e9 af 00 00 00       	jmp    80104242 <pipewrite+0xd0>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104193:	eb 60                	jmp    801041f5 <pipewrite+0x83>
      if(p->readopen == 0 || proc->killed){
80104195:	8b 45 08             	mov    0x8(%ebp),%eax
80104198:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010419e:	85 c0                	test   %eax,%eax
801041a0:	74 0d                	je     801041af <pipewrite+0x3d>
801041a2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801041a8:	8b 40 24             	mov    0x24(%eax),%eax
801041ab:	85 c0                	test   %eax,%eax
801041ad:	74 19                	je     801041c8 <pipewrite+0x56>
        release(&p->lock);
801041af:	8b 45 08             	mov    0x8(%ebp),%eax
801041b2:	83 ec 0c             	sub    $0xc,%esp
801041b5:	50                   	push   %eax
801041b6:	e8 c9 0e 00 00       	call   80105084 <release>
801041bb:	83 c4 10             	add    $0x10,%esp
        return -1;
801041be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041c3:	e9 ac 00 00 00       	jmp    80104274 <pipewrite+0x102>
      }
      wakeup(&p->nread);
801041c8:	8b 45 08             	mov    0x8(%ebp),%eax
801041cb:	05 34 02 00 00       	add    $0x234,%eax
801041d0:	83 ec 0c             	sub    $0xc,%esp
801041d3:	50                   	push   %eax
801041d4:	e8 53 0b 00 00       	call   80104d2c <wakeup>
801041d9:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041dc:	8b 45 08             	mov    0x8(%ebp),%eax
801041df:	8b 55 08             	mov    0x8(%ebp),%edx
801041e2:	81 c2 38 02 00 00    	add    $0x238,%edx
801041e8:	83 ec 08             	sub    $0x8,%esp
801041eb:	50                   	push   %eax
801041ec:	52                   	push   %edx
801041ed:	e8 51 0a 00 00       	call   80104c43 <sleep>
801041f2:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041f5:	8b 45 08             	mov    0x8(%ebp),%eax
801041f8:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801041fe:	8b 45 08             	mov    0x8(%ebp),%eax
80104201:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104207:	05 00 02 00 00       	add    $0x200,%eax
8010420c:	39 c2                	cmp    %eax,%edx
8010420e:	74 85                	je     80104195 <pipewrite+0x23>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104210:	8b 45 08             	mov    0x8(%ebp),%eax
80104213:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104219:	8d 48 01             	lea    0x1(%eax),%ecx
8010421c:	8b 55 08             	mov    0x8(%ebp),%edx
8010421f:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104225:	25 ff 01 00 00       	and    $0x1ff,%eax
8010422a:	89 c1                	mov    %eax,%ecx
8010422c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010422f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104232:	01 d0                	add    %edx,%eax
80104234:	0f b6 10             	movzbl (%eax),%edx
80104237:	8b 45 08             	mov    0x8(%ebp),%eax
8010423a:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010423e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104242:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104245:	3b 45 10             	cmp    0x10(%ebp),%eax
80104248:	0f 8c 45 ff ff ff    	jl     80104193 <pipewrite+0x21>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010424e:	8b 45 08             	mov    0x8(%ebp),%eax
80104251:	05 34 02 00 00       	add    $0x234,%eax
80104256:	83 ec 0c             	sub    $0xc,%esp
80104259:	50                   	push   %eax
8010425a:	e8 cd 0a 00 00       	call   80104d2c <wakeup>
8010425f:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104262:	8b 45 08             	mov    0x8(%ebp),%eax
80104265:	83 ec 0c             	sub    $0xc,%esp
80104268:	50                   	push   %eax
80104269:	e8 16 0e 00 00       	call   80105084 <release>
8010426e:	83 c4 10             	add    $0x10,%esp
  return n;
80104271:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104274:	c9                   	leave  
80104275:	c3                   	ret    

80104276 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104276:	55                   	push   %ebp
80104277:	89 e5                	mov    %esp,%ebp
80104279:	53                   	push   %ebx
8010427a:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
8010427d:	8b 45 08             	mov    0x8(%ebp),%eax
80104280:	83 ec 0c             	sub    $0xc,%esp
80104283:	50                   	push   %eax
80104284:	e8 95 0d 00 00       	call   8010501e <acquire>
80104289:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010428c:	eb 3f                	jmp    801042cd <piperead+0x57>
    if(proc->killed){
8010428e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104294:	8b 40 24             	mov    0x24(%eax),%eax
80104297:	85 c0                	test   %eax,%eax
80104299:	74 19                	je     801042b4 <piperead+0x3e>
      release(&p->lock);
8010429b:	8b 45 08             	mov    0x8(%ebp),%eax
8010429e:	83 ec 0c             	sub    $0xc,%esp
801042a1:	50                   	push   %eax
801042a2:	e8 dd 0d 00 00       	call   80105084 <release>
801042a7:	83 c4 10             	add    $0x10,%esp
      return -1;
801042aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042af:	e9 be 00 00 00       	jmp    80104372 <piperead+0xfc>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801042b4:	8b 45 08             	mov    0x8(%ebp),%eax
801042b7:	8b 55 08             	mov    0x8(%ebp),%edx
801042ba:	81 c2 34 02 00 00    	add    $0x234,%edx
801042c0:	83 ec 08             	sub    $0x8,%esp
801042c3:	50                   	push   %eax
801042c4:	52                   	push   %edx
801042c5:	e8 79 09 00 00       	call   80104c43 <sleep>
801042ca:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042cd:	8b 45 08             	mov    0x8(%ebp),%eax
801042d0:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801042d6:	8b 45 08             	mov    0x8(%ebp),%eax
801042d9:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042df:	39 c2                	cmp    %eax,%edx
801042e1:	75 0d                	jne    801042f0 <piperead+0x7a>
801042e3:	8b 45 08             	mov    0x8(%ebp),%eax
801042e6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801042ec:	85 c0                	test   %eax,%eax
801042ee:	75 9e                	jne    8010428e <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801042f7:	eb 4b                	jmp    80104344 <piperead+0xce>
    if(p->nread == p->nwrite)
801042f9:	8b 45 08             	mov    0x8(%ebp),%eax
801042fc:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104302:	8b 45 08             	mov    0x8(%ebp),%eax
80104305:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010430b:	39 c2                	cmp    %eax,%edx
8010430d:	75 02                	jne    80104311 <piperead+0x9b>
      break;
8010430f:	eb 3b                	jmp    8010434c <piperead+0xd6>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104311:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104314:	8b 45 0c             	mov    0xc(%ebp),%eax
80104317:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010431a:	8b 45 08             	mov    0x8(%ebp),%eax
8010431d:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104323:	8d 48 01             	lea    0x1(%eax),%ecx
80104326:	8b 55 08             	mov    0x8(%ebp),%edx
80104329:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010432f:	25 ff 01 00 00       	and    $0x1ff,%eax
80104334:	89 c2                	mov    %eax,%edx
80104336:	8b 45 08             	mov    0x8(%ebp),%eax
80104339:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
8010433e:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104340:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104344:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104347:	3b 45 10             	cmp    0x10(%ebp),%eax
8010434a:	7c ad                	jl     801042f9 <piperead+0x83>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010434c:	8b 45 08             	mov    0x8(%ebp),%eax
8010434f:	05 38 02 00 00       	add    $0x238,%eax
80104354:	83 ec 0c             	sub    $0xc,%esp
80104357:	50                   	push   %eax
80104358:	e8 cf 09 00 00       	call   80104d2c <wakeup>
8010435d:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104360:	8b 45 08             	mov    0x8(%ebp),%eax
80104363:	83 ec 0c             	sub    $0xc,%esp
80104366:	50                   	push   %eax
80104367:	e8 18 0d 00 00       	call   80105084 <release>
8010436c:	83 c4 10             	add    $0x10,%esp
  return i;
8010436f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104372:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104375:	c9                   	leave  
80104376:	c3                   	ret    

80104377 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104377:	55                   	push   %ebp
80104378:	89 e5                	mov    %esp,%ebp
8010437a:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010437d:	9c                   	pushf  
8010437e:	58                   	pop    %eax
8010437f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104382:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104385:	c9                   	leave  
80104386:	c3                   	ret    

80104387 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80104387:	55                   	push   %ebp
80104388:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010438a:	fb                   	sti    
}
8010438b:	5d                   	pop    %ebp
8010438c:	c3                   	ret    

8010438d <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
8010438d:	55                   	push   %ebp
8010438e:	89 e5                	mov    %esp,%ebp
80104390:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
80104393:	83 ec 08             	sub    $0x8,%esp
80104396:	68 cd 88 10 80       	push   $0x801088cd
8010439b:	68 40 2a 11 80       	push   $0x80112a40
801043a0:	e8 58 0c 00 00       	call   80104ffd <initlock>
801043a5:	83 c4 10             	add    $0x10,%esp
}
801043a8:	c9                   	leave  
801043a9:	c3                   	ret    

801043aa <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801043aa:	55                   	push   %ebp
801043ab:	89 e5                	mov    %esp,%ebp
801043ad:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801043b0:	83 ec 0c             	sub    $0xc,%esp
801043b3:	68 40 2a 11 80       	push   $0x80112a40
801043b8:	e8 61 0c 00 00       	call   8010501e <acquire>
801043bd:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043c0:	c7 45 f4 74 2a 11 80 	movl   $0x80112a74,-0xc(%ebp)
801043c7:	eb 56                	jmp    8010441f <allocproc+0x75>
    if(p->state == UNUSED)
801043c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043cc:	8b 40 0c             	mov    0xc(%eax),%eax
801043cf:	85 c0                	test   %eax,%eax
801043d1:	75 48                	jne    8010441b <allocproc+0x71>
      goto found;
801043d3:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801043d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d7:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801043de:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801043e3:	8d 50 01             	lea    0x1(%eax),%edx
801043e6:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
801043ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043ef:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
801043f2:	83 ec 0c             	sub    $0xc,%esp
801043f5:	68 40 2a 11 80       	push   $0x80112a40
801043fa:	e8 85 0c 00 00       	call   80105084 <release>
801043ff:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104402:	e8 a1 e7 ff ff       	call   80102ba8 <kalloc>
80104407:	89 c2                	mov    %eax,%edx
80104409:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010440c:	89 50 08             	mov    %edx,0x8(%eax)
8010440f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104412:	8b 40 08             	mov    0x8(%eax),%eax
80104415:	85 c0                	test   %eax,%eax
80104417:	75 37                	jne    80104450 <allocproc+0xa6>
80104419:	eb 24                	jmp    8010443f <allocproc+0x95>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010441b:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
8010441f:	81 7d f4 74 4a 11 80 	cmpl   $0x80114a74,-0xc(%ebp)
80104426:	72 a1                	jb     801043c9 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
80104428:	83 ec 0c             	sub    $0xc,%esp
8010442b:	68 40 2a 11 80       	push   $0x80112a40
80104430:	e8 4f 0c 00 00       	call   80105084 <release>
80104435:	83 c4 10             	add    $0x10,%esp
  return 0;
80104438:	b8 00 00 00 00       	mov    $0x0,%eax
8010443d:	eb 6e                	jmp    801044ad <allocproc+0x103>
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
8010443f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104442:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104449:	b8 00 00 00 00       	mov    $0x0,%eax
8010444e:	eb 5d                	jmp    801044ad <allocproc+0x103>
  }
  sp = p->kstack + KSTACKSIZE;
80104450:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104453:	8b 40 08             	mov    0x8(%eax),%eax
80104456:	05 00 10 00 00       	add    $0x1000,%eax
8010445b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010445e:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80104462:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104465:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104468:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
8010446b:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
8010446f:	ba f9 66 10 80       	mov    $0x801066f9,%edx
80104474:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104477:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104479:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
8010447d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104480:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104483:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104486:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104489:	8b 40 1c             	mov    0x1c(%eax),%eax
8010448c:	83 ec 04             	sub    $0x4,%esp
8010448f:	6a 14                	push   $0x14
80104491:	6a 00                	push   $0x0
80104493:	50                   	push   %eax
80104494:	e8 e1 0d 00 00       	call   8010527a <memset>
80104499:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010449c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449f:	8b 40 1c             	mov    0x1c(%eax),%eax
801044a2:	ba 13 4c 10 80       	mov    $0x80104c13,%edx
801044a7:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
801044aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801044ad:	c9                   	leave  
801044ae:	c3                   	ret    

801044af <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801044af:	55                   	push   %ebp
801044b0:	89 e5                	mov    %esp,%ebp
801044b2:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
801044b5:	e8 f0 fe ff ff       	call   801043aa <allocproc>
801044ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
801044bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c0:	a3 68 b6 10 80       	mov    %eax,0x8010b668
  if((p->pgdir = setupkvm()) == 0)
801044c5:	e8 08 39 00 00       	call   80107dd2 <setupkvm>
801044ca:	89 c2                	mov    %eax,%edx
801044cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044cf:	89 50 04             	mov    %edx,0x4(%eax)
801044d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044d5:	8b 40 04             	mov    0x4(%eax),%eax
801044d8:	85 c0                	test   %eax,%eax
801044da:	75 0d                	jne    801044e9 <userinit+0x3a>
    panic("userinit: out of memory?");
801044dc:	83 ec 0c             	sub    $0xc,%esp
801044df:	68 d4 88 10 80       	push   $0x801088d4
801044e4:	e8 73 c0 ff ff       	call   8010055c <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801044e9:	ba 2c 00 00 00       	mov    $0x2c,%edx
801044ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f1:	8b 40 04             	mov    0x4(%eax),%eax
801044f4:	83 ec 04             	sub    $0x4,%esp
801044f7:	52                   	push   %edx
801044f8:	68 00 b5 10 80       	push   $0x8010b500
801044fd:	50                   	push   %eax
801044fe:	e8 26 3b 00 00       	call   80108029 <inituvm>
80104503:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104506:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104509:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
8010450f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104512:	8b 40 18             	mov    0x18(%eax),%eax
80104515:	83 ec 04             	sub    $0x4,%esp
80104518:	6a 4c                	push   $0x4c
8010451a:	6a 00                	push   $0x0
8010451c:	50                   	push   %eax
8010451d:	e8 58 0d 00 00       	call   8010527a <memset>
80104522:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104528:	8b 40 18             	mov    0x18(%eax),%eax
8010452b:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104531:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104534:	8b 40 18             	mov    0x18(%eax),%eax
80104537:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010453d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104540:	8b 40 18             	mov    0x18(%eax),%eax
80104543:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104546:	8b 52 18             	mov    0x18(%edx),%edx
80104549:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010454d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104551:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104554:	8b 40 18             	mov    0x18(%eax),%eax
80104557:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010455a:	8b 52 18             	mov    0x18(%edx),%edx
8010455d:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104561:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104565:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104568:	8b 40 18             	mov    0x18(%eax),%eax
8010456b:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104572:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104575:	8b 40 18             	mov    0x18(%eax),%eax
80104578:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010457f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104582:	8b 40 18             	mov    0x18(%eax),%eax
80104585:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010458c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458f:	83 c0 6c             	add    $0x6c,%eax
80104592:	83 ec 04             	sub    $0x4,%esp
80104595:	6a 10                	push   $0x10
80104597:	68 ed 88 10 80       	push   $0x801088ed
8010459c:	50                   	push   %eax
8010459d:	e8 dd 0e 00 00       	call   8010547f <safestrcpy>
801045a2:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
801045a5:	83 ec 0c             	sub    $0xc,%esp
801045a8:	68 f6 88 10 80       	push   $0x801088f6
801045ad:	e8 02 df ff ff       	call   801024b4 <namei>
801045b2:	83 c4 10             	add    $0x10,%esp
801045b5:	89 c2                	mov    %eax,%edx
801045b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ba:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
801045bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045c0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
801045c7:	c9                   	leave  
801045c8:	c3                   	ret    

801045c9 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801045c9:	55                   	push   %ebp
801045ca:	89 e5                	mov    %esp,%ebp
801045cc:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
801045cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045d5:	8b 00                	mov    (%eax),%eax
801045d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
801045da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801045de:	7e 31                	jle    80104611 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801045e0:	8b 55 08             	mov    0x8(%ebp),%edx
801045e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e6:	01 c2                	add    %eax,%edx
801045e8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045ee:	8b 40 04             	mov    0x4(%eax),%eax
801045f1:	83 ec 04             	sub    $0x4,%esp
801045f4:	52                   	push   %edx
801045f5:	ff 75 f4             	pushl  -0xc(%ebp)
801045f8:	50                   	push   %eax
801045f9:	e8 77 3b 00 00       	call   80108175 <allocuvm>
801045fe:	83 c4 10             	add    $0x10,%esp
80104601:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104604:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104608:	75 3e                	jne    80104648 <growproc+0x7f>
      return -1;
8010460a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010460f:	eb 59                	jmp    8010466a <growproc+0xa1>
  } else if(n < 0){
80104611:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104615:	79 31                	jns    80104648 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104617:	8b 55 08             	mov    0x8(%ebp),%edx
8010461a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461d:	01 c2                	add    %eax,%edx
8010461f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104625:	8b 40 04             	mov    0x4(%eax),%eax
80104628:	83 ec 04             	sub    $0x4,%esp
8010462b:	52                   	push   %edx
8010462c:	ff 75 f4             	pushl  -0xc(%ebp)
8010462f:	50                   	push   %eax
80104630:	e8 09 3c 00 00       	call   8010823e <deallocuvm>
80104635:	83 c4 10             	add    $0x10,%esp
80104638:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010463b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010463f:	75 07                	jne    80104648 <growproc+0x7f>
      return -1;
80104641:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104646:	eb 22                	jmp    8010466a <growproc+0xa1>
  }
  proc->sz = sz;
80104648:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010464e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104651:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80104653:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104659:	83 ec 0c             	sub    $0xc,%esp
8010465c:	50                   	push   %eax
8010465d:	e8 55 38 00 00       	call   80107eb7 <switchuvm>
80104662:	83 c4 10             	add    $0x10,%esp
  return 0;
80104665:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010466a:	c9                   	leave  
8010466b:	c3                   	ret    

8010466c <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
8010466c:	55                   	push   %ebp
8010466d:	89 e5                	mov    %esp,%ebp
8010466f:	57                   	push   %edi
80104670:	56                   	push   %esi
80104671:	53                   	push   %ebx
80104672:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
80104675:	e8 30 fd ff ff       	call   801043aa <allocproc>
8010467a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010467d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104681:	75 0a                	jne    8010468d <fork+0x21>
    return -1;
80104683:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104688:	e9 68 01 00 00       	jmp    801047f5 <fork+0x189>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010468d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104693:	8b 10                	mov    (%eax),%edx
80104695:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010469b:	8b 40 04             	mov    0x4(%eax),%eax
8010469e:	83 ec 08             	sub    $0x8,%esp
801046a1:	52                   	push   %edx
801046a2:	50                   	push   %eax
801046a3:	e8 32 3d 00 00       	call   801083da <copyuvm>
801046a8:	83 c4 10             	add    $0x10,%esp
801046ab:	89 c2                	mov    %eax,%edx
801046ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046b0:	89 50 04             	mov    %edx,0x4(%eax)
801046b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046b6:	8b 40 04             	mov    0x4(%eax),%eax
801046b9:	85 c0                	test   %eax,%eax
801046bb:	75 30                	jne    801046ed <fork+0x81>
    kfree(np->kstack);
801046bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046c0:	8b 40 08             	mov    0x8(%eax),%eax
801046c3:	83 ec 0c             	sub    $0xc,%esp
801046c6:	50                   	push   %eax
801046c7:	e8 40 e4 ff ff       	call   80102b0c <kfree>
801046cc:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
801046cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801046d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046dc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801046e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046e8:	e9 08 01 00 00       	jmp    801047f5 <fork+0x189>
  }
  np->sz = proc->sz;
801046ed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f3:	8b 10                	mov    (%eax),%edx
801046f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046f8:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
801046fa:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104701:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104704:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104707:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010470a:	8b 50 18             	mov    0x18(%eax),%edx
8010470d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104713:	8b 40 18             	mov    0x18(%eax),%eax
80104716:	89 c3                	mov    %eax,%ebx
80104718:	b8 13 00 00 00       	mov    $0x13,%eax
8010471d:	89 d7                	mov    %edx,%edi
8010471f:	89 de                	mov    %ebx,%esi
80104721:	89 c1                	mov    %eax,%ecx
80104723:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104725:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104728:	8b 40 18             	mov    0x18(%eax),%eax
8010472b:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80104732:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104739:	eb 43                	jmp    8010477e <fork+0x112>
    if(proc->ofile[i])
8010473b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104741:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104744:	83 c2 08             	add    $0x8,%edx
80104747:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010474b:	85 c0                	test   %eax,%eax
8010474d:	74 2b                	je     8010477a <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
8010474f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104758:	83 c2 08             	add    $0x8,%edx
8010475b:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010475f:	83 ec 0c             	sub    $0xc,%esp
80104762:	50                   	push   %eax
80104763:	e8 77 c8 ff ff       	call   80100fdf <filedup>
80104768:	83 c4 10             	add    $0x10,%esp
8010476b:	89 c1                	mov    %eax,%ecx
8010476d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104770:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104773:	83 c2 08             	add    $0x8,%edx
80104776:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
8010477a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010477e:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104782:	7e b7                	jle    8010473b <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104784:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478a:	8b 40 68             	mov    0x68(%eax),%eax
8010478d:	83 ec 0c             	sub    $0xc,%esp
80104790:	50                   	push   %eax
80104791:	e8 2f d1 ff ff       	call   801018c5 <idup>
80104796:	83 c4 10             	add    $0x10,%esp
80104799:	89 c2                	mov    %eax,%edx
8010479b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010479e:	89 50 68             	mov    %edx,0x68(%eax)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
801047a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047a7:	8d 50 6c             	lea    0x6c(%eax),%edx
801047aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047ad:	83 c0 6c             	add    $0x6c,%eax
801047b0:	83 ec 04             	sub    $0x4,%esp
801047b3:	6a 10                	push   $0x10
801047b5:	52                   	push   %edx
801047b6:	50                   	push   %eax
801047b7:	e8 c3 0c 00 00       	call   8010547f <safestrcpy>
801047bc:	83 c4 10             	add    $0x10,%esp
 
  pid = np->pid;
801047bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047c2:	8b 40 10             	mov    0x10(%eax),%eax
801047c5:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
801047c8:	83 ec 0c             	sub    $0xc,%esp
801047cb:	68 40 2a 11 80       	push   $0x80112a40
801047d0:	e8 49 08 00 00       	call   8010501e <acquire>
801047d5:	83 c4 10             	add    $0x10,%esp
  np->state = RUNNABLE;
801047d8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047db:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
801047e2:	83 ec 0c             	sub    $0xc,%esp
801047e5:	68 40 2a 11 80       	push   $0x80112a40
801047ea:	e8 95 08 00 00       	call   80105084 <release>
801047ef:	83 c4 10             	add    $0x10,%esp
  
  return pid;
801047f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801047f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047f8:	5b                   	pop    %ebx
801047f9:	5e                   	pop    %esi
801047fa:	5f                   	pop    %edi
801047fb:	5d                   	pop    %ebp
801047fc:	c3                   	ret    

801047fd <exit>:
// An exited process remains in the zombie state
// until its parent calls wait(0) to find out it exited.

void
exit(int status)
{
801047fd:	55                   	push   %ebp
801047fe:	89 e5                	mov    %esp,%ebp
80104800:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104803:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010480a:	a1 68 b6 10 80       	mov    0x8010b668,%eax
8010480f:	39 c2                	cmp    %eax,%edx
80104811:	75 0d                	jne    80104820 <exit+0x23>
    panic("init exiting");
80104813:	83 ec 0c             	sub    $0xc,%esp
80104816:	68 f8 88 10 80       	push   $0x801088f8
8010481b:	e8 3c bd ff ff       	call   8010055c <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104820:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104827:	eb 48                	jmp    80104871 <exit+0x74>
    if(proc->ofile[fd]){
80104829:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010482f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104832:	83 c2 08             	add    $0x8,%edx
80104835:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104839:	85 c0                	test   %eax,%eax
8010483b:	74 30                	je     8010486d <exit+0x70>
      fileclose(proc->ofile[fd]);
8010483d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104843:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104846:	83 c2 08             	add    $0x8,%edx
80104849:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010484d:	83 ec 0c             	sub    $0xc,%esp
80104850:	50                   	push   %eax
80104851:	e8 da c7 ff ff       	call   80101030 <fileclose>
80104856:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80104859:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010485f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104862:	83 c2 08             	add    $0x8,%edx
80104865:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010486c:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010486d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104871:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104875:	7e b2                	jle    80104829 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80104877:	e8 0d ec ff ff       	call   80103489 <begin_op>
  iput(proc->cwd);
8010487c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104882:	8b 40 68             	mov    0x68(%eax),%eax
80104885:	83 ec 0c             	sub    $0xc,%esp
80104888:	50                   	push   %eax
80104889:	e8 39 d2 ff ff       	call   80101ac7 <iput>
8010488e:	83 c4 10             	add    $0x10,%esp
  end_op();
80104891:	e8 81 ec ff ff       	call   80103517 <end_op>
  proc->cwd = 0;
80104896:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010489c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  proc->status = status;
801048a3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048a9:	8b 55 08             	mov    0x8(%ebp),%edx
801048ac:	89 50 7c             	mov    %edx,0x7c(%eax)

  acquire(&ptable.lock);
801048af:	83 ec 0c             	sub    $0xc,%esp
801048b2:	68 40 2a 11 80       	push   $0x80112a40
801048b7:	e8 62 07 00 00       	call   8010501e <acquire>
801048bc:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);
801048bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048c5:	8b 40 14             	mov    0x14(%eax),%eax
801048c8:	83 ec 0c             	sub    $0xc,%esp
801048cb:	50                   	push   %eax
801048cc:	e8 1d 04 00 00       	call   80104cee <wakeup1>
801048d1:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048d4:	c7 45 f4 74 2a 11 80 	movl   $0x80112a74,-0xc(%ebp)
801048db:	eb 3c                	jmp    80104919 <exit+0x11c>
    if(p->parent == proc){
801048dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048e0:	8b 50 14             	mov    0x14(%eax),%edx
801048e3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048e9:	39 c2                	cmp    %eax,%edx
801048eb:	75 28                	jne    80104915 <exit+0x118>
      p->parent = initproc;
801048ed:	8b 15 68 b6 10 80    	mov    0x8010b668,%edx
801048f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f6:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
801048f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048fc:	8b 40 0c             	mov    0xc(%eax),%eax
801048ff:	83 f8 05             	cmp    $0x5,%eax
80104902:	75 11                	jne    80104915 <exit+0x118>
        wakeup1(initproc);
80104904:	a1 68 b6 10 80       	mov    0x8010b668,%eax
80104909:	83 ec 0c             	sub    $0xc,%esp
8010490c:	50                   	push   %eax
8010490d:	e8 dc 03 00 00       	call   80104cee <wakeup1>
80104912:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait(0).
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104915:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104919:	81 7d f4 74 4a 11 80 	cmpl   $0x80114a74,-0xc(%ebp)
80104920:	72 bb                	jb     801048dd <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80104922:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104928:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
8010492f:	e8 ea 01 00 00       	call   80104b1e <sched>
  panic("zombie exit");
80104934:	83 ec 0c             	sub    $0xc,%esp
80104937:	68 05 89 10 80       	push   $0x80108905
8010493c:	e8 1b bc ff ff       	call   8010055c <panic>

80104941 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80104941:	55                   	push   %ebp
80104942:	89 e5                	mov    %esp,%ebp
80104944:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80104947:	83 ec 0c             	sub    $0xc,%esp
8010494a:	68 40 2a 11 80       	push   $0x80112a40
8010494f:	e8 ca 06 00 00       	call   8010501e <acquire>
80104954:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80104957:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010495e:	c7 45 f4 74 2a 11 80 	movl   $0x80112a74,-0xc(%ebp)
80104965:	e9 bb 00 00 00       	jmp    80104a25 <wait+0xe4>
      if(p->parent != proc)
8010496a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010496d:	8b 50 14             	mov    0x14(%eax),%edx
80104970:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104976:	39 c2                	cmp    %eax,%edx
80104978:	74 05                	je     8010497f <wait+0x3e>
        continue;
8010497a:	e9 a2 00 00 00       	jmp    80104a21 <wait+0xe0>
      havekids = 1;
8010497f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104986:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104989:	8b 40 0c             	mov    0xc(%eax),%eax
8010498c:	83 f8 05             	cmp    $0x5,%eax
8010498f:	0f 85 8c 00 00 00    	jne    80104a21 <wait+0xe0>
        // Found one.
    	if (status!=0) {
80104995:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104999:	74 0b                	je     801049a6 <wait+0x65>
    		*status = (p->status);
8010499b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010499e:	8b 50 7c             	mov    0x7c(%eax),%edx
801049a1:	8b 45 08             	mov    0x8(%ebp),%eax
801049a4:	89 10                	mov    %edx,(%eax)
    	}
        pid = p->pid;
801049a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a9:	8b 40 10             	mov    0x10(%eax),%eax
801049ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
801049af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b2:	8b 40 08             	mov    0x8(%eax),%eax
801049b5:	83 ec 0c             	sub    $0xc,%esp
801049b8:	50                   	push   %eax
801049b9:	e8 4e e1 ff ff       	call   80102b0c <kfree>
801049be:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
801049c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801049cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049ce:	8b 40 04             	mov    0x4(%eax),%eax
801049d1:	83 ec 0c             	sub    $0xc,%esp
801049d4:	50                   	push   %eax
801049d5:	e8 21 39 00 00       	call   801082fb <freevm>
801049da:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
801049dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
801049e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049ea:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
801049f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
801049fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049fe:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a05:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
80104a0c:	83 ec 0c             	sub    $0xc,%esp
80104a0f:	68 40 2a 11 80       	push   $0x80112a40
80104a14:	e8 6b 06 00 00       	call   80105084 <release>
80104a19:	83 c4 10             	add    $0x10,%esp
        return pid;
80104a1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a1f:	eb 57                	jmp    80104a78 <wait+0x137>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a21:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104a25:	81 7d f4 74 4a 11 80 	cmpl   $0x80114a74,-0xc(%ebp)
80104a2c:	0f 82 38 ff ff ff    	jb     8010496a <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104a32:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104a36:	74 0d                	je     80104a45 <wait+0x104>
80104a38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a3e:	8b 40 24             	mov    0x24(%eax),%eax
80104a41:	85 c0                	test   %eax,%eax
80104a43:	74 17                	je     80104a5c <wait+0x11b>
      release(&ptable.lock);
80104a45:	83 ec 0c             	sub    $0xc,%esp
80104a48:	68 40 2a 11 80       	push   $0x80112a40
80104a4d:	e8 32 06 00 00       	call   80105084 <release>
80104a52:	83 c4 10             	add    $0x10,%esp
      return -1;
80104a55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a5a:	eb 1c                	jmp    80104a78 <wait+0x137>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104a5c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a62:	83 ec 08             	sub    $0x8,%esp
80104a65:	68 40 2a 11 80       	push   $0x80112a40
80104a6a:	50                   	push   %eax
80104a6b:	e8 d3 01 00 00       	call   80104c43 <sleep>
80104a70:	83 c4 10             	add    $0x10,%esp
  }
80104a73:	e9 df fe ff ff       	jmp    80104957 <wait+0x16>
}
80104a78:	c9                   	leave  
80104a79:	c3                   	ret    

80104a7a <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104a7a:	55                   	push   %ebp
80104a7b:	89 e5                	mov    %esp,%ebp
80104a7d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104a80:	e8 02 f9 ff ff       	call   80104387 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104a85:	83 ec 0c             	sub    $0xc,%esp
80104a88:	68 40 2a 11 80       	push   $0x80112a40
80104a8d:	e8 8c 05 00 00       	call   8010501e <acquire>
80104a92:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a95:	c7 45 f4 74 2a 11 80 	movl   $0x80112a74,-0xc(%ebp)
80104a9c:	eb 62                	jmp    80104b00 <scheduler+0x86>
      if(p->state != RUNNABLE)
80104a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aa1:	8b 40 0c             	mov    0xc(%eax),%eax
80104aa4:	83 f8 03             	cmp    $0x3,%eax
80104aa7:	74 02                	je     80104aab <scheduler+0x31>
        continue;
80104aa9:	eb 51                	jmp    80104afc <scheduler+0x82>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80104aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aae:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104ab4:	83 ec 0c             	sub    $0xc,%esp
80104ab7:	ff 75 f4             	pushl  -0xc(%ebp)
80104aba:	e8 f8 33 00 00       	call   80107eb7 <switchuvm>
80104abf:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ac5:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104acc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ad2:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ad5:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104adc:	83 c2 04             	add    $0x4,%edx
80104adf:	83 ec 08             	sub    $0x8,%esp
80104ae2:	50                   	push   %eax
80104ae3:	52                   	push   %edx
80104ae4:	e8 07 0a 00 00       	call   801054f0 <swtch>
80104ae9:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104aec:	e8 aa 33 00 00       	call   80107e9b <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104af1:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104af8:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104afc:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104b00:	81 7d f4 74 4a 11 80 	cmpl   $0x80114a74,-0xc(%ebp)
80104b07:	72 95                	jb     80104a9e <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104b09:	83 ec 0c             	sub    $0xc,%esp
80104b0c:	68 40 2a 11 80       	push   $0x80112a40
80104b11:	e8 6e 05 00 00       	call   80105084 <release>
80104b16:	83 c4 10             	add    $0x10,%esp

  }
80104b19:	e9 62 ff ff ff       	jmp    80104a80 <scheduler+0x6>

80104b1e <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104b1e:	55                   	push   %ebp
80104b1f:	89 e5                	mov    %esp,%ebp
80104b21:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104b24:	83 ec 0c             	sub    $0xc,%esp
80104b27:	68 40 2a 11 80       	push   $0x80112a40
80104b2c:	e8 1d 06 00 00       	call   8010514e <holding>
80104b31:	83 c4 10             	add    $0x10,%esp
80104b34:	85 c0                	test   %eax,%eax
80104b36:	75 0d                	jne    80104b45 <sched+0x27>
    panic("sched ptable.lock");
80104b38:	83 ec 0c             	sub    $0xc,%esp
80104b3b:	68 11 89 10 80       	push   $0x80108911
80104b40:	e8 17 ba ff ff       	call   8010055c <panic>
  if(cpu->ncli != 1)
80104b45:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b4b:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104b51:	83 f8 01             	cmp    $0x1,%eax
80104b54:	74 0d                	je     80104b63 <sched+0x45>
    panic("sched locks");
80104b56:	83 ec 0c             	sub    $0xc,%esp
80104b59:	68 23 89 10 80       	push   $0x80108923
80104b5e:	e8 f9 b9 ff ff       	call   8010055c <panic>
  if(proc->state == RUNNING)
80104b63:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b69:	8b 40 0c             	mov    0xc(%eax),%eax
80104b6c:	83 f8 04             	cmp    $0x4,%eax
80104b6f:	75 0d                	jne    80104b7e <sched+0x60>
    panic("sched running");
80104b71:	83 ec 0c             	sub    $0xc,%esp
80104b74:	68 2f 89 10 80       	push   $0x8010892f
80104b79:	e8 de b9 ff ff       	call   8010055c <panic>
  if(readeflags()&FL_IF)
80104b7e:	e8 f4 f7 ff ff       	call   80104377 <readeflags>
80104b83:	25 00 02 00 00       	and    $0x200,%eax
80104b88:	85 c0                	test   %eax,%eax
80104b8a:	74 0d                	je     80104b99 <sched+0x7b>
    panic("sched interruptible");
80104b8c:	83 ec 0c             	sub    $0xc,%esp
80104b8f:	68 3d 89 10 80       	push   $0x8010893d
80104b94:	e8 c3 b9 ff ff       	call   8010055c <panic>
  intena = cpu->intena;
80104b99:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b9f:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104ba5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104ba8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bae:	8b 40 04             	mov    0x4(%eax),%eax
80104bb1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104bb8:	83 c2 1c             	add    $0x1c,%edx
80104bbb:	83 ec 08             	sub    $0x8,%esp
80104bbe:	50                   	push   %eax
80104bbf:	52                   	push   %edx
80104bc0:	e8 2b 09 00 00       	call   801054f0 <swtch>
80104bc5:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104bc8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bce:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bd1:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104bd7:	c9                   	leave  
80104bd8:	c3                   	ret    

80104bd9 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104bd9:	55                   	push   %ebp
80104bda:	89 e5                	mov    %esp,%ebp
80104bdc:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104bdf:	83 ec 0c             	sub    $0xc,%esp
80104be2:	68 40 2a 11 80       	push   $0x80112a40
80104be7:	e8 32 04 00 00       	call   8010501e <acquire>
80104bec:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104bef:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bf5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104bfc:	e8 1d ff ff ff       	call   80104b1e <sched>
  release(&ptable.lock);
80104c01:	83 ec 0c             	sub    $0xc,%esp
80104c04:	68 40 2a 11 80       	push   $0x80112a40
80104c09:	e8 76 04 00 00       	call   80105084 <release>
80104c0e:	83 c4 10             	add    $0x10,%esp
}
80104c11:	c9                   	leave  
80104c12:	c3                   	ret    

80104c13 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104c13:	55                   	push   %ebp
80104c14:	89 e5                	mov    %esp,%ebp
80104c16:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104c19:	83 ec 0c             	sub    $0xc,%esp
80104c1c:	68 40 2a 11 80       	push   $0x80112a40
80104c21:	e8 5e 04 00 00       	call   80105084 <release>
80104c26:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104c29:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c2e:	85 c0                	test   %eax,%eax
80104c30:	74 0f                	je     80104c41 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104c32:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104c39:	00 00 00 
    initlog();
80104c3c:	e8 27 e6 ff ff       	call   80103268 <initlog>
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104c41:	c9                   	leave  
80104c42:	c3                   	ret    

80104c43 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104c43:	55                   	push   %ebp
80104c44:	89 e5                	mov    %esp,%ebp
80104c46:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104c49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c4f:	85 c0                	test   %eax,%eax
80104c51:	75 0d                	jne    80104c60 <sleep+0x1d>
    panic("sleep");
80104c53:	83 ec 0c             	sub    $0xc,%esp
80104c56:	68 51 89 10 80       	push   $0x80108951
80104c5b:	e8 fc b8 ff ff       	call   8010055c <panic>

  if(lk == 0)
80104c60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104c64:	75 0d                	jne    80104c73 <sleep+0x30>
    panic("sleep without lk");
80104c66:	83 ec 0c             	sub    $0xc,%esp
80104c69:	68 57 89 10 80       	push   $0x80108957
80104c6e:	e8 e9 b8 ff ff       	call   8010055c <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104c73:	81 7d 0c 40 2a 11 80 	cmpl   $0x80112a40,0xc(%ebp)
80104c7a:	74 1e                	je     80104c9a <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104c7c:	83 ec 0c             	sub    $0xc,%esp
80104c7f:	68 40 2a 11 80       	push   $0x80112a40
80104c84:	e8 95 03 00 00       	call   8010501e <acquire>
80104c89:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104c8c:	83 ec 0c             	sub    $0xc,%esp
80104c8f:	ff 75 0c             	pushl  0xc(%ebp)
80104c92:	e8 ed 03 00 00       	call   80105084 <release>
80104c97:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104c9a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ca0:	8b 55 08             	mov    0x8(%ebp),%edx
80104ca3:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104ca6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cac:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104cb3:	e8 66 fe ff ff       	call   80104b1e <sched>

  // Tidy up.
  proc->chan = 0;
80104cb8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cbe:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104cc5:	81 7d 0c 40 2a 11 80 	cmpl   $0x80112a40,0xc(%ebp)
80104ccc:	74 1e                	je     80104cec <sleep+0xa9>
    release(&ptable.lock);
80104cce:	83 ec 0c             	sub    $0xc,%esp
80104cd1:	68 40 2a 11 80       	push   $0x80112a40
80104cd6:	e8 a9 03 00 00       	call   80105084 <release>
80104cdb:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104cde:	83 ec 0c             	sub    $0xc,%esp
80104ce1:	ff 75 0c             	pushl  0xc(%ebp)
80104ce4:	e8 35 03 00 00       	call   8010501e <acquire>
80104ce9:	83 c4 10             	add    $0x10,%esp
  }
}
80104cec:	c9                   	leave  
80104ced:	c3                   	ret    

80104cee <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104cee:	55                   	push   %ebp
80104cef:	89 e5                	mov    %esp,%ebp
80104cf1:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cf4:	c7 45 fc 74 2a 11 80 	movl   $0x80112a74,-0x4(%ebp)
80104cfb:	eb 24                	jmp    80104d21 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104cfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d00:	8b 40 0c             	mov    0xc(%eax),%eax
80104d03:	83 f8 02             	cmp    $0x2,%eax
80104d06:	75 15                	jne    80104d1d <wakeup1+0x2f>
80104d08:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d0b:	8b 40 20             	mov    0x20(%eax),%eax
80104d0e:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d11:	75 0a                	jne    80104d1d <wakeup1+0x2f>
      p->state = RUNNABLE;
80104d13:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d16:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d1d:	83 6d fc 80          	subl   $0xffffff80,-0x4(%ebp)
80104d21:	81 7d fc 74 4a 11 80 	cmpl   $0x80114a74,-0x4(%ebp)
80104d28:	72 d3                	jb     80104cfd <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104d2a:	c9                   	leave  
80104d2b:	c3                   	ret    

80104d2c <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104d2c:	55                   	push   %ebp
80104d2d:	89 e5                	mov    %esp,%ebp
80104d2f:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104d32:	83 ec 0c             	sub    $0xc,%esp
80104d35:	68 40 2a 11 80       	push   $0x80112a40
80104d3a:	e8 df 02 00 00       	call   8010501e <acquire>
80104d3f:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104d42:	83 ec 0c             	sub    $0xc,%esp
80104d45:	ff 75 08             	pushl  0x8(%ebp)
80104d48:	e8 a1 ff ff ff       	call   80104cee <wakeup1>
80104d4d:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104d50:	83 ec 0c             	sub    $0xc,%esp
80104d53:	68 40 2a 11 80       	push   $0x80112a40
80104d58:	e8 27 03 00 00       	call   80105084 <release>
80104d5d:	83 c4 10             	add    $0x10,%esp
}
80104d60:	c9                   	leave  
80104d61:	c3                   	ret    

80104d62 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104d62:	55                   	push   %ebp
80104d63:	89 e5                	mov    %esp,%ebp
80104d65:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104d68:	83 ec 0c             	sub    $0xc,%esp
80104d6b:	68 40 2a 11 80       	push   $0x80112a40
80104d70:	e8 a9 02 00 00       	call   8010501e <acquire>
80104d75:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d78:	c7 45 f4 74 2a 11 80 	movl   $0x80112a74,-0xc(%ebp)
80104d7f:	eb 45                	jmp    80104dc6 <kill+0x64>
    if(p->pid == pid){
80104d81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d84:	8b 40 10             	mov    0x10(%eax),%eax
80104d87:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d8a:	75 36                	jne    80104dc2 <kill+0x60>
      p->killed = 1;
80104d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d8f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d99:	8b 40 0c             	mov    0xc(%eax),%eax
80104d9c:	83 f8 02             	cmp    $0x2,%eax
80104d9f:	75 0a                	jne    80104dab <kill+0x49>
        p->state = RUNNABLE;
80104da1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104da4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104dab:	83 ec 0c             	sub    $0xc,%esp
80104dae:	68 40 2a 11 80       	push   $0x80112a40
80104db3:	e8 cc 02 00 00       	call   80105084 <release>
80104db8:	83 c4 10             	add    $0x10,%esp
      return 0;
80104dbb:	b8 00 00 00 00       	mov    $0x0,%eax
80104dc0:	eb 22                	jmp    80104de4 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dc2:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104dc6:	81 7d f4 74 4a 11 80 	cmpl   $0x80114a74,-0xc(%ebp)
80104dcd:	72 b2                	jb     80104d81 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104dcf:	83 ec 0c             	sub    $0xc,%esp
80104dd2:	68 40 2a 11 80       	push   $0x80112a40
80104dd7:	e8 a8 02 00 00       	call   80105084 <release>
80104ddc:	83 c4 10             	add    $0x10,%esp
  return -1;
80104ddf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104de4:	c9                   	leave  
80104de5:	c3                   	ret    

80104de6 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104de6:	55                   	push   %ebp
80104de7:	89 e5                	mov    %esp,%ebp
80104de9:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dec:	c7 45 f0 74 2a 11 80 	movl   $0x80112a74,-0x10(%ebp)
80104df3:	e9 d5 00 00 00       	jmp    80104ecd <procdump+0xe7>
    if(p->state == UNUSED)
80104df8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104dfb:	8b 40 0c             	mov    0xc(%eax),%eax
80104dfe:	85 c0                	test   %eax,%eax
80104e00:	75 05                	jne    80104e07 <procdump+0x21>
      continue;
80104e02:	e9 c2 00 00 00       	jmp    80104ec9 <procdump+0xe3>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e07:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e0a:	8b 40 0c             	mov    0xc(%eax),%eax
80104e0d:	83 f8 05             	cmp    $0x5,%eax
80104e10:	77 23                	ja     80104e35 <procdump+0x4f>
80104e12:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e15:	8b 40 0c             	mov    0xc(%eax),%eax
80104e18:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104e1f:	85 c0                	test   %eax,%eax
80104e21:	74 12                	je     80104e35 <procdump+0x4f>
      state = states[p->state];
80104e23:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e26:	8b 40 0c             	mov    0xc(%eax),%eax
80104e29:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104e30:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104e33:	eb 07                	jmp    80104e3c <procdump+0x56>
    else
      state = "???";
80104e35:	c7 45 ec 68 89 10 80 	movl   $0x80108968,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104e3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e3f:	8d 50 6c             	lea    0x6c(%eax),%edx
80104e42:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e45:	8b 40 10             	mov    0x10(%eax),%eax
80104e48:	52                   	push   %edx
80104e49:	ff 75 ec             	pushl  -0x14(%ebp)
80104e4c:	50                   	push   %eax
80104e4d:	68 6c 89 10 80       	push   $0x8010896c
80104e52:	e8 68 b5 ff ff       	call   801003bf <cprintf>
80104e57:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e5d:	8b 40 0c             	mov    0xc(%eax),%eax
80104e60:	83 f8 02             	cmp    $0x2,%eax
80104e63:	75 54                	jne    80104eb9 <procdump+0xd3>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104e65:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e68:	8b 40 1c             	mov    0x1c(%eax),%eax
80104e6b:	8b 40 0c             	mov    0xc(%eax),%eax
80104e6e:	83 c0 08             	add    $0x8,%eax
80104e71:	89 c2                	mov    %eax,%edx
80104e73:	83 ec 08             	sub    $0x8,%esp
80104e76:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104e79:	50                   	push   %eax
80104e7a:	52                   	push   %edx
80104e7b:	e8 55 02 00 00       	call   801050d5 <getcallerpcs>
80104e80:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104e83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104e8a:	eb 1c                	jmp    80104ea8 <procdump+0xc2>
        cprintf(" %p", pc[i]);
80104e8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e8f:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104e93:	83 ec 08             	sub    $0x8,%esp
80104e96:	50                   	push   %eax
80104e97:	68 75 89 10 80       	push   $0x80108975
80104e9c:	e8 1e b5 ff ff       	call   801003bf <cprintf>
80104ea1:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104ea4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104ea8:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104eac:	7f 0b                	jg     80104eb9 <procdump+0xd3>
80104eae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eb1:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104eb5:	85 c0                	test   %eax,%eax
80104eb7:	75 d3                	jne    80104e8c <procdump+0xa6>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104eb9:	83 ec 0c             	sub    $0xc,%esp
80104ebc:	68 79 89 10 80       	push   $0x80108979
80104ec1:	e8 f9 b4 ff ff       	call   801003bf <cprintf>
80104ec6:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ec9:	83 6d f0 80          	subl   $0xffffff80,-0x10(%ebp)
80104ecd:	81 7d f0 74 4a 11 80 	cmpl   $0x80114a74,-0x10(%ebp)
80104ed4:	0f 82 1e ff ff ff    	jb     80104df8 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104eda:	c9                   	leave  
80104edb:	c3                   	ret    

80104edc <pstat>:

int
pstat(int pid, struct procstat *stat){
80104edc:	55                   	push   %ebp
80104edd:	89 e5                	mov    %esp,%ebp
80104edf:	83 ec 18             	sub    $0x18,%esp
	struct proc *p;

	acquire(&ptable.lock);
80104ee2:	83 ec 0c             	sub    $0xc,%esp
80104ee5:	68 40 2a 11 80       	push   $0x80112a40
80104eea:	e8 2f 01 00 00       	call   8010501e <acquire>
80104eef:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ef2:	c7 45 f4 74 2a 11 80 	movl   $0x80112a74,-0xc(%ebp)
80104ef9:	e9 a5 00 00 00       	jmp    80104fa3 <pstat+0xc7>
		if(p->pid == pid){
80104efe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f01:	8b 40 10             	mov    0x10(%eax),%eax
80104f04:	3b 45 08             	cmp    0x8(%ebp),%eax
80104f07:	0f 85 92 00 00 00    	jne    80104f9f <pstat+0xc3>

			int i,fd,openFiles;
			for (i=0; i < 16; i++){
80104f0d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104f14:	eb 1d                	jmp    80104f33 <pstat+0x57>
				stat->name[i] = p->name[i];
80104f16:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f1c:	01 d0                	add    %edx,%eax
80104f1e:	83 c0 60             	add    $0x60,%eax
80104f21:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80104f25:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104f28:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104f2b:	01 ca                	add    %ecx,%edx
80104f2d:	88 02                	mov    %al,(%edx)
	acquire(&ptable.lock);
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
		if(p->pid == pid){

			int i,fd,openFiles;
			for (i=0; i < 16; i++){
80104f2f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104f33:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104f37:	7e dd                	jle    80104f16 <pstat+0x3a>
				stat->name[i] = p->name[i];
			}

			stat->state = p->state;
80104f39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f3c:	8b 50 0c             	mov    0xc(%eax),%edx
80104f3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f42:	89 50 18             	mov    %edx,0x18(%eax)
			stat->sz = p->sz;
80104f45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f48:	8b 10                	mov    (%eax),%edx
80104f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f4d:	89 50 10             	mov    %edx,0x10(%eax)

			openFiles=0;
80104f50:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

			for(fd = 0; fd < NOFILE; fd++){
80104f57:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80104f5e:	eb 19                	jmp    80104f79 <pstat+0x9d>
				if(p->ofile[fd]){
80104f60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f63:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104f66:	83 c2 08             	add    $0x8,%edx
80104f69:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104f6d:	85 c0                	test   %eax,%eax
80104f6f:	74 04                	je     80104f75 <pstat+0x99>
					openFiles++;
80104f71:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
			stat->state = p->state;
			stat->sz = p->sz;

			openFiles=0;

			for(fd = 0; fd < NOFILE; fd++){
80104f75:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80104f79:	83 7d ec 0f          	cmpl   $0xf,-0x14(%ebp)
80104f7d:	7e e1                	jle    80104f60 <pstat+0x84>
				if(p->ofile[fd]){
					openFiles++;
				}
			}

			stat->nofile = openFiles;
80104f7f:	8b 55 e8             	mov    -0x18(%ebp),%edx
80104f82:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f85:	89 50 14             	mov    %edx,0x14(%eax)

			release(&ptable.lock);
80104f88:	83 ec 0c             	sub    $0xc,%esp
80104f8b:	68 40 2a 11 80       	push   $0x80112a40
80104f90:	e8 ef 00 00 00       	call   80105084 <release>
80104f95:	83 c4 10             	add    $0x10,%esp
			return 0;
80104f98:	b8 00 00 00 00       	mov    $0x0,%eax
80104f9d:	eb 26                	jmp    80104fc5 <pstat+0xe9>
int
pstat(int pid, struct procstat *stat){
	struct proc *p;

	acquire(&ptable.lock);
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f9f:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104fa3:	81 7d f4 74 4a 11 80 	cmpl   $0x80114a74,-0xc(%ebp)
80104faa:	0f 82 4e ff ff ff    	jb     80104efe <pstat+0x22>
			release(&ptable.lock);
			return 0;
		}
	}

	release(&ptable.lock);
80104fb0:	83 ec 0c             	sub    $0xc,%esp
80104fb3:	68 40 2a 11 80       	push   $0x80112a40
80104fb8:	e8 c7 00 00 00       	call   80105084 <release>
80104fbd:	83 c4 10             	add    $0x10,%esp
	return -1;
80104fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fc5:	c9                   	leave  
80104fc6:	c3                   	ret    

80104fc7 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104fc7:	55                   	push   %ebp
80104fc8:	89 e5                	mov    %esp,%ebp
80104fca:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104fcd:	9c                   	pushf  
80104fce:	58                   	pop    %eax
80104fcf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104fd2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104fd5:	c9                   	leave  
80104fd6:	c3                   	ret    

80104fd7 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104fd7:	55                   	push   %ebp
80104fd8:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104fda:	fa                   	cli    
}
80104fdb:	5d                   	pop    %ebp
80104fdc:	c3                   	ret    

80104fdd <sti>:

static inline void
sti(void)
{
80104fdd:	55                   	push   %ebp
80104fde:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104fe0:	fb                   	sti    
}
80104fe1:	5d                   	pop    %ebp
80104fe2:	c3                   	ret    

80104fe3 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104fe3:	55                   	push   %ebp
80104fe4:	89 e5                	mov    %esp,%ebp
80104fe6:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104fe9:	8b 55 08             	mov    0x8(%ebp),%edx
80104fec:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fef:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104ff2:	f0 87 02             	lock xchg %eax,(%edx)
80104ff5:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104ff8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104ffb:	c9                   	leave  
80104ffc:	c3                   	ret    

80104ffd <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ffd:	55                   	push   %ebp
80104ffe:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80105000:	8b 45 08             	mov    0x8(%ebp),%eax
80105003:	8b 55 0c             	mov    0xc(%ebp),%edx
80105006:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105009:	8b 45 08             	mov    0x8(%ebp),%eax
8010500c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80105012:	8b 45 08             	mov    0x8(%ebp),%eax
80105015:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
8010501c:	5d                   	pop    %ebp
8010501d:	c3                   	ret    

8010501e <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
8010501e:	55                   	push   %ebp
8010501f:	89 e5                	mov    %esp,%ebp
80105021:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105024:	e8 4f 01 00 00       	call   80105178 <pushcli>
  if(holding(lk))
80105029:	8b 45 08             	mov    0x8(%ebp),%eax
8010502c:	83 ec 0c             	sub    $0xc,%esp
8010502f:	50                   	push   %eax
80105030:	e8 19 01 00 00       	call   8010514e <holding>
80105035:	83 c4 10             	add    $0x10,%esp
80105038:	85 c0                	test   %eax,%eax
8010503a:	74 0d                	je     80105049 <acquire+0x2b>
    panic("acquire");
8010503c:	83 ec 0c             	sub    $0xc,%esp
8010503f:	68 a5 89 10 80       	push   $0x801089a5
80105044:	e8 13 b5 ff ff       	call   8010055c <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80105049:	90                   	nop
8010504a:	8b 45 08             	mov    0x8(%ebp),%eax
8010504d:	83 ec 08             	sub    $0x8,%esp
80105050:	6a 01                	push   $0x1
80105052:	50                   	push   %eax
80105053:	e8 8b ff ff ff       	call   80104fe3 <xchg>
80105058:	83 c4 10             	add    $0x10,%esp
8010505b:	85 c0                	test   %eax,%eax
8010505d:	75 eb                	jne    8010504a <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
8010505f:	8b 45 08             	mov    0x8(%ebp),%eax
80105062:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105069:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
8010506c:	8b 45 08             	mov    0x8(%ebp),%eax
8010506f:	83 c0 0c             	add    $0xc,%eax
80105072:	83 ec 08             	sub    $0x8,%esp
80105075:	50                   	push   %eax
80105076:	8d 45 08             	lea    0x8(%ebp),%eax
80105079:	50                   	push   %eax
8010507a:	e8 56 00 00 00       	call   801050d5 <getcallerpcs>
8010507f:	83 c4 10             	add    $0x10,%esp
}
80105082:	c9                   	leave  
80105083:	c3                   	ret    

80105084 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105084:	55                   	push   %ebp
80105085:	89 e5                	mov    %esp,%ebp
80105087:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
8010508a:	83 ec 0c             	sub    $0xc,%esp
8010508d:	ff 75 08             	pushl  0x8(%ebp)
80105090:	e8 b9 00 00 00       	call   8010514e <holding>
80105095:	83 c4 10             	add    $0x10,%esp
80105098:	85 c0                	test   %eax,%eax
8010509a:	75 0d                	jne    801050a9 <release+0x25>
    panic("release");
8010509c:	83 ec 0c             	sub    $0xc,%esp
8010509f:	68 ad 89 10 80       	push   $0x801089ad
801050a4:	e8 b3 b4 ff ff       	call   8010055c <panic>

  lk->pcs[0] = 0;
801050a9:	8b 45 08             	mov    0x8(%ebp),%eax
801050ac:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801050b3:	8b 45 08             	mov    0x8(%ebp),%eax
801050b6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
801050bd:	8b 45 08             	mov    0x8(%ebp),%eax
801050c0:	83 ec 08             	sub    $0x8,%esp
801050c3:	6a 00                	push   $0x0
801050c5:	50                   	push   %eax
801050c6:	e8 18 ff ff ff       	call   80104fe3 <xchg>
801050cb:	83 c4 10             	add    $0x10,%esp

  popcli();
801050ce:	e8 e9 00 00 00       	call   801051bc <popcli>
}
801050d3:	c9                   	leave  
801050d4:	c3                   	ret    

801050d5 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801050d5:	55                   	push   %ebp
801050d6:	89 e5                	mov    %esp,%ebp
801050d8:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
801050db:	8b 45 08             	mov    0x8(%ebp),%eax
801050de:	83 e8 08             	sub    $0x8,%eax
801050e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801050e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801050eb:	eb 38                	jmp    80105125 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801050f1:	74 38                	je     8010512b <getcallerpcs+0x56>
801050f3:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801050fa:	76 2f                	jbe    8010512b <getcallerpcs+0x56>
801050fc:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80105100:	74 29                	je     8010512b <getcallerpcs+0x56>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105102:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105105:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010510c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010510f:	01 c2                	add    %eax,%edx
80105111:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105114:	8b 40 04             	mov    0x4(%eax),%eax
80105117:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105119:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010511c:	8b 00                	mov    (%eax),%eax
8010511e:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105121:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105125:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105129:	7e c2                	jle    801050ed <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010512b:	eb 19                	jmp    80105146 <getcallerpcs+0x71>
    pcs[i] = 0;
8010512d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105130:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105137:	8b 45 0c             	mov    0xc(%ebp),%eax
8010513a:	01 d0                	add    %edx,%eax
8010513c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105142:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105146:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
8010514a:	7e e1                	jle    8010512d <getcallerpcs+0x58>
    pcs[i] = 0;
}
8010514c:	c9                   	leave  
8010514d:	c3                   	ret    

8010514e <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
8010514e:	55                   	push   %ebp
8010514f:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105151:	8b 45 08             	mov    0x8(%ebp),%eax
80105154:	8b 00                	mov    (%eax),%eax
80105156:	85 c0                	test   %eax,%eax
80105158:	74 17                	je     80105171 <holding+0x23>
8010515a:	8b 45 08             	mov    0x8(%ebp),%eax
8010515d:	8b 50 08             	mov    0x8(%eax),%edx
80105160:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105166:	39 c2                	cmp    %eax,%edx
80105168:	75 07                	jne    80105171 <holding+0x23>
8010516a:	b8 01 00 00 00       	mov    $0x1,%eax
8010516f:	eb 05                	jmp    80105176 <holding+0x28>
80105171:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105176:	5d                   	pop    %ebp
80105177:	c3                   	ret    

80105178 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105178:	55                   	push   %ebp
80105179:	89 e5                	mov    %esp,%ebp
8010517b:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
8010517e:	e8 44 fe ff ff       	call   80104fc7 <readeflags>
80105183:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80105186:	e8 4c fe ff ff       	call   80104fd7 <cli>
  if(cpu->ncli++ == 0)
8010518b:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105192:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80105198:	8d 48 01             	lea    0x1(%eax),%ecx
8010519b:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
801051a1:	85 c0                	test   %eax,%eax
801051a3:	75 15                	jne    801051ba <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
801051a5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801051ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051ae:	81 e2 00 02 00 00    	and    $0x200,%edx
801051b4:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801051ba:	c9                   	leave  
801051bb:	c3                   	ret    

801051bc <popcli>:

void
popcli(void)
{
801051bc:	55                   	push   %ebp
801051bd:	89 e5                	mov    %esp,%ebp
801051bf:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801051c2:	e8 00 fe ff ff       	call   80104fc7 <readeflags>
801051c7:	25 00 02 00 00       	and    $0x200,%eax
801051cc:	85 c0                	test   %eax,%eax
801051ce:	74 0d                	je     801051dd <popcli+0x21>
    panic("popcli - interruptible");
801051d0:	83 ec 0c             	sub    $0xc,%esp
801051d3:	68 b5 89 10 80       	push   $0x801089b5
801051d8:	e8 7f b3 ff ff       	call   8010055c <panic>
  if(--cpu->ncli < 0)
801051dd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801051e3:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801051e9:	83 ea 01             	sub    $0x1,%edx
801051ec:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801051f2:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801051f8:	85 c0                	test   %eax,%eax
801051fa:	79 0d                	jns    80105209 <popcli+0x4d>
    panic("popcli");
801051fc:	83 ec 0c             	sub    $0xc,%esp
801051ff:	68 cc 89 10 80       	push   $0x801089cc
80105204:	e8 53 b3 ff ff       	call   8010055c <panic>
  if(cpu->ncli == 0 && cpu->intena)
80105209:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010520f:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105215:	85 c0                	test   %eax,%eax
80105217:	75 15                	jne    8010522e <popcli+0x72>
80105219:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010521f:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105225:	85 c0                	test   %eax,%eax
80105227:	74 05                	je     8010522e <popcli+0x72>
    sti();
80105229:	e8 af fd ff ff       	call   80104fdd <sti>
}
8010522e:	c9                   	leave  
8010522f:	c3                   	ret    

80105230 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	57                   	push   %edi
80105234:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105235:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105238:	8b 55 10             	mov    0x10(%ebp),%edx
8010523b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010523e:	89 cb                	mov    %ecx,%ebx
80105240:	89 df                	mov    %ebx,%edi
80105242:	89 d1                	mov    %edx,%ecx
80105244:	fc                   	cld    
80105245:	f3 aa                	rep stos %al,%es:(%edi)
80105247:	89 ca                	mov    %ecx,%edx
80105249:	89 fb                	mov    %edi,%ebx
8010524b:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010524e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105251:	5b                   	pop    %ebx
80105252:	5f                   	pop    %edi
80105253:	5d                   	pop    %ebp
80105254:	c3                   	ret    

80105255 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105255:	55                   	push   %ebp
80105256:	89 e5                	mov    %esp,%ebp
80105258:	57                   	push   %edi
80105259:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
8010525a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010525d:	8b 55 10             	mov    0x10(%ebp),%edx
80105260:	8b 45 0c             	mov    0xc(%ebp),%eax
80105263:	89 cb                	mov    %ecx,%ebx
80105265:	89 df                	mov    %ebx,%edi
80105267:	89 d1                	mov    %edx,%ecx
80105269:	fc                   	cld    
8010526a:	f3 ab                	rep stos %eax,%es:(%edi)
8010526c:	89 ca                	mov    %ecx,%edx
8010526e:	89 fb                	mov    %edi,%ebx
80105270:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105273:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105276:	5b                   	pop    %ebx
80105277:	5f                   	pop    %edi
80105278:	5d                   	pop    %ebp
80105279:	c3                   	ret    

8010527a <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
8010527a:	55                   	push   %ebp
8010527b:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
8010527d:	8b 45 08             	mov    0x8(%ebp),%eax
80105280:	83 e0 03             	and    $0x3,%eax
80105283:	85 c0                	test   %eax,%eax
80105285:	75 43                	jne    801052ca <memset+0x50>
80105287:	8b 45 10             	mov    0x10(%ebp),%eax
8010528a:	83 e0 03             	and    $0x3,%eax
8010528d:	85 c0                	test   %eax,%eax
8010528f:	75 39                	jne    801052ca <memset+0x50>
    c &= 0xFF;
80105291:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105298:	8b 45 10             	mov    0x10(%ebp),%eax
8010529b:	c1 e8 02             	shr    $0x2,%eax
8010529e:	89 c1                	mov    %eax,%ecx
801052a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801052a3:	c1 e0 18             	shl    $0x18,%eax
801052a6:	89 c2                	mov    %eax,%edx
801052a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801052ab:	c1 e0 10             	shl    $0x10,%eax
801052ae:	09 c2                	or     %eax,%edx
801052b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801052b3:	c1 e0 08             	shl    $0x8,%eax
801052b6:	09 d0                	or     %edx,%eax
801052b8:	0b 45 0c             	or     0xc(%ebp),%eax
801052bb:	51                   	push   %ecx
801052bc:	50                   	push   %eax
801052bd:	ff 75 08             	pushl  0x8(%ebp)
801052c0:	e8 90 ff ff ff       	call   80105255 <stosl>
801052c5:	83 c4 0c             	add    $0xc,%esp
801052c8:	eb 12                	jmp    801052dc <memset+0x62>
  } else
    stosb(dst, c, n);
801052ca:	8b 45 10             	mov    0x10(%ebp),%eax
801052cd:	50                   	push   %eax
801052ce:	ff 75 0c             	pushl  0xc(%ebp)
801052d1:	ff 75 08             	pushl  0x8(%ebp)
801052d4:	e8 57 ff ff ff       	call   80105230 <stosb>
801052d9:	83 c4 0c             	add    $0xc,%esp
  return dst;
801052dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
801052df:	c9                   	leave  
801052e0:	c3                   	ret    

801052e1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801052e1:	55                   	push   %ebp
801052e2:	89 e5                	mov    %esp,%ebp
801052e4:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
801052e7:	8b 45 08             	mov    0x8(%ebp),%eax
801052ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801052ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801052f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801052f3:	eb 30                	jmp    80105325 <memcmp+0x44>
    if(*s1 != *s2)
801052f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052f8:	0f b6 10             	movzbl (%eax),%edx
801052fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052fe:	0f b6 00             	movzbl (%eax),%eax
80105301:	38 c2                	cmp    %al,%dl
80105303:	74 18                	je     8010531d <memcmp+0x3c>
      return *s1 - *s2;
80105305:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105308:	0f b6 00             	movzbl (%eax),%eax
8010530b:	0f b6 d0             	movzbl %al,%edx
8010530e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105311:	0f b6 00             	movzbl (%eax),%eax
80105314:	0f b6 c0             	movzbl %al,%eax
80105317:	29 c2                	sub    %eax,%edx
80105319:	89 d0                	mov    %edx,%eax
8010531b:	eb 1a                	jmp    80105337 <memcmp+0x56>
    s1++, s2++;
8010531d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105321:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105325:	8b 45 10             	mov    0x10(%ebp),%eax
80105328:	8d 50 ff             	lea    -0x1(%eax),%edx
8010532b:	89 55 10             	mov    %edx,0x10(%ebp)
8010532e:	85 c0                	test   %eax,%eax
80105330:	75 c3                	jne    801052f5 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105332:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105337:	c9                   	leave  
80105338:	c3                   	ret    

80105339 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105339:	55                   	push   %ebp
8010533a:	89 e5                	mov    %esp,%ebp
8010533c:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010533f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105342:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105345:	8b 45 08             	mov    0x8(%ebp),%eax
80105348:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
8010534b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010534e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105351:	73 3d                	jae    80105390 <memmove+0x57>
80105353:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105356:	8b 45 10             	mov    0x10(%ebp),%eax
80105359:	01 d0                	add    %edx,%eax
8010535b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010535e:	76 30                	jbe    80105390 <memmove+0x57>
    s += n;
80105360:	8b 45 10             	mov    0x10(%ebp),%eax
80105363:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105366:	8b 45 10             	mov    0x10(%ebp),%eax
80105369:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
8010536c:	eb 13                	jmp    80105381 <memmove+0x48>
      *--d = *--s;
8010536e:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105372:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105376:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105379:	0f b6 10             	movzbl (%eax),%edx
8010537c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010537f:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105381:	8b 45 10             	mov    0x10(%ebp),%eax
80105384:	8d 50 ff             	lea    -0x1(%eax),%edx
80105387:	89 55 10             	mov    %edx,0x10(%ebp)
8010538a:	85 c0                	test   %eax,%eax
8010538c:	75 e0                	jne    8010536e <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010538e:	eb 26                	jmp    801053b6 <memmove+0x7d>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105390:	eb 17                	jmp    801053a9 <memmove+0x70>
      *d++ = *s++;
80105392:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105395:	8d 50 01             	lea    0x1(%eax),%edx
80105398:	89 55 f8             	mov    %edx,-0x8(%ebp)
8010539b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010539e:	8d 4a 01             	lea    0x1(%edx),%ecx
801053a1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801053a4:	0f b6 12             	movzbl (%edx),%edx
801053a7:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801053a9:	8b 45 10             	mov    0x10(%ebp),%eax
801053ac:	8d 50 ff             	lea    -0x1(%eax),%edx
801053af:	89 55 10             	mov    %edx,0x10(%ebp)
801053b2:	85 c0                	test   %eax,%eax
801053b4:	75 dc                	jne    80105392 <memmove+0x59>
      *d++ = *s++;

  return dst;
801053b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
801053b9:	c9                   	leave  
801053ba:	c3                   	ret    

801053bb <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801053bb:	55                   	push   %ebp
801053bc:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801053be:	ff 75 10             	pushl  0x10(%ebp)
801053c1:	ff 75 0c             	pushl  0xc(%ebp)
801053c4:	ff 75 08             	pushl  0x8(%ebp)
801053c7:	e8 6d ff ff ff       	call   80105339 <memmove>
801053cc:	83 c4 0c             	add    $0xc,%esp
}
801053cf:	c9                   	leave  
801053d0:	c3                   	ret    

801053d1 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801053d1:	55                   	push   %ebp
801053d2:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801053d4:	eb 0c                	jmp    801053e2 <strncmp+0x11>
    n--, p++, q++;
801053d6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801053da:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801053de:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801053e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053e6:	74 1a                	je     80105402 <strncmp+0x31>
801053e8:	8b 45 08             	mov    0x8(%ebp),%eax
801053eb:	0f b6 00             	movzbl (%eax),%eax
801053ee:	84 c0                	test   %al,%al
801053f0:	74 10                	je     80105402 <strncmp+0x31>
801053f2:	8b 45 08             	mov    0x8(%ebp),%eax
801053f5:	0f b6 10             	movzbl (%eax),%edx
801053f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801053fb:	0f b6 00             	movzbl (%eax),%eax
801053fe:	38 c2                	cmp    %al,%dl
80105400:	74 d4                	je     801053d6 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105402:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105406:	75 07                	jne    8010540f <strncmp+0x3e>
    return 0;
80105408:	b8 00 00 00 00       	mov    $0x0,%eax
8010540d:	eb 16                	jmp    80105425 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
8010540f:	8b 45 08             	mov    0x8(%ebp),%eax
80105412:	0f b6 00             	movzbl (%eax),%eax
80105415:	0f b6 d0             	movzbl %al,%edx
80105418:	8b 45 0c             	mov    0xc(%ebp),%eax
8010541b:	0f b6 00             	movzbl (%eax),%eax
8010541e:	0f b6 c0             	movzbl %al,%eax
80105421:	29 c2                	sub    %eax,%edx
80105423:	89 d0                	mov    %edx,%eax
}
80105425:	5d                   	pop    %ebp
80105426:	c3                   	ret    

80105427 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105427:	55                   	push   %ebp
80105428:	89 e5                	mov    %esp,%ebp
8010542a:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
8010542d:	8b 45 08             	mov    0x8(%ebp),%eax
80105430:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105433:	90                   	nop
80105434:	8b 45 10             	mov    0x10(%ebp),%eax
80105437:	8d 50 ff             	lea    -0x1(%eax),%edx
8010543a:	89 55 10             	mov    %edx,0x10(%ebp)
8010543d:	85 c0                	test   %eax,%eax
8010543f:	7e 1e                	jle    8010545f <strncpy+0x38>
80105441:	8b 45 08             	mov    0x8(%ebp),%eax
80105444:	8d 50 01             	lea    0x1(%eax),%edx
80105447:	89 55 08             	mov    %edx,0x8(%ebp)
8010544a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010544d:	8d 4a 01             	lea    0x1(%edx),%ecx
80105450:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105453:	0f b6 12             	movzbl (%edx),%edx
80105456:	88 10                	mov    %dl,(%eax)
80105458:	0f b6 00             	movzbl (%eax),%eax
8010545b:	84 c0                	test   %al,%al
8010545d:	75 d5                	jne    80105434 <strncpy+0xd>
    ;
  while(n-- > 0)
8010545f:	eb 0c                	jmp    8010546d <strncpy+0x46>
    *s++ = 0;
80105461:	8b 45 08             	mov    0x8(%ebp),%eax
80105464:	8d 50 01             	lea    0x1(%eax),%edx
80105467:	89 55 08             	mov    %edx,0x8(%ebp)
8010546a:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010546d:	8b 45 10             	mov    0x10(%ebp),%eax
80105470:	8d 50 ff             	lea    -0x1(%eax),%edx
80105473:	89 55 10             	mov    %edx,0x10(%ebp)
80105476:	85 c0                	test   %eax,%eax
80105478:	7f e7                	jg     80105461 <strncpy+0x3a>
    *s++ = 0;
  return os;
8010547a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010547d:	c9                   	leave  
8010547e:	c3                   	ret    

8010547f <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
8010547f:	55                   	push   %ebp
80105480:	89 e5                	mov    %esp,%ebp
80105482:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105485:	8b 45 08             	mov    0x8(%ebp),%eax
80105488:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
8010548b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010548f:	7f 05                	jg     80105496 <safestrcpy+0x17>
    return os;
80105491:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105494:	eb 31                	jmp    801054c7 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80105496:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010549a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010549e:	7e 1e                	jle    801054be <safestrcpy+0x3f>
801054a0:	8b 45 08             	mov    0x8(%ebp),%eax
801054a3:	8d 50 01             	lea    0x1(%eax),%edx
801054a6:	89 55 08             	mov    %edx,0x8(%ebp)
801054a9:	8b 55 0c             	mov    0xc(%ebp),%edx
801054ac:	8d 4a 01             	lea    0x1(%edx),%ecx
801054af:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801054b2:	0f b6 12             	movzbl (%edx),%edx
801054b5:	88 10                	mov    %dl,(%eax)
801054b7:	0f b6 00             	movzbl (%eax),%eax
801054ba:	84 c0                	test   %al,%al
801054bc:	75 d8                	jne    80105496 <safestrcpy+0x17>
    ;
  *s = 0;
801054be:	8b 45 08             	mov    0x8(%ebp),%eax
801054c1:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801054c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801054c7:	c9                   	leave  
801054c8:	c3                   	ret    

801054c9 <strlen>:

int
strlen(const char *s)
{
801054c9:	55                   	push   %ebp
801054ca:	89 e5                	mov    %esp,%ebp
801054cc:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801054cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801054d6:	eb 04                	jmp    801054dc <strlen+0x13>
801054d8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801054dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
801054df:	8b 45 08             	mov    0x8(%ebp),%eax
801054e2:	01 d0                	add    %edx,%eax
801054e4:	0f b6 00             	movzbl (%eax),%eax
801054e7:	84 c0                	test   %al,%al
801054e9:	75 ed                	jne    801054d8 <strlen+0xf>
    ;
  return n;
801054eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801054ee:	c9                   	leave  
801054ef:	c3                   	ret    

801054f0 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801054f0:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801054f4:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801054f8:	55                   	push   %ebp
  pushl %ebx
801054f9:	53                   	push   %ebx
  pushl %esi
801054fa:	56                   	push   %esi
  pushl %edi
801054fb:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801054fc:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801054fe:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105500:	5f                   	pop    %edi
  popl %esi
80105501:	5e                   	pop    %esi
  popl %ebx
80105502:	5b                   	pop    %ebx
  popl %ebp
80105503:	5d                   	pop    %ebp
  ret
80105504:	c3                   	ret    

80105505 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105505:	55                   	push   %ebp
80105506:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105508:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010550e:	8b 00                	mov    (%eax),%eax
80105510:	3b 45 08             	cmp    0x8(%ebp),%eax
80105513:	76 12                	jbe    80105527 <fetchint+0x22>
80105515:	8b 45 08             	mov    0x8(%ebp),%eax
80105518:	8d 50 04             	lea    0x4(%eax),%edx
8010551b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105521:	8b 00                	mov    (%eax),%eax
80105523:	39 c2                	cmp    %eax,%edx
80105525:	76 07                	jbe    8010552e <fetchint+0x29>
    return -1;
80105527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010552c:	eb 0f                	jmp    8010553d <fetchint+0x38>
  *ip = *(int*)(addr);
8010552e:	8b 45 08             	mov    0x8(%ebp),%eax
80105531:	8b 10                	mov    (%eax),%edx
80105533:	8b 45 0c             	mov    0xc(%ebp),%eax
80105536:	89 10                	mov    %edx,(%eax)
  return 0;
80105538:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010553d:	5d                   	pop    %ebp
8010553e:	c3                   	ret    

8010553f <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010553f:	55                   	push   %ebp
80105540:	89 e5                	mov    %esp,%ebp
80105542:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105545:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010554b:	8b 00                	mov    (%eax),%eax
8010554d:	3b 45 08             	cmp    0x8(%ebp),%eax
80105550:	77 07                	ja     80105559 <fetchstr+0x1a>
    return -1;
80105552:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105557:	eb 46                	jmp    8010559f <fetchstr+0x60>
  *pp = (char*)addr;
80105559:	8b 55 08             	mov    0x8(%ebp),%edx
8010555c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010555f:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105561:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105567:	8b 00                	mov    (%eax),%eax
80105569:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
8010556c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010556f:	8b 00                	mov    (%eax),%eax
80105571:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105574:	eb 1c                	jmp    80105592 <fetchstr+0x53>
    if(*s == 0)
80105576:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105579:	0f b6 00             	movzbl (%eax),%eax
8010557c:	84 c0                	test   %al,%al
8010557e:	75 0e                	jne    8010558e <fetchstr+0x4f>
      return s - *pp;
80105580:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105583:	8b 45 0c             	mov    0xc(%ebp),%eax
80105586:	8b 00                	mov    (%eax),%eax
80105588:	29 c2                	sub    %eax,%edx
8010558a:	89 d0                	mov    %edx,%eax
8010558c:	eb 11                	jmp    8010559f <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010558e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105592:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105595:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105598:	72 dc                	jb     80105576 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
8010559a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010559f:	c9                   	leave  
801055a0:	c3                   	ret    

801055a1 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801055a1:	55                   	push   %ebp
801055a2:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801055a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055aa:	8b 40 18             	mov    0x18(%eax),%eax
801055ad:	8b 40 44             	mov    0x44(%eax),%eax
801055b0:	8b 55 08             	mov    0x8(%ebp),%edx
801055b3:	c1 e2 02             	shl    $0x2,%edx
801055b6:	01 d0                	add    %edx,%eax
801055b8:	83 c0 04             	add    $0x4,%eax
801055bb:	ff 75 0c             	pushl  0xc(%ebp)
801055be:	50                   	push   %eax
801055bf:	e8 41 ff ff ff       	call   80105505 <fetchint>
801055c4:	83 c4 08             	add    $0x8,%esp
}
801055c7:	c9                   	leave  
801055c8:	c3                   	ret    

801055c9 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801055c9:	55                   	push   %ebp
801055ca:	89 e5                	mov    %esp,%ebp
801055cc:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
801055cf:	8d 45 fc             	lea    -0x4(%ebp),%eax
801055d2:	50                   	push   %eax
801055d3:	ff 75 08             	pushl  0x8(%ebp)
801055d6:	e8 c6 ff ff ff       	call   801055a1 <argint>
801055db:	83 c4 08             	add    $0x8,%esp
801055de:	85 c0                	test   %eax,%eax
801055e0:	79 07                	jns    801055e9 <argptr+0x20>
    return -1;
801055e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055e7:	eb 3d                	jmp    80105626 <argptr+0x5d>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801055e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055ec:	89 c2                	mov    %eax,%edx
801055ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055f4:	8b 00                	mov    (%eax),%eax
801055f6:	39 c2                	cmp    %eax,%edx
801055f8:	73 16                	jae    80105610 <argptr+0x47>
801055fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055fd:	89 c2                	mov    %eax,%edx
801055ff:	8b 45 10             	mov    0x10(%ebp),%eax
80105602:	01 c2                	add    %eax,%edx
80105604:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010560a:	8b 00                	mov    (%eax),%eax
8010560c:	39 c2                	cmp    %eax,%edx
8010560e:	76 07                	jbe    80105617 <argptr+0x4e>
    return -1;
80105610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105615:	eb 0f                	jmp    80105626 <argptr+0x5d>
  *pp = (char*)i;
80105617:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010561a:	89 c2                	mov    %eax,%edx
8010561c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010561f:	89 10                	mov    %edx,(%eax)
  return 0;
80105621:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105626:	c9                   	leave  
80105627:	c3                   	ret    

80105628 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105628:	55                   	push   %ebp
80105629:	89 e5                	mov    %esp,%ebp
8010562b:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010562e:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105631:	50                   	push   %eax
80105632:	ff 75 08             	pushl  0x8(%ebp)
80105635:	e8 67 ff ff ff       	call   801055a1 <argint>
8010563a:	83 c4 08             	add    $0x8,%esp
8010563d:	85 c0                	test   %eax,%eax
8010563f:	79 07                	jns    80105648 <argstr+0x20>
    return -1;
80105641:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105646:	eb 0f                	jmp    80105657 <argstr+0x2f>
  return fetchstr(addr, pp);
80105648:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010564b:	ff 75 0c             	pushl  0xc(%ebp)
8010564e:	50                   	push   %eax
8010564f:	e8 eb fe ff ff       	call   8010553f <fetchstr>
80105654:	83 c4 08             	add    $0x8,%esp
}
80105657:	c9                   	leave  
80105658:	c3                   	ret    

80105659 <syscall>:
[SYS_pstat]   sys_pstat,
};

void
syscall(void)
{
80105659:	55                   	push   %ebp
8010565a:	89 e5                	mov    %esp,%ebp
8010565c:	53                   	push   %ebx
8010565d:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80105660:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105666:	8b 40 18             	mov    0x18(%eax),%eax
80105669:	8b 40 1c             	mov    0x1c(%eax),%eax
8010566c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010566f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105673:	7e 30                	jle    801056a5 <syscall+0x4c>
80105675:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105678:	83 f8 16             	cmp    $0x16,%eax
8010567b:	77 28                	ja     801056a5 <syscall+0x4c>
8010567d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105680:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105687:	85 c0                	test   %eax,%eax
80105689:	74 1a                	je     801056a5 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
8010568b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105691:	8b 58 18             	mov    0x18(%eax),%ebx
80105694:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105697:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010569e:	ff d0                	call   *%eax
801056a0:	89 43 1c             	mov    %eax,0x1c(%ebx)
801056a3:	eb 34                	jmp    801056d9 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801056a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056ab:	8d 50 6c             	lea    0x6c(%eax),%edx
801056ae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801056b4:	8b 40 10             	mov    0x10(%eax),%eax
801056b7:	ff 75 f4             	pushl  -0xc(%ebp)
801056ba:	52                   	push   %edx
801056bb:	50                   	push   %eax
801056bc:	68 d3 89 10 80       	push   $0x801089d3
801056c1:	e8 f9 ac ff ff       	call   801003bf <cprintf>
801056c6:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801056c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056cf:	8b 40 18             	mov    0x18(%eax),%eax
801056d2:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801056d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056dc:	c9                   	leave  
801056dd:	c3                   	ret    

801056de <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801056de:	55                   	push   %ebp
801056df:	89 e5                	mov    %esp,%ebp
801056e1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801056e4:	83 ec 08             	sub    $0x8,%esp
801056e7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056ea:	50                   	push   %eax
801056eb:	ff 75 08             	pushl  0x8(%ebp)
801056ee:	e8 ae fe ff ff       	call   801055a1 <argint>
801056f3:	83 c4 10             	add    $0x10,%esp
801056f6:	85 c0                	test   %eax,%eax
801056f8:	79 07                	jns    80105701 <argfd+0x23>
    return -1;
801056fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ff:	eb 50                	jmp    80105751 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105701:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105704:	85 c0                	test   %eax,%eax
80105706:	78 21                	js     80105729 <argfd+0x4b>
80105708:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010570b:	83 f8 0f             	cmp    $0xf,%eax
8010570e:	7f 19                	jg     80105729 <argfd+0x4b>
80105710:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105716:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105719:	83 c2 08             	add    $0x8,%edx
8010571c:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105720:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105723:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105727:	75 07                	jne    80105730 <argfd+0x52>
    return -1;
80105729:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010572e:	eb 21                	jmp    80105751 <argfd+0x73>
  if(pfd)
80105730:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105734:	74 08                	je     8010573e <argfd+0x60>
    *pfd = fd;
80105736:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105739:	8b 45 0c             	mov    0xc(%ebp),%eax
8010573c:	89 10                	mov    %edx,(%eax)
  if(pf)
8010573e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105742:	74 08                	je     8010574c <argfd+0x6e>
    *pf = f;
80105744:	8b 45 10             	mov    0x10(%ebp),%eax
80105747:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010574a:	89 10                	mov    %edx,(%eax)
  return 0;
8010574c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105751:	c9                   	leave  
80105752:	c3                   	ret    

80105753 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105753:	55                   	push   %ebp
80105754:	89 e5                	mov    %esp,%ebp
80105756:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105759:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105760:	eb 30                	jmp    80105792 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105762:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105768:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010576b:	83 c2 08             	add    $0x8,%edx
8010576e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105772:	85 c0                	test   %eax,%eax
80105774:	75 18                	jne    8010578e <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105776:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010577c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010577f:	8d 4a 08             	lea    0x8(%edx),%ecx
80105782:	8b 55 08             	mov    0x8(%ebp),%edx
80105785:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105789:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010578c:	eb 0f                	jmp    8010579d <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010578e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105792:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105796:	7e ca                	jle    80105762 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105798:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010579d:	c9                   	leave  
8010579e:	c3                   	ret    

8010579f <sys_dup>:

int
sys_dup(void)
{
8010579f:	55                   	push   %ebp
801057a0:	89 e5                	mov    %esp,%ebp
801057a2:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801057a5:	83 ec 04             	sub    $0x4,%esp
801057a8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057ab:	50                   	push   %eax
801057ac:	6a 00                	push   $0x0
801057ae:	6a 00                	push   $0x0
801057b0:	e8 29 ff ff ff       	call   801056de <argfd>
801057b5:	83 c4 10             	add    $0x10,%esp
801057b8:	85 c0                	test   %eax,%eax
801057ba:	79 07                	jns    801057c3 <sys_dup+0x24>
    return -1;
801057bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c1:	eb 31                	jmp    801057f4 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801057c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057c6:	83 ec 0c             	sub    $0xc,%esp
801057c9:	50                   	push   %eax
801057ca:	e8 84 ff ff ff       	call   80105753 <fdalloc>
801057cf:	83 c4 10             	add    $0x10,%esp
801057d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801057d9:	79 07                	jns    801057e2 <sys_dup+0x43>
    return -1;
801057db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e0:	eb 12                	jmp    801057f4 <sys_dup+0x55>
  filedup(f);
801057e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057e5:	83 ec 0c             	sub    $0xc,%esp
801057e8:	50                   	push   %eax
801057e9:	e8 f1 b7 ff ff       	call   80100fdf <filedup>
801057ee:	83 c4 10             	add    $0x10,%esp
  return fd;
801057f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801057f4:	c9                   	leave  
801057f5:	c3                   	ret    

801057f6 <sys_read>:

int
sys_read(void)
{
801057f6:	55                   	push   %ebp
801057f7:	89 e5                	mov    %esp,%ebp
801057f9:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801057fc:	83 ec 04             	sub    $0x4,%esp
801057ff:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105802:	50                   	push   %eax
80105803:	6a 00                	push   $0x0
80105805:	6a 00                	push   $0x0
80105807:	e8 d2 fe ff ff       	call   801056de <argfd>
8010580c:	83 c4 10             	add    $0x10,%esp
8010580f:	85 c0                	test   %eax,%eax
80105811:	78 2e                	js     80105841 <sys_read+0x4b>
80105813:	83 ec 08             	sub    $0x8,%esp
80105816:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105819:	50                   	push   %eax
8010581a:	6a 02                	push   $0x2
8010581c:	e8 80 fd ff ff       	call   801055a1 <argint>
80105821:	83 c4 10             	add    $0x10,%esp
80105824:	85 c0                	test   %eax,%eax
80105826:	78 19                	js     80105841 <sys_read+0x4b>
80105828:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010582b:	83 ec 04             	sub    $0x4,%esp
8010582e:	50                   	push   %eax
8010582f:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105832:	50                   	push   %eax
80105833:	6a 01                	push   $0x1
80105835:	e8 8f fd ff ff       	call   801055c9 <argptr>
8010583a:	83 c4 10             	add    $0x10,%esp
8010583d:	85 c0                	test   %eax,%eax
8010583f:	79 07                	jns    80105848 <sys_read+0x52>
    return -1;
80105841:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105846:	eb 17                	jmp    8010585f <sys_read+0x69>
  return fileread(f, p, n);
80105848:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010584b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010584e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105851:	83 ec 04             	sub    $0x4,%esp
80105854:	51                   	push   %ecx
80105855:	52                   	push   %edx
80105856:	50                   	push   %eax
80105857:	e8 13 b9 ff ff       	call   8010116f <fileread>
8010585c:	83 c4 10             	add    $0x10,%esp
}
8010585f:	c9                   	leave  
80105860:	c3                   	ret    

80105861 <sys_write>:

int
sys_write(void)
{
80105861:	55                   	push   %ebp
80105862:	89 e5                	mov    %esp,%ebp
80105864:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105867:	83 ec 04             	sub    $0x4,%esp
8010586a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010586d:	50                   	push   %eax
8010586e:	6a 00                	push   $0x0
80105870:	6a 00                	push   $0x0
80105872:	e8 67 fe ff ff       	call   801056de <argfd>
80105877:	83 c4 10             	add    $0x10,%esp
8010587a:	85 c0                	test   %eax,%eax
8010587c:	78 2e                	js     801058ac <sys_write+0x4b>
8010587e:	83 ec 08             	sub    $0x8,%esp
80105881:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105884:	50                   	push   %eax
80105885:	6a 02                	push   $0x2
80105887:	e8 15 fd ff ff       	call   801055a1 <argint>
8010588c:	83 c4 10             	add    $0x10,%esp
8010588f:	85 c0                	test   %eax,%eax
80105891:	78 19                	js     801058ac <sys_write+0x4b>
80105893:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105896:	83 ec 04             	sub    $0x4,%esp
80105899:	50                   	push   %eax
8010589a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010589d:	50                   	push   %eax
8010589e:	6a 01                	push   $0x1
801058a0:	e8 24 fd ff ff       	call   801055c9 <argptr>
801058a5:	83 c4 10             	add    $0x10,%esp
801058a8:	85 c0                	test   %eax,%eax
801058aa:	79 07                	jns    801058b3 <sys_write+0x52>
    return -1;
801058ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058b1:	eb 17                	jmp    801058ca <sys_write+0x69>
  return filewrite(f, p, n);
801058b3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801058b6:	8b 55 ec             	mov    -0x14(%ebp),%edx
801058b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058bc:	83 ec 04             	sub    $0x4,%esp
801058bf:	51                   	push   %ecx
801058c0:	52                   	push   %edx
801058c1:	50                   	push   %eax
801058c2:	e8 60 b9 ff ff       	call   80101227 <filewrite>
801058c7:	83 c4 10             	add    $0x10,%esp
}
801058ca:	c9                   	leave  
801058cb:	c3                   	ret    

801058cc <sys_close>:

int
sys_close(void)
{
801058cc:	55                   	push   %ebp
801058cd:	89 e5                	mov    %esp,%ebp
801058cf:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801058d2:	83 ec 04             	sub    $0x4,%esp
801058d5:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058d8:	50                   	push   %eax
801058d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058dc:	50                   	push   %eax
801058dd:	6a 00                	push   $0x0
801058df:	e8 fa fd ff ff       	call   801056de <argfd>
801058e4:	83 c4 10             	add    $0x10,%esp
801058e7:	85 c0                	test   %eax,%eax
801058e9:	79 07                	jns    801058f2 <sys_close+0x26>
    return -1;
801058eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058f0:	eb 28                	jmp    8010591a <sys_close+0x4e>
  proc->ofile[fd] = 0;
801058f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058fb:	83 c2 08             	add    $0x8,%edx
801058fe:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105905:	00 
  fileclose(f);
80105906:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105909:	83 ec 0c             	sub    $0xc,%esp
8010590c:	50                   	push   %eax
8010590d:	e8 1e b7 ff ff       	call   80101030 <fileclose>
80105912:	83 c4 10             	add    $0x10,%esp
  return 0;
80105915:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010591a:	c9                   	leave  
8010591b:	c3                   	ret    

8010591c <sys_fstat>:

int
sys_fstat(void)
{
8010591c:	55                   	push   %ebp
8010591d:	89 e5                	mov    %esp,%ebp
8010591f:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105922:	83 ec 04             	sub    $0x4,%esp
80105925:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105928:	50                   	push   %eax
80105929:	6a 00                	push   $0x0
8010592b:	6a 00                	push   $0x0
8010592d:	e8 ac fd ff ff       	call   801056de <argfd>
80105932:	83 c4 10             	add    $0x10,%esp
80105935:	85 c0                	test   %eax,%eax
80105937:	78 17                	js     80105950 <sys_fstat+0x34>
80105939:	83 ec 04             	sub    $0x4,%esp
8010593c:	6a 14                	push   $0x14
8010593e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105941:	50                   	push   %eax
80105942:	6a 01                	push   $0x1
80105944:	e8 80 fc ff ff       	call   801055c9 <argptr>
80105949:	83 c4 10             	add    $0x10,%esp
8010594c:	85 c0                	test   %eax,%eax
8010594e:	79 07                	jns    80105957 <sys_fstat+0x3b>
    return -1;
80105950:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105955:	eb 13                	jmp    8010596a <sys_fstat+0x4e>
  return filestat(f, st);
80105957:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010595a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010595d:	83 ec 08             	sub    $0x8,%esp
80105960:	52                   	push   %edx
80105961:	50                   	push   %eax
80105962:	e8 b1 b7 ff ff       	call   80101118 <filestat>
80105967:	83 c4 10             	add    $0x10,%esp
}
8010596a:	c9                   	leave  
8010596b:	c3                   	ret    

8010596c <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
8010596c:	55                   	push   %ebp
8010596d:	89 e5                	mov    %esp,%ebp
8010596f:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105972:	83 ec 08             	sub    $0x8,%esp
80105975:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105978:	50                   	push   %eax
80105979:	6a 00                	push   $0x0
8010597b:	e8 a8 fc ff ff       	call   80105628 <argstr>
80105980:	83 c4 10             	add    $0x10,%esp
80105983:	85 c0                	test   %eax,%eax
80105985:	78 15                	js     8010599c <sys_link+0x30>
80105987:	83 ec 08             	sub    $0x8,%esp
8010598a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010598d:	50                   	push   %eax
8010598e:	6a 01                	push   $0x1
80105990:	e8 93 fc ff ff       	call   80105628 <argstr>
80105995:	83 c4 10             	add    $0x10,%esp
80105998:	85 c0                	test   %eax,%eax
8010599a:	79 0a                	jns    801059a6 <sys_link+0x3a>
    return -1;
8010599c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059a1:	e9 69 01 00 00       	jmp    80105b0f <sys_link+0x1a3>

  begin_op();
801059a6:	e8 de da ff ff       	call   80103489 <begin_op>
  if((ip = namei(old)) == 0){
801059ab:	8b 45 d8             	mov    -0x28(%ebp),%eax
801059ae:	83 ec 0c             	sub    $0xc,%esp
801059b1:	50                   	push   %eax
801059b2:	e8 fd ca ff ff       	call   801024b4 <namei>
801059b7:	83 c4 10             	add    $0x10,%esp
801059ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
801059bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801059c1:	75 0f                	jne    801059d2 <sys_link+0x66>
    end_op();
801059c3:	e8 4f db ff ff       	call   80103517 <end_op>
    return -1;
801059c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059cd:	e9 3d 01 00 00       	jmp    80105b0f <sys_link+0x1a3>
  }

  ilock(ip);
801059d2:	83 ec 0c             	sub    $0xc,%esp
801059d5:	ff 75 f4             	pushl  -0xc(%ebp)
801059d8:	e8 22 bf ff ff       	call   801018ff <ilock>
801059dd:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
801059e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059e3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801059e7:	66 83 f8 01          	cmp    $0x1,%ax
801059eb:	75 1d                	jne    80105a0a <sys_link+0x9e>
    iunlockput(ip);
801059ed:	83 ec 0c             	sub    $0xc,%esp
801059f0:	ff 75 f4             	pushl  -0xc(%ebp)
801059f3:	e8 be c1 ff ff       	call   80101bb6 <iunlockput>
801059f8:	83 c4 10             	add    $0x10,%esp
    end_op();
801059fb:	e8 17 db ff ff       	call   80103517 <end_op>
    return -1;
80105a00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a05:	e9 05 01 00 00       	jmp    80105b0f <sys_link+0x1a3>
  }

  ip->nlink++;
80105a0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a0d:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a11:	83 c0 01             	add    $0x1,%eax
80105a14:	89 c2                	mov    %eax,%edx
80105a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a19:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105a1d:	83 ec 0c             	sub    $0xc,%esp
80105a20:	ff 75 f4             	pushl  -0xc(%ebp)
80105a23:	e8 04 bd ff ff       	call   8010172c <iupdate>
80105a28:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105a2b:	83 ec 0c             	sub    $0xc,%esp
80105a2e:	ff 75 f4             	pushl  -0xc(%ebp)
80105a31:	e8 20 c0 ff ff       	call   80101a56 <iunlock>
80105a36:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105a39:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a3c:	83 ec 08             	sub    $0x8,%esp
80105a3f:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105a42:	52                   	push   %edx
80105a43:	50                   	push   %eax
80105a44:	e8 87 ca ff ff       	call   801024d0 <nameiparent>
80105a49:	83 c4 10             	add    $0x10,%esp
80105a4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105a4f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105a53:	75 02                	jne    80105a57 <sys_link+0xeb>
    goto bad;
80105a55:	eb 71                	jmp    80105ac8 <sys_link+0x15c>
  ilock(dp);
80105a57:	83 ec 0c             	sub    $0xc,%esp
80105a5a:	ff 75 f0             	pushl  -0x10(%ebp)
80105a5d:	e8 9d be ff ff       	call   801018ff <ilock>
80105a62:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a68:	8b 10                	mov    (%eax),%edx
80105a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a6d:	8b 00                	mov    (%eax),%eax
80105a6f:	39 c2                	cmp    %eax,%edx
80105a71:	75 1d                	jne    80105a90 <sys_link+0x124>
80105a73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a76:	8b 40 04             	mov    0x4(%eax),%eax
80105a79:	83 ec 04             	sub    $0x4,%esp
80105a7c:	50                   	push   %eax
80105a7d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105a80:	50                   	push   %eax
80105a81:	ff 75 f0             	pushl  -0x10(%ebp)
80105a84:	e8 93 c7 ff ff       	call   8010221c <dirlink>
80105a89:	83 c4 10             	add    $0x10,%esp
80105a8c:	85 c0                	test   %eax,%eax
80105a8e:	79 10                	jns    80105aa0 <sys_link+0x134>
    iunlockput(dp);
80105a90:	83 ec 0c             	sub    $0xc,%esp
80105a93:	ff 75 f0             	pushl  -0x10(%ebp)
80105a96:	e8 1b c1 ff ff       	call   80101bb6 <iunlockput>
80105a9b:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105a9e:	eb 28                	jmp    80105ac8 <sys_link+0x15c>
  }
  iunlockput(dp);
80105aa0:	83 ec 0c             	sub    $0xc,%esp
80105aa3:	ff 75 f0             	pushl  -0x10(%ebp)
80105aa6:	e8 0b c1 ff ff       	call   80101bb6 <iunlockput>
80105aab:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105aae:	83 ec 0c             	sub    $0xc,%esp
80105ab1:	ff 75 f4             	pushl  -0xc(%ebp)
80105ab4:	e8 0e c0 ff ff       	call   80101ac7 <iput>
80105ab9:	83 c4 10             	add    $0x10,%esp

  end_op();
80105abc:	e8 56 da ff ff       	call   80103517 <end_op>

  return 0;
80105ac1:	b8 00 00 00 00       	mov    $0x0,%eax
80105ac6:	eb 47                	jmp    80105b0f <sys_link+0x1a3>

bad:
  ilock(ip);
80105ac8:	83 ec 0c             	sub    $0xc,%esp
80105acb:	ff 75 f4             	pushl  -0xc(%ebp)
80105ace:	e8 2c be ff ff       	call   801018ff <ilock>
80105ad3:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105ad6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ad9:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105add:	83 e8 01             	sub    $0x1,%eax
80105ae0:	89 c2                	mov    %eax,%edx
80105ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae5:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105ae9:	83 ec 0c             	sub    $0xc,%esp
80105aec:	ff 75 f4             	pushl  -0xc(%ebp)
80105aef:	e8 38 bc ff ff       	call   8010172c <iupdate>
80105af4:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105af7:	83 ec 0c             	sub    $0xc,%esp
80105afa:	ff 75 f4             	pushl  -0xc(%ebp)
80105afd:	e8 b4 c0 ff ff       	call   80101bb6 <iunlockput>
80105b02:	83 c4 10             	add    $0x10,%esp
  end_op();
80105b05:	e8 0d da ff ff       	call   80103517 <end_op>
  return -1;
80105b0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b0f:	c9                   	leave  
80105b10:	c3                   	ret    

80105b11 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105b11:	55                   	push   %ebp
80105b12:	89 e5                	mov    %esp,%ebp
80105b14:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105b17:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105b1e:	eb 40                	jmp    80105b60 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105b20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b23:	6a 10                	push   $0x10
80105b25:	50                   	push   %eax
80105b26:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b29:	50                   	push   %eax
80105b2a:	ff 75 08             	pushl  0x8(%ebp)
80105b2d:	e8 2f c3 ff ff       	call   80101e61 <readi>
80105b32:	83 c4 10             	add    $0x10,%esp
80105b35:	83 f8 10             	cmp    $0x10,%eax
80105b38:	74 0d                	je     80105b47 <isdirempty+0x36>
      panic("isdirempty: readi");
80105b3a:	83 ec 0c             	sub    $0xc,%esp
80105b3d:	68 ef 89 10 80       	push   $0x801089ef
80105b42:	e8 15 aa ff ff       	call   8010055c <panic>
    if(de.inum != 0)
80105b47:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105b4b:	66 85 c0             	test   %ax,%ax
80105b4e:	74 07                	je     80105b57 <isdirempty+0x46>
      return 0;
80105b50:	b8 00 00 00 00       	mov    $0x0,%eax
80105b55:	eb 1b                	jmp    80105b72 <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105b57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b5a:	83 c0 10             	add    $0x10,%eax
80105b5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b60:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b63:	8b 45 08             	mov    0x8(%ebp),%eax
80105b66:	8b 40 18             	mov    0x18(%eax),%eax
80105b69:	39 c2                	cmp    %eax,%edx
80105b6b:	72 b3                	jb     80105b20 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105b6d:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105b72:	c9                   	leave  
80105b73:	c3                   	ret    

80105b74 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105b74:	55                   	push   %ebp
80105b75:	89 e5                	mov    %esp,%ebp
80105b77:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105b7a:	83 ec 08             	sub    $0x8,%esp
80105b7d:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105b80:	50                   	push   %eax
80105b81:	6a 00                	push   $0x0
80105b83:	e8 a0 fa ff ff       	call   80105628 <argstr>
80105b88:	83 c4 10             	add    $0x10,%esp
80105b8b:	85 c0                	test   %eax,%eax
80105b8d:	79 0a                	jns    80105b99 <sys_unlink+0x25>
    return -1;
80105b8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b94:	e9 bc 01 00 00       	jmp    80105d55 <sys_unlink+0x1e1>

  begin_op();
80105b99:	e8 eb d8 ff ff       	call   80103489 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105b9e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105ba1:	83 ec 08             	sub    $0x8,%esp
80105ba4:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105ba7:	52                   	push   %edx
80105ba8:	50                   	push   %eax
80105ba9:	e8 22 c9 ff ff       	call   801024d0 <nameiparent>
80105bae:	83 c4 10             	add    $0x10,%esp
80105bb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105bb4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105bb8:	75 0f                	jne    80105bc9 <sys_unlink+0x55>
    end_op();
80105bba:	e8 58 d9 ff ff       	call   80103517 <end_op>
    return -1;
80105bbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc4:	e9 8c 01 00 00       	jmp    80105d55 <sys_unlink+0x1e1>
  }

  ilock(dp);
80105bc9:	83 ec 0c             	sub    $0xc,%esp
80105bcc:	ff 75 f4             	pushl  -0xc(%ebp)
80105bcf:	e8 2b bd ff ff       	call   801018ff <ilock>
80105bd4:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105bd7:	83 ec 08             	sub    $0x8,%esp
80105bda:	68 01 8a 10 80       	push   $0x80108a01
80105bdf:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105be2:	50                   	push   %eax
80105be3:	e8 5e c5 ff ff       	call   80102146 <namecmp>
80105be8:	83 c4 10             	add    $0x10,%esp
80105beb:	85 c0                	test   %eax,%eax
80105bed:	0f 84 4a 01 00 00    	je     80105d3d <sys_unlink+0x1c9>
80105bf3:	83 ec 08             	sub    $0x8,%esp
80105bf6:	68 03 8a 10 80       	push   $0x80108a03
80105bfb:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105bfe:	50                   	push   %eax
80105bff:	e8 42 c5 ff ff       	call   80102146 <namecmp>
80105c04:	83 c4 10             	add    $0x10,%esp
80105c07:	85 c0                	test   %eax,%eax
80105c09:	0f 84 2e 01 00 00    	je     80105d3d <sys_unlink+0x1c9>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105c0f:	83 ec 04             	sub    $0x4,%esp
80105c12:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105c15:	50                   	push   %eax
80105c16:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105c19:	50                   	push   %eax
80105c1a:	ff 75 f4             	pushl  -0xc(%ebp)
80105c1d:	e8 3f c5 ff ff       	call   80102161 <dirlookup>
80105c22:	83 c4 10             	add    $0x10,%esp
80105c25:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105c28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105c2c:	75 05                	jne    80105c33 <sys_unlink+0xbf>
    goto bad;
80105c2e:	e9 0a 01 00 00       	jmp    80105d3d <sys_unlink+0x1c9>
  ilock(ip);
80105c33:	83 ec 0c             	sub    $0xc,%esp
80105c36:	ff 75 f0             	pushl  -0x10(%ebp)
80105c39:	e8 c1 bc ff ff       	call   801018ff <ilock>
80105c3e:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c44:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c48:	66 85 c0             	test   %ax,%ax
80105c4b:	7f 0d                	jg     80105c5a <sys_unlink+0xe6>
    panic("unlink: nlink < 1");
80105c4d:	83 ec 0c             	sub    $0xc,%esp
80105c50:	68 06 8a 10 80       	push   $0x80108a06
80105c55:	e8 02 a9 ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c5d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c61:	66 83 f8 01          	cmp    $0x1,%ax
80105c65:	75 25                	jne    80105c8c <sys_unlink+0x118>
80105c67:	83 ec 0c             	sub    $0xc,%esp
80105c6a:	ff 75 f0             	pushl  -0x10(%ebp)
80105c6d:	e8 9f fe ff ff       	call   80105b11 <isdirempty>
80105c72:	83 c4 10             	add    $0x10,%esp
80105c75:	85 c0                	test   %eax,%eax
80105c77:	75 13                	jne    80105c8c <sys_unlink+0x118>
    iunlockput(ip);
80105c79:	83 ec 0c             	sub    $0xc,%esp
80105c7c:	ff 75 f0             	pushl  -0x10(%ebp)
80105c7f:	e8 32 bf ff ff       	call   80101bb6 <iunlockput>
80105c84:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105c87:	e9 b1 00 00 00       	jmp    80105d3d <sys_unlink+0x1c9>
  }

  memset(&de, 0, sizeof(de));
80105c8c:	83 ec 04             	sub    $0x4,%esp
80105c8f:	6a 10                	push   $0x10
80105c91:	6a 00                	push   $0x0
80105c93:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c96:	50                   	push   %eax
80105c97:	e8 de f5 ff ff       	call   8010527a <memset>
80105c9c:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105ca2:	6a 10                	push   $0x10
80105ca4:	50                   	push   %eax
80105ca5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ca8:	50                   	push   %eax
80105ca9:	ff 75 f4             	pushl  -0xc(%ebp)
80105cac:	e8 0a c3 ff ff       	call   80101fbb <writei>
80105cb1:	83 c4 10             	add    $0x10,%esp
80105cb4:	83 f8 10             	cmp    $0x10,%eax
80105cb7:	74 0d                	je     80105cc6 <sys_unlink+0x152>
    panic("unlink: writei");
80105cb9:	83 ec 0c             	sub    $0xc,%esp
80105cbc:	68 18 8a 10 80       	push   $0x80108a18
80105cc1:	e8 96 a8 ff ff       	call   8010055c <panic>
  if(ip->type == T_DIR){
80105cc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cc9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105ccd:	66 83 f8 01          	cmp    $0x1,%ax
80105cd1:	75 21                	jne    80105cf4 <sys_unlink+0x180>
    dp->nlink--;
80105cd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd6:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105cda:	83 e8 01             	sub    $0x1,%eax
80105cdd:	89 c2                	mov    %eax,%edx
80105cdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ce2:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105ce6:	83 ec 0c             	sub    $0xc,%esp
80105ce9:	ff 75 f4             	pushl  -0xc(%ebp)
80105cec:	e8 3b ba ff ff       	call   8010172c <iupdate>
80105cf1:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105cf4:	83 ec 0c             	sub    $0xc,%esp
80105cf7:	ff 75 f4             	pushl  -0xc(%ebp)
80105cfa:	e8 b7 be ff ff       	call   80101bb6 <iunlockput>
80105cff:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105d02:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d05:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105d09:	83 e8 01             	sub    $0x1,%eax
80105d0c:	89 c2                	mov    %eax,%edx
80105d0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d11:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105d15:	83 ec 0c             	sub    $0xc,%esp
80105d18:	ff 75 f0             	pushl  -0x10(%ebp)
80105d1b:	e8 0c ba ff ff       	call   8010172c <iupdate>
80105d20:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105d23:	83 ec 0c             	sub    $0xc,%esp
80105d26:	ff 75 f0             	pushl  -0x10(%ebp)
80105d29:	e8 88 be ff ff       	call   80101bb6 <iunlockput>
80105d2e:	83 c4 10             	add    $0x10,%esp

  end_op();
80105d31:	e8 e1 d7 ff ff       	call   80103517 <end_op>

  return 0;
80105d36:	b8 00 00 00 00       	mov    $0x0,%eax
80105d3b:	eb 18                	jmp    80105d55 <sys_unlink+0x1e1>

bad:
  iunlockput(dp);
80105d3d:	83 ec 0c             	sub    $0xc,%esp
80105d40:	ff 75 f4             	pushl  -0xc(%ebp)
80105d43:	e8 6e be ff ff       	call   80101bb6 <iunlockput>
80105d48:	83 c4 10             	add    $0x10,%esp
  end_op();
80105d4b:	e8 c7 d7 ff ff       	call   80103517 <end_op>
  return -1;
80105d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d55:	c9                   	leave  
80105d56:	c3                   	ret    

80105d57 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105d57:	55                   	push   %ebp
80105d58:	89 e5                	mov    %esp,%ebp
80105d5a:	83 ec 38             	sub    $0x38,%esp
80105d5d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105d60:	8b 55 10             	mov    0x10(%ebp),%edx
80105d63:	8b 45 14             	mov    0x14(%ebp),%eax
80105d66:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105d6a:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105d6e:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105d72:	83 ec 08             	sub    $0x8,%esp
80105d75:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d78:	50                   	push   %eax
80105d79:	ff 75 08             	pushl  0x8(%ebp)
80105d7c:	e8 4f c7 ff ff       	call   801024d0 <nameiparent>
80105d81:	83 c4 10             	add    $0x10,%esp
80105d84:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d87:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d8b:	75 0a                	jne    80105d97 <create+0x40>
    return 0;
80105d8d:	b8 00 00 00 00       	mov    $0x0,%eax
80105d92:	e9 90 01 00 00       	jmp    80105f27 <create+0x1d0>
  ilock(dp);
80105d97:	83 ec 0c             	sub    $0xc,%esp
80105d9a:	ff 75 f4             	pushl  -0xc(%ebp)
80105d9d:	e8 5d bb ff ff       	call   801018ff <ilock>
80105da2:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105da5:	83 ec 04             	sub    $0x4,%esp
80105da8:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105dab:	50                   	push   %eax
80105dac:	8d 45 de             	lea    -0x22(%ebp),%eax
80105daf:	50                   	push   %eax
80105db0:	ff 75 f4             	pushl  -0xc(%ebp)
80105db3:	e8 a9 c3 ff ff       	call   80102161 <dirlookup>
80105db8:	83 c4 10             	add    $0x10,%esp
80105dbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105dbe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105dc2:	74 50                	je     80105e14 <create+0xbd>
    iunlockput(dp);
80105dc4:	83 ec 0c             	sub    $0xc,%esp
80105dc7:	ff 75 f4             	pushl  -0xc(%ebp)
80105dca:	e8 e7 bd ff ff       	call   80101bb6 <iunlockput>
80105dcf:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105dd2:	83 ec 0c             	sub    $0xc,%esp
80105dd5:	ff 75 f0             	pushl  -0x10(%ebp)
80105dd8:	e8 22 bb ff ff       	call   801018ff <ilock>
80105ddd:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105de0:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105de5:	75 15                	jne    80105dfc <create+0xa5>
80105de7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dea:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105dee:	66 83 f8 02          	cmp    $0x2,%ax
80105df2:	75 08                	jne    80105dfc <create+0xa5>
      return ip;
80105df4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105df7:	e9 2b 01 00 00       	jmp    80105f27 <create+0x1d0>
    iunlockput(ip);
80105dfc:	83 ec 0c             	sub    $0xc,%esp
80105dff:	ff 75 f0             	pushl  -0x10(%ebp)
80105e02:	e8 af bd ff ff       	call   80101bb6 <iunlockput>
80105e07:	83 c4 10             	add    $0x10,%esp
    return 0;
80105e0a:	b8 00 00 00 00       	mov    $0x0,%eax
80105e0f:	e9 13 01 00 00       	jmp    80105f27 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105e14:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105e18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e1b:	8b 00                	mov    (%eax),%eax
80105e1d:	83 ec 08             	sub    $0x8,%esp
80105e20:	52                   	push   %edx
80105e21:	50                   	push   %eax
80105e22:	e8 24 b8 ff ff       	call   8010164b <ialloc>
80105e27:	83 c4 10             	add    $0x10,%esp
80105e2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e2d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e31:	75 0d                	jne    80105e40 <create+0xe9>
    panic("create: ialloc");
80105e33:	83 ec 0c             	sub    $0xc,%esp
80105e36:	68 27 8a 10 80       	push   $0x80108a27
80105e3b:	e8 1c a7 ff ff       	call   8010055c <panic>

  ilock(ip);
80105e40:	83 ec 0c             	sub    $0xc,%esp
80105e43:	ff 75 f0             	pushl  -0x10(%ebp)
80105e46:	e8 b4 ba ff ff       	call   801018ff <ilock>
80105e4b:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105e4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e51:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105e55:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105e59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e5c:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105e60:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105e64:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e67:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105e6d:	83 ec 0c             	sub    $0xc,%esp
80105e70:	ff 75 f0             	pushl  -0x10(%ebp)
80105e73:	e8 b4 b8 ff ff       	call   8010172c <iupdate>
80105e78:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105e7b:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105e80:	75 6a                	jne    80105eec <create+0x195>
    dp->nlink++;  // for ".."
80105e82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e85:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105e89:	83 c0 01             	add    $0x1,%eax
80105e8c:	89 c2                	mov    %eax,%edx
80105e8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e91:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105e95:	83 ec 0c             	sub    $0xc,%esp
80105e98:	ff 75 f4             	pushl  -0xc(%ebp)
80105e9b:	e8 8c b8 ff ff       	call   8010172c <iupdate>
80105ea0:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105ea3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ea6:	8b 40 04             	mov    0x4(%eax),%eax
80105ea9:	83 ec 04             	sub    $0x4,%esp
80105eac:	50                   	push   %eax
80105ead:	68 01 8a 10 80       	push   $0x80108a01
80105eb2:	ff 75 f0             	pushl  -0x10(%ebp)
80105eb5:	e8 62 c3 ff ff       	call   8010221c <dirlink>
80105eba:	83 c4 10             	add    $0x10,%esp
80105ebd:	85 c0                	test   %eax,%eax
80105ebf:	78 1e                	js     80105edf <create+0x188>
80105ec1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ec4:	8b 40 04             	mov    0x4(%eax),%eax
80105ec7:	83 ec 04             	sub    $0x4,%esp
80105eca:	50                   	push   %eax
80105ecb:	68 03 8a 10 80       	push   $0x80108a03
80105ed0:	ff 75 f0             	pushl  -0x10(%ebp)
80105ed3:	e8 44 c3 ff ff       	call   8010221c <dirlink>
80105ed8:	83 c4 10             	add    $0x10,%esp
80105edb:	85 c0                	test   %eax,%eax
80105edd:	79 0d                	jns    80105eec <create+0x195>
      panic("create dots");
80105edf:	83 ec 0c             	sub    $0xc,%esp
80105ee2:	68 36 8a 10 80       	push   $0x80108a36
80105ee7:	e8 70 a6 ff ff       	call   8010055c <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105eec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105eef:	8b 40 04             	mov    0x4(%eax),%eax
80105ef2:	83 ec 04             	sub    $0x4,%esp
80105ef5:	50                   	push   %eax
80105ef6:	8d 45 de             	lea    -0x22(%ebp),%eax
80105ef9:	50                   	push   %eax
80105efa:	ff 75 f4             	pushl  -0xc(%ebp)
80105efd:	e8 1a c3 ff ff       	call   8010221c <dirlink>
80105f02:	83 c4 10             	add    $0x10,%esp
80105f05:	85 c0                	test   %eax,%eax
80105f07:	79 0d                	jns    80105f16 <create+0x1bf>
    panic("create: dirlink");
80105f09:	83 ec 0c             	sub    $0xc,%esp
80105f0c:	68 42 8a 10 80       	push   $0x80108a42
80105f11:	e8 46 a6 ff ff       	call   8010055c <panic>

  iunlockput(dp);
80105f16:	83 ec 0c             	sub    $0xc,%esp
80105f19:	ff 75 f4             	pushl  -0xc(%ebp)
80105f1c:	e8 95 bc ff ff       	call   80101bb6 <iunlockput>
80105f21:	83 c4 10             	add    $0x10,%esp

  return ip;
80105f24:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105f27:	c9                   	leave  
80105f28:	c3                   	ret    

80105f29 <sys_open>:

int
sys_open(void)
{
80105f29:	55                   	push   %ebp
80105f2a:	89 e5                	mov    %esp,%ebp
80105f2c:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105f2f:	83 ec 08             	sub    $0x8,%esp
80105f32:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f35:	50                   	push   %eax
80105f36:	6a 00                	push   $0x0
80105f38:	e8 eb f6 ff ff       	call   80105628 <argstr>
80105f3d:	83 c4 10             	add    $0x10,%esp
80105f40:	85 c0                	test   %eax,%eax
80105f42:	78 15                	js     80105f59 <sys_open+0x30>
80105f44:	83 ec 08             	sub    $0x8,%esp
80105f47:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f4a:	50                   	push   %eax
80105f4b:	6a 01                	push   $0x1
80105f4d:	e8 4f f6 ff ff       	call   801055a1 <argint>
80105f52:	83 c4 10             	add    $0x10,%esp
80105f55:	85 c0                	test   %eax,%eax
80105f57:	79 0a                	jns    80105f63 <sys_open+0x3a>
    return -1;
80105f59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f5e:	e9 61 01 00 00       	jmp    801060c4 <sys_open+0x19b>

  begin_op();
80105f63:	e8 21 d5 ff ff       	call   80103489 <begin_op>

  if(omode & O_CREATE){
80105f68:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f6b:	25 00 02 00 00       	and    $0x200,%eax
80105f70:	85 c0                	test   %eax,%eax
80105f72:	74 2a                	je     80105f9e <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
80105f74:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f77:	6a 00                	push   $0x0
80105f79:	6a 00                	push   $0x0
80105f7b:	6a 02                	push   $0x2
80105f7d:	50                   	push   %eax
80105f7e:	e8 d4 fd ff ff       	call   80105d57 <create>
80105f83:	83 c4 10             	add    $0x10,%esp
80105f86:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80105f89:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f8d:	75 75                	jne    80106004 <sys_open+0xdb>
      end_op();
80105f8f:	e8 83 d5 ff ff       	call   80103517 <end_op>
      return -1;
80105f94:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f99:	e9 26 01 00 00       	jmp    801060c4 <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
80105f9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105fa1:	83 ec 0c             	sub    $0xc,%esp
80105fa4:	50                   	push   %eax
80105fa5:	e8 0a c5 ff ff       	call   801024b4 <namei>
80105faa:	83 c4 10             	add    $0x10,%esp
80105fad:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105fb0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fb4:	75 0f                	jne    80105fc5 <sys_open+0x9c>
      end_op();
80105fb6:	e8 5c d5 ff ff       	call   80103517 <end_op>
      return -1;
80105fbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fc0:	e9 ff 00 00 00       	jmp    801060c4 <sys_open+0x19b>
    }
    ilock(ip);
80105fc5:	83 ec 0c             	sub    $0xc,%esp
80105fc8:	ff 75 f4             	pushl  -0xc(%ebp)
80105fcb:	e8 2f b9 ff ff       	call   801018ff <ilock>
80105fd0:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105fd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fd6:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105fda:	66 83 f8 01          	cmp    $0x1,%ax
80105fde:	75 24                	jne    80106004 <sys_open+0xdb>
80105fe0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fe3:	85 c0                	test   %eax,%eax
80105fe5:	74 1d                	je     80106004 <sys_open+0xdb>
      iunlockput(ip);
80105fe7:	83 ec 0c             	sub    $0xc,%esp
80105fea:	ff 75 f4             	pushl  -0xc(%ebp)
80105fed:	e8 c4 bb ff ff       	call   80101bb6 <iunlockput>
80105ff2:	83 c4 10             	add    $0x10,%esp
      end_op();
80105ff5:	e8 1d d5 ff ff       	call   80103517 <end_op>
      return -1;
80105ffa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fff:	e9 c0 00 00 00       	jmp    801060c4 <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106004:	e8 6a af ff ff       	call   80100f73 <filealloc>
80106009:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010600c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106010:	74 17                	je     80106029 <sys_open+0x100>
80106012:	83 ec 0c             	sub    $0xc,%esp
80106015:	ff 75 f0             	pushl  -0x10(%ebp)
80106018:	e8 36 f7 ff ff       	call   80105753 <fdalloc>
8010601d:	83 c4 10             	add    $0x10,%esp
80106020:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106023:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106027:	79 2e                	jns    80106057 <sys_open+0x12e>
    if(f)
80106029:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010602d:	74 0e                	je     8010603d <sys_open+0x114>
      fileclose(f);
8010602f:	83 ec 0c             	sub    $0xc,%esp
80106032:	ff 75 f0             	pushl  -0x10(%ebp)
80106035:	e8 f6 af ff ff       	call   80101030 <fileclose>
8010603a:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010603d:	83 ec 0c             	sub    $0xc,%esp
80106040:	ff 75 f4             	pushl  -0xc(%ebp)
80106043:	e8 6e bb ff ff       	call   80101bb6 <iunlockput>
80106048:	83 c4 10             	add    $0x10,%esp
    end_op();
8010604b:	e8 c7 d4 ff ff       	call   80103517 <end_op>
    return -1;
80106050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106055:	eb 6d                	jmp    801060c4 <sys_open+0x19b>
  }
  iunlock(ip);
80106057:	83 ec 0c             	sub    $0xc,%esp
8010605a:	ff 75 f4             	pushl  -0xc(%ebp)
8010605d:	e8 f4 b9 ff ff       	call   80101a56 <iunlock>
80106062:	83 c4 10             	add    $0x10,%esp
  end_op();
80106065:	e8 ad d4 ff ff       	call   80103517 <end_op>

  f->type = FD_INODE;
8010606a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010606d:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80106073:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106076:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106079:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
8010607c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010607f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80106086:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106089:	83 e0 01             	and    $0x1,%eax
8010608c:	85 c0                	test   %eax,%eax
8010608e:	0f 94 c0             	sete   %al
80106091:	89 c2                	mov    %eax,%edx
80106093:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106096:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106099:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010609c:	83 e0 01             	and    $0x1,%eax
8010609f:	85 c0                	test   %eax,%eax
801060a1:	75 0a                	jne    801060ad <sys_open+0x184>
801060a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060a6:	83 e0 02             	and    $0x2,%eax
801060a9:	85 c0                	test   %eax,%eax
801060ab:	74 07                	je     801060b4 <sys_open+0x18b>
801060ad:	b8 01 00 00 00       	mov    $0x1,%eax
801060b2:	eb 05                	jmp    801060b9 <sys_open+0x190>
801060b4:	b8 00 00 00 00       	mov    $0x0,%eax
801060b9:	89 c2                	mov    %eax,%edx
801060bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060be:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
801060c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
801060c4:	c9                   	leave  
801060c5:	c3                   	ret    

801060c6 <sys_mkdir>:

int
sys_mkdir(void)
{
801060c6:	55                   	push   %ebp
801060c7:	89 e5                	mov    %esp,%ebp
801060c9:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801060cc:	e8 b8 d3 ff ff       	call   80103489 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801060d1:	83 ec 08             	sub    $0x8,%esp
801060d4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060d7:	50                   	push   %eax
801060d8:	6a 00                	push   $0x0
801060da:	e8 49 f5 ff ff       	call   80105628 <argstr>
801060df:	83 c4 10             	add    $0x10,%esp
801060e2:	85 c0                	test   %eax,%eax
801060e4:	78 1b                	js     80106101 <sys_mkdir+0x3b>
801060e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060e9:	6a 00                	push   $0x0
801060eb:	6a 00                	push   $0x0
801060ed:	6a 01                	push   $0x1
801060ef:	50                   	push   %eax
801060f0:	e8 62 fc ff ff       	call   80105d57 <create>
801060f5:	83 c4 10             	add    $0x10,%esp
801060f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060ff:	75 0c                	jne    8010610d <sys_mkdir+0x47>
    end_op();
80106101:	e8 11 d4 ff ff       	call   80103517 <end_op>
    return -1;
80106106:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010610b:	eb 18                	jmp    80106125 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
8010610d:	83 ec 0c             	sub    $0xc,%esp
80106110:	ff 75 f4             	pushl  -0xc(%ebp)
80106113:	e8 9e ba ff ff       	call   80101bb6 <iunlockput>
80106118:	83 c4 10             	add    $0x10,%esp
  end_op();
8010611b:	e8 f7 d3 ff ff       	call   80103517 <end_op>
  return 0;
80106120:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106125:	c9                   	leave  
80106126:	c3                   	ret    

80106127 <sys_mknod>:

int
sys_mknod(void)
{
80106127:	55                   	push   %ebp
80106128:	89 e5                	mov    %esp,%ebp
8010612a:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
8010612d:	e8 57 d3 ff ff       	call   80103489 <begin_op>
  if((len=argstr(0, &path)) < 0 ||
80106132:	83 ec 08             	sub    $0x8,%esp
80106135:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106138:	50                   	push   %eax
80106139:	6a 00                	push   $0x0
8010613b:	e8 e8 f4 ff ff       	call   80105628 <argstr>
80106140:	83 c4 10             	add    $0x10,%esp
80106143:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106146:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010614a:	78 4f                	js     8010619b <sys_mknod+0x74>
     argint(1, &major) < 0 ||
8010614c:	83 ec 08             	sub    $0x8,%esp
8010614f:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106152:	50                   	push   %eax
80106153:	6a 01                	push   $0x1
80106155:	e8 47 f4 ff ff       	call   801055a1 <argint>
8010615a:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
8010615d:	85 c0                	test   %eax,%eax
8010615f:	78 3a                	js     8010619b <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106161:	83 ec 08             	sub    $0x8,%esp
80106164:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106167:	50                   	push   %eax
80106168:	6a 02                	push   $0x2
8010616a:	e8 32 f4 ff ff       	call   801055a1 <argint>
8010616f:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80106172:	85 c0                	test   %eax,%eax
80106174:	78 25                	js     8010619b <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106176:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106179:	0f bf c8             	movswl %ax,%ecx
8010617c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010617f:	0f bf d0             	movswl %ax,%edx
80106182:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106185:	51                   	push   %ecx
80106186:	52                   	push   %edx
80106187:	6a 03                	push   $0x3
80106189:	50                   	push   %eax
8010618a:	e8 c8 fb ff ff       	call   80105d57 <create>
8010618f:	83 c4 10             	add    $0x10,%esp
80106192:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106195:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106199:	75 0c                	jne    801061a7 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
8010619b:	e8 77 d3 ff ff       	call   80103517 <end_op>
    return -1;
801061a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061a5:	eb 18                	jmp    801061bf <sys_mknod+0x98>
  }
  iunlockput(ip);
801061a7:	83 ec 0c             	sub    $0xc,%esp
801061aa:	ff 75 f0             	pushl  -0x10(%ebp)
801061ad:	e8 04 ba ff ff       	call   80101bb6 <iunlockput>
801061b2:	83 c4 10             	add    $0x10,%esp
  end_op();
801061b5:	e8 5d d3 ff ff       	call   80103517 <end_op>
  return 0;
801061ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
801061bf:	c9                   	leave  
801061c0:	c3                   	ret    

801061c1 <sys_chdir>:

int
sys_chdir(void)
{
801061c1:	55                   	push   %ebp
801061c2:	89 e5                	mov    %esp,%ebp
801061c4:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801061c7:	e8 bd d2 ff ff       	call   80103489 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801061cc:	83 ec 08             	sub    $0x8,%esp
801061cf:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061d2:	50                   	push   %eax
801061d3:	6a 00                	push   $0x0
801061d5:	e8 4e f4 ff ff       	call   80105628 <argstr>
801061da:	83 c4 10             	add    $0x10,%esp
801061dd:	85 c0                	test   %eax,%eax
801061df:	78 18                	js     801061f9 <sys_chdir+0x38>
801061e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061e4:	83 ec 0c             	sub    $0xc,%esp
801061e7:	50                   	push   %eax
801061e8:	e8 c7 c2 ff ff       	call   801024b4 <namei>
801061ed:	83 c4 10             	add    $0x10,%esp
801061f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061f7:	75 0c                	jne    80106205 <sys_chdir+0x44>
    end_op();
801061f9:	e8 19 d3 ff ff       	call   80103517 <end_op>
    return -1;
801061fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106203:	eb 6e                	jmp    80106273 <sys_chdir+0xb2>
  }
  ilock(ip);
80106205:	83 ec 0c             	sub    $0xc,%esp
80106208:	ff 75 f4             	pushl  -0xc(%ebp)
8010620b:	e8 ef b6 ff ff       	call   801018ff <ilock>
80106210:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106213:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106216:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010621a:	66 83 f8 01          	cmp    $0x1,%ax
8010621e:	74 1a                	je     8010623a <sys_chdir+0x79>
    iunlockput(ip);
80106220:	83 ec 0c             	sub    $0xc,%esp
80106223:	ff 75 f4             	pushl  -0xc(%ebp)
80106226:	e8 8b b9 ff ff       	call   80101bb6 <iunlockput>
8010622b:	83 c4 10             	add    $0x10,%esp
    end_op();
8010622e:	e8 e4 d2 ff ff       	call   80103517 <end_op>
    return -1;
80106233:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106238:	eb 39                	jmp    80106273 <sys_chdir+0xb2>
  }
  iunlock(ip);
8010623a:	83 ec 0c             	sub    $0xc,%esp
8010623d:	ff 75 f4             	pushl  -0xc(%ebp)
80106240:	e8 11 b8 ff ff       	call   80101a56 <iunlock>
80106245:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106248:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010624e:	8b 40 68             	mov    0x68(%eax),%eax
80106251:	83 ec 0c             	sub    $0xc,%esp
80106254:	50                   	push   %eax
80106255:	e8 6d b8 ff ff       	call   80101ac7 <iput>
8010625a:	83 c4 10             	add    $0x10,%esp
  end_op();
8010625d:	e8 b5 d2 ff ff       	call   80103517 <end_op>
  proc->cwd = ip;
80106262:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106268:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010626b:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
8010626e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106273:	c9                   	leave  
80106274:	c3                   	ret    

80106275 <sys_exec>:

int
sys_exec(void)
{
80106275:	55                   	push   %ebp
80106276:	89 e5                	mov    %esp,%ebp
80106278:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010627e:	83 ec 08             	sub    $0x8,%esp
80106281:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106284:	50                   	push   %eax
80106285:	6a 00                	push   $0x0
80106287:	e8 9c f3 ff ff       	call   80105628 <argstr>
8010628c:	83 c4 10             	add    $0x10,%esp
8010628f:	85 c0                	test   %eax,%eax
80106291:	78 18                	js     801062ab <sys_exec+0x36>
80106293:	83 ec 08             	sub    $0x8,%esp
80106296:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010629c:	50                   	push   %eax
8010629d:	6a 01                	push   $0x1
8010629f:	e8 fd f2 ff ff       	call   801055a1 <argint>
801062a4:	83 c4 10             	add    $0x10,%esp
801062a7:	85 c0                	test   %eax,%eax
801062a9:	79 0a                	jns    801062b5 <sys_exec+0x40>
    return -1;
801062ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062b0:	e9 c6 00 00 00       	jmp    8010637b <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801062b5:	83 ec 04             	sub    $0x4,%esp
801062b8:	68 80 00 00 00       	push   $0x80
801062bd:	6a 00                	push   $0x0
801062bf:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801062c5:	50                   	push   %eax
801062c6:	e8 af ef ff ff       	call   8010527a <memset>
801062cb:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801062ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801062d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062d8:	83 f8 1f             	cmp    $0x1f,%eax
801062db:	76 0a                	jbe    801062e7 <sys_exec+0x72>
      return -1;
801062dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062e2:	e9 94 00 00 00       	jmp    8010637b <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801062e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062ea:	c1 e0 02             	shl    $0x2,%eax
801062ed:	89 c2                	mov    %eax,%edx
801062ef:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801062f5:	01 c2                	add    %eax,%edx
801062f7:	83 ec 08             	sub    $0x8,%esp
801062fa:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106300:	50                   	push   %eax
80106301:	52                   	push   %edx
80106302:	e8 fe f1 ff ff       	call   80105505 <fetchint>
80106307:	83 c4 10             	add    $0x10,%esp
8010630a:	85 c0                	test   %eax,%eax
8010630c:	79 07                	jns    80106315 <sys_exec+0xa0>
      return -1;
8010630e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106313:	eb 66                	jmp    8010637b <sys_exec+0x106>
    if(uarg == 0){
80106315:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010631b:	85 c0                	test   %eax,%eax
8010631d:	75 27                	jne    80106346 <sys_exec+0xd1>
      argv[i] = 0;
8010631f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106322:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106329:	00 00 00 00 
      break;
8010632d:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010632e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106331:	83 ec 08             	sub    $0x8,%esp
80106334:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010633a:	52                   	push   %edx
8010633b:	50                   	push   %eax
8010633c:	e8 0e a8 ff ff       	call   80100b4f <exec>
80106341:	83 c4 10             	add    $0x10,%esp
80106344:	eb 35                	jmp    8010637b <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106346:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010634c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010634f:	c1 e2 02             	shl    $0x2,%edx
80106352:	01 c2                	add    %eax,%edx
80106354:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010635a:	83 ec 08             	sub    $0x8,%esp
8010635d:	52                   	push   %edx
8010635e:	50                   	push   %eax
8010635f:	e8 db f1 ff ff       	call   8010553f <fetchstr>
80106364:	83 c4 10             	add    $0x10,%esp
80106367:	85 c0                	test   %eax,%eax
80106369:	79 07                	jns    80106372 <sys_exec+0xfd>
      return -1;
8010636b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106370:	eb 09                	jmp    8010637b <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106372:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80106376:	e9 5a ff ff ff       	jmp    801062d5 <sys_exec+0x60>
  return exec(path, argv);
}
8010637b:	c9                   	leave  
8010637c:	c3                   	ret    

8010637d <sys_pipe>:

int
sys_pipe(void)
{
8010637d:	55                   	push   %ebp
8010637e:	89 e5                	mov    %esp,%ebp
80106380:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106383:	83 ec 04             	sub    $0x4,%esp
80106386:	6a 08                	push   $0x8
80106388:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010638b:	50                   	push   %eax
8010638c:	6a 00                	push   $0x0
8010638e:	e8 36 f2 ff ff       	call   801055c9 <argptr>
80106393:	83 c4 10             	add    $0x10,%esp
80106396:	85 c0                	test   %eax,%eax
80106398:	79 0a                	jns    801063a4 <sys_pipe+0x27>
    return -1;
8010639a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010639f:	e9 af 00 00 00       	jmp    80106453 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
801063a4:	83 ec 08             	sub    $0x8,%esp
801063a7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801063aa:	50                   	push   %eax
801063ab:	8d 45 e8             	lea    -0x18(%ebp),%eax
801063ae:	50                   	push   %eax
801063af:	e8 c2 db ff ff       	call   80103f76 <pipealloc>
801063b4:	83 c4 10             	add    $0x10,%esp
801063b7:	85 c0                	test   %eax,%eax
801063b9:	79 0a                	jns    801063c5 <sys_pipe+0x48>
    return -1;
801063bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063c0:	e9 8e 00 00 00       	jmp    80106453 <sys_pipe+0xd6>
  fd0 = -1;
801063c5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801063cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
801063cf:	83 ec 0c             	sub    $0xc,%esp
801063d2:	50                   	push   %eax
801063d3:	e8 7b f3 ff ff       	call   80105753 <fdalloc>
801063d8:	83 c4 10             	add    $0x10,%esp
801063db:	89 45 f4             	mov    %eax,-0xc(%ebp)
801063de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801063e2:	78 18                	js     801063fc <sys_pipe+0x7f>
801063e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063e7:	83 ec 0c             	sub    $0xc,%esp
801063ea:	50                   	push   %eax
801063eb:	e8 63 f3 ff ff       	call   80105753 <fdalloc>
801063f0:	83 c4 10             	add    $0x10,%esp
801063f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801063f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801063fa:	79 3f                	jns    8010643b <sys_pipe+0xbe>
    if(fd0 >= 0)
801063fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106400:	78 14                	js     80106416 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80106402:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106408:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010640b:	83 c2 08             	add    $0x8,%edx
8010640e:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106415:	00 
    fileclose(rf);
80106416:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106419:	83 ec 0c             	sub    $0xc,%esp
8010641c:	50                   	push   %eax
8010641d:	e8 0e ac ff ff       	call   80101030 <fileclose>
80106422:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106425:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106428:	83 ec 0c             	sub    $0xc,%esp
8010642b:	50                   	push   %eax
8010642c:	e8 ff ab ff ff       	call   80101030 <fileclose>
80106431:	83 c4 10             	add    $0x10,%esp
    return -1;
80106434:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106439:	eb 18                	jmp    80106453 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
8010643b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010643e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106441:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106443:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106446:	8d 50 04             	lea    0x4(%eax),%edx
80106449:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010644c:	89 02                	mov    %eax,(%edx)
  return 0;
8010644e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106453:	c9                   	leave  
80106454:	c3                   	ret    

80106455 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106455:	55                   	push   %ebp
80106456:	89 e5                	mov    %esp,%ebp
80106458:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010645b:	e8 0c e2 ff ff       	call   8010466c <fork>
}
80106460:	c9                   	leave  
80106461:	c3                   	ret    

80106462 <sys_exit>:

int
sys_exit(void)
{
80106462:	55                   	push   %ebp
80106463:	89 e5                	mov    %esp,%ebp
80106465:	83 ec 18             	sub    $0x18,%esp
  int exit_status;
  if (argint(0, &exit_status) < 0)
80106468:	83 ec 08             	sub    $0x8,%esp
8010646b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010646e:	50                   	push   %eax
8010646f:	6a 00                	push   $0x0
80106471:	e8 2b f1 ff ff       	call   801055a1 <argint>
80106476:	83 c4 10             	add    $0x10,%esp
80106479:	85 c0                	test   %eax,%eax
8010647b:	79 07                	jns    80106484 <sys_exit+0x22>
		  return -1;
8010647d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106482:	eb 14                	jmp    80106498 <sys_exit+0x36>
  exit(exit_status);
80106484:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106487:	83 ec 0c             	sub    $0xc,%esp
8010648a:	50                   	push   %eax
8010648b:	e8 6d e3 ff ff       	call   801047fd <exit>
80106490:	83 c4 10             	add    $0x10,%esp
  return 0;  // not reached
80106493:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106498:	c9                   	leave  
80106499:	c3                   	ret    

8010649a <sys_wait>:

int
sys_wait(void)
{
8010649a:	55                   	push   %ebp
8010649b:	89 e5                	mov    %esp,%ebp
8010649d:	83 ec 18             	sub    $0x18,%esp
  int* status;
  if (argptr(0, (char**)&status, sizeof(status)) < 0)
801064a0:	83 ec 04             	sub    $0x4,%esp
801064a3:	6a 04                	push   $0x4
801064a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064a8:	50                   	push   %eax
801064a9:	6a 00                	push   $0x0
801064ab:	e8 19 f1 ff ff       	call   801055c9 <argptr>
801064b0:	83 c4 10             	add    $0x10,%esp
801064b3:	85 c0                	test   %eax,%eax
801064b5:	79 07                	jns    801064be <sys_wait+0x24>
	  return -1;
801064b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064bc:	eb 0f                	jmp    801064cd <sys_wait+0x33>
  return wait(status);
801064be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064c1:	83 ec 0c             	sub    $0xc,%esp
801064c4:	50                   	push   %eax
801064c5:	e8 77 e4 ff ff       	call   80104941 <wait>
801064ca:	83 c4 10             	add    $0x10,%esp
}
801064cd:	c9                   	leave  
801064ce:	c3                   	ret    

801064cf <sys_kill>:

int
sys_kill(void)
{
801064cf:	55                   	push   %ebp
801064d0:	89 e5                	mov    %esp,%ebp
801064d2:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801064d5:	83 ec 08             	sub    $0x8,%esp
801064d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064db:	50                   	push   %eax
801064dc:	6a 00                	push   $0x0
801064de:	e8 be f0 ff ff       	call   801055a1 <argint>
801064e3:	83 c4 10             	add    $0x10,%esp
801064e6:	85 c0                	test   %eax,%eax
801064e8:	79 07                	jns    801064f1 <sys_kill+0x22>
    return -1;
801064ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064ef:	eb 0f                	jmp    80106500 <sys_kill+0x31>
  return kill(pid);
801064f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064f4:	83 ec 0c             	sub    $0xc,%esp
801064f7:	50                   	push   %eax
801064f8:	e8 65 e8 ff ff       	call   80104d62 <kill>
801064fd:	83 c4 10             	add    $0x10,%esp
}
80106500:	c9                   	leave  
80106501:	c3                   	ret    

80106502 <sys_getpid>:

int
sys_getpid(void)
{
80106502:	55                   	push   %ebp
80106503:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106505:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010650b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010650e:	5d                   	pop    %ebp
8010650f:	c3                   	ret    

80106510 <sys_sbrk>:

int
sys_sbrk(void)
{
80106510:	55                   	push   %ebp
80106511:	89 e5                	mov    %esp,%ebp
80106513:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106516:	83 ec 08             	sub    $0x8,%esp
80106519:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010651c:	50                   	push   %eax
8010651d:	6a 00                	push   $0x0
8010651f:	e8 7d f0 ff ff       	call   801055a1 <argint>
80106524:	83 c4 10             	add    $0x10,%esp
80106527:	85 c0                	test   %eax,%eax
80106529:	79 07                	jns    80106532 <sys_sbrk+0x22>
    return -1;
8010652b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106530:	eb 28                	jmp    8010655a <sys_sbrk+0x4a>
  addr = proc->sz;
80106532:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106538:	8b 00                	mov    (%eax),%eax
8010653a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
8010653d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106540:	83 ec 0c             	sub    $0xc,%esp
80106543:	50                   	push   %eax
80106544:	e8 80 e0 ff ff       	call   801045c9 <growproc>
80106549:	83 c4 10             	add    $0x10,%esp
8010654c:	85 c0                	test   %eax,%eax
8010654e:	79 07                	jns    80106557 <sys_sbrk+0x47>
    return -1;
80106550:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106555:	eb 03                	jmp    8010655a <sys_sbrk+0x4a>
  return addr;
80106557:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010655a:	c9                   	leave  
8010655b:	c3                   	ret    

8010655c <sys_sleep>:

int
sys_sleep(void)
{
8010655c:	55                   	push   %ebp
8010655d:	89 e5                	mov    %esp,%ebp
8010655f:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106562:	83 ec 08             	sub    $0x8,%esp
80106565:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106568:	50                   	push   %eax
80106569:	6a 00                	push   $0x0
8010656b:	e8 31 f0 ff ff       	call   801055a1 <argint>
80106570:	83 c4 10             	add    $0x10,%esp
80106573:	85 c0                	test   %eax,%eax
80106575:	79 07                	jns    8010657e <sys_sleep+0x22>
    return -1;
80106577:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010657c:	eb 77                	jmp    801065f5 <sys_sleep+0x99>
  acquire(&tickslock);
8010657e:	83 ec 0c             	sub    $0xc,%esp
80106581:	68 80 4a 11 80       	push   $0x80114a80
80106586:	e8 93 ea ff ff       	call   8010501e <acquire>
8010658b:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
8010658e:	a1 c0 52 11 80       	mov    0x801152c0,%eax
80106593:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106596:	eb 39                	jmp    801065d1 <sys_sleep+0x75>
    if(proc->killed){
80106598:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010659e:	8b 40 24             	mov    0x24(%eax),%eax
801065a1:	85 c0                	test   %eax,%eax
801065a3:	74 17                	je     801065bc <sys_sleep+0x60>
      release(&tickslock);
801065a5:	83 ec 0c             	sub    $0xc,%esp
801065a8:	68 80 4a 11 80       	push   $0x80114a80
801065ad:	e8 d2 ea ff ff       	call   80105084 <release>
801065b2:	83 c4 10             	add    $0x10,%esp
      return -1;
801065b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065ba:	eb 39                	jmp    801065f5 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
801065bc:	83 ec 08             	sub    $0x8,%esp
801065bf:	68 80 4a 11 80       	push   $0x80114a80
801065c4:	68 c0 52 11 80       	push   $0x801152c0
801065c9:	e8 75 e6 ff ff       	call   80104c43 <sleep>
801065ce:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801065d1:	a1 c0 52 11 80       	mov    0x801152c0,%eax
801065d6:	2b 45 f4             	sub    -0xc(%ebp),%eax
801065d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801065dc:	39 d0                	cmp    %edx,%eax
801065de:	72 b8                	jb     80106598 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801065e0:	83 ec 0c             	sub    $0xc,%esp
801065e3:	68 80 4a 11 80       	push   $0x80114a80
801065e8:	e8 97 ea ff ff       	call   80105084 <release>
801065ed:	83 c4 10             	add    $0x10,%esp
  return 0;
801065f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801065f5:	c9                   	leave  
801065f6:	c3                   	ret    

801065f7 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801065f7:	55                   	push   %ebp
801065f8:	89 e5                	mov    %esp,%ebp
801065fa:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
801065fd:	83 ec 0c             	sub    $0xc,%esp
80106600:	68 80 4a 11 80       	push   $0x80114a80
80106605:	e8 14 ea ff ff       	call   8010501e <acquire>
8010660a:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
8010660d:	a1 c0 52 11 80       	mov    0x801152c0,%eax
80106612:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106615:	83 ec 0c             	sub    $0xc,%esp
80106618:	68 80 4a 11 80       	push   $0x80114a80
8010661d:	e8 62 ea ff ff       	call   80105084 <release>
80106622:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106625:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106628:	c9                   	leave  
80106629:	c3                   	ret    

8010662a <sys_pstat>:

int sys_pstat(void)
{
8010662a:	55                   	push   %ebp
8010662b:	89 e5                	mov    %esp,%ebp
8010662d:	83 ec 18             	sub    $0x18,%esp
	int pid;
	struct procstat *stat;
	if (argint(0, &pid) < 0)
80106630:	83 ec 08             	sub    $0x8,%esp
80106633:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106636:	50                   	push   %eax
80106637:	6a 00                	push   $0x0
80106639:	e8 63 ef ff ff       	call   801055a1 <argint>
8010663e:	83 c4 10             	add    $0x10,%esp
80106641:	85 c0                	test   %eax,%eax
80106643:	79 07                	jns    8010664c <sys_pstat+0x22>
		return -1;
80106645:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010664a:	eb 31                	jmp    8010667d <sys_pstat+0x53>
	if (argptr(1, (char**)&stat, sizeof(stat)) < 0)
8010664c:	83 ec 04             	sub    $0x4,%esp
8010664f:	6a 04                	push   $0x4
80106651:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106654:	50                   	push   %eax
80106655:	6a 01                	push   $0x1
80106657:	e8 6d ef ff ff       	call   801055c9 <argptr>
8010665c:	83 c4 10             	add    $0x10,%esp
8010665f:	85 c0                	test   %eax,%eax
80106661:	79 07                	jns    8010666a <sys_pstat+0x40>
		return -1;
80106663:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106668:	eb 13                	jmp    8010667d <sys_pstat+0x53>
	return pstat(pid, stat);
8010666a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010666d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106670:	83 ec 08             	sub    $0x8,%esp
80106673:	52                   	push   %edx
80106674:	50                   	push   %eax
80106675:	e8 62 e8 ff ff       	call   80104edc <pstat>
8010667a:	83 c4 10             	add    $0x10,%esp
}
8010667d:	c9                   	leave  
8010667e:	c3                   	ret    

8010667f <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010667f:	55                   	push   %ebp
80106680:	89 e5                	mov    %esp,%ebp
80106682:	83 ec 08             	sub    $0x8,%esp
80106685:	8b 55 08             	mov    0x8(%ebp),%edx
80106688:	8b 45 0c             	mov    0xc(%ebp),%eax
8010668b:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010668f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106692:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106696:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010669a:	ee                   	out    %al,(%dx)
}
8010669b:	c9                   	leave  
8010669c:	c3                   	ret    

8010669d <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
8010669d:	55                   	push   %ebp
8010669e:	89 e5                	mov    %esp,%ebp
801066a0:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801066a3:	6a 34                	push   $0x34
801066a5:	6a 43                	push   $0x43
801066a7:	e8 d3 ff ff ff       	call   8010667f <outb>
801066ac:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801066af:	68 9c 00 00 00       	push   $0x9c
801066b4:	6a 40                	push   $0x40
801066b6:	e8 c4 ff ff ff       	call   8010667f <outb>
801066bb:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
801066be:	6a 2e                	push   $0x2e
801066c0:	6a 40                	push   $0x40
801066c2:	e8 b8 ff ff ff       	call   8010667f <outb>
801066c7:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
801066ca:	83 ec 0c             	sub    $0xc,%esp
801066cd:	6a 00                	push   $0x0
801066cf:	e8 8e d7 ff ff       	call   80103e62 <picenable>
801066d4:	83 c4 10             	add    $0x10,%esp
}
801066d7:	c9                   	leave  
801066d8:	c3                   	ret    

801066d9 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801066d9:	1e                   	push   %ds
  pushl %es
801066da:	06                   	push   %es
  pushl %fs
801066db:	0f a0                	push   %fs
  pushl %gs
801066dd:	0f a8                	push   %gs
  pushal
801066df:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
801066e0:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801066e4:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801066e6:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
801066e8:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
801066ec:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
801066ee:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
801066f0:	54                   	push   %esp
  call trap
801066f1:	e8 d4 01 00 00       	call   801068ca <trap>
  addl $4, %esp
801066f6:	83 c4 04             	add    $0x4,%esp

801066f9 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801066f9:	61                   	popa   
  popl %gs
801066fa:	0f a9                	pop    %gs
  popl %fs
801066fc:	0f a1                	pop    %fs
  popl %es
801066fe:	07                   	pop    %es
  popl %ds
801066ff:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106700:	83 c4 08             	add    $0x8,%esp
  iret
80106703:	cf                   	iret   

80106704 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106704:	55                   	push   %ebp
80106705:	89 e5                	mov    %esp,%ebp
80106707:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010670a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010670d:	83 e8 01             	sub    $0x1,%eax
80106710:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106714:	8b 45 08             	mov    0x8(%ebp),%eax
80106717:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010671b:	8b 45 08             	mov    0x8(%ebp),%eax
8010671e:	c1 e8 10             	shr    $0x10,%eax
80106721:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106725:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106728:	0f 01 18             	lidtl  (%eax)
}
8010672b:	c9                   	leave  
8010672c:	c3                   	ret    

8010672d <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
8010672d:	55                   	push   %ebp
8010672e:	89 e5                	mov    %esp,%ebp
80106730:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106733:	0f 20 d0             	mov    %cr2,%eax
80106736:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106739:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010673c:	c9                   	leave  
8010673d:	c3                   	ret    

8010673e <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010673e:	55                   	push   %ebp
8010673f:	89 e5                	mov    %esp,%ebp
80106741:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80106744:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010674b:	e9 c3 00 00 00       	jmp    80106813 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106750:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106753:	8b 04 85 9c b0 10 80 	mov    -0x7fef4f64(,%eax,4),%eax
8010675a:	89 c2                	mov    %eax,%edx
8010675c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010675f:	66 89 14 c5 c0 4a 11 	mov    %dx,-0x7feeb540(,%eax,8)
80106766:	80 
80106767:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010676a:	66 c7 04 c5 c2 4a 11 	movw   $0x8,-0x7feeb53e(,%eax,8)
80106771:	80 08 00 
80106774:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106777:	0f b6 14 c5 c4 4a 11 	movzbl -0x7feeb53c(,%eax,8),%edx
8010677e:	80 
8010677f:	83 e2 e0             	and    $0xffffffe0,%edx
80106782:	88 14 c5 c4 4a 11 80 	mov    %dl,-0x7feeb53c(,%eax,8)
80106789:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010678c:	0f b6 14 c5 c4 4a 11 	movzbl -0x7feeb53c(,%eax,8),%edx
80106793:	80 
80106794:	83 e2 1f             	and    $0x1f,%edx
80106797:	88 14 c5 c4 4a 11 80 	mov    %dl,-0x7feeb53c(,%eax,8)
8010679e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067a1:	0f b6 14 c5 c5 4a 11 	movzbl -0x7feeb53b(,%eax,8),%edx
801067a8:	80 
801067a9:	83 e2 f0             	and    $0xfffffff0,%edx
801067ac:	83 ca 0e             	or     $0xe,%edx
801067af:	88 14 c5 c5 4a 11 80 	mov    %dl,-0x7feeb53b(,%eax,8)
801067b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067b9:	0f b6 14 c5 c5 4a 11 	movzbl -0x7feeb53b(,%eax,8),%edx
801067c0:	80 
801067c1:	83 e2 ef             	and    $0xffffffef,%edx
801067c4:	88 14 c5 c5 4a 11 80 	mov    %dl,-0x7feeb53b(,%eax,8)
801067cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067ce:	0f b6 14 c5 c5 4a 11 	movzbl -0x7feeb53b(,%eax,8),%edx
801067d5:	80 
801067d6:	83 e2 9f             	and    $0xffffff9f,%edx
801067d9:	88 14 c5 c5 4a 11 80 	mov    %dl,-0x7feeb53b(,%eax,8)
801067e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067e3:	0f b6 14 c5 c5 4a 11 	movzbl -0x7feeb53b(,%eax,8),%edx
801067ea:	80 
801067eb:	83 ca 80             	or     $0xffffff80,%edx
801067ee:	88 14 c5 c5 4a 11 80 	mov    %dl,-0x7feeb53b(,%eax,8)
801067f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067f8:	8b 04 85 9c b0 10 80 	mov    -0x7fef4f64(,%eax,4),%eax
801067ff:	c1 e8 10             	shr    $0x10,%eax
80106802:	89 c2                	mov    %eax,%edx
80106804:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106807:	66 89 14 c5 c6 4a 11 	mov    %dx,-0x7feeb53a(,%eax,8)
8010680e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010680f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106813:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010681a:	0f 8e 30 ff ff ff    	jle    80106750 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106820:	a1 9c b1 10 80       	mov    0x8010b19c,%eax
80106825:	66 a3 c0 4c 11 80    	mov    %ax,0x80114cc0
8010682b:	66 c7 05 c2 4c 11 80 	movw   $0x8,0x80114cc2
80106832:	08 00 
80106834:	0f b6 05 c4 4c 11 80 	movzbl 0x80114cc4,%eax
8010683b:	83 e0 e0             	and    $0xffffffe0,%eax
8010683e:	a2 c4 4c 11 80       	mov    %al,0x80114cc4
80106843:	0f b6 05 c4 4c 11 80 	movzbl 0x80114cc4,%eax
8010684a:	83 e0 1f             	and    $0x1f,%eax
8010684d:	a2 c4 4c 11 80       	mov    %al,0x80114cc4
80106852:	0f b6 05 c5 4c 11 80 	movzbl 0x80114cc5,%eax
80106859:	83 c8 0f             	or     $0xf,%eax
8010685c:	a2 c5 4c 11 80       	mov    %al,0x80114cc5
80106861:	0f b6 05 c5 4c 11 80 	movzbl 0x80114cc5,%eax
80106868:	83 e0 ef             	and    $0xffffffef,%eax
8010686b:	a2 c5 4c 11 80       	mov    %al,0x80114cc5
80106870:	0f b6 05 c5 4c 11 80 	movzbl 0x80114cc5,%eax
80106877:	83 c8 60             	or     $0x60,%eax
8010687a:	a2 c5 4c 11 80       	mov    %al,0x80114cc5
8010687f:	0f b6 05 c5 4c 11 80 	movzbl 0x80114cc5,%eax
80106886:	83 c8 80             	or     $0xffffff80,%eax
80106889:	a2 c5 4c 11 80       	mov    %al,0x80114cc5
8010688e:	a1 9c b1 10 80       	mov    0x8010b19c,%eax
80106893:	c1 e8 10             	shr    $0x10,%eax
80106896:	66 a3 c6 4c 11 80    	mov    %ax,0x80114cc6
  
  initlock(&tickslock, "time");
8010689c:	83 ec 08             	sub    $0x8,%esp
8010689f:	68 54 8a 10 80       	push   $0x80108a54
801068a4:	68 80 4a 11 80       	push   $0x80114a80
801068a9:	e8 4f e7 ff ff       	call   80104ffd <initlock>
801068ae:	83 c4 10             	add    $0x10,%esp
}
801068b1:	c9                   	leave  
801068b2:	c3                   	ret    

801068b3 <idtinit>:

void
idtinit(void)
{
801068b3:	55                   	push   %ebp
801068b4:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
801068b6:	68 00 08 00 00       	push   $0x800
801068bb:	68 c0 4a 11 80       	push   $0x80114ac0
801068c0:	e8 3f fe ff ff       	call   80106704 <lidt>
801068c5:	83 c4 08             	add    $0x8,%esp
}
801068c8:	c9                   	leave  
801068c9:	c3                   	ret    

801068ca <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801068ca:	55                   	push   %ebp
801068cb:	89 e5                	mov    %esp,%ebp
801068cd:	57                   	push   %edi
801068ce:	56                   	push   %esi
801068cf:	53                   	push   %ebx
801068d0:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
801068d3:	8b 45 08             	mov    0x8(%ebp),%eax
801068d6:	8b 40 30             	mov    0x30(%eax),%eax
801068d9:	83 f8 40             	cmp    $0x40,%eax
801068dc:	75 4f                	jne    8010692d <trap+0x63>
    if(proc->killed)
801068de:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068e4:	8b 40 24             	mov    0x24(%eax),%eax
801068e7:	85 c0                	test   %eax,%eax
801068e9:	74 0d                	je     801068f8 <trap+0x2e>
      exit(EXIT_STATUS_OK);
801068eb:	83 ec 0c             	sub    $0xc,%esp
801068ee:	6a 01                	push   $0x1
801068f0:	e8 08 df ff ff       	call   801047fd <exit>
801068f5:	83 c4 10             	add    $0x10,%esp
    proc->tf = tf;
801068f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068fe:	8b 55 08             	mov    0x8(%ebp),%edx
80106901:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80106904:	e8 50 ed ff ff       	call   80105659 <syscall>
    if(proc->killed)
80106909:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010690f:	8b 40 24             	mov    0x24(%eax),%eax
80106912:	85 c0                	test   %eax,%eax
80106914:	74 12                	je     80106928 <trap+0x5e>
      exit(EXIT_STATUS_OK);
80106916:	83 ec 0c             	sub    $0xc,%esp
80106919:	6a 01                	push   $0x1
8010691b:	e8 dd de ff ff       	call   801047fd <exit>
80106920:	83 c4 10             	add    $0x10,%esp
    return;
80106923:	e9 24 02 00 00       	jmp    80106b4c <trap+0x282>
80106928:	e9 1f 02 00 00       	jmp    80106b4c <trap+0x282>
  }

  switch(tf->trapno){
8010692d:	8b 45 08             	mov    0x8(%ebp),%eax
80106930:	8b 40 30             	mov    0x30(%eax),%eax
80106933:	83 e8 20             	sub    $0x20,%eax
80106936:	83 f8 1f             	cmp    $0x1f,%eax
80106939:	0f 87 c0 00 00 00    	ja     801069ff <trap+0x135>
8010693f:	8b 04 85 fc 8a 10 80 	mov    -0x7fef7504(,%eax,4),%eax
80106946:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106948:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010694e:	0f b6 00             	movzbl (%eax),%eax
80106951:	84 c0                	test   %al,%al
80106953:	75 3d                	jne    80106992 <trap+0xc8>
      acquire(&tickslock);
80106955:	83 ec 0c             	sub    $0xc,%esp
80106958:	68 80 4a 11 80       	push   $0x80114a80
8010695d:	e8 bc e6 ff ff       	call   8010501e <acquire>
80106962:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106965:	a1 c0 52 11 80       	mov    0x801152c0,%eax
8010696a:	83 c0 01             	add    $0x1,%eax
8010696d:	a3 c0 52 11 80       	mov    %eax,0x801152c0
      wakeup(&ticks);
80106972:	83 ec 0c             	sub    $0xc,%esp
80106975:	68 c0 52 11 80       	push   $0x801152c0
8010697a:	e8 ad e3 ff ff       	call   80104d2c <wakeup>
8010697f:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106982:	83 ec 0c             	sub    $0xc,%esp
80106985:	68 80 4a 11 80       	push   $0x80114a80
8010698a:	e8 f5 e6 ff ff       	call   80105084 <release>
8010698f:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106992:	e8 cb c5 ff ff       	call   80102f62 <lapiceoi>
    break;
80106997:	e9 1c 01 00 00       	jmp    80106ab8 <trap+0x1ee>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
8010699c:	e8 e2 bd ff ff       	call   80102783 <ideintr>
    lapiceoi();
801069a1:	e8 bc c5 ff ff       	call   80102f62 <lapiceoi>
    break;
801069a6:	e9 0d 01 00 00       	jmp    80106ab8 <trap+0x1ee>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801069ab:	e8 b9 c3 ff ff       	call   80102d69 <kbdintr>
    lapiceoi();
801069b0:	e8 ad c5 ff ff       	call   80102f62 <lapiceoi>
    break;
801069b5:	e9 fe 00 00 00       	jmp    80106ab8 <trap+0x1ee>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801069ba:	e8 6a 03 00 00       	call   80106d29 <uartintr>
    lapiceoi();
801069bf:	e8 9e c5 ff ff       	call   80102f62 <lapiceoi>
    break;
801069c4:	e9 ef 00 00 00       	jmp    80106ab8 <trap+0x1ee>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801069c9:	8b 45 08             	mov    0x8(%ebp),%eax
801069cc:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
801069cf:	8b 45 08             	mov    0x8(%ebp),%eax
801069d2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801069d6:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
801069d9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801069df:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801069e2:	0f b6 c0             	movzbl %al,%eax
801069e5:	51                   	push   %ecx
801069e6:	52                   	push   %edx
801069e7:	50                   	push   %eax
801069e8:	68 5c 8a 10 80       	push   $0x80108a5c
801069ed:	e8 cd 99 ff ff       	call   801003bf <cprintf>
801069f2:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
801069f5:	e8 68 c5 ff ff       	call   80102f62 <lapiceoi>
    break;
801069fa:	e9 b9 00 00 00       	jmp    80106ab8 <trap+0x1ee>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801069ff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a05:	85 c0                	test   %eax,%eax
80106a07:	74 11                	je     80106a1a <trap+0x150>
80106a09:	8b 45 08             	mov    0x8(%ebp),%eax
80106a0c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106a10:	0f b7 c0             	movzwl %ax,%eax
80106a13:	83 e0 03             	and    $0x3,%eax
80106a16:	85 c0                	test   %eax,%eax
80106a18:	75 40                	jne    80106a5a <trap+0x190>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a1a:	e8 0e fd ff ff       	call   8010672d <rcr2>
80106a1f:	89 c3                	mov    %eax,%ebx
80106a21:	8b 45 08             	mov    0x8(%ebp),%eax
80106a24:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
80106a27:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a2d:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a30:	0f b6 d0             	movzbl %al,%edx
80106a33:	8b 45 08             	mov    0x8(%ebp),%eax
80106a36:	8b 40 30             	mov    0x30(%eax),%eax
80106a39:	83 ec 0c             	sub    $0xc,%esp
80106a3c:	53                   	push   %ebx
80106a3d:	51                   	push   %ecx
80106a3e:	52                   	push   %edx
80106a3f:	50                   	push   %eax
80106a40:	68 80 8a 10 80       	push   $0x80108a80
80106a45:	e8 75 99 ff ff       	call   801003bf <cprintf>
80106a4a:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106a4d:	83 ec 0c             	sub    $0xc,%esp
80106a50:	68 b2 8a 10 80       	push   $0x80108ab2
80106a55:	e8 02 9b ff ff       	call   8010055c <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a5a:	e8 ce fc ff ff       	call   8010672d <rcr2>
80106a5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a62:	8b 45 08             	mov    0x8(%ebp),%eax
80106a65:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106a68:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a6e:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a71:	0f b6 d8             	movzbl %al,%ebx
80106a74:	8b 45 08             	mov    0x8(%ebp),%eax
80106a77:	8b 48 34             	mov    0x34(%eax),%ecx
80106a7a:	8b 45 08             	mov    0x8(%ebp),%eax
80106a7d:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106a80:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a86:	8d 78 6c             	lea    0x6c(%eax),%edi
80106a89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a8f:	8b 40 10             	mov    0x10(%eax),%eax
80106a92:	ff 75 e4             	pushl  -0x1c(%ebp)
80106a95:	56                   	push   %esi
80106a96:	53                   	push   %ebx
80106a97:	51                   	push   %ecx
80106a98:	52                   	push   %edx
80106a99:	57                   	push   %edi
80106a9a:	50                   	push   %eax
80106a9b:	68 b8 8a 10 80       	push   $0x80108ab8
80106aa0:	e8 1a 99 ff ff       	call   801003bf <cprintf>
80106aa5:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106aa8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aae:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106ab5:	eb 01                	jmp    80106ab8 <trap+0x1ee>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106ab7:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106ab8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106abe:	85 c0                	test   %eax,%eax
80106ac0:	74 2c                	je     80106aee <trap+0x224>
80106ac2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ac8:	8b 40 24             	mov    0x24(%eax),%eax
80106acb:	85 c0                	test   %eax,%eax
80106acd:	74 1f                	je     80106aee <trap+0x224>
80106acf:	8b 45 08             	mov    0x8(%ebp),%eax
80106ad2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106ad6:	0f b7 c0             	movzwl %ax,%eax
80106ad9:	83 e0 03             	and    $0x3,%eax
80106adc:	83 f8 03             	cmp    $0x3,%eax
80106adf:	75 0d                	jne    80106aee <trap+0x224>
    exit(EXIT_STATUS_OK);
80106ae1:	83 ec 0c             	sub    $0xc,%esp
80106ae4:	6a 01                	push   $0x1
80106ae6:	e8 12 dd ff ff       	call   801047fd <exit>
80106aeb:	83 c4 10             	add    $0x10,%esp

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106aee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106af4:	85 c0                	test   %eax,%eax
80106af6:	74 1e                	je     80106b16 <trap+0x24c>
80106af8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106afe:	8b 40 0c             	mov    0xc(%eax),%eax
80106b01:	83 f8 04             	cmp    $0x4,%eax
80106b04:	75 10                	jne    80106b16 <trap+0x24c>
80106b06:	8b 45 08             	mov    0x8(%ebp),%eax
80106b09:	8b 40 30             	mov    0x30(%eax),%eax
80106b0c:	83 f8 20             	cmp    $0x20,%eax
80106b0f:	75 05                	jne    80106b16 <trap+0x24c>
    yield();
80106b11:	e8 c3 e0 ff ff       	call   80104bd9 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106b16:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b1c:	85 c0                	test   %eax,%eax
80106b1e:	74 2c                	je     80106b4c <trap+0x282>
80106b20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b26:	8b 40 24             	mov    0x24(%eax),%eax
80106b29:	85 c0                	test   %eax,%eax
80106b2b:	74 1f                	je     80106b4c <trap+0x282>
80106b2d:	8b 45 08             	mov    0x8(%ebp),%eax
80106b30:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b34:	0f b7 c0             	movzwl %ax,%eax
80106b37:	83 e0 03             	and    $0x3,%eax
80106b3a:	83 f8 03             	cmp    $0x3,%eax
80106b3d:	75 0d                	jne    80106b4c <trap+0x282>
    exit(EXIT_STATUS_OK);
80106b3f:	83 ec 0c             	sub    $0xc,%esp
80106b42:	6a 01                	push   $0x1
80106b44:	e8 b4 dc ff ff       	call   801047fd <exit>
80106b49:	83 c4 10             	add    $0x10,%esp
}
80106b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b4f:	5b                   	pop    %ebx
80106b50:	5e                   	pop    %esi
80106b51:	5f                   	pop    %edi
80106b52:	5d                   	pop    %ebp
80106b53:	c3                   	ret    

80106b54 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106b54:	55                   	push   %ebp
80106b55:	89 e5                	mov    %esp,%ebp
80106b57:	83 ec 14             	sub    $0x14,%esp
80106b5a:	8b 45 08             	mov    0x8(%ebp),%eax
80106b5d:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106b61:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106b65:	89 c2                	mov    %eax,%edx
80106b67:	ec                   	in     (%dx),%al
80106b68:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106b6b:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106b6f:	c9                   	leave  
80106b70:	c3                   	ret    

80106b71 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106b71:	55                   	push   %ebp
80106b72:	89 e5                	mov    %esp,%ebp
80106b74:	83 ec 08             	sub    $0x8,%esp
80106b77:	8b 55 08             	mov    0x8(%ebp),%edx
80106b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b7d:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106b81:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106b84:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106b88:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106b8c:	ee                   	out    %al,(%dx)
}
80106b8d:	c9                   	leave  
80106b8e:	c3                   	ret    

80106b8f <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106b8f:	55                   	push   %ebp
80106b90:	89 e5                	mov    %esp,%ebp
80106b92:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106b95:	6a 00                	push   $0x0
80106b97:	68 fa 03 00 00       	push   $0x3fa
80106b9c:	e8 d0 ff ff ff       	call   80106b71 <outb>
80106ba1:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106ba4:	68 80 00 00 00       	push   $0x80
80106ba9:	68 fb 03 00 00       	push   $0x3fb
80106bae:	e8 be ff ff ff       	call   80106b71 <outb>
80106bb3:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106bb6:	6a 0c                	push   $0xc
80106bb8:	68 f8 03 00 00       	push   $0x3f8
80106bbd:	e8 af ff ff ff       	call   80106b71 <outb>
80106bc2:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106bc5:	6a 00                	push   $0x0
80106bc7:	68 f9 03 00 00       	push   $0x3f9
80106bcc:	e8 a0 ff ff ff       	call   80106b71 <outb>
80106bd1:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106bd4:	6a 03                	push   $0x3
80106bd6:	68 fb 03 00 00       	push   $0x3fb
80106bdb:	e8 91 ff ff ff       	call   80106b71 <outb>
80106be0:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106be3:	6a 00                	push   $0x0
80106be5:	68 fc 03 00 00       	push   $0x3fc
80106bea:	e8 82 ff ff ff       	call   80106b71 <outb>
80106bef:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106bf2:	6a 01                	push   $0x1
80106bf4:	68 f9 03 00 00       	push   $0x3f9
80106bf9:	e8 73 ff ff ff       	call   80106b71 <outb>
80106bfe:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106c01:	68 fd 03 00 00       	push   $0x3fd
80106c06:	e8 49 ff ff ff       	call   80106b54 <inb>
80106c0b:	83 c4 04             	add    $0x4,%esp
80106c0e:	3c ff                	cmp    $0xff,%al
80106c10:	75 02                	jne    80106c14 <uartinit+0x85>
    return;
80106c12:	eb 6c                	jmp    80106c80 <uartinit+0xf1>
  uart = 1;
80106c14:	c7 05 6c b6 10 80 01 	movl   $0x1,0x8010b66c
80106c1b:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106c1e:	68 fa 03 00 00       	push   $0x3fa
80106c23:	e8 2c ff ff ff       	call   80106b54 <inb>
80106c28:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106c2b:	68 f8 03 00 00       	push   $0x3f8
80106c30:	e8 1f ff ff ff       	call   80106b54 <inb>
80106c35:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106c38:	83 ec 0c             	sub    $0xc,%esp
80106c3b:	6a 04                	push   $0x4
80106c3d:	e8 20 d2 ff ff       	call   80103e62 <picenable>
80106c42:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106c45:	83 ec 08             	sub    $0x8,%esp
80106c48:	6a 00                	push   $0x0
80106c4a:	6a 04                	push   $0x4
80106c4c:	e8 d0 bd ff ff       	call   80102a21 <ioapicenable>
80106c51:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c54:	c7 45 f4 7c 8b 10 80 	movl   $0x80108b7c,-0xc(%ebp)
80106c5b:	eb 19                	jmp    80106c76 <uartinit+0xe7>
    uartputc(*p);
80106c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c60:	0f b6 00             	movzbl (%eax),%eax
80106c63:	0f be c0             	movsbl %al,%eax
80106c66:	83 ec 0c             	sub    $0xc,%esp
80106c69:	50                   	push   %eax
80106c6a:	e8 13 00 00 00       	call   80106c82 <uartputc>
80106c6f:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c72:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c79:	0f b6 00             	movzbl (%eax),%eax
80106c7c:	84 c0                	test   %al,%al
80106c7e:	75 dd                	jne    80106c5d <uartinit+0xce>
    uartputc(*p);
}
80106c80:	c9                   	leave  
80106c81:	c3                   	ret    

80106c82 <uartputc>:

void
uartputc(int c)
{
80106c82:	55                   	push   %ebp
80106c83:	89 e5                	mov    %esp,%ebp
80106c85:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106c88:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106c8d:	85 c0                	test   %eax,%eax
80106c8f:	75 02                	jne    80106c93 <uartputc+0x11>
    return;
80106c91:	eb 51                	jmp    80106ce4 <uartputc+0x62>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106c9a:	eb 11                	jmp    80106cad <uartputc+0x2b>
    microdelay(10);
80106c9c:	83 ec 0c             	sub    $0xc,%esp
80106c9f:	6a 0a                	push   $0xa
80106ca1:	e8 d6 c2 ff ff       	call   80102f7c <microdelay>
80106ca6:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106ca9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106cad:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106cb1:	7f 1a                	jg     80106ccd <uartputc+0x4b>
80106cb3:	83 ec 0c             	sub    $0xc,%esp
80106cb6:	68 fd 03 00 00       	push   $0x3fd
80106cbb:	e8 94 fe ff ff       	call   80106b54 <inb>
80106cc0:	83 c4 10             	add    $0x10,%esp
80106cc3:	0f b6 c0             	movzbl %al,%eax
80106cc6:	83 e0 20             	and    $0x20,%eax
80106cc9:	85 c0                	test   %eax,%eax
80106ccb:	74 cf                	je     80106c9c <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106ccd:	8b 45 08             	mov    0x8(%ebp),%eax
80106cd0:	0f b6 c0             	movzbl %al,%eax
80106cd3:	83 ec 08             	sub    $0x8,%esp
80106cd6:	50                   	push   %eax
80106cd7:	68 f8 03 00 00       	push   $0x3f8
80106cdc:	e8 90 fe ff ff       	call   80106b71 <outb>
80106ce1:	83 c4 10             	add    $0x10,%esp
}
80106ce4:	c9                   	leave  
80106ce5:	c3                   	ret    

80106ce6 <uartgetc>:

static int
uartgetc(void)
{
80106ce6:	55                   	push   %ebp
80106ce7:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106ce9:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106cee:	85 c0                	test   %eax,%eax
80106cf0:	75 07                	jne    80106cf9 <uartgetc+0x13>
    return -1;
80106cf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cf7:	eb 2e                	jmp    80106d27 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106cf9:	68 fd 03 00 00       	push   $0x3fd
80106cfe:	e8 51 fe ff ff       	call   80106b54 <inb>
80106d03:	83 c4 04             	add    $0x4,%esp
80106d06:	0f b6 c0             	movzbl %al,%eax
80106d09:	83 e0 01             	and    $0x1,%eax
80106d0c:	85 c0                	test   %eax,%eax
80106d0e:	75 07                	jne    80106d17 <uartgetc+0x31>
    return -1;
80106d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d15:	eb 10                	jmp    80106d27 <uartgetc+0x41>
  return inb(COM1+0);
80106d17:	68 f8 03 00 00       	push   $0x3f8
80106d1c:	e8 33 fe ff ff       	call   80106b54 <inb>
80106d21:	83 c4 04             	add    $0x4,%esp
80106d24:	0f b6 c0             	movzbl %al,%eax
}
80106d27:	c9                   	leave  
80106d28:	c3                   	ret    

80106d29 <uartintr>:

void
uartintr(void)
{
80106d29:	55                   	push   %ebp
80106d2a:	89 e5                	mov    %esp,%ebp
80106d2c:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106d2f:	83 ec 0c             	sub    $0xc,%esp
80106d32:	68 e6 6c 10 80       	push   $0x80106ce6
80106d37:	e8 95 9a ff ff       	call   801007d1 <consoleintr>
80106d3c:	83 c4 10             	add    $0x10,%esp
}
80106d3f:	c9                   	leave  
80106d40:	c3                   	ret    

80106d41 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106d41:	6a 00                	push   $0x0
  pushl $0
80106d43:	6a 00                	push   $0x0
  jmp alltraps
80106d45:	e9 8f f9 ff ff       	jmp    801066d9 <alltraps>

80106d4a <vector1>:
.globl vector1
vector1:
  pushl $0
80106d4a:	6a 00                	push   $0x0
  pushl $1
80106d4c:	6a 01                	push   $0x1
  jmp alltraps
80106d4e:	e9 86 f9 ff ff       	jmp    801066d9 <alltraps>

80106d53 <vector2>:
.globl vector2
vector2:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $2
80106d55:	6a 02                	push   $0x2
  jmp alltraps
80106d57:	e9 7d f9 ff ff       	jmp    801066d9 <alltraps>

80106d5c <vector3>:
.globl vector3
vector3:
  pushl $0
80106d5c:	6a 00                	push   $0x0
  pushl $3
80106d5e:	6a 03                	push   $0x3
  jmp alltraps
80106d60:	e9 74 f9 ff ff       	jmp    801066d9 <alltraps>

80106d65 <vector4>:
.globl vector4
vector4:
  pushl $0
80106d65:	6a 00                	push   $0x0
  pushl $4
80106d67:	6a 04                	push   $0x4
  jmp alltraps
80106d69:	e9 6b f9 ff ff       	jmp    801066d9 <alltraps>

80106d6e <vector5>:
.globl vector5
vector5:
  pushl $0
80106d6e:	6a 00                	push   $0x0
  pushl $5
80106d70:	6a 05                	push   $0x5
  jmp alltraps
80106d72:	e9 62 f9 ff ff       	jmp    801066d9 <alltraps>

80106d77 <vector6>:
.globl vector6
vector6:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $6
80106d79:	6a 06                	push   $0x6
  jmp alltraps
80106d7b:	e9 59 f9 ff ff       	jmp    801066d9 <alltraps>

80106d80 <vector7>:
.globl vector7
vector7:
  pushl $0
80106d80:	6a 00                	push   $0x0
  pushl $7
80106d82:	6a 07                	push   $0x7
  jmp alltraps
80106d84:	e9 50 f9 ff ff       	jmp    801066d9 <alltraps>

80106d89 <vector8>:
.globl vector8
vector8:
  pushl $8
80106d89:	6a 08                	push   $0x8
  jmp alltraps
80106d8b:	e9 49 f9 ff ff       	jmp    801066d9 <alltraps>

80106d90 <vector9>:
.globl vector9
vector9:
  pushl $0
80106d90:	6a 00                	push   $0x0
  pushl $9
80106d92:	6a 09                	push   $0x9
  jmp alltraps
80106d94:	e9 40 f9 ff ff       	jmp    801066d9 <alltraps>

80106d99 <vector10>:
.globl vector10
vector10:
  pushl $10
80106d99:	6a 0a                	push   $0xa
  jmp alltraps
80106d9b:	e9 39 f9 ff ff       	jmp    801066d9 <alltraps>

80106da0 <vector11>:
.globl vector11
vector11:
  pushl $11
80106da0:	6a 0b                	push   $0xb
  jmp alltraps
80106da2:	e9 32 f9 ff ff       	jmp    801066d9 <alltraps>

80106da7 <vector12>:
.globl vector12
vector12:
  pushl $12
80106da7:	6a 0c                	push   $0xc
  jmp alltraps
80106da9:	e9 2b f9 ff ff       	jmp    801066d9 <alltraps>

80106dae <vector13>:
.globl vector13
vector13:
  pushl $13
80106dae:	6a 0d                	push   $0xd
  jmp alltraps
80106db0:	e9 24 f9 ff ff       	jmp    801066d9 <alltraps>

80106db5 <vector14>:
.globl vector14
vector14:
  pushl $14
80106db5:	6a 0e                	push   $0xe
  jmp alltraps
80106db7:	e9 1d f9 ff ff       	jmp    801066d9 <alltraps>

80106dbc <vector15>:
.globl vector15
vector15:
  pushl $0
80106dbc:	6a 00                	push   $0x0
  pushl $15
80106dbe:	6a 0f                	push   $0xf
  jmp alltraps
80106dc0:	e9 14 f9 ff ff       	jmp    801066d9 <alltraps>

80106dc5 <vector16>:
.globl vector16
vector16:
  pushl $0
80106dc5:	6a 00                	push   $0x0
  pushl $16
80106dc7:	6a 10                	push   $0x10
  jmp alltraps
80106dc9:	e9 0b f9 ff ff       	jmp    801066d9 <alltraps>

80106dce <vector17>:
.globl vector17
vector17:
  pushl $17
80106dce:	6a 11                	push   $0x11
  jmp alltraps
80106dd0:	e9 04 f9 ff ff       	jmp    801066d9 <alltraps>

80106dd5 <vector18>:
.globl vector18
vector18:
  pushl $0
80106dd5:	6a 00                	push   $0x0
  pushl $18
80106dd7:	6a 12                	push   $0x12
  jmp alltraps
80106dd9:	e9 fb f8 ff ff       	jmp    801066d9 <alltraps>

80106dde <vector19>:
.globl vector19
vector19:
  pushl $0
80106dde:	6a 00                	push   $0x0
  pushl $19
80106de0:	6a 13                	push   $0x13
  jmp alltraps
80106de2:	e9 f2 f8 ff ff       	jmp    801066d9 <alltraps>

80106de7 <vector20>:
.globl vector20
vector20:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $20
80106de9:	6a 14                	push   $0x14
  jmp alltraps
80106deb:	e9 e9 f8 ff ff       	jmp    801066d9 <alltraps>

80106df0 <vector21>:
.globl vector21
vector21:
  pushl $0
80106df0:	6a 00                	push   $0x0
  pushl $21
80106df2:	6a 15                	push   $0x15
  jmp alltraps
80106df4:	e9 e0 f8 ff ff       	jmp    801066d9 <alltraps>

80106df9 <vector22>:
.globl vector22
vector22:
  pushl $0
80106df9:	6a 00                	push   $0x0
  pushl $22
80106dfb:	6a 16                	push   $0x16
  jmp alltraps
80106dfd:	e9 d7 f8 ff ff       	jmp    801066d9 <alltraps>

80106e02 <vector23>:
.globl vector23
vector23:
  pushl $0
80106e02:	6a 00                	push   $0x0
  pushl $23
80106e04:	6a 17                	push   $0x17
  jmp alltraps
80106e06:	e9 ce f8 ff ff       	jmp    801066d9 <alltraps>

80106e0b <vector24>:
.globl vector24
vector24:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $24
80106e0d:	6a 18                	push   $0x18
  jmp alltraps
80106e0f:	e9 c5 f8 ff ff       	jmp    801066d9 <alltraps>

80106e14 <vector25>:
.globl vector25
vector25:
  pushl $0
80106e14:	6a 00                	push   $0x0
  pushl $25
80106e16:	6a 19                	push   $0x19
  jmp alltraps
80106e18:	e9 bc f8 ff ff       	jmp    801066d9 <alltraps>

80106e1d <vector26>:
.globl vector26
vector26:
  pushl $0
80106e1d:	6a 00                	push   $0x0
  pushl $26
80106e1f:	6a 1a                	push   $0x1a
  jmp alltraps
80106e21:	e9 b3 f8 ff ff       	jmp    801066d9 <alltraps>

80106e26 <vector27>:
.globl vector27
vector27:
  pushl $0
80106e26:	6a 00                	push   $0x0
  pushl $27
80106e28:	6a 1b                	push   $0x1b
  jmp alltraps
80106e2a:	e9 aa f8 ff ff       	jmp    801066d9 <alltraps>

80106e2f <vector28>:
.globl vector28
vector28:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $28
80106e31:	6a 1c                	push   $0x1c
  jmp alltraps
80106e33:	e9 a1 f8 ff ff       	jmp    801066d9 <alltraps>

80106e38 <vector29>:
.globl vector29
vector29:
  pushl $0
80106e38:	6a 00                	push   $0x0
  pushl $29
80106e3a:	6a 1d                	push   $0x1d
  jmp alltraps
80106e3c:	e9 98 f8 ff ff       	jmp    801066d9 <alltraps>

80106e41 <vector30>:
.globl vector30
vector30:
  pushl $0
80106e41:	6a 00                	push   $0x0
  pushl $30
80106e43:	6a 1e                	push   $0x1e
  jmp alltraps
80106e45:	e9 8f f8 ff ff       	jmp    801066d9 <alltraps>

80106e4a <vector31>:
.globl vector31
vector31:
  pushl $0
80106e4a:	6a 00                	push   $0x0
  pushl $31
80106e4c:	6a 1f                	push   $0x1f
  jmp alltraps
80106e4e:	e9 86 f8 ff ff       	jmp    801066d9 <alltraps>

80106e53 <vector32>:
.globl vector32
vector32:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $32
80106e55:	6a 20                	push   $0x20
  jmp alltraps
80106e57:	e9 7d f8 ff ff       	jmp    801066d9 <alltraps>

80106e5c <vector33>:
.globl vector33
vector33:
  pushl $0
80106e5c:	6a 00                	push   $0x0
  pushl $33
80106e5e:	6a 21                	push   $0x21
  jmp alltraps
80106e60:	e9 74 f8 ff ff       	jmp    801066d9 <alltraps>

80106e65 <vector34>:
.globl vector34
vector34:
  pushl $0
80106e65:	6a 00                	push   $0x0
  pushl $34
80106e67:	6a 22                	push   $0x22
  jmp alltraps
80106e69:	e9 6b f8 ff ff       	jmp    801066d9 <alltraps>

80106e6e <vector35>:
.globl vector35
vector35:
  pushl $0
80106e6e:	6a 00                	push   $0x0
  pushl $35
80106e70:	6a 23                	push   $0x23
  jmp alltraps
80106e72:	e9 62 f8 ff ff       	jmp    801066d9 <alltraps>

80106e77 <vector36>:
.globl vector36
vector36:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $36
80106e79:	6a 24                	push   $0x24
  jmp alltraps
80106e7b:	e9 59 f8 ff ff       	jmp    801066d9 <alltraps>

80106e80 <vector37>:
.globl vector37
vector37:
  pushl $0
80106e80:	6a 00                	push   $0x0
  pushl $37
80106e82:	6a 25                	push   $0x25
  jmp alltraps
80106e84:	e9 50 f8 ff ff       	jmp    801066d9 <alltraps>

80106e89 <vector38>:
.globl vector38
vector38:
  pushl $0
80106e89:	6a 00                	push   $0x0
  pushl $38
80106e8b:	6a 26                	push   $0x26
  jmp alltraps
80106e8d:	e9 47 f8 ff ff       	jmp    801066d9 <alltraps>

80106e92 <vector39>:
.globl vector39
vector39:
  pushl $0
80106e92:	6a 00                	push   $0x0
  pushl $39
80106e94:	6a 27                	push   $0x27
  jmp alltraps
80106e96:	e9 3e f8 ff ff       	jmp    801066d9 <alltraps>

80106e9b <vector40>:
.globl vector40
vector40:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $40
80106e9d:	6a 28                	push   $0x28
  jmp alltraps
80106e9f:	e9 35 f8 ff ff       	jmp    801066d9 <alltraps>

80106ea4 <vector41>:
.globl vector41
vector41:
  pushl $0
80106ea4:	6a 00                	push   $0x0
  pushl $41
80106ea6:	6a 29                	push   $0x29
  jmp alltraps
80106ea8:	e9 2c f8 ff ff       	jmp    801066d9 <alltraps>

80106ead <vector42>:
.globl vector42
vector42:
  pushl $0
80106ead:	6a 00                	push   $0x0
  pushl $42
80106eaf:	6a 2a                	push   $0x2a
  jmp alltraps
80106eb1:	e9 23 f8 ff ff       	jmp    801066d9 <alltraps>

80106eb6 <vector43>:
.globl vector43
vector43:
  pushl $0
80106eb6:	6a 00                	push   $0x0
  pushl $43
80106eb8:	6a 2b                	push   $0x2b
  jmp alltraps
80106eba:	e9 1a f8 ff ff       	jmp    801066d9 <alltraps>

80106ebf <vector44>:
.globl vector44
vector44:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $44
80106ec1:	6a 2c                	push   $0x2c
  jmp alltraps
80106ec3:	e9 11 f8 ff ff       	jmp    801066d9 <alltraps>

80106ec8 <vector45>:
.globl vector45
vector45:
  pushl $0
80106ec8:	6a 00                	push   $0x0
  pushl $45
80106eca:	6a 2d                	push   $0x2d
  jmp alltraps
80106ecc:	e9 08 f8 ff ff       	jmp    801066d9 <alltraps>

80106ed1 <vector46>:
.globl vector46
vector46:
  pushl $0
80106ed1:	6a 00                	push   $0x0
  pushl $46
80106ed3:	6a 2e                	push   $0x2e
  jmp alltraps
80106ed5:	e9 ff f7 ff ff       	jmp    801066d9 <alltraps>

80106eda <vector47>:
.globl vector47
vector47:
  pushl $0
80106eda:	6a 00                	push   $0x0
  pushl $47
80106edc:	6a 2f                	push   $0x2f
  jmp alltraps
80106ede:	e9 f6 f7 ff ff       	jmp    801066d9 <alltraps>

80106ee3 <vector48>:
.globl vector48
vector48:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $48
80106ee5:	6a 30                	push   $0x30
  jmp alltraps
80106ee7:	e9 ed f7 ff ff       	jmp    801066d9 <alltraps>

80106eec <vector49>:
.globl vector49
vector49:
  pushl $0
80106eec:	6a 00                	push   $0x0
  pushl $49
80106eee:	6a 31                	push   $0x31
  jmp alltraps
80106ef0:	e9 e4 f7 ff ff       	jmp    801066d9 <alltraps>

80106ef5 <vector50>:
.globl vector50
vector50:
  pushl $0
80106ef5:	6a 00                	push   $0x0
  pushl $50
80106ef7:	6a 32                	push   $0x32
  jmp alltraps
80106ef9:	e9 db f7 ff ff       	jmp    801066d9 <alltraps>

80106efe <vector51>:
.globl vector51
vector51:
  pushl $0
80106efe:	6a 00                	push   $0x0
  pushl $51
80106f00:	6a 33                	push   $0x33
  jmp alltraps
80106f02:	e9 d2 f7 ff ff       	jmp    801066d9 <alltraps>

80106f07 <vector52>:
.globl vector52
vector52:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $52
80106f09:	6a 34                	push   $0x34
  jmp alltraps
80106f0b:	e9 c9 f7 ff ff       	jmp    801066d9 <alltraps>

80106f10 <vector53>:
.globl vector53
vector53:
  pushl $0
80106f10:	6a 00                	push   $0x0
  pushl $53
80106f12:	6a 35                	push   $0x35
  jmp alltraps
80106f14:	e9 c0 f7 ff ff       	jmp    801066d9 <alltraps>

80106f19 <vector54>:
.globl vector54
vector54:
  pushl $0
80106f19:	6a 00                	push   $0x0
  pushl $54
80106f1b:	6a 36                	push   $0x36
  jmp alltraps
80106f1d:	e9 b7 f7 ff ff       	jmp    801066d9 <alltraps>

80106f22 <vector55>:
.globl vector55
vector55:
  pushl $0
80106f22:	6a 00                	push   $0x0
  pushl $55
80106f24:	6a 37                	push   $0x37
  jmp alltraps
80106f26:	e9 ae f7 ff ff       	jmp    801066d9 <alltraps>

80106f2b <vector56>:
.globl vector56
vector56:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $56
80106f2d:	6a 38                	push   $0x38
  jmp alltraps
80106f2f:	e9 a5 f7 ff ff       	jmp    801066d9 <alltraps>

80106f34 <vector57>:
.globl vector57
vector57:
  pushl $0
80106f34:	6a 00                	push   $0x0
  pushl $57
80106f36:	6a 39                	push   $0x39
  jmp alltraps
80106f38:	e9 9c f7 ff ff       	jmp    801066d9 <alltraps>

80106f3d <vector58>:
.globl vector58
vector58:
  pushl $0
80106f3d:	6a 00                	push   $0x0
  pushl $58
80106f3f:	6a 3a                	push   $0x3a
  jmp alltraps
80106f41:	e9 93 f7 ff ff       	jmp    801066d9 <alltraps>

80106f46 <vector59>:
.globl vector59
vector59:
  pushl $0
80106f46:	6a 00                	push   $0x0
  pushl $59
80106f48:	6a 3b                	push   $0x3b
  jmp alltraps
80106f4a:	e9 8a f7 ff ff       	jmp    801066d9 <alltraps>

80106f4f <vector60>:
.globl vector60
vector60:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $60
80106f51:	6a 3c                	push   $0x3c
  jmp alltraps
80106f53:	e9 81 f7 ff ff       	jmp    801066d9 <alltraps>

80106f58 <vector61>:
.globl vector61
vector61:
  pushl $0
80106f58:	6a 00                	push   $0x0
  pushl $61
80106f5a:	6a 3d                	push   $0x3d
  jmp alltraps
80106f5c:	e9 78 f7 ff ff       	jmp    801066d9 <alltraps>

80106f61 <vector62>:
.globl vector62
vector62:
  pushl $0
80106f61:	6a 00                	push   $0x0
  pushl $62
80106f63:	6a 3e                	push   $0x3e
  jmp alltraps
80106f65:	e9 6f f7 ff ff       	jmp    801066d9 <alltraps>

80106f6a <vector63>:
.globl vector63
vector63:
  pushl $0
80106f6a:	6a 00                	push   $0x0
  pushl $63
80106f6c:	6a 3f                	push   $0x3f
  jmp alltraps
80106f6e:	e9 66 f7 ff ff       	jmp    801066d9 <alltraps>

80106f73 <vector64>:
.globl vector64
vector64:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $64
80106f75:	6a 40                	push   $0x40
  jmp alltraps
80106f77:	e9 5d f7 ff ff       	jmp    801066d9 <alltraps>

80106f7c <vector65>:
.globl vector65
vector65:
  pushl $0
80106f7c:	6a 00                	push   $0x0
  pushl $65
80106f7e:	6a 41                	push   $0x41
  jmp alltraps
80106f80:	e9 54 f7 ff ff       	jmp    801066d9 <alltraps>

80106f85 <vector66>:
.globl vector66
vector66:
  pushl $0
80106f85:	6a 00                	push   $0x0
  pushl $66
80106f87:	6a 42                	push   $0x42
  jmp alltraps
80106f89:	e9 4b f7 ff ff       	jmp    801066d9 <alltraps>

80106f8e <vector67>:
.globl vector67
vector67:
  pushl $0
80106f8e:	6a 00                	push   $0x0
  pushl $67
80106f90:	6a 43                	push   $0x43
  jmp alltraps
80106f92:	e9 42 f7 ff ff       	jmp    801066d9 <alltraps>

80106f97 <vector68>:
.globl vector68
vector68:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $68
80106f99:	6a 44                	push   $0x44
  jmp alltraps
80106f9b:	e9 39 f7 ff ff       	jmp    801066d9 <alltraps>

80106fa0 <vector69>:
.globl vector69
vector69:
  pushl $0
80106fa0:	6a 00                	push   $0x0
  pushl $69
80106fa2:	6a 45                	push   $0x45
  jmp alltraps
80106fa4:	e9 30 f7 ff ff       	jmp    801066d9 <alltraps>

80106fa9 <vector70>:
.globl vector70
vector70:
  pushl $0
80106fa9:	6a 00                	push   $0x0
  pushl $70
80106fab:	6a 46                	push   $0x46
  jmp alltraps
80106fad:	e9 27 f7 ff ff       	jmp    801066d9 <alltraps>

80106fb2 <vector71>:
.globl vector71
vector71:
  pushl $0
80106fb2:	6a 00                	push   $0x0
  pushl $71
80106fb4:	6a 47                	push   $0x47
  jmp alltraps
80106fb6:	e9 1e f7 ff ff       	jmp    801066d9 <alltraps>

80106fbb <vector72>:
.globl vector72
vector72:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $72
80106fbd:	6a 48                	push   $0x48
  jmp alltraps
80106fbf:	e9 15 f7 ff ff       	jmp    801066d9 <alltraps>

80106fc4 <vector73>:
.globl vector73
vector73:
  pushl $0
80106fc4:	6a 00                	push   $0x0
  pushl $73
80106fc6:	6a 49                	push   $0x49
  jmp alltraps
80106fc8:	e9 0c f7 ff ff       	jmp    801066d9 <alltraps>

80106fcd <vector74>:
.globl vector74
vector74:
  pushl $0
80106fcd:	6a 00                	push   $0x0
  pushl $74
80106fcf:	6a 4a                	push   $0x4a
  jmp alltraps
80106fd1:	e9 03 f7 ff ff       	jmp    801066d9 <alltraps>

80106fd6 <vector75>:
.globl vector75
vector75:
  pushl $0
80106fd6:	6a 00                	push   $0x0
  pushl $75
80106fd8:	6a 4b                	push   $0x4b
  jmp alltraps
80106fda:	e9 fa f6 ff ff       	jmp    801066d9 <alltraps>

80106fdf <vector76>:
.globl vector76
vector76:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $76
80106fe1:	6a 4c                	push   $0x4c
  jmp alltraps
80106fe3:	e9 f1 f6 ff ff       	jmp    801066d9 <alltraps>

80106fe8 <vector77>:
.globl vector77
vector77:
  pushl $0
80106fe8:	6a 00                	push   $0x0
  pushl $77
80106fea:	6a 4d                	push   $0x4d
  jmp alltraps
80106fec:	e9 e8 f6 ff ff       	jmp    801066d9 <alltraps>

80106ff1 <vector78>:
.globl vector78
vector78:
  pushl $0
80106ff1:	6a 00                	push   $0x0
  pushl $78
80106ff3:	6a 4e                	push   $0x4e
  jmp alltraps
80106ff5:	e9 df f6 ff ff       	jmp    801066d9 <alltraps>

80106ffa <vector79>:
.globl vector79
vector79:
  pushl $0
80106ffa:	6a 00                	push   $0x0
  pushl $79
80106ffc:	6a 4f                	push   $0x4f
  jmp alltraps
80106ffe:	e9 d6 f6 ff ff       	jmp    801066d9 <alltraps>

80107003 <vector80>:
.globl vector80
vector80:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $80
80107005:	6a 50                	push   $0x50
  jmp alltraps
80107007:	e9 cd f6 ff ff       	jmp    801066d9 <alltraps>

8010700c <vector81>:
.globl vector81
vector81:
  pushl $0
8010700c:	6a 00                	push   $0x0
  pushl $81
8010700e:	6a 51                	push   $0x51
  jmp alltraps
80107010:	e9 c4 f6 ff ff       	jmp    801066d9 <alltraps>

80107015 <vector82>:
.globl vector82
vector82:
  pushl $0
80107015:	6a 00                	push   $0x0
  pushl $82
80107017:	6a 52                	push   $0x52
  jmp alltraps
80107019:	e9 bb f6 ff ff       	jmp    801066d9 <alltraps>

8010701e <vector83>:
.globl vector83
vector83:
  pushl $0
8010701e:	6a 00                	push   $0x0
  pushl $83
80107020:	6a 53                	push   $0x53
  jmp alltraps
80107022:	e9 b2 f6 ff ff       	jmp    801066d9 <alltraps>

80107027 <vector84>:
.globl vector84
vector84:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $84
80107029:	6a 54                	push   $0x54
  jmp alltraps
8010702b:	e9 a9 f6 ff ff       	jmp    801066d9 <alltraps>

80107030 <vector85>:
.globl vector85
vector85:
  pushl $0
80107030:	6a 00                	push   $0x0
  pushl $85
80107032:	6a 55                	push   $0x55
  jmp alltraps
80107034:	e9 a0 f6 ff ff       	jmp    801066d9 <alltraps>

80107039 <vector86>:
.globl vector86
vector86:
  pushl $0
80107039:	6a 00                	push   $0x0
  pushl $86
8010703b:	6a 56                	push   $0x56
  jmp alltraps
8010703d:	e9 97 f6 ff ff       	jmp    801066d9 <alltraps>

80107042 <vector87>:
.globl vector87
vector87:
  pushl $0
80107042:	6a 00                	push   $0x0
  pushl $87
80107044:	6a 57                	push   $0x57
  jmp alltraps
80107046:	e9 8e f6 ff ff       	jmp    801066d9 <alltraps>

8010704b <vector88>:
.globl vector88
vector88:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $88
8010704d:	6a 58                	push   $0x58
  jmp alltraps
8010704f:	e9 85 f6 ff ff       	jmp    801066d9 <alltraps>

80107054 <vector89>:
.globl vector89
vector89:
  pushl $0
80107054:	6a 00                	push   $0x0
  pushl $89
80107056:	6a 59                	push   $0x59
  jmp alltraps
80107058:	e9 7c f6 ff ff       	jmp    801066d9 <alltraps>

8010705d <vector90>:
.globl vector90
vector90:
  pushl $0
8010705d:	6a 00                	push   $0x0
  pushl $90
8010705f:	6a 5a                	push   $0x5a
  jmp alltraps
80107061:	e9 73 f6 ff ff       	jmp    801066d9 <alltraps>

80107066 <vector91>:
.globl vector91
vector91:
  pushl $0
80107066:	6a 00                	push   $0x0
  pushl $91
80107068:	6a 5b                	push   $0x5b
  jmp alltraps
8010706a:	e9 6a f6 ff ff       	jmp    801066d9 <alltraps>

8010706f <vector92>:
.globl vector92
vector92:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $92
80107071:	6a 5c                	push   $0x5c
  jmp alltraps
80107073:	e9 61 f6 ff ff       	jmp    801066d9 <alltraps>

80107078 <vector93>:
.globl vector93
vector93:
  pushl $0
80107078:	6a 00                	push   $0x0
  pushl $93
8010707a:	6a 5d                	push   $0x5d
  jmp alltraps
8010707c:	e9 58 f6 ff ff       	jmp    801066d9 <alltraps>

80107081 <vector94>:
.globl vector94
vector94:
  pushl $0
80107081:	6a 00                	push   $0x0
  pushl $94
80107083:	6a 5e                	push   $0x5e
  jmp alltraps
80107085:	e9 4f f6 ff ff       	jmp    801066d9 <alltraps>

8010708a <vector95>:
.globl vector95
vector95:
  pushl $0
8010708a:	6a 00                	push   $0x0
  pushl $95
8010708c:	6a 5f                	push   $0x5f
  jmp alltraps
8010708e:	e9 46 f6 ff ff       	jmp    801066d9 <alltraps>

80107093 <vector96>:
.globl vector96
vector96:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $96
80107095:	6a 60                	push   $0x60
  jmp alltraps
80107097:	e9 3d f6 ff ff       	jmp    801066d9 <alltraps>

8010709c <vector97>:
.globl vector97
vector97:
  pushl $0
8010709c:	6a 00                	push   $0x0
  pushl $97
8010709e:	6a 61                	push   $0x61
  jmp alltraps
801070a0:	e9 34 f6 ff ff       	jmp    801066d9 <alltraps>

801070a5 <vector98>:
.globl vector98
vector98:
  pushl $0
801070a5:	6a 00                	push   $0x0
  pushl $98
801070a7:	6a 62                	push   $0x62
  jmp alltraps
801070a9:	e9 2b f6 ff ff       	jmp    801066d9 <alltraps>

801070ae <vector99>:
.globl vector99
vector99:
  pushl $0
801070ae:	6a 00                	push   $0x0
  pushl $99
801070b0:	6a 63                	push   $0x63
  jmp alltraps
801070b2:	e9 22 f6 ff ff       	jmp    801066d9 <alltraps>

801070b7 <vector100>:
.globl vector100
vector100:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $100
801070b9:	6a 64                	push   $0x64
  jmp alltraps
801070bb:	e9 19 f6 ff ff       	jmp    801066d9 <alltraps>

801070c0 <vector101>:
.globl vector101
vector101:
  pushl $0
801070c0:	6a 00                	push   $0x0
  pushl $101
801070c2:	6a 65                	push   $0x65
  jmp alltraps
801070c4:	e9 10 f6 ff ff       	jmp    801066d9 <alltraps>

801070c9 <vector102>:
.globl vector102
vector102:
  pushl $0
801070c9:	6a 00                	push   $0x0
  pushl $102
801070cb:	6a 66                	push   $0x66
  jmp alltraps
801070cd:	e9 07 f6 ff ff       	jmp    801066d9 <alltraps>

801070d2 <vector103>:
.globl vector103
vector103:
  pushl $0
801070d2:	6a 00                	push   $0x0
  pushl $103
801070d4:	6a 67                	push   $0x67
  jmp alltraps
801070d6:	e9 fe f5 ff ff       	jmp    801066d9 <alltraps>

801070db <vector104>:
.globl vector104
vector104:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $104
801070dd:	6a 68                	push   $0x68
  jmp alltraps
801070df:	e9 f5 f5 ff ff       	jmp    801066d9 <alltraps>

801070e4 <vector105>:
.globl vector105
vector105:
  pushl $0
801070e4:	6a 00                	push   $0x0
  pushl $105
801070e6:	6a 69                	push   $0x69
  jmp alltraps
801070e8:	e9 ec f5 ff ff       	jmp    801066d9 <alltraps>

801070ed <vector106>:
.globl vector106
vector106:
  pushl $0
801070ed:	6a 00                	push   $0x0
  pushl $106
801070ef:	6a 6a                	push   $0x6a
  jmp alltraps
801070f1:	e9 e3 f5 ff ff       	jmp    801066d9 <alltraps>

801070f6 <vector107>:
.globl vector107
vector107:
  pushl $0
801070f6:	6a 00                	push   $0x0
  pushl $107
801070f8:	6a 6b                	push   $0x6b
  jmp alltraps
801070fa:	e9 da f5 ff ff       	jmp    801066d9 <alltraps>

801070ff <vector108>:
.globl vector108
vector108:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $108
80107101:	6a 6c                	push   $0x6c
  jmp alltraps
80107103:	e9 d1 f5 ff ff       	jmp    801066d9 <alltraps>

80107108 <vector109>:
.globl vector109
vector109:
  pushl $0
80107108:	6a 00                	push   $0x0
  pushl $109
8010710a:	6a 6d                	push   $0x6d
  jmp alltraps
8010710c:	e9 c8 f5 ff ff       	jmp    801066d9 <alltraps>

80107111 <vector110>:
.globl vector110
vector110:
  pushl $0
80107111:	6a 00                	push   $0x0
  pushl $110
80107113:	6a 6e                	push   $0x6e
  jmp alltraps
80107115:	e9 bf f5 ff ff       	jmp    801066d9 <alltraps>

8010711a <vector111>:
.globl vector111
vector111:
  pushl $0
8010711a:	6a 00                	push   $0x0
  pushl $111
8010711c:	6a 6f                	push   $0x6f
  jmp alltraps
8010711e:	e9 b6 f5 ff ff       	jmp    801066d9 <alltraps>

80107123 <vector112>:
.globl vector112
vector112:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $112
80107125:	6a 70                	push   $0x70
  jmp alltraps
80107127:	e9 ad f5 ff ff       	jmp    801066d9 <alltraps>

8010712c <vector113>:
.globl vector113
vector113:
  pushl $0
8010712c:	6a 00                	push   $0x0
  pushl $113
8010712e:	6a 71                	push   $0x71
  jmp alltraps
80107130:	e9 a4 f5 ff ff       	jmp    801066d9 <alltraps>

80107135 <vector114>:
.globl vector114
vector114:
  pushl $0
80107135:	6a 00                	push   $0x0
  pushl $114
80107137:	6a 72                	push   $0x72
  jmp alltraps
80107139:	e9 9b f5 ff ff       	jmp    801066d9 <alltraps>

8010713e <vector115>:
.globl vector115
vector115:
  pushl $0
8010713e:	6a 00                	push   $0x0
  pushl $115
80107140:	6a 73                	push   $0x73
  jmp alltraps
80107142:	e9 92 f5 ff ff       	jmp    801066d9 <alltraps>

80107147 <vector116>:
.globl vector116
vector116:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $116
80107149:	6a 74                	push   $0x74
  jmp alltraps
8010714b:	e9 89 f5 ff ff       	jmp    801066d9 <alltraps>

80107150 <vector117>:
.globl vector117
vector117:
  pushl $0
80107150:	6a 00                	push   $0x0
  pushl $117
80107152:	6a 75                	push   $0x75
  jmp alltraps
80107154:	e9 80 f5 ff ff       	jmp    801066d9 <alltraps>

80107159 <vector118>:
.globl vector118
vector118:
  pushl $0
80107159:	6a 00                	push   $0x0
  pushl $118
8010715b:	6a 76                	push   $0x76
  jmp alltraps
8010715d:	e9 77 f5 ff ff       	jmp    801066d9 <alltraps>

80107162 <vector119>:
.globl vector119
vector119:
  pushl $0
80107162:	6a 00                	push   $0x0
  pushl $119
80107164:	6a 77                	push   $0x77
  jmp alltraps
80107166:	e9 6e f5 ff ff       	jmp    801066d9 <alltraps>

8010716b <vector120>:
.globl vector120
vector120:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $120
8010716d:	6a 78                	push   $0x78
  jmp alltraps
8010716f:	e9 65 f5 ff ff       	jmp    801066d9 <alltraps>

80107174 <vector121>:
.globl vector121
vector121:
  pushl $0
80107174:	6a 00                	push   $0x0
  pushl $121
80107176:	6a 79                	push   $0x79
  jmp alltraps
80107178:	e9 5c f5 ff ff       	jmp    801066d9 <alltraps>

8010717d <vector122>:
.globl vector122
vector122:
  pushl $0
8010717d:	6a 00                	push   $0x0
  pushl $122
8010717f:	6a 7a                	push   $0x7a
  jmp alltraps
80107181:	e9 53 f5 ff ff       	jmp    801066d9 <alltraps>

80107186 <vector123>:
.globl vector123
vector123:
  pushl $0
80107186:	6a 00                	push   $0x0
  pushl $123
80107188:	6a 7b                	push   $0x7b
  jmp alltraps
8010718a:	e9 4a f5 ff ff       	jmp    801066d9 <alltraps>

8010718f <vector124>:
.globl vector124
vector124:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $124
80107191:	6a 7c                	push   $0x7c
  jmp alltraps
80107193:	e9 41 f5 ff ff       	jmp    801066d9 <alltraps>

80107198 <vector125>:
.globl vector125
vector125:
  pushl $0
80107198:	6a 00                	push   $0x0
  pushl $125
8010719a:	6a 7d                	push   $0x7d
  jmp alltraps
8010719c:	e9 38 f5 ff ff       	jmp    801066d9 <alltraps>

801071a1 <vector126>:
.globl vector126
vector126:
  pushl $0
801071a1:	6a 00                	push   $0x0
  pushl $126
801071a3:	6a 7e                	push   $0x7e
  jmp alltraps
801071a5:	e9 2f f5 ff ff       	jmp    801066d9 <alltraps>

801071aa <vector127>:
.globl vector127
vector127:
  pushl $0
801071aa:	6a 00                	push   $0x0
  pushl $127
801071ac:	6a 7f                	push   $0x7f
  jmp alltraps
801071ae:	e9 26 f5 ff ff       	jmp    801066d9 <alltraps>

801071b3 <vector128>:
.globl vector128
vector128:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $128
801071b5:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801071ba:	e9 1a f5 ff ff       	jmp    801066d9 <alltraps>

801071bf <vector129>:
.globl vector129
vector129:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $129
801071c1:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801071c6:	e9 0e f5 ff ff       	jmp    801066d9 <alltraps>

801071cb <vector130>:
.globl vector130
vector130:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $130
801071cd:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801071d2:	e9 02 f5 ff ff       	jmp    801066d9 <alltraps>

801071d7 <vector131>:
.globl vector131
vector131:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $131
801071d9:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801071de:	e9 f6 f4 ff ff       	jmp    801066d9 <alltraps>

801071e3 <vector132>:
.globl vector132
vector132:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $132
801071e5:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801071ea:	e9 ea f4 ff ff       	jmp    801066d9 <alltraps>

801071ef <vector133>:
.globl vector133
vector133:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $133
801071f1:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801071f6:	e9 de f4 ff ff       	jmp    801066d9 <alltraps>

801071fb <vector134>:
.globl vector134
vector134:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $134
801071fd:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107202:	e9 d2 f4 ff ff       	jmp    801066d9 <alltraps>

80107207 <vector135>:
.globl vector135
vector135:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $135
80107209:	68 87 00 00 00       	push   $0x87
  jmp alltraps
8010720e:	e9 c6 f4 ff ff       	jmp    801066d9 <alltraps>

80107213 <vector136>:
.globl vector136
vector136:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $136
80107215:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010721a:	e9 ba f4 ff ff       	jmp    801066d9 <alltraps>

8010721f <vector137>:
.globl vector137
vector137:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $137
80107221:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107226:	e9 ae f4 ff ff       	jmp    801066d9 <alltraps>

8010722b <vector138>:
.globl vector138
vector138:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $138
8010722d:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107232:	e9 a2 f4 ff ff       	jmp    801066d9 <alltraps>

80107237 <vector139>:
.globl vector139
vector139:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $139
80107239:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
8010723e:	e9 96 f4 ff ff       	jmp    801066d9 <alltraps>

80107243 <vector140>:
.globl vector140
vector140:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $140
80107245:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010724a:	e9 8a f4 ff ff       	jmp    801066d9 <alltraps>

8010724f <vector141>:
.globl vector141
vector141:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $141
80107251:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107256:	e9 7e f4 ff ff       	jmp    801066d9 <alltraps>

8010725b <vector142>:
.globl vector142
vector142:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $142
8010725d:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107262:	e9 72 f4 ff ff       	jmp    801066d9 <alltraps>

80107267 <vector143>:
.globl vector143
vector143:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $143
80107269:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010726e:	e9 66 f4 ff ff       	jmp    801066d9 <alltraps>

80107273 <vector144>:
.globl vector144
vector144:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $144
80107275:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010727a:	e9 5a f4 ff ff       	jmp    801066d9 <alltraps>

8010727f <vector145>:
.globl vector145
vector145:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $145
80107281:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107286:	e9 4e f4 ff ff       	jmp    801066d9 <alltraps>

8010728b <vector146>:
.globl vector146
vector146:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $146
8010728d:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107292:	e9 42 f4 ff ff       	jmp    801066d9 <alltraps>

80107297 <vector147>:
.globl vector147
vector147:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $147
80107299:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010729e:	e9 36 f4 ff ff       	jmp    801066d9 <alltraps>

801072a3 <vector148>:
.globl vector148
vector148:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $148
801072a5:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801072aa:	e9 2a f4 ff ff       	jmp    801066d9 <alltraps>

801072af <vector149>:
.globl vector149
vector149:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $149
801072b1:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801072b6:	e9 1e f4 ff ff       	jmp    801066d9 <alltraps>

801072bb <vector150>:
.globl vector150
vector150:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $150
801072bd:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801072c2:	e9 12 f4 ff ff       	jmp    801066d9 <alltraps>

801072c7 <vector151>:
.globl vector151
vector151:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $151
801072c9:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801072ce:	e9 06 f4 ff ff       	jmp    801066d9 <alltraps>

801072d3 <vector152>:
.globl vector152
vector152:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $152
801072d5:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801072da:	e9 fa f3 ff ff       	jmp    801066d9 <alltraps>

801072df <vector153>:
.globl vector153
vector153:
  pushl $0
801072df:	6a 00                	push   $0x0
  pushl $153
801072e1:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801072e6:	e9 ee f3 ff ff       	jmp    801066d9 <alltraps>

801072eb <vector154>:
.globl vector154
vector154:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $154
801072ed:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801072f2:	e9 e2 f3 ff ff       	jmp    801066d9 <alltraps>

801072f7 <vector155>:
.globl vector155
vector155:
  pushl $0
801072f7:	6a 00                	push   $0x0
  pushl $155
801072f9:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801072fe:	e9 d6 f3 ff ff       	jmp    801066d9 <alltraps>

80107303 <vector156>:
.globl vector156
vector156:
  pushl $0
80107303:	6a 00                	push   $0x0
  pushl $156
80107305:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010730a:	e9 ca f3 ff ff       	jmp    801066d9 <alltraps>

8010730f <vector157>:
.globl vector157
vector157:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $157
80107311:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107316:	e9 be f3 ff ff       	jmp    801066d9 <alltraps>

8010731b <vector158>:
.globl vector158
vector158:
  pushl $0
8010731b:	6a 00                	push   $0x0
  pushl $158
8010731d:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107322:	e9 b2 f3 ff ff       	jmp    801066d9 <alltraps>

80107327 <vector159>:
.globl vector159
vector159:
  pushl $0
80107327:	6a 00                	push   $0x0
  pushl $159
80107329:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
8010732e:	e9 a6 f3 ff ff       	jmp    801066d9 <alltraps>

80107333 <vector160>:
.globl vector160
vector160:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $160
80107335:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010733a:	e9 9a f3 ff ff       	jmp    801066d9 <alltraps>

8010733f <vector161>:
.globl vector161
vector161:
  pushl $0
8010733f:	6a 00                	push   $0x0
  pushl $161
80107341:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107346:	e9 8e f3 ff ff       	jmp    801066d9 <alltraps>

8010734b <vector162>:
.globl vector162
vector162:
  pushl $0
8010734b:	6a 00                	push   $0x0
  pushl $162
8010734d:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107352:	e9 82 f3 ff ff       	jmp    801066d9 <alltraps>

80107357 <vector163>:
.globl vector163
vector163:
  pushl $0
80107357:	6a 00                	push   $0x0
  pushl $163
80107359:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010735e:	e9 76 f3 ff ff       	jmp    801066d9 <alltraps>

80107363 <vector164>:
.globl vector164
vector164:
  pushl $0
80107363:	6a 00                	push   $0x0
  pushl $164
80107365:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010736a:	e9 6a f3 ff ff       	jmp    801066d9 <alltraps>

8010736f <vector165>:
.globl vector165
vector165:
  pushl $0
8010736f:	6a 00                	push   $0x0
  pushl $165
80107371:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107376:	e9 5e f3 ff ff       	jmp    801066d9 <alltraps>

8010737b <vector166>:
.globl vector166
vector166:
  pushl $0
8010737b:	6a 00                	push   $0x0
  pushl $166
8010737d:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107382:	e9 52 f3 ff ff       	jmp    801066d9 <alltraps>

80107387 <vector167>:
.globl vector167
vector167:
  pushl $0
80107387:	6a 00                	push   $0x0
  pushl $167
80107389:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010738e:	e9 46 f3 ff ff       	jmp    801066d9 <alltraps>

80107393 <vector168>:
.globl vector168
vector168:
  pushl $0
80107393:	6a 00                	push   $0x0
  pushl $168
80107395:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010739a:	e9 3a f3 ff ff       	jmp    801066d9 <alltraps>

8010739f <vector169>:
.globl vector169
vector169:
  pushl $0
8010739f:	6a 00                	push   $0x0
  pushl $169
801073a1:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801073a6:	e9 2e f3 ff ff       	jmp    801066d9 <alltraps>

801073ab <vector170>:
.globl vector170
vector170:
  pushl $0
801073ab:	6a 00                	push   $0x0
  pushl $170
801073ad:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801073b2:	e9 22 f3 ff ff       	jmp    801066d9 <alltraps>

801073b7 <vector171>:
.globl vector171
vector171:
  pushl $0
801073b7:	6a 00                	push   $0x0
  pushl $171
801073b9:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801073be:	e9 16 f3 ff ff       	jmp    801066d9 <alltraps>

801073c3 <vector172>:
.globl vector172
vector172:
  pushl $0
801073c3:	6a 00                	push   $0x0
  pushl $172
801073c5:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801073ca:	e9 0a f3 ff ff       	jmp    801066d9 <alltraps>

801073cf <vector173>:
.globl vector173
vector173:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $173
801073d1:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801073d6:	e9 fe f2 ff ff       	jmp    801066d9 <alltraps>

801073db <vector174>:
.globl vector174
vector174:
  pushl $0
801073db:	6a 00                	push   $0x0
  pushl $174
801073dd:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801073e2:	e9 f2 f2 ff ff       	jmp    801066d9 <alltraps>

801073e7 <vector175>:
.globl vector175
vector175:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $175
801073e9:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801073ee:	e9 e6 f2 ff ff       	jmp    801066d9 <alltraps>

801073f3 <vector176>:
.globl vector176
vector176:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $176
801073f5:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801073fa:	e9 da f2 ff ff       	jmp    801066d9 <alltraps>

801073ff <vector177>:
.globl vector177
vector177:
  pushl $0
801073ff:	6a 00                	push   $0x0
  pushl $177
80107401:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107406:	e9 ce f2 ff ff       	jmp    801066d9 <alltraps>

8010740b <vector178>:
.globl vector178
vector178:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $178
8010740d:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107412:	e9 c2 f2 ff ff       	jmp    801066d9 <alltraps>

80107417 <vector179>:
.globl vector179
vector179:
  pushl $0
80107417:	6a 00                	push   $0x0
  pushl $179
80107419:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
8010741e:	e9 b6 f2 ff ff       	jmp    801066d9 <alltraps>

80107423 <vector180>:
.globl vector180
vector180:
  pushl $0
80107423:	6a 00                	push   $0x0
  pushl $180
80107425:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010742a:	e9 aa f2 ff ff       	jmp    801066d9 <alltraps>

8010742f <vector181>:
.globl vector181
vector181:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $181
80107431:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107436:	e9 9e f2 ff ff       	jmp    801066d9 <alltraps>

8010743b <vector182>:
.globl vector182
vector182:
  pushl $0
8010743b:	6a 00                	push   $0x0
  pushl $182
8010743d:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107442:	e9 92 f2 ff ff       	jmp    801066d9 <alltraps>

80107447 <vector183>:
.globl vector183
vector183:
  pushl $0
80107447:	6a 00                	push   $0x0
  pushl $183
80107449:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010744e:	e9 86 f2 ff ff       	jmp    801066d9 <alltraps>

80107453 <vector184>:
.globl vector184
vector184:
  pushl $0
80107453:	6a 00                	push   $0x0
  pushl $184
80107455:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010745a:	e9 7a f2 ff ff       	jmp    801066d9 <alltraps>

8010745f <vector185>:
.globl vector185
vector185:
  pushl $0
8010745f:	6a 00                	push   $0x0
  pushl $185
80107461:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107466:	e9 6e f2 ff ff       	jmp    801066d9 <alltraps>

8010746b <vector186>:
.globl vector186
vector186:
  pushl $0
8010746b:	6a 00                	push   $0x0
  pushl $186
8010746d:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107472:	e9 62 f2 ff ff       	jmp    801066d9 <alltraps>

80107477 <vector187>:
.globl vector187
vector187:
  pushl $0
80107477:	6a 00                	push   $0x0
  pushl $187
80107479:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010747e:	e9 56 f2 ff ff       	jmp    801066d9 <alltraps>

80107483 <vector188>:
.globl vector188
vector188:
  pushl $0
80107483:	6a 00                	push   $0x0
  pushl $188
80107485:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010748a:	e9 4a f2 ff ff       	jmp    801066d9 <alltraps>

8010748f <vector189>:
.globl vector189
vector189:
  pushl $0
8010748f:	6a 00                	push   $0x0
  pushl $189
80107491:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107496:	e9 3e f2 ff ff       	jmp    801066d9 <alltraps>

8010749b <vector190>:
.globl vector190
vector190:
  pushl $0
8010749b:	6a 00                	push   $0x0
  pushl $190
8010749d:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801074a2:	e9 32 f2 ff ff       	jmp    801066d9 <alltraps>

801074a7 <vector191>:
.globl vector191
vector191:
  pushl $0
801074a7:	6a 00                	push   $0x0
  pushl $191
801074a9:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801074ae:	e9 26 f2 ff ff       	jmp    801066d9 <alltraps>

801074b3 <vector192>:
.globl vector192
vector192:
  pushl $0
801074b3:	6a 00                	push   $0x0
  pushl $192
801074b5:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801074ba:	e9 1a f2 ff ff       	jmp    801066d9 <alltraps>

801074bf <vector193>:
.globl vector193
vector193:
  pushl $0
801074bf:	6a 00                	push   $0x0
  pushl $193
801074c1:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801074c6:	e9 0e f2 ff ff       	jmp    801066d9 <alltraps>

801074cb <vector194>:
.globl vector194
vector194:
  pushl $0
801074cb:	6a 00                	push   $0x0
  pushl $194
801074cd:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801074d2:	e9 02 f2 ff ff       	jmp    801066d9 <alltraps>

801074d7 <vector195>:
.globl vector195
vector195:
  pushl $0
801074d7:	6a 00                	push   $0x0
  pushl $195
801074d9:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801074de:	e9 f6 f1 ff ff       	jmp    801066d9 <alltraps>

801074e3 <vector196>:
.globl vector196
vector196:
  pushl $0
801074e3:	6a 00                	push   $0x0
  pushl $196
801074e5:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801074ea:	e9 ea f1 ff ff       	jmp    801066d9 <alltraps>

801074ef <vector197>:
.globl vector197
vector197:
  pushl $0
801074ef:	6a 00                	push   $0x0
  pushl $197
801074f1:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801074f6:	e9 de f1 ff ff       	jmp    801066d9 <alltraps>

801074fb <vector198>:
.globl vector198
vector198:
  pushl $0
801074fb:	6a 00                	push   $0x0
  pushl $198
801074fd:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107502:	e9 d2 f1 ff ff       	jmp    801066d9 <alltraps>

80107507 <vector199>:
.globl vector199
vector199:
  pushl $0
80107507:	6a 00                	push   $0x0
  pushl $199
80107509:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
8010750e:	e9 c6 f1 ff ff       	jmp    801066d9 <alltraps>

80107513 <vector200>:
.globl vector200
vector200:
  pushl $0
80107513:	6a 00                	push   $0x0
  pushl $200
80107515:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010751a:	e9 ba f1 ff ff       	jmp    801066d9 <alltraps>

8010751f <vector201>:
.globl vector201
vector201:
  pushl $0
8010751f:	6a 00                	push   $0x0
  pushl $201
80107521:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107526:	e9 ae f1 ff ff       	jmp    801066d9 <alltraps>

8010752b <vector202>:
.globl vector202
vector202:
  pushl $0
8010752b:	6a 00                	push   $0x0
  pushl $202
8010752d:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107532:	e9 a2 f1 ff ff       	jmp    801066d9 <alltraps>

80107537 <vector203>:
.globl vector203
vector203:
  pushl $0
80107537:	6a 00                	push   $0x0
  pushl $203
80107539:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
8010753e:	e9 96 f1 ff ff       	jmp    801066d9 <alltraps>

80107543 <vector204>:
.globl vector204
vector204:
  pushl $0
80107543:	6a 00                	push   $0x0
  pushl $204
80107545:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010754a:	e9 8a f1 ff ff       	jmp    801066d9 <alltraps>

8010754f <vector205>:
.globl vector205
vector205:
  pushl $0
8010754f:	6a 00                	push   $0x0
  pushl $205
80107551:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107556:	e9 7e f1 ff ff       	jmp    801066d9 <alltraps>

8010755b <vector206>:
.globl vector206
vector206:
  pushl $0
8010755b:	6a 00                	push   $0x0
  pushl $206
8010755d:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107562:	e9 72 f1 ff ff       	jmp    801066d9 <alltraps>

80107567 <vector207>:
.globl vector207
vector207:
  pushl $0
80107567:	6a 00                	push   $0x0
  pushl $207
80107569:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
8010756e:	e9 66 f1 ff ff       	jmp    801066d9 <alltraps>

80107573 <vector208>:
.globl vector208
vector208:
  pushl $0
80107573:	6a 00                	push   $0x0
  pushl $208
80107575:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010757a:	e9 5a f1 ff ff       	jmp    801066d9 <alltraps>

8010757f <vector209>:
.globl vector209
vector209:
  pushl $0
8010757f:	6a 00                	push   $0x0
  pushl $209
80107581:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107586:	e9 4e f1 ff ff       	jmp    801066d9 <alltraps>

8010758b <vector210>:
.globl vector210
vector210:
  pushl $0
8010758b:	6a 00                	push   $0x0
  pushl $210
8010758d:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107592:	e9 42 f1 ff ff       	jmp    801066d9 <alltraps>

80107597 <vector211>:
.globl vector211
vector211:
  pushl $0
80107597:	6a 00                	push   $0x0
  pushl $211
80107599:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010759e:	e9 36 f1 ff ff       	jmp    801066d9 <alltraps>

801075a3 <vector212>:
.globl vector212
vector212:
  pushl $0
801075a3:	6a 00                	push   $0x0
  pushl $212
801075a5:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801075aa:	e9 2a f1 ff ff       	jmp    801066d9 <alltraps>

801075af <vector213>:
.globl vector213
vector213:
  pushl $0
801075af:	6a 00                	push   $0x0
  pushl $213
801075b1:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801075b6:	e9 1e f1 ff ff       	jmp    801066d9 <alltraps>

801075bb <vector214>:
.globl vector214
vector214:
  pushl $0
801075bb:	6a 00                	push   $0x0
  pushl $214
801075bd:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801075c2:	e9 12 f1 ff ff       	jmp    801066d9 <alltraps>

801075c7 <vector215>:
.globl vector215
vector215:
  pushl $0
801075c7:	6a 00                	push   $0x0
  pushl $215
801075c9:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801075ce:	e9 06 f1 ff ff       	jmp    801066d9 <alltraps>

801075d3 <vector216>:
.globl vector216
vector216:
  pushl $0
801075d3:	6a 00                	push   $0x0
  pushl $216
801075d5:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801075da:	e9 fa f0 ff ff       	jmp    801066d9 <alltraps>

801075df <vector217>:
.globl vector217
vector217:
  pushl $0
801075df:	6a 00                	push   $0x0
  pushl $217
801075e1:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801075e6:	e9 ee f0 ff ff       	jmp    801066d9 <alltraps>

801075eb <vector218>:
.globl vector218
vector218:
  pushl $0
801075eb:	6a 00                	push   $0x0
  pushl $218
801075ed:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801075f2:	e9 e2 f0 ff ff       	jmp    801066d9 <alltraps>

801075f7 <vector219>:
.globl vector219
vector219:
  pushl $0
801075f7:	6a 00                	push   $0x0
  pushl $219
801075f9:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801075fe:	e9 d6 f0 ff ff       	jmp    801066d9 <alltraps>

80107603 <vector220>:
.globl vector220
vector220:
  pushl $0
80107603:	6a 00                	push   $0x0
  pushl $220
80107605:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010760a:	e9 ca f0 ff ff       	jmp    801066d9 <alltraps>

8010760f <vector221>:
.globl vector221
vector221:
  pushl $0
8010760f:	6a 00                	push   $0x0
  pushl $221
80107611:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107616:	e9 be f0 ff ff       	jmp    801066d9 <alltraps>

8010761b <vector222>:
.globl vector222
vector222:
  pushl $0
8010761b:	6a 00                	push   $0x0
  pushl $222
8010761d:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107622:	e9 b2 f0 ff ff       	jmp    801066d9 <alltraps>

80107627 <vector223>:
.globl vector223
vector223:
  pushl $0
80107627:	6a 00                	push   $0x0
  pushl $223
80107629:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
8010762e:	e9 a6 f0 ff ff       	jmp    801066d9 <alltraps>

80107633 <vector224>:
.globl vector224
vector224:
  pushl $0
80107633:	6a 00                	push   $0x0
  pushl $224
80107635:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010763a:	e9 9a f0 ff ff       	jmp    801066d9 <alltraps>

8010763f <vector225>:
.globl vector225
vector225:
  pushl $0
8010763f:	6a 00                	push   $0x0
  pushl $225
80107641:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107646:	e9 8e f0 ff ff       	jmp    801066d9 <alltraps>

8010764b <vector226>:
.globl vector226
vector226:
  pushl $0
8010764b:	6a 00                	push   $0x0
  pushl $226
8010764d:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107652:	e9 82 f0 ff ff       	jmp    801066d9 <alltraps>

80107657 <vector227>:
.globl vector227
vector227:
  pushl $0
80107657:	6a 00                	push   $0x0
  pushl $227
80107659:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
8010765e:	e9 76 f0 ff ff       	jmp    801066d9 <alltraps>

80107663 <vector228>:
.globl vector228
vector228:
  pushl $0
80107663:	6a 00                	push   $0x0
  pushl $228
80107665:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010766a:	e9 6a f0 ff ff       	jmp    801066d9 <alltraps>

8010766f <vector229>:
.globl vector229
vector229:
  pushl $0
8010766f:	6a 00                	push   $0x0
  pushl $229
80107671:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107676:	e9 5e f0 ff ff       	jmp    801066d9 <alltraps>

8010767b <vector230>:
.globl vector230
vector230:
  pushl $0
8010767b:	6a 00                	push   $0x0
  pushl $230
8010767d:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107682:	e9 52 f0 ff ff       	jmp    801066d9 <alltraps>

80107687 <vector231>:
.globl vector231
vector231:
  pushl $0
80107687:	6a 00                	push   $0x0
  pushl $231
80107689:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
8010768e:	e9 46 f0 ff ff       	jmp    801066d9 <alltraps>

80107693 <vector232>:
.globl vector232
vector232:
  pushl $0
80107693:	6a 00                	push   $0x0
  pushl $232
80107695:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010769a:	e9 3a f0 ff ff       	jmp    801066d9 <alltraps>

8010769f <vector233>:
.globl vector233
vector233:
  pushl $0
8010769f:	6a 00                	push   $0x0
  pushl $233
801076a1:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801076a6:	e9 2e f0 ff ff       	jmp    801066d9 <alltraps>

801076ab <vector234>:
.globl vector234
vector234:
  pushl $0
801076ab:	6a 00                	push   $0x0
  pushl $234
801076ad:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801076b2:	e9 22 f0 ff ff       	jmp    801066d9 <alltraps>

801076b7 <vector235>:
.globl vector235
vector235:
  pushl $0
801076b7:	6a 00                	push   $0x0
  pushl $235
801076b9:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801076be:	e9 16 f0 ff ff       	jmp    801066d9 <alltraps>

801076c3 <vector236>:
.globl vector236
vector236:
  pushl $0
801076c3:	6a 00                	push   $0x0
  pushl $236
801076c5:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801076ca:	e9 0a f0 ff ff       	jmp    801066d9 <alltraps>

801076cf <vector237>:
.globl vector237
vector237:
  pushl $0
801076cf:	6a 00                	push   $0x0
  pushl $237
801076d1:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801076d6:	e9 fe ef ff ff       	jmp    801066d9 <alltraps>

801076db <vector238>:
.globl vector238
vector238:
  pushl $0
801076db:	6a 00                	push   $0x0
  pushl $238
801076dd:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801076e2:	e9 f2 ef ff ff       	jmp    801066d9 <alltraps>

801076e7 <vector239>:
.globl vector239
vector239:
  pushl $0
801076e7:	6a 00                	push   $0x0
  pushl $239
801076e9:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801076ee:	e9 e6 ef ff ff       	jmp    801066d9 <alltraps>

801076f3 <vector240>:
.globl vector240
vector240:
  pushl $0
801076f3:	6a 00                	push   $0x0
  pushl $240
801076f5:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801076fa:	e9 da ef ff ff       	jmp    801066d9 <alltraps>

801076ff <vector241>:
.globl vector241
vector241:
  pushl $0
801076ff:	6a 00                	push   $0x0
  pushl $241
80107701:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107706:	e9 ce ef ff ff       	jmp    801066d9 <alltraps>

8010770b <vector242>:
.globl vector242
vector242:
  pushl $0
8010770b:	6a 00                	push   $0x0
  pushl $242
8010770d:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107712:	e9 c2 ef ff ff       	jmp    801066d9 <alltraps>

80107717 <vector243>:
.globl vector243
vector243:
  pushl $0
80107717:	6a 00                	push   $0x0
  pushl $243
80107719:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
8010771e:	e9 b6 ef ff ff       	jmp    801066d9 <alltraps>

80107723 <vector244>:
.globl vector244
vector244:
  pushl $0
80107723:	6a 00                	push   $0x0
  pushl $244
80107725:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010772a:	e9 aa ef ff ff       	jmp    801066d9 <alltraps>

8010772f <vector245>:
.globl vector245
vector245:
  pushl $0
8010772f:	6a 00                	push   $0x0
  pushl $245
80107731:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107736:	e9 9e ef ff ff       	jmp    801066d9 <alltraps>

8010773b <vector246>:
.globl vector246
vector246:
  pushl $0
8010773b:	6a 00                	push   $0x0
  pushl $246
8010773d:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107742:	e9 92 ef ff ff       	jmp    801066d9 <alltraps>

80107747 <vector247>:
.globl vector247
vector247:
  pushl $0
80107747:	6a 00                	push   $0x0
  pushl $247
80107749:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
8010774e:	e9 86 ef ff ff       	jmp    801066d9 <alltraps>

80107753 <vector248>:
.globl vector248
vector248:
  pushl $0
80107753:	6a 00                	push   $0x0
  pushl $248
80107755:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010775a:	e9 7a ef ff ff       	jmp    801066d9 <alltraps>

8010775f <vector249>:
.globl vector249
vector249:
  pushl $0
8010775f:	6a 00                	push   $0x0
  pushl $249
80107761:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107766:	e9 6e ef ff ff       	jmp    801066d9 <alltraps>

8010776b <vector250>:
.globl vector250
vector250:
  pushl $0
8010776b:	6a 00                	push   $0x0
  pushl $250
8010776d:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107772:	e9 62 ef ff ff       	jmp    801066d9 <alltraps>

80107777 <vector251>:
.globl vector251
vector251:
  pushl $0
80107777:	6a 00                	push   $0x0
  pushl $251
80107779:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
8010777e:	e9 56 ef ff ff       	jmp    801066d9 <alltraps>

80107783 <vector252>:
.globl vector252
vector252:
  pushl $0
80107783:	6a 00                	push   $0x0
  pushl $252
80107785:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010778a:	e9 4a ef ff ff       	jmp    801066d9 <alltraps>

8010778f <vector253>:
.globl vector253
vector253:
  pushl $0
8010778f:	6a 00                	push   $0x0
  pushl $253
80107791:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107796:	e9 3e ef ff ff       	jmp    801066d9 <alltraps>

8010779b <vector254>:
.globl vector254
vector254:
  pushl $0
8010779b:	6a 00                	push   $0x0
  pushl $254
8010779d:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801077a2:	e9 32 ef ff ff       	jmp    801066d9 <alltraps>

801077a7 <vector255>:
.globl vector255
vector255:
  pushl $0
801077a7:	6a 00                	push   $0x0
  pushl $255
801077a9:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801077ae:	e9 26 ef ff ff       	jmp    801066d9 <alltraps>

801077b3 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
801077b3:	55                   	push   %ebp
801077b4:	89 e5                	mov    %esp,%ebp
801077b6:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801077b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801077bc:	83 e8 01             	sub    $0x1,%eax
801077bf:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801077c3:	8b 45 08             	mov    0x8(%ebp),%eax
801077c6:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801077ca:	8b 45 08             	mov    0x8(%ebp),%eax
801077cd:	c1 e8 10             	shr    $0x10,%eax
801077d0:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801077d4:	8d 45 fa             	lea    -0x6(%ebp),%eax
801077d7:	0f 01 10             	lgdtl  (%eax)
}
801077da:	c9                   	leave  
801077db:	c3                   	ret    

801077dc <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
801077dc:	55                   	push   %ebp
801077dd:	89 e5                	mov    %esp,%ebp
801077df:	83 ec 04             	sub    $0x4,%esp
801077e2:	8b 45 08             	mov    0x8(%ebp),%eax
801077e5:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
801077e9:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801077ed:	0f 00 d8             	ltr    %ax
}
801077f0:	c9                   	leave  
801077f1:	c3                   	ret    

801077f2 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
801077f2:	55                   	push   %ebp
801077f3:	89 e5                	mov    %esp,%ebp
801077f5:	83 ec 04             	sub    $0x4,%esp
801077f8:	8b 45 08             	mov    0x8(%ebp),%eax
801077fb:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
801077ff:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107803:	8e e8                	mov    %eax,%gs
}
80107805:	c9                   	leave  
80107806:	c3                   	ret    

80107807 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107807:	55                   	push   %ebp
80107808:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010780a:	8b 45 08             	mov    0x8(%ebp),%eax
8010780d:	0f 22 d8             	mov    %eax,%cr3
}
80107810:	5d                   	pop    %ebp
80107811:	c3                   	ret    

80107812 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80107812:	55                   	push   %ebp
80107813:	89 e5                	mov    %esp,%ebp
80107815:	8b 45 08             	mov    0x8(%ebp),%eax
80107818:	05 00 00 00 80       	add    $0x80000000,%eax
8010781d:	5d                   	pop    %ebp
8010781e:	c3                   	ret    

8010781f <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
8010781f:	55                   	push   %ebp
80107820:	89 e5                	mov    %esp,%ebp
80107822:	8b 45 08             	mov    0x8(%ebp),%eax
80107825:	05 00 00 00 80       	add    $0x80000000,%eax
8010782a:	5d                   	pop    %ebp
8010782b:	c3                   	ret    

8010782c <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
8010782c:	55                   	push   %ebp
8010782d:	89 e5                	mov    %esp,%ebp
8010782f:	53                   	push   %ebx
80107830:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107833:	e8 d1 b6 ff ff       	call   80102f09 <cpunum>
80107838:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010783e:	05 40 24 11 80       	add    $0x80112440,%eax
80107843:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107846:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107849:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
8010784f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107852:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107858:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010785b:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
8010785f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107862:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107866:	83 e2 f0             	and    $0xfffffff0,%edx
80107869:	83 ca 0a             	or     $0xa,%edx
8010786c:	88 50 7d             	mov    %dl,0x7d(%eax)
8010786f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107872:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107876:	83 ca 10             	or     $0x10,%edx
80107879:	88 50 7d             	mov    %dl,0x7d(%eax)
8010787c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107883:	83 e2 9f             	and    $0xffffff9f,%edx
80107886:	88 50 7d             	mov    %dl,0x7d(%eax)
80107889:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010788c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107890:	83 ca 80             	or     $0xffffff80,%edx
80107893:	88 50 7d             	mov    %dl,0x7d(%eax)
80107896:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107899:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010789d:	83 ca 0f             	or     $0xf,%edx
801078a0:	88 50 7e             	mov    %dl,0x7e(%eax)
801078a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a6:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078aa:	83 e2 ef             	and    $0xffffffef,%edx
801078ad:	88 50 7e             	mov    %dl,0x7e(%eax)
801078b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b3:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078b7:	83 e2 df             	and    $0xffffffdf,%edx
801078ba:	88 50 7e             	mov    %dl,0x7e(%eax)
801078bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c0:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078c4:	83 ca 40             	or     $0x40,%edx
801078c7:	88 50 7e             	mov    %dl,0x7e(%eax)
801078ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078cd:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078d1:	83 ca 80             	or     $0xffffff80,%edx
801078d4:	88 50 7e             	mov    %dl,0x7e(%eax)
801078d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078da:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801078de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e1:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801078e8:	ff ff 
801078ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ed:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801078f4:	00 00 
801078f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f9:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107903:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010790a:	83 e2 f0             	and    $0xfffffff0,%edx
8010790d:	83 ca 02             	or     $0x2,%edx
80107910:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107919:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107920:	83 ca 10             	or     $0x10,%edx
80107923:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107929:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792c:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107933:	83 e2 9f             	and    $0xffffff9f,%edx
80107936:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010793c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793f:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107946:	83 ca 80             	or     $0xffffff80,%edx
80107949:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010794f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107952:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107959:	83 ca 0f             	or     $0xf,%edx
8010795c:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107962:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107965:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010796c:	83 e2 ef             	and    $0xffffffef,%edx
8010796f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107975:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107978:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010797f:	83 e2 df             	and    $0xffffffdf,%edx
80107982:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107988:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107992:	83 ca 40             	or     $0x40,%edx
80107995:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010799b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010799e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079a5:	83 ca 80             	or     $0xffffff80,%edx
801079a8:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801079ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b1:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801079b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079bb:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
801079c2:	ff ff 
801079c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c7:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
801079ce:	00 00 
801079d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d3:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
801079da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079dd:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079e4:	83 e2 f0             	and    $0xfffffff0,%edx
801079e7:	83 ca 0a             	or     $0xa,%edx
801079ea:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f3:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079fa:	83 ca 10             	or     $0x10,%edx
801079fd:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a06:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a0d:	83 ca 60             	or     $0x60,%edx
80107a10:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a19:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a20:	83 ca 80             	or     $0xffffff80,%edx
80107a23:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a2c:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a33:	83 ca 0f             	or     $0xf,%edx
80107a36:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a3f:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a46:	83 e2 ef             	and    $0xffffffef,%edx
80107a49:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a52:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a59:	83 e2 df             	and    $0xffffffdf,%edx
80107a5c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a65:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a6c:	83 ca 40             	or     $0x40,%edx
80107a6f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a78:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a7f:	83 ca 80             	or     $0xffffff80,%edx
80107a82:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a8b:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a95:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107a9c:	ff ff 
80107a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa1:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107aa8:	00 00 
80107aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aad:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab7:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107abe:	83 e2 f0             	and    $0xfffffff0,%edx
80107ac1:	83 ca 02             	or     $0x2,%edx
80107ac4:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107acd:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107ad4:	83 ca 10             	or     $0x10,%edx
80107ad7:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107add:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae0:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107ae7:	83 ca 60             	or     $0x60,%edx
80107aea:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107af0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af3:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107afa:	83 ca 80             	or     $0xffffff80,%edx
80107afd:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b06:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b0d:	83 ca 0f             	or     $0xf,%edx
80107b10:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b19:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b20:	83 e2 ef             	and    $0xffffffef,%edx
80107b23:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b2c:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b33:	83 e2 df             	and    $0xffffffdf,%edx
80107b36:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b3f:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b46:	83 ca 40             	or     $0x40,%edx
80107b49:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b52:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b59:	83 ca 80             	or     $0xffffff80,%edx
80107b5c:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b65:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6f:	05 b4 00 00 00       	add    $0xb4,%eax
80107b74:	89 c3                	mov    %eax,%ebx
80107b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b79:	05 b4 00 00 00       	add    $0xb4,%eax
80107b7e:	c1 e8 10             	shr    $0x10,%eax
80107b81:	89 c2                	mov    %eax,%edx
80107b83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b86:	05 b4 00 00 00       	add    $0xb4,%eax
80107b8b:	c1 e8 18             	shr    $0x18,%eax
80107b8e:	89 c1                	mov    %eax,%ecx
80107b90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b93:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107b9a:	00 00 
80107b9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b9f:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba9:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb2:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bb9:	83 e2 f0             	and    $0xfffffff0,%edx
80107bbc:	83 ca 02             	or     $0x2,%edx
80107bbf:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc8:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bcf:	83 ca 10             	or     $0x10,%edx
80107bd2:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bdb:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107be2:	83 e2 9f             	and    $0xffffff9f,%edx
80107be5:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bee:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bf5:	83 ca 80             	or     $0xffffff80,%edx
80107bf8:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c01:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c08:	83 e2 f0             	and    $0xfffffff0,%edx
80107c0b:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c14:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c1b:	83 e2 ef             	and    $0xffffffef,%edx
80107c1e:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c27:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c2e:	83 e2 df             	and    $0xffffffdf,%edx
80107c31:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c3a:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c41:	83 ca 40             	or     $0x40,%edx
80107c44:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4d:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c54:	83 ca 80             	or     $0xffffff80,%edx
80107c57:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c60:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107c66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c69:	83 c0 70             	add    $0x70,%eax
80107c6c:	83 ec 08             	sub    $0x8,%esp
80107c6f:	6a 38                	push   $0x38
80107c71:	50                   	push   %eax
80107c72:	e8 3c fb ff ff       	call   801077b3 <lgdt>
80107c77:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107c7a:	83 ec 0c             	sub    $0xc,%esp
80107c7d:	6a 18                	push   $0x18
80107c7f:	e8 6e fb ff ff       	call   801077f2 <loadgs>
80107c84:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8a:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107c90:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107c97:	00 00 00 00 
}
80107c9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107c9e:	c9                   	leave  
80107c9f:	c3                   	ret    

80107ca0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107ca0:	55                   	push   %ebp
80107ca1:	89 e5                	mov    %esp,%ebp
80107ca3:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ca9:	c1 e8 16             	shr    $0x16,%eax
80107cac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107cb3:	8b 45 08             	mov    0x8(%ebp),%eax
80107cb6:	01 d0                	add    %edx,%eax
80107cb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cbe:	8b 00                	mov    (%eax),%eax
80107cc0:	83 e0 01             	and    $0x1,%eax
80107cc3:	85 c0                	test   %eax,%eax
80107cc5:	74 18                	je     80107cdf <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107cc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cca:	8b 00                	mov    (%eax),%eax
80107ccc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cd1:	50                   	push   %eax
80107cd2:	e8 48 fb ff ff       	call   8010781f <p2v>
80107cd7:	83 c4 04             	add    $0x4,%esp
80107cda:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107cdd:	eb 48                	jmp    80107d27 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107cdf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107ce3:	74 0e                	je     80107cf3 <walkpgdir+0x53>
80107ce5:	e8 be ae ff ff       	call   80102ba8 <kalloc>
80107cea:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107ced:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107cf1:	75 07                	jne    80107cfa <walkpgdir+0x5a>
      return 0;
80107cf3:	b8 00 00 00 00       	mov    $0x0,%eax
80107cf8:	eb 44                	jmp    80107d3e <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107cfa:	83 ec 04             	sub    $0x4,%esp
80107cfd:	68 00 10 00 00       	push   $0x1000
80107d02:	6a 00                	push   $0x0
80107d04:	ff 75 f4             	pushl  -0xc(%ebp)
80107d07:	e8 6e d5 ff ff       	call   8010527a <memset>
80107d0c:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107d0f:	83 ec 0c             	sub    $0xc,%esp
80107d12:	ff 75 f4             	pushl  -0xc(%ebp)
80107d15:	e8 f8 fa ff ff       	call   80107812 <v2p>
80107d1a:	83 c4 10             	add    $0x10,%esp
80107d1d:	83 c8 07             	or     $0x7,%eax
80107d20:	89 c2                	mov    %eax,%edx
80107d22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d25:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107d27:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d2a:	c1 e8 0c             	shr    $0xc,%eax
80107d2d:	25 ff 03 00 00       	and    $0x3ff,%eax
80107d32:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107d39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d3c:	01 d0                	add    %edx,%eax
}
80107d3e:	c9                   	leave  
80107d3f:	c3                   	ret    

80107d40 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d40:	55                   	push   %ebp
80107d41:	89 e5                	mov    %esp,%ebp
80107d43:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107d46:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d49:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107d51:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d54:	8b 45 10             	mov    0x10(%ebp),%eax
80107d57:	01 d0                	add    %edx,%eax
80107d59:	83 e8 01             	sub    $0x1,%eax
80107d5c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d61:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107d64:	83 ec 04             	sub    $0x4,%esp
80107d67:	6a 01                	push   $0x1
80107d69:	ff 75 f4             	pushl  -0xc(%ebp)
80107d6c:	ff 75 08             	pushl  0x8(%ebp)
80107d6f:	e8 2c ff ff ff       	call   80107ca0 <walkpgdir>
80107d74:	83 c4 10             	add    $0x10,%esp
80107d77:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107d7a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107d7e:	75 07                	jne    80107d87 <mappages+0x47>
      return -1;
80107d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d85:	eb 49                	jmp    80107dd0 <mappages+0x90>
    if(*pte & PTE_P)
80107d87:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d8a:	8b 00                	mov    (%eax),%eax
80107d8c:	83 e0 01             	and    $0x1,%eax
80107d8f:	85 c0                	test   %eax,%eax
80107d91:	74 0d                	je     80107da0 <mappages+0x60>
      panic("remap");
80107d93:	83 ec 0c             	sub    $0xc,%esp
80107d96:	68 84 8b 10 80       	push   $0x80108b84
80107d9b:	e8 bc 87 ff ff       	call   8010055c <panic>
    *pte = pa | perm | PTE_P;
80107da0:	8b 45 18             	mov    0x18(%ebp),%eax
80107da3:	0b 45 14             	or     0x14(%ebp),%eax
80107da6:	83 c8 01             	or     $0x1,%eax
80107da9:	89 c2                	mov    %eax,%edx
80107dab:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107dae:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107db3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107db6:	75 08                	jne    80107dc0 <mappages+0x80>
      break;
80107db8:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107db9:	b8 00 00 00 00       	mov    $0x0,%eax
80107dbe:	eb 10                	jmp    80107dd0 <mappages+0x90>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
80107dc0:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107dc7:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107dce:	eb 94                	jmp    80107d64 <mappages+0x24>
  return 0;
}
80107dd0:	c9                   	leave  
80107dd1:	c3                   	ret    

80107dd2 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107dd2:	55                   	push   %ebp
80107dd3:	89 e5                	mov    %esp,%ebp
80107dd5:	53                   	push   %ebx
80107dd6:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107dd9:	e8 ca ad ff ff       	call   80102ba8 <kalloc>
80107dde:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107de1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107de5:	75 0a                	jne    80107df1 <setupkvm+0x1f>
    return 0;
80107de7:	b8 00 00 00 00       	mov    $0x0,%eax
80107dec:	e9 8e 00 00 00       	jmp    80107e7f <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107df1:	83 ec 04             	sub    $0x4,%esp
80107df4:	68 00 10 00 00       	push   $0x1000
80107df9:	6a 00                	push   $0x0
80107dfb:	ff 75 f0             	pushl  -0x10(%ebp)
80107dfe:	e8 77 d4 ff ff       	call   8010527a <memset>
80107e03:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107e06:	83 ec 0c             	sub    $0xc,%esp
80107e09:	68 00 00 00 0e       	push   $0xe000000
80107e0e:	e8 0c fa ff ff       	call   8010781f <p2v>
80107e13:	83 c4 10             	add    $0x10,%esp
80107e16:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107e1b:	76 0d                	jbe    80107e2a <setupkvm+0x58>
    panic("PHYSTOP too high");
80107e1d:	83 ec 0c             	sub    $0xc,%esp
80107e20:	68 8a 8b 10 80       	push   $0x80108b8a
80107e25:	e8 32 87 ff ff       	call   8010055c <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107e2a:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
80107e31:	eb 40                	jmp    80107e73 <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107e33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e36:	8b 48 0c             	mov    0xc(%eax),%ecx
80107e39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3c:	8b 50 04             	mov    0x4(%eax),%edx
80107e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e42:	8b 58 08             	mov    0x8(%eax),%ebx
80107e45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e48:	8b 40 04             	mov    0x4(%eax),%eax
80107e4b:	29 c3                	sub    %eax,%ebx
80107e4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e50:	8b 00                	mov    (%eax),%eax
80107e52:	83 ec 0c             	sub    $0xc,%esp
80107e55:	51                   	push   %ecx
80107e56:	52                   	push   %edx
80107e57:	53                   	push   %ebx
80107e58:	50                   	push   %eax
80107e59:	ff 75 f0             	pushl  -0x10(%ebp)
80107e5c:	e8 df fe ff ff       	call   80107d40 <mappages>
80107e61:	83 c4 20             	add    $0x20,%esp
80107e64:	85 c0                	test   %eax,%eax
80107e66:	79 07                	jns    80107e6f <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107e68:	b8 00 00 00 00       	mov    $0x0,%eax
80107e6d:	eb 10                	jmp    80107e7f <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107e6f:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107e73:	81 7d f4 00 b5 10 80 	cmpl   $0x8010b500,-0xc(%ebp)
80107e7a:	72 b7                	jb     80107e33 <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107e7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107e7f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107e82:	c9                   	leave  
80107e83:	c3                   	ret    

80107e84 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107e84:	55                   	push   %ebp
80107e85:	89 e5                	mov    %esp,%ebp
80107e87:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107e8a:	e8 43 ff ff ff       	call   80107dd2 <setupkvm>
80107e8f:	a3 18 53 11 80       	mov    %eax,0x80115318
  switchkvm();
80107e94:	e8 02 00 00 00       	call   80107e9b <switchkvm>
}
80107e99:	c9                   	leave  
80107e9a:	c3                   	ret    

80107e9b <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107e9b:	55                   	push   %ebp
80107e9c:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107e9e:	a1 18 53 11 80       	mov    0x80115318,%eax
80107ea3:	50                   	push   %eax
80107ea4:	e8 69 f9 ff ff       	call   80107812 <v2p>
80107ea9:	83 c4 04             	add    $0x4,%esp
80107eac:	50                   	push   %eax
80107ead:	e8 55 f9 ff ff       	call   80107807 <lcr3>
80107eb2:	83 c4 04             	add    $0x4,%esp
}
80107eb5:	c9                   	leave  
80107eb6:	c3                   	ret    

80107eb7 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107eb7:	55                   	push   %ebp
80107eb8:	89 e5                	mov    %esp,%ebp
80107eba:	56                   	push   %esi
80107ebb:	53                   	push   %ebx
  pushcli();
80107ebc:	e8 b7 d2 ff ff       	call   80105178 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107ec1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107ec7:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ece:	83 c2 08             	add    $0x8,%edx
80107ed1:	89 d6                	mov    %edx,%esi
80107ed3:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107eda:	83 c2 08             	add    $0x8,%edx
80107edd:	c1 ea 10             	shr    $0x10,%edx
80107ee0:	89 d3                	mov    %edx,%ebx
80107ee2:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ee9:	83 c2 08             	add    $0x8,%edx
80107eec:	c1 ea 18             	shr    $0x18,%edx
80107eef:	89 d1                	mov    %edx,%ecx
80107ef1:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107ef8:	67 00 
80107efa:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107f01:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107f07:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f0e:	83 e2 f0             	and    $0xfffffff0,%edx
80107f11:	83 ca 09             	or     $0x9,%edx
80107f14:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f1a:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f21:	83 ca 10             	or     $0x10,%edx
80107f24:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f2a:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f31:	83 e2 9f             	and    $0xffffff9f,%edx
80107f34:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f3a:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f41:	83 ca 80             	or     $0xffffff80,%edx
80107f44:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f4a:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f51:	83 e2 f0             	and    $0xfffffff0,%edx
80107f54:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f5a:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f61:	83 e2 ef             	and    $0xffffffef,%edx
80107f64:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f6a:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f71:	83 e2 df             	and    $0xffffffdf,%edx
80107f74:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f7a:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f81:	83 ca 40             	or     $0x40,%edx
80107f84:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f8a:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f91:	83 e2 7f             	and    $0x7f,%edx
80107f94:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f9a:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107fa0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fa6:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107fad:	83 e2 ef             	and    $0xffffffef,%edx
80107fb0:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107fb6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fbc:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107fc2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fc8:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107fcf:	8b 52 08             	mov    0x8(%edx),%edx
80107fd2:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107fd8:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107fdb:	83 ec 0c             	sub    $0xc,%esp
80107fde:	6a 30                	push   $0x30
80107fe0:	e8 f7 f7 ff ff       	call   801077dc <ltr>
80107fe5:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107fe8:	8b 45 08             	mov    0x8(%ebp),%eax
80107feb:	8b 40 04             	mov    0x4(%eax),%eax
80107fee:	85 c0                	test   %eax,%eax
80107ff0:	75 0d                	jne    80107fff <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107ff2:	83 ec 0c             	sub    $0xc,%esp
80107ff5:	68 9b 8b 10 80       	push   $0x80108b9b
80107ffa:	e8 5d 85 ff ff       	call   8010055c <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107fff:	8b 45 08             	mov    0x8(%ebp),%eax
80108002:	8b 40 04             	mov    0x4(%eax),%eax
80108005:	83 ec 0c             	sub    $0xc,%esp
80108008:	50                   	push   %eax
80108009:	e8 04 f8 ff ff       	call   80107812 <v2p>
8010800e:	83 c4 10             	add    $0x10,%esp
80108011:	83 ec 0c             	sub    $0xc,%esp
80108014:	50                   	push   %eax
80108015:	e8 ed f7 ff ff       	call   80107807 <lcr3>
8010801a:	83 c4 10             	add    $0x10,%esp
  popcli();
8010801d:	e8 9a d1 ff ff       	call   801051bc <popcli>
}
80108022:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108025:	5b                   	pop    %ebx
80108026:	5e                   	pop    %esi
80108027:	5d                   	pop    %ebp
80108028:	c3                   	ret    

80108029 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108029:	55                   	push   %ebp
8010802a:	89 e5                	mov    %esp,%ebp
8010802c:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
8010802f:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108036:	76 0d                	jbe    80108045 <inituvm+0x1c>
    panic("inituvm: more than a page");
80108038:	83 ec 0c             	sub    $0xc,%esp
8010803b:	68 af 8b 10 80       	push   $0x80108baf
80108040:	e8 17 85 ff ff       	call   8010055c <panic>
  mem = kalloc();
80108045:	e8 5e ab ff ff       	call   80102ba8 <kalloc>
8010804a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
8010804d:	83 ec 04             	sub    $0x4,%esp
80108050:	68 00 10 00 00       	push   $0x1000
80108055:	6a 00                	push   $0x0
80108057:	ff 75 f4             	pushl  -0xc(%ebp)
8010805a:	e8 1b d2 ff ff       	call   8010527a <memset>
8010805f:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108062:	83 ec 0c             	sub    $0xc,%esp
80108065:	ff 75 f4             	pushl  -0xc(%ebp)
80108068:	e8 a5 f7 ff ff       	call   80107812 <v2p>
8010806d:	83 c4 10             	add    $0x10,%esp
80108070:	83 ec 0c             	sub    $0xc,%esp
80108073:	6a 06                	push   $0x6
80108075:	50                   	push   %eax
80108076:	68 00 10 00 00       	push   $0x1000
8010807b:	6a 00                	push   $0x0
8010807d:	ff 75 08             	pushl  0x8(%ebp)
80108080:	e8 bb fc ff ff       	call   80107d40 <mappages>
80108085:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80108088:	83 ec 04             	sub    $0x4,%esp
8010808b:	ff 75 10             	pushl  0x10(%ebp)
8010808e:	ff 75 0c             	pushl  0xc(%ebp)
80108091:	ff 75 f4             	pushl  -0xc(%ebp)
80108094:	e8 a0 d2 ff ff       	call   80105339 <memmove>
80108099:	83 c4 10             	add    $0x10,%esp
}
8010809c:	c9                   	leave  
8010809d:	c3                   	ret    

8010809e <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
8010809e:	55                   	push   %ebp
8010809f:	89 e5                	mov    %esp,%ebp
801080a1:	53                   	push   %ebx
801080a2:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801080a5:	8b 45 0c             	mov    0xc(%ebp),%eax
801080a8:	25 ff 0f 00 00       	and    $0xfff,%eax
801080ad:	85 c0                	test   %eax,%eax
801080af:	74 0d                	je     801080be <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
801080b1:	83 ec 0c             	sub    $0xc,%esp
801080b4:	68 cc 8b 10 80       	push   $0x80108bcc
801080b9:	e8 9e 84 ff ff       	call   8010055c <panic>
  for(i = 0; i < sz; i += PGSIZE){
801080be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801080c5:	e9 95 00 00 00       	jmp    8010815f <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801080ca:	8b 55 0c             	mov    0xc(%ebp),%edx
801080cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080d0:	01 d0                	add    %edx,%eax
801080d2:	83 ec 04             	sub    $0x4,%esp
801080d5:	6a 00                	push   $0x0
801080d7:	50                   	push   %eax
801080d8:	ff 75 08             	pushl  0x8(%ebp)
801080db:	e8 c0 fb ff ff       	call   80107ca0 <walkpgdir>
801080e0:	83 c4 10             	add    $0x10,%esp
801080e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
801080e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801080ea:	75 0d                	jne    801080f9 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
801080ec:	83 ec 0c             	sub    $0xc,%esp
801080ef:	68 ef 8b 10 80       	push   $0x80108bef
801080f4:	e8 63 84 ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
801080f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080fc:	8b 00                	mov    (%eax),%eax
801080fe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108103:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108106:	8b 45 18             	mov    0x18(%ebp),%eax
80108109:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010810c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80108111:	77 0b                	ja     8010811e <loaduvm+0x80>
      n = sz - i;
80108113:	8b 45 18             	mov    0x18(%ebp),%eax
80108116:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108119:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010811c:	eb 07                	jmp    80108125 <loaduvm+0x87>
    else
      n = PGSIZE;
8010811e:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80108125:	8b 55 14             	mov    0x14(%ebp),%edx
80108128:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010812b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010812e:	83 ec 0c             	sub    $0xc,%esp
80108131:	ff 75 e8             	pushl  -0x18(%ebp)
80108134:	e8 e6 f6 ff ff       	call   8010781f <p2v>
80108139:	83 c4 10             	add    $0x10,%esp
8010813c:	ff 75 f0             	pushl  -0x10(%ebp)
8010813f:	53                   	push   %ebx
80108140:	50                   	push   %eax
80108141:	ff 75 10             	pushl  0x10(%ebp)
80108144:	e8 18 9d ff ff       	call   80101e61 <readi>
80108149:	83 c4 10             	add    $0x10,%esp
8010814c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010814f:	74 07                	je     80108158 <loaduvm+0xba>
      return -1;
80108151:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108156:	eb 18                	jmp    80108170 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80108158:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010815f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108162:	3b 45 18             	cmp    0x18(%ebp),%eax
80108165:	0f 82 5f ff ff ff    	jb     801080ca <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010816b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108170:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108173:	c9                   	leave  
80108174:	c3                   	ret    

80108175 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108175:	55                   	push   %ebp
80108176:	89 e5                	mov    %esp,%ebp
80108178:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010817b:	8b 45 10             	mov    0x10(%ebp),%eax
8010817e:	85 c0                	test   %eax,%eax
80108180:	79 0a                	jns    8010818c <allocuvm+0x17>
    return 0;
80108182:	b8 00 00 00 00       	mov    $0x0,%eax
80108187:	e9 b0 00 00 00       	jmp    8010823c <allocuvm+0xc7>
  if(newsz < oldsz)
8010818c:	8b 45 10             	mov    0x10(%ebp),%eax
8010818f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108192:	73 08                	jae    8010819c <allocuvm+0x27>
    return oldsz;
80108194:	8b 45 0c             	mov    0xc(%ebp),%eax
80108197:	e9 a0 00 00 00       	jmp    8010823c <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
8010819c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010819f:	05 ff 0f 00 00       	add    $0xfff,%eax
801081a4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801081ac:	eb 7f                	jmp    8010822d <allocuvm+0xb8>
    mem = kalloc();
801081ae:	e8 f5 a9 ff ff       	call   80102ba8 <kalloc>
801081b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
801081b6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801081ba:	75 2b                	jne    801081e7 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
801081bc:	83 ec 0c             	sub    $0xc,%esp
801081bf:	68 0d 8c 10 80       	push   $0x80108c0d
801081c4:	e8 f6 81 ff ff       	call   801003bf <cprintf>
801081c9:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
801081cc:	83 ec 04             	sub    $0x4,%esp
801081cf:	ff 75 0c             	pushl  0xc(%ebp)
801081d2:	ff 75 10             	pushl  0x10(%ebp)
801081d5:	ff 75 08             	pushl  0x8(%ebp)
801081d8:	e8 61 00 00 00       	call   8010823e <deallocuvm>
801081dd:	83 c4 10             	add    $0x10,%esp
      return 0;
801081e0:	b8 00 00 00 00       	mov    $0x0,%eax
801081e5:	eb 55                	jmp    8010823c <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
801081e7:	83 ec 04             	sub    $0x4,%esp
801081ea:	68 00 10 00 00       	push   $0x1000
801081ef:	6a 00                	push   $0x0
801081f1:	ff 75 f0             	pushl  -0x10(%ebp)
801081f4:	e8 81 d0 ff ff       	call   8010527a <memset>
801081f9:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
801081fc:	83 ec 0c             	sub    $0xc,%esp
801081ff:	ff 75 f0             	pushl  -0x10(%ebp)
80108202:	e8 0b f6 ff ff       	call   80107812 <v2p>
80108207:	83 c4 10             	add    $0x10,%esp
8010820a:	89 c2                	mov    %eax,%edx
8010820c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010820f:	83 ec 0c             	sub    $0xc,%esp
80108212:	6a 06                	push   $0x6
80108214:	52                   	push   %edx
80108215:	68 00 10 00 00       	push   $0x1000
8010821a:	50                   	push   %eax
8010821b:	ff 75 08             	pushl  0x8(%ebp)
8010821e:	e8 1d fb ff ff       	call   80107d40 <mappages>
80108223:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108226:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010822d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108230:	3b 45 10             	cmp    0x10(%ebp),%eax
80108233:	0f 82 75 ff ff ff    	jb     801081ae <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80108239:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010823c:	c9                   	leave  
8010823d:	c3                   	ret    

8010823e <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010823e:	55                   	push   %ebp
8010823f:	89 e5                	mov    %esp,%ebp
80108241:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108244:	8b 45 10             	mov    0x10(%ebp),%eax
80108247:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010824a:	72 08                	jb     80108254 <deallocuvm+0x16>
    return oldsz;
8010824c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010824f:	e9 a5 00 00 00       	jmp    801082f9 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80108254:	8b 45 10             	mov    0x10(%ebp),%eax
80108257:	05 ff 0f 00 00       	add    $0xfff,%eax
8010825c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108261:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108264:	e9 81 00 00 00       	jmp    801082ea <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108269:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010826c:	83 ec 04             	sub    $0x4,%esp
8010826f:	6a 00                	push   $0x0
80108271:	50                   	push   %eax
80108272:	ff 75 08             	pushl  0x8(%ebp)
80108275:	e8 26 fa ff ff       	call   80107ca0 <walkpgdir>
8010827a:	83 c4 10             	add    $0x10,%esp
8010827d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80108280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108284:	75 09                	jne    8010828f <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80108286:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
8010828d:	eb 54                	jmp    801082e3 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
8010828f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108292:	8b 00                	mov    (%eax),%eax
80108294:	83 e0 01             	and    $0x1,%eax
80108297:	85 c0                	test   %eax,%eax
80108299:	74 48                	je     801082e3 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
8010829b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010829e:	8b 00                	mov    (%eax),%eax
801082a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801082a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801082ac:	75 0d                	jne    801082bb <deallocuvm+0x7d>
        panic("kfree");
801082ae:	83 ec 0c             	sub    $0xc,%esp
801082b1:	68 25 8c 10 80       	push   $0x80108c25
801082b6:	e8 a1 82 ff ff       	call   8010055c <panic>
      char *v = p2v(pa);
801082bb:	83 ec 0c             	sub    $0xc,%esp
801082be:	ff 75 ec             	pushl  -0x14(%ebp)
801082c1:	e8 59 f5 ff ff       	call   8010781f <p2v>
801082c6:	83 c4 10             	add    $0x10,%esp
801082c9:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801082cc:	83 ec 0c             	sub    $0xc,%esp
801082cf:	ff 75 e8             	pushl  -0x18(%ebp)
801082d2:	e8 35 a8 ff ff       	call   80102b0c <kfree>
801082d7:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801082da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801082e3:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801082ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082ed:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082f0:	0f 82 73 ff ff ff    	jb     80108269 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801082f6:	8b 45 10             	mov    0x10(%ebp),%eax
}
801082f9:	c9                   	leave  
801082fa:	c3                   	ret    

801082fb <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801082fb:	55                   	push   %ebp
801082fc:	89 e5                	mov    %esp,%ebp
801082fe:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80108301:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108305:	75 0d                	jne    80108314 <freevm+0x19>
    panic("freevm: no pgdir");
80108307:	83 ec 0c             	sub    $0xc,%esp
8010830a:	68 2b 8c 10 80       	push   $0x80108c2b
8010830f:	e8 48 82 ff ff       	call   8010055c <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108314:	83 ec 04             	sub    $0x4,%esp
80108317:	6a 00                	push   $0x0
80108319:	68 00 00 00 80       	push   $0x80000000
8010831e:	ff 75 08             	pushl  0x8(%ebp)
80108321:	e8 18 ff ff ff       	call   8010823e <deallocuvm>
80108326:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108329:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108330:	eb 4f                	jmp    80108381 <freevm+0x86>
    if(pgdir[i] & PTE_P){
80108332:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108335:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010833c:	8b 45 08             	mov    0x8(%ebp),%eax
8010833f:	01 d0                	add    %edx,%eax
80108341:	8b 00                	mov    (%eax),%eax
80108343:	83 e0 01             	and    $0x1,%eax
80108346:	85 c0                	test   %eax,%eax
80108348:	74 33                	je     8010837d <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
8010834a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010834d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108354:	8b 45 08             	mov    0x8(%ebp),%eax
80108357:	01 d0                	add    %edx,%eax
80108359:	8b 00                	mov    (%eax),%eax
8010835b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108360:	83 ec 0c             	sub    $0xc,%esp
80108363:	50                   	push   %eax
80108364:	e8 b6 f4 ff ff       	call   8010781f <p2v>
80108369:	83 c4 10             	add    $0x10,%esp
8010836c:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010836f:	83 ec 0c             	sub    $0xc,%esp
80108372:	ff 75 f0             	pushl  -0x10(%ebp)
80108375:	e8 92 a7 ff ff       	call   80102b0c <kfree>
8010837a:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010837d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108381:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108388:	76 a8                	jbe    80108332 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010838a:	83 ec 0c             	sub    $0xc,%esp
8010838d:	ff 75 08             	pushl  0x8(%ebp)
80108390:	e8 77 a7 ff ff       	call   80102b0c <kfree>
80108395:	83 c4 10             	add    $0x10,%esp
}
80108398:	c9                   	leave  
80108399:	c3                   	ret    

8010839a <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010839a:	55                   	push   %ebp
8010839b:	89 e5                	mov    %esp,%ebp
8010839d:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801083a0:	83 ec 04             	sub    $0x4,%esp
801083a3:	6a 00                	push   $0x0
801083a5:	ff 75 0c             	pushl  0xc(%ebp)
801083a8:	ff 75 08             	pushl  0x8(%ebp)
801083ab:	e8 f0 f8 ff ff       	call   80107ca0 <walkpgdir>
801083b0:	83 c4 10             	add    $0x10,%esp
801083b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801083b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801083ba:	75 0d                	jne    801083c9 <clearpteu+0x2f>
    panic("clearpteu");
801083bc:	83 ec 0c             	sub    $0xc,%esp
801083bf:	68 3c 8c 10 80       	push   $0x80108c3c
801083c4:	e8 93 81 ff ff       	call   8010055c <panic>
  *pte &= ~PTE_U;
801083c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083cc:	8b 00                	mov    (%eax),%eax
801083ce:	83 e0 fb             	and    $0xfffffffb,%eax
801083d1:	89 c2                	mov    %eax,%edx
801083d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083d6:	89 10                	mov    %edx,(%eax)
}
801083d8:	c9                   	leave  
801083d9:	c3                   	ret    

801083da <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801083da:	55                   	push   %ebp
801083db:	89 e5                	mov    %esp,%ebp
801083dd:	53                   	push   %ebx
801083de:	83 ec 24             	sub    $0x24,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801083e1:	e8 ec f9 ff ff       	call   80107dd2 <setupkvm>
801083e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801083e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801083ed:	75 0a                	jne    801083f9 <copyuvm+0x1f>
    return 0;
801083ef:	b8 00 00 00 00       	mov    $0x0,%eax
801083f4:	e9 f8 00 00 00       	jmp    801084f1 <copyuvm+0x117>
  for(i = 0; i < sz; i += PGSIZE){
801083f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108400:	e9 c8 00 00 00       	jmp    801084cd <copyuvm+0xf3>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108405:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108408:	83 ec 04             	sub    $0x4,%esp
8010840b:	6a 00                	push   $0x0
8010840d:	50                   	push   %eax
8010840e:	ff 75 08             	pushl  0x8(%ebp)
80108411:	e8 8a f8 ff ff       	call   80107ca0 <walkpgdir>
80108416:	83 c4 10             	add    $0x10,%esp
80108419:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010841c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108420:	75 0d                	jne    8010842f <copyuvm+0x55>
      panic("copyuvm: pte should exist");
80108422:	83 ec 0c             	sub    $0xc,%esp
80108425:	68 46 8c 10 80       	push   $0x80108c46
8010842a:	e8 2d 81 ff ff       	call   8010055c <panic>
    if(!(*pte & PTE_P))
8010842f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108432:	8b 00                	mov    (%eax),%eax
80108434:	83 e0 01             	and    $0x1,%eax
80108437:	85 c0                	test   %eax,%eax
80108439:	75 0d                	jne    80108448 <copyuvm+0x6e>
      panic("copyuvm: page not present");
8010843b:	83 ec 0c             	sub    $0xc,%esp
8010843e:	68 60 8c 10 80       	push   $0x80108c60
80108443:	e8 14 81 ff ff       	call   8010055c <panic>
    pa = PTE_ADDR(*pte);
80108448:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010844b:	8b 00                	mov    (%eax),%eax
8010844d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108452:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80108455:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108458:	8b 00                	mov    (%eax),%eax
8010845a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010845f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80108462:	e8 41 a7 ff ff       	call   80102ba8 <kalloc>
80108467:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010846a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010846e:	75 02                	jne    80108472 <copyuvm+0x98>
      goto bad;
80108470:	eb 6c                	jmp    801084de <copyuvm+0x104>
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108472:	83 ec 0c             	sub    $0xc,%esp
80108475:	ff 75 e8             	pushl  -0x18(%ebp)
80108478:	e8 a2 f3 ff ff       	call   8010781f <p2v>
8010847d:	83 c4 10             	add    $0x10,%esp
80108480:	83 ec 04             	sub    $0x4,%esp
80108483:	68 00 10 00 00       	push   $0x1000
80108488:	50                   	push   %eax
80108489:	ff 75 e0             	pushl  -0x20(%ebp)
8010848c:	e8 a8 ce ff ff       	call   80105339 <memmove>
80108491:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
80108494:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80108497:	83 ec 0c             	sub    $0xc,%esp
8010849a:	ff 75 e0             	pushl  -0x20(%ebp)
8010849d:	e8 70 f3 ff ff       	call   80107812 <v2p>
801084a2:	83 c4 10             	add    $0x10,%esp
801084a5:	89 c2                	mov    %eax,%edx
801084a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084aa:	83 ec 0c             	sub    $0xc,%esp
801084ad:	53                   	push   %ebx
801084ae:	52                   	push   %edx
801084af:	68 00 10 00 00       	push   $0x1000
801084b4:	50                   	push   %eax
801084b5:	ff 75 f0             	pushl  -0x10(%ebp)
801084b8:	e8 83 f8 ff ff       	call   80107d40 <mappages>
801084bd:	83 c4 20             	add    $0x20,%esp
801084c0:	85 c0                	test   %eax,%eax
801084c2:	79 02                	jns    801084c6 <copyuvm+0xec>
      goto bad;
801084c4:	eb 18                	jmp    801084de <copyuvm+0x104>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801084c6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801084cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084d0:	3b 45 0c             	cmp    0xc(%ebp),%eax
801084d3:	0f 82 2c ff ff ff    	jb     80108405 <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
801084d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084dc:	eb 13                	jmp    801084f1 <copyuvm+0x117>

bad:
  freevm(d);
801084de:	83 ec 0c             	sub    $0xc,%esp
801084e1:	ff 75 f0             	pushl  -0x10(%ebp)
801084e4:	e8 12 fe ff ff       	call   801082fb <freevm>
801084e9:	83 c4 10             	add    $0x10,%esp
  return 0;
801084ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
801084f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801084f4:	c9                   	leave  
801084f5:	c3                   	ret    

801084f6 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801084f6:	55                   	push   %ebp
801084f7:	89 e5                	mov    %esp,%ebp
801084f9:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084fc:	83 ec 04             	sub    $0x4,%esp
801084ff:	6a 00                	push   $0x0
80108501:	ff 75 0c             	pushl  0xc(%ebp)
80108504:	ff 75 08             	pushl  0x8(%ebp)
80108507:	e8 94 f7 ff ff       	call   80107ca0 <walkpgdir>
8010850c:	83 c4 10             	add    $0x10,%esp
8010850f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108515:	8b 00                	mov    (%eax),%eax
80108517:	83 e0 01             	and    $0x1,%eax
8010851a:	85 c0                	test   %eax,%eax
8010851c:	75 07                	jne    80108525 <uva2ka+0x2f>
    return 0;
8010851e:	b8 00 00 00 00       	mov    $0x0,%eax
80108523:	eb 29                	jmp    8010854e <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
80108525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108528:	8b 00                	mov    (%eax),%eax
8010852a:	83 e0 04             	and    $0x4,%eax
8010852d:	85 c0                	test   %eax,%eax
8010852f:	75 07                	jne    80108538 <uva2ka+0x42>
    return 0;
80108531:	b8 00 00 00 00       	mov    $0x0,%eax
80108536:	eb 16                	jmp    8010854e <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
80108538:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010853b:	8b 00                	mov    (%eax),%eax
8010853d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108542:	83 ec 0c             	sub    $0xc,%esp
80108545:	50                   	push   %eax
80108546:	e8 d4 f2 ff ff       	call   8010781f <p2v>
8010854b:	83 c4 10             	add    $0x10,%esp
}
8010854e:	c9                   	leave  
8010854f:	c3                   	ret    

80108550 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108550:	55                   	push   %ebp
80108551:	89 e5                	mov    %esp,%ebp
80108553:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108556:	8b 45 10             	mov    0x10(%ebp),%eax
80108559:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
8010855c:	eb 7f                	jmp    801085dd <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
8010855e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108561:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108566:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108569:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010856c:	83 ec 08             	sub    $0x8,%esp
8010856f:	50                   	push   %eax
80108570:	ff 75 08             	pushl  0x8(%ebp)
80108573:	e8 7e ff ff ff       	call   801084f6 <uva2ka>
80108578:	83 c4 10             	add    $0x10,%esp
8010857b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010857e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108582:	75 07                	jne    8010858b <copyout+0x3b>
      return -1;
80108584:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108589:	eb 61                	jmp    801085ec <copyout+0x9c>
    n = PGSIZE - (va - va0);
8010858b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010858e:	2b 45 0c             	sub    0xc(%ebp),%eax
80108591:	05 00 10 00 00       	add    $0x1000,%eax
80108596:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108599:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010859c:	3b 45 14             	cmp    0x14(%ebp),%eax
8010859f:	76 06                	jbe    801085a7 <copyout+0x57>
      n = len;
801085a1:	8b 45 14             	mov    0x14(%ebp),%eax
801085a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801085a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801085aa:	2b 45 ec             	sub    -0x14(%ebp),%eax
801085ad:	89 c2                	mov    %eax,%edx
801085af:	8b 45 e8             	mov    -0x18(%ebp),%eax
801085b2:	01 d0                	add    %edx,%eax
801085b4:	83 ec 04             	sub    $0x4,%esp
801085b7:	ff 75 f0             	pushl  -0x10(%ebp)
801085ba:	ff 75 f4             	pushl  -0xc(%ebp)
801085bd:	50                   	push   %eax
801085be:	e8 76 cd ff ff       	call   80105339 <memmove>
801085c3:	83 c4 10             	add    $0x10,%esp
    len -= n;
801085c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085c9:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801085cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085cf:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
801085d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801085d5:	05 00 10 00 00       	add    $0x1000,%eax
801085da:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801085dd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801085e1:	0f 85 77 ff ff ff    	jne    8010855e <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801085e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
801085ec:	c9                   	leave  
801085ed:	c3                   	ret    

801085ee <EXIT_BEGIN>:
#include "traps.h"
#include "asm.h"

.globl EXIT_BEGIN
EXIT_BEGIN:
  	pushl %eax
801085ee:	50                   	push   %eax
  	pushl %eax
801085ef:	50                   	push   %eax
    movl $SYS_exit, %eax
801085f0:	b8 02 00 00 00       	mov    $0x2,%eax
    int $T_SYSCALL
801085f5:	cd 40                	int    $0x40
    ret
801085f7:	c3                   	ret    
