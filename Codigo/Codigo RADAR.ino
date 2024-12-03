#include<Servo.h>

const int trigPin = 10;
const int echoPin = 11;

const int buzzer = 8;


long duration;
int distance;
Servo myServo; 
void setup() {
pinMode(trigPin, OUTPUT); 
pinMode(echoPin, INPUT); 
Serial.begin(9600);
myServo.attach(9); 
pinMode(buzzer, OUTPUT); 
}

void loop() {

for(int i=0;i<=180;i++){

  myServo.write(i);
  delay(30);
  distance = calculateDistance();
  Serial.print(i); 
  Serial.print(","); 
  Serial.print(distance); 
  Serial.print("."); 
 
  if(distance<20){ 
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

  for(int i=180;i>0;i--){

    myServo.write(i);
    delay(30);
   
    distance = calculateDistance();
    Serial.print(i); 
    Serial.print(","); 
    Serial.print(distance); 
    Serial.print("."); 
   
    if(distance<20){ 
    tone(8, 1500, 100);
  }else if(distance>20 && distance<40){
    tone(8, 800, 100);
      
      noTone(buzzer);
  }else if(distance>40 && distance<100){
      tone(8, 500, 100);
      
      noTone(buzzer);
  }else if (distance > 100 && distance < 200){
      tone(8, 250, 100);
      
      noTone(buzzer);
  }else{
    noTone(8);
  }
  }
}


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
