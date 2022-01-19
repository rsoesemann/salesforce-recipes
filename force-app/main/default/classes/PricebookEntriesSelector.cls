public class PricebookEntriesSelector extends fflib_SObjectSelector
{
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField> {
			PricebookEntry.Id,
			PricebookEntry.IsActive,
			PricebookEntry.Name,
			PricebookEntry.Pricebook2Id,
			PricebookEntry.Product2Id,
			PricebookEntry.ProductCode,
			PricebookEntry.UnitPrice,
			PricebookEntry.UseStandardPrice
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return PricebookEntry.sObjectType;
	}

	public List<PricebookEntry> selectById(Set<ID> idSet)
	{
		assertIsAccessible();
		String query = String.format('select {0},{3},{4} FROM {1} WHERE id in :idSet order by {2}', 
			new List<String>{
				getFieldListString(),
				getSObjectName(),
				getOrderBy()
			});
		return (List<PricebookEntry>) Database.query(query);
	}
}