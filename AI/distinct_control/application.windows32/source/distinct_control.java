import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.File; 
import java.io.FileWriter; 
import java.io.IOException; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class distinct_control extends PApplet {

  



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
public void setup(){
  
  
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
public void draw(){
  scale(scleNumber);
  //translate(width/(2*scleNumber),height/(2*scleNumber));
  background(0);
  if(menu) menu();
  else if (runSkectch) runSketch();
  
}

public float mapTheX(float x){
  return map(x,-10,60,map[0],map[1]);
}
public float mapTheY(float y){
  return map(y,-10,60,map[2],map[3]);  

}
public float mapTheR(float r){
  return r*600/70;

}
public void keyp(){
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
    vehicle.position.add(dir.mult(0.1f));
  }
  else if(key=='s'||key=='S'){
    float a=map(vehicle.oriented,0,360,0,2*PI);
    PVector dir=new PVector(cos(a),sin(a));
    vehicle.position.sub(dir.mult(0.1f));
  }
  
  
  }
}
public void keyPressed(){
  if(key=='r'||key=='R'){
    setup();
  }


}

public void menu(){
  frameRate(60);
  start.show();
  start.run("start");
  record1.show();
  record1.run("record1");
  record2.show();
  record2.run("record2");
  

}
public void runSketch(){
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

public boolean pnpoly(float x, float y, Box b) {
  boolean c=false;

  for (int i=0, j=b.vertex.length-1; i<b.vertex.length; j=i++) {
    if (((b.vertex[i].y>y)!=(b.vertex[j].y>y))&&(x<(b.vertex[j].x-b.vertex[i].x)*(y-b.vertex[i].y)/(b.vertex[j].y-b.vertex[i].y)+b.vertex[i].x)) {
      c=!c;
    }
  }
  b.touch=c;
  return c;
}
class Boundary{
  PVector start;
  PVector end;
  Boundary(float x1,float x2,float x3,float x4){
    start=new PVector(x1,x2);
    end=new PVector(x3,x4);  
  }
  public void show(){
    stroke(255);
    strokeWeight(1);
    line(mapTheX(start.x),mapTheY(start.y),mapTheX(end.x),mapTheY(end.y));
    
  }
}
class Box {
  PVector position;
  float width;
  float height;
  float angle;
  boolean touch;
  boolean drag;
  boolean collision;
  Vector[] vertex;
  Vector[] vertexLine;
  Vector[] orginalVertex;
  Box(float x, float y, float w, float h, float a) {
    vertex=new Vector[4];
    vertexLine=new Vector[4];
    position=new PVector(x, y);
    this.width=w;
    this.height=h;  
    angle=a;
    drag=false;
    collision=false;
    createVertex();
  }
  Box(Vector[] v,float x, float y,float a){
    orginalVertex=v;
    vertexLine=new Vector[v.length];
    vertex=new Vector[v.length];
    position=new PVector(x, y);
    angle=a;  
    for(int i=0;i<v.length;i+=1){
      vertex[i]=new Vector(orginalVertex[i].x,orginalVertex[i].y);
    }
    for (int i=0; i<vertex.length; i+=1) {
      vertex[i].rotate(angle);
      vertex[i].translate(position);
    }
    
    for(int i=0,j=vertexLine.length-1;i<vertexLine.length;j=i++){
      vertexLine[i]=new Vector(vertex[j].x-vertex[i].x,vertex[j].y-vertex[i].y);
    }
  }
  public void show() {  
    createVectorForMore();
    if (touch)fill(255, 0, 0);
    else if(collision)fill(255,255,0);
    else fill(255);
    if (drag) stroke(0, 255, 0);
    else noStroke();
    stroke(255);
    noFill();
    beginShape();
    for (int i=0; i<vertex.length; i+=1) {
      vertex(mapTheX(vertex[i].x), mapTheY(vertex[i].y));
    }
    endShape(CLOSE);
  }
  public void update() {
    //if(touch==false) drag=false;
    drag();    
    angle+=random(-0.01f,0.1f);
    collision=false;

    //if (mousePressed==false) {
    //  drag=false;
    //} else {
    //  if (touch) {
    //    drag=true;
    //  }
    //}
  }
  public void drag() {
    if (drag) {
      PVector v=new PVector(mouseX-pmouseX, mouseY-pmouseY);
      position.add(v);
    }
  }
  public void createVertex() {
    vertex[0]=new Vector(0, 0);
    vertex[1]=new Vector(0, this.height);
    vertex[2]=new Vector(this.width, this.height);
    vertex[3]=new Vector(this.width,0);
    for (int i=0; i<vertex.length; i+=1) {
      vertex[i].rotate(angle);
      vertex[i].translate(position);
    }
    for(int i=0,j=vertexLine.length-1;i<vertexLine.length;j=i++){
      vertexLine[i]=new Vector(vertex[j].x-vertex[i].x,vertex[j].y-vertex[i].y);
    }
  }
  public void createVectorForMore(){
    for(int i=0;i<vertex.length;i+=1){
      vertex[i]=new Vector(orginalVertex[i].x,orginalVertex[i].y);
    }
    for (int i=0; i<vertex.length; i+=1) {
      vertex[i].rotate(angle);
      vertex[i].translate(position);
    }
    
    for(int i=0,j=vertexLine.length-1;i<vertexLine.length;j=i++){
      vertexLine[i]=new Vector(vertex[j].x-vertex[i].x,vertex[j].y-vertex[i].y);
    }
  
  }
  
  
  public void projectOnLine(PVector pl){
    for(Vector v:vertex){
      PVector pp=v.projectOnto(pl);
      fill(0,0,255);
      circle(pp.x,pp.y,5);
    }  
  }
  public float[] projectOnLineMaxAndMin(PVector pl){
    float maxRecord=-100000000;
    float minRecord=100000000;
    PVector minV=new PVector();
    PVector maxV=new PVector();
    for(Vector v:vertex){
      PVector pp=v.projectOnto(pl);
      float ff=v.projectOntoLength(pl);
      if(ff>maxRecord){
        maxRecord=ff;
        maxV=pp.copy();
      }
      if(ff<minRecord){
        minRecord=ff;
        minV=pp.copy();
      }
    }
    fill(0,0,255);
    //circle(minV.x,minV.y,5);
    //circle(maxV.x,maxV.y,5);
    float[] result={minRecord,maxRecord};
    return result;
  }
  
}
class Vector {
  float x;
  float y;
  Vector(float _x, float _y) {
    x=_x;
    y=_y;
  }
  public void rotate(float a) {
    float newx=cos(a)*x-sin(a)*y;
    float newy=sin(a)*x+cos(a)*y;
    x=newx;
    y=newy;
  }
  public void translate(PVector p){
    x+=p.x;
    y+=p.y;
  }
  
  public float projectOntoLength(PVector p){
    float a=(x*p.x+y*p.y)/(p.magSq());
    return a;  
  }
  public PVector projectOnto(PVector p){
    float a=(x*p.x+y*p.y)/(p.magSq());
    PVector r=p.copy();
    return r.mult(a);  
  }
  public PVector getNormal(){
    return new PVector(y,-x);
  
  }
}
class Button {
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  float r;
  boolean touch=false;
  boolean pressed=false;
  Button(String _name, float _x, float _y, int _num, float _len, float _hei,float _r) {
    name=_name;
    position=new PVector(_x, _y);
    num=_num;
    len=_len;
    hei=_hei;
    r=_r;
    pp=position.copy();
  }
  public void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    //strokeWeight(4);
    //rect(position.x, position.y, len, hei);
    smoothRect(position.x, position.y, len, hei,r);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  
  public void smoothRect(float x,float y,float l,float h,float r){
    float prx=x+l/2-r;
    float nrx=x-l/2+r;
    float pry=y+h/2-r;
    float nry=y-h/2+r;
    
    
    beginShape();
    vertex(nrx,nry-r);
    vertex(prx,nry-r);
    quarterCircle(prx,nry,-PI/2,0,r);
    vertex(prx+r,nry);
    vertex(prx+r,pry);
    quarterCircle(prx,pry,0,PI/2,r);
    vertex(prx,pry+r);
    vertex(nrx,pry+r);
    quarterCircle(nrx,pry,PI/2,PI,r);
    vertex(nrx-r,pry);
    vertex(nrx-r,nry);
    quarterCircle(nrx,nry,PI,3*PI/2,r);
    endShape(CLOSE);
  
  
  }
  public void quarterCircle(float x,float y,float sa,float ea,float r){
    for(int i=0;i<=90;i+=1){
      float theda=map(i,0,90,sa,ea);
      
      vertex(x+(r)*cos(theda),y+(r)*sin(theda));
    }
  }
  
  public void run(String s) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        // here the code
        if(s=="start"){
          menu=false;
          runSkectch=true;
        }
        else if(s=="record1"){
          menu=false;
          runSkectch=true;
          record=true;
        }
        else if(s=="record2"){
          menu=false;
          runSkectch=true;
          record=true;
        }
        
        pressed=true;
      }
    } else pressed=false;
  }
  
}
class Fuzzy {
  float[] DF_FS;
  float[] DRL_FS;
  Fuzzy() {
    DF_FS=new float[3];
    DRL_FS=new float[3];
  }

  public float getTheda(float l, float f, float r) {
    float turn_left = -20;
    float turn_right = 20;
    DF_FS[0]=FS_Fuzzy(f);
    DF_FS[1]=FM_Fuzzy(f);
    DF_FS[2]=FL_Fuzzy(f);
    float o=r-l;
    DRL_FS[0]=OS_Fuzzy(o);
    DRL_FS[1]=OM_Fuzzy(o);
    DRL_FS[2]=OL_Fuzzy(o);
    float[] ALL_FS=new float[9];
    for (int i=0; i<DF_FS.length; i+=1) {
      for (int j=0; j<DRL_FS.length; j+=1) {
        int index=3*i+j;
        ALL_FS[index]=min(DF_FS[i], DRL_FS[j]);
      }
    }
    float AF=0;
    for (int i=0; i<ALL_FS.length; i+=1) {
      AF+=ALL_FS[i];
    }
    float drive=(ALL_FS[0]*turn_left+ALL_FS[1]*(-5)+ALL_FS[2]*turn_right+ALL_FS[3]*turn_left+ALL_FS[4]*(0)+ALL_FS[5]*turn_right+ALL_FS[6]*turn_left+ALL_FS[7]*(0)+ALL_FS[8]*turn_right)/AF;
    drive = max(min(drive, 40), -40);
    return drive;
  }


  public float FS_Fuzzy(float x) {
    if (x<=3) return 1;
    else if (x<=4) return -x+4;
    else return 0;
  }
  public float FM_Fuzzy(float x) {
    if (x<=4 && x>=3) return x-3;
    else if (x<=5 && x>4) return -x+4;
    else return 0;
  }
  public float FL_Fuzzy(float x) {
    if (x>=5) return 1;
    else if (x>=4) return x-4;
    else return 0;
  }

  public float OS_Fuzzy(float x) {
    if (x<=-4) return 1;
    else if (x<=0) return -x/4;
    else return 0;
  }
  public float OM_Fuzzy(float x) {
    if (x<=0 && x>=-4) return x/4+1;
    else if (x>0 && x<=4) return -x/4+1;
    else return 0;
  }
  public float OL_Fuzzy(float x) {
    if (x>=4) return 1;
    else if (x>=0) return x/4;
    else return 0;
  }
}
class Ray{
  PVector position;
  PVector dir;
  float oriented;
  Ray(float x,float y,float _a){
    position=new PVector(x,y);
    oriented=_a+theda;
    float a=map(oriented,0,360,0,2*PI);
    dir=new PVector(cos(a),sin(a));
  }
  public PVector show(Boundary wall) {
    float o=map(oriented+theda,0,360,0,2*PI);
    dir=new PVector(cos(o),sin(o));
    return checkwall(wall);
  }
    

  public PVector checkwall(Boundary wall) {
    float x3=position.x;
    float y3=position.y;
    float x4=position.x+dir.x;
    float y4=position.y+dir.y;
    float x1=wall.start.x;
    float y1=wall.start.y;
    float x2=wall.end.x;
    float y2=wall.end.y;

    float delta=(x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
    if (delta==0) return null;
    float t=((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/delta;
    float u=((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/delta;
    if (t>0 && t<1 && u>0) {
      float px=x1+t*(x2-x1);
      float py=y1+t*(y2-y1);
      return new PVector(px,py);
    } else return null;
  }
  
}
class Vehicle{
  PVector position;
  float oriented;
  float radius;
  float drive;
  Ray[] ray=new Ray[3];
  float[] distanceToWall=new float[ray.length];
  Vehicle(float _x,float _y,float _o){
    position=new PVector(_x,_y);
    oriented=_o;  
    radius=3;
    drive=0;
    for(int i=0;i<ray.length;i+=1){
      //float o=map(oriented,0,360,0,2*PI);
      float a=map(i,0,ray.length-1,-45+oriented,45+oriented);
      ray[i]=new Ray(position.x,position.y,a);
    }
  }
  public void show(){
    noFill();
    stroke(255);
    strokeWeight(1);
    oriented=90+theda;
    float a=map(oriented,0,360,0,2*PI);
    line(mapTheX(position.x),mapTheY(position.y),mapTheX(position.x+radius*cos(a)),mapTheY(position.y+radius*sin(a)));
    circle(mapTheX(position.x),mapTheY(position.y),mapTheR(radius*2));
    int count=0;
    for(Ray r:ray){
      r.position=new PVector(position.x,position.y);
      float record=100000;
      PVector mb=null;
      
      for(Boundary b:boundary){
        PVector pt=r.show(b);
        if(pt==null) continue;
        float d=dist(pt.x,pt.y,position.x,position.y);
        if(record>d){
          record=d;
          mb=pt.copy();
        }
      }
     
      if(mb==null) continue;
      stroke(255);
      line(mapTheX(mb.x),mapTheY(mb.y),mapTheX(position.x),mapTheY(position.y));
      fill(255);
      circle(mapTheX(mb.x),mapTheY(mb.y),6);
      distanceToWall[count]=dist(mb.x,mb.y,position.x,position.y);
      count+=1;
    }
  
  }
  
  public void saveDate(){
    println("123");
    train4D.println(distanceToWall[1]+" "+distanceToWall[2]+" "+distanceToWall[0]+" "+drive);
    train6D.println(position.x+" "+position.y+" "+distanceToWall[1]+" "+distanceToWall[2]+" "+distanceToWall[0]+" "+drive);
    
    //saveStrings("data/train4D.txt",s);
    
  
  }
  
  public void autoMove(){
    drive=fuzzy.getTheda(distanceToWall[0],distanceToWall[1],distanceToWall[2]);
    theda+=drive;
    float deltaX=cos(radians(oriented)+radians(drive))+sin(radians(oriented))*sin(radians(drive));
    float deltaY=sin(radians(oriented)+radians(drive))-sin(radians(drive))*cos(radians(oriented));
    float delta_oriented=asin(2*sin(radians(drive))/6);
    
    oriented+=-delta_oriented;
    position=new PVector(position.x+deltaX,position.y+deltaY);
  
  
  }
  
  public void recordMove(){
    String[] s=recordPath[countPath].split(" ");
    position=new PVector(PApplet.parseFloat(s[0]),PApplet.parseFloat(s[1]));
    drive=PApplet.parseFloat(s[5]);
    theda+=drive;
    countPath+=1;
    
  }


}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "distinct_control" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
