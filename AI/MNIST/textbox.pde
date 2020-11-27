class textbox {
  PVector position;
  float len;
  float hei;
  boolean pressed=false;
  boolean touch=false;
  boolean select=false;
  boolean re=false;
  boolean keyp=false;
  float time=0;
  String t="";
  textbox(float _x, float _y, float _len, float _hei) {
    position=new PVector(_x, _y);
    len=_len;
    hei=_hei;
  }
  void show() {
    //println(t);
    rectMode(CENTER);
    fill(0);
    stroke(255);
    rect(position.x, position.y, len, hei);
    if (select==true) {
      if (re) line(position.x-len/2+2+t.length()*len/(len/40), position.y-hei/2+10, position.x-len/2+2+t.length()*len/(len/40), position.y+hei/2-10);
      time+=1;
      if (time%20==0) re=!re;
    }
    textAlign(LEFT);
    fill(255);
    textSize(64);
    text(t, position.x-len/2, position.y+20);
  }

  void select() {
    if (mouseX>position.x-len/2 && mouseX<position.x+len/2 && mouseY>position.y-hei/2 && mouseY<position.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        select=!select;
        pressed=true;
      }
    } else pressed=false;
  }  
  void type() {
    if (keyPressed) {
      if (key != CODED && key!= BACKSPACE && t.length()<len/40) {
        if (keyp==false) {
          t+=key;
          keyp=true;
        }
      } else {
        if (key==BACKSPACE) {
          if (keyp==false && t.length()!=0) {
            t=t.substring(0, t.length()-1);
            keyp=true;
          }
        }
      }
    } else keyp=false;
  }
}
