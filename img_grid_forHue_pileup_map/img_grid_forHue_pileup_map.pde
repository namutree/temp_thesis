Table table;
PImage img;
Table gridTable;
Table originalTable;

float latMax, latMin, lonMax, lonMin;
int count;
int wCount, hCount;

void setup() {

  count=0;
  table = loadTable("../../data/gridTable_pileup.csv", "header");
  originalTable = loadTable("../../data/usa_10_total.csv", "header");

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

  float w = (lonMax - lonMin)*1110/5.5;
  float h = (latMax - latMin)*1110/4;

  size((int)w, (int)h);
  //size(30, 30);
  println("w:", w, ", h:", h);
  wCount = int(w/10);
  hCount = int(h/10);
  println("x:", wCount, ", y:", hCount);
}
//  0   1   2   3   4            5
//  id, lat,lon,url,created_time,tags
void draw() {
  background(255);

  for (TableRow i : table.rows ()) {

    int[] HueHist = new int[256];
    for (int j=0; j<256; j++) {
      HueHist[j]= i.getInt(str(j));
    }
    int histMax = max(HueHist);
    if (histMax==0) continue;
    int maxnumber=0;
    for (int j=0; j<256; j++) {
      if (HueHist[j] == histMax) maxnumber = j;
    }

    colorMode(HSB);
    noStroke();
    fill(maxnumber, 255, 255, 110);
    int x = i.getInt("x")*5;
    int y = i.getInt("y")*5;
    //full
    //ellipse(x*10+5, y*10+5, 10, 10);
    //half
    //arc(x*10+5, y*10+5, 10, 10, PI*3/2, PI*5/2);
    //quater
    arc(x*10+5, y*10+5, 50, 50, 0, PI/2);

    //2nd highest hue half-moon
    HueHist[maxnumber]=0;
    histMax = max(HueHist);
    for (int j=0; j<256; j++) {
      if (HueHist[j] == histMax) maxnumber = j;
    }
    fill(maxnumber, 255, 255, 110);
    //half
    //arc(x*10+5, y*10+5, 10, 10, PI/2, PI*3/2);
    //quater
    arc(x*10+5, y*10+5, 50, 50, PI/2, PI);
    //2nd end

    //3rd highest hue half-moon
    HueHist[maxnumber]=0;
    histMax = max(HueHist);
    for (int j=0; j<256; j++) {
      if (HueHist[j] == histMax) maxnumber = j;
    }
    fill(maxnumber, 255, 255, 110);
    //half
    //arc(x*10+5, y*10+5, 10, 10, PI/2, PI*3/2);
    //quater
    arc(x*10+5, y*10+5, 50, 50, PI, PI*3/2);
    //3rd end

    //4th highest hue half-moon
    HueHist[maxnumber]=0;
    histMax = max(HueHist);
    for (int j=0; j<256; j++) {
      if (HueHist[j] == histMax) maxnumber = j;
    }
    fill(maxnumber, 255, 255, 110);
    //half
    //arc(x*10+5, y*10+5, 10, 10, PI/2, PI*3/2);
    //quater
    arc(x*10+5, y*10+5, 50, 50, PI*3/2, PI*2);
    //4th end
  }

  save("../../data/grid_full_bigsize.jpg");
  println("done");
  noLoop();
}

