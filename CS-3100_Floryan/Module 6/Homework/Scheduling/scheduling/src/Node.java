public class Node {

    private boolean visited;
    private String name;
    private int id;


    public Node(String name, int id) {
        this.visited = false;
        this.name = name;
        this.id = id;
    }

    public boolean getVisited() {
        return visited;
    }

    public void setVisited(boolean visited) {
        this.visited = visited;
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
        System.out.println(this.name + " " + this.id + " " + this.visited);
    }


}
