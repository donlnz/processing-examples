// pipes med vattenläckage

int scale = 20;
int cols, rows;

ArrayList<Pipe> pipes = new ArrayList<Pipe>();

void setup() {
  size(400, 400);
  
  pipes.add(new Pipe(new PVector(0, 0), scale));
}

void draw() {
  background(51);

  ArrayList<Pipe> newPipes = new ArrayList<Pipe>();
  for (Pipe p : pipes) {
    Pipe newPipe = p.connect(pipes);
    if (newPipe != null)
      newPipes.add(newPipe);
  }
  pipes.addAll(newPipes);
  
  for (Pipe p : pipes) {
    p.show();
  }
}