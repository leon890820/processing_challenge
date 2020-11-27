float[] r={5, 4, 3, 2, 1};
float[] l={1,0,1,0,1};
int num=60;

String[] list=new String[num*r.length];

void setup() {
  int count=0;
  for (int j=0; j<r.length; j+=1) {
    for (int i=0; i<num; i+=1) {
      float theda=2*PI*i/num;
      float x=r[j]*cos(theda);
      float y=r[j]*sin(theda);
      list[count]=str(x)+" "+str(y)+" "+str(l[j]);
      count+=1;
    }
  }

  saveStrings("data\\Cccircle.txt", list);
}
