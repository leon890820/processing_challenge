ArrayList<Point> points;
QuadTree quadTree;
boolean debug=false;
void setup() {
  size(600, 600);  
  points=new ArrayList<Point>();
  quadTree=new QuadTree(0, 0, width, height);
}
void draw() {
  background(0);
  quadTree=new QuadTree(0, 0, width, height);
  for (Point p : points) {
    quadTree.insert(p);
  }
   
  quadTree.show();
  if (mousePressed) {
    points.add(new Point(mouseX, mouseY));
  }
}

void mousePressed() {
  //points.add(new Point(mouseX,mouseY));
}

void keyPressed() {
  if (keyPressed) {
    if (key=='p'||key=='P') {
      debug=!debug;
    }
    if (key=='d'||key=='D') {
      points.clear();
    }
  }
}

boolean pnpoly(float x, float y, Box b) {
  boolean c=false;
  for (int i=0, j=b.vertex.length-1; i<b.vertex.length; j=i++) {
    if (((b.vertex[i].y>y)!=(b.vertex[j].y>y))&&(x<(b.vertex[j].x-b.vertex[i].x)*(y-b.vertex[i].y)/(b.vertex[j].y-b.vertex[i].y)+b.vertex[i].x)) {
      c=!c;
    }
  }
  b.touch=c;
  return c;
}
