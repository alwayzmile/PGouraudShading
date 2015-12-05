class Vertex
{
  float x, y, z, w;
  
  public Vertex() {
    x = y = z = 0;
    w = 1;
  }
  
  public Vertex(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    w = 1;
  }
  
  public Vertex(float x, float y, float z, float w) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
  }
  
  public String toString() {
    return ( "(" + (x) + "," + (y) + "," + (z) + "," + (w) + ")" );
  }
}

class TriangleStrip
{
  ArrayList<Vertex> verts = new ArrayList<Vertex>();
  
  public TriangleStrip() {}
  
  public void addVertex(float x, float y, float z) {
    Vertex tmp = new Vertex(x, y, z);
    verts.add(tmp);
  }
  
  public void drawIt() {
    Vertex v1, v2, v3;
    int ns = 0,
        n = -1;
    for ( int i = 2; i < verts.size(); i++ ) {      
      v1 = verts.get(i-2);
      v2 = verts.get(i-1);
      v3 = verts.get(i);
      
      n++;
      if ( v1.x == v2.x || v2.x == v3.x || v3.x == v1.x )
        continue;
      ns++;
      
      //line(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
      //line(v2.x, v2.y, v2.z, v3.x, v3.y, v3.z);
      //line(v3.x, v3.y, v3.z, v1.x, v1.y, v1.z);
      //println(v1.toString());
      //println(v2.toString());
      //println(v3.toString());
      //println("-");
      TVector normal;
      if (n % 2 == 0)
        normal = crossProduct(new TVector(v2.x-v1.x, v2.y-v1.y, v2.z-v1.z), new TVector(v3.x-v1.x, v3.y-v1.y, v3.z-v1.z));
      else
        normal = crossProduct(new TVector(v3.x-v1.x, v3.y-v1.y, v3.z-v1.z), new TVector(v2.x-v1.x, v2.y-v1.y, v2.z-v1.z));
        
      float d = dotProduct(normal, new TVector(0, 0, -1));
      
      if (d >= 0)
        continue;
      
      v1 = perspective(verts.get(i-2), 0, 0, 5);
      v2 = perspective(verts.get(i-1), 0, 0, 5);
      v3 = perspective(verts.get(i), 0, 0, 5);
      
      //println(perspective(verts.get(i-2), 0, 0, 5).toString());
      //v1 = perspective(verts.get(i-2));
      //v2 = perspective(verts.get(i-1));
      //v3 = perspective(verts.get(i));
      //println(v1.toString());
      //println(v2.toString());
      //println(v3.toString());
      //println();
      line(v1.x, v1.y, v2.x, v2.y);
      line(v2.x, v2.y, v3.x, v3.y);
      line(v3.x, v3.y, v1.x, v1.y);
    }
    
    //println("NS: " + ns);
    //println("N : " + (n+1));
  }
}
