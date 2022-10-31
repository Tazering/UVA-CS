import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Main {
    
    static String testCase1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 5/Drainage/test-cases/test-case-1.txt";

    public static void main(String[] args) {
        ArrayList<String> parsedString = new ArrayList<>();
        parsedString = getTestCase(testCase1);

        //submission purposes
//        Scanner input = new Scanner(System.in);
//        while(input.hasNextLine()) {
//            String data = input.nextLine();
//            parsedString.add(data);
//        }

        int size = Integer.parseInt(parsedString.get(0));
        parsedString.remove(0);

        for(int i = 0; i < size; i++) {
            ArrayList<String> testCase = grabTestCase(parsedString);
            String[] metaData = testCase.get(0).split(" ");
            String location = metaData[0];
            int r = Integer.parseInt(metaData[1]);
            int c = Integer.parseInt(metaData[2]);

            Map<Integer, Integer> map = new HashMap<>();
            int[][] graph = makeGraph(r, c, testCase);
            int longestDistance = DFS_Sweep(graph, map);

            System.out.println(location + ": " + longestDistance);
        }

    }

    //algorithm
    public static int DFS_Sweep(int[][] graph, Map<Integer, Integer> map) {
        int longestPath = 1;

        for(int r = 0; r < graph.length; r++) {
            for(int c = 0; c < graph[r].length; c++) {
                if(!map.containsKey(graph[r][c])) {
                    int temp = DFS(r, c, graph, map);

                    if(temp > longestPath) {
                        longestPath = temp;
                    }
                }
            }
        }

        return longestPath;
    }

    public static int DFS(int startR, int startC, int[][] graph, Map<Integer, Integer> map) {

        return 0;
    }

    //helper
    public static ArrayList<String> grabTestCase(ArrayList<String> parsedString) {
        ArrayList<String> arr = new ArrayList<>();
        String[] data = parsedString.get(0).split(" ");
        int n = Integer.parseInt(data[1]);

        for(int i = 0; i <= n; i++) {
            arr.add(parsedString.get(0));
            parsedString.remove(0);
        }

        return arr;
    }

    public static int[][] makeGraph(int r, int c, ArrayList<String> values) {
        int[][] output = new int[r][c];

        for(int i = 0; i < r; i++) {
            String[] row = values.get(i + 1).split(" ");

            for(int j = 0; j < c; j++) {
                output[i][j] = Integer.parseInt(row[j]);
            }
        }
        return output;
    }

    //testing
    public static ArrayList<String> getTestCase(String filepath) {
        File file = new File(filepath);
        ArrayList<String> arr = new ArrayList<>();
        try {
            Scanner input = new Scanner(file);
            while(input.hasNextLine()) {
                String data = input.nextLine();
                arr.add(data);
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        return arr;
    }

    public static void printArrayList(ArrayList<String> arr){

        for(String s: arr) {
            System.out.println(s);
        }

        System.out.println();

    }

    public static void print2DArray(int[][] arr) {
        for(int r = 0; r < arr.length; r++) {
            for(int c = 0; c < arr[r].length; c++) {
                System.out.print(arr[r][c] + "\t");
            }
            System.out.println();
        }
        System.out.println();
    }



}
