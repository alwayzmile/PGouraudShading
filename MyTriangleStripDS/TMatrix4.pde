class TMatrix4 
{
  public float[][] elms = new float[4][4];
  
  public TMatrix4() {
    for (int i=0; i<4; i++) {
      for (int j=0; j<4; j++) {
        elms[i][j] = 0;
      }
    }
  }
  
  public void inputCol(int col, float a, float b, float c, float d) {
    elms[0][col] = a;
    elms[1][col] = b;
    elms[2][col] = c;
    elms[3][col] = d;
  }
  
  public void inputRow(int row, float a, float b, float c, float d) {
    elms[row][0] = a;
    elms[row][1] = b;
    elms[row][2] = c;
    elms[row][3] = d;
  }
  
  public TMatrix4 multiply(TMatrix4 T) {
    TMatrix4 tmp = new TMatrix4();
    
    for (int i=0; i<4; i++) {
      for (int j=0; j<4; j++) {
        for (int k=0; k<4; k++) {
          tmp.elms[i][j] += (elms[i][k] * T.elms[k][j]);
          //println(i + " " + j + " " + k); 
          //println("tmp.elms[" + i + "][" + j +"] += (elms[" + i + "][" + k + "] * T.elms[" + k + "][" + j + "])");
        }
        //print( tmp.elms[i][j] + " _ " );
      }
      //println();
    }
    
    return tmp;
  }
  
  public void printIt() {
    for ( int i=0; i<4; i++ ) {
      for ( int j=0; j<4; j++ ) {
        print( (elms[i][j]) + " " );
      }
      println();
    }
  }
}
