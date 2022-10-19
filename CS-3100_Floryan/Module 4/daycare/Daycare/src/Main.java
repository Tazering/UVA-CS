import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class Main {

    static final String TEST_CASE_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 4/daycare/test-cases/test-case-1.txt";

    public static void main(String[] args) {
        ArrayList<String> parsedFile = new ArrayList<>();

        //testing
        parsedFile = getTestCase(TEST_CASE_1);

        //submission
//        Scanner scan = new Scanner(System.in);
//        while(scan.hasNextLine()) {
//            String data = scan.nextLine();
//            parsedFile.add(data);
//        }

        //go through test cases
        while(parsedFile.size() != 0) {
            ArrayList<String> testCase = grabTestCase(parsedFile);

            //TODO actual algorithm
        }

    }
    //helper
    public static ArrayList<String> grabTestCase(ArrayList<String> parsedFile) {
        ArrayList<String> output = new ArrayList<>();
        int i = 0;

        output.add(parsedFile.get(0));
        parsedFile.remove(0);

        while(i < Integer.parseInt(output.get(0))) {
            output.add(parsedFile.get(0));
            parsedFile.remove(0);
            i++;
        }

        return output;
    }

    public static void printArrayList(ArrayList<String> arr) {
        for(String s : arr) {
            System.out.println(s);
        }
    }

    public static boolean isNumeric(String s) {
        try {
            int i = Integer.parseInt(s);
        } catch(NumberFormatException e) {
            return false;
        }

        return true;
    }

    //test files
    public static ArrayList<String> getTestCase(String path) {
        ArrayList<String> output = new ArrayList<>();

        try{

            File file = new File(path);
            Scanner scan = new Scanner(file);
            while(scan.hasNextLine()) {
                String data = scan.nextLine();
                output.add(data);
            }

        } catch(FileNotFoundException e) {
            System.out.println("File not found");
        }

        return output;

    }




}
