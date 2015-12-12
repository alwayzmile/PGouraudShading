// color phongIllumination()
// color ambient()
// color diffuse()
// color specular()

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
  color ambientRGB = ambient(fill, ka);
  color diffuseRGB = diffuse(fill, kd, L, N);
  color specularRGB = specular(light, ks, V, R, n);
  
  float colR = red(ambientRGB) + red(diffuseRGB) + red(specularRGB);
  float colG = green(ambientRGB) + green(diffuseRGB) + green(specularRGB);
  float colB = blue(ambientRGB) + blue(diffuseRGB) + blue(specularRGB);
  
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
