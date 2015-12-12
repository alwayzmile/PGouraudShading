class Surface
{
  VertexInt vi1, vi2, vi3;
  int xMin, xMax, yMin, yMax;
  color fill = color(0);
  Edge[] edges = new Edge[3];
  BuckSET[] buckets;
  AEL ael;
  
  Surface(VertexInt vi1, VertexInt vi2, VertexInt vi3)
  { 
    this.vi1 = vi1; this.vi2 = vi2; this.vi3 = vi3;
    
    xMin = min(vi1.x, vi2.x, vi3.x);
    yMin = min(vi1.y, vi2.y, vi3.y);
    xMax = max(vi1.x, vi2.x, vi3.x);
    yMax = max(vi1.y, vi2.y, vi3.y);
    
    edges[0] = new Edge(vi1, vi2);
    edges[1] = new Edge(vi2, vi3);
    edges[2] = new Edge(vi3, vi1);
    
    /*
    strokeWeight(10);
    stroke(vi1.rgb);
    point(vi1.x, vi1.y);
    stroke(vi2.rgb);
    point(vi2.x, vi2.y);
    stroke(vi3.rgb);
    point(vi3.x, vi3.y);
    */
    
    setBuckets(); // see below
  }
  
  void setBuckets() {
    float r, g, b;
    
    // clear buckets
    buckets = new BuckSET[yMax - yMin + 1];
    for (int i = 0; i < (yMax - yMin + 1); i++)
      buckets[i] = new BuckSET();
    
    // insert edges to buckets
    ElemSET e;
    for (int i = 0; i < 3; i++) {
      e = new ElemSET(edges[i].yMax, 
                edges[i].xyMin,
                edges[i].vi2.x - edges[i].vi1.x,
                edges[i].vi2.y - edges[i].vi1.y);
                
      e.yMin = edges[i].yMin;
      if (edges[i].vi1.y >= edges[i].vi2.y) {
        e.rgb1 = edges[i].vi1.rgb;
        e.rgb2 = edges[i].vi2.rgb;
      } else {
        e.rgb1 = edges[i].vi2.rgb;
        e.rgb2 = edges[i].vi1.rgb;
      }
      
      ////////////////////////////////////////////////////////////////////////////////////////////////////////set rinc, ginc, binc
                
      if (e.dy > 0)
        buckets[edges[i].yMin - yMin].insertF(e);
    }
    
    // sorting edges in buckets based on edge's x of ymin position
    for (int i = 0; i < (yMax - yMin); i++) {
      if (buckets[i].first != null) { //======== how does it work?
        ElemSET cur, next, tmp;
        cur = buckets[i].first;
        next = cur.next;
        
        for (int j = 1; j < buckets[i].size; j++) {
          for (int k = 1; k < buckets[i].size; k++) {
            if (cur.xyMin < next.xyMin) {
              tmp = cur;
              cur = next;
              next = cur;
            }
            
            cur = cur.next;
            
            if (cur != null)
              next = cur.next;
          }
          
          cur = buckets[i].first;
          next = cur.next;
        }
      }
    }
  }
  
  void fill() {
    setBuckets();
    ael = new AEL();
    ElemSET cur;
    color col1, col2;
    
    /*
    // draw outline
    stroke(fill);
    strokeWeight(2);
    line(vi1.x, vi1.y, vi2.x, vi2.y);
    line(vi2.x, vi2.y, vi3.x, vi3.y);
    line(vi3.x, vi3.y, vi1.x, vi1.y);
    */
    
    for (int i = yMin; i <= yMax; i++) {
      ael.y = i;
      cur = buckets[i - yMin].first;
      
      if (cur != null) {
        // (Ys - Y2) / (Y1 - Y2) * I1 + (Y1 - Ys) / (Y1 - Y2) * I2
        cur.r = round((i - cur.yMin) / (cur.yMax - cur.yMin) * red(cur.rgb1) + (cur.yMax - i) / (cur.yMax - cur.yMin) * red(cur.rgb2));
        cur.g = round((i - cur.yMin) / (cur.yMax - cur.yMin) * green(cur.rgb1) + (cur.yMax - i) / (cur.yMax - cur.yMin) * green(cur.rgb2));
        cur.b = round((i - cur.yMin) / (cur.yMax - cur.yMin) * blue(cur.rgb1) + (cur.yMax - i) / (cur.yMax - cur.yMin) * blue(cur.rgb2));
        
        /*
        cur.r = round(red(cur.rgb1) - (red(cur.rgb1) - red(cur.rgb2)) * (cur.yMax - i) / cur.yMax - cur.yMin);
        cur.g = round(green(cur.rgb1) - (green(cur.rgb1) - green(cur.rgb2)) * (cur.yMax - i) / cur.yMax - cur.yMin);
        cur.b = round(blue(cur.rgb1) - (blue(cur.rgb1) - blue(cur.rgb2)) * (cur.yMax - i) / cur.yMax - cur.yMin);
        */
        
        stroke(cur.r, cur.g, cur.b);
        strokeWeight(3);
        //point(cur.xyMin, i);
        println(i);
        
        //println(cur.yMin);
        
        ael.insertL(cur, buckets[i - yMin].size);
        //println(buckets[i - yMin].size);
        
        deleteReplaced();
        sortAEL();
      }
      
      deleteOverY();
      stroke(fill);
      strokeWeight(1);
      ael.fillIt();
      ael.process();
    }
    println();
    
    ael.first = null;
  }
  
  void deleteAEL(ElemSET a) {
    ElemSET prev, cur = ael.first;
    
    if (cur == a)
      ael.first = ael.first.next;
    else {
      prev = cur;
      cur = cur.next;
      
      while (cur != a) {
        prev = cur;
        cur = cur.next;
      }
      
      prev.next = cur.next;
    }
    
    ael.size--;
  }
  
  void deleteReplaced() {
    ElemSET a, b = buckets[ael.y - yMin].first;
    
    while (b != null) {
      a = ael.first;
      
      while (a != null) {
        if (a.yMax == ael.y && a.xyMin == b.xyMin)
          deleteAEL(a);
        
        a = a.next;
      }
      
      b = b.next; 
    }
  }
  
  void sortAEL() {
    ElemSET cur  = ael.first,
            next = cur.next, 
            prev = null, 
            tmp;
    
    for (int i = 1; i < ael.size; i++) {
      for (int j = 1; j < ael.size; j++) {
        if (cur.xyMin < next.xyMin) {
          tmp = cur;
          tmp.next = next.next;
          next.next = tmp;
          
          if (prev == null) 
            ael.first = next;
          else 
            prev.next = next;
            
          cur = next;
        }
        
        prev = cur;
        cur = cur.next;
        next = cur.next;
      }
      
      prev = null;
      cur = ael.first;
      next = cur.next;
    }
  }
  
  void deleteOverY() {
    ElemSET a = ael.first;
    
    while (a != null) {
      if (a.yMax <= ael.y) 
        deleteAEL(a);
        
      a = a.next;
    }
  }
}
