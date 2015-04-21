
Table stateTable;
PImage img = new PImage();
;

String[]  stateName= { 
  "Florida", "Massachusetts", "New York", "Arkansas", "Utah", "Colorado", "Montana", "Illinois", "Michigan", "California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut", "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
};

void setup() {
  for (int i =0; i < stateName.length; i++) {
    stateTable = loadTable("../../data/state/state_"+stateName[i]+".csv", "header");
    int t = stateTable.getRowCount();
   println( stateName[i] +": "+ t);



  }
}

/*
  
 
 
 
 for (int st =0; st<stateName.length; st++) {
 stateTable = new Table();
 stateTable.addColumn("id");
 
 for (int i=0; i<256; i++) {
 stateTable.addColumn(str(i));
 }
 
 for (TableRow i : table.rows ()) {
 if (stateName[st].equals(i.getString("state"))) {
 TableRow newRow = stateTable.addRow();
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
 TableRow newRow = stateTable.addRow();
 newRow.setString("id", "avrg");
 int[] avrg = new int[256];
 
 for (int jj =0; jj<stateTable.getRowCount ()-1; jj++) {
 
 for (int ii=0; ii<256; ii++) {
 
 avrg[ii] += stateTable.getInt(jj, str(ii));
 }
 }
 for (int k =0; k<256; k++) {
 int totalRow = (int)avrg[k] / (stateTable.getRowCount()-1);
 newRow.setInt(str(k), totalRow );
 }
 println(stateName[st]);
 saveTable(stateTable, "../../data/state_"+stateName[st]+".csv");
 }
 }
 
 void draw() {
 }
 
/*
 "Florida", "Massachusetts","New York","Arkansas","Utah","Colorado","Montana","Illinois","Michigan","California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut",  "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
 */
