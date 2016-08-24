#include <SPI.h>

#define ADXL362_CS SS
#define ADXL362_XDATA_L 0x0e
#define ADXL362_XDATA_H 0x0f
#define ADXL362_YDATA_L 0x10
#define ADXL362_YDATA_H 0x11
#define ADXL362_ZDATA_L 0x12
#define ADXL362_ZDATA_H 0x13
#define ADXL362_FILTER 0x2c
#define ADXL362_POWER_CTL 0x2d
#define WRITE 0xa
#define READ 0xb
#define READ_FIFO 0xd
#define SENSING_THRESHOLD 700

#define WALK_MONITOR_TIME 30
#define WALK_THRESHOLD 7

short nx,ny,nz;
short ox,oy,oz;

unsigned long startTime=0;
unsigned long stepavg=0;
bool isWalk;

unsigned long stepcnt;
unsigned long time=-1;
String buffer;
String buf2;
bool isUp;

void regWrite(byte reg, byte val)
{
  digitalWrite(ADXL362_CS, LOW);
  SPI.transfer(WRITE);
  SPI.transfer(reg);
  SPI.transfer(val);
  digitalWrite(ADXL362_CS, HIGH);
}
byte regRead(byte reg)
{
  byte ret;
  digitalWrite(ADXL362_CS, LOW);
  SPI.transfer(READ);
  SPI.transfer(reg);
  ret = SPI.transfer(0); 
  digitalWrite(ADXL362_CS, HIGH); 
  return ret;
}
void readSensor()
{
  nx = regRead(ADXL362_XDATA_H);
  nx = (nx << 8) | regRead(ADXL362_XDATA_L);
  ny = regRead(ADXL362_YDATA_H);
  ny = (ny << 8) | regRead(ADXL362_YDATA_L);
  nz = regRead(ADXL362_ZDATA_H);
  nz = (nz << 8) | regRead(ADXL362_ZDATA_L);
}
void setup()
{
  pinMode(3,INPUT_PULLUP);
  digitalWrite(SS, HIGH);
  pinMode(SS, OUTPUT); 
  SPI.begin();
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV8); // 8MHz/8 = 1MHz
  regWrite(ADXL362_FILTER, 0x13); // +-2g range, 100Hz
  regWrite(ADXL362_POWER_CTL, 0x02); // normal operation, measurement mode
  readSensor();
  Serial.begin(9600);
}
void loop()
{
  ox=nx;oy=ny;oz=nz;
  readSensor();
  if(abs(ny-oy)>SENSING_THRESHOLD){
    
    if(isUp){
      if(startTime==-1){
        startTime=time;
        stepavg=0;
        buf2=String();
      }
      if(time-startTime>WALK_MONITOR_TIME*10){
        startTime=-1;
        isWalk=false;
      }
      stepavg++;
      buf2+=String(String(time/10)+","+String(stepavg)+";");
      if(stepavg>=WALK_THRESHOLD){
        if(!isWalk){
          stepcnt=stepavg;
          buffer+=buf2;
        }
        startTime=-1;
        isWalk=true;
      }
      if(isWalk){
        stepcnt++;
        buffer+=String(String(time/10)+","+String(stepcnt)+";");
      }
    }
    isUp=!isUp;
  }
  
  if(digitalRead(3)==LOW&&Serial){
      Serial.println(buffer);
      buffer=String();
      stepcnt=0;
      time=0;
  }
  delay(100);
  time++;
}

