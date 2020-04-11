square s;
ArrayList<square> ss;
void setup(){
  size(500,500,P2D);
  s=new square(0,0,400);
  ss=new ArrayList<square>();
  ss.add(s);
}
void draw(){
  background(0);
  translate(width/2,width/2);
  stroke(0);
  fill(255);
  for(square sr:ss){
    sr.display();
  }
  
}
void mousePressed(){
  ArrayList<square> next=new ArrayList<square>();
  for(int i=0;i<ss.size();i+=1){
    next.addAll(ss.get(i).generate());
  }
  ss=next;
}
