class Mesh {
  Vector3[] verties;
  int[] triangles;
  int[] number;
  int[] uv_triangle;
  Vector3[] uv;
  Vector3[] normal_vector;
  Vector3[] nv;
  Vector3 Olambda;
  float Kd;
  float Ks;
  float N;
  String[] texture_name;
  int[] tc;
  PImage[] texture;
  //Shader shader=new Shader();
  Mesh(Vector3[] verties, int[] triangles, int[] number,Vector3[] uv,int[] uv_triangle, Vector3 Olambda, float Kd, float Ks, float N,int[] tc,String[] tn) {
    this.verties=verties;
    this.triangles=triangles;
    this.number=number;
    this.uv=uv;
    this.uv_triangle=uv_triangle;
    
    this.normal_vector=new Vector3[number.length];
    this.nv=new Vector3[number.length];
    this.Olambda=Olambda;
    this.Kd=Kd;
    this.Ks=Ks;
    this.N=N;
    this.tc=tc;
    this.texture_name=tn;
    initNormalVector();
    initNV();
    texture=new PImage[tc.length];
    for(int i=0;i<texture.length;i+=1){
      texture[i]=loadImage(texture_name[i]);
    }
    //this.shader=shader;
  }
  Mesh() {
  }

  void initNV() {
    int count=0;
    //println(number.length);
    for (int i=0; i<normal_vector.length; i+=1) {
      float d;
      if (number[i]<3) {
        count+=number[i];
        continue;
      }

      Vector3 v1=Vector3.sub(verties[triangles[count]], verties[triangles[count+1]]);
      Vector3 v2=Vector3.sub(verties[triangles[count+2]], verties[triangles[count+1]]);
      Vector3 v3=Vector3.cross(v1, v2);

      d=v3.x*verties[triangles[count]].x+v3.y*verties[triangles[count]].y+v3.z*verties[triangles[count]].z;
      nv[i]=new Vector3(-v3.x, -v3.y, -v3.z, -d);
      //println(normal_vector[i]);
      count+=number[i];
    }
  }

  void initNormalVector() {
    int count=0;
    //println(number.length);
    for (int i=0; i<normal_vector.length; i+=1) {
      float d;
      if (number[i]<3) {
        count+=number[i];
        continue;
      }

      Vector3 v1=Vector3.sub(verties[triangles[count]], verties[triangles[count+1]]);
      Vector3 v2=Vector3.sub(verties[triangles[count+2]], verties[triangles[count+1]]);
      Vector3 v3=Vector3.cross(v1, v2);
      
      d=v3.x*verties[triangles[count]].x+v3.y*verties[triangles[count]].y+v3.z*verties[triangles[count]].z;
      normal_vector[i]=new Vector3(v3.x, v3.y, v3.z, d);
      //println(normal_vector[i]);
      count+=number[i];
    }
  }

  void show() {
    if (verties==null||triangles==null) return;
    stroke(200);
    //noStroke();
    //fill(shader.c);
    noFill();
    int n=0;
    int r=0;
    for (int i=0; i<number.length; i+=1) {
      //println(i,number[n]);
      beginShape();
      for (int j=0; j<number[n]; j+=1) {
        //println(verties[triangles[r+j]]);
        vertex(map(verties[triangles[r+j]].x, -1, 1, 0, width), map( verties[triangles[r+j]].y, -1, 1, 0, height));
      }
      //vertex(verties[triangles[i]].x*editor.radius,verties[triangles[i]].y*editor.radius,verties[triangles[i]].z*editor.radius);
      //vertex(verties[triangles[i+1]].x*editor.radius,verties[triangles[i+1]].y*editor.radius,verties[triangles[i+1]].z*editor.radius);
      // vertex(verties[triangles[i+2]].x*editor.radius,verties[triangles[i+2]].y*editor.radius,verties[triangles[i+2]].z*editor.radius);
      endShape(CLOSE);
      r+=number[n];
      n+=1;

      //println(verties[triangles[i]],verties[triangles[i+1]],verties[triangles[i+2]]);
    }
  }


  void zBuffer() {
    //for(Vector3 v:nv) println(v);
    int count=0;
    
    for (int i=0; i<number.length; i+=1) {
      Vector3[] vs=new Vector3[number[i]];
      for (int j=0; j<vs.length; j+=1) {
        vs[j]=verties[triangles[count+j]];
      }
      
      PVector xminmax=new PVector(1.0/0.0, -1.0, 0.0);
      PVector yminmax=new PVector(1.0/0.0, -1.0, 0.0);
      ;
      for (int j=0; j<vs.length; j+=1) {
        xminmax.x=min(vs[j].x, xminmax.x);
        xminmax.y=max(vs[j].x, xminmax.y);
        yminmax.x=min(vs[j].y, yminmax.x);
        yminmax.y=max(vs[j].y, yminmax.y);
      }
      xminmax.x=max(0, map(xminmax.x, -1, 1, 0, width));
      xminmax.y=min(width, map(xminmax.y, -1, 1, 0, width));
      yminmax.x=max(0, map(yminmax.x, -1, 1, 0, height));
      yminmax.y=min(height, map(yminmax.y, -1, 1, 0, height));


      for (int y=(int)yminmax.x; y<yminmax.y; y+=1) {
        for (int x=(int)xminmax.x; x<xminmax.y; x+=1) {
          int index=y*width+x;
          float mx=map(x, 0, width, -1, 1);
          float my=map(y, 0, height, -1, 1);

          if (!pnpoly(mx, my, vs)) {
            continue;
          }
          float z=(normal_vector[i].h-mx*normal_vector[i].x-my*normal_vector[i].y)/normal_vector[i].z;
          if (z<=dz[index]) {
            dz[index]=z;
            PImage image=null;
            for(int s=0;s<tc.length;s+=1){
              if(i<tc[s]){
                image=texture[s];
                break;
              }
            }
            
            Vector3 uv_color=caculateUV(new Vector3(mx,my,z),i*3,image);
            Vector3 c=calculateIlambda(new Vector3(mx, my, z), nv[i],uv_color);
            cz[index]=color(c.x*255, c.y*255, c.z*255);
          }
        }
      }
      for (int j=0, k=number[i]-1; j<number[i]; k=j++) {
        int x0=(int)map(verties[triangles[count+j]].x, -1, 1, 0, width);
        int x1=(int)map(verties[triangles[count+k]].x, -1, 1, 0, width);
        int y0=(int)map(verties[triangles[count+j]].y, -1, 1, 0, height);
        int y1=(int)map(verties[triangles[count+k]].y, -1, 1, 0, height);

        //drawdz(x0,y0,x1,y1,color(255),normal_vector[i]);
      }
      count+=number[i];
    }
  }
  
  Vector3 caculateUV(Vector3 P,int count,PImage image){
    if(uv_triangle[count]>=uv.length || image==null) return Olambda;
    Vector3 A=verties[triangles[count+0]];
    Vector3 B=verties[triangles[count+1]];
    Vector3 C=verties[triangles[count+2]];
    Vector3 A_uv=uv[uv_triangle[count+0]];
    Vector3 B_uv=uv[uv_triangle[count+1]];
    Vector3 C_uv=uv[uv_triangle[count+2]];
    
    float t=((B.y-C.y)*(A.x-C.x)+(C.x-B.x)*(A.y-C.y));
    float BaryA=((B.y-C.y)*(P.x-C.x)+(C.x-B.x)*(P.y-C.y))/t;
    float BaryB=((C.y-A.y)*(P.x-C.x)+(A.x-C.x)*(P.y-C.y))/t;
    float BaryC=1-BaryA-BaryB;
    //println(BaryA,BaryB,BaryC);
    Vector3 P_uv=Vector3.add(Vector3.add(Vector3.mult(A_uv,BaryA),Vector3.mult(B_uv,BaryB)),Vector3.mult(C_uv,BaryC));
    int x=int(map(P_uv.x,0,1,0,image.width));
    int y=int(map(P_uv.y,1,0,0,image.height));
    //println(A_uv);
    int pixel=image.pixels[y*image.width+x];
    
    int B_MASK = 255;
    int G_MASK = 255<<8; //65280 
    int R_MASK = 255<<16; //16711680

    float r = float((pixel & R_MASK)>>16)/255;
    float g = float((pixel & G_MASK)>>8)/255;
    float b = float(pixel & B_MASK)/255;
    //println(r,g,b);
    return new Vector3(r,g,b);
  }

  Vector3 calculateIlambda(Vector3 position, Vector3 normal,Vector3 uv_color) {
    // println(position,normal);
    Vector3 n=normal.norm();
    Vector3 I=Vector3.product(kala,uv_color);
    for (Light light : lights) {
      Vector3 l=Vector3.sub(position, light.location).norm();
       
      float cos_theda=Vector3.dot3(n, l);
      //println(n);
      if (cos_theda<0) return new Vector3(0, 0, 0);
      Vector3 R=Vector3.sub(Vector3.mult(n, 2*cos_theda), l).norm();
      Vector3 v=Vector3.sub(position,cam.eye_position).norm();
      float cos_beta=Vector3.dot3(R, v);


      I=Vector3.add(I, Vector3.product(Vector3.mult(light.lp, cos_theda*Kd), Olambda));
      if (cos_beta>=0) {
        I=Vector3.add(I, Vector3.mult(light.lp, Ks*pow(cos_beta, N)));
      }
    }
    return I;
  }
  void drawUV(){
    int count=0;
    for(int i=0;i<uv.length;i+=1){
      stroke(0);
      beginShape();
      for(int j=0;j<3;j+=1){
        float x=map(uv[uv_triangle[count+j]].x,0,1,0,width);
        float y=map(uv[uv_triangle[count+j]].y,1,0,0,width);
        vertex(x,y);
      }
      endShape(CLOSE);
      count+=3;
    }
  
  }
}

void drawdz(int x0, int y0, int x1, int y1, color c, Vector3 normal_vector) {
  //println(x0,y0,x1,y1);
  boolean steep=abs(y1-y0)>abs(x1-x0);
  if (steep) {
    int tmp=x0;
    x0=y0;
    y0=tmp;

    int tmp1=x1;
    x1=y1;
    y1=tmp1;
  }
  if (x0>x1) {
    int tmp=x0;
    x0=x1;
    x1=tmp;

    int tmpy=y0;
    y0=y1;
    y1=tmpy;
  }
  int deltaX=x1-x0;
  int deltaY=abs(y1-y0);


  int error=deltaX/2;

  int ystep;
  int y=(int)y0;
  ystep=(y0<y1)?1:-1;
  for (int x=(int)x0; x<x1; x+=1) {
    if (x>=width || y>=height || x<0 || y<0) continue;
    if (steep) {
      float mx=map(y, 0, height, -1, 1);
      float my=map(x, 0, width, -1, 1);
      float z=(normal_vector.h-mx*normal_vector.x-my*normal_vector.y)/normal_vector.z;
      int index=x*width+y;

      if (z<=dz[index]) {

        dz[index]=z;
        cz[index]=c;
      }
    } else {
      float mx=map(x, 0, height, -1, 1);
      float my=map(y, 0, width, -1, 1);
      float z=(normal_vector.h-mx*normal_vector.x-my*normal_vector.y)/normal_vector.z;
      //println(z);
      int index=y*width+x;
      if (z<=dz[index]) {

        dz[index]=z;
        cz[index]=c;
      }
    }
    error-=deltaY;
    if (error<0) {
      y+=ystep;
      error+=deltaX;
    }
  }
}
