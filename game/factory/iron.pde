class IronCenter{
  PVector location;
  int numX=(int)random(3,10);
  int numY=(int)random(4,10);
  Iron[] irons=new Iron[numX*numY*4];
  IronCenter(){
    location=new PVector((int)(random(-width,width)/scl)*scl,(int)(random(-height,height)/scl)*scl);    
    create();
  }
  
  void create(){
    int count=0;
    for(int i=-numX;i<numX;i+=1){
      for(int j=-numY;j<numY;j+=1){
        irons[count]=new Iron(new PVector(location.x+i*scl,location.y+j*scl),100);
        count+=1;
      }
    }
  }
  
  void run(){
    for(int i=0;i<irons.length;i+=1){
      irons[i].show();
    }
    
  
  }
}

class Iron{
  PVector location;
  float num;
  String name="iron";
  boolean inform=false;
  Iron(PVector _location,float _num){
    location=_location.copy();
    num=_num;
  
  }
  void show(){    
    image(imgiron,location.x,location.y,scl,scl);
    
  }
  void information(PVector location){
    imageMode(CENTER);
    image(UIbgd,location.x,location.y,100,100);
    text(name,location.x,location.y);
  }


}
class item{
  String name;
  item(String _name){
    name=_name;
  }
  

}
