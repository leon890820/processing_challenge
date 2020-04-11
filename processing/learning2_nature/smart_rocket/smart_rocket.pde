population populations;
float lifetime;
int lifecount;
int rnum=100;
float mutationrate=0.01;
PVector target; 
void setup(){
  size(640,360);
  lifetime=height;
  populations=new population(rnum);
  target=new PVector(width/2,20);
}
void draw(){
    background(255);
    fill(0);
    circle(target.x,target.y,24);
  if(lifetime>lifecount){
    //print(lifecount);
    populations.live();
    lifecount+=1;
  }
  else{
    lifecount=0;
    populations.fitness();
    populations.selection();
    populations.reproduction();
  }
  
  
}
void mousePressed(){
  target=new PVector (mouseX,mouseY);    
}
