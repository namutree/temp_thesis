Table table;
PFont font;

String[]  stateName= { 
  "Florida", "Massachusetts", "New York", "Arkansas", "Utah", "Colorado", "Montana", "Illinois", "Michigan", "California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut", "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
};
int[][] hueAverage = new int[stateName.length][256];
int[] totalAverage = new int[256];
int hueSubNo;
String saveName;

String state01, state02; 

void setup() {
  size(1280, 720);
  stateName = sort(stateName);
  textAlign(LEFT, CENTER);
  font = loadFont("HelveticaNeue-UltraLight-23.vlw");
  textFont(font, 12);

  for (int i =0; i <stateName.length; i++) {
    table = loadTable("../../data/state/state_"+stateName[i]+".csv", "header");

    for (int j=0; j<256; j++) {
      hueAverage[i][j] = table.getInt(table.getRowCount()-1, str(j));
      totalAverage[j] += hueAverage[i][j];
    }
  }

  for (int i=0; i<totalAverage.length; i++) {
    totalAverage[i] = totalAverage[i]/stateName.length;
  }
}


void draw() {
  colorMode(RGB);
  background(255);
  saveName ="00";

  //vertical lines
  stroke(0, 20);
  for (int j=0; j<256; j++) {
    float x = map(j, 0, 255, 150, width-10);
    line(x, 50, x, height-50);
  }

  int[] pickedHue = new int[256];
  hueSubNo = -1;
  for (int i =0; i <stateName.length; i++) {
    float y = map(i, 0, stateName.length-1, 50, height-50);
    for (int j=0; j<256; j++) {
      if (mouseY<y+6 && mouseY>y-6) {
        pickedHue[j] = hueAverage[i][j];
        hueSubNo=i;
        saveName = stateName[i];
      }
    }
  }



  //total average
  fill(0, 180);
  text("average", 10, 20);
  for (int i=0; i<totalAverage.length; i++) {
    float r = totalAverage[i];
    float x = map(i, 0, 255, 150, width-10);
    colorMode(HSB);
    fill(i, 255, 255, 100);
    ellipse(x, 20, r/4, r/4);
    if (mouseY<20+6 && mouseY>20-6) {
      pickedHue[i] = totalAverage[i];
//      hueSubNo=i;
      saveName = "0average";
    }
  }


  for (int i =0; i <stateName.length; i++) {

    float y = map(i, 0, stateName.length-1, 50, height-50);

    if (i ==hueSubNo) fill (0, 255);
    else    fill(0, 150);
    text(stateName[i], 10, y);

    if (i ==hueSubNo) stroke(0, 250);
    else stroke(0, 30);
    line(12+ textWidth(stateName[i]), y, width-10, y);

    stroke(0, 10);
    for (int j=0; j<256; j++) {
      float r = hueAverage[i][j] - pickedHue[j];
      
      float x = map(j, 0, 255, 150, width-10);
      colorMode(HSB);
      if (r>0) fill(j, 255, 255, 100);
      else {
        fill(0,200);
        r = -r;
      }
      ellipse(x, y, r/4, r/4);
    }
  }
}

void mouseClicked() {
  save("../../data/state_table_"+saveName+".jpg");
}

