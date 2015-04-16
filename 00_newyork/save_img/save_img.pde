Table table;
PImage img;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../../../data/ny/usa_ny.csv", "header");
  img = new PImage();

  size(50, 50);
}

void draw() {

  background(0);
  for (TableRow t : table.rows ()) {
    int id = t.getInt("id"); 
    if(id<69000) continue;
    String url = t.getString("url"); 

    try {
      img = loadImage(url);
      img.resize(50, 50);
    }
    catch(Exception e) {
      println(e);
      img = loadImage("../../../data/ny/white_back.jpg");
      img.resize(50, 50);
    }
    img.save("../../../data/ny/img/"+str(id)+".jpg");

    if (id%100 ==0 ) println(id+" / "+table.getRowCount());
  }
  println("done"); 
  noLoop();
}

