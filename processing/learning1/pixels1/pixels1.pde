
size(640,640);
background(0);

loadPixels();

for(int x =0;x<width;x+=1){
  for(int y=0;y<height;y+=1){
    pixels[x+y*width]=color(0,x*255/640,y*255/640);
  }
}

updatePixels();
