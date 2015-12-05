class Edge{
  public Point P1, P2;
  public Edge next;
  
  public Edge(Point p, Point q){
    P1 = p; P2 = q;
  }
  
  public int XMin(){
    return P1.x < P2.x? P1.x : P2.x;
  }
  public int XMax(){
    return P1.x > P2.x? P1.x : P2.x;
  }
  public int YMin(){
    return P1.y < P2.y? P1.y : P2.y;
  }
  public int YMax(){
    return P1.y > P2.y? P1.y : P2.y;
  }
  public int XofYMin(){
    return P1.y < P2.y? P1.x : P2.x;
  }
}

class ElmtSET{
  public int YMax, XofYMin, dx, dy, carry;
  public ElmtSET next;
  
  public ElmtSET(int ya, int xi, int x, int y){
    YMax = ya; XofYMin = xi; dx = x;
    if ( y < 0 ) { dx = -dx; dy = -y; }
    else dy = y;
    carry = 0;
    next = null;
  }
}

class Bucket{
  public int n;
  public ElmtSET first;
  
  public void insertF(ElmtSET e){
    if(first == null){
      first = e;
    } else {
       e.next = first;
       first = e;
    }
    n++;
  }
  
  public Bucket(){
    n = 0;
    first = null;
  }
}

class AEL{
  public int y, n;
  public ElmtSET first;
  
  public void insertF(ElmtSET e){
   if ( first == null ) first = e;
   else {
     e.next = first;
     first = e;
   }
  }
  
  public void insertL(ElmtSET e, int ni){
    ElmtSET cur = first;
    if( first == null ) first = e;
    else {
      while ( cur.next != null ){
        cur = cur.next;
      }
      cur.next = e;
    }
    n = n + ni;
  }
  
  public void fills(){
    ElmtSET cur = first;
    while(cur != null){
      line(cur.XofYMin, y, cur.next.XofYMin, y);
      cur = cur.next.next;
    }
  }
  
  public void process(){
    ElmtSET cur = first;
    while(cur != null){
      cur.XofYMin = cur.XofYMin + intDiv(cur.dx, cur.dy);
      cur.carry = cur.carry + (cur.dx % cur.dy);
      if(cur.dx < 0){
        if(cur.carry <= -cur.dy){
          cur.XofYMin--;
          cur.carry = cur.carry + cur.dy;
        }        
      } else {
        if(cur.carry >= cur.dy){
          cur.XofYMin++;
          cur.carry = cur.carry - cur.dy;
        }
      }
      cur = cur.next;
    }
  }
  
  public AEL(){
    first = null;
    n = 0;
  }
}

public int intDiv(int a, int b){
  a = a - (a % b);
  return a / b;
}
