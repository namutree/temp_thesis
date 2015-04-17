class Quater {
  PVector q01 = new PVector();
  PVector q02 = new PVector();
  PVector q03 = new PVector();
  PVector q04 = new PVector();
  float x, y, w, h;
  int count;

  Quater(float x_, float y_, float w_, float h_, int count_) {
    w = w_;
    h = h_;
    x = x_;
    y = y_;
    count = count_;
    q01 = new PVector(x, y);
    q02 = new PVector(x+w/2, y);
    q03 = new PVector(x, y+h/2);
    q04 = new PVector(x+w/2, y+h/2);
  }

  void display() {
    noFill();
    rect(x, y, w, h);
  }
}

