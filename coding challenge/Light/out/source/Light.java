import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Light extends PApplet {

lightning light;

public void setup(){
  
  light=new lightning();
}
public void draw(){
  background(0);
  light.run();
}
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
  public void show(){
    stroke(255);
    if(parent!=null){
      line(pos.x,pos.y,parent.pos.x,parent.pos.y);
    }
  }
  public branch next(){   
    isgrow=true;
    PVector cdir=dir.copy().add(new PVector(random(-1,1),random(0,1)));
    cdir.normalize();
    cdir.mult(len);
    branch b=new branch(pos.copy().add(cdir),this,cdir);
    return b;  
    
  }
  
  
}
class lightning{
  PVector pos;
  ArrayList<branch> branches;
  PVector dir;
  float len=1;
  lightning(){
    dir=new PVector(0,1);
    pos = new PVector(width/2,0);
    branches=new ArrayList<branch>();
    branches.add(new branch(pos,null,dir));
  }
  public void run(){
    for(int i=0;i<10;i+=1){
      grow();
    }
    for(branch b:branches){
      b.show();
    }
    
  }
  
  public void grow(){
    for(int i=branches.size()-1;i>=0;i-=1){
      branch b=branches.get(i);
      if(b.isgrow==false){
        branches.add(b.next());
        if(random(1)<0.001f){
          branches.add(b.next());
        }
      }
    }
    
  }
  

}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Light" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
