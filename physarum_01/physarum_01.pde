import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

PVector center;

ArrayList<Agent> physarums = new ArrayList<Agent>();

float ratio = 0.5;
float intensity = 10;
int maxPhysarums = 50000 ;

boolean recording = false;

void setup() {
  size(1600, 900, P3D);
  frameRate(60);
  smooth(8);
  background(0);
  
  
  stroke(255);
  strokeWeight(1.0);

  center = new PVector(width/2, height/2);
  fx = new PostFX(this);
  
  setPhysarums();

  background(0);
}

void draw() {
  run();

  // -5- diffuse
  fx.render()
    .blur(
    round(map(ratio, 0, 1, 0, intensity)), 
    map(ratio, 1, 0, 0, intensity)
    )
    .compose();

  // -6- Decay
  pushStyle();
    noStroke();
    fill(0, 15);
    rect(0, 0, width, height);
  popStyle();

  record();
}

void keyPressed() {
  if ( key == 's' ) {
    screenshot();
  }

  if ( key == 'r' ) {
    recording = !recording;
  }
  
  if (key == ENTER ) {
    reset();
  }
}
