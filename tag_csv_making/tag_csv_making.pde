Table table;
Table hashTagTable;
PImage img;

String  hashTag;

void setup() {

  hashTag ="beer";
  table = loadTable("../../data/usa_10_total.csv", "header");
  //no, id,lat,lon,url,created_time,tags,state,city,sd,go

  hashTagTable = new Table();
  hashTagTable.addColumn("id");

  for (int i=0; i<256; i++) {
    hashTagTable.addColumn(str(i));
  }

  for (TableRow i : table.rows ()) {
    String tags = i.getString("tags");
    String[] tagsList = tags.split("-");

    for (int t=0; t<tagsList.length; t++) {
      if (hashTag.equals(tagsList[t])) {
        TableRow newRow = hashTagTable.addRow();
        newRow.setInt("id", i.getInt("no"));
        //hue list
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
  }
  println(hashTag);
  saveTable(hashTagTable, "../../data/tag/"+hashTag+".csv");
}


void draw() {
}

/*
"Florida", "Massachusetts","New York","Arkansas","Utah","Colorado","Montana","Illinois","Michigan","California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut",  "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
 */
