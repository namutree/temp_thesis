Table table;


void setup() {


  table = loadTable("../../data/eraseme.csv", "header");
  table.addColumn("test");
}
//  0   1   2   3   4            5
//  id, lat,lon,url,created_time,tags
void draw() {
  background(255);
  
  for(TableRow t : table.rows()){
    if(t.getInt("id") ==0) t.setInt("test", 2);
  }
  
//  if(table.getInt("id") ==0) 
//  table.removeRow(0);
//  table.removeRow(10);
  
  saveTable(table, "data/eraseme2.csv");
  //println(table);

  noLoop();
}

