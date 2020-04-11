float i=0;
void setup(){
  size(600,600);
  background(0);
}
void draw(){
  
  loadPixels();
  for(int x=0;x<width;x+=1){
    for(int y=0;y<height;y+=1){
     
      float d=dist(width/2,height/2,x,y);
      float d1=dist(mouseX,mouseY,x,y);
      float c=map(sin(d/10+i)+sin(d1/10+i),-2,2,0,255);
      pixels[x+y*width]=color(c); 
    }
  }
  updatePixels();
  i+=-1;
  
}
