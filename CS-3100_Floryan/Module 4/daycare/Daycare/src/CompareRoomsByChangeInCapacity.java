import java.util.Comparator;

public class CompareRoomsByChangeInCapacity implements Comparator<Room> {


    @Override
    public int compare(Room o1, Room o2) {
        if(o1.getChangeInCapacity() == o2.getChangeInCapacity()) {
            return 0;
        } else if(o1.getChangeInCapacity() < o2.getChangeInCapacity()) {
            return -1;
        }

        return 1;
    }
}
