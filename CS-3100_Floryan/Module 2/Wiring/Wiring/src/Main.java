/*
    Name: Tyler Kim
    Computing Id: tkj9ep
    Homework: Wiring
 */

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public class Main {

    int cost = 0;

    static HashMap<String, Integer> nodeToID = new HashMap<>(); //for the adjacency matrix

    static String testCase1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-1.txt";

    public static void main(String[] args) {

        ArrayList<String> parsedFile = new ArrayList<>();

        //read in the data

        //testing purposes
        try{
            File file = new File(testCase1);
            Scanner scan = new Scanner(file);
            while(scan.hasNextLine()) {
                String data = scan.nextLine();
                parsedFile.add(data);
            }

        } catch(FileNotFoundException e) {
            System.out.println("Could not find file.");
        }

        //submission purposes
//        Scanner scan = new Scanner(System.in);
//        while(scan.hasNextLine()) {
//            String data = scan.nextLine();
//            parsedFile.add(data);
//        }
        String[] metaData = parsedFile.get(0).split(" ");

        int numberOfVertices = Integer.parseInt(metaData[0]);
        int numberOfEdges = Integer.parseInt(metaData[1]);

        //System.out.println(parsedFile);

        //get vertices and edges
        Vertex[] vertices = formVerticesList(numberOfVertices, parsedFile);
        int[][] adjacencyMatrix = formAdjacencyMatrix(vertices, numberOfEdges, parsedFile);

        //printAdjacencyMatrix(adjacencyMatrix);
        //printVertices(vertices);
        //printNodeToID();
    }
    //Form Vertices List
    public static Vertex[] formVerticesList(int numberOfVertices, ArrayList<String> parsedFile) {
        Vertex[] vertexList = new Vertex[numberOfVertices];
        int switchId = -1;

        for(int i = 0; i < numberOfVertices; i++) {
            String[] individualVertex = parsedFile.get(i + 1).split(" "); //split each node into name and type

            vertexList[i] = new Vertex(individualVertex[0], individualVertex[1], -1, i, false); //creates the new vertex and puts it into the list
            nodeToID.put(vertexList[i].getName(), i); //put into hashmap

            //update switch id when type "switch" is found and update light
            Vertex temp = vertexList[i];

            if(temp.getType().equals("switch")) { //if type is switch
                switchId = Integer.parseInt(temp.getName().substring(1));
                temp.setSwitchId(switchId);
            }

            if(temp.getType().equals("light")) { //updates the light
                temp.setSwitchId(switchId);
            }
        }

        return vertexList;
    }


    //Form Adjacency List
    public static int[][] formAdjacencyMatrix(Vertex[] vertices, int numberOfEdges, ArrayList<String> parsedFile) {
        int numberOfVertices = vertices.length;

        int[][] adjacencyMatrix = new int[numberOfVertices][numberOfVertices];

        //initialize to all 0
        for(int c = 0; c < adjacencyMatrix.length; c++) {
            for(int r = 0; r < adjacencyMatrix[c].length; r++) {
                adjacencyMatrix[c][r] = 0;
            }
        }

        //fill in the matrix with weights and corresponding edges
        int edgeIndexConstant = 1 + numberOfVertices;

        for(int i = 0; i < numberOfEdges; i++) {
            String edgeDataFromFile = parsedFile.get(i + edgeIndexConstant);
            String[] parsedEdgeData = edgeDataFromFile.split(" ");

            int u = nodeToID.get(parsedEdgeData[0]);
            int v = nodeToID.get(parsedEdgeData[1]);
            int weight = Integer.parseInt(parsedEdgeData[2]);

            adjacencyMatrix[u][v] = weight;

        }

        return adjacencyMatrix;
    }


    //Prim's Algorithm


    //testing purposes
    public static void printVertices(Vertex[] vertices) {
        for(int i = 0; i < vertices.length; i++) {
            vertices[i].printVertex();
            System.out.println("");
        }

    }

    public static void printAdjacencyMatrix(int[][] adjacencyMatrix) {
        for(int c = 0; c < adjacencyMatrix.length; c++) {
            for(int r = 0; r < adjacencyMatrix[c].length; r++) {
                System.out.print(adjacencyMatrix[c][r] + "\t");
            }
            System.out.println("");
        }
    }


    public static void printNodeToID() {
        for (String node : nodeToID.keySet()) {
            String key = node;
            int id = nodeToID.get(key);
            System.out.println(key + " " + id);
        }
    }

}
