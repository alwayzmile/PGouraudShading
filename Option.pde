// void optionPanel()
// void makeEditable()
// class NumberboxInput
// void resetOption()

void optionPanel() {
  ControlP5 cp5 = new ControlP5(this);
  Numberbox n;
  
  //=================================================================
  cp5.addTextlabel("lblLightPosition")
     .setText("LIGHT SOURCE POSITION :")
     .setPosition(405, 15)
     .setColorValue(255);
    
  n = cp5.addNumberbox("change_x_light")
     .setPosition(410, 30)
     .setSize(50, 20)
     .setScrollSensitivity(1)
     .setValue(-10)
     .setLabel("X");
  makeEditable(n);
    
  n = cp5.addNumberbox("change_y_light")
     .setPosition(470, 30)
     .setSize(50, 20)
     .setScrollSensitivity(1)
     .setValue(-10)
     .setLabel("Y");
  makeEditable(n);
    
  n = cp5.addNumberbox("change_z_light")
     .setPosition(530, 30)
     .setSize(50, 20)
     .setScrollSensitivity(1)
     .setValue(10)
     .setLabel("Z");
  makeEditable(n);
  
  //=================================================================
  cp5.addTextlabel("lblLightPosition2")
     .setText("LIGHT SOURCE 2 POSITION :")
     .setPosition(405, 85)
     .setColorValue(255);
     
  cp5.addCheckBox("activate_second_light")
     .setPosition(530, 84)
     .setSize(11, 11)
     .addItem("Activate", 0);
    
  n = cp5.addNumberbox("change_x_light2")
     .setPosition(410, 100)
     .setSize(50, 20)
     .setScrollSensitivity(1)
     .setValue(10)
     .setLabel("X");
  makeEditable(n);
    
  n = cp5.addNumberbox("change_y_light2")
     .setPosition(470, 100)
     .setSize(50, 20)
     .setScrollSensitivity(1)
     .setValue(-10)
     .setLabel("Y");
  makeEditable(n);
    
  n = cp5.addNumberbox("change_z_light2")
     .setPosition(530, 100)
     .setSize(50, 20)
     .setScrollSensitivity(1)
     .setValue(10)
     .setLabel("Z");
  makeEditable(n);
  
  //=================================================================
  cp5.addTextlabel("lblCoefficient")
     .setText("COEFFICIENT :")
     .setPosition(405, 155)
     .setColorValue(255);
    
  n = cp5.addNumberbox("change_ka")
     .setPosition(410, 170)
     .setSize(50, 20)
     .setScrollSensitivity(0.10)
     .setValue(0.70)
     .setRange(0, 1)
     .setLabel("Ambient");
  makeEditable(n);
    
  n = cp5.addNumberbox("change_kd")
     .setPosition(470, 170)
     .setSize(50, 20)
     .setScrollSensitivity(0.10)
     .setValue(0.90)
     .setRange(0, 1)
     .setLabel("Diffuse");
  makeEditable(n);
    
  n = cp5.addNumberbox("change_ks")
     .setPosition(530, 170)
     .setSize(50, 20)
     .setScrollSensitivity(0.10)
     .setValue(0.80)
     .setRange(0, 1)
     .setLabel("Specular");
  makeEditable(n);
  
  //=================================================================
  cp5.addTextlabel("lblSpecExp")
     .setText("SPECULAR EXPONENT :")
     .setPosition(405, 225)
     .setColorValue(255);
    
  n = cp5.addNumberbox("change_spec_exp")
     .setPosition(530, 220)
     .setSize(50, 20)
     .setScrollSensitivity(2)
     .setValue(5)
     .setMin(1)
     .setLabel("");
  
  //=================================================================
  cp5.addTextlabel("lblCenterSphere")
     .setText("TRANSLATE SPHERE BY :")
     .setPosition(405, 260)
     .setColorValue(255);
    
  n = cp5.addNumberbox("transx_sphere")
     .setPosition(410, 275)
     .setSize(50, 20)
     .setScrollSensitivity(0.05)
     .setValue(0)
     .setLabel("X");
  makeEditable(n);
    
  n = cp5.addNumberbox("transy_sphere")
     .setPosition(470, 275)
     .setSize(50, 20)
     .setScrollSensitivity(0.05)
     .setValue(0)
     .setLabel("Y");
  makeEditable(n);
    
  n = cp5.addNumberbox("transz_sphere")
     .setPosition(530, 275)
     .setSize(50, 20)
     .setScrollSensitivity(0.05)
     .setValue(0)
     .setLabel("Z");
  makeEditable(n);
  
  //=================================================================     
  cp5.addCheckBox("use_flat_shading")
     .setPosition(410, 320)
     .setSize(11, 11)
     .addItem("Use flat shading", 0);
     
  //=================================================================      
  cp5.addButton("reset")
     .setPosition(410, 345)
     .setSize(80,19)
     .setLabel("RESET")
     .setValue(0);
}

void makeEditable(Numberbox n) {
  // allows the user to click a numberbox and type in a number which is confirmed with RETURN

  final NumberboxInput nin = new NumberboxInput( n ); // custom input handler for the numberbox
  
  // control the active-status of the input handler when releasing the mouse button inside 
  // the numberbox. deactivate input handler when mouse leaves.
  n.onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      nin.setActive(true); 
    }
  }
  ).onLeave(new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      nin.setActive(false); nin.submit();
    }
  });
}

// input handler for a Numberbox that allows the user to 
// key in numbers with the keyboard to change the value of the numberbox
public class NumberboxInput {
  String text = "";
  Numberbox n;
  boolean active;

  NumberboxInput(Numberbox theNumberbox) {
    n = theNumberbox;
    registerMethod("keyEvent", this );
  }

  public void keyEvent(KeyEvent k) {
    // only process key event if input is active 
    if (k.getAction()==KeyEvent.PRESS && active) {
      if (k.getKey()=='\n') { // confirm input with enter          
        submit();
        return;
      } else if(k.getKeyCode()==BACKSPACE) { 
        text = text.isEmpty() ? "":text.substring(0, text.length()-1);
        //text = ""; // clear all text with backspace
      }
      else if (k.getKey()<255) {
        // check if the input is a valid (decimal) number
        final String regex = "-??\\d+([.]\\d{0,2})?";
        final String regex2 = "-";
        String s = text + k.getKey();
        if ( java.util.regex.Pattern.matches(regex, s) || java.util.regex.Pattern.matches(regex2, s) ) {
          text += k.getKey();
        }
      }
      n.getValueLabel().setText(this.text);
    }
  }

  public void setActive(boolean b) {
    active = b;
    if (active) {
      n.getValueLabel().setText("");
      text = ""; 
    }
  }
  
  public void submit() {
    if (!text.isEmpty()) {
      if (text.equals("-"))
        text = "-0";
        
      n.setValue(float(text));
      text = "";
    } else {
      float val = n.getValue();
      n.getValueLabel().setText(String.format("%.2f", val));
    }
  }
}

void resetOption() {
  isLight2Active = false;
  transX = 0;
  transY = 0;
  transZ = 0;
  lights = new LightSources(new Vertex(-10, (-10 * -1), 10), // light1Pos
                            #2772B2, #ffffff,                // objectCol, lightCol
                            0.7, 0.9, 0.8, 5);               // coefAmbient, coefDiffuse, coefSpecular, specularExponent
  ts = sphere(5, 32, 1);
  ts.isFlat = false;

  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  ts.draw();
  
  fill(#3D4C53);
  noStroke();
  rect(width-optWidth, 0, width-optWidth, height);
  optionPanel();
}
