class Box {
  PVector position;
  float width;
  float height;
  float angle;
  boolean touch;
  boolean drag;
  boolean collision;
  Vector[] vertex;
  Vector[] vertexLine;
  Vector[] orginalVertex;
  Box(float x, float y, float w, float h, float a) {
    vertex=new Vector[4];
    vertexLine=new Vector[4];
    position=new PVector(x, y);
    this.width=w;
    this.height=h;  
    angle=a;
    drag=false;
    collision=false;
    createVertex();
  }
  Box(Vector[] v,float x, float y,float a){
    orginalVertex=v;
    vertexLine=new Vector[v.length];
    vertex=new Vector[v.length];
    position=new PVector(x, y);
    angle=a;  
    for(int i=0;i<v.length;i+=1){
      vertex[i]=new Vector(orginalVertex[i].x,orginalVertex[i].y);
    }
    for (int i=0; i<vertex.length; i+=1) {
      vertex[i].rotate(angle);
      vertex[i].translate(position);
    }
    
    for(int i=0,j=vertexLine.length-1;i<vertexLine.length;j=i++){
      vertexLine[i]=new Vector(vertex[j].x-vertex[i].x,vertex[j].y-vertex[i].y);
    }
  }
  void show() {
    println(vertex[0].x,vertex[0].y);
    if(vertex.length==4){
      createVertex();
    }
    else createVectorForMore();
    if (touch)fill(255, 0, 0);
    else if(collision)fill(255,255,0);
    else fill(255);
    if (drag) stroke(0, 255, 0);
    else noStroke();
    beginShape();
    for (int i=0; i<vertex.length; i+=1) {
      vertex(vertex[i].x, vertex[i].y);
    }
    endShape(CLOSE);
  }
  void update() {
    //if(touch==false) drag=false;
    drag();    
    angle+=random(-0.01,0.1);
    collision=false;

    //if (mousePressed==false) {
    //  drag=false;
    //} else {
    //  if (touch) {
    //    drag=true;
    //  }
    //}
  }
  void drag() {
    if (drag) {
      PVector v=new PVector(mouseX-pmouseX, mouseY-pmouseY);
      position.add(v);
    }
  }
  void createVertex() {
    vertex[0]=new Vector(this.width/2, -this.height/2);
    vertex[1]=new Vector(-this.width/2, -this.height/2);
    vertex[2]=new Vector(-this.width/2, this.height/2);
    vertex[3]=new Vector(this.width/2, this.height/2);
    for (int i=0; i<vertex.length; i+=1) {
      vertex[i].rotate(angle);
      vertex[i].translate(position);
    }
    for(int i=0,j=vertexLine.length-1;i<vertexLine.length;j=i++){
      vertexLine[i]=new Vector(vertex[j].x-vertex[i].x,vertex[j].y-vertex[i].y);
    }
  }
  void createVectorForMore(){
    for(int i=0;i<vertex.length;i+=1){
      vertex[i]=new Vector(orginalVertex[i].x,orginalVertex[i].y);
    }
    for (int i=0; i<vertex.length; i+=1) {
      vertex[i].rotate(angle);
      vertex[i].translate(position);
    }
    
    for(int i=0,j=vertexLine.length-1;i<vertexLine.length;j=i++){
      vertexLine[i]=new Vector(vertex[j].x-vertex[i].x,vertex[j].y-vertex[i].y);
    }
  
  }
  
  
  void projectOnLine(PVector pl){
    for(Vector v:vertex){
      PVector pp=v.projectOnto(pl);
      fill(0,0,255);
      circle(pp.x,pp.y,5);
    }  
  }
  float[] projectOnLineMaxAndMin(PVector pl){
    float maxRecord=-100000000;
    float minRecord=100000000;
    PVector minV=new PVector();
    PVector maxV=new PVector();
    for(Vector v:vertex){
      PVector pp=v.projectOnto(pl);
      float ff=v.projectOntoLength(pl);
      if(ff>maxRecord){
        maxRecord=ff;
        maxV=pp.copy();
      }
      if(ff<minRecord){
        minRecord=ff;
        minV=pp.copy();
      }
    }
    fill(0,0,255);
    //circle(minV.x,minV.y,5);
    //circle(maxV.x,maxV.y,5);
    float[] result={minRecord,maxRecord};
    return result;
  }
  
}
