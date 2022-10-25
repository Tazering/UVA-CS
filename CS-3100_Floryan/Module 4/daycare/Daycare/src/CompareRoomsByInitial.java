import java.util.Comparator;

public class CompareRoomsByInitial implements Comparator<Room> {


    @Override
    public int compare(Room o1, Room o2) {
        if(o1.getInitialCapacity() == o2.getInitialCapacity()) {
            return 0;
        } else if(o1.getInitialCapacity() < o2.getInitialCapacity()) {
            return -1;
        }

        return 1;
    }
}
