Table table;
Table hueTable;
Table mozaicHueTable;
float latMax, latMin, lonMax, lonMin;
int count;

void setup() {
  table = loadTable("../../../data/ny/mozaicTable_original.csv", "header");
  hueTable = loadTable("../../../data/ny/hueTable_gonogo.csv", "header");
  mozaicHueTable = new Table();
  mozaicHueTable.addColumn("x");
  mozaicHueTable.addColumn("y");
  mozaicHueTable.addColumn("w");
  mozaicHueTable.addColumn("h");
  mozaicHueTable.addColumn("hue");


  count =0;
  latMax= 40.903939;
  latMin= 40.481192;
  lonMax= -73.694036;
  lonMin= -74.280432;

  int w = (int)((lonMax - lonMin)*1110*3);
  int h = (int)((latMax - latMin)*1110*3);

  size((int)w, (int)h);
}

void draw() {
  background(255);
  noStroke();
  colorMode(HSB);

  for (TableRow m : table.rows ()) {


    float x = m.getFloat("x");
    float y = m.getFloat("y");
    float w = m.getFloat("w");
    float h = m.getFloat("h");

    int cc = hueMode(x, y, w, h);

    TableRow newRow =   mozaicHueTable.addRow();
    newRow.setFloat("x", x);
    newRow.setFloat("y", y);
    newRow.setFloat("w", w);
    newRow.setFloat("h", h);
    newRow.setInt("hue", cc);

    //max h = height/8
    // starting is log(h/height) / log(1/2) = 3
    // next will be 4,5,6,...
    //if just oppa = map(h, 0, height/8, 255, 0); then it is 1/8 ,1/16, 1/32 ....
    //so not good changes
    //    float oppa = log(h/height) / log(1/2); 
    //    oppa = map(oppa, 3, 10, 10, 255);
    float oppa = map(h, 0, height/8, 255, 0);

    fill(cc, 255, 255, oppa);
    rect(x, y, w, h);
    if ( count %25 ==0 ) println(count+" / " +table.getRowCount());
    count++;
  }

  save("../../../data/ny/mozaic20_hue_nogo.jpg");
  saveTable(mozaicHueTable, "../../../data/ny/mozaicTable_hue_nogo.csv");
  println("done");
  noLoop();
}

int hueMode(float x, float y, float w, float h) {
  int[] hueHist = new int[256];
  for (TableRow ht : hueTable.rows () ) {
    
    // ** go test -----------------------------//
    int go = ht.getInt("go");
    if(go == 1 ) continue;
    // ** -------------------------------------//
    
    
    float lat = ht.getFloat("lat"); //y
    float lon = ht.getFloat("lon"); //x
    lat = map(lat, latMin, latMax, height, 0); 
    lon = map(lon, lonMin, lonMax, 0, width); 

    if ( lon > x && lon <= x+w && lat > y && lat <= y+h) {
      for (int i = 0; i<256; i++) {
        hueHist[i] += ht.getInt(str(i));
      }
    }
  }
  int maxHue = max(hueHist); 
  int hueItself = 300; 
  for (int i = 0; i<256; i++) {
    if (hueHist[i] == maxHue) hueItself = i;
  }

  return hueItself;
}

