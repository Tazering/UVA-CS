import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
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

            
        }

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

}
