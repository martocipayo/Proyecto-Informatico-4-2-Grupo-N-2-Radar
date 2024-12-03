/* Arduino Radar Project
*
* Version Actualizada. Se ajusta a cualquier resolucion!
* Tan solo cambia los valores en la funcion size() con los de tu pantalla.
*
*
* Codigo hecho por Dejan Nedelkovski,
* www.HowToMechatronics.com
*
* Traducido por El Taller De TD
* youtube/eltallerdetd
*
*/
import processing.serial.*; // Importa la libreria necesaria para la comunicacion Serial
import java.awt.event.KeyEvent; // Importa la libreria para leer datos desde el puerto Serial
import java.io.IOException;
Serial myPort; // define el objeto serial
// define las variables
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
PFont orcFont;

void setup() {
  size(900, 500); // ***CAMBIA ESTO CON LOS VALORES DE TU RESOLUCION***
  smooth();
  myPort = new Serial(this,"COM3", 9600); // Comienza la comunicacion Serial, cambia el COM3 por el puerto que uses
  myPort.bufferUntil('.'); // Lee los datos enviados al puerto serial, angulo, distancia.
  orcFont = loadFont("OCRAExtended-30.vlw");
}

void draw() {
  fill(98,245,31);
  textFont(orcFont);
  // Simulas efectos visuales y de transicion
  noStroke();
  fill(0,4);
  rect(0, 0, width, height-height*0.065);
  fill(98,245,31); // color verde
  // Llama las funciones para dibujar el radar
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

void serialEvent (Serial myPort) {
  // Pone la informacion leida en la variable data
  data = myPort.readStringUntil('.');
  if (data != null) {
    data = data.trim(); // Elimina cualquier espacio en blanco adicional
    index1 = data.indexOf(","); // busca la , y la coloca en la variable index1
    if (index1 != -1) {
      angle = data.substring(0, index1); // Lee desde la posicion 0 hasta el index1, osea el angulo
      distance = data.substring(index1 + 1); // Lee el resto, osea la distancia
      // convierte los Strings a enteros
      iAngle = int(angle);
      iDistance = int(distance);
      println("Angle: " + iAngle + ", Distance: " + iDistance); // Agrega este mensaje de depuración
    }
  }
}

void drawRadar() {
  pushMatrix();
  translate(width/2, height-height*0.074);
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  line(-width/2,0,width/2,0);
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  line((-width/2)*cos(radians(30)),0,width/2,0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width/2, height-height*0.074);
  strokeWeight(9);
  stroke(255,10,10);
  pixsDistance = iDistance*((height-height*0.1666)*0.025);
  if (iDistance < 40) {
    line(pixsDistance*cos(radians(iAngle)), -pixsDistance*sin(radians(iAngle)), (width-width*0.505)*cos(radians(iAngle)), -(width-width*0.505)*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(width/2, height-height*0.074); // moves the starting coordinates to new location
  line(0, 0, (height-height*0.12)*cos(radians(iAngle)), -(height-height*0.12)*sin(radians(iAngle))); // draws the line according to the angle
  popMatrix();
}

void drawText() {
  pushMatrix();
  if (iDistance > 200) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }
  fill(0,0,0);
  noStroke();
  rect(0, height-height*0.0648, width, height);
  fill(98,245,31);
  textSize(25);
  text("10cm", width-width*0.3854, height-height*0.0833);
  text("20cm", width-width*0.281, height-height*0.0833);
  text("30cm", width-width*0.177, height-height*0.0833);
  text("40cm", width-width*0.0729, height-height*0.0833);
  textSize(40);
  text("Object: " + noObject, width-width*0.875, height-height*0.0277);
  text("Angle: " + iAngle + " °", width-width*0.48, height-height*0.0277);
  text("Distance: " + iDistance + " cm", width-width*0.26, height-height*0.0277); // Asegúrate de que esto se actualiza correctamente
  textSize(25);
  fill(98,245,60);
  translate((width-width*0.4994)+width/2*cos(radians(30)), (height-height*0.0907)-width/2*sin(radians(30)));
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();
  translate((width-width*0.503)+width/2*cos(radians(60)), (height-height*0.0888)-width/2*sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();
  translate((width-width*0.507)+width/2*cos(radians(90)), (height-height*0.0833)-width/2*sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();
  translate(width-width*0.513+width/2*cos(radians(120)), (height-height*0.07129)-width/2*sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();
  translate((width-width*0.5104)+width/2*cos(radians(150)), (height-height*0.0574)-width/2*sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);
  popMatrix();
}