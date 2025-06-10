public class MarketingCloudSyncQueueable implements Queueable, Database.AllowsCallouts {

    private List<Lead> leads;
    private Integer retryCount;

    public MarketingCloudSyncQueueable(List<Lead> leads, Integer retryCount) {
        this.leads = leads;
        this.retryCount = retryCount;
    }

    public void execute(QueueableContext context) {

        if (leads == null || leads.isEmpty()) {
            System.debug('Nenhum lead para sincronizar. Saindo do job.');
            return;
        }

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:MarketingCloudAPI/leads');
        req.setMethod('POST');
        req.setBody(JSON.serialize(leads));
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();

        try {
            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                System.debug('✅ Leads sincronizados com sucesso! Status 200');
            } else if (shouldRetry(res.getStatusCode()) && retryCount < 3) {
                System.debug('🔄 Tentativa de retry #' + (retryCount + 1) + ' - Status: ' + res.getStatusCode());
                enqueueRetry();
            } else {
                System.debug('❌ Erro ao sincronizar leads. Status: ' + res.getStatusCode()
                    + ' - Body: ' + res.getBody());
            }

        } catch (Exception e) {
            System.debug('⚠️ Exceção ao enviar requisição: ' + e.getMessage());
            if (retryCount < 3) {
                System.debug('🔄 Retry devido a exceção - Tentativa #' + (retryCount + 1));
                enqueueRetry();
            }
        }
    }

    private Boolean shouldRetry(Integer statusCode) {
        return statusCode == 429 || (statusCode >= 500 && statusCode < 600);
    }

    private void enqueueRetry() {
        System.enqueueJob(new MarketingCloudSyncQueueable(leads, retryCount + 1));
    }
}
