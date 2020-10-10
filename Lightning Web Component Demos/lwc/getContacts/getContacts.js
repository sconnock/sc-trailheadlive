import { LightningElement, api, wire } from 'lwc';
import getContactsForAccount from '@salesforce/apex/ContactController.getContactsForAccount';

export default class GetContacts extends LightningElement {
    @api accountName;

    @wire(getContactsForAccount, { accountName: '$accountName' })
    contacts;    
        
    handleChange(event) {
        this.accountName = event.target.value;
    }
}