import megamu.mesh.*;
import controlP5.*;

int BACKGROUND = 0;
int MAX_POINTS = 200;
float LINE_DISTANCE = 100;
boolean MOUSE_DISABLED = false;

DelaunaySystem system;
ControlP5 cp5;

void setup() {
  size(800, 800);
  background(BACKGROUND);

  // GUI
  cp5 = new ControlP5(this);

  // create a slider
  // parameters:
  // name, minValue, maxValue, defaultValue, x, y, width, height
  cp5.addSlider("sliderA", 0, 500, LINE_DISTANCE, 5, 100, 200, 40);
  
  cp5.addToggle("MOUSE_DISABLED")          .setColorValue(color(255))
            .setColorActive(color(155))
                .setColorBackground(color(255, 0, 0));

  // System declaration and settings
  system = new DelaunaySystem(MAX_POINTS);
  system.setStroke(255);
  system.setStrokeWeight(0.9);
}

void draw() {
  background(0);
  system.setLineDistance(LINE_DISTANCE);
  system.render();
  system.move();
}

void mouseDragged() {
  
  if (MOUSE_DISABLED) return;
  
  brushOne(BRUSH_OFFSET);
}

void keyPressed() {
  MOUSE_DISABLED = !MOUSE_DISABLED;
}

// Offset from mouse position 
float BRUSH_OFFSET = 30;

void brushOne(float offset) {
  float x = mouseX + random(-offset, offset);
  float y = mouseY + random(-offset, offset);
  system.addPoint(x, y);
}

public void sliderA(int value) {
  LINE_DISTANCE = value;
}