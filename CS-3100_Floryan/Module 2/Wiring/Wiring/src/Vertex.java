public class Vertex implements Comparable<Vertex>{

    //private member variables
    private String name, type, switchName;
    private int numID, key;
    private boolean isChecked;

    public Vertex(String name, String type, String switchName, int numID, int key, boolean isChecked) {
        this.name = name;
        this.type = type;
        this.switchName = switchName;
        this.numID = numID;
        this.isChecked = isChecked;
        this.key = key;

    }

    //getters
    public String getName() {
        return this.name;
    }

    public String getType() {
        return this.type;
    }

    public String getSwitchName() {
        return this.switchName;
    }

    public int getNumID() {
        return this.numID;
    }

    public boolean isChecked() {
        return this.isChecked;
    }

    public int getKey() {
        return this.key;
    }

    //setters
    public void setName(String name) {
        this.name = name;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setSwitchName(String switchName) {
        this.switchName = switchName;
    }

    public void setNumID(int numID) {
        this.numID = numID;
    }

    public void setChecked(boolean isChecked) {
        this.isChecked = isChecked;
    }

    public void setKey(int key) {
        this.key = key;
    }

    //helper
    public void printVertex() {
        System.out.println("Vertex name: " + this.name);
        System.out.println("\ttype: " + this.type);
        System.out.println("\tswitchName: " + this.switchName);
        System.out.println("\tnumID: " + this.numID);
        System.out.println("\tkey: " + this.key);
        System.out.println("\tisChecked: " + this.isChecked);
    }

    public boolean equals(Vertex other) {
        return this.getKey() == other.getKey();
    }

    @Override
    public int compareTo(Vertex o) {

        //check if its between breaker and switch
        if(isPreswitch(this) && isSwitch(o)) {
            return -1;
        } else if(isSwitch(this) && isPreswitch(o)) {
            return 1;
        }

        if(this.equals(o)) {
            return 0;

        } else if(this.getKey() > o.getKey()) {
            return 1;

        } else {
            return -1;
        }



    }

    //types of components
    public static boolean isPreswitch(Vertex u) {
        return u.getType().equals("breaker") || u.getType().equals("outlet") || u.getType().equals("box");
    }

    public static boolean isSwitch(Vertex u) {
        return u.getType().equals("switch");
    }


}
