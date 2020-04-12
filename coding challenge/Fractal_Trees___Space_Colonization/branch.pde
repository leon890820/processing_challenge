class branch{
  PVector pos;
  branch parent;
  PVector dir;
  PVector rdir;
  int count=0;
  branch(PVector _pos,branch _parent,PVector _dir ){
    pos=_pos;
    parent=_parent;
    dir=_dir;
    rdir=dir.get();
    
  }
  void reset(){
    dir=rdir.get();
    count=0;
  } 
  branch next(){
    PVector newpos=PVector.add(pos,dir);
    branch b=new branch(newpos,this,dir);
    return b;
  }
  void show(float i){
    if(parent!=null){
      stroke(255);
      float sw=map(i,0,t.branches.size(),5,0);
      strokeWeight(sw);
      
      line(pos.x,pos.y,pos.z,parent.pos.x,parent.pos.y,parent.pos.z);
    }
  }

}
