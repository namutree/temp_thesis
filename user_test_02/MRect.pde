class MRect {
  float x1, y1, x2, y2;
  MRect(){
   x1 = 0;
   x2 = 0;
   y1 = 0;
   y2 = 0; 
  }
  void update() {
  }

  void render() {
    fill(255,0,0, 100); 
    stroke(255,0,0);
    float ww = x2-x1;
    float hh = y2-y1;
    rect(x1, y1, ww, hh);
  }
}

