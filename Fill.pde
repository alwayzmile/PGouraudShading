class Edge 
{
  VertexInt vi1, vi2;
  int xMin, xMax, yMin, yMax, xyMin;
  
  Edge(VertexInt vi1, VertexInt vi2)
  { 
    this.vi1 = vi1; this.vi2 = vi2;
    xMin = (vi1.x < vi2.x) ? vi1.x : vi2.x;
    xMax = (vi1.x > vi2.x) ? vi1.x : vi2.x;
    yMin = (vi1.y < vi2.y) ? vi1.y : vi2.y;
    yMax = (vi1.y > vi2.y) ? vi1.y : vi2.y;
    xyMin = (vi1.y < vi2.y) ? vi1.x : vi2.x;
  }
}

class ElemSET
{
  int yMax, xyMin, dx, dy, carry = 0;
  ElemSET next = null;
  
  ElemSET(int yMax, int xyMin, int dx, int dy)
  {
    this.yMax = yMax; this.xyMin = xyMin; this.dy = abs(dy);
    this.dx = (dy < 0) ? -dx : dx;
  }
}

class BuckSET
{
  int size = 0;
  ElemSET first = null;
  
  BuckSET() {}
  
  void insertF(ElemSET e) {
    if (first == null) {
      first = e;
    } else {
      e.next = first;
      first = e;
    }
    
    size++;
  }
}

class AEL
{//====================================== what is y
  int y, size = 0;
  ElemSET first = null;
  
  AEL() {}
  
  void insertL(ElemSET e, int size) {
    ElemSET cur = first;
    
    if (first == null) 
      first = e;
    else {
      while (cur.next != null)
        cur = cur.next;
      cur.next = e;
    }
    
    this.size += size;
  }
  
  void fill() {
    ElemSET cur = first;
    
    while (cur != null) {
      line(cur.xyMin, y, cur.next.xyMin, y);//============ y is used here?
      cur = cur.next.next;
    }
  }
  
  void process() {
    ElemSET cur = first;
    
    while (cur != null) {
      cur.xyMin += (cur.dx / cur.dy);
      cur.carry += (cur.dx % cur.dy);
      
      if (cur.dx < 0) { //======================== why doing this
        if (cur.carry <= -cur.dy) {
          cur.xyMin--;
          cur.carry += cur.dy;
        }
      } else {
        if (cur.carry >= cur.dy) {
          cur.xyMin++;
          cur.carry -= cur.dy;
        }
      }
        
      cur = cur.next;
    }
  }
}