class path{
  PVector start;
  PVector end;
  float r;
  ArrayList<PVector>points;
  path(){
    r=20;
    points=new ArrayList<PVector>();
    start=new PVector(0,height/3);
    end=new PVector(width,2*height/3);
  
  }
  void display(){
    strokeWeight(r*2);
    stroke(0,100);
    noFill();
    beginShape();
    for(PVector v:points){
      vertex(v.x,v.y);
    }
    endShape();
    //line(start.x,start.y,end.x,end.y);
    
    strokeWeight(1);
    stroke(0);
    noFill();
    beginShape();
    for(PVector v:points){
      vertex(v.x,v.y);
    }
    endShape();
    //line(start.x,start.y,end.x,end.y);
  }
  void addpoint(float x,float y){
    PVector point=new PVector(x,y);
    points.add(point);
  }
  PVector getstart(){
    return points.get(0);
  }
  PVector getend(){
  return points.get(points.size()-1);
      
  }
  
  
}
