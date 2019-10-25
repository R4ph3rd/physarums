import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import gab.opencv.*;
import processing.video.*;

PostFX fx;

PVector center;

ArrayList<Agent> physarums = new ArrayList<Agent>();

float ratio = 0.5;
float intensity = 4;
int maxPhysarums = 50000 ;

boolean recording = false;

String startForm = "circle";

Capture cam;
OpenCV opencv;

int steps = 40; // becarefull you can't get a region out of scope
float scale = 2.7;

void setup() {
  fullScreen(P2D);
  frameRate(60);
  smooth(8);
  background(0);
  
  //pixelDensity(displayDensity());
  
  
  stroke(255);
  strokeWeight(1.0);

  center = new PVector(width/2, height/2);
  fx = new PostFX(this);
  
  String[] cameras = Capture.list();
  
  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
  
  opencv = new OpenCV(this, 640, 480);
  
  setPhysarums();
  
  scale = width / 640 ;

  background(0);
}

void draw() {
  
  set(0, 0, cam); 
  
  if (cam.available() == true) {
    cam.read();

    opencv.loadImage(cam);
    opencv.flip(1);
    opencv.calculateOpticalFlow();
    //PVector maxPoint = opencv.max();
    
    
    pushMatrix();
    for (int i = 0; i < cam.width; i += steps) {
      for (int j = 0; j < cam.height; j += steps) {
        PVector p = opencv.getTotalFlowInRegion(i, j, steps, steps);
        noStroke();
        if (p.mag() > 1000) {
          Agent a = physarums.get( int(random(physarums.size() - 1)) );
          a.recycle = true ;
          a.flowPos.set(i * scale, j * scale );
          fill(255, 0 ,0);
          rect(i * scale,j * scale, steps ,steps );
        }
      }
    }
    popMatrix();
  }
    
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
  
  if ( key == TAB){
    background(0);
    physarums.clear();
    setPhysarums();
  }
}
