import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    static final String TEST_CASE_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 6/Homework/Scheduling/test-cases/test-case-1.txt";

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
            ArrayList<String> testCase = grabTestCase(parsedString); // grab the test case
            String[] meta = parsedString.get(0).split(" "); // grab the first line
            parsedString.remove(0);

            // grab the meta data
            int r = Integer.parseInt(meta[0]);
            int c = Integer.parseInt(meta[1]);
            int n = Integer.parseInt(meta[2]);

            //algorithm
                //initialize

                //residual graph
                //update and saturation
        }

    }

    //supplementary
    public static ArrayList<String> grabTestCase(ArrayList<String> parsedString) {
        String[] meta = parsedString.get(0).split(" ");
        int total = Integer.parseInt(meta[0]) + Integer.parseInt(meta[1]);
        ArrayList<String> testCase = new ArrayList<>();

        for(int i = 0; i < total + 1; i++) {
            testCase.add(parsedString.get(0));
            parsedString.remove(0);
        }

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
        for(String s: arrayList) {
            System.out.println(s);
        }

        System.out.println(" ");
    }

}
