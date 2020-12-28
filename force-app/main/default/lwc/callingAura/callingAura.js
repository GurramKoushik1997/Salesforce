import { LightningElement,api,wire,track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';

const FIELDS = [NAME_FIELD];

export default class CallingAura extends LightningElement {
    @api recordId;
    
    @track details;
    @track aName;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    getdetails;

    getRecord(){
        this.details = this.getdetails;
        console.log('-----'+JSON.stringify(this.details.data.fields.Name.value));
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: 'Hii '+this.details.data.fields.Name.value,
            variant: 'success',
        }),
        );
    }
}