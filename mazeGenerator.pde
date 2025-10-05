PGraphics Maze;

void generateMaze(int numColumns, int numRows, int strokeWeight, int height, int width) {
    // using Kruskal's Algorithm
    int[][] grid = new int[numColumns][numRows];

    for (int i = 0; i < numColumns; i++) {
        for (int j = 0; j < numRows; j++) {
            grid[i][j] = i * numRows + j;
        }
    }

    int[][] verticalWalls = new int[numColumns - 1][numRows];
    int[][] horizontalWalls = new int[numColumns][numRows - 1];

    boolean done = false;
    while (!done) {
        int x = floor(random(numColumns));
        int y = floor(random(numRows));

        // pick a directly adjacent cell
        int x2 = x;
        int y2 = y;
        if (random(1) < 0.5) {
            x2 += floor(random(0, 1)*2)-1;
        } else {
            y2 += floor(random(0, 1)*2)-1;
        }

        if (x2 < 0 || x2 >= numColumns || y2 < 0 || y2 >= numRows) { // check if the cell is out of bounds
            continue;
        }
        
        if (grid[x][y] == grid[x2][y2]) { // check if the cells are already connected
            continue;
        }

        int oldValue = grid[x2][y2];
        int newValue = grid[x][y];

        boolean unique = true;

        for (int i = 0; i < numColumns; i++) {
            for (int j = 0; j < numRows; j++) {
                if (grid[i][j] == oldValue) {
                    grid[i][j] = newValue;
                }

                if (unique) {
                    if (grid[i][j] != newValue) {
                        unique = false;
                    }
                }
            }
        }

        // remove the wall between the two cells
        if (x == x2) { // horizontal wall
            horizontalWalls[x][min(y, y2)] = 1;
        } else { // vertical wall
            verticalWalls[min(x, x2)][y] = 1;
        }

        if (unique) {
            done = true;
        }
    }


    Maze = createGraphics(width, height);
    Maze.beginDraw();
    Maze.background(100);
    Maze.stroke(0);
    Maze.strokeWeight(strokeWeight);

    // draw walls
    for (int i = 0; i < verticalWalls.length; i++) {
        for (int j = 0; j < verticalWalls[i].length; j++) {
            if (verticalWalls[i][j] == 0) {
                Maze.line((i + 1) * (width / numColumns), j * (height / numRows), (i + 1) * (width / numColumns), (j + 1) * (height / numRows));
            }
        }
    }

    for (int i = 0; i < horizontalWalls.length; i++) {
        for (int j = 0; j < horizontalWalls[i].length; j++) {
            if (horizontalWalls[i][j] == 0) {
                Maze.line(i * (width / numColumns), (j + 1) * (height / numRows), (i + 1) * (width / numColumns), (j + 1) * (height / numRows));
            }
        }
    }

    // draw border
    Maze.noFill();
    Maze.rect(0, 0, width - strokeWeight/2, height - strokeWeight/2);

    Maze.endDraw();
}