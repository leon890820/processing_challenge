class net {
  float learning_rate=0.1;
  matrix input;
  matrix output;
  ArrayList<matrix> h;
  ArrayList<matrix> w;
  ArrayList<matrix> b;
  ArrayList<button> plus;
  ArrayList<button> minus;
  net(int i, int o) {
    h=new ArrayList<matrix>();
    w=new ArrayList<matrix>();
    b=new ArrayList<matrix>();
    plus=new ArrayList<button>();
    minus=new ArrayList<button>();
    input=new matrix(1, i);
    output=new matrix(1, o);
    w.add(new matrix(i, o));
    b.add(new matrix(1, o));
    for (matrix m : w) {
      m.init();
    }
    for (matrix m : b) {
      m.init();
    }
  }
  void plus(int i) {
    h.get(i).plus();
    b.get(i).plus();
    w.get(i).pluswf();   
    w.get(i+1).pluswb();
  }

  void minus(int i) {
    if (n.h.get(i).rows>1) {
      h.get(i).minus();
      b.get(i).minus();
      w.get(i).minuswf();   
      w.get(i+1).minuswb();
    }
  }

  void addhiddenlayer(int a) {
    //proggerm
    h.add(new matrix(1, a));
    w.clear();
    b.clear();
    plus.clear();
    minus.clear();
    for (int i=0; i<h.size()+1; i+=1) {      
      if (i==0) w.add(new matrix(input.rows, h.get(i).rows));
      else if (i==h.size()) w.add(new matrix(h.get(i-1).rows, output.rows));
      else w.add(new matrix(h.get(i-1).rows, h.get(i).rows));
    }
    for (int i=0; i<h.size(); i+=1) {
      b.add(new matrix(1, h.get(i).rows));
    }
    b.add(new matrix(1, output.rows));


    for (int i=0; i<h.size(); i+=1) {
      float r2=50;
      float h1=675+250*(i+1)/(n.h.size()+1);
      float l=250-(n.h.get(i).rows-1)*r2/2;
      plus.add(new button("+", h1, 50, 0, 20, 20));
      minus.add(new button("-", h1, 450, 0, 20, 20));
    }
    for (matrix m : w) {
      m.init();
    }
    for (matrix m : b) {
      m.init();
    }
  }

  void clearhidden() {
    h.remove(h.size()-1);
    w.clear();
    b.clear();
    plus.clear();
    minus.clear();
    for (int i=0; i<h.size()+1; i+=1) { 
      if (h.size()==0) {
        w.add(new matrix(input.rows, output.rows));
        break;
      }
      if (i==0) w.add(new matrix(input.rows, h.get(i).rows));
      else if (i==h.size()) w.add(new matrix(h.get(i-1).rows, output.rows));
      else w.add(new matrix(h.get(i-1).rows, h.get(i).rows));
    }
    for (int i=0; i<h.size(); i+=1) {
      b.add(new matrix(1, h.get(i).rows));
    }
    b.add(new matrix(1, output.rows));
    //button
    for (int i=0; i<h.size(); i+=1) {
      float r2=50;
      float h1=675+250*(i+1)/(n.h.size()+1);
      float l=250-(n.h.get(i).rows-1)*r2/2;
      plus.add(new button("+", h1, 50, 0, 20, 20));
      minus.add(new button("-", h1, 450, 0, 20, 20));
    }
    for (matrix m : w) {
      m.init();
    }
    for (matrix m : b) {
      m.init();
    }
  }
  float[] forward(drawpoint p) {
    input.w[0]=p.data.clone();
    if (h.size()==0) {
      output=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix();
    } else {
      h.get(0).w=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix().w.clone();
      for (int i=0; i<h.size()-1; i+=1) {
        h.get(i+1).w=h.get(i).multiple(w.get(i+1)).addiction(b.get(i+1)).sigmoidMatrix().w.clone();
      }
      output=h.get(h.size()-1).multiple(w.get(w.size()-1)).addiction(b.get(b.size()-1)).sigmoidMatrix();
    }


    return output.w[0].clone();
  }
  float[] forward(float[] p) {
    input.w[0]=p.clone();
    if (h.size()==0) {
      output=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix();
    } else {
      h.get(0).w=input.multiple(w.get(0)).addiction(b.get(0)).sigmoidMatrix().w.clone();
      for (int i=0; i<h.size()-1; i+=1) {
        h.get(i+1).w=h.get(i).multiple(w.get(i+1)).addiction(b.get(i+1)).sigmoidMatrix().w.clone();
      }
      output=h.get(h.size()-1).multiple(w.get(w.size()-1)).addiction(b.get(b.size()-1)).sigmoidMatrix();
    }


    return output.w[0].clone();
  }
  void train(drawpoint p) {
    //println(output.w[0]);
    if (h.size()==0) {
      matrix outputs=output;
      matrix target=new matrix(1, output.rows);
      target.w[0]=p.lable.clone();
      matrix output_error=target.subtract(outputs);
      
      outputs=outputs.dsigmoidMatrix().scalematrix(output_error).scalematrix(learning_rate);
      
      matrix input_t=input.transport();
      
      matrix w_delta=input_t.multiple(outputs);
           
      w.get(0).w=w.get(0).addiction(w_delta).w.clone();
      b.get(0).w=b.get(0).addiction(outputs).w.clone();
    }
    else{
      //output to last
      matrix outputs=output;
      matrix target=new matrix(1,output.rows);
      target.w[0]=p.lable.clone();
      matrix output_error=target.subtract(outputs);
      outputs=outputs.dsigmoidMatrix().scalematrix(output_error).scalematrix(learning_rate);
      
      matrix h_t=h.get(h.size()-1).transport();
      matrix w_delta=h_t.multiple(outputs);
      w.get(w.size()-1).w=w.get(w.size()-1).addiction(w_delta).w.clone();
      b.get(b.size()-1).w=b.get(b.size()-1).addiction(outputs).w.clone();
      
      matrix wl_t=w.get(w.size()-1).transport();
      matrix h_error=output_error.multiple(wl_t);
      // hidden
      for(int i=h.size()-1;i>0;i-=1){
        matrix hh=h.get(i);
        hh=hh.dsigmoidMatrix().scalematrix(h_error).scalematrix(learning_rate);
        
        h_t=h.get(i-1).transport();
        w_delta=h_t.multiple(hh);
        w.get(i).w=w.get(i).addiction(w_delta).w.clone();
        b.get(i).w=b.get(i).addiction(hh).w.clone();
        
        wl_t=w.get(i).transport();
        h_error=h_error.multiple(wl_t);
        
    }      
      // first to input
      matrix hh=h.get(0);
      
      hh=hh.dsigmoidMatrix().scalematrix(h_error).scalematrix(learning_rate);
      
      matrix i_t=input.transport();
      w_delta=i_t.multiple(hh);
      w.get(0).w=w.get(0).addiction(w_delta).w.clone();
      b.get(0).w=b.get(0).addiction(hh).w.clone();
    }
    
  }


  
}
