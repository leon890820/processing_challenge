blob[] blobs=new blob[10];
void setup(){
  size(600,600);
  colorMode(HSB);
  for(int i=0;i<blobs.length;i+=1){
    blobs[i]=new blob(random(0,width),random(0,height),random(10,40));
  }
}
void draw(){
  background(0);
  loadPixels();
  for(int x=0;x<width;x+=1){
    for(int y=0;y<height;y+=1){
      int index=x+y*width;
      float sum=0;
      for(blob b:blobs){
        float d=dist(x,y,b.pos.x,b.pos.y);
      //d=map(d,0,300*1.414,0,255);
        sum +=100*blobs[0].r/d;
      }
      pixels[index]=color(sum,255,255);
     
    }
  }
  
  updatePixels();
  for(int i=0;i<blobs.length;i+=1){
   blobs[i].run();
  }
}
