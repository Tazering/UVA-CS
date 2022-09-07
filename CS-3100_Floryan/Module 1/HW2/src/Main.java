import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *  Name: Tyler Kim
 *  Computing Id: tkj9ep
 *  Filename: Main.java
 *  Programming Language: Java
 */

public class Main {

    static boolean flag = false;

    public static void main(String[] args) {

        final String testCase1Filepath = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-1.txt";
        final String testCase2Filepath = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-2.txt";
        final String testCase3Filepath = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-3.txt";
        final String testCase4Filepath = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-4.txt";
        ArrayList<String> parsedFile = new ArrayList<>();

        //read the file and store into array list
//        try {
//            File file = new File(testCase2Filepath);
//            Scanner scan = new Scanner(file);
//            while (scan.hasNextLine()) {
//                String data = scan.nextLine();
//                parsedFile.add(data);
//            }
//
//        } catch (FileNotFoundException e) {
//            System.out.println("File Not Found");
//            e.printStackTrace();
//        }

        Scanner scan = new Scanner(System.in);
        while (scan.hasNextLine()) {
            String data = scan.nextLine();
            parsedFile.add(data);
        }
        //System.out.println(parsedFile);


        //printAdjacencyMatrix(adjacencyMatrix);
        // printListOfVertices(vertices);
        if(!flag) {
            if (Integer.parseInt(parsedFile.get(0)) != 1) {
                int[][] adjacencyMatrix = formAdjacencyMatrix(parsedFile);
                ArrayList<int[]> vertices = formListOfVertices(parsedFile);
                DFS(adjacencyMatrix, vertices, 0, Integer.parseInt(parsedFile.get(0)) - 1, "");

            } else {
                System.out.println("0");
            }
        }


    }

    //makes the adjacency matrix
    public static int[][] formAdjacencyMatrix(ArrayList<String> arr) {
        int[][] aMatrix = new int[Integer.parseInt(arr.get(0))][Integer.parseInt(arr.get(0))];

        //set all elements to 0
        for(int r = 0; r < aMatrix.length; r++) {
            for(int c = 0; c < aMatrix[0].length; c++) {
                aMatrix[r][c] = 0;
            }
        }

        // each row represents input and each output represents output
        for(int i = 0; i < Integer.parseInt(arr.get(1)); i++) {
            String[] ioValue = arr.get(i+2).split(" ");
            int vi = Integer.parseInt(ioValue[0]);
            int vj = Integer.parseInt(ioValue[1]);
            aMatrix[vi][vj] = 1;
            aMatrix[vj][vi] = 1;
        }

        //define some constants
        int nRoads = Integer.parseInt(arr.get(1));
        int numOfBadNodes = Integer.parseInt(arr.get(nRoads + 2));
        int indexOfFirstBadNodeFromFile = 0;

        if(numOfBadNodes != 0) {
            indexOfFirstBadNodeFromFile = nRoads+3;
        }

        // bad vertices
        for(int i = 0; i < numOfBadNodes; i++) {

            int badNode = Integer.parseInt(arr.get(i + indexOfFirstBadNodeFromFile));

            if(badNode == 0) {
                flag = true;
            }

            for(int j = 0; j < aMatrix[0].length; j++) {
                aMatrix[badNode][j] = 0;
                aMatrix[j][badNode] = 0;
            }
        }
        return aMatrix;

    }

    //run modified DFS algorithm
    public static void DFS(int[][] adjacencyMatrix, ArrayList<int[]> verticesList, int s, int targetNumber, String o) {
        int[] u = verticesList.get(s);
        int[] targetV = verticesList.get(targetNumber);

        u[1] = 1; //set s to GRAY
        o += s;
        o += "-";

        if(u[0] == targetNumber) { // check if current vertex is the target vertex; also the base case
            System.out.println(o.substring(0, o.length()-1));
        } else { // recursive case
            for(int i = 0; i < adjacencyMatrix[s].length; i++) {
                if(adjacencyMatrix[s][i] == 1) {
                    if(verticesList.get(i)[1] == 0) {
                        DFS(adjacencyMatrix, verticesList, i, targetNumber, o);
                    }
                }
            }
        }
        u[1] = 2; //u.color = BLACK
        u[1] = 0;
        targetV[1] = 0;

    }

    //makes array of vertices
    public static ArrayList<int[]> formListOfVertices(ArrayList<String> arr) {
        ArrayList<int[]> listOfVertices = new ArrayList<>();

        //creates a list of vertices
        for(int i = 0; i < Integer.parseInt(arr.get(0)); i++) {
            int[] vertex = new int[4];
            for(int j = 0; j < 4; j++) {
                vertex[j] = 0;
            }
            vertex[0] = i;
            listOfVertices.add(vertex);
        }
        return listOfVertices;
    }

    public static void printAdjacencyMatrix(int[][] matrix) {
        System.out.println("Adjacency Matrix...");
        for(int i = 0; i < matrix.length; i++) {
            System.out.println("");
            for(int j = 0; j < matrix[0].length; j++) {
                System.out.print(matrix[i][j] + " ");
            }
        }

        System.out.println("");
    }

    public static void printListOfVertices(ArrayList<int[]> list) {
        System.out.println("List of Vertices...");
        for(int[] v: list) {
            printVertex(v);
        }
    }

    public static void printVertex(int[] vertex) {
        System.out.println("Vertex: " + vertex[0]);
        System.out.println("    Color: " + vertex[1]);
    }
}
