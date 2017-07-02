int P = 0;
float distance;
float Dis;
int a = 0;
int b = 0;

void setup() {
  Serial.begin(9600);

  pinMode(A0, OUTPUT);//led
  pinMode(A1, OUTPUT);
  pinMode(A2, OUTPUT);
  pinMode(A3, OUTPUT);
  digitalWrite(A0, LOW);
  digitalWrite(A1, LOW);
  digitalWrite(A2, LOW);
  digitalWrite(A3, LOW);

  pinMode(2, OUTPUT);//chaoshengbo
  pinMode(3, INPUT);
  pinMode(4, OUTPUT);
  pinMode(5, INPUT);
}

void loop() {

  if (Serial.available()) {
    P = Serial.read();
    if (P == 97) {
      digitalWrite(A0, HIGH);
      a = 1;
    }
    if (P == 98) {
      digitalWrite(A0, LOW);
      a = 0;
    }
    if (P == 99) {
      digitalWrite(A1, HIGH);
    }
    if (P == 100) {
      digitalWrite(A1, LOW);
    }
    if (P == 101) {
      digitalWrite(A2, HIGH);
    }
    if (P == 102) {
      digitalWrite(A2, LOW);
    }
    if (P == 103) {
      digitalWrite(A3, HIGH);
      b=1;
    }
    if (P == 104) {
      digitalWrite(A3, LOW);
      b=0;
    }


  }
  if (a == 1) {
    digitalWrite(2, LOW);
    delayMicroseconds(2);
    digitalWrite(2, HIGH);
    delayMicroseconds(10);
    digitalWrite(2, LOW);
    distance = pulseIn(3, HIGH) / 58.8;
    if (distance <= 10) {
      digitalWrite(A0, LOW);
    } else {
      digitalWrite(A0, HIGH);
    }
    delay(50);
  } else {
    digitalWrite(A0, LOW);
  }

  if (b == 1) {
    digitalWrite(4, LOW);
    delayMicroseconds(2);
    digitalWrite(4, HIGH);
    delayMicroseconds(10);
    digitalWrite(4, LOW);
    Dis = pulseIn(5, HIGH) / 58.8;
    if (Dis <= 10) {
      digitalWrite(A3, LOW);
    } else {
      digitalWrite(A3, HIGH);
    } delay(50);
  } else {
    digitalWrite(A3, LOW);
  }

}




