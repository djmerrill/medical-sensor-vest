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

//Serial buffer
// I use a char array because it is 10x faster than using the Arduino built in String type
char ser_buff[25];

// Redefine these character so that the Arduino serial code plays nice with the raw values
char zero_char = 64;
char newline_char = 65;

//acceleration values
int x,y,z;
//char x,y,z;

SPISettings settings(1000000, MSBFIRST, SPI_MODE3);

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
  delay(1000);
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
  Serial.println("x y z");
}

void loop() {
  readRegister(DATAX0, 6, values, CS1);
//  x = (int) word(values[1], values[0]);
//  y = (int) word(values[3], values[2]);
//  z = (int) word(values[5], values[4]);
  ser_buff[0] = values[0];
  ser_buff[1] = values[2];
  ser_buff[2] = values[4];
//  ser_buff[3] = newline_char; // These "new lines" are not really needed because there is a frame marker of '\r\n' from Serial.println() at the end of the frame
  

  readRegister(DATAX0, 6, values, CS2);
  ser_buff[3] = values[0];
  ser_buff[4] = values[2];
  ser_buff[5] = values[4];
//  ser_buff[7] = newline_char;

  readRegister(DATAX0, 6, values, CS3);
  ser_buff[6] = values[0];
  ser_buff[7] = values[2];
  ser_buff[8] = values[4];
//  ser_buff[11] = newline_char;

  readRegister(DATAX0, 6, values, CS4);
  ser_buff[9] = values[0];
  ser_buff[10] = values[2];
  ser_buff[11] = values[4];
//  ser_buff[15] = newline_char;

  readRegister(DATAX0, 6, values, CS5);
  ser_buff[12] = values[0];
  ser_buff[13] = values[2];
  ser_buff[14] = values[4];
//  ser_buff[19] = newline_char;

  readRegister(DATAX0, 6, values, CS6);
  ser_buff[15] = values[0];
  ser_buff[16] = values[2];
  ser_buff[17] = values[4];
  ser_buff[18] = newline_char;

  // We need to replace the '\0' so that Serial.println() will send the whole string.
  for (int i = 0; i < 24; i += 1) {
    if (ser_buff[i] == '\0')
      ser_buff[i] = zero_char;
  }

  // This should be the only '\0' in the array
  ser_buff[19] = '\0';

  // Serial.println() adds a "\r\n". This maps to 13, 10 in ASCII.
  Serial.println(ser_buff);
}
