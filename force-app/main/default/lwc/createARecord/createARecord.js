import { LightningElement,track,wire,api} from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import getContacts from '@salesforce/apex/ContactController.getContactsForTable';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';

const actions = [
    { label: 'Record Details', name: 'record_details'}, 
    { label: 'Edit', name: 'edit'}, 
    { label: 'Delete', name: 'delete'}
];

const columns = [
    { label: 'FirstName', fieldName: 'FirstName',sortable: true,editable: true }, 
    { label: 'LastName', fieldName: 'LastName',sortable: true,editable: true},
    { label: 'Phone', fieldName: 'Phone', type: 'phone',sortable: true,editable: true}, 
    { label: 'Email', fieldName: 'Email', type: 'email',sortable: true,editable: true }, 
    {
        type: 'action',
        typeAttributes: {
            rowActions: actions,
            menuAlignment: 'right'
        }
    }
];

export default class CreateARecord extends LightningElement {

    @track data;
    @track columns = columns;
    @track record = [];
    @track aShowModal = false;
    @track bShowModal = false;
    @track ShowModalNew = false;
    @track currentRecordId;
    @track isEditForm = false;
    @track showLoadingSpinner = false;
    @track isNew = false;
    @track createModal = false;
    @track sortDirection='dsc';
    @track sortBy;

    @api recordId;

    @wire(getContacts, { accId: '$recordId' })
    contacts(result) {
        this.refreshTable = result;
            this.data = result.data;
    }

    handleRowActions(event) {
        let actionName = event.detail.action.name;
        console.log('actionName ====> ' + actionName);
        let row = event.detail.row;
        console.log('row ====> ' + row);
        switch (actionName) {
            case 'record_details':
                this.viewCurrentRecord(row);
                break;
            case 'edit':
                this.editCurrentRecord(row);
                break;
            case 'delete':
                this.deleteCons(row);
                break;
        }
    }

    handleSortdata(event) {
        console.log("-----handleSortdata-------");
        this.sortBy = event.detail.fieldName;
        console.log("sortBy==="+this.sortBy);
        this.sortDirection = event.detail.sortDirection;
        console.log("sortDirection==="+this.sortDirection);
        this.sortData(event.detail.fieldName, event.detail.sortDirection);
    }

    sortData(fieldName, sortDirection) {
        console.log("-----sortdata-------");
        let sortResult = Object.assign([], this.data);
        this.data = sortResult.sort(function(a,b){
          if(a[fieldName] < b[fieldName])
            return sortDirection === 'asc' ? -1 : 1;
          else if(a[fieldName] > b[fieldName])
            return sortDirection === 'dsc' ? 1 : -1;
          else
            return 0;
        })
    }
    viewCurrentRecord(currentRow) {
        this.bShowModal = true;
        this.isEditForm = false;
        this.isNew = false;
        this.record = currentRow;
    }
    editCurrentRecord(currentRow) {
        this.bShowModal = true;
        this.isEditForm = true;
        this.currentRecordId = currentRow.Id;
    }
    closeModal() {
        this.bShowModal = false;
        this.createModal = false;
        this.isNew = false;
        
    }
    createNewRecord(){
        this.bShowModal = true;
        this.isNew = true;
        this.record = '';
    }
    deleteCons(currentRow) {
        let currentRecord = [];
        currentRecord.push(currentRow.Id);
        this.showLoadingSpinner = true;
        deleteRecord(currentRow.Id)
            .then(result => {
                console.log('result ====> ' + result);
                this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: 'Record Is  Deleted',
                        variant: 'success',
                    }),
                    );
                    return refreshApex(this.refreshTable);
            })
    }

    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "Contact created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        console.log('contactId==',event.detail.id);
        this.isNew = false;
        this.bShowModal = false;
    }
    handleEditSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "Contact Updated",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        console.log('contactId==',event.detail.id);
        this.isNew = false;
        this.bShowModal = false;
    }
    handleSubmit(event) {
        let r = event.detail.fields;
        console.log('fields====='+ JSON.stringify(r));
    }
    /*connectedCallback(){
        refreshApex(this.refreshTable);
        setInterval( ()=> {
            refreshApex(this.refreshTable);
        },1000*2)
    }*/
}