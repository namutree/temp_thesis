Table table;

int wCount, hCount;
float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../../../data/ny/hueTable_gonogo.csv", "header");

  //# ny
  //# lat 40.903939, lon -73.694036 
  //# lat 40.481192, lon -74.280432

  latMax= 40.903939;
  latMin= 40.481192;
  lonMax= -73.694036;
  lonMin= -74.280432;

  float w = (lonMax - lonMin)*1110*3;
  float h = (latMax - latMin)*1110*3;

  size((int)w, (int)h);
  wCount = int(w/4);
  hCount = int(h/4);
  println("x:", wCount, ", y:", hCount);
  println("w:", w, ", h:", h);
}

void draw() {
  background(255);

  for (int ii =0; ii<wCount+1; ii++) {
    for (int jj=0; jj<hCount+1; jj++) {

      int[] hueHist = new int[256];
      for (TableRow t : table.rows ()) {
        float lat = t.getFloat("lat"); //y
        float lon = t.getFloat("lon"); //x
        
        // go no go check!!----------------//
        int gonogo = t.getInt("go");
        if(gonogo == 0) continue;
        //---------------------------------//
        
        lat = map(lat, latMin, latMax, height, 0); 
        lon = map(lon, lonMin, lonMax, 0, width); 


        if (lon >= ii*4 && lon < (ii+1)*4 && lat >= jj*4 && lat < (jj+1)*4) {
          for (int h = 0; h<256; h++) {
            hueHist[h] += t.getInt(str(h));
          }
        }
      }
      int maxHue = max(hueHist); 
      int hueItself = 300;
      for (int h = 0; h<256; h++) {
        if (hueHist[h] == maxHue) hueItself = h ;
      }
      if (maxHue == 0) continue;
      
     //println("hue: "+hueItself +" max:" + maxHue);
      colorMode(HSB);
      noStroke();
      fill(hueItself, 255, 255, 110);
      ellipse(ii*4+2, jj*4+2, 4, 4);
    }
    println(ii+" / " + wCount);
  }

  save("../../../data/ny/map_hue_grid_small_go.jpg");
  println("done"); 
  noLoop();
}

