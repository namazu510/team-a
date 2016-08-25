#include <SPI.h>

//ADXL362の通信用マクロ
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

//データ送信ピン
#define SEND_PIN 3

//LEDピン
#define LED_PIN 2

//各種閾値
#define THRESHOLD_SENSING 670 //足を動かしたという判定用
#define THRESHOLD_WALK_TIME 15//運動開始を判定する時間
#define THRESHOLD_WALK_COUNT 4//運動開始を判定する歩数

//センサ値
short now_x, now_y, now_z;
short old_x, old_y, old_z;

//運動開始判定前に運動を記録するバッファ
unsigned long before_time = 0;
unsigned long before_stepcnt = 0;
String before_buffer;

//運動開始後のバッファ
unsigned long stepcnt;
unsigned long time = -1;
String buffer;

//フラグ
bool isUp;  //足を上げた
bool isWalk;//歩いている

//SPI通信でADXL362に値を書き込む
void regWrite(byte reg, byte val) {
  digitalWrite(ADXL362_CS, LOW);
  SPI.transfer(WRITE);
  SPI.transfer(reg);
  SPI.transfer(val);
  digitalWrite(ADXL362_CS, HIGH);
}

//SPI通信でADXL362から値を読み込む
byte regRead(byte reg) {
  byte ret;
  digitalWrite(ADXL362_CS, LOW);
  SPI.transfer(READ);
  SPI.transfer(reg);
  ret = SPI.transfer(0);
  digitalWrite(ADXL362_CS, HIGH);
  return ret;
}

//各種値を読み込む
void readSensor() {
  //データは8bit×2なのでH側とL側でデータを取得する。
  now_x = regRead(ADXL362_XDATA_H);
  now_x = (now_x << 8) | regRead(ADXL362_XDATA_L);
  now_y = regRead(ADXL362_YDATA_H);
  now_y = (now_y << 8) | regRead(ADXL362_YDATA_L);
  now_z = regRead(ADXL362_ZDATA_H);
  now_z = (now_z << 8) | regRead(ADXL362_ZDATA_L);
}

//初期化
void setup() {

  //IOピンの初期設定
  pinMode(SEND_PIN, INPUT_PULLUP); //送信用ボタン用ピンをプルアップ入力に設定
  pinMode(LED_PIN, OUTPUT); //歩行時に点灯する機能
  digitalWrite(LED_PIN,LOW);
  digitalWrite(SS, HIGH);
  pinMode(SS, OUTPUT);

  //SPIの初期設定
  SPI.begin();
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV8);  //今回のSPI通信では1Mhzを使用

  //センサの初期設定
  regWrite(ADXL362_FILTER, 0x13);
  regWrite(ADXL362_POWER_CTL, 0x02);
  readSensor();   //センサー値を初期化

  //シリアル通信を行おうと試みる
  Serial.begin(9600);   //シリアル通信を9600bpsで始める
}

void addBuffer(String buf){
  buffer+=buf;//バッファにデータを追加する
}
void addBeforeBuffer(String buf){
  before_buffer+=buf;//バッファにデータを追加する
}

void walk(){
    //センサー値は1歩で上下で2回反応するのでその判定。
    if (isUp) {

      //運動開始判定
      if (before_time == -1) { //運動していないという判定であれば
        before_time = time;
        before_stepcnt = 0;
        before_buffer = String(); //今までとりあえず溜め込んでいたバッファを削除
      }
      if (time - before_time > THRESHOLD_WALK_TIME * 10) { //閾値分時間がたっていたら
        before_time = -1; //運動していないという判定に
        isWalk = false; //運動終了
        addBuffer(String("|"));//運動の区切りをバッファに追加
      }
      //歩数カウント
      before_stepcnt++;
      //バッファに歩行記録を追加
      addBeforeBuffer(String(time / 10) + "," + String(before_stepcnt) + ";");

      //一定時間内に一定歩数歩いた場合(運動開始)
      if (before_stepcnt >= THRESHOLD_WALK_COUNT) {

        //いままで運動していなかったら
        if (!isWalk) {
          //運動判定時のカウントは運動時カウントだったということでデータに追加する
          stepcnt = before_stepcnt;
          buffer += before_buffer;
        }

        //運動判定用のタイマをリセッ
        before_time = -1;
        //運動している状態へ
        isWalk = true;
        digitalWrite(LED_PIN,HIGH);

      }

      //運動している判定なら
      if (isWalk) {
        stepcnt++;
        addBuffer(String(time / 10) + "," + String(stepcnt) + ";");

      }
    }
    isUp = !isUp; //足の上げ下げを判定
}

//ループ
void loop() {

  //センサー値を更新
  old_x = now_x; old_y = now_y; old_z = now_z;
  readSensor();

  //足を動かしたかの判定
  if (abs(now_y - old_y) > THRESHOLD_SENSING) {
    walk();//歩いた際の処理
  }

  //転送処理
  if (digitalRead(SEND_PIN) == LOW && Serial) {
    if(buffer.length()>0){
      Serial.println(String(time/10)+"*"+buffer);//バッファのデータを転送
  
      //初期化処理を送信
      buffer = String();
      stepcnt = 0;
      time = 0;
      before_time = -1;
      before_stepcnt = 0;
    }
  }
  delay(100);//100ms
  time++;//100msに1カウント(誤差あり)
  if (time - before_time > THRESHOLD_WALK_TIME * 10) {
    digitalWrite(LED_PIN,LOW);
  }
}

