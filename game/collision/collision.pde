Box b;
ArrayList<Box> boxes;
//PVector projectLine;
Vector[] penta;
void setup() {
  size(600, 600);
  penta=new Vector[5];
  //projectLine=new PVector(1, 1);
  for(int i=0;i<5;i+=1){
    float a=map(i,0,5,0,2*PI);
    penta[i]=new Vector(50*cos(a),50*sin(a));
  }
  println(penta[1].x,penta[1].y);
  boxes=new ArrayList<Box>();
  boxes.add(new Box(width/2, height/2, 100, 50, 3.16));
  boxes.add(new Box(width-100, height/2, 50, 50, 2.16));
  boxes.add(new Box(100,100, 75, 80, 1));  
  boxes.add(new Box(penta,200,100,PI));
}
void draw() {
  background(0);
  stroke(255);
  //line(0,0,map(boxes.get(0).vertexLine[1].getNormal().x,0,1,0,width),map(boxes.get(0).vertexLine[1].getNormal().y,0,1,0,height));
  //println(boxes.get(0).vertexLine[1].getNormal());
  selectCollision();
  for (Box b : boxes) {
    b.show();
    b.update();
    pnpoly(mouseX, mouseY, b);
   
  }
  //println(boxes.get(3).vertex[1].x,boxes.get(3).vertex[1].y);
  
  
  
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
void mousePressed() {
  for (Box b : boxes) {
    if (b.touch) b.drag=true;
  }
}
void mouseReleased() {
  for (Box b : boxes) {
    b.drag=false;
  }
}
void selectCollision(){
  for (int i=0; i<boxes.size(); i+=1) {
    for (int j=i+1; j<boxes.size(); j+=1) {
      if(i==j)continue;
      Box b1=boxes.get(i);
      Box b2=boxes.get(j);
      
      boolean collision=true;
      for (Vector v : b1.vertexLine) {
        float[] b1MM=b1.projectOnLineMaxAndMin(v.getNormal());
        float[] b2MM=b2.projectOnLineMaxAndMin(v.getNormal());
        if (b2MM[0]>b1MM[1]||b1MM[0]>b2MM[1]) {
          collision=false;          
        }
      }
      for (Vector v : b2.vertexLine) {
        float[] b1MM=b1.projectOnLineMaxAndMin(v.getNormal());
        float[] b2MM=b2.projectOnLineMaxAndMin(v.getNormal());
        if (b2MM[0]>b1MM[1]||b1MM[0]>b2MM[1]) {
          collision=false;          
        }
      }
      b1.collision=(collision||b1.collision);
      b2.collision=collision||b2.collision;
    }
  }


}
