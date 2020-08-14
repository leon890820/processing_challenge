class branch{
  PVector pos;
  branch parent;
  PVector dir;
  boolean isgrow=false;
  float len=1;
  branch(PVector _pos,branch _parent,PVector _dir){
    pos=_pos.copy();
    parent=_parent;
    dir=_dir.copy();
    
  }
  void show(){
    stroke(255);
    if(parent!=null){
      line(pos.x,pos.y,parent.pos.x,parent.pos.y);
    }
  }
  branch next(){   
    isgrow=true;
    PVector cdir=dir.copy().add(new PVector(random(-1,1),random(0,1)));
    cdir.normalize();
    cdir.mult(len);
    branch b=new branch(pos.copy().add(cdir),this,cdir);
    return b;  
    
  }
  
  
}
