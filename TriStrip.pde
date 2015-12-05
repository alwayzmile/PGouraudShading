class TriangleStrip
{
  ArrayList<Vertex> verts = new ArrayList<Vertex>();
  
  TriangleStrip() {}
  
  void addVertex(float x, float y, float z) {
    Vertex tmp = new Vertex(x, y, z);
    verts.add(tmp);
  }
  
  void drawIt() {
    Vertex v1, v2, v3;
    VertexInt vi1, vi2, vi3;
    Vector normal;
    Surface sf;
    int n = -1;
    float d;
        
    for ( int i = 2; i < verts.size(); i++ ) {
      n++;
      
      v1 = verts.get(i-2);
      v2 = verts.get(i-1);
      v3 = verts.get(i);
      
      if ( v1.x == v2.x || v2.x == v3.x || v3.x == v1.x )
        continue;
      
      if (n % 2 == 0)
        normal = (new Vector(v2.x-v1.x, v2.y-v1.y, v2.z-v1.z)).cross(new Vector(v3.x-v1.x, v3.y-v1.y, v3.z-v1.z));
      else
        normal = (new Vector(v3.x-v1.x, v3.y-v1.y, v3.z-v1.z)).cross(new Vector(v2.x-v1.x, v2.y-v1.y, v2.z-v1.z));
        
      d = normal.dot(new Vector(0, 0, -1));
      if (d >= 0)
        continue;
      
      v1 = perspective(v1, 0, 0, 5);
      v2 = perspective(v2, 0, 0, 5);
      v3 = perspective(v3, 0, 0, 5);
      
      vi1 = new VertexInt(round(v1.x), round(v1.y));
      vi2 = new VertexInt(round(v2.x), round(v2.y));
      vi3 = new VertexInt(round(v3.x), round(v3.y));
      
      sf = new Surface(vi1, vi2, vi3);
      sf.fill = #ff0000;
      sf.fill();
      
      //stroke(0);
      //line(vi1.x, vi1.y, vi2.x, vi2.y);
      //line(vi2.x, vi2.y, vi3.x, vi3.y);
      //line(vi3.x, vi3.y, vi1.x, vi1.y);
    }
  }
}

class Vertex
{
  float x, y, z, w = 1;
  
  Vertex() 
  { x = y = z = 0; }
  
  Vertex(float x, float y, float z) 
  { this.x = x; this.y = y; this.z = z; }
  
  Vertex(float x, float y, float z, float w) 
  { this.x = x; this.y = y; this.z = z; this.w = w; }
  
  String toString() {
    return ( "(" + (x) + "," + (y) + "," + (z) + "," + (w) + ")" );
  }
}

class VertexInt
{
  int x, y;
  
  VertexInt() 
  { x = y = 0; }
  
  VertexInt(int x, int y)
  { this.x = x; this.y = y; }
  
  String toString() {
    return ( "(" + (x) + "," + (y) + ")" );
  }
}

class Vector
{
  float x, y, z;
  
  Vector(float xx, float yy, float zz) 
  { x = xx; y = yy; z = zz; }
  
  float dot(Vector vect) {
    return x*vect.x + y*vect.y + z*vect.z;
  }
  
  Vector cross(Vector vect) {
    return new Vector( y*vect.z - z*vect.y,
                        z*vect.x - x*vect.z,
                        x*vect.y - y*vect.x );
  }
  
  float length() {
    return sqrt(dot(this));
  }
  
  Vector unit() {
    float len = length();
    return new Vector( x/len, y/len, z/len );
  }
  
  String toString() {
    return ( "(" + x + "," + y + "," + z + ")" );
  }
}
