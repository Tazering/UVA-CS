import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    /**
     *  Name: Tyler Kim
     *  Computing Id: tkj9ep
     *  Filename: Main.java
     *  Programming Language: Java
     */

    public static void main(String[] args) {

        //read the file and store into array list
        final String testCase1Filepath = "C:/Users/tyler/dev/UVA-CS/UVA-CS/CS-3100_Floryan/Module 1/HW1-Tasks/src/test-cases/test-case-1.txt";

        ArrayList<String> parsedFile = new ArrayList<>();

        try {
            File file = new File(testCase1Filepath);
            Scanner scan = new Scanner(file);
            while (scan.hasNextLine()) {
                String data = scan.nextLine();
                parsedFile.add(data);
            }

        } catch (FileNotFoundException e) {
            System.out.println("File Not Found");
            e.printStackTrace();
        }

        System.out.println(parsedFile);

    }

}
