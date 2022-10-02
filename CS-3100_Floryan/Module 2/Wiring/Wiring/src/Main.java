/*
    Name: Tyler Kim
    Computing Id: tkj9ep
    Homework: Wiring
 */

import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.PriorityQueue;
import java.util.Scanner;

public class Main {

    static int cost = 0;
    static int numPreSwitchNodes = 0;

    static HashMap<String, Integer> nodeToID = new HashMap<>(); //for the adjacency matrix

    static String testCase1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-1.txt"; // 7
    static String testCase2 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-2.txt"; // 240
    static String testCase3 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-3.txt"; // 82
    static String testCase4 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-4.txt"; // 27
    static String testCase5 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-5.txt"; // 11
    static String testCase6 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-6.txt"; // 27
    static String testCase7 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-7.txt"; // 14
    static String testCase8 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-8.txt"; // 7
    static String testCase9 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-9.txt"; // 7
    static String testCase10 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-10.txt"; // 11
    static String testCase11 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-11.txt"; // 11
    static String testCase12 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 2/Wiring/test-cases/test-case-12.txt"; // 7

    public static void main(String[] args) {

        ArrayList<String> parsedFile = new ArrayList<>();

        //read in the data

        //testing purposes
//        try{
//            File file = new File(testCase2);
//            Scanner scan = new Scanner(file);
//            while(scan.hasNextLine()) {
//                String data = scan.nextLine();
//                parsedFile.add(data);
//            }
//
//        } catch(FileNotFoundException e) {
//            System.out.println("Could not find file.");
//        }


        //submission purposes
        Scanner scan = new Scanner(System.in);
        while(scan.hasNextLine()) {
            String data = scan.nextLine();
            parsedFile.add(data);
        }


        String[] metaData = parsedFile.get(0).split(" ");


        int numberOfVertices = Integer.parseInt(metaData[0]);
        int numberOfEdges = Integer.parseInt(metaData[1]);

        //System.out.println(parsedFile);

        //get vertices and edges
        Vertex[] vertices = formVerticesList(numberOfVertices, parsedFile);
        int[][] adjacencyMatrix = formAdjacencyMatrix(vertices, numberOfEdges, parsedFile);

        //run Prim's Algorithm
        prim(vertices, adjacencyMatrix);

        //testSwitchComponents(vertices);
        //printAdjacencyMatrix(adjacencyMatrix);
        //printVertices(vertices);
        //printNodeToID();
    }
    //Form Vertices List
    public static Vertex[] formVerticesList(int numberOfVertices, ArrayList<String> parsedFile) {
        Vertex[] vertexList = new Vertex[numberOfVertices];
        int switchId = -1;

        for(int i = 0; i < numberOfVertices; i++) {
            String individualVertexFromFile = parsedFile.get(i + 1);

            String[] individualVertex = individualVertexFromFile.split(" "); //split each node into name and type

            vertexList[i] = new Vertex(individualVertex[0], individualVertex[1], -1, i, Integer.MAX_VALUE, false); //creates the new vertex and puts it into the list
            nodeToID.put(vertexList[i].getName(), i); //put into hashmap

            //update switch id when type "switch" is found and update light
            Vertex temp = vertexList[i];

            if(isPreswitch(temp)) {
                numPreSwitchNodes++;
            }

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
            adjacencyMatrix[v][u] = weight;

        }

        return adjacencyMatrix;
    }


    //Prim's Algorithm
    public static void prim(Vertex[] vertices, int[][] adjacencyMatrix) {
        int numOfVertices = vertices.length;

        //start at breaker
        vertices[0].setKey(0); //set breaker key to 0

        //set up priority queue
        PriorityQueue<Vertex> Q = new PriorityQueue<>();

        for(Vertex v: vertices) {
            Q.add(v);
        }
        //testPriorityQueue(Q);

        //actual algorithm
        while(!Q.isEmpty()) {

            Vertex u = Q.remove();
            u.setChecked(true);

            cost += u.getKey();
            int uID = nodeToID.get(u.getName());

            // look for adjacent vertices
            for(int i = 0; i < numOfVertices; i++) {
                int weight = adjacencyMatrix[uID][i]; //grab the weight

                if(weight != 0) {
                    Vertex v = vertices[i];

                    if(Q.contains(v) && weight < v.getKey() && isConnectable(u, v)) {
                        v.setKey(weight);
                        Q.remove(v);
                        Q.add(v);
                    }

                }
            }

        }

        System.out.println(cost);
    }

    //Prim's Algorithm
//    public static void prim(Vertex[] vertices, int[][] adjacencyMatrix) {
//        int numOfVertices = vertices.length;
//
//        //start at breaker
//        vertices[0].setKey(0); //set breaker key to 0
//
//        //set up priority queue
//        PriorityQueue<Vertex> Q = new PriorityQueue<>();
//
//        for(Vertex v: vertices) {
//            Q.add(v);
//        }
//        //testPriorityQueue(Q);
//
//        //actual algorithm
//        while(!Q.isEmpty()) {
//
//            Vertex u = Q.remove();
//            u.setChecked(true);
//
//            cost += u.getKey();
//            int uID = nodeToID.get(u.getName());
//
//            // look for adjacent vertices
//            for(int i = 0; i < numOfVertices; i++) {
//                int weight = adjacencyMatrix[uID][i]; //grab the weight
//
//                if(weight != 0) {
//                    Vertex v = vertices[i];
//
//                    if(Q.contains(v) && weight < v.getKey() && !v.isChecked()) {
//
//                        if(((isPreswitch(u) && isPreswitch(v)) || (isPreswitch(u) && isSwitch(v))) && !v.isChecked()) {
//
//                        }
//
//                    }
//
//                }
//            }
//
//        }
//
//        System.out.println(cost);
//    }


    //helper functions
    public static boolean isConnectable(Vertex u, Vertex v) {

        // conditionals

        //both are pre-switches
        if(isPreswitch(u) && isPreswitch(v) ) {
            return true;
        }

        //u is preswitch and v is post-switch
        if(isPreswitch(u) && isSwitch(v) ) {

            return true;
        }

        //if u and v are lights
        if(isPostSwitch(u) && isPostSwitch(v)) {
            if(u.getSwitchId() == v.getSwitchId()) {
                return true;
            }
        }

        //if u is a switch and v is post-switch
        if(isSwitch(u) && isPostSwitch(v) && !v.isChecked()) {
            if(u.getSwitchId() == v.getSwitchId()) {
                return true;
            }
        }

        return false;
    }


        //types of components
    public static boolean isPreswitch(Vertex u) {
        return u.getType().equals("breaker") || u.getType().equals("outlet") || u.getType().equals("box");
    }

    public static boolean isSwitch(Vertex u) {
        return u.getType().equals("switch");
    }

    public static boolean isPostSwitch(Vertex u) {
        return u.getType().equals("light");
    }

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

    public static void testSwitchComponents(Vertex[] vertices) {
        for(int i = 0; i < vertices.length; i++) {
            Vertex u = vertices[i];
            String name = u.getName();
            if(isPreswitch(u)) {
                System.out.println(name + " is a Preswitch");
            } else if(isSwitch(u)) {
                System.out.println(name + " is a Switch");
            } else if(isPostSwitch(u)) {
                System.out.println(name + " is a Postswitch");
            }
        }
    }

    public static void testPriorityQueue(PriorityQueue<Vertex> Q) {
        int size = Q.size();
        for(int i = 0; i < size; i++) {
            System.out.println("Index " + i);
            Vertex v = Q.remove();
            v.printVertex();
        }
    }

    public static void testCost() {
        System.out.println(cost);
    }

    public static void testArray(String[] arr) {
        for(String s: arr) {
            System.out.println(s);
        }
    }

    public static void testMetaData(int numberOfEdges, int numberOfVertices) {
        System.out.println("number of edges: " + numberOfEdges);
        System.out.println("number of vertices: " + numberOfVertices);
    }

    public static void testNumOfPreswitch() {
        System.out.println(numPreSwitchNodes);
    }

}
