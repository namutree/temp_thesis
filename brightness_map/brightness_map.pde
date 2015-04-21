Table table;
Table brightnessTable;
PImage img;
int count;
float latMax, latMin, lonMax, lonMin;


void setup() {

  table = loadTable("../../data/usa_10_total.csv", "header");
  brightnessTable = loadTable("../../data/brightness_Table.csv", "header");

  //  #revised USA
  //# 49.265911, -125.517483
  //# 24.584452, -64.872955

  latMax= 49.265911;
  latMin= 24.584452;
  lonMax= -64.872955;
  lonMin= -125.517483;

  float w = (lonMax - lonMin)*1110/5.5/2;
  float h = (latMax - latMin)*1110/4/2;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);

  count=0;
}

void draw() {
  background(200,200,0);
  colorMode(HSB);
  for (TableRow i : brightnessTable.rows ()) {
    float lat = table.getFloat(i.getInt("id"), "lat");
    float lon = table.getFloat(i.getInt("id"), "lon");
    lat = map(lat, latMin, latMax, height, 0);
    lon = map(lon, lonMin, lonMax, 0, width);

   int[] bHist = new int[256];
    for (int a = 0; a < bHist.length; a++) {
      bHist[a] = i.getInt(str(a));
    }
    int bMax = max(bHist);
    if (bMax == 0) continue;
    int bItself =300;
    for (int a = 0; a < bHist.length; a++) {
      if (bHist[a] == bMax) bItself =a ;
    }
    noStroke();
    fill(0, 0,bItself, 150);
    ellipse(lon, lat, 10, 10);


    if (count%300 == 0 ) println(count+ " / "+ table.getRowCount());
    count++;
  }

  save("../../data/brightness_map.jpg");
  println("done");
  noLoop();
}

