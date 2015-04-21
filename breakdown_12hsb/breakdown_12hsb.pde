Table table;
PImage img, img2;


void setup() {
  
  img = loadImage("data/newyork.jpg");
  img2 = loadImage("data/newyork.jpg");
  table = new Table();
  size(img.width*2, img.height);
}
//  0   1   2   3   4            5
//  id, lat,lon,url,created_time,tags
void draw() {
  colorMode(RGB, 255);
  background(255);
  colorMode(HSB, 12, 12, 12);

  int[] h = new int[img.width * img.height];
  int[] s = new int[img.width * img.height];
  int[] b = new int[img.width * img.height];

  for (int i = 0; i<img.width * img.height; i++) {
    h[i] = int(hue(img.pixels[i]));
    s[i] = int(saturation(img.pixels[i]));
    b[i] = int(brightness(img.pixels[i]));
    //print(h[i]+", ");
  }

  loadPixels();
  for (int i = 0; i<img.width * img.height; i++) {
    color cc = color(h[i], s[i], b[i]);
    img2.pixels[i] = cc;
  }
  updatePixels();

  colorMode(RGB, 255);
  image(img, 0, 0);
  image(img2, img.width,0);
  noLoop();
}

