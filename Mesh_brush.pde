import megamu.mesh.*;
import controlP5.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int BACKGROUND = 0;
int MAX_POINTS = 400;
float LINE_DISTANCE = 100;
boolean MOUSE_DISABLED = false;

Minim minim;
AudioOutput out;
NoiseInstrument noise;
TickRate rateControl;
FilePlayer filePlayer;

String songName = "mans.mp3";

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

  cp5.addToggle("MOUSE_DISABLED")          
    .setColorValue(color(255))
    .setColorActive(color(155))
    .setColorBackground(color(255, 0, 0));

  // NOISE VER
  //minim = new Minim(this);
  //out = minim.getLineOut(Minim.MONO, 512);
  //noise = new NoiseInstrument(1.0, out);
  //out.playNote(0, 100.0, noise);

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


  // System declaration and settings
  system = new DelaunaySystem(MAX_POINTS);
  //system.generateRandom();
  system.setStroke(255, 200);
  system.setStrokeWeight(0.01);
  smooth();
}

void draw() {
  pushStyle();
  fill(0, 30);
  rect(0, 0, width, height);
  popStyle();
  //background(0);
  system.setLineDistance(LINE_DISTANCE);
  system.render();
  system.move();

}

void mouseDragged() {

  if (MOUSE_DISABLED) return;

  brushOne(BRUSH_OFFSET);
  //map the position of the mouse to useful values
  //float freq = map( system.getMeanX(), 0, width, 100, 150 );
  //float q = map( system.getMeanY(), 0, height, 0.9, 100 );
  //// and call the methods of the instrument to change the sound
  //noise.setFilterCF( freq );
  //noise.setFilterQ( q );
    float rate = map(system.getMeanX(), 0, width, 0.0f, 1.f);
  rateControl.value.setLastValue(rate);
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