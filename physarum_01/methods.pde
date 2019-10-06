void setPhysarums(){
  
  for ( float i = 0; i <= maxPhysarums; ++i ) {      
      physarums.add(new Agent(
        new PVector(random(width), random(height)), 
        random(TWO_PI),
        color(255)
        ));
    }
}

void run(){
   for ( Agent phy : physarums ) {
    phy.update();
  } 
  
  pushStyle(); 
    for ( Agent phy : physarums ) {
      phy.render();
    }
  popStyle();
}

////////////* screen capture & video *///////////////
  
void screenshot() {
  save("data/img/physarum-#######" + ".png");
}

void record() {
  if ( recording ) {
    saveFrame("data/movie/physarum-#####.tif");
  }
}

void reset(){
  for ( Agent phy : physarums ) {
    phy.pos.set(random(width), random(height));
  } 
}
