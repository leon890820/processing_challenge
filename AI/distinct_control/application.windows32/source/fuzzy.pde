class Fuzzy {
  float[] DF_FS;
  float[] DRL_FS;
  Fuzzy() {
    DF_FS=new float[3];
    DRL_FS=new float[3];
  }

  float getTheda(float l, float f, float r) {
    float turn_left = -20;
    float turn_right = 20;
    DF_FS[0]=FS_Fuzzy(f);
    DF_FS[1]=FM_Fuzzy(f);
    DF_FS[2]=FL_Fuzzy(f);
    float o=r-l;
    DRL_FS[0]=OS_Fuzzy(o);
    DRL_FS[1]=OM_Fuzzy(o);
    DRL_FS[2]=OL_Fuzzy(o);
    float[] ALL_FS=new float[9];
    for (int i=0; i<DF_FS.length; i+=1) {
      for (int j=0; j<DRL_FS.length; j+=1) {
        int index=3*i+j;
        ALL_FS[index]=min(DF_FS[i], DRL_FS[j]);
      }
    }
    float AF=0;
    for (int i=0; i<ALL_FS.length; i+=1) {
      AF+=ALL_FS[i];
    }
    float drive=(ALL_FS[0]*turn_left+ALL_FS[1]*(-5)+ALL_FS[2]*turn_right+ALL_FS[3]*turn_left+ALL_FS[4]*(0)+ALL_FS[5]*turn_right+ALL_FS[6]*turn_left+ALL_FS[7]*(0)+ALL_FS[8]*turn_right)/AF;
    drive = max(min(drive, 40), -40);
    return drive;
  }


  float FS_Fuzzy(float x) {
    if (x<=3) return 1;
    else if (x<=4) return -x+4;
    else return 0;
  }
  float FM_Fuzzy(float x) {
    if (x<=4 && x>=3) return x-3;
    else if (x<=5 && x>4) return -x+4;
    else return 0;
  }
  float FL_Fuzzy(float x) {
    if (x>=5) return 1;
    else if (x>=4) return x-4;
    else return 0;
  }

  float OS_Fuzzy(float x) {
    if (x<=-4) return 1;
    else if (x<=0) return -x/4;
    else return 0;
  }
  float OM_Fuzzy(float x) {
    if (x<=0 && x>=-4) return x/4+1;
    else if (x>0 && x<=4) return -x/4+1;
    else return 0;
  }
  float OL_Fuzzy(float x) {
    if (x>=4) return 1;
    else if (x>=0) return x/4;
    else return 0;
  }
}
