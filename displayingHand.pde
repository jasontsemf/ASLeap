import java.util.Collections;
import java.util.Comparator;

/* CONSTANTS */
int FREQ = 0;
int FREQ_MAX = 20;
int JOINT_SIZE = 20;

int xGrid = width;
int yGrid = height;

void drawHand(Hand hand) {
    
    stroke(153,50);
    fill(51, 50);
    ArrayList<Vector> allJoints = new ArrayList<Vector>();


    //Get the wrist position
    Vector wrist = hand.wristPosition();
    float wristX = wrist.getX();
    float wristY = wrist.getY();
    float wristZ = wrist.getZ();
    wristX = map(wristX, -250, 300, 0, xGrid * 8);
    wristY = map(wristY, 0, 500, 30, 10);
    wristZ = map(wristZ, -150, 150, 0, height);
    
    
    ArrayList<Vector> joints = new ArrayList<Vector>();
    
    for (int i = 0; i < hand.fingers().count(); i++)
    {
        joints.add(new Vector(wristX, wristY, wristZ));
        Finger finger = hand.fingers().get(i);
        
        for (Bone.Type boneType : Bone.Type.values()) {
            Bone bone = finger.bone(boneType);        
            Vector boneEnd = bone.nextJoint();

            float xEnd = boneEnd.getX();
            float yEnd = boneEnd.getY();
            float zEnd = boneEnd.getZ();

            xEnd = map(xEnd, -250, 300, 0, xGrid * 8);
            yEnd = map(yEnd, 0, 500, 30, 10);
            zEnd = map(zEnd, -150, 150, 0, height);

            allJoints.add(new Vector(xEnd, yEnd, zEnd));
            joints.add(new Vector(xEnd, yEnd, zEnd));
        }

        for (int j = joints.size() - 1; j > 0; j--)
        {
            Vector first = joints.get(j);
            Vector second = joints.get(j - 1);
            line(first.getX(), first.getZ(), second.getX(), second.getZ());
        }        
        joints.clear();
    }
    
    strokeWeight(1);
    Collections.sort(allJoints, new DepthComparator());
    for (int j = allJoints.size() - 1; j >= 0; j--) {
        Vector current = (Vector) allJoints.get(j);
        ellipse(current.getX(), current.getZ(), JOINT_SIZE, JOINT_SIZE);
    }
}
class DepthComparator implements Comparator<Object> {
    public int compare(Object one, Object two) {
        Vector first = (Vector) one;
        Vector second = (Vector) two;
        return (int)(first.getY() - second.getY());
    }
}