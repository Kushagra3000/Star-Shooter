
#include <I2Cdev.h>
#include <Wire.h>
#include <I2Cdev.h>
#include <MPU6050.h>
#include <Mouse.h>

MPU6050 mpu;
int16_t ax, ay, az, gx, gy, gz;
int vx, vy;

int responseDelay = 10;
void setup() {
  pinMode(7,INPUT);
  Serial.begin(9600);
  Wire.begin();
  Mouse.begin();
  mpu.initialize();
 }


void loop() {
  mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
  vx = (gx + 0) / 300;
  vy = -(gz +0) /300;

    if (digitalRead(7) == HIGH) {
    Serial.println("sensor is touched");
    Mouse.press(MOUSE_LEFT);
    delay(100);
    Mouse.release(MOUSE_LEFT);
    delay(200);
  }
  
  Mouse.move(vx, vy);

  delay(10);
} 