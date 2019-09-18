import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
ArrayList<Thing> obstacles=new ArrayList<Thing>();
public void setup() {
  size(500, 500);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
}

class Thing {
  float x, y, w, h;
  Thing(float ax, float ay, float aw, float ah) {
    x=ax;
    y=ay;
    w=aw;
    h=ah;
  }
  public void show() {
    fill(255-(float)arduino.analogRead(5)/2);
    rect(x, y, w, h);
  }
}
int thing=0;
int px;
boolean dead;
public void draw() {
  background(192);
  thing++;
  if(thing==(arduino.analogRead(3)>100?40:20)){
    obstacles.add(new Thing((float)Math.random()*500,(float)-50,(float)50,(float)50));
    thing=0;
  }
  if(arduino.analogRead(6)>100){
    px-=arduino.analogRead(3)>100?2:4;
  }
  if(arduino.analogRead(1)>100){
   px+=arduino.analogRead(3)>100?2:(float)4;
  }
  for(int i=0;i<obstacles.size();i++){
    
    obstacles.get(i).y+=arduino.analogRead(3)>100?3/((float)arduino.analogRead(5)/200+0.2):6/((float)arduino.analogRead(5)/200+0.2);
    obstacles.get(i).show();
    
  }
  //System.out.println(arduino.analogRead(5));
  //System.out.println();
  square(px, py, ph);
  if(collide()){
    dead=true;
  }

}
int py=400;
int pw=20;
int ph=20;
public boolean collide(){
   for(int i=0;i<obstacles.size();i++){
    if (obstacles.get(i).x < px+pw && obstacles.get(i).x+obstacles.get(i).w > px &&
        obstacles.get(i).y < py+ph && obstacles.get(i).y+obstacles.get(i).h >py) {
      return true;
    }
  }
  return false;
}
public void explode(int x, int y){
  
}
