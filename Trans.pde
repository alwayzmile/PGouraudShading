// COP (xc, yc, zc)
Vertex perspective(Vertex v, float xc, float yc, float zc) {
  float w = (-v.z / zc) + 1;
  
  return new Vertex( v.x/w, v.y/w, v.z/w, 1 );
}
