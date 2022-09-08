public class Vertex {

    /**
     * Vertex class that represents the node
     *
     * States:
     * taskName of type String
     *      - name of the particular task
     * in-degrees of type int
     *      - number of edges that point into the particular vertex
     * isChecked of type boolean
     *      - sees if the vertex is checked or not
     */

    private int numId;
    private String taskName;
    private int inDegrees;
    private boolean isChecked;

    //constructor
    public Vertex() {
        numId = -1;
        this.taskName = null;
        this.inDegrees = 0;
        this.isChecked = false;
    }

    public Vertex(int numId, String taskName, int inDegrees, boolean isChecked) {
        this.numId = numId;
        this.taskName = taskName;
        this.inDegrees = inDegrees;
        this.isChecked = isChecked;
    }

    // getters and setters
    public int getNumId() {return this.numId;}

    public String getTaskName() {
        return this.taskName;
    }

    public int getInDegrees() {
        return this.inDegrees;
    }

    public boolean isChecked() {
        return this.isChecked;
    }

    public void setNumId(int numId) {this.numId = numId;}

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public void setInDegrees(int inDegrees) {
        this.inDegrees = inDegrees;
    }

    public void setChecked(boolean isChecked) {
        this.isChecked = isChecked;
    }

    public String printVertex() {
        String s = "Vertex: " + this.taskName + "\n\tNumber Id: " + this.numId + "\n\tin-degrees: " + this.inDegrees + "\n\tisChecked: " + this.isChecked;

        return s;
    }


}
