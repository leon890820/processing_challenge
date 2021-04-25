class LidarScan{
  float oriented;
  PVector dir=new PVector(1,0);
  ArrayList<PVector> start;
  ArrayList<PVector> end;
  LidarScan(float o){
    oriented=o;
    start=new ArrayList<PVector>();
    end=new ArrayList<PVector>();
    
  }
  void scan(float robotOriented,PVector position){
    start.clear();
    end.clear();
    start.add(position.copy());
    float addOriented=oriented+robotOriented;
    PVector e=new PVector(dir.x*cos(addOriented)-dir.y*sin(addOriented),dir.x*sin(addOriented)+dir.y*cos(addOriented));
    end.add(position.add(e.copy()));
    while(true){
      start.add(end.get(end.size()-1).copy());
      end.add(start.get(start.size()-1).add(e.copy()).copy());
      if(isedge(end.get(end.size()-1))){
        break;
      }    
    }
    
  }
  void show(){
    stroke(255);
    for(int i=0;i<start.size()-1;i+=1){      
      line(start.get(i).x,start.get(i).y,end.get(i).x,end.get(i).y);
      //println(start.get(i).x,start.get(i).y,end.get(i).x,end.get(i).y);
    }
  
  
  }
  boolean isedge(PVector p){
    if(p.x<0||p.x>width||p.y<0||p.y>height){
      return true;
    }
    if(p.x>target.position.x-target.radious/2&&p.x<target.position.x+target.radious/2&&p.y>target.position.y-target.radious/2&&p.y<target.position.y+target.radious/2){
      return true;
    }
   return false;
  }
  float getLength(){
    return dist(start.get(0).x,start.get(0).y,end.get(end.size()-1).x,end.get(end.size()-1).y);
  
  
  }

}
