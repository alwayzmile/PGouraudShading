class TriangleStrip
{
  ArrayList<Vertex> verts = new ArrayList<Vertex>();
  ArrayList<TriangleData> triData = new ArrayList<TriangleData>(); 
  
  TriangleStrip() {}
  
  void addVertex(float x, float y, float z) {
    Vertex tmp = new Vertex(x, y, z);
    verts.add(tmp);
    
    if (verts.size() > 2)
      setTriangleData(verts.size()-1);
  }
  
  /**
   * idVert is the index of the third vertex in "verts" which
   * together with two vertex with index < idVert form a triangle
   *
   * note: (verts.size() - 2) == (triData.size());
   */
  private void setTriangleData(int idVert) {
    if (idVert >= 2) {
      TriangleData td = new TriangleData();
      Vertex v1 = verts.get(idVert-2),
             v2 = verts.get(idVert-1),
             v3 = verts.get(idVert);
      float d;
      
      if ((idVert+1) == verts.size())
        triData.add(td);
        
      //if (v1.x != v2.x && v2.x != v3.x && v3.x != v1.x ) {
        if (idVert % 2 == 0)
          td.N = (new Vector(v2.x-v1.x, v2.y-v1.y, v2.z-v1.z)).cross(new Vector(v3.x-v1.x, v3.y-v1.y, v3.z-v1.z));
        else
          td.N = (new Vector(v3.x-v1.x, v3.y-v1.y, v3.z-v1.z)).cross(new Vector(v2.x-v1.x, v2.y-v1.y, v2.z-v1.z));
          
        d = td.N.dot(DOP);
        if (d < 0) {
          td.isDisplayed = true;
          td.fill = flatShading(idVert-2, lightCol, ka, kd);  // (verts.size() - 2) == (triData.size());
        }
      //} // end if v1.x != v2.x ...
      
      triData.set(idVert-2, td);
    } // end if idVert >= 2 ...
  }
  
  /**
   * idTri is the index of the triangle which its data stored in triData
   * this triangle is formed by vertices 
   * verts.get(idTri-2), verts.get(idTri-1), verts.get(idTri)
   *
   * ka is the ambient coefficient
   * kd is the diffuse coefficient
   *
   * note: (verts.size() - 2) == (triData.size());
   */
  private color flatShading(int idTri, color fill, float ka, float kd) {
    if (triData.get(idTri).isDisplayed) {
      Vertex vert = verts.get(idTri);
      Vector N = triData.get(idTri).N.normalize();
      Vector L = new Vector(lightPos);
      L = L.sub(new Vector(vert)).normalize();
      
      int R = int(ka * red(fill)   + kd * red(fill)   * L.dot(N));
      int G = int(ka * green(fill) + kd * green(fill) * L.dot(N));
      int B = int(ka * blue(fill)  + kd * blue(fill)  * L.dot(N));
      
      return color(R, G, B);
    } else {
      return color(0);
    }
  }
  
  void draw() {
    Vertex v1, v2, v3;
    VertexInt vi1, vi2, vi3;
    Vector normal;
    Surface sf;
        
    for ( int i = 2; i < verts.size(); i++ ) {      
      if (triData.get(i-2).isDisplayed) {                 // (verts.size() - 2) == (triData.size());
        v1 = perspective(verts.get(i-2), 0, 0, 5);
        v2 = perspective(verts.get(i-1), 0, 0, 5);
        v3 = perspective(verts.get(i)  , 0, 0, 5);
        
        // scale and translate the vertices for displaying purpose
        v1 = v1.scale(10, 10, 1)
               .translate(width/2, height/2, 0);
        v2 = v2.scale(10, 10, 1)
               .translate(width/2, height/2, 0);
        v3 = v3.scale(10, 10, 1)
               .translate(width/2, height/2, 0);
        
        vi1 = new VertexInt(round(v1.x), round(v1.y));
        vi2 = new VertexInt(round(v2.x), round(v2.y));
        vi3 = new VertexInt(round(v3.x), round(v3.y));
        
        sf = new Surface(vi1, vi2, vi3);
        sf.fill = triData.get(i-2).fill;
        sf.fill();
      }
    }
  }
  
  void rotX(float deg) {
    for (int i = 0; i < verts.size(); i++) {
      verts.set(i, verts.get(i).rotX(deg));
      
      if (i >= 2)
        setTriangleData(i);
    }
    
    draw();
  }
  
  void rotY(float deg) {
    for (int i = 0; i < verts.size(); i++) {
      verts.set(i, verts.get(i).rotY(deg));
      
      if (i >= 2)
        setTriangleData(i);
    }
    
    draw();
  }
  
  void rotZ(float deg) {
    for (int i = 0; i < verts.size(); i++) {
      verts.set(i, verts.get(i).rotZ(deg));
      
      if (i >= 2)
        setTriangleData(i);
    }
    
    draw();
  }
}

class TriangleData
{
  Vector N = null;
  boolean isDisplayed = false;
  color fill = color(0);
  
  TriangleData() {}
  
  TriangleData(Vector N, boolean isDisplayed, color fill)
  { this.N = N; this.isDisplayed = isDisplayed; this.fill = fill; }
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
  
  Vector(Vertex v)
  { x = v.x; y = v.y; z = v.z; }
  
  Vector(float xx, float yy, float zz) 
  { x = xx; y = yy; z = zz; }
  
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
  
  String toString() {
    return ("(" + x + "," + y + "," + z + ")");
  }
}
