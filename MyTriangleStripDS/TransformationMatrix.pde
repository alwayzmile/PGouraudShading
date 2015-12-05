TMatrix4 getTranslationMatrix(float dx, float dy, float dz) {
  TMatrix4 tmp = new TMatrix4();
  
  tmp.inputRow(0, 1,  0,  0, 0);
  tmp.inputRow(1, 0,  1,  0, 0);
  tmp.inputRow(2, 0,  0,  1, 0);
  tmp.inputRow(3, dx, dy, dz,1);
  
  return tmp;
}

TMatrix4 getScaleMatrix(float sx, float sy, float sz) {
  TMatrix4 tmp = new TMatrix4();
  
  tmp.inputRow(0, sx, 0,  0, 0);
  tmp.inputRow(1, 0,  sy, 0, 0);
  tmp.inputRow(2, 0,  0,  sz,0);
  tmp.inputRow(3, 0,  0,  0, 1);
  
  return tmp;
}

TMatrix4 getStep1n2Matrix() {
  TMatrix4 tmp = new TMatrix4();
  
  tmp.inputRow(0, u.x,      v.x,      n.x,     0);
  tmp.inputRow(1, u.y,      v.y,      n.y,     0);
  tmp.inputRow(2, u.z,      v.z,      n.z,     0);
  tmp.inputRow(3, 0,        0,        0,       1);
  
  //tmp.printIt();
  VRPView = VRP.multiply(tmp);
  tmp.inputRow(0, u.x,         v.x,         n.x,        0);
  tmp.inputRow(1, u.y,         v.y,         n.y,        0);
  tmp.inputRow(2, u.z,         v.z,         n.z,        0);
  tmp.inputRow(3, -VRPView.x,  -VRPView.y,  -VRPView.z, 1);
  //tmp.printIt();
  
  return tmp;
}

TMatrix4 getStep3Matrix() {
  TMatrix4 tmp = new TMatrix4();
  
  tmp.inputRow(0, 1,       0,       0,      0);
  tmp.inputRow(1, 0,       1,       0,      0);
  tmp.inputRow(2, 0,       0,       1,      0);
  tmp.inputRow(3, -COP.x,  -COP.y,  -COP.z, 1);
  
  return tmp;
}

TMatrix4 getStep4Matrix() {
  TMatrix4 tmp = new TMatrix4();
  
  TPoint CW = new TPoint((xwmin + xwmax)/2, (ywmin + ywmax)/2, 0);
  TVector DOP = new TVector(CW.x-COP.x, CW.y-COP.y, CW.z-COP.z);
  
  float shx = -(DOP.x / DOP.z);
  float shy = -(DOP.y / DOP.z);
  
  tmp.inputRow(0, 1,     0,     0, 0);
  tmp.inputRow(1, 0,     1,     0, 0);
  tmp.inputRow(2, shx,   shy,   1, 0);
  tmp.inputRow(3, 0,     0,     0, 1);
  
  //println("shear: " + shx + " " + shy);
  return tmp;
}

//TMatrix4 get4Matrix() {
//  TMatrix4 tmp = new TMatrix4();
//  
//  float shzx = -((xwmin + xwmax) / (2 * znear));
//  float shzy = -((ywmin + ywmax) / (2 * znear));
//  
//  tmp.inputRow(0, 1,     0,     0, 0);
//  tmp.inputRow(1, 0,     1,     0, 0);
//  tmp.inputRow(2, shzx,  shzy,  1, 0);
//  tmp.inputRow(3, 0,     0,     0, 1);
//  
//  return tmp;
//}

//TMatrix4 getStep5Matrix() {
//  TMatrix4 tmp = new TMatrix4();
//  
//  float el00 = -2*znear / (xwmax - xwmin);
//  float el11 = -2*znear / (ywmax - ywmin);
//  float el20 = (xwmax + xwmin) / (xwmax - xwmin);
//  float el21 = (ywmax + ywmin) / (ywmax - ywmin);
//  float el22 = (znear + zfar) / (znear - zfar);
//  float el32 = -((2 * znear * zfar) / (znear - zfar));
//  
//  tmp.inputRow(0, el00,  0,     0,    0);
//  tmp.inputRow(1, 0,     el11,  0,    0);
//  tmp.inputRow(2, el20,  el21,  el22, -1);
//  tmp.inputRow(3, 0,     0,     el32, 0);
//  
//  return tmp;
//}

TMatrix4 getStep5Matrix() {
  TMatrix4 tmp = new TMatrix4();
  
  float c = -COP.z + zfar;
  float sx = (2 * -COP.z) / ((xwmax - xwmin) * c);
  float sy = (2 * -COP.z) / ((ywmax - ywmin) * c);
  float sz = -1 / c;
  
  tmp.inputRow(0, sx,  0,  0,    0);
  tmp.inputRow(1, 0,   sy, 0,    0);
  tmp.inputRow(2, 0,   0,  sz,   0);
  tmp.inputRow(3, 0,   0,  0,    1);
  
  //tmp.printIt();
  //println("scale: " + sx + " " + sy + " " + sz);
  
  return tmp;
}

TMatrix4 getStep6Matrix() {
  TMatrix4 tmp = new TMatrix4();

  float c = -COP.z + zfar;
  zmin = -((-COP.z + znear) / c);
  zmax = -1;
  
  tmp.inputRow(0, 1,   0,  0,                  0);
  tmp.inputRow(1, 0,   1,  0,                  0);
  tmp.inputRow(2, 0,   0,  1 / (1 + zmin),    -1);
  tmp.inputRow(3, 0,   0,  -zmin / (1 + zmin), 0);
  
  return tmp;
}
