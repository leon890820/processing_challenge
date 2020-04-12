class brench{
  PVector start ;
  PVector end;
  brench(PVector begin,PVector end_){
    start=begin.get();
    end=end_.get();
  }
  void show(){
    stroke(255);
    line(start.x,start.y,end.x,end.y);
     print(start,end+"\n");
  }
  
}
