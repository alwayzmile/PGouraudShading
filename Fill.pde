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
