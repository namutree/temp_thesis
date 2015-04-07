Table table;
int filename;
int total;
void setup() {
  int cvsNo;
  cvsNo = 9;
  total =0;
  for (int i=0; i<=cvsNo; i++) {
    filename = i;
    if (i<10) table = loadTable("../../data/usa_0"+str(filename)+".csv", "header");
    else table = loadTable("../../data/usa_"+str(filename)+".csv", "header");
    println(i+": "+table.getRowCount());
    total += table.getRowCount();
  }
  println("total: "+ total);
}

void draw() {
}

