import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class fourth_demension extends PApplet {

public void setup() {
    
    background(0);
}

public void draw() {
    
}
  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "fourth_demension" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
