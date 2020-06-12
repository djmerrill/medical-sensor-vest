#include <SPI.h>

#define CS1 7
#define CS2 9
#define CS3 10
#define CS4 11
#define CS5 12
#define CS6 A1


// ADXL343 Registers
const char BW_RATE = 0x2C;
const char POWER_CTL = 0x2D;
const char DATA_FORMAT = 0x31;
const char DATAX0 = 0x32; //X-Axis Data 0
const char DATAX1 = 0x33; //X-Axis Data 1
const char DATAY0 = 0x34; //Y-Axis Data 0
const char DATAY1 = 0x35; //Y-Axis Data 1
const char DATAZ0 = 0x36; //Z-Axis Data 0
const char DATAZ1 = 0x37; //Z-Axis Data 1

//SPI read buffer
unsigned char values[10];

//acceleration values
int x,y,z;
//char x,y,z;

SPISettings settings(10000, MSBFIRST, SPI_MODE3);

void writeRegister(char registerAdress, char value, int CS){
  //Chip select LOW to write to chip
  digitalWrite(CS, LOW);
//  delay(100);
  SPI.transfer(registerAdress);
  SPI.transfer(value);
//  delay(100);
  digitalWrite(CS, HIGH);
}

void readRegister(char registerAdress, int numBytes, unsigned char * values, int CS){
  char adress = 0x80 | registerAdress;
  if(numBytes > 1) adress = adress | 0x40;
  digitalWrite(CS, LOW);
  SPI.transfer(adress);
  for (int i = 0; i < numBytes; i++){
    values[i] = SPI.transfer(0x00);
  }
  digitalWrite(CS, HIGH);
}

void setup_sensor(int CS) {
  pinMode(CS, OUTPUT);

  SPI.begin();
  SPI.beginTransaction(settings);

  delay(500);
  digitalWrite(CS, HIGH);

  delay(500);

  writeRegister(DATA_FORMAT, 0x00, CS);
  writeRegister(POWER_CTL, 0x08, CS);
  writeRegister(BW_RATE, 0x0C, CS); // set sampling rate
//  writeRegister(BW_RATE, 0x0E, CS); // set sampling rate, 1.6k Hz
}



void setup() {
  Serial.begin(1152000); // baudrate might be an issue
  delay(5000);
  Serial.println("x y z");
  
  setup_sensor(CS1);
  delay(50);
  setup_sensor(CS2);
  delay(50);
  setup_sensor(CS3);
  delay(50);
  setup_sensor(CS4);
  delay(50);
  setup_sensor(CS5);
  delay(50);
  setup_sensor(CS6);
  delay(50);
}

void loop() {

  readRegister(DATAX0, 6, values, CS1);
  x = (int) word(values[1], values[0]);
  y = (int) word(values[3], values[2]);
  z = (int) word(values[5], values[4]);
//  Serial.print("\n1 ");
//  Serial.print("\n ");
//  Serial.println("1");
//  Serial.print(x, DEC);
//  Serial.print(" ");
//  Serial.print(y,DEC);
//  Serial.print(" ");
//  Serial.println(z,DEC);

  //delay(1);
//  delayMicroseconds(10);

  readRegister(DATAX0, 6, values, CS2);
  x = (int) word(values[1], values[0]);
  y = (int) word(values[3], values[2]);
  z = (int) word(values[5], values[4]);
//  Serial.println("2");
//  Serial.print(x, DEC);
//  Serial.print(" ");
//  Serial.print(y,DEC);
//  Serial.print(" ");
//  Serial.println(z,DEC);

  //delay(1);
//  delayMicroseconds(10);

  readRegister(DATAX0, 6, values, CS3);
  x = (int) word(values[1], values[0]);
  y = (int) word(values[3], values[2]);
  z = (int) word(values[5], values[4]);
//  Serial.println("3");
//  Serial.print(x, DEC);
//  Serial.print(" ");
//  Serial.print(y,DEC);
//  Serial.print(" ");
//  Serial.println(z,DEC);

  //delay(1);
//  delayMicroseconds(10);

  readRegister(DATAX0, 6, values, CS4);
  x = (int) word(values[1], values[0]);
  y = (int) word(values[3], values[2]);
  z = (int) word(values[5], values[4]);
//  Serial.println("4");
//  Serial.print(x, DEC);
//  Serial.print(" ");
//  Serial.print(y,DEC);
//  Serial.print(" ");
//  Serial.println(z,DEC);

  //delay(1);
//  delayMicroseconds(10);

  readRegister(DATAX0, 6, values, CS5);
  x = (int) word(values[1], values[0]);
  y = (int) word(values[3], values[2]);
  z = (int) word(values[5], values[4]);
//  Serial.println("5");
//  Serial.print(x, DEC);
//  Serial.print(" ");
//  Serial.print(y,DEC);
//  Serial.print(" ");
//  Serial.println(z,DEC);

  // delay(1);
//  delayMicroseconds(10);

  readRegister(DATAX0, 6, values, CS6);
  x = (int) word(values[1], values[0]);
  y = (int) word(values[3], values[2]);
  z = (int) word(values[5], values[4]);
//  Serial.println("6");
//  Serial.print(x, DEC);
//  Serial.print(" ");
//  Serial.print(y,DEC);
//  Serial.print(" ");
//  Serial.println(z,DEC);
  Serial.write("1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx1xx2xx3xx4xx5xx6xx\r\n");
  // delay(1);
//  delayMicroseconds(10);
}
