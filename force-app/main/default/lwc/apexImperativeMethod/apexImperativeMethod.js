import { LightningElement,api,wire } from 'lwc';
import {refreshApex} from '@salesforce/apex';
import getContactList from '@salesforce/apex/ContactController.getContacts';
import getContacts from '@salesforce/apex/ContactController.getContactslist';

export default class apexImperativeMethod extends LightningElement {
    @api recordId;

    //calling apex
    @wire(getContactList, {accId:'$recordId' })
    totalContacts;
    
    //calling apex 2nd time
    @wire(getContacts, {accId:'$recordId' })
      contacts;

}