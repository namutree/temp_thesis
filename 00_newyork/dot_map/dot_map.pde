Table table;
PImage pImg;
PImage maskImage;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../../../data/ny/usa_ny_wo_tagNurl.csv", "header");
  pImg = loadImage("../../../data/ny/point.png");
  

  //# ny
  //# lat 40.903939, lon -73.694036 
  //# lat 40.481192, lon -74.280432

  latMax= 40.903939;
  latMin= 40.481192;
  lonMax= -73.694036;
  lonMin= -74.280432;

  float w = (lonMax - lonMin)*1110*3;
  float h = (latMax - latMin)*1110*3;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);
}

void draw() {

  background(0);
  for (TableRow t : table.rows ()) {
    float lat = t.getFloat("lat"); //y
    float lon = t.getFloat("lon"); //x
    lat = map(lat, latMin, latMax, height, 0);
    lon = map(lon, lonMin, lonMax, 0, width);

    noStroke();
    fill(255, 20);
    pushMatrix();
    {
      translate(lon+random(-2, 2), lat+random(-2, 2));
      //ellipse(0, 0, 5, 5);
      tint(255,100);
      image(pImg, 0, 0);
    }
    popMatrix();
  }
  save("../../../data/ny/map_dot.jpg");
  println("done"); 
  noLoop();
}

