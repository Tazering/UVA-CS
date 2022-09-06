public class Vertex {

    /**
     * Class Vertex
     */

    private int number;
    private int color;
    private int pi;
    private boolean isDangerousVertex;

    //constructors
    public Vertex() {
        this.number = 0;
        this.color = 0;
        this.pi = -1;
        this.isDangerousVertex = false;
    }

    public Vertex(int number, int color, int pi, boolean isDangerousVertex) {
        this.number = number;
        this.color = color;
        this.pi = pi;
        this.isDangerousVertex = isDangerousVertex;
    }

    //getters and setters
    public int getNumber() {
        return this.number;
    }

    public int getColor() {
        return this.color;
    }

    public int getPi() {
        return this.pi;
    }

    public boolean isDangerousVertex() {
        return this.isDangerousVertex;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public void setColor(int color) {
        this.color = color;
    }

    public void setPi(int pi) {
        this.pi = pi;
    }

    public void setDangerousVertex(boolean isDangerousVertex) {
        this.isDangerousVertex = isDangerousVertex;
    }

    //print
    public void printVertex() {
        System.out.println("Vertex: " + this.number);
        System.out.println("    Color: " + this.color);
        System.out.println("    Pi: " + this.pi);
    }

}
