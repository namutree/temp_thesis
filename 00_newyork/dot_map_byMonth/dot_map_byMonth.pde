Table table;
PImage pImg;
int monthInput;

float latMax, latMin, lonMax, lonMin;

void setup() {

  table = loadTable("../../../data/ny/usa_ny_wo_tagNurl.csv", "header");
  pImg = loadImage("../../../data/ny/point.png");


  //# ny
  //# lat 40.903939, lon -73.694036 
  //# lat 40.481192, lon -74.280432

  latMax= 40.903939;
  latMin= 40.481192;
  lonMax= -73.694036;
  lonMin= -74.280432;

  float w = (lonMax - lonMin)*1110*2;//*3;
  float h = (latMax - latMin)*1110*2;//*3;

  size((int)w, (int)h);
  println("w:", w, ", h:", h);
}
//0  1   2   3
//id,lat,lon,created_time

void draw() {

  background(0);
  for (TableRow t : table.rows ()) {
    int id = t.getInt("id");
    String times = t.getString("created_time");
    String[] timesS = times.split("-");
    int month = int (timesS[1]);
//if(id % 3000==0) println(times, month);
    if (month == monthInput) {
      float lat = t.getFloat("lat"); //y
      float lon = t.getFloat("lon"); //x
      lat = map(lat, latMin, latMax, height, 0);
      lon = map(lon, lonMin, lonMax, 0, width);

      noStroke();
      fill(255, 20);
      pushMatrix();
      {
        translate(lon, lat);//+random(-2, 2));
        ellipse(0, 0, 5, 5);
        //tint(255, 100);
        //image(pImg, 0, 0);
      }
      popMatrix();
    }
  }
  save("../../../data/ny/map_dot_byMonth"+str(monthInput)+".jpg");
  //println("done"); 
  //noLoop();
}

void keyPressed(){
 if(key == '1')  monthInput =1;
 if(key == '2')  monthInput =2;
 if(key == '3')  monthInput =3;
 if(key == '4')  monthInput =4;
 if(key == '5')  monthInput =5;
 if(key == '6')  monthInput =6;
 if(key == '7')  monthInput =7;
 if(key == '8')  monthInput =8;
 if(key == '9')  monthInput =9;
 if(key == 'q')  monthInput =10;
 if(key == 'w')  monthInput =11;
 if(key == 'e')  monthInput =12;
}
