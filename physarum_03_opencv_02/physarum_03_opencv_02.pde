import gab.opencv.*;
import processing.video.*;

import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import gab.opencv.*;
import processing.video.*;

PostFX fx;



PVector center;


PGraphics ocvTemp ;

float ratio = 0.5;
float intensity = 4;
int maxPhysarums = 25000 ;
ArrayList<Agent> physarums = new ArrayList<Agent>();

Capture cam;

OpenCV opencv;

int steps = 5; // becarefull you can't get a region out of scope
float scale = 2.7;



float h = 0;


void setup() {
  fullScreen(P2D);
  colorMode(HSB, 360, 100, 100);

  String[] cameras = Capture.list();
  printArray(cameras);
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
  ocvTemp = createGraphics(640, 480, P2D);
  scale = width/640;
  println(cam.width, cam.height, scale);
  background(0);
  fx = new PostFX(this);
}

void draw() {

  if (cam.available() == true) {
    cam.read();
    captFlow();
    
    if (opencv.getAverageFlow().mag() > 2){
      
      for (int i = steps; i <= cam.width-steps; i += steps) {
        for (int j = steps; j <= cam.height-steps; j += steps) {
          PVector p = opencv.getAverageFlowInRegion(i, j, steps, steps);
          noStroke();
          if (p.mag() > 5 && physarums.size()< maxPhysarums) {
            physarums.add(new Agent(
              new PVector(i*scale, j*scale), 
              random(TWO_PI), 
              color(255)
              ));
            Agent a = physarums.get( int(random(physarums.size() - 1)) );
            //a.recycle = true ;
            a.flowPos.set(p.x * scale, p.y * scale );
          }
        }
      }
      
    }
  }
  if (frameCount%10 ==0) println(physarums.size(), frameRate);

  pushStyle();
  noStroke();
  fill(0, 15);
  rect(0, 0, width, height);
  popStyle();

  run();
  render();

  // -5- diffuse
  fx.render()

    .blur(
    round(map(ratio, 0, 1, 0, intensity)), 
    map(ratio, 1, 0, 0, intensity)
    )
    .bloom(0.7, 20, 40)
    .compose();
}


void captFlow() {
/*  ocvTemp.beginDraw();
  ocvTemp.set(0, 0, cam);
  ocvTemp.endDraw();
  ocvTemp.filter(OPAQUE);
  */
  //if (frameCount % 20 == 0) {
    set(0, 0, cam);  
    opencv.loadImage(cam);
    
    opencv.flip(1);
    opencv.calculateOpticalFlow();
    
    
  //}
}


void movieEvent(Movie m) {
  m.read();
}
