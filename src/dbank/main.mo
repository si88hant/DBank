import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank{
  stable var currentValue: Float = 300;  //orthgonally persisted variable (aka stable variable)
  currentValue := 300;

  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  let id = 9971727178;
  
//  Debug.print(debug_show(id));

   public func topUp(amount: Float){
    currentValue += amount;
    Debug.print(debug_show(currentValue));
    
  };

  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount;
    if(tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    }
    else{
      Debug.print("Amount too large, currentValue less than zero");
    }
  };


  public query func checkBalance(): async  Float{
    return currentValue; //this is a read only operation. no update. it is very fast
  };

 // topUp();

 public func compound(){
   let currentTime = Time.now();
   let timeElapsed_ns = currentTime - startTime;   //in nano seconds
   let timeElapsed_s = timeElapsed_ns/1000000000;  //in seconds

  currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsed_s)); //formula of compound interest (with 1% interest)

  startTime := currentTime; //every time that we compound, we're going to reset the startTime so that the next time we compound it's calculated since the previous time that we've added the money.
 };

}