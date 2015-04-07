Table table;
Table stateTable01, stateTable02;
float latMax, latMin, lonMax, lonMin;
IntList lineUp01, lineUp02;

String[]  stateName= { 
  "Florida", "Massachusetts", "New York", "Arkansas", "Utah", "Colorado", "Montana", "Illinois", "Michigan", "California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut", "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
};

String state01, state02; 

void setup() {
  state02 ="New York";
  state01 ="Iowa";
  table = loadTable("../../data/usa_10_total.csv", "header");
  stateTable01 = loadTable("../../data/state_"+state01+".csv", "header");
  stateTable02 = loadTable("../../data/state_"+state02+".csv", "header");
  lineUp01 = new IntList();
  lineUp02 = new IntList();

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

  //---- lineUp 01 ------------------------------------------------------//
  for (TableRow i : stateTable01.rows ()) {
    int[] hueHist = new int[256];
    int imgNumber = i.getInt("id");
    //----------- go only----
    if (table.getFloat(imgNumber, "go")==0) continue;

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

    lineUp01.append(maxnumber);
  }

  lineUp01.sortReverse();
  //----------------------------------------------------------------------//  

  //---- lineUp 02 ------------------------------------------------------//
  for (TableRow i : stateTable02.rows ()) {
    int[] hueHist = new int[256];
    int imgNumber = i.getInt("id");
    //----------- go only----
    if (table.getFloat(imgNumber, "go")==0) continue;

    for (int j =0; j<256; j++) {
      hueHist[j] = i.getInt(str(j)) - stateTable01.getInt(stateTable01.getRowCount()-1, str(j));
    }
    int hueMax = max(hueHist);
    colorMode(HSB);
    int maxnumber=0;
    for (int j=0; j<256; j++) {
      if (hueHist[j] == hueMax) maxnumber = j;
    }
    noStroke();

    lineUp02.append(maxnumber);
  }
  lineUp02.sortReverse();
  //-------------------------------------------------------------------------------------//

println(lineUp01.size(),lineUp02.size());

  //---------------------------------------------vis--------------------------------//
  // remove value in the one if the two has it.
  IntList lineUpSub = new IntList();
  for (int i=0; i<lineUp01.size (); i++) {
    for (int j=0; j<lineUp02.size (); j++) {
      if ( lineUp01.get(i) == lineUp02.get(j)  ) {
        lineUp01.set(i, 999);
        lineUp02.set(j, 999);
        break;
      }
    }
  }
  
  //real vis
  lineUp01.sort();
  int ccc=0;
  for (int i=0; i<lineUp01.size (); i++) {
    if(lineUp01.get(i) == 999) continue;
    ccc++;
    fill(lineUp01.get(i), 255, 255, 70);
    int x = (i) % int(width/10) ;
    int y = (int) (i)/ (width/10) ;
    ellipse(x*10+5, y*10+5, 10, 10);
  }
println(ccc);
  //------------------------------------------------------------------------------------------//
  println("done");
  save("../../data/statecompare02_"+state01+"_"+state02+".jpg");
  noLoop();
}

/*
"Florida", "Massachusetts","New York","Arkansas","Utah","Colorado","Montana","Illinois","Michigan","California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut",  "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
 */
