Table table;
PVector globalRotation = new PVector();

float latMax, latMin, lonMax, lonMin;
float theta;

void setup() {
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

  size((int)w, (int)h, P3D);
  smooth(4);
  println("w:", w, ", h:", h);
  globalRotation.x = PI/4;
  globalRotation.y = 0;
  globalRotation.z = 0;
}

void draw() {


  translate(width/2, height/2);
  rotateX(globalRotation.x);
  rotateY(globalRotation.y);
  rotateZ(globalRotation.z);
  translate(-width/2, -height/2);


  float[][] points = new float[width][height];
  for (int x =0; x<width; x++) {
    for (int y=0; y<height; y++) {
      points[x][y] =0;
    }
  }

  background(255);
  //0  1   2   3   4            5    6     7    8  9
  //id,lat,lon,url,created_time,tags,state,city,sd,go
  for (int i=0; i<table.getRowCount (); i++) {
    float lat = table.getFloat(i, "lat"); //lat
    float lon = table.getFloat(i, "lon");  //lon
    lat = map(lat, latMin, latMax, height, 0);
    lon = map(lon, lonMin, lonMax, 0, width);
    if (lat<4) lat =4;
    if (lat>height-4) lat = height-4;
    if (lon<4) lon =4;
    if ( lon>width-4) lon=width-4;

    for (int ii=-3; ii<4; ii++) {
      for (int jj= -3; jj<4; jj++) {
        if (ii ==0 && jj==0) {
          points[int(lon)+ii][int(lat)+jj] += 1;
        }
        if (abs(ii) ==1 && abs(jj)==1) {
          points[int(lon)+ii][int(lat)+jj] += 0.5;
        } else {
          points[int(lon)+ii][int(lat)+jj] += 0.2;
        }
      }
    }
  }
  println("drawing...");

  //find max value of points
  float maxV =0;
  for (int i=0; i<width; i++) {
    if (maxV<max(points[i])) {
      maxV = max(points[i]);
    }
  }

  noStroke();
  fill(255);


  //,150);
  //fill(255, 0, 0, 150);
  //shpere, ellispe/////////////////
  stroke(255,0,0);
  for (int x = 2; x<width-2; x+=2) {
    for (int y= 2; y<height-2; y+=2) {

      if(points[x][y] ==0) continue;
      line(x, y, points[x][y], x-2, y-2, points[x-2][y-2]);

      //      pushMatrix();
      //      {
      //        translate(x, y, points[x][y]/2);
      //        line(0, 0, 0, 0, 0, points[x][y]);
      //      }
      //      popMatrix();
    }
    if (x%50==0) println(x+" / "+width);
  }
  //////////////////////////////

  //save("../../data/map_3d"+str(degrees(globalRotation.z))+".jpg");
  save("../../data/map_3d_Mesh"+str(degrees(globalRotation.z))+".jpg");
  globalRotation.z += PI/6;
  //noLoop();
}

