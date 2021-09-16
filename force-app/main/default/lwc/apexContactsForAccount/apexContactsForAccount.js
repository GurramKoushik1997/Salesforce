import { LightningElement,api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LAST_FIELD from '@salesforce/schema/Contact.LastName';

/**
 * Creates Contact records.
 */
export default class AccountCreator extends LightningElement {

    @api recordId;
    object = CONTACT_OBJECT;
    myFields = [LAST_FIELD];

    handleAccountCreated(event) {
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        console.log('=====Contact is Created=====');
        console.log('recordId=='+this.recordId);
        console.log('success====');

    }
}