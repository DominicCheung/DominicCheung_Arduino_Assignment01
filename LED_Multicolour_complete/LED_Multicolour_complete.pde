#define LED1_NEGATIVE 2
#define LED1_POSITIVE 3
#define LED2_NEGATIVE 4
#define LED2_POSITIVE 5
#define LED3_NEGATIVE 6
#define LED3_POSITIVE 7

const int RED_LED_PIN = 9;
const int GREEN_LED_PIN = 10;
const int BLUE_LED_PIN = 11;
const int DISPLAY_TIME = 100;

int redIntensity = 0;
int greenIntensity = 0;
int blueIntensity = 0;

unsigned int lockValue;
boolean unlock = false;

#include <Servo.h>
Servo myservo;
int pos = 0;



void setup(){
 
 Serial.begin(9600);
 
 myservo.attach(13 );
}

void loop() {
  redLight();
  greenLight();
  blueLight();
  
  
  lockValue = redIntensity + greenIntensity + blueIntensity;
 
  lockCheck();
  
  Serial.println(redIntensity);
  Serial.println(greenIntensity);
  Serial.println(blueIntensity);
  Serial.println(lockValue);
}

void redLight() {
  
  unsigned int LED1_count;

  pinMode(LED1_NEGATIVE,OUTPUT);
  pinMode(LED1_POSITIVE,OUTPUT);
  digitalWrite(LED1_NEGATIVE,HIGH);
  digitalWrite(LED1_POSITIVE,LOW);
  
  pinMode(LED1_NEGATIVE,INPUT);
  digitalWrite(LED1_NEGATIVE,LOW);
  
  for ( LED1_count = 0; LED1_count < 30000; LED1_count++) {
    if (digitalRead(LED1_NEGATIVE)==0) 
    break;
  }
  
  
  
    redIntensity = map(LED1_count, 0, 30000, 0, 255);
    analogWrite(RED_LED_PIN, redIntensity);
    delay(DISPLAY_TIME);

}

void greenLight() {
  
  
  unsigned int LED2_count;

  pinMode(LED2_NEGATIVE,OUTPUT);
  pinMode(LED2_POSITIVE,OUTPUT);
  digitalWrite(LED2_NEGATIVE,HIGH);
  digitalWrite(LED2_POSITIVE,LOW);
  
  pinMode(LED2_NEGATIVE,INPUT);
  digitalWrite(LED2_NEGATIVE,LOW);
  
  for ( LED2_count = 0; LED2_count < 30000; LED2_count++) {
    if (digitalRead(LED2_NEGATIVE)==0) 
    break;
  }
  
    greenIntensity = map(LED2_count, 0, 30000, 0, 255);
    analogWrite(GREEN_LED_PIN, greenIntensity);
    delay(DISPLAY_TIME);

}
 
void blueLight() {
  
  unsigned int LED3_count;

  pinMode(LED3_NEGATIVE,OUTPUT);
  pinMode(LED3_POSITIVE,OUTPUT);
  digitalWrite(LED3_NEGATIVE,HIGH);
  digitalWrite(LED3_POSITIVE,LOW);
  
  pinMode(LED3_NEGATIVE,INPUT);
  digitalWrite(LED3_NEGATIVE,LOW);
  
  for ( LED3_count = 0; LED3_count < 30000; LED3_count++) {
    if (digitalRead(LED3_NEGATIVE)==0) 
    break;
  }
  
  blueIntensity = map(LED3_count, 0, 30000, 0, 255);
  
  analogWrite(BLUE_LED_PIN, blueIntensity);
    delay(DISPLAY_TIME);

}
     
void lockCheck() {
  if (lockValue >= 750)
  unlock = true;
  if (lockValue < 100)
  unlock = false;
  
  if (unlock == true)  
  for (pos = 0; pos < 180; pos +=1) {
    myservo.write(pos);
    delay(15);
  }
    
  if (unlock == false)
   for (pos = 180; pos >= 180; pos-=1) {
    myservo.write(pos);
    delay(15);
   }
  
}

