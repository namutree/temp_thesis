Table table;
Table brightnessTable;
PImage img;
int count;
float latMax, latMin, lonMax, lonMin;
int month = 0 ;


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
}

void draw() {
  colorMode(RGB);
  background(0);
  colorMode(HSB);
  count=0;
  for (TableRow i : brightnessTable.rows ()) {
    int id = i.getInt("id");

    // month--------------------------------------------------------//
    //    String times = table.getString(id, "created_time");
    //    String[] timesS = times.split("-");
    //    int monthS = int (timesS[1]);
    //if(!(month== monthS)) continue;
    ///---------------------------------------------------------------//

    float lat = table.getFloat(id, "lat");
    float lon = table.getFloat(id, "lon");
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
    stroke(0, 0, bItself, 50);
    strokeWeight(10);
    //line(0, lat, width, lat);

    noStroke();
    fill(0, 0, bItself, 150);
    ellipse(lon, lat, 10, 10);


    if (count%500 == 0 ) print(count+ "/"+ table.getRowCount()+" ");
    count++;
  }

  save("../../data/brightness_map_blackBack.jpg");//byMonth_line"+str(month)+".jpg");
  println("done" + "-" +month);
  //noLoop();
}


void keyPressed() {
  if (key =='1') month =1;
  if (key =='2') month =2;
  if (key =='3') month =3;
  if (key =='4') month =4;
  if (key =='5') month =5;
  if (key =='6') month =6;
  if (key =='7') month =7;
  if (key =='8') month =8;
  if (key =='9') month =9;
  if (key =='0') month =10;
  if (key =='q') month =11;
  if (key =='w') month =12;
}

