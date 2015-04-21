Table table;

float latMax, latMin, lonMax, lonMin;
int count;

void setup() {
  table = loadTable("../../../data/ny/mozaicTable_hue.csv", "header");

  count =0;
  latMax= 40.903939;
  latMin= 40.481192;
  lonMax= -73.694036;
  lonMin= -74.280432;

  int w = (int)((lonMax - lonMin)*1110*3);
  int h = (int)((latMax - latMin)*1110*3);

  size((int)w, (int)h);
}
//x,     y,       w,    h,      hue
//1464.0,1231.125,244.0,175.875,151
void draw() {
  background(255);
  noStroke();
  colorMode(HSB);

  for (TableRow m : table.rows ()) {

    float x = m.getFloat("x");
    float y = m.getFloat("y");
    float w = m.getFloat("w");
    float h = m.getFloat("h");
    int maxHue = m.getInt("hue");

    float aa = (log(1/(h/height))/log(2));
    println(aa);
    float oppa = map(aa, 5, 11, 50, 500);

    //fill(maxHue, 255, 255, oppa);
    fill(0, oppa);
    rect(x, y, w, h);
    if ( count %25 ==0 ) println(count+" / " +table.getRowCount());
    count++;
  }

  //println(log(1/8)/log(1/2));
  println("done");
  save("../../../data/ny/erasememe00.jpg");
  noLoop();
}

