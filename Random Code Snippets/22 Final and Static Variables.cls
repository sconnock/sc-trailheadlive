public class MyClass {
    // A final class variable can be assigned only at declaration or in a constructor
    public final Integer FINAL_VAR1;
    public final Integer FINAL_VAR2 = 2;

    // A static final variable can be assigned at declaration or in a static initialization
    public final static Integer STATIC_FINAL_VAR3;
    public final static Integer STATIC_FINAL_VAR4 = 4;

    // Static initialization
    // The instance initialization code in a class is executed each time an object 
    // is instantiated from that class. These code blocks run before the constructor.
    //
    // If you don’t want to write your own constructor for a class, you can use an 
    // instance initialization code block to initialize instance variables. In simple
    // situations, use an ordinary initializer. Reserve initialization code for 
    // complex situations, such as initializing a static map. 
    //
    // A static initialization block runs only once, regardless of how many times
    // you access the class that contains it.
    //
    // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_static.htm
    Static {
        STATIC_FINAL_VAR3 = 3;
    }

    // Constructor
    Public MyClass() {
        FINAL_VAR1 = 1;
    }
}



public class HelloWorld {
    
    public String memberVariable;
    public final String finalVariable;
    public static String staticVariable;
	
    // Constructor (no args)
    public HelloWorld() {
        memberVariable = 'Default';
        finalVariable = 'Constant1';
    }
    
    // Constructor (single string arg)
    public HelloWorld(String value) {
        memberVariable = value;
        finalVariable = 'Constant2';
    }
    
	public void printMemberVariable() {
		System.debug('Hello ' + memberVariable);
        System.debug('Hello ' + finalVariable);
	}
    
	public static void printStaticVariable() {
		System.debug('Hello ' + staticVariable);
	}
}

// From Anonymous block
// Instantiate and set memberVariable
HelloWorld hw1 = new HelloWorld();
hw1.memberVariable = 'Simon';
hw1.printMemberVariable(); // Output is Hello Simon and Hello Constant1

// Instantiate and set memberVariable using constructor
HelloWorld hw2 = new HelloWorld('World');
hw2.printMemberVariable(); // Output is Hello World and Hello Constant2

// Static variable and method so don't have to create an instance of the class
HelloWorld.staticVariable = 'Bert';
HelloWorld.printStaticVariable(); // Output is Hello Bert

// Try to set the final variable - won't end well!
//hw1.finalVariable = 'Problem';
