import { LightningElement,track } from 'lwc';
import getHotelsByCity from "@salesforce/apex/searchHotels.getHotels";

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class SearchHotel extends LightningElement {
    
    data = [];
    isdata = false
    @track city;

    handleChange(event){
        this.city = event.target.value;

    }
    fetchHotelsBycity(){
        console.log('city-- '+this.city);
        if(this.city){
            getHotelsByCity({cityName:this.city})
            .then(result => {
            var hotels = [];
            hotels = JSON.parse(result).suggestions[1].entities;
            for(var i=0;i<hotels.length;i++){
                var h = [i+1] +' '+hotels[i].name;
                this.data.push(h);
                console.log('h-'+h);
            }
            this.isdata = true;
            })
            .catch(error => {
			this.data = error;
            })
        }else{
            this.dispatchEvent(new ShowToastEvent({
                        title: 'Error',
                        message: 'Please enter City name',
                        variant: 'error',
                    }),
                    );
        }
        
    }

    cleardata(){
        this.isdata = false;
        this.data =[];
        this.city = '';
        this.template.querySelector('lightning-input[data-name="CityName"]').value = null;
    }
}