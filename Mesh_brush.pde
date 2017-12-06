import megamu.mesh.*;
import controlP5.*;
import ddf.minim.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import de.voidplus.leapmotion.*;

int BACKGROUND = 0;
int MAX_POINTS = 500;
float LINE_DISTANCE = 285;
boolean MOUSE_DISABLED = false;

Minim minim;
AudioOutput out;
TickRate rateControl;
FilePlayer filePlayer;
LeapMotion leap;

String songName = "Swallow.wav";

DelaunaySystem system;
ControlP5 cp5;

void setup() {
  //fullScreen();
  //size(2480, 3508);
  size(800, 1131);
  background(BACKGROUND);
  //addControl();
  // TICK RATE VER
  minim = new Minim(this);

  // this opens the file and puts it in the "play" state.                           
  filePlayer = new FilePlayer( minim.loadFileStream(songName) );
  // and then we'll tell the recording to loop indefinitely
  filePlayer.loop();

  // this creates a TickRate UGen with the default playback speed of 1.
  // ie, it will sound as if the file is patched directly to the output
  rateControl = new TickRate(1.f);

  // get a line out from Minim. It's important that the file is the same audio format 
  // as our output (i.e. same sample rate, number of channels, etc).
  out = minim.getLineOut();

  // patch the file player through the TickRate to the output.
  filePlayer.patch(rateControl).patch(out);

  // Leap
  leap = new LeapMotion(this);


  // System declaration and settings
  system = new DelaunaySystem(MAX_POINTS);
  //system.generateRandom();
  system.setStroke(255, 200);
  system.setStrokeWeight(0.01);

}

void draw() {
  //rect(0,0,width/3, height/3);
  //scale(3);
  pushStyle();
  fill(0, 30);
  rect(0, 0, width, height);
  popStyle();
  //background(0);

  for (Hand hand : leap.getHands()) {
    PVector position = hand.getPosition();
    brushOne(30, position.x, position.y);
  }



  system.setLineDistance(LINE_DISTANCE);
  system.render();
  system.move();
}

void mouseDragged() {

  if (MOUSE_DISABLED) return;

  brushOne(BRUSH_OFFSET, mouseX, mouseY);
}

void keyPressed() {
  //system.clear();
  saveFrame("render-####.png");
}

// Offset from mouse position 
float BRUSH_OFFSET = 30;

void brushOne(float offset, float posX, float posY) {
  float x = posX + random(-offset, offset);
  float y = posY + random(-offset, offset);

  system.addPoint(x, y);
  float rate = map(system.getMeanX(), 0, width, 0.0f, 1.f);
  rateControl.value.setLastValue(rate);
}

public void sliderA(int value) {
  LINE_DISTANCE = value;
}

void addControl() {
  // GUI
  cp5 = new ControlP5(this);

  // create a slider
  // parameters:
  // name, minValue, maxValue, defaultValue, x, y, width, height
  cp5.addSlider("sliderA", 0, 500, LINE_DISTANCE, 5, 100, 200, 40);

  cp5.addToggle("MOUSE_DISABLED")          
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorBackground(color(255, 0, 0));
}