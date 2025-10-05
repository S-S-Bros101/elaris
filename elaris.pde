void setup() {
    size(700, 700);
    frameRate(30);
    generateMaze(15, 15, 6, height, width);
}

void draw() {
    image(Maze, 0, 0);
    ellipse(mouseX, mouseY, 20, 20);
}

void mousePressed() {
    generateMaze(15, 15, 6, height, width);
}