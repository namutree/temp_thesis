Table table;
Table satTable;
Table[] hueTable= new Table[11];

Table finalTable = new Table();
PImage img;

void setup() {

  table = new Table();
  satTable = new Table();
  for (int i=0; i<hueTable.length; i++) {
    hueTable[i] = new Table();
  }


  img = loadImage("data/yoyo01.jpg");
  size(img.width, img.height);

  table.addColumn("h");
  table.addColumn("s");
  table.addColumn("b");
  satTable.addColumn("h");
  satTable.addColumn("s");
  satTable.addColumn("b");
  for (int i=0; i<hueTable.length; i++) {
    hueTable[i].addColumn("h");
    hueTable[i].addColumn("s");
    hueTable[i].addColumn("b");
  }
  finalTable.addColumn("h");
  finalTable.addColumn("s");
  finalTable.addColumn("b");

  for (int i = 0; i <img.width * img.height; i++) {
    TableRow newRow = table.addRow();
    newRow.setInt("h", (int)hue(img.pixels[i]));
    newRow.setInt("s", (int)saturation(img.pixels[i]));
    newRow.setInt("b", (int)brightness(img.pixels[i]));

    //if ( i % 1500 ==0) print("a " + i+"/"+ img.width *  img.height+" ");
  }

  //have to set column as int, otherwise it sorts in different way!!
  sortColumnAsInt(table);
  //----------------------------------------------------------------------//


  //'1' is the column number, so in this case 'h' column is 0!
  //table.sortReverse(1);
  table.sort(1); //saturation

  //take out whose saturation is smaller than 5%
  println("original: "+ table.getRowCount());
  for (TableRow t : table.rows ()) {
    int hh = t.getInt("h");
    int ss = t.getInt("s");
    int bb = t.getInt("b");

    if (ss < 255*5/100) {
      TableRow newRow = satTable.addRow();
      newRow.setInt("h", hh);
      newRow.setInt("s", ss);
      newRow.setInt("b", bb); 

      t.setInt("h", -1);
      t.setInt("s", -1);
      t.setInt("b", -1);
    }
  }

  while (table.getInt (0, "h") <0) {
    table.removeRow(0);
  }

  sortColumnAsInt(satTable);

  //sort by brightness
  satTable.sort(2); // b (HSB)

  println("reivsed: "+ table.getRowCount());
  println("saturation: "+ satTable.getRowCount());
  //-----------------------------------------------------------//


  // sort by hue---------------------------------
  for (int i =0; i<hueTable.length; i++) {
    table.sort(0);
    for (TableRow t : table.rows ()) {
      int hh = t.getInt("h");
      int ss = t.getInt("s");
      int bb = t.getInt("b");
      ss = (int) map(ss, 0, 255, 255, 255);
      bb = (int) map(bb, 0, 255, 255, 255);

      if (hh < 255*(i+1)/12) {
        TableRow newRow = hueTable[i].addRow();
        newRow.setInt("h", hh);
        newRow.setInt("s", ss);
        newRow.setInt("b", bb); 

        t.setInt("h", -1);
        t.setInt("s", -1);
        t.setInt("b", -1);
      }
    }
    while (table.getInt (0, "h") <0) {
      table.removeRow(0);
    }

    sortColumnAsInt(hueTable[i]);
    hueTable[i].sort(0); // hue
    hueTable[i].sort(1); //saturation
    hueTable[i].sort(2); //brightness

    println("reivsed"+str(i)+": "+ table.getRowCount());
    println("hue"+str(i)+": "+ hueTable[i].getRowCount());
  }
  //--------------------------------------------------------//

  // sort rest of data

  table.sort(0);
  table.sort(1);
  table.sort(2);
  //-------------------------------------------------------

  // combine everytable together------------------


  for (int i = 0; i< hueTable.length; i++) {
    for (TableRow t : hueTable[i].rows ()) {
      TableRow newRow = finalTable.addRow();
      newRow.setInt("h", t.getInt("h"));
      newRow.setInt("s", t.getInt("s"));
      newRow.setInt("b", t.getInt("b"));
    }
  }

  for (TableRow t : table.rows ()) {
    TableRow newRow = finalTable.addRow();
    newRow.setInt("h", t.getInt("h"));
    newRow.setInt("s", t.getInt("s"));
    newRow.setInt("b", t.getInt("b"));
  }
  for (TableRow t : satTable.rows ()) {
    TableRow newRow = finalTable.addRow();
    newRow.setInt("h", t.getInt("h"));
    newRow.setInt("s", t.getInt("s"));
    newRow.setInt("b", t.getInt("b"));
  }



  colorMode(HSB);


  loadPixels();
  for (int i = 0; i < (width*height); i++) {
    color cc = color(finalTable.getInt(i, "h"), finalTable.getInt(i, "s"), finalTable.getInt(i, "b"));
    pixels[i] = cc;
    if ( i % 5500 ==0) print("b "+i+"/"+ img.width *  img.height+" ");
  }
  updatePixels();

  println(finalTable.getRowCount());


  //save
  saveTable(finalTable, "data/eraseme02.csv");
  save("data/eraseme.jpg");
}

void draw() {
}

void sortColumnAsInt(Table tt) {
  tt.setColumnType("h", Table.INT);
  tt.setColumnType("s", Table.INT);
  tt.setColumnType("b", Table.INT);
}

