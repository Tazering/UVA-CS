import java.io.File;
import java.io.FileNotFoundException;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.*;
import java.util.stream.DoubleStream;

public class Main {

    static String test_case_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 3/Trading/test-cases/test-case-1.txt";

    public static void main(String[] args) {
        List<String> fileToArray = new ArrayList<>();

        //test array
        //fileToArray = formTestCaseArrayList();

        //submission purposes
        Scanner scan = new Scanner(System.in);
        while(scan.hasNextLine()) {
            String data = scan.nextLine();
            fileToArray.add(data);
        }

        //run algorithm
        while(!fileToArray.isEmpty()) {

            //get cases
            double[][] coordinates = getCase(fileToArray);

            if(coordinates.length == 0) {
                fileToArray = fileToArray.subList(coordinates.length + 1, fileToArray.size());
                continue;
            }

            fileToArray = fileToArray.subList(coordinates.length + 1, fileToArray.size());

            //get Star list
            ArrayList<Star> starsX = getStarArray(coordinates);
            ArrayList<Star> starsY = getStarArray(coordinates);

            //main algorithm
            //initialization
            Collections.sort(starsX, new CompareStarsX()); //sort stars by x coordinates
            Collections.sort(starsY, new CompareStarsY());

            double d = findClosestPairOfPoints(starsX, starsY);

            if(d < 10000) {
                System.out.println(String.format("%.4f", d));

            } else {
                System.out.println("infinity");
            }

        }
    }

    //main algorithm
    public static double findClosestPairOfPoints(List<Star> starsX, List<Star> starsY) {
        double delta;
        int n = starsX.size();

        // divide and conquer
        if(n <= 3) { //base case
            return bruteForce(starsX, n);

        } else { // recursive case

            int mid = n/2;

            List<Star> leftSideX = starsX.subList(0, mid + 1);
            List<Star> rightSideX = starsX.subList(mid + 1, n);

            List<Star> leftSideY = starsY.subList(0, mid+1);
            List<Star> rightSideY = starsY.subList(mid+1, n);

            double dl = findClosestPairOfPoints(leftSideX, leftSideY);
            double dr = findClosestPairOfPoints(rightSideX, rightSideY);
            delta = min(dl, dr);

            //combine
            ArrayList<Star> strip = createStrip(delta, starsY, mid);

            return min(delta, stripClosest(strip));
        }

    }

    //algorithm helpers
    public static double calculateDistance(Star s1, Star s2) { // calculate Euclidean distance
        double deltaX = Math.abs(s1.getX() - s2.getX());
        double deltaY = Math.abs(s1.getY() - s2.getY());

        return Math.sqrt(Math.pow(deltaX, 2) + Math.pow(deltaY, 2));
    }

    public static double bruteForce(List<Star> stars, int n) { //minimum distance of 3 stars
        double min = Double.MAX_VALUE;

        for(int i = 0; i < stars.size(); i++) {
            for(int j = i + 1; j < n; j++) {
                if(calculateDistance(stars.get(i), stars.get(j)) < min) {
                    min = calculateDistance(stars.get(i), stars.get(j));
                }
            }
        }

        return min;

    }

    public static double min(double x, double y) { //min of two numbers
        if(x < y) {
            return x;
        }
        return y;
    }

    public static double stripClosest(ArrayList<Star> strip) {
        double delta = Double.MAX_VALUE;

        for(int i = 0; i < strip.size(); i++) {
            //int j = i + 1;

//            while(j < strip.size() && j < 7) {
//                if(calculateDistance(strip.get(i), strip.get(j)) < delta) {
//                    delta = calculateDistance(strip.get(i), strip.get(j));
//                }
//
//                j++;
//            }

            for(int j = i + 1; j < strip.size(); j++) {
                if(calculateDistance(strip.get(i), strip.get(j)) < delta) {
                    delta = calculateDistance(strip.get(i), strip.get(j));
                }
            }
        }

        return delta;

    }

    public static ArrayList<Star> createStrip(double delta, List<Star> stars, double mid) {
        ArrayList<Star> output = new ArrayList<>();

        for(Star s : stars) {
            if(isXInDelta(s.getX(), mid, delta)) {
                output.add(s);
            }
        }

        return output;
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
    public static ArrayList<Star> getStarArray(double[][] coordinates) {
        ArrayList<Star> stars = new ArrayList<>();

        for(int i = 0; i < coordinates.length; i++) {
            Star s = new Star(coordinates[i][0], coordinates[i][1]);
            stars.add(s);
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







}