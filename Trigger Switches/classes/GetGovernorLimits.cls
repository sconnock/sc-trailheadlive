public class GetGovernorLimits {
    
    public class LimitsRequest {
		@InvocableVariable public String limitName;        
    }
    
    public class LimitsResult {
	    @InvocableVariable public Integer limitValue;        
    }

    @InvocableMethod
    public static List<LimitsResult> getLimit(List<LimitsRequest> request) {
        String limitName = request[0].limitName.toUpperCase();
		LimitsResult result = new LimitsResult();
        
        switch on limitName {
            when 'QUERYROWS' {
                result.limitValue = Limits.getQueryRows();
            }
            when 'QUERIES' {
                result.limitValue = Limits.getQueries();
            }
            when 'DMLROWS' {
                result.limitValue = Limits.getDmlRows();
            }
            when 'DMLSTATEMENTS' {
                result.limitValue = Limits.getDmlStatements();
            }
            when else {
                result.limitValue = -1;
            }
        }  
        
        List<LimitsResult> results = new List<LimitsResult>{result};
		return results;
    }
}