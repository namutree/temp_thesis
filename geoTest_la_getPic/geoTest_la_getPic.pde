Table table;
PImage img;
int count;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../data/geotest_lowNy.csv", "header");
  img = loadImage("../data/myMap_la.png");
  size(5, 5);
  // 34.327265, -118.691884
  // 33.648624, -117.466908
  
  count =3496;
}



void draw() {
  background(255);

  TableRow row = table.getRow(count);
  try {
    img = loadImage(row.getString("url"));
    img.resize(5, 5);
  }
  catch(Exception e) {
    println(e);
  }
  image(img,0,0);
  save("../data/lowNy_pic/"+str(count)+".jpg");
  if (count > table.getRowCount()) noLoop();
  count++;
  println(count);
}

