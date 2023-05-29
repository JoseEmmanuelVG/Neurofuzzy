const int triggerPin = 9;
const int echoPin = 10;
const int lm35Pin = A0;
//extra led
const int ledPin = 11;

const int motorIn1 = 5; // IN1
const int motorIn2 = 6; // IN2
const int motorEnA = 7; // ENA

String dataString = "";
bool dataComplete = false;
const char separator = ',';
const int dataLength = 1;
int datos[dataLength];
//double datos[sizeData];

// Angulos en grados
int vel = 0;
int distance = 4;
int temperature = 5;
int pwm = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(triggerPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(motorIn1, OUTPUT);
  pinMode(motorIn2, OUTPUT);
  pinMode(motorEnA, OUTPUT);
  // extra led
  pinMode(ledPin, OUTPUT);
}

void loop() {
  //Leemos el dato que envia Matlab
  if (dataComplete)
  {
    for (int i = 0; i < dataLength ; i++)
    {
      int index = dataString.indexOf(separator);
      datos[i] = dataString.substring(0, index).toInt();
      dataString = dataString.substring(index + 1);
    }

    //Asignamos el dato leido en esta variable de velocidad
    vel = datos[0];

    // Distance measurement
    digitalWrite(triggerPin, LOW);
    delayMicroseconds(2);
    digitalWrite(triggerPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(triggerPin, LOW);
    unsigned long pulseDuration = pulseIn(echoPin, HIGH);
    float distance = pulseDuration * 0.0343 / 2;

    //Limitamos la lectura de distancia
    if (distance<=5)
      distance=5;
    if (distance>=200)
      distance=200;

    // Temperature measurement
    int lm35Reading = analogRead(lm35Pin);
    float voltage = lm35Reading * (5.0 / 1023.0);
    float temperature = voltage * 100.0;

    //limitamos la lectura de temperatura
    if (temperature<=10)
      temperature=10;
    if (temperature>=50)
      temperature=50;

    //Enviamos a Matlab los datos leidos de distancia y temperatura
    Serial.print(distance);
    Serial.print(",");
    Serial.print(temperature);
    Serial.println(";");

    //Convertimos la velocidad de Matlab en PWM para el motor
    pwm = (int)vel / 15;
    analogWrite(ledPin, pwm);

    dataString = "";
    dataComplete = false;
  }
}

void serialEvent() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    dataString += inChar;
    if (inChar == '\n') {
      dataComplete = true;
    }
  }
}
