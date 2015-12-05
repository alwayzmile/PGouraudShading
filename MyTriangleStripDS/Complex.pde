boolean isLineSegmentIntersection( Point X, Point A1, Point A2, Point B1, Point B2 ) {
  return (X.x <= max(A1.x, A2.x)) && (X.x >= min(A1.x, A2.x)) &&
         (X.y <= max(A1.y, A2.y)) && (X.y >= min(A1.y, A2.y)) &&
         (X.x <= max(B1.x, B2.x)) && (X.x >= min(B1.x, B2.x)) &&
         (X.y <= max(B1.y, B2.y)) && (X.y >= min(B1.y, B2.y));
}

boolean doLineIntersect( Point A1, Point A2, Point B1, Point B2 ) {
  if ( A1 == null || A2 == null || B1 == null || B2 == null ) return false;
  
  if ( A1.x == A2.x ) {
    return !( (B1.x == B2.x) && (A1.x != B1.x) );
  } else if ( B1.x == B2.x ) {
    return true;
  } else {
    float m1 = (A1.y - A2.y) / (float)(A1.x - A2.x);
    float m2 = (B1.y - B2.y) / (float)(B1.x - B2.x);
    
    return m1 != m2;
  }
}

public Point getIntersectionPoint ( Point A1, Point A2, Point B1, Point B2 ) {
  int a1, a2, b1, b2, c1, c2, x, y, det;
  a1 = A2.y - A1.y;
  b1 = A1.x - A2.x;
  c1 = a1*A1.x + b1*A1.y;
  
  a2 = B2.y - B1.y;
  b2 = B1.x - B2.x;
  c2 = a2*B1.x + b2*B1.y;
   
  det = a1*b2 - a2*b1;
  x = round((b2*c1 - b1*c2) / (float)det);
  y = round((a1*c2 - a2*c1) / (float)det);
  
  return new Point( x, y );
}


boolean doLinesIntersect(Point a1, Point a2, Point b1, Point b2){
  Point ip;
  if(doLineIntersect(a1, a2, b1, b2)){
    ip = getIntersectionPoint(a1, a2, b1, b2);
    return isLineSegmentIntersection(ip, a1, a2, b1, b2);
  } else {
    return false;
  }
}

boolean isValidPolygon(Polygon p){
  Point p1, p2;
  if(p.n < 3) return false;
  else {
    if (p.n > 3){
      p1 = p.first;
      while(p1.next.next != null){
        p2 = p1.next.next;
        while(p2.next != null){
          if(doLinesIntersect(p1, p1.next, p2, p2.next)) return false;
          p2 = p2.next;
        }
        if(doLinesIntersect(p1, p1.next, p2, p.first) && p1 != p.first) return false;
        p1 = p1.next;
      }
    }
    return true;
  }
}

