import { LightningElement,wire,track} from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';
export default class Time extends LightningElement {
@track time="";
@track greeting="";
@track name;
connectedCallback(){
    this.getTime();
    setInterval(() =>{
        this.getTime();
    }, 1000);
}

@wire(getRecord, {
        recordId: USER_ID,
        fields: [NAME_FIELD]
    }) wireuser({
        error,
        data
    }) {
        if (error) {
           this.error = error ; 
        } else if (data) {
            this.name = data.fields.Name.value;
        }
    }

getTime(){
    const date = new Date();
    const hour = date.getHours();
    const min = date.getMinutes();
    this.time = `${this.getHour(hour)}:${this.getDoubleDigit(min)} ${this.getMidDay(hour)}`;
    this.setGreeting(hour);
}
getHour(hour){
    return hour === 0 ? 12 : hour > 12 ? (hour-12) : hour;
}
getMidDay(hour){
    return hour >= 12 ? "PM" : "AM";
}
getDoubleDigit(digit){
    return digit < 10 ? "0"+digit : digit;
}
setGreeting(hour){
    if(hour < 12){
        this.greeting = "Good Morning";
    }else if(hour >= 12 && hour < 17){
        this.greeting = "Good Afternoon";
    }else{
        this.greeting = "Good Evening";
    }
    //this.greeting += " "+this.name;
}
}