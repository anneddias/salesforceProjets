trigger OpportunityTrigger on Opportunity (before update) {
    for (Opportunity opp : Trigger.new) {
        // Se o valor da oportunidade for maior que 10.000, mova para "Proposta Enviada"
        if (opp.Amount > 10000 && opp.StageName != 'Proposta Enviada') {
            opp.StageName = 'Proposta Enviada';
        }
        // Caso o valor da oportunidade seja menor ou igual a 10.000, mova para "Qualificação"
        else if (opp.Amount <= 10000 && opp.StageName != 'Qualificação') {
            opp.StageName = 'Qualificação';
        }
    }
}
