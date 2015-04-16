Table table;
Table hueTable;
PImage img;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../../../data/ny/usa_ny.csv", "header");
  hueTable = new Table();
  hueTable.addColumn("id");
  hueTable.addColumn("lat");
  hueTable.addColumn("lon");
  for (int i=0; i<256; i++) {
    hueTable.addColumn(str(i));
  }

  img = new PImage();

  size(200, 200);
}

void draw() {
  background(255);
  for (TableRow t : table.rows ()) {
    int id = t.getInt("id"); 
    String url = t.getString("url"); 
    float lat = t.getFloat("lat"); //y
    float lon = t.getFloat("lon"); //x

    try {
      img = loadImage(url);
      img.resize(200, 200);
    }
    catch(Exception e) {
      println(e);
      img = loadImage("../../../data/ny/white_back.jpg");
      img.resize(200, 200);
    }

    TableRow newRow = hueTable.addRow();
    newRow.setInt("id", id);
    newRow.setFloat("lat", lat);
    newRow.setFloat("lon", lon);

//hue set up
    int[] hueHist = new int[256];
    for (int a = 0; a < img.width; a++) {
      for (int b = 0; b < img.height; b++) {
        int loc = a + b*img.width;
        //if it is grey than donot count
        if (red(img.pixels[loc]) == blue(img.pixels[loc]) && blue(img.pixels[loc]) == green(img.pixels[loc])) continue;

        int hueY = int(hue(img.pixels[loc]));
        hueHist[hueY]++;
      }
    }

    for (int a=0; a<256; a++) {
      newRow.setInt(str(a), hueHist[a]);
    }


    if (id%100 ==0 ) println(id+" / "+table.getRowCount());
  }
  saveTable(hueTable, "../../../data/ny/hueTable.csv");
  
  println("done"); 
  noLoop();
}

