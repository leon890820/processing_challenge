float angel=0;
PVector[] points=new PVector[4];
float[][] projection={
    {1,0,0},
    {0,1,0}
};
void setup() {
    size(600,400);
    points[0]=new PVector(-50,-50,0);
    points[1]=new PVector(50,-50,0);
    points[2]=new PVector(-50,50,0);
    points[3]=new PVector(50,50,0);
}

void draw() {
    background(0);
    translate(width/2,height/2);
    stroke(255);
    strokeWeight(16);
    noFill();
    for (PVector v:points){
        PVector projected2d=matmul(projection,v);

        point(projected2d.x,projected2d.y);

    }
   

    angel+=0.01;
}
