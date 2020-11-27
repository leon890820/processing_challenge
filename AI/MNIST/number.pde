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
