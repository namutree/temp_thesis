Table table;
PImage[] testImg = new PImage[500]; 
PImage img;


void setup() {
  size(500, 500);

  //no, id,lat,lon,url,created_time,tags,state,city,sd,go
  table = loadTable("../../data/usa_10_total.csv", "header");

  for (int i =0; i<testImg.length; i++) {
    testImg[i] =  loadImage("../../data/img/"+str(table.getInt((int)random(10000), "no"))+".jpg");
  }

  img = loadImage("../../data/img/"+str(table.getInt((int)random(100, 150), "no"))+".jpg");

  for (int i=0; i<img.width; i++) {
    for (int j=0; j<img.height; j++) {
      int loc = i + j*img.height;

      float r =0;
      float g =0;
      float b =0;

        for (int x =0; x<testImg.length; x++) {
          r += red(testImg[x].pixels[loc]);
          g += green(testImg[x].pixels[loc]);
          b += blue(testImg[x].pixels[loc]);
        }
      r = r/testImg.length;
      g = g/testImg.length;
      b = b/testImg.length;

      color abc = color(r, g, b);
      img.set(i, j, abc);
    }
  }
}


void draw() {
  background(255);
 

  image(img, img.width, img.height+20);
}

void mouseClicked() {
  save("../../data/test"+str((int)random(100))+".jpg");
}

