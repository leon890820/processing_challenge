class Vehicle{
  PVector position;
  float oriented;
  float radius;
  float drive;
  Ray[] ray=new Ray[3];
  float[] distanceToWall=new float[ray.length];
  Vehicle(float _x,float _y,float _o){
    position=new PVector(_x,_y);
    oriented=_o;  
    radius=3;
    drive=0;
    for(int i=0;i<ray.length;i+=1){
      //float o=map(oriented,0,360,0,2*PI);
      float a=map(i,0,ray.length-1,-45+oriented,45+oriented);
      ray[i]=new Ray(position.x,position.y,a);
    }
  }
  void show(){
    noFill();
    stroke(255);
    strokeWeight(1);
    oriented=90+theda;
    float a=map(oriented,0,360,0,2*PI);
    line(mapTheX(position.x),mapTheY(position.y),mapTheX(position.x+radius*cos(a)),mapTheY(position.y+radius*sin(a)));
    circle(mapTheX(position.x),mapTheY(position.y),mapTheR(radius*2));
    int count=0;
    for(Ray r:ray){
      r.position=new PVector(position.x,position.y);
      float record=100000;
      PVector mb=null;
      
      for(Boundary b:boundary){
        PVector pt=r.show(b);
        if(pt==null) continue;
        float d=dist(pt.x,pt.y,position.x,position.y);
        if(record>d){
          record=d;
          mb=pt.copy();
        }
      }
     
      if(mb==null) continue;
      stroke(255);
      line(mapTheX(mb.x),mapTheY(mb.y),mapTheX(position.x),mapTheY(position.y));
      fill(255);
      circle(mapTheX(mb.x),mapTheY(mb.y),6);
      distanceToWall[count]=dist(mb.x,mb.y,position.x,position.y);
      count+=1;
    }
  
  }
  
  void saveDate(){
    println("123");
    train4D.println(distanceToWall[1]+" "+distanceToWall[2]+" "+distanceToWall[0]+" "+drive);
    train6D.println(position.x+" "+position.y+" "+distanceToWall[1]+" "+distanceToWall[2]+" "+distanceToWall[0]+" "+drive);
    
    //saveStrings("data/train4D.txt",s);
    
  
  }
  
  void autoMove(){
    drive=fuzzy.getTheda(distanceToWall[0],distanceToWall[1],distanceToWall[2]);
    theda+=drive;
    float deltaX=cos(radians(oriented)+radians(drive))+sin(radians(oriented))*sin(radians(drive));
    float deltaY=sin(radians(oriented)+radians(drive))-sin(radians(drive))*cos(radians(oriented));
    float delta_oriented=asin(2*sin(radians(drive))/6);
    
    oriented+=-delta_oriented;
    position=new PVector(position.x+deltaX,position.y+deltaY);
    path.add(position);
  
  }
  
  void recordMove(){
    String[] s=recordPath[countPath].split(" ");
    position=new PVector(float(s[0]),float(s[1]));
    drive=float(s[5]);
    theda+=drive;
    countPath+=1;
    
  }


}
