/**
 * todo:
 * -polygon filling
 */

int Band_Power;  // 2^Band_Power = Total Points in a band.
int Band_Points; // 16 = 2^Band_Power
int Band_Mask;
int Sections_In_Band;
int Total_Points;
// remember - for each section in a band, we have a band
float Section_Arc;
float R; // radius of 10

TPoint VRP = new TPoint(0, 0, 0);
TPoint VRPView = new TPoint(0, 0, 0);
TPoint COP = new TPoint(0, 0, 5);
TVector VPN = new TVector(0, 0, 1);
TVector VUP = new TVector(0, 1, 0);
float xwmin = -2, 
      xwmax = 2, 
      ywmin = -2, 
      ywmax = 2;
float znear = 2, 
      zfar  = 1;
float zmin, zmax;

TVector n = VPN.getUnitVector();
float t = n.dotProduct(VUP);
TVector tmpp = new TVector(n.x*t, n.y*t, n.z*t);
TVector tmpv = new TVector(VUP.x-tmpp.x, VUP.y-tmpp.y, VUP.z-tmpp.z);
TVector v = tmpv.getUnitVector();
TVector tmp = v.crossProduct(n);
TVector u = tmp.getUnitVector();

void setup() {
  size(640, 360);
  background(204);
  noFill();
  strokeWeight(0.005);
  
  Band_Power = 5;  // 2^Band_Power = Total Points in a band.
  Band_Points = 32; // 16 = 2^Band_Power
  Band_Mask = (Band_Points-2);
  Sections_In_Band = ((Band_Points/2)-1);
  Total_Points = (Sections_In_Band*Band_Points);
  // remember - for each section in a band, we have a band
  Section_Arc = (6.28/Sections_In_Band);
  R = -10; // radius of 10
  
  translate(width/2, height/2);
  scale(10, 10);
  
  int i;
  float x_angle;
  float y_angle;
  TriangleStrip ts = new TriangleStrip();
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
  
  ts.drawIt();
  
  /*
  Vertex ptA = new Vertex(-1, -1, 1);
  Vertex ptB = new Vertex(1, -1, 1);
  Vertex ptC = new Vertex(1, 1, 1);
  Vertex ptD = new Vertex(-1, 1, 1);
  
  Vertex ptE = new Vertex(-1, -1, -1);
  Vertex ptF = new Vertex(1, -1, -1);
  Vertex ptG = new Vertex(1, 1, -1);
  Vertex ptH = new Vertex(-1, 1, -1);
  
  ptA = perspective(ptA, 0, 0, 5);
  ptB = perspective(ptB, 0, 0, 5);
  ptC = perspective(ptC, 0, 0, 5);
  ptD = perspective(ptD, 0, 0, 5);
  
  ptE = perspective(ptE, 0, 0, 5);
  ptF = perspective(ptF, 0, 0, 5);
  ptG = perspective(ptG, 0, 0, 5);
  ptH = perspective(ptH, 0, 0, 5);
  
  line(ptA.x, ptA.y, ptB.x, ptB.y);
  line(ptB.x, ptB.y, ptC.x, ptC.y);
  line(ptC.x, ptC.y, ptD.x, ptD.y);
  line(ptD.x, ptD.y, ptA.x, ptA.y);
  
  line(ptE.x, ptE.y, ptF.x, ptF.y);
  line(ptF.x, ptF.y, ptG.x, ptG.y);
  line(ptG.x, ptG.y, ptH.x, ptH.y);
  line(ptH.x, ptH.y, ptE.x, ptE.y);
  
  line(ptA.x, ptA.y, ptE.x, ptE.y);
  line(ptB.x, ptB.y, ptF.x, ptF.y);
  line(ptC.x, ptC.y, ptG.x, ptG.y);
  line(ptD.x, ptD.y, ptH.x, ptH.y);
  */
}

void draw(){}
