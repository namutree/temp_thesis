Table table;
Table brightnessTable;
PImage img;
int count;


void setup() {

  table = loadTable("../../data/usa_10_total.csv", "header");
  //no, id,lat,lon,url,created_time,tags,state,city,sd,go
  count=0;
  ;

  brightnessTable = new Table();
  brightnessTable.addColumn("id");

  for (int i=0; i<256; i++) {
    brightnessTable.addColumn(str(i));
  }

  for (TableRow i : table.rows ()) {


    TableRow newRow = brightnessTable.addRow();
    newRow.setInt("id", i.getInt("no"));
    //brightness list
    img = loadImage("../../data/img/"+str(i.getInt("no"))+".jpg");

    // take out the white pics ------------------------------//
    int temp01 = (int)random(img.width*img.height);
    int temp02 = (int)random(img.width*img.height);
    int temp03 = (int)random(img.width*img.height);
    if (red(img.pixels[temp01]) == blue(img.pixels[temp02]) && green(img.pixels[temp02]) ==255 && green(img.pixels[temp03]) ==255 && red(img.pixels[temp01]) ==255) continue;
    // -----------------------------------------------------//

    int[] bHist = new int[256];
    for (int a = 0; a < img.width; a++) {
      for (int b = 0; b < img.height; b++) {
        int loc = a + b*img.width;
        //if it is grey than donot count

        int brightnessY = int(brightness(img.pixels[loc]));
        bHist[brightnessY]++;
      }
    }
    for (int j =0; j<256; j ++) {
      newRow.setInt(str(j), bHist[j]);
    }
    if (count%100 == 0 ) println(count+ " / "+ table.getRowCount());
    count++;
  }

  println("done");
  saveTable(brightnessTable, "../../data/brightness_Table.csv");
}


void draw() {
}

