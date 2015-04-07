Table table;
PImage img;
Table gridTable;

float latMax, latMin, lonMax, lonMin;
int count;
int wCount, hCount;

void setup() {

  count=0;
  table = loadTable("../../data/usa_10_total.csv", "header");

  //# USA
  //# 49.265911, -125.517483
  //# 26.743020, -64.872955
  //  #revised USA
  //# 49.265911, -125.517483
  //# 24.584452, -64.872955

  latMax= 49.265911;
  latMin= 24.584452;
  lonMax= -64.872955;
  lonMin= -125.517483;

  float w = (lonMax - lonMin)*1110/5.5/5;
  float h = (latMax - latMin)*1110/4/5;

  size((int)w, (int)h);
  //size(30, 30);
  println("w:", w, ", h:", h);
  wCount = int(w/10);
  hCount = int(h/10);
  println("x:", wCount, ", y:", hCount);

  gridTable = new Table();
  gridTable.addColumn("id");
  gridTable.addColumn("x");
  gridTable.addColumn("y");
  for (int i=0; i <256; i++) {
    gridTable.addColumn(str(i));
  }
}
//  0   1   2   3   4            5
//  id, lat,lon,url,created_time,tags
void draw() {
  background(255);

  for (TableRow i : table.rows ()) {
    //if (i.getFloat("go") ==0) continue; // if nogo, don't count
    float lat = i.getFloat("lat"); //y
    float lon = i.getFloat("lon"); //x
    lat = map(lat, latMin, latMax, height, 0); 
    lon = map(lon, lonMin, lonMax, 0, width); 

    TableRow newRow = gridTable.addRow();

    for (int x =0; x < wCount+1; x++) {
      for (int y =0; y < hCount+1; y++) {
        if ( lon >= x*10 && lon < (x+1)*10 && lat >= y*10 && lat < (y+1)*10) {
          newRow.setInt("id", i.getInt("no"));
          newRow.setInt("x", x);
          newRow.setInt("y", y);
        }
      }
    }
    img = loadImage("../../data/img/"+i.getInt("no")+".jpg");

    //////////////////
    
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
    ////////////////

    if ( count%50 == 0) println(count+" / "+table.getRowCount()); 
    count++;
  }
  saveTable(gridTable, "../../data/gridTable.csv");
  println("done");
  noLoop();
}

