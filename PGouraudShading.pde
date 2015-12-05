int Band_Power;  // 2^Band_Power = Total Points in a band.
int Band_Points; // 16 = 2^Band_Power
int Band_Mask;
int Sections_In_Band;
int Total_Points;
// remember - for each section in a band, we have a band
float Section_Arc;
float R; // radius of 10

void setup() {
  size(640, 360);
  background(204);
  noFill();
  strokeWeight(0.005);
  
  Band_Power = 6;  // 2^Band_Power = Total Points in a band.
  Band_Points = 64; // 16 = 2^Band_Power
  Band_Mask = (Band_Points-2);
  Sections_In_Band = ((Band_Points/2)-1);
  Total_Points = (Sections_In_Band*Band_Points);
  // remember - for each section in a band, we have a band
  Section_Arc = (6.28/Sections_In_Band);
  R = -10; // radius of 10
  
  //scale(10, 10);
  
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
      R*sin(x_angle)*sin(y_angle)*10+width/2,
      R*cos(x_angle)*10+height/2,
      R*sin(x_angle)*cos(y_angle));
  }
  ts.drawIt();
}

void draw(){}
