

void run() {
  for ( int i = 0; i < physarums.size(); i++) {
    Agent phy = physarums.get(i);
    if (phy.life < 0 || phy.outOfBound()) {
      physarums.remove(i);
    }
    phy.update();
  }
}
void render() {
  pushStyle();
  for ( int i = 0; i < physarums.size(); i++) {
    Agent phy = physarums.get(i);
    phy.render();
  }
  popStyle();
}

void reset() {
  for ( Agent phy : physarums ) {
    phy.pos.set(random(width), random(height));
  }
}
