Table table;

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
  println("w:", w, ", h:", h);
}

void draw() {

  background(255);
  for (TableRow t : table.rows ()) {
    
    //go or nogo check
    int go = t.getInt("go");
    if(go == 0) continue; //  0(nogo) 1(go)
    
    int id = t.getInt("id");
    float lat = t.getFloat("lat"); //y
    float lon = t.getFloat("lon"); //x
    lat = map(lat, latMin, latMax, height, 0);
    lon = map(lon, lonMin, lonMax, 0, width);
    
    int[] hueList = new int[256];
    for(int i =0; i<hueList.length ;i++){
     hueList[i] = t.getInt(str(i)); 
    }
    int hueMax = max(hueList);
    colorMode(HSB);
    for(int i =0; i<hueList.length ;i++){
     if (hueList[i] == hueMax) fill(i,255,255,100); 
    }
    
    noStroke();
    pushMatrix();
    {
      translate(lon+random(-2, 2), lat+random(-2, 2));
      ellipse(0, 0, 5, 5);
    
    }
    popMatrix();
    if(id % 300 == 0) println(id+" / "+ table.getRowCount());
  }
  save("../../../data/ny/map_hue_go.jpg");
  println("done"); 
  noLoop();
}

