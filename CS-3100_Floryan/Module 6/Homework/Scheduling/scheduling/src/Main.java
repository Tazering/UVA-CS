import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class Main {

    static final String TEST_CASE_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 6/Homework/Scheduling/test-cases/test-case-1.txt";
    static Map<String, Integer> objectToNumber = new HashMap<>();
    static Map<Integer, String> numberToObject = new HashMap<>();
    static ArrayList<Node> nodes = new ArrayList<>();
    static int studentCount = 0;
    static ArrayList<String> path = new ArrayList<>();
    static boolean reachesSuperSink = true;

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
            String[] meta = parsedString.get(0).split(" "); // grab the first line
            ArrayList<String> testCase = grabTestCase(parsedString); // grab the test case


            // grab the meta data
            int r = Integer.parseInt(meta[0]);
            int c = Integer.parseInt(meta[1]);
            int n = Integer.parseInt(meta[2]);

            if(r <= 0) {
                break;
            }

            //System.out.println(objectToNumber);
            studentCount = 0;

            //algorithm
            ArrayList<String> temp = new ArrayList<>();
            for(int s = 1; s < r + 1; s++) {
                String[] data = testCase.get(s).split(" ");
                if(!temp.contains(data[0])) {
                    studentCount++;
                    temp.add(data[0]);
                }
            }

            int[][] graph = createAdjacencyMatrix(testCase, r, c, n);

                //run Ford-Fulkerson
            fordFulkerson(graph, studentCount * n);
        }

    }

    //algorithm
        //ford-fulkerson
    public static void fordFulkerson(int[][] graph, int goal) {
        int maxflow = calculateMaxFlow(graph);

        if(maxflow >= goal) {
            System.out.println("Yes");
        } else {
            System.out.println("No");

        }
    }

    //temporary
    public static int calculateMaxFlow(int[][] graph) {

        while(true) {
            path = new ArrayList<>();
            reachesSuperSink = true;
            DFS_PathSearch("Supersource", graph);

            if(!reachesSuperSink) {
                break;
            }
            saturateGraph(graph);
        }

        return 0;
    }

    public static void saturateGraph(int[][] residualGraph) {
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


    public static void DFS_PathSearch(String start, int[][] graph) {

        //base case
        if(start.equals("Supersink")) {
            path.add(start);

        } else if(!canTraverseAnywhere(graph, start)) {
            reachesSuperSink = false;

        } else { //recursive case
            path.add(start);

            for(int i = 0; i < graph.length; i++) {
                if(canTraverse(graph, start, i)) {

                    DFS_PathSearch(numberToObject.get(i), graph);
                    break;
                }
            }

        }

    }

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

    public static boolean canTraverse(int[][] graph, String node, int end) {
        int start = objectToNumber.get(node);

        return graph[start][end] != 0;
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
        nodes.add(new Node("Supersource", 0, -1));

        int count = 1;

        for(int i = 0; i < total + 1; i++) {
            String line = parsedString.get(0);
            testCase.add(line);
            parsedString.remove(0);

            String[] data = line.split(" ");

            if(!objectToNumber.containsKey(data[0]) && i > 0) {
                objectToNumber.put(data[0], count);
                numberToObject.put(count, data[0]);
                nodes.add(new Node(data[0], count, -1));
                count++;
            }

        }

        objectToNumber.put("Supersink", count);
        numberToObject.put(count, "Supersink");
        nodes.add(new Node("Supersink", count, -1));
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

}
