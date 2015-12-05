Vertex translate(Vertex v, float x, float y, float z) {
  return new Vertex(v.x+x, v.y+y, v.z+z);
}

// COP (xc, yc, zc)
Vertex perspective(Vertex v, float xc, float yc, float zc) {
  float w = (-v.z / zc) + 1;
  
  return new Vertex( v.x, v.y, 0, w );
}

Vertex perspective(Vertex v) {
  TMatrix4 m = new TMatrix4();
  m = getStep1n2Matrix().multiply(
      getStep3Matrix().multiply(
      getStep4Matrix().multiply(
      getStep5Matrix().multiply(
      getStep6Matrix()))));

  return vertxmatr(v, m);
}

Vertex vertxmatr(Vertex v, TMatrix4 m) {
  Vertex tmp = new Vertex();
  
  tmp.x = v.x*m.elms[0][0] + 
          v.y*m.elms[1][0] + 
          v.z*m.elms[2][0] + 
          v.w*m.elms[3][0];
  tmp.y = v.x*m.elms[0][1] + 
          v.y*m.elms[1][1] + 
          v.z*m.elms[2][1] + 
          v.w*m.elms[3][1];
  tmp.z = v.x*m.elms[0][2] + 
          v.y*m.elms[1][2] + 
          v.z*m.elms[2][2] + 
          v.w*m.elms[3][2];
  tmp.w = v.x*m.elms[0][3] + 
          v.y*m.elms[1][3] + 
          v.z*m.elms[2][3] + 
          v.w*m.elms[3][3];
  tmp.x /= tmp.w;
  tmp.y /= tmp.w;
  tmp.z /= tmp.w;
  tmp.w /= tmp.w;
  
  return tmp;
}
