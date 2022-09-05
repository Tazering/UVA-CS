import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class Main {


    public static void main(String[] args) {

        final String testCase1Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-1.txt";
        final String testCase2Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW2/test-case/test-case-2.txt";


        try {
            File file = new File(testCase2Filepath);
            Scanner scan = new Scanner(file);
            while (scan.hasNextLine()){
                String data = scan.nextLine();
                System.out.println(data);
            }

        } catch(FileNotFoundException e) {
            System.out.println("File Not Found");
            e.printStackTrace();
        }

    }

}
