
String CURRENT_LETTER = "";
ArrayList<Letter> rightDictionary;

Letter A = new Letter("A", 69.51921, 44.777283, 46.077297, 43.881107, 38.800507);
Letter B = new Letter("B", 50.027805, 98.189445, 105.116325, 97.472435, 81.95997);
Letter C = new Letter("C", 71.21127, 79.79342, 81.6763, 75.067894, 61.232384);
Letter D = new Letter("D", 64.76191, 97.84882, 68.02343, 61.301888, 52.127308);
Letter E = new Letter("E", 54.17099, 63.985104, 62.6702, 55.521904, 55.954796);
Letter F = new Letter("F", 65.35656, 62.598972, 99.349335, 95.93016, 89.06092);
Letter G = new Letter("G", 68.929535, 77.88947, 43.559692, 37.220657, 37.682026);
Letter H = new Letter("H", 59.721462, 88.84897, 92.410095, 52.48596, 45.761395);
Letter I = new Letter("I", 58.660732, 57.267033, 59.419037, 55.228428, 86.245735);
Letter L = new Letter("L", 90.56681, 102.17722, 69.62716, 62.43469, 53.74383);
Letter O = new Letter("O", 62.463245, 71.610916, 75.705414, 61.603535, 56.195118);

void setupIdentifier(){
  rightDictionary = new ArrayList<Letter>();

    rightDictionary.add(A);
    rightDictionary.add(B);
    rightDictionary.add(C);
    rightDictionary.add(D);
    rightDictionary.add(E);
    rightDictionary.add(F);
    rightDictionary.add(G);
    rightDictionary.add(H);
    rightDictionary.add(I);
    rightDictionary.add(L);
    rightDictionary.add(O);

}

void getHandInfo(Frame frame) {
    double max = Double.MAX_VALUE;
    String letter = " ";

    for (Hand leapHand : frame.hands())
    {
        Vector handXBasis =  leapHand.palmNormal().cross(leapHand.direction()).normalized();
        Vector handYBasis = leapHand.palmNormal().opposite();
        Vector handZBasis = leapHand.direction().opposite();
        Vector handOrigin =  leapHand.palmPosition();
        Matrix handTransform = new Matrix(handXBasis, handYBasis, handZBasis, handOrigin);
        handTransform = handTransform.rigidInverse();

        //Find closest letter
        for (int i = 0; i < rightDictionary.size(); i++) {
            double currentMagnitude = isLetter(leapHand, rightDictionary.get(i));
            //    println(rightDictionary.get(i).getName() + "-" + currentMagnitude);
            if (currentMagnitude < max) {
                max = currentMagnitude;
                letter = rightDictionary.get(i).getName();
            }
        }
    }
    updateCurrentLetter(letter, max);
}
char detectedLetter; 
void updateCurrentLetter(String newLetter, double magnitude) {
    if (newLetter.equals(CURRENT_LETTER)) {
        FREQ++;
    } else {
        FREQ = 0;
        CURRENT_LETTER = newLetter;
    }

    if (FREQ > FREQ_MAX) {
        detectedLetter = CURRENT_LETTER.charAt(0);
        println(detectedLetter);

        FREQ = FREQ_MAX + 1;
    } else {
        detectedLetter = ' ';
    }

    float strength = magnitude == Double.MAX_VALUE ? 220 : map((float)magnitude, 0, 220, 0, 50);
    //updateStrength(strength);
}
/**
 * Checks if the given hand shape is close to the given letter
 * @param leapHand The hand shape to compare to
 * @param toCompare The letter shape to look up against
 */
double isLetter(Hand leapHand, Letter toCompare) {

    float mag = 0;
    float handX = leapHand.palmPosition().getX();
    float handY = leapHand.palmPosition().getY();
    float handZ = leapHand.palmPosition().getZ();

    for ( int f = 0; f < leapHand.fingers().count(); f++ )
    {
        Finger leapFinger = leapHand.fingers().get(f);

        float x = leapFinger.tipPosition().getX();
        float y = leapFinger.tipPosition().getY();
        float z = leapFinger.tipPosition().getZ();

        float dist = dist(handX, handY, handZ, x, y, z);
        float ref = 0;

        for (Bone.Type boneType : Bone.Type.values()) {

            Bone bone = leapFinger.bone(boneType);        
            Vector boneEnd = bone.nextJoint();
            float xEnd = boneEnd.getX();
            float yEnd = boneEnd.getY();
            float zEnd = boneEnd.getZ();

            xEnd = map(xEnd, -250, 300, 0, xGrid * 8);
            yEnd = map(yEnd, 0, 500, 30, 10);
            zEnd = map(zEnd, -150, 150, 0, height);
        }

        switch(leapFinger.type()) {
        case TYPE_THUMB:
            ref = toCompare.thumb();
            break;
        case TYPE_INDEX:
            ref = toCompare.index();
            break;
        case TYPE_MIDDLE:
            ref = toCompare.middle();          
            break;
        case TYPE_RING:
            ref = toCompare.ring();
            break;
        default:
            ref = toCompare.pinky();
            break;
        }       
        float diff = Math.abs(ref - dist);
        mag += diff;
    }
    return mag;
}