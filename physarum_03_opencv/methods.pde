void setPhysarums(){
  
  for ( int i = 0; i <= maxPhysarums; i++ ) {      
    
      physarums.add(new Agent(
        starterForm(i), 
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

PVector starterForm(int i){
  
  float x, y ;
   
  if ( startForm == "circle"){
      
    x = (width/2) + ((height / 3) * cos(radians(i))) ;
    y = (height/2) + ((height / 3) * sin(radians(i))) ;
    
  } else if ( startForm == "line"){
      
    float len = height / 2 ;
    x = map(i, 0, maxPhysarums, (width/2) - (len/2), (width/2) + (len/2));
    y = map(i, 0, maxPhysarums, (height/2) - (len/2), (height/2) + (len/2));
    
  } else if ( startForm == "square"){
    
    float len = height / 2 ;
    x = 0;
    y = 0;
    
    if (i < maxPhysarums / 4){
      x = map(i, 0, maxPhysarums/4, (width/2) - (len/2), (width/2) + (len/2));
      y = height/2 - (len/2) ;
    
    }
    if (i < maxPhysarums /2 && i > maxPhysarums / 4){
      x = width/2 + (len/2) ;
      y = map(i, maxPhysarums/4, maxPhysarums/2, (height/2) - (len/2), (height/2) + (len/2));
      
    }
    if (i < maxPhysarums * 3 /4 && i > maxPhysarums / 2){
      x = map(i, maxPhysarums / 2, maxPhysarums * 3 / 4, (width/2) + (len/2), (width/2) - (len/2));
      y = height/2 + (len/2) ;
    }
    if (i > maxPhysarums * 3 /4) {
      x = width/2 - (len/2) ;
      y = map(i, maxPhysarums * 3 / 4, maxPhysarums, (height/2) + (len/2), (height/2) - (len/2));
    }
    
  } else if (startForm == "noisy"){
    
    float g = map(i, 0, maxPhysarums, 0, 1);
    x = width * cos(noise(g));
    y = height * sin(noise(g));
    
  } else {
    x = random(width);
    y = random(height);
  }
  
    return new PVector(x,y);
}
