// class Vertex
// class VertexInt
// class Vector
// Point getIntersection()

class Vertex
{
  float x, y, z, w = 1;
  color fill;
  
  Vertex()
  { x = y = z = 0; }
  
  Vertex(float x, float y, float z)
  { this.x = x; this.y = y; this.z = z; }
  
  Vertex(float x, float y, float z, float w) 
  { this.x = x; this.y = y; this.z = z; this.w = w; }
  
  boolean equals(Vertex v) {
    return (x == v.x && y == v.y && z == v.z);
  }
  
  String toString() {
    return ( "(" + (x) + " " + (y) + " " + (z) + " " + (w) + ")" );
  }
  
  Vertex rotX(float deg) {
    float angle = radians(deg);
    float yrot, zrot;
    
    yrot = y*cos(angle) + z*-sin(angle);
    zrot = y*sin(angle) + z*cos(angle);
    
    return new Vertex(x, yrot, zrot);
  }
  
  Vertex rotY(float deg) {
    float angle = radians(deg);
    float xrot, zrot;
    
    xrot = x*cos(angle) + z*sin(angle);
    zrot = x*-sin(angle) + z*cos(angle);
    
    return new Vertex(xrot, y, zrot);
  }
  
  Vertex rotZ(float deg) {
    float angle = radians(deg);
    float xrot, yrot;
    
    xrot = x*cos(angle) + y*-sin(angle);
    yrot = x*sin(angle) + y*cos(angle);
    
    return new Vertex(xrot, yrot, z);
  }
  
  Vertex scale(float sx, float sy, float sz) {
    return new Vertex(x*sx, y*sy, z*sz);
  }
  
  Vertex translate(float dx, float dy, float dz) {
    return new Vertex(x+dx, y+dy, z+dz);
  }
}

class Vector
{
  float x, y, z;
  
  Vector(Vector v)
  { x = v.x; y = v.y; z = v.z; }
  
  Vector(Vertex v)
  { x = v.x; y = v.y; z = v.z; }
  
  Vector(float xx, float yy, float zz) 
  { x = xx; y = yy; z = zz; }
  
  Vector(Vertex A, Vertex B) 
  { x = B.x-A.x; y = B.y-A.y; z = B.z-A.z; }
  
  float dot(Vector vect) {
    return x*vect.x + y*vect.y + z*vect.z;
  }
  
  Vector cross(Vector vect) {
    return new Vector(y*vect.z - z*vect.y,
                        z*vect.x - x*vect.z,
                        x*vect.y - y*vect.x);
  }
  
  float length() {
    return sqrt(dot(this));
  }
  
  Vector normalize() {
    float len = length();
    return new Vector(x/len, y/len, z/len);
  }
  
  Vector sub(Vector v) {
    return new Vector(x - v.x, y - v.y, z - v.z);
  }
  
  Vector mult(float n) {
    return new Vector(n * x, n * y, n * z);
  }
  
  String toString() {
    return ("(" + x + " " + y + " " + z + ")T");
  }
}

// Intersection between Line 1 and Line 2
// Line 1; from A1 to A2
// Line 2; from B1 to B2
Point getIntersection(Point A1, Point A2, Point B1, Point B2) {
  float a1, a2, b1, b2, c1, c2, x, y, det;
  a1 = A2.y - A1.y;
  b1 = A1.x - A2.x;
  c1 = a1*A1.x + b1*A1.y;

  a2 = B2.y - B1.y;
  b2 = B1.x - B2.x;
  c2 = a2*B1.x + b2*B1.y;

  det = a1*b2 - a2*b1;
  x = (b2*c1 - b1*c2) / det;
  y = (a1*c2 - a2*c1) / det;

  return new Point(x, y, 0);
}
