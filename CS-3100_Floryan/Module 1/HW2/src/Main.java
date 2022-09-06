import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {


    public static void main(String[] args) {

        final String testCase1Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-1.txt";
        final String testCase2Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-2.txt";
        ArrayList<String> arrayList = new ArrayList<>();


        //read the file and store into array list
        try {
            File file = new File(testCase2Filepath);
            Scanner scan = new Scanner(file);
            while (scan.hasNextLine()){
                String data = scan.nextLine();
                arrayList.add(data);
            }

        } catch(FileNotFoundException e) {
            System.out.println("File Not Found");
            e.printStackTrace();
        }

        System.out.println(arrayList);

        int[][] adjacencyMatrix = formAdjacencyMatrix(arrayList);
        ArrayList<int[]> vertices = formListOfVertices(arrayList);
        printAdjacencyMatrix(adjacencyMatrix);
        printListOfVertices(vertices);
        // System.out.println("Size of matrix is: " + adjacencyMatrix.length + " x " + adjacencyMatrix[0].length);
    }

    //makes the adjacency matrix
    public static int[][] formAdjacencyMatrix(ArrayList<String> arr) {
        int[][] aMatrix = new int[Integer.parseInt(arr.get(0))][Integer.parseInt(arr.get(0))];


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

        return aMatrix;

    }

    //makes array of vertices
    public static ArrayList<int[]> formListOfVertices(ArrayList<String> arr) {
        ArrayList<int[]> listOfVertices = new ArrayList<>();
        int nRoads = Integer.parseInt(arr.get(1));

        for(int i = 0; i < Integer.parseInt(arr.get(0)); i++) {

            int[] vertex = new int[4];

            for(int j = 0; j < 4; j++) {
                vertex[j] = 0;
            }

            vertex[0] = i;
            listOfVertices.add(vertex);
        }

        for(int i = 0; i < Integer.parseInt(arr.get(nRoads + 2)); i++) {
            System.out.println("i: " + i);
            listOfVertices.get(Integer.parseInt(arr.get(i + (nRoads+3))))[3] = 1;
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
        System.out.println("    Pi: " + vertex[2]);
        System.out.println("    isDangerous: " + vertex[3]);
    }

}
