import java.util.Date;
PImage Playground;
void setup() {
  size(1200, 800);
  //Playground = loadShape("bot1.svg");
  load_Playground();
}




void draw() {
  //background(0);
  image(Playground, 0, 0, width, height);  // Draw at coordinate (110, 90) at size 100 x 100
}

void load_Playground() {
  String path = sketchPath()+"/data/Playground/";
  String[] filenames = listFileNames(path);
  //printArray(filenames);
  Playground = loadImage(path+filenames[0]);
  //Playground.disableStyle();
  println("Load Playground = "+filenames[0]);
}