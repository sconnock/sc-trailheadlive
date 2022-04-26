List<List<sObject>> acmes = [ Find 'Acme' RETURNING Account(Name), Opportunity(Name) ]; 

// The first outer element is the List of Accounts
List<Account> acmeAccounts = acmes[0];
for (Account acmeAccount : acmeAccounts) {
    System.debug('Account: ' + acmeAccount.Name);
}

// The second outer element is the List of Opportunities
List<Opportunity> acmeOpportunities = acmes[1];
for (Opportunity acmeOpportunity : acmeOpportunities) {
    System.debug('Opportunity: ' + acmeOpportunity.Name);
}

// Debug Log
//15:00:47:089 USER_DEBUG [6]|DEBUG|Account: Acme Inc (London)
//15:00:47:089 USER_DEBUG [6]|DEBUG|Account: Acme Inc
//15:00:47:089 USER_DEBUG [6]|DEBUG|Account: Acme
//15:00:47:089 USER_DEBUG [12]|DEBUG|Opportunity: Acme Inc - 6 Desktops
//15:00:47:089 USER_DEBUG [12]|DEBUG|Opportunity: Acme Inc - 20 Desktops
//15:00:47:089 USER_DEBUG [12]|DEBUG|Opportunity: Acme Inc - 600 Desktops
//15:00:47:090 USER_DEBUG [12]|DEBUG|Opportunity: Acme Inc - 700 Desktops