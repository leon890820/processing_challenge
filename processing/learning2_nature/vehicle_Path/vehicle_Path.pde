ArrayList<car> c;
boolean debug=true;
path p;
void setup(){
  size(640,360);
  c=new ArrayList<car>();
  p=new path();
  newPath();
}
void draw(){
  background(255);
  p.display();
  if(mousePressed){
    c.add(new car(new PVector(mouseX,mouseY)));
  }
  for(car c1:c){
    c1.run();
    c1.follow(p);
    c1.border(p);
  }
}
public void keyPressed() {
  if (key == ' ') {
    debug = !debug;
  }
  if (key=='k'){  
    newPath();
  }
}
void newPath(){
  float n=(int)random(3,10);
  p = new path();
  p.addpoint(-20, height/2);
  for(int i=0;i<4;i+=1){
  p.addpoint(random(i*width/n, (i+1)*width/n), random(0, height));
  //p.addpoint(random(width/2, width), random(0, height));
  }
  p.addpoint(width+20, height/2);   
}


  
  
  
