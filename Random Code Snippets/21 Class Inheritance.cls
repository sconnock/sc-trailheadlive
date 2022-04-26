// Taken from the Apex Developer Guide
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_interfaces.htm

// An interface is like a class in which none of the methods have been implemented—the method signatures
// are there, but the body of each method is empty. To use an interface, another class must implement
// it by providing a body for all of the methods contained in the interface.

// An interface that defines what a purchase order looks like in general
public interface PurchaseOrder {
    // All other functionality excluded
    Double discount();
}

// One implementation of the interface for customers
public class CustomerPurchaseOrder implements PurchaseOrder {
    public static Double discount() {
        return .05;  // Flat 5% discount
    }
}

// Another implementation of the interface for employees
public class EmployeePurchaseOrder implements PurchaseOrder {
      public static Double discount() {
        return .10;  // It’s worth it being an employee! 10% discount
    }
}

// Execute anonymous
Double customerDiscount = CustomerPurchaseOrder.discount();
Double employeeDiscount = EmployeePurchaseOrder.discount();
system.debug('customerDiscount ' + customerDiscount);
system.debug('employeeDiscount ' + employeeDiscount);


// Taken from Apex Developer Guide
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_extending.htm
//
// The virtual definition modifier declares that this class allows extension and overrides. You cannot
// override a method with the override keyword unless the class has been defined as virtual.
//
// A class that extends another class inherits all the methods and properties of the extended class.
// In addition, the extending class can override the existing virtual methods by using the override
// keyword in the method definition. Overriding a virtual method allows you to provide a different
// implementation for an existing method. This means that the behavior of a particular method is
// different based on the object you’re calling it on. This is referred to as polymorphism.
//
// This example shows how to extend a class. The YellowMarker class extends the Marker class.
public virtual class Marker {

    public virtual void write() {
        System.debug('Writing some text.');
    }
 
    public virtual Double discount() {
        return .05;
    }

    public string hello() {
        return 'Hello World';
    }    
}

// Extension for the Marker class
public class YellowMarker extends Marker {

    public override void write() {
        System.debug('Writing some text using the yellow marker.');
    }

    // Method only in this class
    public Double computePrice() {
        return 1.5;
    }
}

// This code segment shows polymorphism. The example declares two objects of the same type (Marker). 
// Even though both objects are markers, the second object is assigned to an instance of the 
// YellowMarker class. Hence, calling the write method on it yields a different result than calling
// this method on the first object because this method has been overridden. Note that we can call the
// discount method on the second object even though this method isn’t part of the YellowMarker class
// definition, but it is part of the extended class, and hence is available to the extending class, YellowMarker.

Marker obj1 = new Marker();
obj1.write(); // This outputs 'Writing some text.'
system.debug(obj1.hello());
 
Marker obj2 = new YellowMarker();
obj2.write(); // This outputs 'Writing some text using the yellow marker.'
system.debug(obj2.hello());

Double d = obj2.discount(); // We get the discount method for free and can call it from the YellowMarker instance.
system.debug('Discount ' + d);
