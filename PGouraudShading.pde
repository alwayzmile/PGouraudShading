import controlP5.*;

Vector DOP = new Vector(0, 0, -1);
Vertex COP = new Vertex(0, 0, 5);
Vertex lightPos2 = new Vertex(10, (-10 * -1), 10);
boolean isLight2Active = false,
        ctrlPressed = false;
LightSources lights;
TriangleStrip ts;
int optWidth = 200;
float transX = 0,
      transY = 0,
      transZ = 0;

void setup() {
  frame.setTitle("PGouraudShading : Gouraud Shading Implementation");
  
  size(600, 380, OPENGL);
  background(#3D4C53);
  
  // as canvas
  fill(#EEF3F6);
  noStroke();
  rect(0, 0, width-optWidth, height);
  
  lights = new LightSources(new Vertex(-10, (-10 * -1), 10), // light1Pos
                            #2772B2, #ffffff,                // objectCol, lightCol
                            0.7, 0.9, 0.8, 5);               // coefAmbient, coefDiffuse, coefSpecular, specularExponent
  
  ts = sphere(5, 32, 1);
  ts.draw();
  optionPanel();
}

void draw(){}
