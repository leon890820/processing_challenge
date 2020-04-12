import peasy.*;
PeasyCam cam;
int total=100;
PVector[][] global;
float a=1;
float b=1;
float an=0;
float m11=0;
float m12=5;
float mc=0;
float n11=0.479398;
float n12=30.2539;
float n13=0.3563;
float n21=15.4425;
float n22=-0.453763;
float n23=87.077;
void setup(){
  size(600,600,P3D);
  cam=new PeasyCam(this,200);
  global=new PVector[total+2][total+2];
  colorMode(HSB);
}
void draw(){
  background(0);
  fill(255);
  lights();
  float m1=map(sin(mc),-1,1,0,m11);
  float m2=map(sin(mc),-1,1,0,m12);
  mc+=0.03;
  //translate(width/2,height/2);
  //sphere(200);
  float r=200;
  
  for(int j=0;j<total+2;j+=1){
    float lon=map(j,0,total,-PI/2,PI/2);
    
    for(int i=0;i<total+2;i+=1){
      float lat=map(i,0,total,-PI,PI);
      float r1=supershape(lat,m1,n11,n12,n13);
      float r2=supershape(lon,m2,n21,n22,n23);
      float x=r*r1*r2*cos(lon)*cos(lat);
      float y=r*r1*r2*cos(lon)*sin(lat);
      float z=r*r2*sin(lon);
      global[j][i]=new PVector(x,y,z);
      PVector v=PVector.random3D();
      v.mult(10);
     // global[j][i].add(v);
      
    }
    
  }
  
  for(int j=0;j<total+1;j+=1){
    
    beginShape(TRIANGLE_STRIP);
    for(int i=0;i<total+2;i+=1){ 
      float hu= map(j,0,total,0,600);
      //stroke(255);
      //fill(255);
      fill((hu+an)%255,255,255);
      PVector v1=global[j][i];
      noStroke();
      vertex(v1.x,v1.y,v1.z);
      PVector v2=global[j+1][i];
      vertex(v2.x,v2.y,v2.z);
    }
    endShape();
  }
  an+=5;
}
float supershape(float theda,float m,float n1,float n2,float n3){
  float t1=pow(abs(cos(m*theda/4)/a),n2);
  float t2=pow(abs(sin(m*theda/4)/b),n3);
  float r=pow(t1+t2,-1/n1);
  
  return r;
}
