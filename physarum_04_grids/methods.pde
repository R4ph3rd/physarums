void setPhysarums(){
  
  int stepX = int(width/ nb_lines);
  
  for ( int x = 0; x <= width; x+= stepX ) {    
    
    for (int y = 0; y < height ; y ++){
    
      for (int k = 0; k < 6 ; k ++){
      physarums.add(new Agent(
        new PVector(x,y), 
        random(TWO_PI),
        color(255)
        ));
      }
    }
  }
  
  println(physarums.size());
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
  save("data/img/physarum-#" + frameCount + random(76798653) + ".png");
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
