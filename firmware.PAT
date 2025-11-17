#include <Servo.h>

Servo panServo;
Servo tiltServo;

// Define pins
const int panPin = 9;   // Servo 1
const int tiltPin = 10; // Servo 2

// Default angles
int panAngle = 90;   // center
int tiltAngle = 90;  // center

void setup() {
  panServo.attach(panPin);
  tiltServo.attach(tiltPin);

  panServo.write(panAngle);
  tiltServo.write(tiltAngle);

  Serial.begin(9600);
  Serial.println("Pan-Tilt Controller Ready");
  Serial.println("Send: P<number>  or  T<number>");
  Serial.println("Example: P120  or  T45");
}

void loop() {
  if (Serial.available()) {
    char prefix = Serial.read();   // 'P' or 'T'
    int value = Serial.parseInt(); // Angle value

    if (prefix == 'P') {
      panAngle = constrain(value, 0, 180);
      smoothMove(panServo, panAngle);
      Serial.print("Pan set to: ");
      Serial.println(panAngle);
    }

    if (prefix == 'T') {
      tiltAngle = constrain(value, 0, 180);
      smoothMove(tiltServo, tiltAngle);
      Serial.print("Tilt set to: ");
      Serial.println(tiltAngle);
    }
  }
}

// Smooth movement function
void smoothMove(Servo &servo, int targetAngle) {
  int currentAngle = servo.read();

  if (currentAngle < targetAngle) {
    for (int pos = currentAngle; pos <= targetAngle; pos++) {
      servo.write(pos);
      delay(10);
    }
  } else {
    for (int pos = currentAngle; pos >= targetAngle; pos--) {
      servo.write(pos);
      delay(10);
    }
  }
}

