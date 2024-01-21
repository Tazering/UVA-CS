import java.util.*;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // stores the data
        ArrayList<Double> data = new ArrayList<>();

        while(true) {
            System.out.println("0: create new dataset\t 1: sort dataset -1: exit");

            int input = scanner.nextInt();

            //exits
            if(input == -1) {
                break;
            }

            //possible cases
            switch(input) {
                case 0:
                    break;

                case 1:
                    printData(data.sort());
            }
        }

        System.out.println("Program Finished");

    }

    public static void printData(ArrayList<Double> data) {

        for(double x : data) {
            System.out.println("");
            System.out.println(x);

        }
    }


}
