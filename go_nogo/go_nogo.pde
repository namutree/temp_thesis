PImage img;
Table table;
Table hueTable;
String filename;
int count;

void setup() {
  size(200, 200);
  count=0;

  //picture url
  int cc = 14;
  filename = "usa_"+str(cc)+".csv";
  table  = loadTable("../../data/"+filename, "header");

  //pic hue history
  hueTable = new Table();
  hueTable.addColumn("id");
  for (int i=0; i<256; i++) {
    hueTable.addColumn(str(i));
  }
}

void draw() {
  for (TableRow i : table.rows ()) {
    String url = i.getString("url");
    try {
      img = loadImage(url);
      img.resize(200, 200);
    }
    catch(Exception e) {
      println(e);
      img = loadImage("../../data/white_back.jpg");
      img.resize(200, 200);
    }
    image(img, 0, 0);
    hueHist(img.width, img.height,count);
    if (count%20==0) println(hueTable.getRowCount()+","+count+" / "+table.getRowCount());
    count++;
  }
  saveTable(hueTable, "../../data/hue_"+filename);
  println("done");
  noLoop();
}

void hueHist(int w, int h, int cc) {
  int[] hueHist = new int[256];
  for (int i=0; i<w; i++) {
    for (int j=0; j<h; j++) {
      int hueY = int(hue(get(i, j)));
      hueHist[hueY]++;
    }
  }
  TableRow newRow = hueTable.addRow();
  newRow.setInt("id", cc);
  for (int i=0; i<256; i++) {
    
    for (int j=0; j<256; j++) {
      newRow.setInt(str(j), hueHist[j]);
    }
  }
}

