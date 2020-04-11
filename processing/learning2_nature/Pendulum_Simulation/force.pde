class force{
  PVector location;
  float av;
  float aa;
  
  float mass;
  force(){
    location=new PVector(0,height/2);
    av=0;
    aa=0;
    mass=1;

  }
  void display(){
   
    stroke(255);
    fill(255);
    line(0,0,location.x,location.y);
    circle(location.x,location.y,20);
  }
  void addforce(PVector F){
    
               
  }
  void update(){
    aa=-0.01*sin(angle);
     location.x=sin(angle)*L;
     location.y=cos(angle)*L;
     angle+=av;
     av+=aa;
     av*=0.99;
  }

}
