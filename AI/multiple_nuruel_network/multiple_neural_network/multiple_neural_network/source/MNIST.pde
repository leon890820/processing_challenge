class NN {
  matrix input;
  matrix hidden1;
  matrix hidden2;
  matrix output;
  matrix w1;
  matrix w2;
  matrix w3;
  matrix bias_h1;
  matrix bias_h2;
  matrix bias_o;
  float learning_rate=0.001;
  float bias=1;
  NN(int i, int h1, int h2, int o) {
    input=new matrix(1, i);
    hidden1=new matrix(1, h1);
    hidden2=new matrix(1, h2);
    output=new matrix(1, o);
    w1=new matrix(i, h1);
    w2=new matrix(h1, h2);
    w3=new matrix(h2, o);
    bias_h1=new matrix(1, h1);
    bias_h2=new matrix(1, h2);
    bias_o=new matrix(1, o);
    w1.init();
    w2.init();
    w3.init();
    bias_h1.init();
    bias_h2.init();
    bias_o.init();
  }
  float forward(float[] in) {
    float n=0;
    float[][] inn=new float[input.cols][input.rows];
    for (int i=0; i<inn[0].length; i+=1) {
      inn[0][i]=in[i]/255;
    }
    //inn[0][inn[0].length-1]=1;
    input.w=inn;
    matrix tem=input.multiple(w1);
    for (int i=0; i<hidden1.rows; i+=1) {
      hidden1.w[0][i]=tem.w[0][i];
    }
    //hidden1.w[0][hidden1.rows-1]=1;
    for (int i=0; i<hidden1.rows; i+=1) {
      hidden1.w[0][i]=sigmoid(hidden1.w[0][i]);
    }

    tem=hidden1.multiple(w2);
    for (int i=0; i<hidden2.rows; i+=1) {
      hidden2.w[0][i]=tem.w[0][i];
    }
    //hidden2.w[0][hidden2.rows-1]=1;
    for (int i=0; i<hidden2.rows; i+=1) {
      hidden2.w[0][i]=sigmoid(hidden2.w[0][i]);
    }
    output=hidden2.multiple(w3);
    for (int i=0; i<output.rows; i+=1) {
      output.w[0][i]=sigmoid(output.w[0][i]);
    }

    //println(output.w[0]);
    float max=calcmax(output.w[0]);


    return max;
  }

  void training(number n) {
    matrix outputs=output;
    matrix target=new matrix(1, output.rows);
    target.w=n.label;
    matrix output_error=target.subtract(outputs);
    outputs=outputs.dsigmoidMatrix();
    outputs=outputs.scalematrix(output_error);
    outputs=outputs.scalematrix(learning_rate);

    matrix hidden2_t=hidden2.transport();
    matrix w3_deltas=hidden2_t.multiple(outputs);
    w3=w3.addiction(w3_deltas);
    bias_o=bias_o.addiction(outputs);

    matrix w3_t=w3.transport();
    matrix hidden2_error=output_error.multiple(w3_t);
    matrix hiddens2=hidden2;
    hiddens2=hiddens2.dsigmoidMatrix();
    hiddens2=hiddens2.scalematrix(hidden2_error);
    hiddens2=hiddens2.scalematrix(learning_rate);

    matrix hidden1_t=hidden1.transport();
    matrix w2_deltas=hidden1_t.multiple(hiddens2);
    w2=w2.addiction(w2_deltas);
    bias_h2=bias_h2.addiction(hiddens2);

    matrix w2_t=w2.transport();
    matrix hidden1_error=hidden2_error.multiple(w2_t);
    matrix hiddens1=hidden1;
    hiddens1=hiddens1.dsigmoidMatrix();
    hiddens1=hiddens1.scalematrix(hidden1_error);
    hiddens1=hiddens1.scalematrix(learning_rate);

    matrix input_t=input.transport();
    matrix w1_deltas=input_t.multiple(hiddens1);
    w1=w1.addiction(w1_deltas);
    bias_h1=bias_h1.addiction(hiddens1);
  }



  float calcmax(float[] f) {
    float record=-100000;
    float[] index=new float[10];
    int in=0;
    //int inn=0;
    indexclear(index);
    for (int i=0; i<f.length; i+=1) {
      if (f[i]>record) {
        record=f[i];
        in=i;
      }
    }
    //  if (f[i]>record) {
    //    in=0;
    //    indexclear(index);
    //    record=f[i];
    //    index[in]=i;
    //    in+=1;
    //  } else if (f[i]==record) {
    //    index[in]=i;
    //    in+=1;
    //  }     
    //}
    //float n=index[(int)random(in+1)];


    return in;
  }
  void indexclear(float[] index) {
    for (int i=0; i<index.length; i+=1) {
      index[i]=0;
    }
  }
  float[][] realforward() {

    return output.w;
  }

  void saveweight() {
    String[] list=new String[3];
    String s="";
    float total=w1.rows*w1.cols+w2.rows*w2.cols+w3.rows*w3.cols;
    float count=0;
    for (int i=0; i<w1.cols; i+=1) {
      for (int j=0; j<w1.rows; j+=1) {
        println((str(count*100/total)));
        count+=1;
        s+=str(w1.w[i][j])+" ";
      }
    }

    list[0]=s;

    s="";
    for (int i=0; i<w2.cols; i+=1) {
      for (int j=0; j<w2.rows; j+=1) {
        println((str(count*100/total)));
        count+=1;
        s+=str(w2.w[i][j])+" ";
      }
    }
    list[1]=s;

    s="";
    for (int i=0; i<w3.cols; i+=1) {
      for (int j=0; j<w3.rows; j+=1) {
        println((str(count*100/total)));
        count+=1;
        s+=str(w3.w[i][j])+" ";
      }
    }
    list[2]=s;
    saveStrings("data\\weightdata.txt", list);
  }
}

class number {
  float[] data;
  float[][] label=new float[1][10];
  int predict=0;
  float[][] realforward=new float[1][10];
  number(float[] d, int l) {
    data=d;

    for (int i=0; i<label[0].length; i+=1) {     
      if (i==l) {
        label[0][i]=1;
      } else label[0][i]=0;
    }
  }
  void view(float x, float y, float _scl) {
    for (int i=0; i<num; i+=1) {
      for (int j=0; j<num; j+=1) {
        int index=i+j*num;
        noStroke();
        rectMode(CORNER);
        float d=map(data[index], 0, 255, 255, 0);
        fill(d);
        rect(x+j*_scl, y+i*_scl, _scl, _scl);
      }
    }
  }
}
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
