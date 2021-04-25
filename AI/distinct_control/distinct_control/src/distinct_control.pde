import java.io.File;  
import java.io.FileWriter;
import java.io.IOException;

boolean debug=true;
float theda;
Vehicle vehicle;
float scleNumber=1;
JSONObject boundaryData;
Boundary[] boundary;
float[] map={0,600,600,0};
Fuzzy fuzzy;
Box endPoint;
boolean isTarget=false;
boolean menu=true;
boolean runSkectch=false;
boolean record=false;
Button start;
Button record1;
Button record2;
PrintWriter train4D;
PrintWriter train6D;
String[] recordPath;
int countPath=0;
void setup(){
  size(600,600);
  
  recordPath=loadStrings("data/train6D.txt");
  train4D = createWriter("data/train4D.txt"); 
  train6D=createWriter("data/train6D.txt");
  boundaryData=loadJSONObject("case.json");
  JSONObject p=boundaryData.getJSONObject("boundary");
  boundary=new Boundary[p.getJSONArray("x").size()];
  for(int i=0;i<boundary.length;i+=1){
    boundary[i]=new Boundary(p.getJSONArray("x").getFloat(i),p.getJSONArray("y").getFloat(i),p.getJSONArray("x").getFloat((i+1)%boundary.length),p.getJSONArray("y").getFloat((i+1)%boundary.length));
  }
  JSONObject ep=boundaryData.getJSONObject("endPoint");
  Vector[] endPointVector=new Vector[ep.getJSONArray("x").size()];
  for(int i=0;i<endPointVector.length;i+=1){
    endPointVector[i]=new Vector(ep.getJSONArray("x").getFloat(i),ep.getJSONArray("y").getFloat(i));
  }
  endPoint=new Box(endPointVector,0,0,0);
  vehicle=new Vehicle(0,0,90);
  fuzzy=new Fuzzy();
  start=new Button("Start Train",width/2,100,0,150,50,0);
  record1=new Button("train4D",width/2,300,0,150,50,0);
  record2=new Button("train6D",width/2,500,0,150,50,0);
}
void draw(){
  scale(scleNumber);
  //translate(width/(2*scleNumber),height/(2*scleNumber));
  background(0);
  if(menu) menu();
  else if (runSkectch) runSketch();
  
}

float mapTheX(float x){
  return map(x,-10,60,map[0],map[1]);
}
float mapTheY(float y){
  return map(y,-10,60,map[2],map[3]);  

}
float mapTheR(float r){
  return r*600/70;

}
void keyp(){
  if(keyPressed){
    if(key=='a'||key=='A'){
    theda+=10;
    println(vehicle.oriented);
  }
  else if(key=='d'||key=='D'){
    theda-=10;
  }
  else if(key=='w'||key=='W'){
    float a=map(vehicle.oriented,0,360,0,2*PI);
    PVector dir=new PVector(cos(a),sin(a));
    vehicle.position.add(dir.mult(0.1));
  }
  else if(key=='s'||key=='S'){
    float a=map(vehicle.oriented,0,360,0,2*PI);
    PVector dir=new PVector(cos(a),sin(a));
    vehicle.position.sub(dir.mult(0.1));
  }
  
  
  }
}
void keyPressed(){
  if(key=='r'||key=='R'){
    setup();
  }


}

void menu(){
  frameRate(60);
  start.show();
  start.run("start");
  record1.show();
  record1.run("record1");
  record2.show();
  record2.run("record2");
  

}
void runSketch(){
  frameRate(10);
  for(Boundary b:boundary){
    b.show();
  }
  endPoint.show();
  if(!isTarget) {
    if(!record)vehicle.autoMove();  
    else vehicle.recordMove();    
  }
  else{
      train4D.flush(); // Writes the remaining data to the file
      train4D.close();
      train6D.flush();
      train6D.close();
    
    exit();
  }
  vehicle.saveDate();
  vehicle.show();
  //keyp();
  isTarget=pnpoly(vehicle.position.x,vehicle.position.y,endPoint);
}

boolean pnpoly(float x, float y, Box b) {
  boolean c=false;

  for (int i=0, j=b.vertex.length-1; i<b.vertex.length; j=i++) {
    if (((b.vertex[i].y>y)!=(b.vertex[j].y>y))&&(x<(b.vertex[j].x-b.vertex[i].x)*(y-b.vertex[i].y)/(b.vertex[j].y-b.vertex[i].y)+b.vertex[i].x)) {
      c=!c;
    }
  }
  b.touch=c;
  return c;
}
