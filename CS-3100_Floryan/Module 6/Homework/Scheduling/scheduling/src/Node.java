public class Node {

    private int color;
    private String name;
    private int id;

    public Node(String name, int id, int color) {
        this.color = color;
        this.name = name;
        this.id = id;
    }

    public int getColor() {
        return color;
    }

    public void setColor(int color) {
        this.color = color;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void print() {
        System.out.println(this.name + " " + this.id + " " + this.color);
    }
}
