Table table;
int filename;
IntDict counter = new IntDict();
String whatDay;
float latMax, latMin, lonMax, lonMin;
PImage maskImage;

void setup() {
  //# USA
  //# 49.265911, -125.517483
  //# 26.743020, -64.872955
  //  #revised USA
  //# 49.265911, -125.517483
  //# 24.584452, -64.872955

  latMax= 49.265911;
  latMin= 24.584452;
  lonMax= -64.872955;
  lonMin= -125.517483;

  float w = (lonMax - lonMin)*1110/5.5/11;
  float h = (latMax - latMin)*1110/4/11;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);

  whatDay="asdfqqq";
  maskImage = loadImage("../../data/mask.jpg");
}

void draw() {
  colorMode(RGB, 255);
  background(255);
  tagsDay();
  save("../../data/"+whatDay+".jpg");
}


void tagsDay() {
  randomSeed(0);
  text(whatDay +"....", 10, 10);
  int cvsNo;
  cvsNo = 9;
  for (int i=0; i<=cvsNo; i++) {
    filename = i;
    if (i<10) table = loadTable("../../data/usa_0"+str(filename)+".csv", "header");
    else table = loadTable("../../data/usa_"+str(filename)+".csv", "header");

    //    0  2   3   4   5            6    7     8    9  10
    //    id,lat,lon,url,created_time,tags,state,city,sd,go
    int count;
    count =0;
    float xValue=0;
    for (TableRow j : table.rows ()) {
      String tags = j.getString("tags");
      String[] words = tags.split("-");
      for (String w : words) {
        String lcw = w.toLowerCase();

        counter.increment(lcw);
        
        
        if (lcw.equals(whatDay) && j.getFloat("go")==1) {
          //xValue++;
          if (count%11==0 || count%12==0) println(i+" "+count+"/"+table.getRowCount());
          float lat = j.getFloat("lat");
          float lon = j.getFloat("lon");
          lat = map(lat, latMin, latMax, height, 0);
          lon = map(lon, lonMin, lonMax, 0, width);

          PImage img;
          try {
            img = loadImage(j.getString("url")); //url
            img.resize(200, 200);
          }
          catch(Exception e) {
            println(e); 
            img = loadImage("../../data/white_w_pic.jpg");
            img.resize(200, 200);
          }
          
          colorMode(HSB, 255);
          fill(HueHist(img), 255, 255, 50);
          xValue = map(float(HueHist(img)), 0, 255, 15, height-15);
          img.resize(3,3);
          //println(HueHist(img));
          imageMode(CENTER);
          noStroke();
          pushMatrix();
          {
            //translate(lon +random(-5, 5), lat+random(-5, 5));
            
            translate(lon+random(-5, 5), xValue);
            tint(255,100);
            img.resize(10,10);
            maskImage.resize(10,10);
            img.mask(maskImage);
            image(img,0,0);
            
            ellipse(0, 0, 10, 10);
          }
          popMatrix();
        }
      }
      count++;
    }
  }
  colorMode(RGB);
  fill(0);
  text(whatDay +"done", 10, 20);
}


int HueHist(PImage hue) {
  int[] hueHist = new int[256];
  for (int i = 0; i < hue.width; i++) {
    for (int j = 0; j < hue.height; j++) {
      int loc = i + j*hue.width;
      int hueY = int(hue(hue.pixels[loc]));
      hueHist[hueY]++;
    }
  }
  int histMax = max(hueHist);
  int aa;
  aa=0;
  for (int i=0; i<hueHist.length; i++) {
    if (hueHist[i] == histMax) aa = i;
  }
  
  //color cc = color(aa, 100, 100,50);
  fill(aa, 255, 255, 100);
  return aa;
}

void keyPressed() {
  if (key == 'm') whatDay = "monday";
  if (key == 't') whatDay = "tuesday";
  if (key == 'w') whatDay = "wednesday";
  if (key == 'T') whatDay = "thursday";
  if (key == 'f') whatDay = "friday";
  if (key == 's') whatDay = "saturday";
  if (key == 'S') whatDay = "sunday";
}


/*  finding the day of the week algorithm!!!!!
String[] dayName = { 
  "Sunday", "Monday", "Tuesday", "Wednesday", 
  "Thursday", "Friday", "Saturday"
};
int w;
 
void setup() {
  w = dow(26, 2, 2015);
  println(w + "  " + dayName[w] );
}
 
// d = day in month
// m = month (January = 1 : December = 12)
// y = 4 digit year
// Returns 0 = Sunday .. 6 = Saturday

int dow(int d, int m, int y) {
  if (m < 3) {
    m += 12;
    y--;
  }
  return (d + int((m+1)*2.6) +  y + int(y/4) + 6*int(y/100) + int(y/400) + 6) % 7;
}
*/
