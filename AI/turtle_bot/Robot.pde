class Robot{
  PVector position;
  PVector velocity;
  int radious=20;
  Network network;
  LidarScan[] lidarScans=new LidarScan[scanNum];
  float oriented=-PI/2;
  PVector robotColorP=new PVector(random(255),random(255),random(255));
  color robotColor=color(robotColorP.x,robotColorP.y,robotColorP.z);
  color robotComplementaryColor=color(255-robotColorP.x,255-robotColorP.y,255-robotColorP.z);
  Robot(){
    position=new PVector(random(width/2-50,width/2+50),random(height-200,height-100));
    velocity=new PVector(1,0);
    network=new Network(observation,action);
    for(int i=0;i<lidarScans.length;i+=1){
      float theta=map(i,0,lidarScans.length,0,2*PI);
      lidarScans[i]=new LidarScan(theta);    
    }
    network.addhiddenlayer(64);
  }
  void show(){
    noStroke();
    fill(robotColor);
    circle(position.x,position.y,radious);
    stroke(robotComplementaryColor);
    line(position.x,position.y,position.x+radious*0.5*cos(oriented),position.y+radious*0.5*sin(oriented));
  
  }
  void move(){
    PVector forward=new PVector(velocity.x*cos(oriented)-velocity.y*sin(oriented),velocity.x*sin(oriented)+velocity.y*cos(oriented));
    position.add(forward);
    float[] observationSpace=new float[observation];
    float distToTarget=dist(position.x,position.y,target.position.x,target.position.y);
    float angleToTarget;
    PVector o=new PVector(cos(oriented),sin(oriented));
    PVector p=new PVector(target.position.x-position.x,target.position.y-position.y);
    angleToTarget=VectorDot(o,p);
    for(int i=0;i<scanNum;i+=1){
      observationSpace[i]=lidarScans[i].getLength();
    }
    observationSpace[observationSpace.length-2]=distToTarget;
    observationSpace[observationSpace.length-1]=angleToTarget;
    float[] actionSpace=network.forward(observationSpace);
    float a=argmax(actionSpace);
    if(a==0) oriented-=0.04;
    else if(a==1) oriented-=0.02;
    else if(a==2) oriented-=0;
    else if(a==3) oriented+=0.02;
    else if(a==4) oriented+=0.04;
    println(a);
  }
  void scan(){
    for(LidarScan ls:lidarScans){
      ls.scan(oriented,position.copy());
      ls.show();
    }
    //println(lidarScans[0].start.size());  
  }


}
float VectorDot(PVector a,PVector b){
  return a.x*b.x+a.y*b.y;

}
float argmax(float[] a){
  float record=-10000;
  int index=0;
  for(int i=0;i<a.length;i+=1){
    if(record<a[i]){
      record=a[i];
      index=i;
    }  
  }
  return index;

}
