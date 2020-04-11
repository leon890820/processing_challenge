class obstacle{
  
  PVector  location;
  PVector velocity;
  boolean getpoint;
  obstacle(){
    location=new PVector(500,random(120,380));
    velocity=new PVector(-5,0);

  }
  void run(){
    
    show();
    update();
  
  
  }
  void show(){
    noStroke();
    fill(255);
    rect(location.x-w,0,2*w,location.y-h);
    rect(location.x-w,location.y+h,2*w,500-location.y+h);
  }
  void update(){
    velocity=new PVector(-3,0);
    location.add(velocity); 
    //location.add(new PVector(0,random(1,-1)));
  }
 

}
