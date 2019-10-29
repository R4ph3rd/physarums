float turnAngle = PI/8;
float t = 0 ;

int sense(float heading, PVector pos, float len, float angle) {

  float ang = angle + heading;

  PVector target = new PVector(cos(ang)*len, sin(ang)*len).add(pos);

  color c = get( int(target.x), int(target.y)  );
 /* loadPixels();
  if (target.x  < 0 || target.y < 0 ) println("under 0", target) ;
  color c = pixels[int(target.y * width + target.x)] ;
  */
  float b = max( red(c), green(c), blue(c) );
  //println("c", max(red(c), green(c), blue(c)), c);
  // divided on three thirds, returns 0 if it's dark, 1 if it's medium, and 2 for bright
  
  if ( b > 255 / 3 ) return 1 ;
  else if ( b > ( 255 * 2) / 3) return 2;
  else return 0 ;
  
  //return b > 255 / 3 ? 1 : b > (255 * 2) / 3 ? 2 : 0;
}


boolean m_b (int i) {
  return (i == 1 || i == 2);
}

boolean d(int i){
  return ( i == 0);
}


float setAngle(Agent a) {
  int[] res = new int[3];

  res[0] = sense(a.heading, a.pos, a.sensorDist, -a.sensorAngle);
  res[1] = sense(a.heading, a.pos, a.sensorDist, 0);
  res[2] = sense(a.heading, a.pos, a.sensorDist, a.sensorAngle);

 
  a.nextStep = a.step;

  // turn randomly
  if ( m_b(res[0]) && d(res[1]) && m_b(res[2]) ) {
    return random(1) > 0.5 ? turnAngle : -turnAngle;
  }
  
  // turn left
  else if ( m_b(res[0]) && d(res[2]) ) {
    return -turnAngle;
  }

  // turn right
  else if ( d(res[0]) && m_b(res[2]) ) {
    return turnAngle;
  }

  else {
    return 0.005; // .05 
  }
}

void headingSensors( Agent a){
  a.heading += setAngle(a) ;
}
