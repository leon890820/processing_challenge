float a=PI/4;

void setup(){
  size(500,500);
}
void draw(){
  a=map(mouseX,0,width,-PI,PI);
  background(0);
  translate(width/2,height);
  brench(100);
}
void brench(float len){
  stroke(255); 
  line(0,0,0,-len);
  translate(0,-len);
  
 
  if(len>4){
    pushMatrix(); 
    rotate(a);
    brench(len*0.8);
    popMatrix();
    pushMatrix(); 
    rotate(-a);
    brench(len*0.8);
    popMatrix();
  }
  
}
