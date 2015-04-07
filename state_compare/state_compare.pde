Table table;
Table stateTable01, stateTable02;
float latMax, latMin, lonMax, lonMin;
IntList lineUp;

String[]  stateName= { 
  "Florida", "Massachusetts", "New York", "Arkansas", "Utah", "Colorado", "Montana", "Illinois", "Michigan", "California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut", "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
};

String state01, state02; 

void setup() {
  state01 ="New York";
  state02 ="Iowa";
  table = loadTable("../../data/usa_10_total.csv", "header");
  stateTable01 = loadTable("../../data/state_"+state01+".csv", "header");
  stateTable02 = loadTable("../../data/state_"+state02+".csv", "header");
  lineUp = new IntList();

  latMax = -9999; 
  latMin =  9999; 
  lonMax = -9999; 
  lonMin =  9999;

  for ( TableRow i : stateTable01.rows () ) {
    if ( i.getString("id").equals("avrg") ) continue;
    int imgNumber = i.getInt("id");

    float lon = table.getFloat(imgNumber, "lon");
    float lat = table.getFloat(imgNumber, "lat");
    if (lon<lonMin) lonMin = lon;
    if (lon>lonMax) lonMax = lon;
    if (lat<latMin) latMin = lat;
    if (lat>latMax) latMax = lat;
  }

  println(latMax, latMin, lonMax, lonMin);
  float w = (lonMax - lonMin)*1110/5.5/2;
  float h = (latMax - latMin)*1110/4/2;

  size((int)w, (int)h);
}


void draw() {
  background(255);
  int count=-1;
  for (TableRow i : stateTable01.rows ()) {
    int[] hueHist = new int[256];
    int imgNumber = i.getInt("id");
    //----------- go only----
    if (table.getFloat(imgNumber, "go")==0) continue;
    count++;
    float lon = table.getFloat(imgNumber, "lon");
    float lat = table.getFloat(imgNumber, "lat");
    lon = map(lon, lonMin, lonMax, 0, width);
    lat = map(lat, latMin, latMax, height, 0);
    for (int j =0; j<256; j++) {
      hueHist[j] = i.getInt(str(j)) - stateTable02.getInt(stateTable02.getRowCount()-1, str(j));
    }
    int hueMax = max(hueHist);
    colorMode(HSB);
    int maxnumber=0;
    for (int j=0; j<256; j++) {
      if (hueHist[j] == hueMax) maxnumber = j;
    }
    noStroke();
    fill(maxnumber, 255, 255, 70);
    float yy = map(maxnumber, 0, 255, 0, height);
    //ellipse(lon, lat,7,7);//yy, 10, 10);

    //-------line up---------------------
    int x = (count) % int(width/10) ;
    int y = (int) (count)/ (width/10) ;
    //ellipse(x*10+5, y*10+5, 10, 10);
    //----------------------------------

    //--------line up2 by hue 01/02 ------------------
    lineUp.append(maxnumber);
    //--------------------------------------------
  }

  //--------line up2 by hue 02/02 ------------------
  lineUp.sort();

  for (int i=0; i<lineUp.size (); i++) {
    fill(lineUp.get(i), 255, 255, 70);
    int x = (i) % int(width/10) ;
    int y = (int) (i)/ (width/10) ;
    ellipse(x*10+5, y*10+5, 10, 10);
    //--------------------------------------------
  }

  println("done");
  save("../../data/statecompare_"+state01+"_"+state02+".jpg");
  noLoop();
}

/*
"Florida", "Massachusetts","New York","Arkansas","Utah","Colorado","Montana","Illinois","Michigan","California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut",  "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
 */
