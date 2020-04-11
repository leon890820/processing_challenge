class leave{
  PVector pos=new PVector(random(-width/2,width/2),random(-height/2,400),random(-width/2,width/2));
  
  boolean reached=false;
  
  leave(){
    
    while(ifpos()){
      pos=new  PVector(random(-width/2,width/2),random(-height/2,400),random(-width/2,width/2));
    }
    
  }
  void show(){
    fill(255);
    noStroke();
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    circle(0,0,5);
    popMatrix();
  }

  boolean ifpos(){
    if(-0.003*pos.x*pos.x-0.003*pos.z*pos.z>=pos.y-200){
      return false;
    }
    else{
      return true;
    }

  } 
}
