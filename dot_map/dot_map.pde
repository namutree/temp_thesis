Table table;
PImage imgP;


float latMax, latMin, lonMax, lonMin;

String filename;

int countCSV;

void setup() {
  //lat(wido) 1do is 111km   -90  ~ 90
  //lon(kyoungdo) is 0-111km -180 ~ 180

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

  float w = (lonMax - lonMin)*1110/5.5/2;
  float h = (latMax - latMin)*1110/4/2;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);
  countCSV=0;
  
  imgP = loadImage("../../data/point2.png");
 // blendMode(ADD);
  imageMode(CENTER);
}

void draw() {
  background(0);

  noStroke(); 
  fill(255, 150);


    filename = "usa_10_total.csv";
  table  = loadTable("../../data/"+filename, "header");
  
  for ( TableRow i : table.rows ()) {

    float lat = i.getFloat("lat"); //lat
    float lon = i.getFloat("lon");  //lon


    lat = map(lat, latMin, latMax, height, 0);
    lon = map(lon, lonMin, lonMax, 0, width);
 
    pushMatrix();
    {
      translate(lon + random(-3,3), lat + random(-3,3));
      //image(imgP, 0,0);
      fill(255,100);
      rect(0,0,5,5);
    }
    popMatrix();
   countCSV++; 
  }
  save("../../data/usa_final_eraseme2.jpg");
  println(countCSV);
  noLoop();
}

