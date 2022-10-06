import java.util.Comparator;

public class CompareStarsY implements Comparator<Star> {

    @Override
    public int compare(Star o1, Star o2) {
        if(o1.getY() > o2.getY()) {
            return 1;
        } else if(o1.getY() < o2.getY()) {
            return -1;
        }

        return 0;
    }
}
