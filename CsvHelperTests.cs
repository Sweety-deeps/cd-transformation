using System;
using cdtransformation.Helpers;
using Xunit;

namespace cdtransformation.tests.Helpers
{
	public class CsvHelperTests
	{
		[Fact]
		public void Validate_DataTableWhenPassedCsvDataAsString()
		{
			var csvHelper = new CsvHelper();

			string csvContent = "id,name\r\n123,mohan\r\n1234,testdata\r\n\r\n";

			var result = csvHelper.GetDataFromCsv(false, csvContent);
		}
	}
}