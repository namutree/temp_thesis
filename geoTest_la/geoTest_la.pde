Table table;
PImage img;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../data/geotest_lowNy.csv", "header");
  img = loadImage("../data/myMap_lowNy.png");
  size(img.width, img.height);
//# lower ny
//41.01052, -73.53637
//40.522667, -74.177025
  int count=0;
  float[] lat = new float[table.getRowCount()];
  float[] lon = new float[table.getRowCount()];
  for (TableRow xx : table.rows ()) {
    lat[count] = xx.getFloat("lat");
    lon[count] = xx.getFloat("lon"); 
    count++;
  }
  latMax = max(lat);
  latMin = min(lat);
  lonMax = max(lon);
  lonMin = min(lon);
  println(latMax);
  println(latMin);
  println(lonMax);
  println(lonMin);
}

void draw() {
  int ccc =0;
  background(255);
  image(img, 0, 0);
  for ( TableRow xx : table.rows ()) {

    float x = map(xx.getFloat("lat"), latMin, latMax, width, 0);
    float y = map(xx.getFloat("lon"), lonMin, lonMax, 0, height);
    PImage img;
    img = loadImage("../data/lowNy_pic/"+str(ccc)+".jpg");
    img.resize(2, 2);

    noStroke();
        fill(255,0,0);
        ellipse(x, y, 3, 3);
    //image(img, x, y);
    ccc++;
    if ((ccc%100) == 5) println(ccc);
  }
  println(ccc);
  save("maps1a.jpg");
  noLoop();
}

