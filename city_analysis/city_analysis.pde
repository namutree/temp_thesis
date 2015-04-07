Table table;
Table cityTable;

String[]  cityName= {"Bunche Park","Sherbrooke","Colorado Springs","Oldsmar","Montréal","St. Louis","Sandy","Waterbury","Peoria","Los Angeles","Evansville","Philadelphia","Columbus","San Diego","Springfield","Saint Paul","Minneapolis","Las Vegas","Tucson","Culiacán","Clifton","Toledo","Albuquerque","Allentown","Amarillo","Toronto","Monterrey","Indianapolis","Washington","Lancaster","South Bend","Grand Rapids","Cincinnati","Arlington","Havana","Buena Ventura Lakes","Fort Worth","Birmingham","Charlotte","Burlington","Chicago","Omaha","Santa Fe","Baltimore","Vancouver","Kansas City","Pittsburgh","Acuña","Beaumont","Fort Wayne","Aurora","Windsor","Worcester","Sioux Falls","Newport News","Detroit","Louisville","Tallahassee","Newport Hills","McAllen","Knoxville","Naperville","Des Moines","Hammond","Jacksonville","Atlanta","Dayton","Hamilton","Nashville","Houston","Durham","Helena","Norfolk","Monclova","Memphis","Boston","Tempe","Alexandria","Baton Rouge","Denver","Corpus Christi","Yonkers","Lubbock","Mesa","Gilbert","Modesto","Ottawa","Roseville","Saltillo","Dover","Laredo","Richmond","Torreón","Corona","Tulsa","Savannah","Buffalo","Portland","Dallas","Lansing","San Antonio","Rochester","Irondequoit","Sacramento","Columbia","Fayetteville","Orlando","Lincoln","Flint","Albany","Reno","Tijuana","Athens","Shreveport","Opportunity","Reynosa","San Jose","Eugene","Ann Arbor","Providence","Rancho Cucamonga","Del City","Clarksville","Piedras Negras","Kitchener","Middleburg","New York","Fresno","Mobile","Quebec","Wichita","Bridgeport","Pueblo","Fort Collins","San Luis Río Colorado","Overland Park","Santa Clarita","Harrisburg","Chattanooga","Greensboro","Lowell","Austin","Phoenix","Huntsville","San Francisco","Rumson","North Charleston","Carrollwood Village","New Orleans","Oceanside","Blountville","El Paso","Akron","Boise City","Winston-Salem","Tacoma","Norman","Irving","Waco","Cedar Rapids","Salinas","Madison","Provo","Lafayette","Sudbury","Hermosillo","Tangelo Park","Metairie","Manchester","Denton","London","Port St. Lucie","Lockwood","Cleveland","Gómez Palacio","Concord","Killeen","Erie","Chandler","Bellevue","Gainesville","Stockton","San Bernardino","Pine Lake","Eden","Green Bay","Victoria","Raleigh","Carson City","Ciudad Juárez","Delicias","Hartford","Oxnard","Abilene","Thunder Bay","Bakersfield","Cary","Guaymas","Saint Catharines","Riverside","Pierre","Wichita Falls","Lake Buena Vista","Winter Springs","Topeka","Montgomery","Oshkosh","Antioch","Milwaukee","Lenexa","Mexicali","Oshawa","Rockford","Vallejo","Seattle"};

void setup() {

  table = loadTable("../../data/usa_10_total.csv", "header");

  for (int st =0; st<cityName.length; st++) {
    cityTable = new Table();
    cityTable.addColumn("id");

    for (int i=0; i<256; i++) {
      cityTable.addColumn(str(i));
    }

    for (TableRow i : table.rows ()) {
      if (cityName[st].equals(i.getString("city"))) {
        TableRow newRow = cityTable.addRow();
        newRow.setInt("id", i.getInt("no"));


        //hue
        PImage img;
        img = loadImage("../../data/img/"+str(i.getInt("no"))+".jpg");
        int[] hueHist = new int[256];
        for (int a = 0; a < img.width; a++) {
          for (int b = 0; b < img.height; b++) {
            int loc = a + b*img.width;
            //if it is grey than donot count
            if (red(img.pixels[loc]) == blue(img.pixels[loc]) && blue(img.pixels[loc]) == green(img.pixels[loc])) continue;
            int hueY = int(hue(img.pixels[loc]));
            hueHist[hueY]++;
          }
        }

        for (int j =0; j<256; j ++) {
          newRow.setInt(str(j), hueHist[j]);
        }
      }
    }
    //////---------------------- 
    TableRow newRow = cityTable.addRow();
    newRow.setString("id", "avrg");
    int[] avrg = new int[256];

    for (int jj =0 ; jj<cityTable.getRowCount()-1;jj++) {
      
      for (int ii=0; ii<256; ii++) {

        avrg[ii] += cityTable.getInt(jj, str(ii));
      }
    }
    for (int k =0; k<256; k++) {
      int totalRow = (int)avrg[k] / (cityTable.getRowCount()-1);
      newRow.setInt(str(k), totalRow );
    }
    println(cityName[st]);
    saveTable(cityTable, "../../data/city/"+cityName[st]+".csv");
  }
}

void draw() {
}

