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

    public static ArrayList<Integer> output = new ArrayList<>();

    public static void main(String[] args) {

        final String testCase1Filepath = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-1.txt";
        final String testCase2Filepath = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-2.txt";
        ArrayList<String> parsedFile = new ArrayList<>();

        //read the file and store into array list
        try {
            File file = new File(testCase1Filepath);
            Scanner scan = new Scanner(file);
            while (scan.hasNextLine()) {
                String data = scan.nextLine();
                parsedFile.add(data);
            }

        } catch (FileNotFoundException e) {
            System.out.println("File Not Found");
            e.printStackTrace();
        }

        //System.out.println(parsedFile);

        int[][] adjacencyMatrix = formAdjacencyMatrix(parsedFile);
        ArrayList<int[]> vertices = formListOfVertices(parsedFile);
        printAdjacencyMatrix(adjacencyMatrix);
        printListOfVertices(vertices);
        DFS(adjacencyMatrix, vertices, 0, Integer.parseInt(parsedFile.get(0)) - 1);
        //System.out.println(output);
        // System.out.println("Size of matrix is: " + adjacencyMatrix.length + " x " + adjacencyMatrix[0].length);

        //finalize
        finalizeOutput(output, Integer.parseInt(parsedFile.get(0)) - 1);

    }

    //finalize output
    public static void finalizeOutput(ArrayList<Integer> stringArrayList, int targetValue) {
        //count number of zeros and target values
        ArrayList<Integer> output = new ArrayList<>();
        int zeroCount = 0;
        int targetCount = 0;

        for(int i = 0; i < stringArrayList.size(); i++) {
            if(stringArrayList.get(i) == 0) {
                zeroCount++;
            }

            if(stringArrayList.get(i) == targetValue) {
                targetCount++;
            }
        }

        int difference = targetCount - zeroCount;

        //add a zero after every targetValue
        for(int i = 1; i < stringArrayList.size(); i++) {
            if(difference == 0) {
                break;
            }
            if(stringArrayList.get(i) == targetValue) {
                stringArrayList.add(i, 0);
                i++;
                difference--;
            }

        }

        //System.out.println(stringArrayList);

        // set into string variable
        String o = "";

        o += stringArrayList.get(stringArrayList.size() - 1);
        boolean skip = false;

        for(int i = stringArrayList.size() - 2; i >= 0; i--) {

            if(skip == false) {
                o += "-";
            } else {
                o += "\n";
            }

            skip = false;

            o += stringArrayList.get(i);

            if(stringArrayList.get(i) == targetValue) {
                skip = true;
            }

        }

        System.out.println(o);

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
            aMatrix[Integer.parseInt(ioValue[0])][Integer.parseInt(ioValue[1])] = 1;
        }

        //define some constants
        int nRoads = Integer.parseInt(arr.get(1));
        int numOfBadNodes = Integer.parseInt(arr.get(nRoads + 2));
        int indexOfFirstBadNodeFromFile = Integer.parseInt(arr.get(nRoads+3));

        // bad vertices
        for(int i = 0; i < numOfBadNodes; i++) {
            //System.out.println("i: " + i);
            for(int j = 0; j < aMatrix[0].length; j++) {
                aMatrix[i + indexOfFirstBadNodeFromFile][j] = 0;
                aMatrix[j][i + indexOfFirstBadNodeFromFile] = 0;
            }
        }
        return aMatrix;

    }

    //run modified DFS algorithm
    public static void DFS(int[][] adjacencyMatrix, ArrayList<int[]> verticesList, int s, int targetNumber) {
        int[] u = verticesList.get(s);
        int[] targetV = verticesList.get(targetNumber);

        u[1] = 1; //set V0 to GRAY

        if(u[0] == targetNumber) { // check if current vertex is the target vertex also the base case



        } else { // recursive case
            for(int i = 0; i < adjacencyMatrix[s].length; i++) {
                if(adjacencyMatrix[s][i] == 1) {

                    DFS(adjacencyMatrix, verticesList, i, targetNumber);
                }
            }
        }
        u[1] = 2; //u.color = BLACK
        targetV[1] = 0;

        output.add(s);
        System.out.println(output);
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
