import { LightningElement,api,wire,track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';

const FIELDS = [NAME_FIELD];

export default class CallingAura extends LightningElement {
    @api recordId;
    
    @track details;
    @track currenRecordId;

    connectedCallback() {
        this.currenRecordId = this.recordId;
    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    getdetails({data}){
        this.details = data;
        console.log("data===="+data);
    }

    @api
    handleRecord(){
        console.log("===handleRecord=====");
        console.log("details====="+JSON.stringify(this.details.fields.Name.value));
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: 'Hii '+this.details.fields.Name.value,
            variant: 'success',
        }),
        );
    }
}