int rows,culs;
int scl=10;
float[][] terrain;
float s=0;
void setup(){
  size(600,600,P3D);
  rows=600/scl;
  culs=600/scl;
  terrain= new float[culs][rows];
  float xoff=0;
  for(int x=0;x<rows;x+=1){
    float yoff=0;
    for(int y=0;y<culs;y+=1){
      terrain[x][y]=map(noise(xoff,yoff),0,1,-50,50);
      yoff+=0.1;
    }
    xoff+=0.1;
  }
}
void draw(){
  background(0);
  stroke(255);
  noFill();
  translate(width/2,width/2);
  rotateX(PI/3);
  translate(-300,-300);
  for(int y=0;y<rows-1;y+=1){
    beginShape(TRIANGLE_STRIP);
    for(int x=0;x<culs;x+=1){
      vertex(x*scl,y*scl,terrain[x][y],scl,scl);
      vertex(x*scl,(y+1)*scl,terrain[x][y+1],scl,scl);
        
    }
    endShape();
  }
  fly();
  s-=0.1;
}
void fly(){
  float xoff=0;
  for(int x=0;x<rows;x+=1){
    float yoff=s;
    for(int y=0;y<culs;y+=1){
      terrain[x][y]=map(noise(xoff,yoff),0,1,-100,100);
      yoff+=0.15;
    }
    xoff+=0.15;
  }
}
