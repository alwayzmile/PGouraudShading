// ArrayList<Trapezoid> TrapezoidList
// class Point
// class Endpoint
// class Trapezoid
// class Polygon

ArrayList<Trapezoid> TrapezoidList = new ArrayList<Trapezoid>();

class Point 
{
  float x = 0, 
        y = 0, 
        z = 0;
  Point next = null,    // next and prev as the order in the list
        prev = null;
  Point ptNext = null,  // next and prev as two edges
        ptPrev = null;
  boolean isPeak = false;

  Point(float x, float y, float z) 
  { this.x = x; this.y = y; this.z = z; }

  Point(Point p) 
  { this.x = p.x; this.y = p.y; this.z = p.z; }

  String toString() {
    return ( "(" + (x) + " " + (y) + " " + (z) + ")" );
  }
}

class Endpoint 
{
  float x, y, z, yEnd, xyEnd;
  float xInc = 0, 
        zInc = 0;
  
  Endpoint(float x, float y, float z)
  { this.x = x; this.y = y; this.z = z; }
  
  Endpoint(Point p)
  { this.x = p.x; this.y = p.y; this.z = p.z; }
  
  String toString() {
    String strEp = "";
    
    strEp += "xyz  = " + (x) + " " + (y) + " " + (z) + "\n";
    strEp += "yEnd = " + yEnd + "\n";
    strEp += "xyEnd= " + xyEnd + "\n";
    strEp += "xInc = " + xInc;
    
    return strEp;
  }
}

class Trapezoid 
{
  Endpoint ep1, ep2;

  Trapezoid(Endpoint ep1, Endpoint ep2) 
  { this.ep1 = ep1; this.ep2 = ep2; }
}

class Polygon 
{
  Point first = null,
        last = null;

  Polygon() {}

  Polygon(Vertex v1, Vertex v2, Vertex v3) 
  {
    addF(v1.x, v1.y, v1.z);
    addF(v2.x, v2.y, v2.z);
    addF(v3.x, v3.y, v3.z);
  }
  
  void addF(float x, float y, float z) {
    addF(new Point(x, y, z));
  }

  // add point to the first of the polygon
  // just insert it normally
  // note: put ptPrev and ptNext in anti-clockwise manner
  void addF(Point pt) {
    if (first == null) {
      // left end
      pt.prev = pt;
      pt.ptNext = pt;
      pt.next = pt;
      pt.ptPrev = pt;
      first = pt;
      
      // right end
      last = first;     // don't need last.next; and ... the same as first.next;
      //println("null");
    } else {
      // left end
      first.prev = pt;
      first.ptNext = pt;
      pt.next = first;
      pt.ptPrev = first;
      first = pt;
      
      // right end
      // no need to specify last.prev; 
      // it's already set by first.prev = pt at the second time this procedure is called
      last.next = pt;
      last.ptPrev = pt;
      first.prev = last;
      first.ptNext = last;
    }
  }

  void addSortedY(float x, float y, float z) {
    addSortedY(new Point(x, y, z));
  }

  // TODO Optimize with addF, addL, and addAfter (if possible)
  // add a point to polygon in ascending order based on the value of y
  // 1. doing insertion with sorted y and then sort x per y
  void addSortedY(Point p) {
    // Have to do this because don't want to do any change to "p"
    Point pt = new Point(p.x, p.y, p.z);
    pt.ptNext = p.ptNext;
    pt.ptPrev = p.ptPrev;
    pt.isPeak = p.isPeak;
    
    if (first == null) {
      /* 
      // this pointer assignment put in this if branch is wrong. 
      // first in "pt.prev = first" and ... is null
      pt.prev = first;
      pt.next = first;
      first = pt;
      
      // this one also wrong
      // first in "first.prev" and ... is null
      first.prev = pt;
      first.next = pt;
      first = pt;
      
      println(first.next.toString());  // null pointer exception
      
      // this one works, no null
      pt.prev = pt;
      pt.next = pt;
      first = pt;
      */
      
      // left end
      pt.prev = pt;
      pt.next = pt;
      first = pt;
      
      // right end
      last = first;     // don't need last.next; and ... the same as first.next
      //println("first == null " + pt.toString());
    } else {
      Point cur = first;

      while (cur.next != first && cur.y > pt.y) {
        cur = cur.next;
        //println("while = " + (cur.y >= pt.y) + "; " + pt.toString());
      } // cur.next == first || cur.y >= pt.y

      if (cur.y < pt.y) {     // insert before cur
        pt.next = cur;
        pt.prev = cur.prev;
        pt.prev.next = pt;    // cur.prev.next = pt
        cur.prev = pt;
        
        // if pt should be "first"
        // in this case pt.prev.next == cur.prev.next == first
        // so, cur.next != first anymore, it is pt
        if (cur.next == pt) {
          first = pt;
          last = cur;
          //println("first " + first.toString());
        } else if (cur == first) {
          first = pt;
        }
      } else if (cur.y == pt.y) {  // sort x
        if (cur.x > pt.x) {   // insert before cur
          pt.next = cur;
          pt.prev = cur.prev;
          pt.prev.next = pt;  // cur.prev.next = pt
          cur.prev = pt;
          
          if (cur.next == pt) {
            first = pt;
            last = cur;
            //println("first " + first.toString());
          } else if (cur == first) {
            first = pt;
          }
        } else {              // insert after cur
          pt.prev = cur;
          pt.next = cur.next;
          pt.next.prev = pt;  // cur.next.prev = pt
          cur.next = pt;
          
          if (pt.next == first) {
            last = pt;
          }
        }
      } else { // cur.next == first
        if (cur == first) {
          if (first.y > pt.y) { // insert after first
            // as after and before "first"; also be "last"
            pt.next = first;
            pt.prev = first;
            last = pt;
            
            first.next = last;
            first.prev = last;
            //println("insert after first " + pt.toString());
          } else if (first.y < pt.y) { // insert as "first"
            first.next = pt;
            first.prev = pt;
            last = first;
            
            pt.prev = last;
            pt.next = last;
            first = pt;
            //println("insert as first " + pt.toString());
          } else { // first.y == pt.y
            if (first.x < pt.x) { // insert as after and before "first"; also be "last"
              pt.next = first;
              pt.prev = first;
              last = pt;
              
              first.next = last;
              first.prev = last;
            } else { // insert as "first"
              first.next = pt;
              first.prev = pt;
              last = first;
              
              pt.prev = last;
              pt.next = last;
              first = pt;
            } // end if first.x < pt.x else ...
          } // end if first.y < pt.y else if ...
        } else { // cur != first
          // insert as "last"
          pt.next = first;
          pt.prev = cur;
          last = pt;
          cur.next = last;
          first.prev = last;
          //println("test cur != first " + pt.toString());
        } // end if cur == first else
      } // end if cur.y > pt.y else if ...
    } // end if first == null
  }

  void toTrapezoidList() {
    Point tmp = null;
    Point cur = first;
    Polygon teP = new Polygon();
    
    while (cur.next != first) {
      if ((cur.prev.y > cur.y && cur.next.y > cur.y) ||
          (cur.prev.y < cur.y && cur.next.y < cur.y)) {
        cur.isPeak = true;
      }
      teP.addSortedY(cur);
      
      //println("while " + cur.toString());
      //println(teP.toString());
      //println();
      
      cur = cur.next;
    }
    
    if ((cur.prev.y > cur.y && cur.next.y > cur.y) ||
        (cur.prev.y < cur.y && cur.next.y < cur.y)) {
      cur.isPeak = true;
    }
    teP.addSortedY(cur);
    
    /*
    println();
    println(teP.toString());
    println();
    */
    
    Point p1start, p2start,
          p1end,   p2end,
          p1max,   p2max, 
          p1min,   p2min;
    Trapezoid tmpT;
    Endpoint ep1, ep2;
    float tmpf;
    
    cur = teP.first;
    
    do {   
      p1start = cur;      
      
      if (p1start.isPeak)
        p2start = p1start;
      else
        p2start = p1start.next;
      
      if (p1start.isPeak) {
        p1end = p1start.ptNext;
        p2end = p1start.ptPrev;
      } else if (p2start.isPeak) { // && !p1start.isPeak
        p1start = p2start;
        p1end = p1start.ptNext;
        p2end = p1start.ptPrev;
      } else if (p1start.y == p2start.y) {
        if (p1start.y > p1start.ptNext.y)
          p1end = p1start.ptNext;
        else
          p1end = p1start.ptPrev;
          
        if (p2start.y > p2start.ptNext.y)
          p2end = p2start.ptNext;
        else
          p2end = p2start.ptPrev;
      } else { // p1start.y > p2start.y
        if (p1start.y > p1start.ptNext.y)
          p1end = p1start.ptNext;
        else
          p1end = p1start.ptPrev;
        
        if (p2start.y < p2start.ptNext.y)
          p2end = p2start.ptNext;
        else
          p2end = p2start.ptPrev;
      }
      
      /*
      println("p1start: " + p1start.toString());
      println("p2start: " + p2start.toString());
      println("p1end: " + p1end.toString());
      println("p2end: " + p2end.toString());
      */
      
      if (p1start.y > p1end.y) {
        p1max = p1start;
        p1min = p1end;
      } else {
        p1max = p1end;
        p1min = p1start;
      }
      
      if (p2start.y > p2end.y) {
        p2max = p2start;
        p2min = p2end;
      } else {
        p2max = p2end;
        p2min = p2start;
      }
      
      /*
      println("p1max: " + p1max.toString());
      println("p2max: " + p2max.toString());
      println("p1min: " + p1min.toString());
      println("p2min: " + p2min.toString());
      */
      
      p1start = getIntersection(p1max, p1min, new Point(p2max.x+1, p2max.y, p2max.z), p2max);
      p1end   = getIntersection(p1max, p1min, new Point(p2min.x+1, p2min.y, p2min.z), p2min);
      p2start = getIntersection(new Point(p1max.x+1, p1max.y, p1max.z), p1max, p2max, p2min);
      p2end   = getIntersection(new Point(p1min.x+1, p1min.y, p1min.z), p1min, p2max, p2min);
      
      /*
      println("p1start new: " + p1start.toString());
      println("p2start new: " + p2start.toString());
      println("p1end new: " + p1end.toString());
      println("p2end new: " + p2end.toString());
      */
      
      //-----------------------------------------
      if (p1start.y > p1max.y)
        p1start = p1max;
      else if (p1start.y < p1min.y)
        p1start = p1min;
        
      if (p1end.y > p1max.y)
        p1end = p1max;
      else if (p1end.y < p1min.y)
        p1end = p1min;
      
      //-----------------------------------------
      if (p2start.y > p2max.y)
        p2start = p2max;
      else if (p2start.y < p2min.y)
        p2start = p2min;
        
      if (p2end.y > p2max.y)
        p2end = p2max;
      else if (p2end.y < p2min.y)
        p2end = p2min;
      
      /*
      println("p1start fin: " + p1start.toString());
      println("p2start fin: " + p2start.toString());
      println("p1end fin  : " + p1end.toString());
      println("p2end fin  : " + p2end.toString());
      println();
      */
      
      ep1 = new Endpoint(p1start);
      ep1.xInc = -((p1start.x-p1end.x) / (p1start.y-p1end.y));
      ep1.yEnd = p1end.y;
      ep1.xyEnd = p1end.x;
      
      ep2 = new Endpoint(p2start);
      ep2.xInc = -(p2start.x-p2end.x) / (p2start.y-p2end.y);
      ep2.yEnd = p2end.y;
      ep2.xyEnd = p2end.x;
      
      tmpT = new Trapezoid(ep1, ep2);
      TrapezoidList.add(tmpT);
      
      cur = cur.next;
    } while (cur.next != teP.first);
    
    //println("TrapezoidList size: " + TrapezoidList.size());
  }
  
  void fill(color col) { 
    Trapezoid T;
    Endpoint ep1, ep2;
    int tmpi;
    float tmpf;
    Point pt1, pt2;
    
    TrapezoidList.clear();
    this.toTrapezoidList();
    
    for (int ti = 0; ti < TrapezoidList.size(); ti++) {
      T = TrapezoidList.get(ti);
      ep1 = T.ep1;
      ep2 = T.ep2;
      
      //if (abs(ep1.y - ep1.yEnd) < 1 || abs(ep2.y - ep2.yEnd) < 1) {
        println();
        println(ep1.toString());
        println();
        println(ep2.toString());
        println("==========================================");
      //}
      
      /*
      println();
      println(ep1.toString());
      println();
      println(ep2.toString());
      */
      
      /*
      stroke(#ff0000);
      strokeWeight(3);
      line(ep1.x, ep1.y, ep1.xyEnd, ep1.yEnd);
      line(ep2.x, ep2.y, ep2.xyEnd, ep2.yEnd);
      */
      
      /*
      stroke(#ff0000);
      strokeWeight(3);
      pt1 = new Point(ep1.x, ep1.y, 0);
      for (int i = round(ep1.y); i >= round(ep1.yEnd); i-- ) {
        point(pt1.x, pt1.y);
        pt1 = new Point(pt1.x + ep1.xInc, pt1.y - 1, 0);
      }
      
      pt2 = new Point(ep2.x, ep2.y, 0);
      for (int i = round(ep2.y); i >= round(ep2.yEnd); i-- ) {
        point(pt2.x, pt2.y);
        pt2 = new Point(pt2.x + ep2.xInc, pt2.y - 1, 0);
      }
      */
      
      stroke(col);
      strokeWeight(1);
      pt1 = new Point(ep1.x, ep1.y, 0);
      pt2 = new Point(ep2.x, ep2.y, 0);
      
      //if (round(ep2.y) == round(ep2.yEnd))
      //  println("same");
      
      for (int i = round(ep2.y); i >= round(ep2.yEnd); i-- ) {
        line(pt1.x, pt1.y, pt2.x, pt2.y);
        
        pt1 = new Point(pt1.x + ep1.xInc, pt1.y - 1, 0);
        pt2 = new Point(pt2.x + ep2.xInc, pt2.y - 1, 0);
      }
      
      
      /*
      //-----------------------------------------------------------------------
      tmpf = -(ep1.y - floor(ep1.y)) * (ep1.x - ep1.xyEnd) / (ep1.y - ep1.yEnd);
      pt1 = new Point(ep1.x+tmpf, floor(ep1.y), 0);
      
      println(ep1.toString());
      println();
      println("xd= " + tmpf);
      println(pt1.toString());
      
      stroke(#ff0000);
      strokeWeight(3);
      for (int i = 0; i < round(ep1.y - ep1.yEnd); i++) {
        pt1 = new Point((pt1.x + ep1.xInc), (pt1.y - 1), 0);
        point(pt1.x, pt1.y);
      }
      
      //-----------------------------------------------------------------------
      tmpf = -(ep2.y - floor(ep2.y)) * (ep2.x - ep2.xyEnd) / (ep2.y - ep2.yEnd);
      pt2 = new Point(ep2.x+tmpf, floor(ep2.y), 0);
      
      println(ep2.toString());
      println();
      println("xd= " + tmpf);
      println(pt2.toString());
      
      stroke(#ff0000);
      strokeWeight(3);
      for (int i = 0; i < round(ep2.y - ep2.yEnd); i++) {
        pt2 = new Point((pt2.x + ep2.xInc), (pt2.y - 2), 0);
        point(pt2.x, pt2.y);
      }
      */
    }
  }
  
  void draw() {
    Point cur = first;
    
    strokeWeight(1);
    stroke(0);
    if (cur != null) {
      while (cur.next != first) {
        line(cur.x, cur.y, cur.next.x, cur.next.y);
        cur = cur.next;
      }
      
      line(cur.x, cur.y, cur.next.x, cur.next.y);
    }
  }
  
  String toString() {
    String points = "";
    Point cur = first;

    if (cur == null) {
      points = "null\n";
    } else {
      /* another way to do this
      cur = last;
      while (cur.prev != last) {
        points += cur.toString() + "\n";
        cur = cur.prev;
        //println(cur.prev.toString());
      }
      */
      
      while (cur.next != first) {
        //points += cur.toString() + " prev=" + cur.ptPrev.toString() + " next=" + cur.ptNext.toString() + " isPeak=" + cur.isPeak + "\n";
        points += cur.toString() + "\n";
        cur = cur.next;
      }
      
      //points += cur.toString() + " prev=" + cur.ptPrev.toString() + " next=" + cur.ptNext.toString() + " isPeak=" + cur.isPeak + "\n";
      points += cur.toString();
    }
    
    return points;
  }
}
