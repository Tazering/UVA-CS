import java.io.File;
import java.io.FileNotFoundException;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class Main {

    static final String TEST_CASE_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 6/Homework/Scheduling/test-cases/test-case-1.txt";
    static Map<String, Integer> objectToNumber = new HashMap<>();
    static Map<Integer, String> numberToObject = new HashMap<>();
    static ArrayList<Node> nodes = new ArrayList<>();
    static ArrayList<ArrayList<String>> paths = new ArrayList<>();
    static int maxflow;

    public static void main(String[] args) {
        ArrayList<String> parsedString = new ArrayList<>();

        parsedString = parseString(TEST_CASE_1);

        //Submission Purposes
//        Scanner input = new Scanner(System.in);
//        while(input.hasNextLine()) {
//            String data = input.nextLine();
//            parsedString.add(data);
//        }


        while(parsedString.size() != 0) {
            //grab the meta data
            String[] meta = parsedString.get(0).split(" "); // grab the first line
            int r = Integer.parseInt(meta[0]);
            int c = Integer.parseInt(meta[1]);
            int n = Integer.parseInt(meta[2]);

            if(r == 0 && c == 0 && n == 0) {
                break;
            }

            ArrayList<String> testCase = grabTestCase(parsedString); // grab the test case

            //System.out.println(objectToNumber);
            int studentCount = 0;

            //algorithm
            //initialization
            ArrayList<String> temp = new ArrayList<>();
            for(int s = 1; s < r + 1; s++) {
                String[] data = testCase.get(s).split(" ");
                if(!temp.contains(data[0])) {
                    studentCount++;
                    temp.add(data[0]);
                }
            }


//            make adjacency matrix and residual graph
            int[][] graph = createAdjacencyMatrix(testCase, r, c, n);
            int[][] residualGraph = makeResidualGraph(graph);

            printPaths();


            //printAdjacencyMatrix(graph);
            //printNodesList();
//            run DFS


//            run Ford-Fulkerson
            fordFulkerson(graph, residualGraph, studentCount * n);
            parsedString.remove(0);
        }

    }

    //algorithm
    //ford-fulkerson
    public static void fordFulkerson(int[][] graph, int[][] residualGraph, int goal) {
        maxflow = 0;
        ArrayList<String> currentPath = new ArrayList<>();
        currentPath.add("Supersource");
        DFS("Supersource", graph, residualGraph, "Supersink", currentPath);


        if(maxflow >= goal) {
            System.out.println("Yes");
        } else {
            System.out.println("No");

        }
    }


    public static void saturateGraph(int[][] residualGraph, ArrayList<String> path) {
        for(int i = 0; i < path.size() - 1; i++) {
            int input = objectToNumber.get(path.get(i));
            int output = objectToNumber.get(path.get(i + 1));

            residualGraph[input][output] -= 1;
            residualGraph[output][input] += 1;
        }
    }

    public static int[][] makeResidualGraph(int[][] graph) {
        int[][] residualGraph = new int[graph.length][graph[0].length];

        for(int i = 0; i < graph.length; i++) {
            for(int j = 0; j < graph[i].length; j++) {
                residualGraph[i][j] = graph[i][j];
            }
        }

        return residualGraph;
    }



    public static void DFS(String start, int[][] adjacencyMatrix, int[][] residualGraph, String end, ArrayList<String> currentPath) {
        //base case
        if(start.equals(end)) {
            maxflow++;
            paths.add(new ArrayList<>(currentPath));
            saturateGraph(residualGraph, new ArrayList<>(currentPath));
            return;
        }
        nodes.get(objectToNumber.get(start)).setVisited(false);
        //visit all the neighbors
        for(int i = 0; i < adjacencyMatrix.length; i++) { //recursive case
            if(canTraverse(residualGraph, start, numberToObject.get(i))) {
                currentPath.add(numberToObject.get(i));
                DFS(numberToObject.get(i), adjacencyMatrix, residualGraph, end, currentPath);
                currentPath.remove(numberToObject.get(i));
            }
        }
        nodes.get(objectToNumber.get(start)).setVisited(false);


    }



//    public static void DFS(String start, int[][] graph) {
//
//        //base case
//        if(start.equals("Supersink")) {
//            path.add(start);
//
//        } else if(!canTraverseAnywhere(graph, start)) {
//            reachesSuperSink = false;
//
//        } else { //recursive case
//            path.add(start);
//
//            for(int i = 0; i < graph.length; i++) {
//                if(canTraverse(graph, start, i)) {
//
//                    DFS_PathSearch(numberToObject.get(i), graph);
//                    break;
//                }
//            }
//
//        }
//
//    }

    public static boolean canTraverseAnywhere(int[][] graph, String node) {
        int i = objectToNumber.get(node);
        int size = graph[i].length;

        for(int c = 0; c <= size; c++) {
            if(graph[i][c] != 0) {
                return true;
            }
        }

        return false;
    }

    public static boolean canTraverse(int[][] graph, String node, String end) {
        int start = objectToNumber.get(node);

        if(graph[start][objectToNumber.get(end)] != 0 && !nodes.get(objectToNumber.get(node)).getVisited() && !end.equals("Supersource")) {
            return true;
        }

        return false;
    }




    public static int[][] createAdjacencyMatrix(ArrayList<String> testCase, int r, int c, int n) {
        int size = objectToNumber.size();
        int[][] adjacencyMatrix = new int[size][size];

        for(int i = 0; i < adjacencyMatrix.length; i++) {
            for(int j = 0; j < adjacencyMatrix[i].length; j++) {
                adjacencyMatrix[i][j] = 0;
            }
        }

        //superstart
        for(int i = 1; i < size - c - 1; i++){
            adjacencyMatrix[0][i] = n;
        }


        //student to class
        for(int i = 1; i < r + 1; i++) {
            String[] data = testCase.get(i).split(" ");
            adjacencyMatrix[objectToNumber.get(data[0])][objectToNumber.get(data[1])] = 1;
        }

        //supersink
        for(int i = r + 1; i < (r + 1) + c; i++) {
            String[] data = testCase.get(i).split(" ");
            adjacencyMatrix[objectToNumber.get(data[0])][objectToNumber.get("Supersink")] = Integer.parseInt(data[1]);
        }


        return adjacencyMatrix;
    }


    //supplementary
    public static ArrayList<String> grabTestCase(ArrayList<String> parsedString) {
        String[] meta = parsedString.get(0).split(" ");
        int total = Integer.parseInt(meta[0]) + Integer.parseInt(meta[1]);
        ArrayList<String> testCase = new ArrayList<>();

        objectToNumber.put("Supersource", 0);
        numberToObject.put(0, "Supersource");
        nodes.add(new Node("Supersource", 0));

        int count = 1;

        for(int i = 0; i < total + 1; i++) {
            String line = parsedString.get(0);
            testCase.add(line);
            parsedString.remove(0);

            String[] data = line.split(" ");

            if(!objectToNumber.containsKey(data[0]) && i > 0) {
                objectToNumber.put(data[0], count);
                numberToObject.put(count, data[0]);
                nodes.add(new Node(data[0], count));
                count++;
            }

        }

        objectToNumber.put("Supersink", count);
        numberToObject.put(count, "Supersink");
        nodes.add(new Node("Supersink", count));
        return testCase;
    }






    //testing
    public static ArrayList<String> parseString(String filepath) {
        ArrayList<String> arrayList = new ArrayList<>();

        try {
            File file = new File(filepath);
            Scanner input = new Scanner(file);

            while(input.hasNextLine()) {
                String data = input.nextLine();
                arrayList.add(data);
            }
        } catch(FileNotFoundException e) {
            System.out.println("File not Found");
        }

        return arrayList;
    }

    public static void printArrayList(ArrayList<String> arrayList) {
        System.out.print("{ ");
        for(String s: arrayList) {
            System.out.print(s + ", ");
        }

        System.out.print("}");
        System.out.println(" ");
    }

    public static void printAdjacencyMatrix(int[][] residualGraph) {
        for(int i = 0; i < residualGraph.length; i++) {
            for(int j = 0; j < residualGraph[i].length; j++) {
                System.out.print(residualGraph[i][j] + "\t");
            }
            System.out.println();
        }
    }

    public static void printNodesList() {
        for(Node n : nodes) {
            n.print();
            System.out.println(" ");
        }
    }

    public static void printPaths() {
        for(int i = 0; i < paths.size(); i++) {
            printArrayList(paths.get(i));
        }
    }


}