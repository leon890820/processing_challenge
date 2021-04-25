Robot turtleBot;
Target target;
int scanNum=24;
int observation=scanNum+2;
int action=5;
boolean debug=false;
void setup() {
  size(800, 800);
  background(0);
  turtleBot=new Robot();
  target=new Target();
}
void draw() {
  background(0);
  turtleBot.scan();
  turtleBot.show();
  turtleBot.move();

  target.show();
  myKeyPressed();
}
void myKeyPressed() {
  if (keyPressed) {
    if (key=='p') debug=!debug;
    if (debug) {
      if (key=='a') {
        turtleBot.oriented-=0.02;
      }
      if (key=='d') {
        turtleBot.oriented+=0.02;
      }
    }
  }
}
