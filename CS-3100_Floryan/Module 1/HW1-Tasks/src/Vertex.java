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

    private String taskName;
    private int inDegrees;
    private boolean isChecked;

    //constructor
    public Vertex() {
        this.taskName = null;
        this.inDegrees = 0;
        this.isChecked = false;
    }

    public Vertex(String taskName, int inDegrees, boolean isChecked) {
        this.taskName = taskName;
        this.inDegrees = inDegrees;
        this.isChecked = isChecked;
    }

    // getters and setters
    public String getTaskName() {
        return this.taskName;
    }

    public int getInDegrees() {
        return this.inDegrees;
    }

    public boolean isChecked() {
        return this.isChecked;
    }

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
        String s = "Vertex: " + this.taskName + "\n\tin-degrees: " + this.inDegrees + "\n\tisChecked: " + this.isChecked;

        return s;
    }


}
