public class Vertex {

    //private member variables
    String name, type;
    int switchId, numID;
    boolean isChecked;

    //constructors
    public Vertex() {
        this.name = "";
        this.type = "";
        this.switchId = -1;
        this.numID = -1;
        this.isChecked = false;

    }

    public Vertex(String name, String type, int switchId, int numID, boolean isChecked) {
        this.name = name;
        this.type = type;
        this.switchId = switchId;
        this.numID = numID;
        this.isChecked = isChecked;

    }

    //getters
    public String getName() {
        return this.name;
    }

    public String getType() {
        return this.type;
    }

    public int getSwitchId() {
        return this.switchId;
    }

    public int getNumID() {
        return this.numID;
    }

    public boolean isChecked() {
        return this.isChecked;
    }



    //setters
    public void setName(String name) {
        this.name = name;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setSwitchId(int switchId) {
        this.switchId = switchId;
    }

    public void setNumID(int numID) {
        this.numID = numID;
    }

    public void setChecked(boolean isChecked) {
        this.isChecked = isChecked;
    }


    //helper
    public void printVertex() {
        System.out.println("Vertex name: " + this.name);
        System.out.println("\ttype: " + this.type);
        System.out.println("\tswitchID: " + this.switchId);
        System.out.println("\tnumID: " + this.numID);
        System.out.println("\tisChecked: " + this.isChecked);
    }
}
