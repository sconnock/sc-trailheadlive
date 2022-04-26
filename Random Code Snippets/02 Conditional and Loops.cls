Integer x, sign;
if(x <= 0) {
  if (x == 0) {
    sign = 0;
  } else {
    sign = -1;
  }
}

String medal_color;
Integer place = 2;
if(place == 1) {
  medal_color = 'gold';
} else if (place == 2) {
  medal_color = 'silver';
} else if (place == 3) {
  medal_color = 'bronze';
} else {
  medal_color = null;
}
System.debug (medal_Color);

/*
Logical operators: x && y, x || y
Equality operators: x == y (value), x === y (reference)
*/

// Example of If-then-else: x ? y : z
System.debug(medal_Color == 'silver' ? 'Expected a silver' : 'Not expected');

// Enumerations - a set of constants
public enum Season {WINTER, SPRING, SUMMER, FALL};
Season s = Season.SUMMER;
if (s == Season.SUMMER) {
   System.debug(s); // Will write the string value SUMMER
} else {
   System.debug('Not summer.');
}

// counts to 10
Integer count = 1;
do{
  System.debug(count);
  count++;
} while(count < 11);

// counts to 10
Integer count1 = 1;
while(count1 < 11) {
  System.debug(count1);
  count1++;
}

// counts to 10
for(Integer i = 0; i < 10; i++) {
  System.debug(i+1);
}

//String[] seasons = new String[]{'Winter', 'Spring', 'Summer', 'Fall'};
List<String> seasons = new List<String>{'Winter', 'Spring', 'Summer', 'Fall'};
for(String season : seasons) {
  System.debug(season);
}

List<Contact> cons = new List<Contact>();
cons.addAll(new List<Contact>{new Contact(LastName='Connock'),
                              new Contact(LastName='Campos')});
system.debug(cons);

// New in Summer 18
String someStringVar = 'value 3';
switch on someStringVar {
    when 'value 1' {
        System.Debug('value 1');
    }  
    when 'value 2', 'value 3' {
        System.Debug('value 2 or 3');
    }
    when 'value 4' {
        System.Debug('value 4');
    }
    when else {
        System.Debug('all other values');
    }
}
