public class Room {

    private int initialCapacity;
    private int finalCapacity;
    private int changeInCapacity;

    public Room(int initialCapacity, int finalCapacity, int changeInCapacity) {
        this.initialCapacity = initialCapacity;
        this.finalCapacity = finalCapacity;
        this.changeInCapacity = changeInCapacity;
    }

    public int getInitialCapacity() {
        return initialCapacity;
    }

    public void setInitialCapacity(int initialCapacity) {
        this.initialCapacity = initialCapacity;
    }

    public int getFinalCapacity() {
        return finalCapacity;
    }

    public void setFinalCapacity(int finalCapacity) {
        this.finalCapacity = finalCapacity;
    }

    public int getChangeInCapacity() {
        return changeInCapacity;
    }

    public void setChangeInCapacity(int changeInCapacity) {
        this.changeInCapacity = changeInCapacity;
    }

    public void printRoom() {
        System.out.println("Room:");
        System.out.println("Initial Size: " + this.initialCapacity);
        System.out.println("Final Size: " + this.finalCapacity);
        System.out.println("Change: " + this.changeInCapacity);
    }
}
