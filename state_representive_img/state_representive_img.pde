Table table;
PImage img;
PImage repre_img;

String[]  stateName= { 
  "Florida", "Massachusetts", "New York", "Arkansas", "Utah", "Colorado", "Montana", "Illinois", "Michigan", "California", "Minnesota", "Washington", "Mississippi", "Pennsylvania", "Louisiana", "Alabama", "Georgia", "Arizona", "Kentucky", "Virginia", "South Carolina", "Rhode Island", "New Mexico", "Missouri", "Connecticut", "Idaho", "Texas", "Maine", "Oklahoma", "North Carolina", "Kansas", "Nevada", "Wisconsin", "Iowa", "Tennessee", "Indiana", "West Virginia", "New Jersey", "Ohio", "Maryland", "Oregon", "Vermont", "South Dakota", "New Hampshire", "District of Columbia", "Nebraska", "Wyoming", "North Dakota", "Delaware"
};

void setup() {
  img = loadImage("../../data/img/"+str((int)random(100, 150))+".jpg");
  repre_img = loadImage("../../data/img/"+str((int)random(100, 150))+".jpg");
  size(img.width, img.height+20);
}


void draw() {
  background(255);
  for (int sn =0; sn<stateName.length; sn++) {
    //id, 0 ,1,2,3,4,5,6,7,---->
    table = loadTable("../../data/state/state_"+stateName[sn]+".csv", "header");

    int number = img.height* img.width;
    float[] r = new float[number];
    float[] g = new float[number];
    float[] b = new float[number];

    for (int aa =0; aa<table.getRowCount (); aa++) {
      img = loadImage("../../data/img/"+str(table.getInt(aa, "id"))+".jpg");


      for (int i=0; i<img.width; i++) {
        for (int j=0; j<img.height; j++) {
          int loc = i + j*img.width;
          r[loc] += red(img.pixels[loc])   / table.getRowCount();
          g[loc] += green(img.pixels[loc]) / table.getRowCount();
          b[loc] += blue(img.pixels[loc])  / table.getRowCount();
        }
        println(stateName[sn], i+"/"+img.width);
      }
    }
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int loc = i + j*img.width;
        color abc = color(r[loc], g[loc], b[loc]);
        repre_img.set(i, j, abc);
      }
    }
    println(stateName[sn]+"done_ "+ sn+"/"+stateName.length);
    image(repre_img, 0, 0);
    
    fill(0);
    textAlign(CENTER, CENTER);

    text(stateName[sn] , width/2, height-10);
    save("../../data/state/repre_"+stateName[sn]+".jpg");
    background(255);
  }
  
  println("done");
  noLoop();
}

void mouseClicked() {
}

