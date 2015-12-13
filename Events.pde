void change_x_light(float x) {
  lights.positions.get(0).x = x;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void change_y_light(float y) {
  lights.positions.get(0).y = -y;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void change_z_light(float z) {
  lights.positions.get(0).z = z;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void change_x_light2(float x) {
  lightPos2.x = x;
  
  if (isLight2Active) {
    fill(#EEF3F6);
    noStroke();
    rect(0, 0, width-optWidth, height);
    ts.draw();
    
    fill(#3D4C53);
    noStroke();
    rect(width-optWidth, 0, width-optWidth, height);
  }
}

void change_y_light2(float y) {
  lightPos2.y = -y;
  
  if (isLight2Active) {
    fill(#EEF3F6);
    noStroke();
    rect(0, 0, width-optWidth, height);
    ts.draw();
    
    fill(#3D4C53);
    noStroke();
    rect(width-optWidth, 0, width-optWidth, height);
  }
}

void change_z_light2(float z) {
  lightPos2.z = z;
  
  if (isLight2Active) {
    fill(#EEF3F6);
    noStroke();
    rect(0, 0, width-optWidth, height);
    ts.draw();
    
    fill(#3D4C53);
    noStroke();
    rect(width-optWidth, 0, width-optWidth, height);
  }
}

void activate_second_light(float[] v) {
  if (v[0] == 1) {
    lights.positions.add(lightPos2);
    isLight2Active = true;
  } else {
    lights.positions.remove(1);
    isLight2Active = false;
  }
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void change_ka(float k) {
  lights.ka = k;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void change_kd(float k) {
  lights.kd = k;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void change_ks(float k) {
  lights.ks = k;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void change_spec_exp(int n) {
  lights.specularExp = n;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void transx_sphere(float x) {
  ts.trans(x-transX, 0, 0);
  transX = x;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void transy_sphere(float y) {
  ts.trans(0, -y-transY, 0);
  transY = -y;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void transz_sphere(float z) {
  ts.trans(0, 0, z-transZ);
  transZ = z;
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

void use_flat_shading(float[] v) {
  if (v[0] == 1) {
    ts.isFlat = true;
  } else {
    ts.isFlat = false;
  }
  
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
}

//void keyPressed() {
  /*
  if (key == 'x' || key == 'X') {
    ts.rotX(3);
  
    fill(#EEF3F6);
    noStroke();
    rect(0, 0, width-optWidth, height);
    ts.draw();
    
    fill(#3D4C53);
    noStroke();
    rect(width-optWidth, 0, width-optWidth, height);
  } else if (key == 'y' || key == 'Y') {
    ts.rotY(3);
  
    fill(#EEF3F6);
    noStroke();
    rect(0, 0, width-optWidth, height);
    ts.draw();
    
    fill(#3D4C53);
    noStroke();
    rect(width-optWidth, 0, width-optWidth, height);
  } else if (key == 'z' || key == 'Z') {
    ts.rotZ(3);
  
    fill(#EEF3F6);
    noStroke();
    rect(0, 0, width-optWidth, height);
    ts.draw();
    
    fill(#3D4C53);
    noStroke();
    rect(width-optWidth, 0, width-optWidth, height);
  } else if (key == CODED) {
    if (keyCode == UP) {
      ts.trans(0, -0.05, 0);
  
      fill(#EEF3F6);
      noStroke();
      rect(0, 0, width-optWidth, height);
      ts.draw();
      
      fill(#3D4C53);
      noStroke();
      rect(width-optWidth, 0, width-optWidth, height);
    } else if (keyCode == DOWN) {
      ts.trans(0, 0.05, 0);
  
      fill(#EEF3F6);
      noStroke();
      rect(0, 0, width-optWidth, height);
      ts.draw();
      
      fill(#3D4C53);
      noStroke();
      rect(width-optWidth, 0, width-optWidth, height);
    } else if (keyCode == LEFT) {
      ts.trans(-0.05, 0, 0);
  
      fill(#EEF3F6);
      noStroke();
      rect(0, 0, width-optWidth, height);
      ts.draw();
      
      fill(#3D4C53);
      noStroke();
      rect(width-optWidth, 0, width-optWidth, height);
    } else if (keyCode == RIGHT) {
      ts.trans(0.05, 0, 0);
  
      fill(#EEF3F6);
      noStroke();
      rect(0, 0, width-optWidth, height);
      ts.draw();
      
      fill(#3D4C53);
      noStroke();
      rect(width-optWidth, 0, width-optWidth, height);
    }
  }
  */
//}

void keyPressed() {
  if ( keyCode == CONTROL ) {
    ctrlPressed = true;
  }
  
  if ( char(keyCode)=='R' && ctrlPressed ) {
    // RESET
    resetOption();
  }
}

void keyReleased() {
  if ( keyCode == CONTROL ) {
    ctrlPressed = false;
  }
}

void mouseClicked() {
  if (mouseX >= 410 && mouseX < 490 && mouseY >= 345 && mouseY < 364) {
    resetOption();
  }
}
