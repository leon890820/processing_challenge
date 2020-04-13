float angel=0;
float len=200;
P4Vector[] points=new P4Vector[16];
PVector[] projected=new PVector[16];

void setup() {
    size(600,400,P3D);
    points[0]=new P4Vector(-1,-1, 1,1);
    points[1]=new P4Vector( 1,-1, 1,1);
    points[2]=new P4Vector(-1, 1, 1,1);
    points[3]=new P4Vector( 1, 1, 1,1);
    points[4]=new P4Vector(-1,-1,-1,1);
    points[5]=new P4Vector( 1,-1,-1,1);
    points[6]=new P4Vector(-1, 1,-1,1);
    points[7]=new P4Vector( 1, 1,-1,1);
    points[8]=new P4Vector(-1,-1, 1,-1);
    points[9]=new P4Vector( 1,-1, 1,-1);
    points[10]=new P4Vector(-1, 1, 1,-1);
    points[11]=new P4Vector( 1, 1, 1,-1);
    points[12]=new P4Vector(-1,-1,-1,-1);
    points[13]=new P4Vector( 1,-1,-1,-1);
    points[14]=new P4Vector(-1, 1,-1,-1);
    points[15]=new P4Vector( 1, 1,-1,-1);
}

void draw() {
    
    translate(width/2,height/2);
    rotateX(-PI/2);
    float[][] rotationXY={
        {cos(angel),-sin(angel),0,0},
        {sin(angel),cos(angel),0,0},
        {0,0,1,0},
        {0,0,0,1}
    };
    float[][] rotationXZ={
        {cos(angel),0,-sin(angel),0},
        {0,1,0,0},
        {-sin(angel),0,cos(angel),0},
        {0,0,0,1}
    };
    float[][] rotationXW={
        {cos(angel),0,0,-sin(angel)},
        {0,1,0,0},
        {0,0,1,0},
        {sin(angel),0,0,cos(angel)}
    };
    float[][] rotationZW={
        {1,0,0,0},
        {0,1,0,0},
        {0,0,cos(angel),-sin(angel)},
        {0,0,sin(angel),cos(angel)}
    };
    
    background(0);
    //translate(width/2,height/2);
    stroke(255);
    strokeWeight(8);
    noFill();
    //rotateY(angel);
    int index=0;
    for (P4Vector v:points){
        P4Vector rotated=matmul(rotationXY,v,true);
        rotated=matmul(rotationZW,rotated,true);
        float distance=2;
        float w=1/(distance-rotated.w);
        float[][] projection={
            {w,0,0,0},
            {0,w,0,0},
            {0,0,w,0}
        };
        PVector projected3d=matmul(projection,rotated);
        projected3d.mult(50);

       

             
        projected[index]=projected3d;
        index+=1;
    }
    for(PVector v:projected){
         point(v.x,v.y,v.z);
    }
    
    
    for(int i=0;i<16;i+=1){
        for(int j=0;j<16;j+=1){
            float dis=fourthDdistance(points[i],points[j]);
            if (dis<=2){
                connect(i,j);

            }

        }

    }
   

    angel+=0.01;
}

void connect(int i,int j){
    PVector a= projected[i];
    PVector b= projected[j];
    
    strokeWeight(1);
    stroke(255);
    line(a.x,a.y,a.z,b.x,b.y,b.z);
}
float fourthDdistance(P4Vector a,P4Vector b){
    float dis4=pow(a.x-b.x,2)+pow(a.y-b.y,2)+pow(a.z-b.z,2)+pow(a.w-b.w,2);
    return sqrt(dis4);

}
