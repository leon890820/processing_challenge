class Rolling {
  PVector center;
  float bigRadious=15;
  float smallRadious=8;
  boolean flash=false;
  PVector bais;
  Rolling(float x, float y,float z,float bx,float by) {
    center=new PVector(x, y,z);
    bais=new PVector(bx,by);
  }

  void show() {
    //text(str(center.x)+" "+str(center.y)+" "+str(center.z),center.x,center.y);

    //flashCircle(0, 362, 255, -1);
    //flashCircle(0, 362, 0, 1);
    //flashCircle(0+(int)(time*0.8), 152+(int)(time*0.8), 0,-1);
    //flashCircle(150+(int)(time*0.8), 182+(int)(time*0.8), 200,-1);
    //flashCircle(180+(int)(time*0.8), 332+(int)(time*0.8), 255,-1);
    //flashCircle(330+(int)(time*0.8), 362+(int)(time*0.8), 30,-1);


    
    
    drawCircle(0+45+(int)time, 152+45+(int)time, 0,-bais.x,-bais.y);
    drawCircle(150+45+(int)time, 182+45+(int)time, 200,-bais.x,-bais.y);
    drawCircle(180+45+(int)time, 332+45+(int)time, 255,-bais.x,-bais.y);
    drawCircle(330+45+(int)time, 362+45+(int)time, 30,-bais.x,-bais.y);
    
    drawCircle(0-45+(int)time, 152-45+(int)time, 0,bais.x,bais.y);
    drawCircle(150-45+(int)time, 182-45+(int)time, 200,bais.x,bais.y);
    drawCircle(180-45+(int)time, 332-45+(int)time, 255,bais.x,bais.y);
    drawCircle(330-45+(int)time, 362-45+(int)time, 30,bais.x,bais.y);
    
    drawCircle(0+(int)time, 152+(int)time, 0,0,0);
    drawCircle(150+(int)time, 182+(int)time, 200,0,0);
    drawCircle(180+(int)time, 332+(int)time, 255,0,0);
    drawCircle(330+(int)time, 362+(int)time, 30,0,0);
  }
  void drawCircle(int start, int end, color c,float baisx,float baisy) {
    noStroke();
    fill(c);
    beginShape();
   
    for (int i=start; i<end; i+=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      
      vertex(center.x+baisx+bigRadious*cos(angle), center.y+baisy+bigRadious*sin(angle));
    }
    for (int i=end; i>start; i-=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      vertex(center.x+baisx+smallRadious*cos(angle), center.y+baisy+smallRadious*sin(angle));
    }

    endShape();
  }
  
  

  void flashCircle(int start, int end, color c, float bias) {
    noStroke();
    fill(c);
    float sr=map(time%360,0,360,0,2*PI);
    beginShape();

    for (int i=start; i<end; i+=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      vertex(center.x+bias+bigRadious*cos(angle), center.y+bigRadious*sin(angle));
    }
    for (int i=end; i>start; i-=1) {
      float angle=map(i, 0, 360, 0, 2*PI);
      vertex(center.x+bias+smallRadious*cos(angle), center.y+smallRadious*sin(angle));
    }

    endShape();
  }
}
