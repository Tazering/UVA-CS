import java.util.Comparator;

public class CompareRoomsByFinal implements Comparator<Room> {


    @Override
    public int compare(Room o1, Room o2) {
        if(o1.getFinalCapacity() == o2.getFinalCapacity()) {
            return 0;
        } else if(o1.getFinalCapacity() < o2.getFinalCapacity()) {
            return 1;
        }

        return -1;
    }
}
