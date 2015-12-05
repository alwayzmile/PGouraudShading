class TVector
{
  public float x, y, z, w;
  
  public TVector ( float xx, float yy, float zz ) {
    x = xx;
    y = yy;
    z = zz;
    w = 0;
  }
  
  public TVector ( float xx, float yy, float zz, float ww ) {
    x = xx;
    y = yy;
    z = zz;
    w = ww;
  }
  
  public float dotProduct( TVector vect ) {
    return x*vect.x + y*vect.y + z*vect.z;
  }
  
  public float dotProduct( TPoint pt ) {
    return x*pt.x + y*pt.y + z*pt.z;
  }
  
  public TVector crossProduct( TVector vect ) {
    return new TVector( y*vect.z - z*vect.y,
                        z*vect.x - x*vect.z,
                        x*vect.y - y*vect.x );
  }
  
//  public TVector divideBy( float db ) {
//    return new TVector( x/db, y/db, z/db );
//  }
//  
//  public TVector multiplyBy( float mb ) {
//    return new TVector( x*mb, y*mb, z*mb );
//  }
//  
//  public TVector minus( TVector m ) {
//    return new TVector( x-m.x, y-m.y, z-m.z );
//  }
//  
//  public TVector plus( TVector p ) {
//    return new TVector( x+p.x, y+p.y, z+p.z );
//  }
  
  public float getLength() {
    return sqrt(dotProduct(this));
  }
  
  public TVector getUnitVector() {
    float len = getLength();
    return new TVector( x/len, y/len, z/len );
  }
  
  public void printIt() {
    println( "(" + x + "," + y + "," + z + ")" );
  }
}

TVector crossProduct( TVector v1, TVector v2 ) {
  return new TVector( v1.y*v2.z - v1.z*v2.y,
                      v1.z*v2.x - v1.x*v2.z,
                      v1.x*v2.y - v1.y*v2.x );
}

float dotProduct( TVector v1, TVector v2 ) {
  return v1.x*v2.x + v1.y*v2.y + v1.z*v2.z;
}
