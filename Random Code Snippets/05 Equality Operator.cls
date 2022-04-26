Account a = new Account(Name='Acc1');
Account b = new Account(Name='Acc1');
if ( a === b )
    system.debug('a === b true');
else
    system.debug('a === b false'); // Will return this

if ( a == b )
    system.debug('a == b true '); // Will return this
else 
    system.debug('a == b false');

a = b;
if ( a === b )
    system.debug('a === b true'); // Will return this
else
    system.debug('a === b false');