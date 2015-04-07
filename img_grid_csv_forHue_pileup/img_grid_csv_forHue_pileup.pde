Table table;
PImage img;
Table gridTable;
Table originalTable;

float latMax, latMin, lonMax, lonMin;
int count;
int wCount, hCount;

void setup() {

  count=0;
  table = loadTable("../../data/gridTable.csv", "header");
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

  float w = (lonMax - lonMin)*1110/5.5/5;
  float h = (latMax - latMin)*1110/4/5;

  size((int)w, (int)h);
  //size(30, 30);
  println("w:", w, ", h:", h);
  wCount = int(w/10);
  hCount = int(h/10);
  println("x:", wCount, ", y:", hCount);

  gridTable = new Table();
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
  for (int x =0; x < wCount; x++) {
    for (int y =0; y < hCount; y++) {
      int[] hueHist = new int[256];
      TableRow newRow = gridTable.addRow();
      for (TableRow i : table.rows ()) {
        //-- go only!!-----------
        //int gonogo = originalTable.getInt(i.getInt("id"), "go");
        //if (gonogo ==1) continue;
        //-----------------------
        
        //-- By month ------------
        String createdTime = originalTable.getString(i.getInt("id"),"created_time");
        String[] createdTimeSplit = createdTime.split("-");
        int month = int(createdTimeSplit[1]);
        if (month !=1 ) continue;
        //--------------------
        
        if ( x == i.getInt("x") && y == i.getInt("y")) {
          for ( int j =0; j<256; j++) {
            hueHist[j] += i.getInt(str(j));
          }
        }
      }
      newRow.setInt("x", x);
      newRow.setInt("y", y);
      for (int j=0; j<256; j++) {
        newRow.setInt(str(j), hueHist[j]);
      }
    }
    println(x+" / " + wCount);//+" "+y);
  }

  for (TableRow i : gridTable.rows ()) {
    int x = i.getInt("x");
    int y = i.getInt("y");
    int[] hueHist = new int[256];
    for (int j=0; j<256; j++) {
      hueHist[j] = i.getInt(str(j));
    }
  }

  saveTable(gridTable, "../../data/gridTable_pileup_month01.csv");
  println("done");
  noLoop();
}

