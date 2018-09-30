import java.util.Date;
PImage Playground;
SecondApplet sa = new SecondApplet();
float mx,my;
float display_scale = 500.0; // pixels per meter'
float time_step = 0.0001;
dif_robot bot = new dif_robot();
void settings () {
  size(1200, 750);

}
void setup() {
  frameRate(20);

  //Playground = loadShape("bot1.svg");
  load_Playground();
  cursor(CROSS);
  
  String[] args = {"TwoFrameTest"};
  //
  PApplet.runSketch(args, sa);
}




void draw() {
  //background(0);
  image(Playground, 0, 0, 2.4*display_scale, 1.5*display_scale);  
  noStroke();
  fill(255, 127);
  rectMode(CORNER);
  rect(width-100, height-25, 100, 25);
  textAlign(LEFT, CENTER);
  fill(0, 200);
  text(str(mouseX*2)+","+str(mouseY*2), width-75, height-25/2);
  rectMode(CENTER);
  stroke(0);
  fill(#00EAD5);
  rect(mouseX, mouseY, 150/2, 150/2);
  mx = mouseX;
  my = mouseY;
  
  for(int i = 0;i<(1.0/time_step)/20;i++){
    bot.state_update();
  }
  bot.draw();
  
  
}

void load_Playground() {
  String path = sketchPath()+"/data/Playground/";
  String[] filenames = listFileNames(path);
  //printArray(filenames);
  Playground = loadImage(path+filenames[0]);
  //Playground.disableStyle();
  //println("Load Playground = "+filenames[0]);
}

public class SecondApplet extends PApplet {

  public void settings() {
    size(200, 100);
  }
  public void draw() {
    background(255);
    fill(0);
    ellipse(100, 50, 10, 10);
    text(str(mx*2)+","+str(my *2), width/2, height/2);
  }
}