class Network{
  float learning_rate=0.1;
  matrix input;
  matrix output;
  ArrayList<matrix> h;
  ArrayList<matrix> w;
  ArrayList<matrix> b;
  
  Network(int i, int o) {
    h=new ArrayList<matrix>();
    w=new ArrayList<matrix>();
    b=new ArrayList<matrix>();
    
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
    if (h.get(i).rows>1) {
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
      float h1=675+250*(i+1)/(h.size()+1);
      float l=250-(h.get(i).rows-1)*r2/2;
      
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
      float h1=675+250*(i+1)/(h.size()+1);
      float l=250-(h.get(i).rows-1)*r2/2;
      
    }
    for (matrix m : w) {
      m.init();
    }
    for (matrix m : b) {
      m.init();
    }
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


}
