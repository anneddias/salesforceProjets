import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getOpportunities from '@salesforce/apex/OpportunityController.getOpportunities';

export default class OpportunityPipeline extends LightningElement {
    opportunities = [];
    isLoading = true;
    wiredOpportunitiesResult;

    columns = [
        { label: 'Nome da Oportunidade', fieldName: 'Name' },
        { label: 'Valor', fieldName: 'Amount', type: 'currency' },
        { label: 'Fase', fieldName: 'StageName' },
        { label: 'Data de Fechamento', fieldName: 'CloseDate', type: 'date' }
    ];

    @wire(getOpportunities)
    wiredOpportunities(result) {
        this.wiredOpportunitiesResult = result;
        const { data, error } = result;

        this.isLoading = false;

        if (data) {
            this.opportunities = data;
        } else if (error) {
            console.error('Error retrieving opportunities:', error);
        }
    }

    refreshOpportunities() {
        this.isLoading = true;
        refreshApex(this.wiredOpportunitiesResult).finally(() => {
            this.isLoading = false;
        });
    }

    get hasOpportunities() {
        return this.opportunities && this.opportunities.length > 0;
    }
}
