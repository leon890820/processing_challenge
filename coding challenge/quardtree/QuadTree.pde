class QuadTree{
  QuadTree[] QT;
  ArrayList<Point> points;
  float w;
  float h;
  PVector position;
  int MAX=4;
  QuadTree(float x,float y,float _w,float _h){
    points=new ArrayList<Point>();
    QT=new QuadTree[4];
    for(int i=0;i<QT.length;i+=1){
      QT[i]=null;
    }
    w=_w;
    h=_h;
    position=new PVector(x,y);
  }
  void show(){
    rect(position.x,position.y,w,h);
    for(int i=0;i<QT.length;i+=1){
      if(QT[i]!=null) QT[i].show(); 
    }
  }
  void insert(Point p){
    if(){
    
    }
    if(points.size()<MAX){
      points.add(p);
      return;
    }
    
  
  }


}
