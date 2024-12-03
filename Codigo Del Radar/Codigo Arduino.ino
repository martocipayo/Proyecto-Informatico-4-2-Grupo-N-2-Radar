/*
Codigo originalmente creado por Dejan Nedelkovski de howtomechatronics.com
Traducido y modificado por El Taller de TD de youtube/eltallerdetd
*/
// Importa la libreria Servo
#include<Servo.h>
// Define los pines del sensor ultrasonico Trig y Echo
const int trigPin = 10;
const int echoPin = 11;

const int buzzer = 8;

// Variables de duracion y distancia
long duration;
int distance;
Servo myServo; // Crea el objeto myServo
void setup() {
pinMode(trigPin, OUTPUT); // Setea el pin trigPin como un Output
pinMode(echoPin, INPUT); // Setea el pin echoPin como un Input
Serial.begin(9600);
myServo.attach(9); // Define en que pin esta conectado el Servo motor
pinMode(buzzer, OUTPUT); //Setea el pin 8 del buzzer como output
}
void loop() {
// Rota el servo de 15 a 165 grados
for(int i=0;i<=180;i++){
  myServo.write(i);
  delay(30);
  distance = calculateDistance();// Llama a esta funcion para calcular la distancia por cada grado
  Serial.print(i); // Envia el grado de inclinacion actual al puerto serial
  Serial.print(","); // Envia una , como caracter de separacion
  Serial.print(distance); // Envia la distancia al puerto serial
  Serial.print("."); // Envia un . como final de la orden
 
  if(distance<20){ // Si la distancia es menor a 20cm el ruido sera mas agudo que si la distancia esta entre mayor a 20 y menor a 40
    tone(8, 1500, 100);
  }else if(distance>20 && distance<40){
    tone(8, 800, 100);
    
    noTone(buzzer);
  }else if(distance>40 && distance<100){
      tone(8, 500, 100);
      
      noTone(buzzer);
  }else if (distance>100 && distance <200){
      tone(8, 250, 100);
      
      noTone(buzzer);
  }else{
    noTone(buzzer);
  }
}
// Repite las lineas previas y hace que ahora el servo vaya de 165 a 15 grados
  for(int i=180;i>0;i--){
    myServo.write(i);
    delay(30);
   
    distance = calculateDistance();// Llama a esta funcion para calcular la distancia por cada grado
    Serial.print(i); // Envia el grado de inclinacion actual al puerto serial
    Serial.print(","); // Envia una , como caracter de separacion
    Serial.print(distance); // Envia la distancia al puerto serial
    Serial.print("."); // Envia un . como final de la orden
   
    if(distance<20){ // Si la distancia es menor a 20cm el ruido sera mas agudo que si la distancia esta entre mayor a 20 y menor a 40
    tone(8, 1500, 100);
  }else if(distance>20 && distance<40){
    tone(8, 800, 100);
      //delay(1000);
      noTone(buzzer);
  }else if(distance>40 && distance<100){
      tone(8, 500, 100);
      //delay(1000);
      noTone(buzzer);
  }else if (distance > 100 && distance < 200){
      tone(8, 250, 100);
      //delay(1500);
      noTone(buzzer);
  }else{
    noTone(8);
  }
  }
}

// Funcion que calcula la distancia real con los datos que nos devuelve el sensor ultrasonico
float calculateDistance(){
digitalWrite(trigPin, LOW);
delayMicroseconds(2);
digitalWrite(trigPin, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin, LOW);
duration = pulseIn(echoPin, HIGH, 30000);
distance= duration*0.034/2;
return distance;
}
