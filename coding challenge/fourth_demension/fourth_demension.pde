float angel=0;
float len=100;
PVector[] points=new PVector[8];
PVector[] projected=new PVector[8];
float[][] projection={
    {1,0,0},
    {0,1,0}
};
void setup() {
    size(600,400);
    points[0]=new PVector(-0.5,-0.5, 0.5);
    points[1]=new PVector( 0.5,-0.5, 0.5);
    points[2]=new PVector(-0.5, 0.5, 0.5);
    points[3]=new PVector( 0.5, 0.5, 0.5);
    points[4]=new PVector(-0.5,-0.5,-0.5);
    points[5]=new PVector( 0.5,-0.5,-0.5);
    points[6]=new PVector(-0.5, 0.5,-0.5);
    points[7]=new PVector( 0.5, 0.5,-0.5);
}

void draw() {
    float[][] rotationZ={
        {cos(angel),-sin(angel),0},
        {sin(angel),cos(angel),0},
        {0,0,1}
    };
    float[][] rotationY={
        {cos(angel),0,sin(angel)},
        {0,1,0},
        {-sin(angel),0,cos(angel)}
    };
    float[][] rotationX={
        {1,0,0},
        {0,cos(angel),-sin(angel)},
        {0,sin(angel),cos(angel)}
    };
    
    background(0);
    translate(width/2,height/2);
    stroke(255);
    strokeWeight(16);
    noFill();
    int index=0;
    for (PVector v:points){
        PVector rotated=matmul(rotationY,v);
        rotated=matmul(rotationZ,rotated);
        rotated=matmul(rotationX,rotated);
        PVector projected2d=matmul(projection,rotated);
        projected2d.mult(len); 
        

        
        projected[index]=projected2d;
        index+=1;
    }
    for(PVector v:projected){
        point(v.x,v.y);
    }

    for(int i=0;i<8;i+=1){
        for(int j=0;j<8;j+=1){
            float dis=dist(points[i].x,points[i].y,points[i].z,points[j].x,points[j].y,points[j].z);
            if (dis<=1){
                connect(i,j);

            }

        }

    }
   

    angel+=0.03;
}

void connect(int i,int j){
    PVector a= projected[i];
    PVector b= projected[j];
    
    strokeWeight(1);
    stroke(255);
    line(a.x,a.y,b.x,b.y);
}