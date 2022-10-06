import java.io.File;
import java.io.FileNotFoundException;
import java.lang.reflect.Array;
import java.net.URI;
import java.util.*;

public class Main {

    static String test_case_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 3/Trading/test-cases/test-case-1.txt";
    String s = "";

    public static void main(String[] args) {
        List<String> fileToArray = new ArrayList<>();

        //test array
        fileToArray = formTestCaseArrayList();

        //submission purposes
//        Scanner scan = new Scanner(System.in);
//        while(scan.hasNextLine()) {
//            String data = scan.nextLine();
//            arrayList.add(data);
//        }

        //run algorithm
        while(!fileToArray.isEmpty()) {

            //get cases
            double[][] coordinates = getCase(fileToArray);
            fileToArray = fileToArray.subList(coordinates.length + 1, fileToArray.size());

            //get Star list
            Star[] stars = getStarArray(coordinates);

            //main algorithm
                //initialization
            Arrays.sort(stars, new CompareStars()); //sort stars by x coordinates


        }

//        Star[] test = {new Star(-6.47, 2.24), new Star(8.9, 6.53), new Star(-1.45, 5.05)};
//        testMinThree(test);


    }

    //main algorithm
    public static double findClosestPairOfPoints(Star[] stars) {
        double delta = 0;
        int n = stars.length;

        // divide and conquer
        if(stars.length == 2) { //base case
            return calculateDistance(stars[0], stars[1]);

        } else if(stars.length == 3) { //base case
            return minThreeStars(stars[0], stars[1], stars[2]);

        } else { // recursive case
            int mid = n/2;
            double dl = findClosestPairOfPoints(Arrays.copyOfRange(stars, 0, mid));
            double dr = findClosestPairOfPoints(Arrays.copyOfRange(stars, mid + 1, n));
            delta = min(dl, dr);

            Star[] y_sorted = merge(Arrays.copyOfRange(stars, 0, mid), Arrays.copyOfRange(stars, mid + 1, n));
            Star[] strip = createStrip(delta, stars, mid);

            return delta;
        }





    }

    //algorithm helpers
    public static double calculateDistance(Star s1, Star s2) { // calculate Euclidean distance
        double deltaX = Math.abs(s1.getX() - s2.getX());
        double deltaY = Math.abs(s1.getY() - s2.getY());

        return Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));
    }

    public static double minThreeStars(Star s1, Star s2, Star s3) { //minimum distance of 3 stars
        double s1_to_s2 = calculateDistance(s1, s2);
        double s2_to_s3 = calculateDistance(s2, s3);
        double s1_to_s3 = calculateDistance(s1, s3);

        if((s1_to_s2 < s2_to_s3) && (s1_to_s2 < s1_to_s3)) {
            return s1_to_s2;

        } else if((s2_to_s3 < s1_to_s2) && (s2_to_s3 < s1_to_s3)) {
            return s2_to_s3;

        } else {
            return s1_to_s3;
        }
    }

    public static double min(double x, double y) { //min of two numbers
        if(x < y) {
            return x;
        }

        return y;
    }

    public static Star[] merge(Star[] l, Star[] r) {
        int lSize = l.length;
        int rSize = r.length;

        Star[] output = new Star[lSize + rSize];

        int index = 0, lPtr = 0, rPtr = 0;

        while((rPtr < rSize) && (lPtr < lSize)) {
            if(l[lPtr].getY() < r[rPtr].getY()) {
                output[index] = l[lPtr];
                lPtr++;
            } else {
                output[index] = r[rPtr];
                rPtr++;
            }

            index++;
        }

        while(lPtr < lSize) {
            output[index] = l[lPtr];
            lPtr++;
            index++;
        }

        while(rPtr < rSize) {
            output[index] = r[rPtr];
            rPtr++;
            index++;
        }

        return output;
    }

    public static Star[] createStrip(double delta, Star[] stars, double mid) {
        ArrayList<Star> output = new ArrayList<>();

        for(Star s : stars) {
            if(isXInDelta(s.getX(), mid, delta)) {
                output.add(s);
            }
        }

        Star[] finalOutput = new Star[output.size()];

        for(int i = 0; i < output.size(); i++) {
            finalOutput[i] = output.get(i);
        }

        return finalOutput;
    }

    //helper
    public static double[][] getCase(List<String> fileToArray) {
        int size = Integer.parseInt(fileToArray.get(0));
        double[][] output = new double[size][2];

        if(size == 0) { //if zero is the size
            return output;
        }

        //make array
        for(int i = 0; i < fileToArray.size(); i++) {
            String s = fileToArray.get(i + 1);

            if(isInteger(s)) { //indicate that another test case was found
                return output;
            }

            String[] str = s.split(" ");
            double[] coordinates = new double[2];

            coordinates[0] = Double.parseDouble(str[0]); // store x coordinates
            coordinates[1] = Double.parseDouble(str[1]);

            output[i] = coordinates;
        }

        return output;
    }

    //check if string can be a number
    public static boolean isInteger(String s) {
        try {
            int x = Integer.parseInt(s);
            return true;
        } catch(NumberFormatException e) {
            return false;
        }
    }

    //make star array
    public static Star[] getStarArray(double[][] coordinates) {
        Star[] stars = new Star[coordinates.length];
        for(int i = 0; i < coordinates.length; i++) {
            Star s = new Star(coordinates[i][0], coordinates[i][1]);
            stars[i] = s;
        }

        return stars;

    }

    public static boolean isXInDelta(double x1, double x2, double delta) {
        return delta <= Math.abs(x1 - x2);
    }



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

    public static void testArray(double[][] arr) {
        for(int i = 0; i < arr.length; i++) {
            System.out.println("x: " + arr[i][0] + "\t y: " + arr[i][1]);
        }
    }

    public static void testStarArray(Star[] arr) {
        for(Star s : arr) {
            System.out.println(s.toString());
        }

        System.out.println("------------------------------------");
    }

    public static void testMinThree(Star[] stars) {
        System.out.println(minThreeStars(stars[0], stars[1], stars[2]));
    }






}
