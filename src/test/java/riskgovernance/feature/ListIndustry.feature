@sanity @IndList
Feature: To Check the Industry Listing API
Background:
    #Declarations and file read of headers/ cookies
         * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of "json" request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    #Declarations and file read of 'json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 
@IndList
Scenario:[TC-IDL-01] To verify the Industry list API with without parameter(like Name,Per page,page)
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    When method GET
    Then status 200
    * print response
    * def responseCount = response.meta.total_count
    * print 'Response Count: ', responseCount
    * def responseTotalRecords = response.meta.total_records
    * print " Response Total Record", responseTotalRecords

@IndList
Scenario:[TC-IDL-02] Verify the Industry Listing API with dynamic query like "page" and "total records" send in query parameter and match paremeter
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    And param per = 10
    And param page = 1
    When method GET
    Then status 200
    And print response
    * def responseCount = response.meta.total_count
    * print 'Response Count: ', responseCount
    * def responseTotalRecords = response.meta.total_records
    * print " Response Total Record", responseTotalRecords

@IndList
Scenario:[TC-IDL-03] Verify the Industry Listing API with dynamic query like "name" and match paremeter
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    And param name = "Auto"
    When method GET
    Then status 200
    And print response
    * def responseCount = response.meta.total_count
    * print 'Response Count: ', responseCount
    * def responseTotalRecords = response.meta.total_records
    * print " Response Total Record", responseTotalRecords

@IndList
Scenario:[TC-IDL-04] To verify the Industry list API with with all parameter(like Name,Per page,page)
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    And param name = "food"
    And param page = 1
    And param per = 10
    When method GET
    Then status 200
    * print response
    * def responseCount = response.meta.total_count
    * print 'Response Count: ', responseCount
    * def responseTotalRecords = response.meta.total_records
    * print " Response Total Record", responseTotalRecords