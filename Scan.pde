class TrapezoidList {
  Trapezoid first = null;
}

class Trapezoid {
  Trapezoid next = null;
  Polygon trapezoid = new Polygon();

  Trapezoid() {
  }
}

class Polygon {
  Point first = null,
        last = null;

  Polygon() {
  }

  void addF(float x, float y, float z) {
    addF(new Point(x, y, z));
  }

  // add point to the first of the polygon
  // just insert it normally
  void addF(Point pt) {
    if (first == null) {
      // left end
      pt.prev = pt;
      pt.next = pt;
      first = pt;
      
      // right end
      last = first;     // don't need last.next; and ... the same as first.nextt;
    } else {
      // left end
      first.prev = pt;
      pt.next = first;
      first = pt;
      
      // right end
      // no need to specify last.prev; 
      // it's already set by first.prev = pt at the second time this procedure is called
      last.next = pt;
      first.prev = last;
    }
  }

  void addSortedY(float x, float y, float z) {
    addSortedY(new Point(x, y, z));
  }

  // TODO Optimize with addF, addL, and addAfter (if possible)
  // add a point to polygon in ascending order based on the value of y
  // 1. doing insertion with sorted y and then sort x per y
  void addSortedY(Point pt) {
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

  /*
  TrapezoidList toTrapezoidList() {
   Line left, right;
   Point cur;
   boolean isLeftLower;
   
   cur = first;
   while (cur.next != first) {
   if (cur
   }
   }
   */

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
        points += cur.toString() + "\n";
        cur = cur.next;
        //println(cur.next.toString());
      }
      
      points += cur.toString();
    }
    
    return points;
  }
}

class Line {
  Point p1, p2;

  Line(Point p1, Point p2)
  { 
    this.p1 = p1; 
    this.p2 = p2;
  }
}

class Point {
  float x = 0, 
        y = 0, 
        z = 0;
  Point next = null, 
  prev = null;

  Point(float x, float y, float z) 
  { this.x = x; this.y = y; this.z = z; }

  Point(Point p ) 
  { this.x = p.x; this.y = p.y; this.z = p.z;
  }

  String toString() {
    return ( "(" + (x) + " " + (y) + " " + (z) + ")" );
  }
}

class Endpoint {
}

