import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Main {

    public static ArrayList<Integer> output = new ArrayList<>();

    public static void main(String[] args) {

        final String testCase1Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-1.txt";
        final String testCase2Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-2.txt";
        ArrayList<String> arrayList = new ArrayList<>();


        //read the file and store into array list
        try {
            File file = new File(testCase1Filepath);
            Scanner scan = new Scanner(file);
            while (scan.hasNextLine()) {
                String data = scan.nextLine();
                arrayList.add(data);
            }

        } catch (FileNotFoundException e) {
            System.out.println("File Not Found");
            e.printStackTrace();
        }

        //System.out.println(arrayList);

        int[][] adjacencyMatrix = formAdjacencyMatrix(arrayList);
        ArrayList<int[]> vertices = formListOfVertices(arrayList);
        //printAdjacencyMatrix(adjacencyMatrix);
        //printListOfVertices(vertices);
        DFS(adjacencyMatrix, vertices, 0, Integer.parseInt(arrayList.get(0)) - 1);
        //System.out.println(output);
        // System.out.println("Size of matrix is: " + adjacencyMatrix.length + " x " + adjacencyMatrix[0].length);

        //finalize


        finalizeOutput(output, Integer.parseInt(arrayList.get(0)) - 1);

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

        // bad vertices
        for(int i = 0; i < Integer.parseInt(arr.get(nRoads + 2)); i++) {
            //System.out.println("i: " + i);
            listOfVertices.get(Integer.parseInt(arr.get(i + (nRoads+3))))[3] = 1;
            listOfVertices.get(Integer.parseInt(arr.get(i + (nRoads+3))))[1] = 2;
        }

        return listOfVertices;
    }

    //run modified DFS algorithm


    public static void DFS(int[][] adjacencyMatrix, ArrayList<int[]> verticesList, int vertexNumber, int targetNumber) {

        ArrayList<Integer> adjacencyVertexList = new ArrayList<>();

        // make a list of connecting vertices
        for(int c = 0; c < adjacencyMatrix[0].length; c++) {
            if(adjacencyMatrix[vertexNumber][c] == 1) {
                adjacencyVertexList.add(c);
            }
        }

        Collections.reverse(adjacencyVertexList);


        int[] u = verticesList.get(vertexNumber);
        int[] targetV = verticesList.get(targetNumber);
        u[1] = 1; //set V0 to GRAY


        if(u[0] != targetNumber) { // check if current vertex is the target vertex
            for(int i = 0; i < adjacencyVertexList.size(); i++) {
                if(verticesList.get(adjacencyVertexList.get(i))[1] == 0) {
                    verticesList.get(adjacencyVertexList.get(i))[2] = vertexNumber;
                    DFS(adjacencyMatrix, verticesList, verticesList.get(adjacencyVertexList.get(i))[0], targetNumber);
                }
            }

        }
        u[1] = 2; //u.color = BLACK
        targetV[1] = 0;

        output.add(vertexNumber);
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
