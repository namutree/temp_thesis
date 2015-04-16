Table table;


void setup() {


  table = loadTable("../../../data/ny/usa_ny_wo_tagNurl.csv", "header");
  table.addColumn("in_out");
}
//# ny
//# lat 40.903939, lon -73.694036 
//# lat 40.481192, lon -74.280432

void draw() {
  background(255);

  for (TableRow t : table.rows ()) {
    float lat = t.getFloat("lat");
    float lon = t.getFloat("lon");
    if (lat <= 40.903939 && lat >= 40.481192 && lon <= -73.694036 && lon >= -74.280432 ) {
      t.setInt("in_out", 1);
    } else {
      t.setInt("in_out", 0);
    }
  }


  saveTable(table, "../../../data/ny/usa_ny_wo_tagNurl_wBoundary.csv");

  noLoop();
}

