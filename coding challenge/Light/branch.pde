class branch{
  PVector pos;
  branch parent;
  PVector dir;
  boolean isgrow=false;
  float len=1;
  float energy;
  branch(PVector _pos,branch _parent,PVector _dir,float _energy){
    pos=_pos.copy();
    parent=_parent;
    dir=_dir.copy();
    energy=_energy;
    
  }
  void show(){
    stroke(255,time);
    float w=map(energy,0,1000,0,4);
    strokeWeight(w);
    if(parent!=null){
      line(pos.x,pos.y,parent.pos.x,parent.pos.y);
    }
  }
  branch next(float energys,float bias){   
    isgrow=true;
    PVector cdir;
    if (bias>=0){
      cdir=dir.copy().add(new PVector(random(-2+bias,2+bias),random(0,1)));
    }
    else{
      cdir=dir.copy().add(new PVector(random(-2-bias,2-bias),random(0,1)));
      
    }
    cdir.normalize();
    cdir.mult(len);
    branch b=new branch(pos.copy().add(cdir),this,cdir,energys);
    return b;  
    
  }
  
  
}
