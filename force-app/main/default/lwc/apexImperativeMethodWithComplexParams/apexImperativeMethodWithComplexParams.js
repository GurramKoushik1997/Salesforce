import { LightningElement } from 'lwc';
import checkApexTypes from '@salesforce/apex/ApexTypesController.checkApexTypes';

export default class ApexImperativeMethodWithComplexParams extends LightningElement {
    listItemValue = 4;
    numberValue = 50;
    stringValue = 'Some string';

    message;

    handleStringChange(event) {
        this.stringValue = event.target.value;
    }
    handleNumberChange(event) {
        this.numberValue = event.target.value;
    }
    handleListItemChange(event) {
        this.listItemValue = event.target.value;
    }
    handleButtonClick() {
        let parameterObject = {
            someString: this.stringValue,
            someInteger: this.numberValue,
            someList: []
        };
        for (let i = 0; i < this.listItemValue; i++) {
            parameterObject.someList.push({
                someInnerString: this.stringValue,
                someInnerInteger: this.numberValue
            });
        }
        checkApexTypes({ wrapper: parameterObject })
            .then((result) => {
                this.message = result;
            });
    }
}
