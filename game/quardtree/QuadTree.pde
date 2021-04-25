class QuadTree {
  QuadTree[] QT;
  ArrayList<Point> points;
  float w;
  float h;
  PVector position;
  int MAX=20;
  Box box;
  QuadTree(float x, float y, float _w, float _h) {
    points=new ArrayList<Point>();
    QT=new QuadTree[4];
    for (int i=0; i<QT.length; i+=1) {
      QT[i]=null;
    }
    w=_w;
    h=_h;
    position=new PVector(x, y);
    Vector[] v=new Vector[4];
    v[0]=new Vector(x, y);
    v[1]=new Vector(x+w, y);
    v[2]=new Vector(x+w, y+h);
    v[3]=new Vector(x, y+h);
    box=new Box(v, 0, 0, 0);
  }
  void show() {
    
      noFill();
      stroke(255);
      rect(position.x, position.y, w, h);
      for (int i=0; i<QT.length; i+=1) {
        if (QT[i]!=null) QT[i].show();
      }
    
    for (Point p : points) {
      fill(255);
      noStroke();
      if (!debug)circle(p.position.x, p.position.y, 5);
    }
  }
  void insert(Point p) {
    if (points.size()<MAX) {
      points.add(p);
      return;
    }
    if (QT[0]==null)subquadtree();    
    for (int i=0; i<QT.length; i+=1) {
      if (pnpoly(p.position.x, p.position.y, QT[i].box)) {
        QT[i].insert(p);
        return;
      }
    }
    QT[3].insert(p);
    return;
  }
  void subquadtree() {
    QT[0]=new QuadTree(position.x, position.y, w/2, h/2);
    QT[1]=new QuadTree(position.x+w/2, position.y, w/2, h/2);
    QT[2]=new QuadTree(position.x+w/2, position.y+h/2, w/2, h/2);
    QT[3]=new QuadTree(position.x, position.y+h/2, w/2, h/2);
  }
}
