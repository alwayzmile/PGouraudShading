// bandPoints = 2 ^ bandPower
// R is the radius of the sphere
TriangleStrip sphere(int bandPower, int bandPoints, int R) {
  int bandMask = bandPoints - 2;
  int sectionsInBand = bandPoints / 2 - 1;
  int totalPoints = sectionsInBand * bandPoints;
  float sectionArc = 6.28 / sectionsInBand;
  R = -R;
  
  float x_angle;
  float y_angle;
  TriangleStrip tmp = new TriangleStrip();
  
  for (int i=0; i < totalPoints; i++) {
    // using last bit to alternate,+band number (which band)
    x_angle = (float)(i & 1) + (i >> bandPower);
    // (i&Band_Mask)>>1 == Local Y value in the band
    // (i>>Band_Power)*((Band_Points/2)-1) == how many bands have we processed?
    // Remember - we go "right" one value for every 2 points.
    // i>>bandpower - tells us our band number
    y_angle = (float)((i & bandMask) >> 1) + ((i >> bandPower) * (sectionsInBand));
 
    x_angle *= (float)sectionArc / 2.0; // remember - 180° x rot not 360
    y_angle *= (float)sectionArc * -1; // *-1
    
    /*
    println(R * sin(x_angle) * sin(y_angle),
            R * cos(x_angle),
            R * sin(x_angle) * cos(y_angle));
    */
      
    tmp.addVertex(R * sin(x_angle) * sin(y_angle),
                  R * cos(x_angle),
                  R * sin(x_angle) * cos(y_angle));
  }
  
  return tmp;
}
