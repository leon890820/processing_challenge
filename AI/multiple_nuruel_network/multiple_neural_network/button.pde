class button {
  PVector position;
  PVector pp;
  float len=150;
  float hei=50;
  String name;
  int num;
  boolean touch=false;
  boolean pressed=false;
  button(String _name, float _x, float _y, int _num, float _len, float _hei) {
    name=_name;
    position=new PVector(_x, _y);
    num=_num;
    len=_len;
    hei=_hei;
    pp=position.copy();
  }
  void show(float value) {
    pp.y=position.y-value*(buttons.length*60+100-height)/100;
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(pp.x, pp.y, len, hei);
    fill(255);
    textSize(20);
    text(name, pp.x, pp.y-3);
  }
  void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  void show(float s, boolean i) {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    stroke(255);
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(s);
    text(name, position.x, position.y-3);
  }
  void slidershow() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (touch==false) fill(0);
    else fill(50);
    noStroke();
    rect(position.x, position.y, len, hei);
    fill(255);
    textSize(20);
    text(name, position.x, position.y-3);
  }
  void select() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        initialize(name);
        pressed=true;
      }
    } else pressed=false;
  }
  void selectM() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        reset();
        pressed=true;
      }
    } else pressed=false;
  }  
  void slide() {
  }

  PVector sliderselect() {
    if (mouseX>position.x-len/2 && mouseX<position.x+len/2 && mouseY>position.y-hei/2 && mouseY<position.y+hei/2) {
      touch=true;
    }


    if (touch==true && mousePressed == true) {
      position.x=mouseX;
      position.y=mouseY;
    } else touch=false;
    return position;
  }

  void training() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false; 

    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        training=true;
        menu=false;
        testing=false;
        bonus=false;
        n.learning_rate=learning.v;
        pressed=true;
        graph=new EvolutionGraph(); 
      }
    } else pressed=false;
  }  

  void back() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=true;
        training=false;
        testing=false;
        bonus=false;
        pressed=true;
        MSV.clear();
        save=false;
        count=0;
        
      }
    } else pressed=false;
  }

  void test() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=false;
        training=false;
        testing=true;
        bonus=false;
        pressed=true;
      }
    } else pressed=false;
  }

  void bonusarea() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=false;
        training=false;
        testing=false;
        bonus=true;
        pressed=true;
      }
    } else pressed=false;
  }
  void addlayer() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        n.addhiddenlayer(4);
        pressed=true;
      }
    } else pressed=false;
  }

  void deletelayer() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        if (n.h.size()>0) {
          n.clearhidden();
        }
        pressed=true;
      }
    } else pressed=false;
  }

  void plus(int i) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {

        n.plus(i);


        pressed=true;
      }
    } else pressed=false;
  }


  void minus(int i) {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        n.minus(i);
        pressed=true;
      }
    } else pressed=false;
  }
  void classify() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        showclassify=!showclassify;
        pressed=true;
      }
    } else pressed=false;
  }
  void send() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true&&keylabel.t!="") {
      if (pressed==false) {
        String mt="";
        for (int i=0; i<mosaic.length; i+=1) {
          for (int j=0; j<mosaic[i].length; j+=1) {
            mt+=str(mosaic[i][j])+" ";
          }
        }
        mt+=keylabel.t;
        sdata.append(mt);
        String[] list=new String[sdata.size()];
        for (int i=0; i<list.length; i+=1) {
          list[i]=sdata.get(i);
        }
        saveStrings("data\\numberdata.txt", list);
        reset();
        pressed=true;
      }
    } else pressed=false;
  }
  
  
  void view() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menuM=false;
        view=true;
        pressed=true;
      }
    } else pressed=false;
  }  
  
  
  void backM() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menuM=true;
        view=false;
        pressed=true;
      }
    } else pressed=false;
  } 
  void next() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page+=1;
        viewload(page);
        
        pressed=true;
      }
    } else pressed=false;
  }  
  void prev() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page-=1;
        viewload(page);
        pressed=true;
      }
    } else pressed=false;
  }  
  
  void reload() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        page=1;
        MNISTsetup();
        viewload(page);
        pressed=true;
      }
    } else pressed=false;
  }  
  void resetweight() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        nueralnetwork.w1.init();
        nueralnetwork.w2.init();
        nueralnetwork.w3.init();
        MNISTsetupweight();
        pressed=true;
      }
    } else pressed=false;
  }  
  
  
  void label() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        blabel=!blabel;
         pressed=true;
      }
    } else pressed=false;
  } 
  void trainingM() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        
        train=true;
        pressed=true;
      }
    } else pressed=false;
  } 
  void MNIST() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=false;
        training=false;
        testing=false;
        bonus=false;
        MNISTb=true;
        
        pressed=true;
      }
    } else pressed=false;
  } 
  void backton() {
    if (mouseX>pp.x-len/2 && mouseX<pp.x+len/2 && mouseY>pp.y-hei/2 && mouseY<pp.y+hei/2) {
      touch=true;
    } else touch=false;     
    if (touch==true && mousePressed == true) {
      if (pressed==false) {
        menu=true;
        training=false;
        testing=false;
        bonus=false;
        MNISTb=false;
        pressed=true;
        
        
      }
    } else pressed=false;
  }
  
}
