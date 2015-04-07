Table table;
PImage img;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../data/geotest_ny.csv");
  img = loadImage("../data/myMap.png");
    size(img.width, img.height);
  //   x= 25.5  ~ 26.22
  //   y= -80.3 ~ -69.49
  int count=0;
  float[] lat = new float[table.getRowCount()];
  float[] lon = new float[table.getRowCount()];
  for (TableRow xx : table.rows ()) {
    lat[count] = xx.getFloat(0);
    lon[count] = xx.getFloat(1); 
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
  image(img,0,0);
  for ( TableRow xx : table.rows ()) {
    float x = map(xx.getFloat(0), latMin, latMax, 0, width);
    float y = map(xx.getFloat(1), lonMin, lonMax, height,0);

    noStroke();
    fill(0);
    ellipse(x, y, 3, 3);
    ccc++;
  }
  println(ccc);
  noLoop();
}

