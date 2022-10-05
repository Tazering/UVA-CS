import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.Array;
import java.net.URI;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    static String test_case_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 3/Trading/test-cases/test-case-1.txt";
    String s = "";

    public static void main(String[] args) {
        ArrayList<String> fileToArray = new ArrayList<>();

        //test array
        fileToArray = formTestCaseArrayList();
        testFileToArray(fileToArray);

        //submission purposes
//        Scanner scan = new Scanner(System.in);
//        while(scan.hasNextLine()) {
//            String data = scan.nextLine();
//            arrayList.add(data);
//        }




    }

    //main algorithm

    //helper




    // testing
        // form test case Array List
    public static ArrayList<String> formTestCaseArrayList() {
        ArrayList<String> output = new ArrayList<>();

        try {

            Scanner scanner = new Scanner(new File(test_case_1));
            while(scanner.hasNextLine()) {
                String data = scanner.nextLine();
                output.add(data);

            }

        } catch(FileNotFoundException e) {
            System.out.println("File not found");
        }

        return output;
    }

        // Unit Tests
    public static void testFileToArray(ArrayList<String> arrayList) {

        for(String s : arrayList) {
            System.out.println(s);
        }

    }





}
