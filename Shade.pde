// color phongIllumination()
// color ambient()
// color diffuse()
// color specular()

class LightSources
{
  ArrayList<Vertex> positions = new ArrayList<Vertex>();
  float ka, kd, ks;
  color lightColor, objectColor;
  int specularExp;
  
  LightSources(Vertex lpos, color ocol, color lcol, float a, float d, float s, int se) 
  { positions.add(lpos); objectColor = ocol; lightColor = lcol; ka = a; kd = d; ks = s; specularExp = se;  }
  
  void addLightSource(Vertex lpos) {
    positions.add(lpos);
  }
}

/**
 * ka is the ambient coefficient
 * kd is the diffuse coefficient
 * ks is specular reflection coefficient
 * L is the unit vector from a point on the surface to light source
 * N is the normalized normal vector of the surface
 * V is vector from the one of the point on the surface to the viewer (unit vector)
 * R is reflection vector (unit vector)
 * n is specular reflection exponent
 */
color phongIllumination(color fill, color light, float ka, float kd, float ks, Vector L, Vector N, Vector V, Vector R, int n) {
  color ambientRGB = ambient(fill, ka), 
        diffuseRGB, 
        specularRGB;
  
  float colR = red(ambientRGB);
  float colG = green(ambientRGB);
  float colB = blue(ambientRGB);
  
  if (kd > 0) {
    diffuseRGB = diffuse(fill, kd, L, N);
    specularRGB = specular(light, ks, V, R, n);
    
    colR += red(diffuseRGB)   + red(specularRGB);
    colG += green(diffuseRGB) + green(specularRGB);
    colB += blue(diffuseRGB)  + blue(specularRGB);
  }
  
  return color(colR, colG, colB);
}

// N is unit vector
color phongIllumination(LightSources ls, Vertex pt, Vertex viewer, Vector N) {
  color ambientRGB, diffuseRGB, specularRGB;
  float colR, colG, colB;
  Vector L, V, R;
  
  ambientRGB = ambient(ls.objectColor, ls.ka);
  
  colR = red(ambientRGB);
  colG = green(ambientRGB);
  colB = blue(ambientRGB);
  
  if (ls.kd > 0) {
    V = (new Vector(pt, viewer)).normalize();
    for (int i = 0; i < ls.positions.size(); i++) {
      L = (new Vector(pt, ls.positions.get(i))).normalize();
      R = (new Vector(N.mult(2 * L.dot(N)))).sub(L).normalize();
      
      diffuseRGB = diffuse(ls.objectColor, ls.kd, L, N);
      specularRGB = specular(ls.lightColor, ls.ks, V, R, ls.specularExp);
      
      colR += red(diffuseRGB)   + red(specularRGB);
      colG += green(diffuseRGB) + green(specularRGB);
      colB += blue(diffuseRGB)  + blue(specularRGB);
    }
  }
  
  return color(colR, colG, colB);
}

/**
 * ka is the ambient coefficient
 */
color ambient(color fill, float ka) {
  float Ramb = ka * red(fill);
  float Gamb = ka * green(fill);
  float Bamb = ka * blue(fill);
  
  return color(Ramb, Gamb, Bamb);
}

/**
 * L is the unit vector from a point on the surface to light source
 * N is the normalized normal vector of the surface
 */
color diffuse(color fill, float kd, Vector L, Vector N) {
  float Rdif = kd * red(fill)   * L.dot(N);
  float Gdif = kd * green(fill) * L.dot(N);
  float Bdif = kd * blue(fill)  * L.dot(N);
  
  return color(Rdif, Gdif, Bdif);
}

/**
 * ks is specular reflection coefficient
 * V is vector from the one of the point on the surface to the viewer (unit vector)
 * R is reflection vector (unit vector)
 * n is specular reflection exponent
 */
color specular(color light, float ks, Vector V, Vector R, int n) {
  float Rspec = ks * red(light) * pow(V.dot(R), n);
  float Gspec = ks * green(light) * pow(V.dot(R), n);
  float Bspec = ks * blue(light) * pow(V.dot(R), n);
  //println(Rspec + " " + Gspec + " " + Bspec);
  
  return color(Rspec, Gspec, Bspec);
}

// y1 value is higher than y2
color interpolateIalongY(float ys, float y1, float y2, color i1, color i2) {
  // Ia = (Ys - Y2) / (Y1 - Y2) * I1 + (Y1 - Ys) / (Y1 - Y2) * I2
  if (y1 == y2) {
    return i1;
  } else {
    float R = (ys - y2) / (y1 - y2) * red(i1) + (y1 - ys) / (y1 - y2) * red(i2);
    float G = (ys - y2) / (y1 - y2) * green(i1) + (y1 - ys) / (y1 - y2) * green(i2);
    float B = (ys - y2) / (y1 - y2) * blue(i1) + (y1 - ys) / (y1 - y2) * blue(i2);
    
    return color(R, G, B);
  }
}

// yb value is higher than ya
color interpolateIalongX(float xp, float xa, float xb, color ia, color ib) {
  // Ip = (Xb - Xp) / (Xb - Xa) * Ia + (Xp - Xa) / (Xb - Xa) * Ib
  if (xa == xb) {
    return ia;
  } else {
    float R = (xb - xp) / (xb - xa) * red(ia) + (xp - xa) / (xb - xa) * red(ib);
    float G = (xb - xp) / (xb - xa) * green(ia) + (xp - xa) / (xb - xa) * green(ib);
    float B = (xb - xp) / (xb - xa) * blue(ia) + (xp - xa) / (xb - xa) * blue(ib);
    
    return color(R, G, B);
  }
}
