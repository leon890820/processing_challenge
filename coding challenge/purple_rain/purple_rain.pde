ArrayList<drop> d;
void setup(){
  size(640,360);
  d=new ArrayList<drop>();
  for(int i=0;i<100;i+=1){
    d.add(new drop());
  }
}

void draw(){
  background(230,230,250);
  for(int i=0;i<d.size();i+=1){
    drop d1=d.get(i);
    d1.show();
    d1.fall();
    if(d1.l.y>height){
      d.remove(i);
    }
  }
  for(int i=0;i<10;i+=1){
  d.add(new drop());
  }
  if(mousePressed){
    PVector wind=new PVector(0.1,0);
    for(drop d1:d){
      d1.addforce(wind);
    }
  }
}
