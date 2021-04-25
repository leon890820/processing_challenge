ArrayList<Point> points;
QuadTree quadTree;

void setup(){
  size(600,600);  
  points=new ArrayList<Point>();
  quadTree=new QuadTree(0,0,width,height);
}
void draw(){
  background(0);
  quadTree=new QuadTree(0,0,width,height);
  for(Point p:points){
    quadTree.insert(p);
  }
}

void mousePressed(){
  points.add(new Point(mouseX,mouseY));
}
