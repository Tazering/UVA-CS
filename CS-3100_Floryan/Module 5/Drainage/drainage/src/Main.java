import java.io.File;
import java.io.FileNotFoundException;
import java.net.Inet4Address;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Main {
    
    static String testCase1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 5/Drainage/test-cases/test-case-1.txt";

    public static void main(String[] args) {
        ArrayList<String> parsedString = new ArrayList<>();
//        parsedString = getTestCase(testCase1);

        //submission purposes
        Scanner input = new Scanner(System.in);
        while(input.hasNextLine()) {
            String data = input.nextLine();
            parsedString.add(data);
        }

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

            for(int row = 0; row < graph.length; row++) {
                for(int column = 0; column < graph[row].length; column++) {
                    map.put(graph[row][column], -1);
                }
            }

            int longestDistance = DFS_Sweep(graph, map);

            System.out.println(location + ": " + longestDistance);
        }

    }

    //algorithm
    public static int DFS_Sweep(int[][] graph, Map<Integer, Integer> map) {
        int longestPath = 1;

        for(int r = 0; r < graph.length; r++) {
            for(int c = 0; c < graph[r].length; c++) {
                if(map.get(graph[r][c]) == -1) {
                    int temp = DFS(r, c, graph, map);

                    if(temp > longestPath) {
                        longestPath = temp;
                    }
                }
            }

        }

        return longestPath;
    }



    public static int DFS(int r, int c, int[][] graph, Map<Integer, Integer> map) {
        int maxL = 1;
        int maxR = 1;
        int maxD = 1;
        int maxU = 1;

        //base case
        if(noWhereToGo(r, c, graph)) {
            return 1;
        } else if(map.get(graph[r][c]) != -1) {
            return map.get(graph[r][c]);
        } else {
            //left
            if(canTraverse(r, c, r, c-1, graph)) {
                maxL = DFS(r, c-1, graph, map) + 1;
            }

            //right
            if(canTraverse(r, c, r, c+1, graph)) {
                maxR = DFS(r, c+1, graph, map) + 1;
            }

            //up
            if(canTraverse(r, c, r-1, c, graph)) {
                maxU = DFS(r-1, c, graph, map) + 1;
            }

            //down
            if(canTraverse(r, c, r+1, c, graph)) {
                maxD = DFS(r+1, c, graph, map) + 1;
            }

            ArrayList<Integer> arr = new ArrayList<>();
            arr.add(maxL);
            arr.add(maxR);
            arr.add(maxU);
            arr.add(maxD);

            return maxOfArray(arr);

        }
    }

    public static int maxOfArray(ArrayList<Integer> arr) {
        int output = 0;

        for(int i : arr) {
            if(i > output) {
                output = i;
            }
        }

        return output;
    }

    public static boolean canTraverse(int r0, int c0, int r1, int c1, int[][] graph) {
        int x = graph[r0][c0];

        //out of bounds
        if(r1 < 0 || c1 < 0 || r1 >= graph.length || c1 >= graph[r0].length) {
            return false;
        } else if(x <= graph[r1][c1]) {
            return false;
        }

        return true;
    }

   public static boolean noWhereToGo(int r, int c, int[][] graph) {
        int x = graph[r][c];
        int nextR = r;
        int nextC;

        //left
       nextC = c - 1;
       if(nextC >= 0 && x > graph[nextR][nextC]) {
           return false;
       }

       //right
       nextC = c + 1;
       if(nextC < graph[r].length && x > graph[nextR][nextC]) {
           return false;
       }

       //up
       nextC = c;
       nextR = r - 1;
       if(nextR >= 0 && x > graph[nextR][nextC]) {
           return false;
       }

       //down
       nextR = r + 1;
       if(nextR < graph.length && x > graph[nextR][nextC] ) {
           return false;
       }

       return true;
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
