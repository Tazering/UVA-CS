import java.util.Comparator;

public class CompareStarsX implements Comparator<Star> {

    @Override
    public int compare(Star o1, Star o2) {
        if(o1.getX() > o2.getX()) {
            return 1;
        } else if(o1.getX() < o2.getX()) {
            return -1;
        }

        return 0;
    }
}
