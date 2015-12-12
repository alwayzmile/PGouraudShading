// class TriangleData
// class TriangleStrip

class TriangleData
{
  Vector N = null;
  boolean isDisplayed = false;
  color fill = color(0);
  
  TriangleData() {}
  
  TriangleData(Vector N, boolean isDisplayed, color fill)
  { this.N = N; this.isDisplayed = isDisplayed; this.fill = fill; }
}

class TriangleStrip
{
  ArrayList<Vertex> verts = new ArrayList<Vertex>();
  ArrayList<TriangleData> triData = new ArrayList<TriangleData>();
  boolean isFlat = true;
  
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
      
      if ((idVert+1) == verts.size() && 
          triData.size() < verts.size()-2)
        triData.add(td);
        
      if (!v1.equals(v2) && !v1.equals(v3) && !v2.equals(v3)) {
        if (idVert % 2 == 0)
          td.N = (new Vector(v1, v2)).cross(new Vector(v1, v3));
        else
          td.N = (new Vector(v1, v3)).cross(new Vector(v1, v2));
          
        d = td.N.dot(DOP);
        if (d < 0) {
          td.isDisplayed = true;
          Vector L, N, V, R;
          
          if (this.isFlat) {
            L = (new Vector(v1, lightPos)).normalize();
            N = td.N.normalize();
            V = (new Vector(v1, COP)).normalize();
            R = (new Vector(N.mult(2 * L.dot(N)))).sub(L).normalize();
            td.fill = phongIllumination(objectCol, lightCol, ka, kd, ks, L, N, V, R, 5);
          }
          
          /*
          if ( xi == 0 ) {
          //println(xi);
          println(v1.toString());
          println(v2.toString());
          println(v3.toString());
          println((red(td.fill)) + " " + (green(td.fill)) + " " + (blue(td.fill)) );
          xi++;
          }
          */
        } // end if d < 0
      } // end if !v1.equals(v2) && ...
      
      triData.set(idVert-2, td);
    } // end if idVert >= 2 ...
  }
  
  void draw() {
    Vertex v1, v2, v3;
    Vector L, N, V, R;
    Polygon pol;
        
    for ( int i = 2; i < verts.size(); i++ ) {      
      if (triData.get(i-2).isDisplayed) {                 // (verts.size() - 2) == (triData.size());        
        v1 = perspective(verts.get(i-2), COP.x, COP.y, COP.z);
        v2 = perspective(verts.get(i-1), COP.x, COP.y, COP.z);
        v3 = perspective(verts.get(i)  , COP.x, COP.y, COP.z);
        
        // scale and translate the vertices for displaying purpose
        v1 = v1.scale(100, 100, 1)
               .translate(width/2, height/2, 0);
        v2 = v2.scale(100, 100, 1)
               .translate(width/2, height/2, 0);
        v3 = v3.scale(100, 100, 1)
               .translate(width/2, height/2, 0);
        
        /*
        println(v1.toString());
        println(v2.toString());
        println(v3.toString());
        */
        
        if (!isFlat) {
          L = (new Vector(verts.get(i-2), lightPos)).normalize();
          N = (new Vector(verts.get(i-2))).normalize();
          V = (new Vector(verts.get(i-2), COP)).normalize();
          R = (new Vector(N.mult(2 * L.dot(N)))).sub(L).normalize();
          v1.fill = phongIllumination(objectCol, lightCol, ka, kd, ks, L, N, V, R, 5);
          
          L = (new Vector(verts.get(i-1), lightPos)).normalize();
          N = (new Vector(verts.get(i-1))).normalize();
          V = (new Vector(verts.get(i-1), COP)).normalize();
          R = (new Vector(N.mult(2 * L.dot(N)))).sub(L).normalize();
          v2.fill = phongIllumination(objectCol, lightCol, ka, kd, ks, L, N, V, R, 5);
          
          L = (new Vector(verts.get(i), lightPos)).normalize();
          N = (new Vector(verts.get(i))).normalize();
          V = (new Vector(verts.get(i), COP)).normalize();
          R = (new Vector(N.mult(2 * L.dot(N)))).sub(L).normalize();
          v3.fill = phongIllumination(objectCol, lightCol, ka, kd, ks, L, N, V, R, 5);
        }
        
        //pol = new Polygon(new Vertex(round(v1.x), round(v1.y), round(v1.z)), new Vertex(round(v2.x), round(v2.y), round(v2.z)), new Vertex(round(v3.x), round(v3.y), round(v3.z)));
        pol = new Polygon(v1, v2, v3);
        if (isFlat) {
          pol.draw(triData.get(i-2).fill);
          pol.fill(triData.get(i-2).fill);
        } else {
          pol.draw();
          pol.fill();
        }
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
