import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Main {

    /**
     *  Name: Tyler Kim
     *  Computing Id: tkj9ep
     *  Filename: Main.java
     *  Programming Language: Java
     */

    static Map<String, Integer> numToTaskTable = new HashMap<>();

    public static void main(String[] args) {



        //read the file and store into array list
        final String testCase1Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW1-Tasks/src/test-cases/test-case-1.txt";

        ArrayList<String> parsedFile = new ArrayList<>();

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

        String[] metaData = parsedFile.get(0).split(" ");
        int t = Integer.parseInt(metaData[0]);
        int d = Integer.parseInt(metaData[1]);

        Vertex[] vertices = formVerticesList(parsedFile, t);
        int[][] adjacencyMatrix = formAdjacencyMatrix(parsedFile, vertices, t, d);


        printVerticesList(vertices);
        printAdjacencyMatrix(adjacencyMatrix);

    }

    //creates a list of vertices
    public static Vertex[] formVerticesList(ArrayList<String> parsedFile, int t) {
        Vertex[] listOfVertices = new Vertex[t];

        //puts all vertices into list
        for(int i = 0; i < t; i++) {
            String taskName = parsedFile.get(i + 1);
            listOfVertices[i] = new Vertex(i, taskName, 0, false);
            numToTaskTable.put(taskName, i);
        }

        return listOfVertices;
    }

    //forms the adjacency matrix
    public static int[][] formAdjacencyMatrix(ArrayList<String> parsedFile, Vertex[] vertices, int t, int d) {
        int indexOfFirstDependency = t + 1;

        System.out.println("t: " + t + " d: " + d);

        //initialize adjacency matrix
        int[][] adjacencyMatrix = new int[t][t];
        for(int i = 0; i < adjacencyMatrix.length; i++) {
            for(int j = 0; j < adjacencyMatrix[i].length; j++) {
                adjacencyMatrix[i][j] = 0;
            }
        }

        //form adjacency matrix
        for(int i = 0; i < d; i++) {
            String[] edge = parsedFile.get(indexOfFirstDependency + i).split(" ");
            int inputId = numToTaskTable.get(edge[0]);
            int outputId = numToTaskTable.get(edge[1]);

            vertices[outputId].setInDegrees(vertices[outputId].getInDegrees() + 1);

            adjacencyMatrix[inputId][outputId] = 1;
        }


        return adjacencyMatrix;
    }

    //debugging tools
    public static void printVerticesList(Vertex[] verticesList) {
        for(int i = 0; i < verticesList.length; i++) {
            System.out.println(verticesList[i].printVertex());
        }
    }

    public static void printAdjacencyMatrix(int[][] adjacencyMatrix) {
        System.out.println("Adjacency Matrix...");
        for(int i = 0; i < adjacencyMatrix.length; i++) {
            for(int j = 0; j < adjacencyMatrix[0].length; j++) {
                System.out.print(adjacencyMatrix[i][j] + "\t");
            }
            System.out.println("");
        }
    }

}
