import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Main {

    static final String TEST_CASE_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 4/movingBoxes/testcases/test-case-1.txt";
    static final String TEST_CASE_2 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 4/movingBoxes/testcases/test-case-2.txt";


    public static void main(String[] args) {
        ArrayList<String> parsedFile = new ArrayList<>();
        //parsedFile = grabParsedFileForTesting(TEST_CASE_1);

        //submission
        Scanner scan = new Scanner(System.in);
        while(scan.hasNextLine()) {
            String data = scan.nextLine();
            parsedFile.add(data);
        }

        //grab num of test cases
        int n = Integer.parseInt(parsedFile.get(0));
        parsedFile.remove(0);

        //run algorithm
        for(int i = 1; i <= n; i++) {
            System.out.println("Case " + i);
            ArrayList<MovingCompany> output = new ArrayList<>();

            //setup
            ArrayList<String> testCase = grabTestCase(parsedFile);
            String[] meta = testCase.get(0).split(" ");
            int b = Integer.parseInt(meta[0]);
            int m = Integer.parseInt(meta[1]);
            testCase.remove(0);

            //greedy algorithm
            for(String s: testCase) {
                int total = b;
                int cost = 0;
                String[] movingCompanyCost = s.split(" ");
                String name = movingCompanyCost[0];
                int x = Integer.parseInt(movingCompanyCost[1]);
                int y = Integer.parseInt(movingCompanyCost[2]);

                //do half until limit is reached
                while((total - (int) Math.ceil((double) total/2)) > m) {
                    total -=  (int) Math.ceil((double) total/2);
                    cost += y;
                }

                total -= m;

                //rest is single
                cost += total * x;

                output.add(new MovingCompany(name, cost));
            }

            Collections.sort(output);
            printOutput(output);

        }


    }

    //helper
    public static ArrayList<String> grabTestCase(ArrayList<String> parsedFile) {
        ArrayList<String> testCase = new ArrayList<>();

        //grab three numbers
        testCase.add(parsedFile.get(0));
        String[] temp = parsedFile.get(0).split(" ");
        int numCompanies = Integer.parseInt(temp[2]);
        parsedFile.remove(0);

        for(int i = 0; i < numCompanies; i++) {
            testCase.add(parsedFile.get(0));
            parsedFile.remove(0);
        }

        return testCase;
    }

    public static void printOutput(ArrayList<MovingCompany> list) {
        for(MovingCompany mv : list) {
            System.out.println(mv.printMovingCompany());
        }
    }



    //testing
    public static ArrayList<String> grabParsedFileForTesting(String testCase) {
        ArrayList<String> output = new ArrayList<>();
        try {
            File file = new File(testCase);
            Scanner reader = new Scanner(file);
            while(reader.hasNextLine()) {
                String data = reader.nextLine();
                output.add(data);
            }
        } catch(FileNotFoundException e) {
            System.out.println("File not found");
        }

        return output;

    }

    public static void printArrayList(ArrayList<String> parsedFile) {
        for(String s : parsedFile) {
            System.out.println(s);
        }
    }

}

 class MovingCompany implements Comparable<MovingCompany> {

    private String name;
    private int cost;

    public MovingCompany(String name, int cost) {
        this.name = name;
        this.cost = cost;
    }


    @Override
    public int compareTo(MovingCompany o) {

        if(this.cost == o.cost) {
            return this.name.compareTo(o.name);
        }

        return Integer.compare(this.cost, o.cost);
    }

    public String printMovingCompany() {
        return name + " " + cost;
    }

}

