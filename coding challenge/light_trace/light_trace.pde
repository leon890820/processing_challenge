int rayNum=360;
int boundaryNum=5;
Boundary[] boundary=new Boundary[boundaryNum+4];
Light light;
float xoff=0;
float yoff=0;
void setup(){
  size(600,600);
  for(int i=0;i<boundary.length-4;i+=1){
    boundary[i]=new Boundary(random(width),random(height),random(width),random(height));
  }
  boundary[boundary.length-4]=new Boundary(0,0,width,0);
  boundary[boundary.length-3]=new Boundary(0,0,0,height);
  boundary[boundary.length-2]=new Boundary(0,height,width,height);
  boundary[boundary.length-1]=new Boundary(0,height,width,height);
  light=new Light(mouseX,mouseY);
}

void draw(){
  background(0);
  for(Boundary b:boundary){
    b.show();
  }
  light.show(noise(xoff)*width,noise(yoff)*height);
  xoff+=0.01;
  yoff+=0.02;
}
