import { LightningElement, track } from 'lwc';

export default class HelloLwc extends LightningElement {

    @track greeting = 'World';

    handleChange(event) {
        this.greeting = event.target.value;
    }

    count() {
        alert(this.greeting.length + " letters");
    }
}