class TPoint 
{
  public float x, y, z, w;
  
  public TPoint() {
    x = y = z = 0;
    w = 1;
  }
  
  public TPoint(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = 1;
  }
  
  public TPoint multiply(TMatrix4 T) {
    TPoint tmp = new TPoint();
    
    tmp.x = x*T.elms[0][0] + 
            y*T.elms[1][0] + 
            z*T.elms[2][0] + 
            w*T.elms[3][0];
    tmp.y = x*T.elms[0][1] + 
            y*T.elms[1][1] + 
            z*T.elms[2][1] + 
            w*T.elms[3][1];
    tmp.z = x*T.elms[0][2] + 
            y*T.elms[1][2] + 
            z*T.elms[2][2] + 
            w*T.elms[3][2];
    tmp.w = x*T.elms[0][3] + 
            y*T.elms[1][3] + 
            z*T.elms[2][3] + 
            w*T.elms[3][3];
            
    return tmp;
  }
  
  public void printIt() {
//    println( "(" + (x/w) + "," + (y/w) + "," + (z/w) + "," + (w/w) + ")" );
    println( "(" + (x) + "," + (y) + "," + (z) + "," + (w) + ")" );
  }
}
