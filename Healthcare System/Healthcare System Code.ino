#include <Wire.h>
#include "MAX30100_PulseOximeter.h"
#define REPORTING_PERIOD_MS     1000
PulseOximeter pox;
uint32_t tsLastReport = 0;
#include <LiquidCrystal.h>
String stringtemperature;        
String systolic;
String diastolic;
String pulse;
String temp1;
String stringOne = "this", stringTwo;
String inputString = "";                             // String to hold incoming data
char d = 0;
int countState = 0;
int timerState = 0;
String data;                                         // String systolic;
String sysdata;
String diadata;
String hrdata;
int count = 0;
char e = 0;
int intsystolic = 0;
int intdiastolic = 0;
int intpulse = 0;
int intcel = 0;
int intsysdata = 0;
int intdiadata = 0;
int inthrdata = 0;
const int button1Pin = PB3;                          // The number of the pushbutton pin
int button1State = 0;
const int button2Pin = PB4;                          // The number of the pushbutton pin
int button2State = 0;
LiquidCrystal lcd(PA2, PA3, PA4, PA5, PA6, PA7);
int val;
int tempPin = PA1;
int cel;
int sp = 0;
#define DEBUG true
#define IP "184.106.153.149"
String Api_key = "GET /update?key=SR7EOTPXB4PCUKZA";  // Write API Key for "https://thingspeak.com/channels/1385817"
int error;

void setup()
{
  pinMode(button1Pin, INPUT_PULLUP);
  pinMode(button2Pin, INPUT_PULLUP);
  Serial.begin(9600);
  Serial1.begin(115200);
  Serial3.begin(9600);
  lcd.begin(16, 2);
  lcd.clear();
  lcd.print("IoT HEALTHCARE");
  lcd.setCursor(0, 1);
  lcd.print("    SYSTEM    ");
  delay(3000);
  Serial.begin(9600);
  send_command("AT+RST\r\n", 2000, DEBUG);                        // Reset module
  send_command("AT+CWMODE=1\r\n", 1000, DEBUG);                   // Set station mode
  send_command("AT+CWJAP=\"TGL\",\"12345678\"\r\n", 2000, DEBUG);
  
  if (!pox.begin()) {
    Serial.println("FAILED");
    for (;;);
  } else {
    Serial.println("SUCCESS");
  }
  pox.setIRLedCurrent(MAX30100_LED_CURR_7_6MA);
}

void loop()
{
label1:
  pox.update();
  if (millis() - tsLastReport > REPORTING_PERIOD_MS)
  {
    sp = pox.getSpO2();
    tsLastReport = millis();
    val = analogRead(tempPin);
    float mv = ( val / 4096.0) * 5000;
    cel = mv / 10;
    float farh = (cel * 9) / 5 + 32;
    cel = cel - 15;
    lcd.clear();
    lcd.print("Temp:");
    lcd.print(cel);
    lcd.print("C");
    lcd.setCursor(0, 1);
    lcd.print("SPO2:");
    lcd.print(sp);
    lcd.print("%");
    
    button2State = digitalRead(button2Pin);
    if (button2State == LOW)
    {
      lcd.clear();
      lcd.print("Checking BP/Pulse....");
      Serial1.begin(115200);
      delay(4000);
      goto checkbp;
    }
  }
  goto label1;
  
checkbp:
compare:
  if (Serial1.available() > 0)
  {
    if (Serial1.find("$"))
    {
      lcd.clear();
      lcd.print("$ received!!!");
      
label5:
      d = Serial1.read();
      if (d == '#')
      {
        goto label6;
      }
      delay(10);
      sysdata += d;
      delay(10);
      goto label5;

label6:
      d = Serial1.read();
      if (d == '*')
      {
        goto label7;
      }
      delay(10);
      diadata += d;
      delay(10);
      goto label6;

label7:
      d = Serial1.read();
      delay(10);
      hrdata += d;
      delay(10);

      if (d == '\n')
      {
        lcd.clear();
        lcd.print("S:");
        lcd.print(sysdata);
        lcd.print("/");
        lcd.print("D:");
        lcd.print(diadata);
        lcd.setCursor(0, 1);
        lcd.print("P:");
        lcd.print(hrdata);
        lcd.print("/");
        lcd.print("T:");
        lcd.print(cel);
        lcd.print("/");
        lcd.print("S:");
        lcd.print(sp);
        delay(100);
        intsysdata = sysdata.toInt();
        intdiadata = diadata.toInt();
        inthrdata = hrdata.toInt();
        Serial.print("Systolic:");
        Serial.println(intsysdata);
        Serial.print("Diastolic:");
        Serial.println(intdiadata);
        Serial.print("Heart Rate:");
        Serial.println(inthrdata);
        Serial.print("Temperature:");
        Serial.println(cel);
        Serial.print("SPO2:");
        Serial.println(sp);
        delay(3000);
        updatedata();
        delay(5000);
        goto label1;
      }
      goto label7;
    }
  }

  button2State = digitalRead(button2Pin);
  if (button2State == LOW)
  {
    lcd.clear();
    lcd.print("Checking SPO2/Temp....");
    delay(4000);
    goto label1;
  }
  goto checkbp;
}

void updatedata() {
  String command = "AT+CIPSTART=\"TCP\",\"";
  command += IP;
  command += "\",80";
  Serial.begin(9600);
  delay(200);
  Serial3.begin(9600);
  delay(200);
  Serial.println(command);
  delay(200);
  Serial3.println(command);
  delay(2000);
  if (Serial3.find("Error")) {
    return;
  }
  command = Api_key ;
  command += "&field1=";
  command += String(cel);
  command += "&field2=";
  command += String(sp);
  command += "&field3=";
  command += String(intsysdata);
  command += "&field4=";
  command += String(intdiadata);
  command += "&field5=";
  command += String(inthrdata);
  command += "\r\n\r\n\r\n\r\n\r\n";
  Serial.print("AT+CIPSEND=");
  Serial3.print("AT+CIPSEND=");
  Serial.println(command.length());
  Serial3.println(command.length());

  if (Serial3.find(">")) {
    delay(200);
    Serial.print(command);
    delay(200);
    Serial3.print(command);
    delay(200);
    delay(5000);
    Serial3.println("AT+RST");
    delay(200);
    Serial3.println("AT");
    delay(200);
    Serial3.println("AT");
    delay(200);
  }
  else {
    Serial.println("AT+CIPCLOSE");
    Serial3.println("AT+CIPCLOSE");                         // Resend
    error = 1;
  }
}

String send_command(String command, const int timeout, boolean debug)
{
  Serial3.begin(9600);
  String response = "";
  Serial3.print(command);
  long int time = millis();
  while ( (time + timeout) > millis())
  {
    while (Serial3.available())
    {
      char c = Serial3.read();
      response += c;
    }
  }
  if (debug)
  {
    Serial.print(response);
  }
  return response;
}
