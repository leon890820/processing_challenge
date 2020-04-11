float y;
boolean up=true;
void setup(){
size(640,360);
stroke(255);
y=height*0.5;

}
void draw(){
  background(0);
  line(0,y,width,y);
  if (y>height){
    up=true;    
  }
  if(y<0){
    up=false;
  } 
  if(up==true){
    y-=1;
  }
  else{
    y+=1;
  
  }
  
}
