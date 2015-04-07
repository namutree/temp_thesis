Table table;

float latMax, latMin, lonMax, lonMin;

String filename;
String tagetState;

int countCSV;

void setup() {
  tagetState = "Michigan";
  latMax =  -10000;
  lonMax =  -10000;
  latMin = 10000;
  lonMin = 10000;

  for ( int cc =1; cc<9; cc++) {
    filename = "usa_0"+str(cc)+".csv";
    table  = loadTable("../../data/"+filename, "header");
    //lat(wido) 1do is 111km   -90  ~ 90
    //lon(kyoungdo) is 0-111km -180 ~ 180
    for ( TableRow i : table.rows ()) {
      String state = i.getString("state");
      if (state.equals(tagetState)) {
        float lat = i.getFloat("lat"); 
        float lon = i.getFloat("lon");

        if (lat > latMax) latMax = lat;
        if (lat < latMin) latMin = lat;
        if (lon > lonMax) lonMax = lon;
        if (lon < lonMin) lonMin = lon;
      }
    }
  }

  println(latMax);
  println(latMin);
  println(lonMax);
  println(lonMin);

  float w = (lonMax - lonMin)*111;
  //  w = map(w, 0, 90, 0, abs(latMax+latMin)/2)*1110*2; 
  float h = (latMax - latMin)*111;

  size((int)w, (int)h);
  println("w,h: ", w,", ",h);
}

void draw() {
  background(0);
  //  lat,lon,url,created_time
  //  37.398083333,126.739708333,http://scontent.cdninstagram.com/hphotos-xpf1/t51.2885-15/s150x150/e15/1515701_304578143079479_1750133629_n.jpg,2014-10-31-15-39-28
  //for(int i=0; i<table.getRowCount(); i++){
  noStroke(); 
  fill(255, 170);
  for ( int cc =1; cc<9; cc++) {
    filename = "usa_0"+str(cc)+".csv";
    table  = loadTable("../../data/"+filename, "header");

    for ( TableRow i : table.rows ()) {
      String state = i.getString("state");
      if (state.equals(tagetState)) {
        float lat = i.getFloat("lat"); //lat
        float lon = i.getFloat("lon");  //lon


        lat = map(lat, latMin, latMax, height, 0);
        lon = map(lon, lonMin, lonMax, 0, width);
        //ellipse(lon, lat, 2, 2);
        pushMatrix();
        {
          translate(lon, lat);
          ellipse(0, 0, 7, 7 );
        }
        popMatrix();
        countCSV++;
      }
    }
  }
  save("../../data/"+tagetState+"_"+countCSV+"_eraseme.jpg");
  println(countCSV);
  noLoop();
}

//void mouseReleased(){
//  countCSV=0;
//  tagetState="Iowa";
//}
