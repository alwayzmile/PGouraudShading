// color flatShading()

/**
 * ka is the ambient coefficient
 * kd is the diffuse coefficient
 * L is the unit vector from a point on the surface to light source
 * N is the normalized normal vector of the surface
 */
color flatShading(color fill, float ka, float kd, Vector L, Vector N) {
  float Ramb = ka * red(fill);
  float Gamb = ka * green(fill);
  float Bamb = ka * blue(fill);
  
  float Rdif = kd * red(fill)   * L.dot(N);
  float Gdif = kd * green(fill) * L.dot(N);
  float Bdif = kd * blue(fill)  * L.dot(N);
  
  int R = round(Ramb + ((Rdif > 0) ? Rdif : 0));
  int G = round(Gamb + ((Gdif > 0) ? Gdif : 0));
  int B = round(Bamb + ((Bdif > 0) ? Bdif : 0));
  
  return color(R, G, B);
}

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
  int yMax, yMin, xyMin, dx, dy, carry = 0;
  color rgb1, rgb2;
  int r = 111, g = 111, b = 111;
  
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
  
  void fillIt() {
    ElemSET cur = first;
    color col;
    float r1, g1, b1,
          r2, g2, b2,
          rp, gp, bp;
    
    while (cur != null) {
      /*
      // IA = I1-(I1-I2)(y1-yP)/(y1-y2)
      r1 = red(cur.rgb1)-(red(cur.rgb1)-red(cur.rgb2))*(cur.yMax-y)/cur.yMax-cur.yMin;
      g1 = green(cur.rgb1)-(green(cur.rgb1)-green(cur.rgb2))*(cur.yMax-y)/cur.yMax-cur.yMin;
      b1 = blue(cur.rgb1)-(blue(cur.rgb1)-blue(cur.rgb2))*(cur.yMax-y)/cur.yMax-cur.yMin;
      //col1 = color(r1, g1, b1);
      
      r2 = red(cur.next.rgb1)-(red(cur.next.rgb1)-red(cur.next.rgb2))*(cur.next.yMax-y)/cur.next.yMax-cur.next.yMin;
      g2 = green(cur.next.rgb1)-(green(cur.next.rgb1)-green(cur.next.rgb2))*(cur.next.yMax-y)/cur.next.yMax-cur.next.yMin;
      b2 = blue(cur.next.rgb1)-(blue(cur.next.rgb1)-blue(cur.next.rgb2))*(cur.next.yMax-y)/cur.next.yMax-cur.next.yMin;
      //col2 = color(r2, g2, b2);
      
      if (cur.xyMin <= cur.next.xyMin) {
        for (int i = cur.xyMin; i <= cur.next.xyMin; i++) {
          // IP = IB-(IB-IA)(xB-xP)/(xB-xA)
          //rp = r2-(r2-r1)*(cur.next.xyMin-y)/cur.next.yMax-cur.next.yMin;
        }
      }
      */
      cur.r = round((y - cur.yMin) / (cur.yMax - cur.yMin) * red(cur.rgb1) + (cur.yMax - y) / (cur.yMax - cur.yMin) * red(cur.rgb2));
      cur.g = round((y - cur.yMin) / (cur.yMax - cur.yMin) * green(cur.rgb1) + (cur.yMax - y) / (cur.yMax - cur.yMin) * green(cur.rgb2));
      cur.b = round((y - cur.yMin) / (cur.yMax - cur.yMin) * blue(cur.rgb1) + (cur.yMax - y) / (cur.yMax - cur.yMin) * blue(cur.rgb2));
      
      cur.next.r = round((y - cur.next.yMin) / (cur.next.yMax - cur.next.yMin) * red(cur.next.rgb1) + (cur.next.yMax - y) / (cur.next.yMax - cur.next.yMin) * red(cur.next.rgb2));
      cur.next.g = round((y - cur.next.yMin) / (cur.next.yMax - cur.next.yMin) * green(cur.next.rgb1) + (cur.next.yMax - y) / (cur.next.yMax - cur.next.yMin) * green(cur.next.rgb2));
      cur.next.b = round((y - cur.next.yMin) / (cur.next.yMax - cur.next.yMin) * blue(cur.next.rgb1) + (cur.next.yMax - y) / (cur.next.yMax - cur.next.yMin) * blue(cur.next.rgb2));
      
      r1 = cur.r;
      g1 = cur.g;
      b1 = cur.b;
      
      r2 = cur.next.r;
      g2 = cur.next.g;
      b2 = cur.next.b;
      
      stroke(r1, g1, b1);
      strokeWeight(2);
      point(cur.xyMin, y);
      println(r1 + " " + g1 + " " + b1);
      
      if (cur.xyMin <= cur.next.xyMin) {
        for (int i = cur.xyMin; i <= cur.next.xyMin; i++) {
          // IP = IB-(IB-IA)(xB-xP)/(xB-xA)
          if (cur.xyMin == cur.next.xyMin) {
            rp = r1;
            gp = g1;
            bp = b1;
          } else {
            // (Xb - Xp) / (Xb - Xa) * Ia + (Xp - Xa) / (Xb - Xa) * Ib
            rp = round((cur.next.xyMin - i) / (cur.next.xyMin) * r1 + (i - cur.xyMin) / (cur.next.xyMin - cur.xyMin) * r2);
            gp = round((cur.next.xyMin - i) / (cur.next.xyMin) * g1 + (i - cur.xyMin) / (cur.next.xyMin - cur.xyMin) * g2);
            bp = round((cur.next.xyMin - i) / (cur.next.xyMin) * b1 + (i - cur.xyMin) / (cur.next.xyMin - cur.xyMin) * b2);
            /*
            rp = r2 - (r2 - r1) * (cur.next.xyMin - i) / (cur.next.xyMin - cur.xyMin);
            gp = g2 - (g2 - g1) * (cur.next.xyMin - i) / (cur.next.xyMin - cur.xyMin);
            bp = b2 - (b2 - b1) * (cur.next.xyMin - i) / (cur.next.xyMin - cur.xyMin);
            */
          }
          
          //println(r2 + " " + g2 + " " + b2);
          stroke(color(rp, gp, bp));
          strokeWeight(1);
          //point(i, y);
        }
      }
      
      //line(cur.xyMin, y, cur.next.xyMin, y);
      //println("(" + cur.xyMin + "," + y + ")" + " - (" + cur.next.xyMin + "," + y + ")");
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
