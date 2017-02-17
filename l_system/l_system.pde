import java.util.*;

interface Rule {
  public String apply(Character c);
}

String axiom = "F";
String sentence = axiom;

float len = 100;

void setup() {
  size(400, 400);
  
}

String rules(Character c) {
  switch (c) {
    case 'F':
      return "FF+[+F-F-F]-[-F+F+F]";
    default:
      return "" + c;
  }
}

void turtle() {
  for (int i = 0; i < sentence.length(); i++) {
    Character c = sentence.charAt(i);
    
    switch (c) {
      case 'F':
        line(0, 0, 0, -len);
        translate(0, -len);
        continue;
      case '+':
        rotate(radians(25));
        continue;
      case '-':
        rotate(-radians(25));
        continue;
      case '[':
        pushMatrix();
        continue;
      case ']':
        popMatrix();
        continue;
      default:
        continue;
    }
  }
}

String generate(String s) {
  String ns = "";
  for (int i = 0; i < s.length(); i++) {
    ns += rules(s.charAt(i));
  }
  len *= 0.5;
  return ns;
}

void mousePressed() {
  sentence = generate(sentence);
}

void draw() {
  background(51);
  stroke(255, 255, 255, 50);
  translate(width / 2, height);
  turtle();
}