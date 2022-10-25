import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Main {

    static final String TEST_CASE_1 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 4/daycare/test-cases/test-case-1.txt";
    static final String TEST_CASE_2 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 4/daycare/test-cases/test-case-2.txt";
    static final String TEST_CASE_3 = "C:/Users/tyler/dev/UVA-CS/CS-3100_Floryan/Module 4/daycare/test-cases/test-case-3.txt";



    public static void main(String[] args) {
        ArrayList<String> parsedFile = new ArrayList<>();

        //testing
        //parsedFile = getTestCase(TEST_CASE_1);

        //submission
        Scanner scan = new Scanner(System.in);
        while(scan.hasNextLine()) {
            String data = scan.nextLine();
            parsedFile.add(data);
        }

        //go through test cases
        while(parsedFile.size() != 0) {
            ArrayList<String> testCase = grabTestCase(parsedFile);
            ArrayList<Room> rooms = getRooms(testCase);
            ArrayList<ArrayList<Room>> sorted = sortedRooms(rooms);
            int available = 0;
            int openSpaceFromOtherRooms = 0;
            int transferred = 0;
            int trailersize = 0;
            ArrayList<Room> ascending = sorted.get(0);
            ArrayList<Room> neutral = sorted.get(1);
            ArrayList<Room> descending = sorted.get(2);

            //algorithm
                // increasing capacity

                if(ascending.size() != 0) {
                    Collections.sort(ascending, new CompareRoomsByInitial());
                }

                for(int i = 0; i < ascending.size(); i++) {
                    transferred += ascending.get(i).getInitialCapacity();

                    available = updateAvailability(transferred, trailersize, openSpaceFromOtherRooms);

                    if(available < 0) {
                        trailersize += Math.abs(available);
                    }

                    openSpaceFromOtherRooms += ascending.get(i).getFinalCapacity();

                }


                // no change in capacity
            for(int i = 0; i < neutral.size(); i++) {
                transferred += neutral.get(i).getInitialCapacity();

                available = updateAvailability(transferred, trailersize, openSpaceFromOtherRooms);

                if(available < 0) {
                    trailersize += Math.abs(available);
                }

                openSpaceFromOtherRooms += neutral.get(i).getFinalCapacity();

            }


                // decreasing capacity
                if(descending.size() != 0) {
                    Collections.sort(descending, new CompareRoomsByFinal());
                }

            for(int i = 0; i < descending.size(); i++) {
                transferred += descending.get(i).getInitialCapacity();

                available = updateAvailability(transferred, trailersize, openSpaceFromOtherRooms);

                if(available < 0) {
                    trailersize += Math.abs(available);
                }

                openSpaceFromOtherRooms += descending.get(i).getFinalCapacity();

            }

            System.out.println(trailersize);
        }



    }

    //algorithm
    public static ArrayList<Room> getRooms(ArrayList<String> testCase) {
        int n = Integer.parseInt(testCase.get(0));
        ArrayList<Room> rooms = new ArrayList<>();
        testCase.remove(0);

        for(int i = 0; i < n; i++) {
            String[] str = testCase.get(i).split(" ");
            int c0 = Integer.parseInt(str[0]);
            int cf = Integer.parseInt(str[1]);
            rooms.add(new Room(c0, cf, cf - c0));

        }

        return rooms;
    }

    public static ArrayList<ArrayList<Room>> sortedRooms(ArrayList<Room> rooms) {
        ArrayList<ArrayList<Room>> output = new ArrayList<>();
        Collections.sort(rooms, new CompareRoomsByChangeInCapacity());

        ArrayList<Room> ascending = new ArrayList<>();
        ArrayList<Room> neutral = new ArrayList<>();
        ArrayList<Room> descending = new ArrayList<>();

        for(Room r : rooms) {
            if(r.getChangeInCapacity() > 0) {
                ascending.add(r);
            } else if(r.getChangeInCapacity() == 0) {
                neutral.add(r);
            } else {
                descending.add(r);
            }
        }
        output.add(ascending);
        output.add(neutral);
        output.add(descending);

        return output;
    }

    public static int updateAvailability(int transferred, int trailerSize, int changeInCapacity) {
        return trailerSize + changeInCapacity - transferred;
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

    public static void printRooms(ArrayList<Room> rooms) {
        for(Room r : rooms) {
            r.printRoom();
            System.out.println("");
        }
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
