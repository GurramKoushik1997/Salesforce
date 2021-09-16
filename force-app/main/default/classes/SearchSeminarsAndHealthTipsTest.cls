@isTest
public class SearchSeminarsAndHealthTipsTest {
	STATIC TESTMETHOD VOID doTestSeminars()
    {
        SearchSeminarsCon.returnAllSeminars();
        string selCategory = 'NORMAL-WEIGHT';
        SearchSeminarsCon.returnSeminarsByCategory(selCategory);
    }
    
    STATIC TESTMETHOD VOID doTestHealthTips()
    {
        SearchHealthTipsCon.returnAllHealthTips();
        string selCategory = 'NORMAL-WEIGHT';
        SearchHealthTipsCon.returnHealthTipsByCategory(selCategory);
    }
    
    STATIC TESTMETHOD VOID doDataLoadTest()
    {
        loadSampleData.loadSampleData();
    }
}