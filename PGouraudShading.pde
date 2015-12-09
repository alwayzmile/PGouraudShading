int Band_Power;  // 2^Band_Power = Total Points in a band.
int Band_Points; // 16 = 2^Band_Power
int Band_Mask;
int Sections_In_Band;
int Total_Points;
// remember - for each section in a band, we have a band
float Section_Arc;
float R; // radius of 10

Vector DOP = new Vector(0, 0, -1);
Vertex lightPos = new Vertex(-10, -10, 10);
color lightCol = #ff0000;
float ka = 0.7,
      kd = 1.1;
TriangleStrip ts;

void setup() {
  size(640, 360, OPENGL);
  background(204);
  noFill();
  strokeWeight(0.005);
  
  Band_Power = 6;  // 2^Band_Power = Total Points in a band.
  Band_Points = 64; // 2^Band_Power
  Band_Mask = (Band_Points-2);
  Sections_In_Band = ((Band_Points/2)-1);
  Total_Points = (Sections_In_Band*Band_Points);
  // remember - for each section in a band, we have a band
  Section_Arc = (6.28/Sections_In_Band);
  R = -1; // radius of 1
  
  //scale(10, 10);
  
  int i;
  float x_angle;
  float y_angle;
  ts = new TriangleStrip();
  for (i=0;i<Total_Points;i++)
  {  
    // using last bit to alternate,+band number (which band)
    x_angle=(float)(i&1)+(i>>Band_Power);  
    
    // (i&Band_Mask)>>1 == Local Y value in the band
    // (i>>Band_Power)*((Band_Points/2)-1) == how many bands
    //  have we processed?
    // Remember - we go "right" one value for every 2 points.
    //  i>>bandpower - tells us our band number
    y_angle=(float)((i&Band_Mask)>>1)+((i>>Band_Power)*(Sections_In_Band));
 
    x_angle*=(float)Section_Arc/2.0f; // remember - 180° x rot not 360
    y_angle*=(float)Section_Arc*-1; // *-1
    
    /*println(
      R*sin(x_angle)*sin(y_angle),
      R*cos(x_angle),
      R*sin(x_angle)*cos(y_angle));*/
      
    ts.addVertex(
      R*sin(x_angle)*sin(y_angle),
      R*cos(x_angle),
      R*sin(x_angle)*cos(y_angle));
  }
  ts.draw();
  
  String a = "test";
  //println(a.equals("test"));
  
  Polygon testPol = new Polygon();
  /*
  testPol.addF(-5, 3, 0);
  testPol.addF(-2, 3, 0);
  testPol.addF(-1, 3, 0);
  testPol.addF(0, -3, 0);
  testPol.addF(0, -5, 0);
  */
  testPol.addSortedY(0, 8, 0);
  testPol.addSortedY(0, 0, 0);
  testPol.addSortedY(4, 5, 0);
  testPol.addSortedY(4, 2, 0);
  testPol.addSortedY(-5, 3, 0);
  print(testPol.toString());
}

void draw(){}

void keyPressed() {
  if (key == 'x' || key == 'X') {
    ts.rotX(3);
    background(204);
    ts.draw();
  } else if (key == 'y' || key == 'Y') {
    ts.rotY(3);
    background(204);
    ts.draw();
  } else if (key == 'z' || key == 'Z') {
    ts.rotZ(3);
    background(204);
    ts.draw();
  }
}
