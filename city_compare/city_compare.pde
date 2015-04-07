Table table;
Table cityTable01, cityTable02;
float latMax, latMin, lonMax, lonMin;
IntList lineUp;

//"Bunche Park","Sherbrooke","Colorado Springs","Oldsmar","Montréal","St. Louis","Sandy","Waterbury","Peoria","Los Angeles","Evansville","Philadelphia","Columbus","San Diego","Springfield","Saint Paul","Minneapolis","Las Vegas","Tucson","Culiacán","Clifton","Toledo","Albuquerque","Allentown","Amarillo","Toronto","Monterrey","Indianapolis","Washington","Lancaster","South Bend","Grand Rapids","Cincinnati","Arlington","Havana","Buena Ventura Lakes","Fort Worth","Birmingham","Charlotte","Burlington","Chicago","Omaha","Santa Fe","Baltimore","Vancouver","Kansas City","Pittsburgh","Acuña","Beaumont","Fort Wayne","Aurora","Windsor","Worcester","Sioux Falls","Newport News","Detroit","Louisville","Tallahassee","Newport Hills","McAllen","Knoxville","Naperville","Des Moines","Hammond","Jacksonville","Atlanta","Dayton","Hamilton","Nashville","Houston","Durham","Helena","Norfolk","Monclova","Memphis","Boston","Tempe","Alexandria","Baton Rouge","Denver","Corpus Christi","Yonkers","Lubbock","Mesa","Gilbert","Modesto","Ottawa","Roseville","Saltillo","Dover","Laredo","Richmond","Torreón","Corona","Tulsa","Savannah","Buffalo","Portland","Dallas","Lansing","San Antonio","Rochester","Irondequoit","Sacramento","Columbia","Fayetteville","Orlando","Lincoln","Flint","Albany","Reno","Tijuana","Athens","Shreveport","Opportunity","Reynosa","San Jose","Eugene","Ann Arbor","Providence","Rancho Cucamonga","Del City","Clarksville","Piedras Negras","Kitchener","Middleburg","New York","Fresno","Mobile","Quebec","Wichita","Bridgeport","Pueblo","Fort Collins","San Luis Río Colorado","Overland Park","Santa Clarita","Harrisburg","Chattanooga","Greensboro","Lowell","Austin","Phoenix","Huntsville","San Francisco","Rumson","North Charleston","Carrollwood Village","New Orleans","Oceanside","Blountville","El Paso","Akron","Boise City","Winston-Salem","Tacoma","Norman","Irving","Waco","Cedar Rapids","Salinas","Madison","Provo","Lafayette","Sudbury","Hermosillo","Tangelo Park","Metairie","Manchester","Denton","London","Port St. Lucie","Lockwood","Cleveland","Gómez Palacio","Concord","Killeen","Erie","Chandler","Bellevue","Gainesville","Stockton","San Bernardino","Pine Lake","Eden","Green Bay","Victoria","Raleigh","Carson City","Ciudad Juárez","Delicias","Hartford","Oxnard","Abilene","Thunder Bay","Bakersfield","Cary","Guaymas","Saint Catharines","Riverside","Pierre","Wichita Falls","Lake Buena Vista","Winter Springs","Topeka","Montgomery","Oshkosh","Antioch","Milwaukee","Lenexa","Mexicali","Oshawa","Rockford","Vallejo","Seattle"
String city01, city02; 

void setup() {
  city02 ="San Antonio";
  city01 ="New York";
  table = loadTable("../../data/usa_10_total.csv", "header");
  cityTable01 = loadTable("../../data/city/"+city01+".csv", "header");
  cityTable02 = loadTable("../../data/city/"+city02+".csv", "header");
  lineUp = new IntList();

  latMax = -9999; 
  latMin =  9999; 
  lonMax = -9999; 
  lonMin =  9999;

  for ( TableRow i : cityTable01.rows () ) {
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
  float w = (lonMax - lonMin)*1110/5.5*10;
  float h = (latMax - latMin)*1110/4*10;

  size((int)w, (int)h);
}


void draw() {
  background(255);
  int count=-1;
  for (TableRow i : cityTable01.rows ()) {
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
      hueHist[j] = i.getInt(str(j)) - cityTable02.getInt(cityTable02.getRowCount()-1, str(j));
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
  lineUp.sortReverse();

  for (int i=0; i<lineUp.size (); i++) {
    fill(lineUp.get(i), 255, 255, 70);
    int x = (i) % int(width/10) ;
    int y = (int) (i)/ (width/10) ;
    ellipse(x*10+5, y*10+5, 10, 10);
    //--------------------------------------------
  }

  println("done");
  save("../../data/citycompare_"+city01+"_"+city02+".jpg");
  noLoop();
}

