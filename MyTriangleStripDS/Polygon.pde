class Point{
  public int x, y;
  public Point next;
  
  public Point(int xp, int yp){
    x = xp;
    y = yp;
    next = null;
  }
}

class Polygon{
  public Point first;
  public int n, XMin, XMax, YMin, YMax;
  public color colour, fill;
  public boolean filled, selected;
  public Edge edgeF;
  public Bucket[] buckets = new Bucket[410];
  public AEL ael;
  public Polygon next;
  
  public Polygon(){
    n = 0;
    first = null;
    colour = color(0);
    fill = color(0);
    filled = false;
    selected = false;
    next = null;
  }
  
  public void insertL(Point p){
    Point cur;
    
    if(first != null){
      cur = first.next;
      while(cur != null){
        cur = cur.next;
      }
      cur = p;
    } else {
      first = p;
    }
    n++;
  }
  
  public void insertF(Point p){
    if ( first != null ) {
      p.next = first;
      first = p;
    } else {
      first = p;
    } 
    n++;
  }
  
  public void draw(){
    Point cur = first;
    if ( filled ) fills();
    if ( selected ) stroke(255, 0, 0);
    else stroke(0);
    if(cur != null){
      while(cur.next != null){
        line(cur.x, cur.y, cur.next.x, cur.next.y);
        cur = cur.next;
      }
      line(cur.x, cur.y, first.x, first.y);
    }
  }
  
  public void setRect(){
    //set enclosed rectangle
    Point cur = first;
    XMin = cur.x; XMax = cur.x; YMin = cur.y; YMax = cur.y;
    while ( cur.next != null ){
      cur = cur.next;
      if ( cur.x < XMin ) XMin = cur.x;
      if ( cur.x > XMax ) XMax = cur.x;
      if ( cur.y < YMin ) YMin = cur.y;
      if ( cur.y > YMax ) YMax = cur.y;
    }
  }
  
  public void insertEdge(Edge e){
   if ( edgeF == null ) edgeF = e;
   else {
     e.next = edgeF;
     edgeF = e;
   }
  }
  
  public void setEdges(){
    Point cur = first;
    Edge tmp;
    while( cur.next != null ) {
      tmp = new Edge(cur, cur.next);
      insertEdge(tmp);
      cur = cur.next;
    }
    tmp = new Edge(cur, first);
    insertEdge(tmp);
  }
  
  public void clearBuckets(){
    int i = 0;
    while ( i < 410 ) {
      buckets[i] = new Bucket();
      i++;
    }
  }
  
  public void setBuckets(){
    Edge tmp = edgeF;
    ElmtSET e;
    while ( tmp != null ) {
      e = new ElmtSET(tmp.YMax(), tmp.XofYMin(), tmp.P2.x - tmp.P1.x, tmp.P2.y - tmp.P1.y);
      if(e.dy > 0) buckets[tmp.YMin() - YMin].insertF(e);
      tmp = tmp.next;
    }
    sortBuckets();
  }
  
  public void sortBucket(Bucket b){
    int i = 1, j = 1;
    ElmtSET cur, nxt, tmp;
    cur = b.first;
    nxt = cur.next;
    while(i < b.n){
      while(j < b.n){
        if(cur.XofYMin < nxt.XofYMin){
          tmp = cur;
          cur = nxt;
          nxt = cur;
        }
        cur = cur.next;
        if (cur != null)
          nxt = cur.next;
        j++;
      }
      j = 1;
      cur = b.first;
      nxt = cur.next;
      i++;
    }
  }
  
  public void sortBuckets(){
    int i = 0;
    while(i < YMax-YMin){
      if(buckets[i].first != null) sortBucket(buckets[i]);
      i++;
    }
  }
  
  public void deleteAEL(ElmtSET a){
    ElmtSET cur = ael.first, prev;
    if ( cur == a ) ael.first = ael.first.next;
    else {
      prev = cur;
      cur = cur.next;
      while ( cur != a ){
        prev = cur;
        cur = cur.next;
      }
      prev.next = cur.next;
    }
    ael.n--;
  }
  
  public void deleteReplaced(){
    ElmtSET b = buckets[ael.y - YMin].first, a;
    while(b != null){
      a = ael.first;
      while(a != null){
        if(a.YMax == ael.y && a.XofYMin == b.XofYMin) deleteAEL(a);
        a = a.next;
      }
      b = b.next;
    }
  }
  
  public void deleteOverY(){
    ElmtSET a = ael.first;
    while(a != null){
      if(a.YMax <= ael.y) deleteAEL(a);
      a = a.next;
    }
  }
  
  public void sortAEL(){
    int i = 1, j = 1;
    ElmtSET cur, nxt, prv, tmp;
    prv = null;
    cur = ael.first;
    nxt = cur.next;
    while(i < ael.n){
      while(j < ael.n){
        if(cur.XofYMin < nxt.XofYMin){
          tmp = cur;
          tmp.next = nxt.next;
          nxt.next = tmp;
          if ( prv == null ) ael.first = nxt;
          else prv.next = nxt;
          cur = nxt;
        }
        prv = cur;
        cur = cur.next;
        nxt = cur.next;
        j++;
      }
      j = 1;
      prv = null;
      cur = ael.first;
      nxt = cur.next;
      i++;
    }
  }
  
  public void fills(){
    int i = YMin;
    clearBuckets();
    setBuckets();
    ael = new AEL();
    while(i <= YMax){
      ael.y = i;
      
      if(buckets[i - YMin].first != null){
        ael.insertL(buckets[i - YMin].first, buckets[i - YMin].n);
        deleteReplaced();
        sortAEL();
      }
      deleteOverY();
      stroke(fill);
      strokeWeight(1);
      ael.fills();
      i++;
      ael.process();
    }
    ael.first = null;
    
  }
}
