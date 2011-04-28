// RGB Lamp, based on HSV model
// João Moreno, 2011
//
// http://blog.joaomoreno.com/arduino-rgb-lamp/
// https://github.com/joaomoreno/arduino-rgb-lamp
// http://en.wikipedia.org/wiki/HSL_and_HSV#From_HSV

// *** Customize these values for your setup

int pinR= 11;               // red pin
int pinG= 9;                // green pin
int pinB= 10;               // blue pin
double saturation= 1.0;     // saturation
double value= 1.0;          // value
double granularity= 0.002;  // hue step interval (between [0,1])
int ms= 200;                // sleep interval (lower is faster)

// *****************************************

double chroma= saturation * value;
double match= value - chroma;

int debase(double value, int base) {
    return (int) (value * (double) base);
}

void hueToRGB(double hue, double *r, double *g, double *b) {
    double h= debase(hue, 360) / 60.0;
    double x= chroma * (1 - fabs(fmod(h, 2.0) - 1));
    if (h < 1) {
        *r= chroma;
        *g= x;
        *b= 0;
    } else if (h < 2) {
        *r= x;
        *g= chroma;
        *b= 0;
    } else if (h < 3) {
        *r= 0;
        *g= chroma;
        *b= x;
    } else if (h < 4) {
        *r= 0;
        *g= x;
        *b= chroma;
    } else if (h < 5) {
        *r= x;
        *g= 0;
        *b= chroma;
    } else {
        *r= chroma;
        *g= 0;
        *b= x;
    }
    *r= *r + match;
    *g= *g + match;
    *b= *b + match;
}

void setup()  {}

void loop() {
    double r, g, b;
    for(double hue= 0.0; hue <= 1.0; hue += granularity) {
        hueToRGB(hue, &r, &g, &b);
        analogWrite(pinR, debase(r, 255));
        analogWrite(pinG, debase(g, 255));
        analogWrite(pinB, debase(b, 255));
        delay(ms);
    }
}

