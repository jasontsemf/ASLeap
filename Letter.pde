class Letter{
    
  String name = "";
  float thumb = 0;
  float index = 0;
  float middle = 0;
  float ring = 0;
  float pinky = 0;
    
    
    Letter(String name, float th, float in, float mi, float ri, float pi){
       this.name = name;
       this.thumb = th;
       this.index = in;
       this.middle = mi;
       this.ring = ri;
       this.pinky = pi;
    }
    
    String getName(){
       return this.name; 
    }
    
    float thumb(){
       return thumb; 
    }
    
    float index(){
       return index; 
    }
    
    float middle(){
       return middle; 
    }
    
    float ring(){
       return ring; 
    }
    
    float pinky(){
       return pinky; 
    }
  
  
}