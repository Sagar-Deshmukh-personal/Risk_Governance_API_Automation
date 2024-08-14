@sanity @member
Feature: To Check the Create Members API
Background:
    #Declarations and file read of headers/ cookies
         * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of "json" request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    #Declarations and file read of 'json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json')
@member
Scenario:[TC-MB-01] To verify the Create Members API with sending mandatory parameters and ensure the response matches the expected success structure
        
        Given url getUrl.mintifiBaseUrl + getUrl.typeCreateMembers
        And headers getHeaders
        And def requestBody = getRequestBodyLogin.validateMember

    # Generate a unique name using a base name and a random string
        * def uniqueName = 'gaurav.chavan' + java.util.UUID.randomUUID().toString().replaceAll('-', '').substring(0, 5)
    # Generating a unique email using the same random string or another method
        * def email = uniqueName + '@mintifi.com'
    # Append the generated unique name and email to the request body
        * requestBody.name = uniqueName
        * requestBody.email = email
        And request requestBody
        When method post
        Then status 201
        And print response

        And assert responseStatus == 201
        * def storedMemberId = response.data.id
        * print 'Member id is: ', storedMemberId

@member
Scenario:[TC-MB-02] To verify the Create Members API with not sending mandatory parameters and ensure the error response matches the expected success structure
        
        Given url getUrl.mintifiBaseUrl + getUrl.typeCreateMembers
        And headers getHeaders
        And def requestBody = getRequestBodyLogin.valiateemptyparameter
        And request requestBody
        When method post
        Then status 400
        And print response
        And assert responseStatus == 400

@member
Scenario:[TC-MB-03] To verify the Create Members API with not sending some mandatory parameters and ensure the error response matches the expected success structure
        
        Given url getUrl.mintifiBaseUrl + getUrl.typeCreateMembers
        And headers getHeaders
        * def requestBody = 
    """
    {
      "name": "",
      "email": "sagar.deshmukh@mintifi.com",
      "role": "manager"
    }
    """
        And request requestBody
        When method post
        Then status 400
        And print response
        And assert responseStatus == 400
    #FuzzyMatcing 
        * def expectedResponseDataTypes =
        """
        getResponseBodyLogin.validateFuzzyMatchErrorResponseO 
        """
        * print expectedResponseDataTypes
        * def actualResponseDataTypes = response
        * print actualResponseDataTypes
        And match actualResponseDataTypes == expectedResponseDataTypes


@member
Scenario:[TC-MB-04] To verify the Create Members API with not sending some mandatory parameters and ensure the error response matches the expected success structure
            
        Given url getUrl.mintifiBaseUrl + getUrl.typeCreateMembers
        And headers getHeaders
        * def requestBody = 
    """
    {
      "name": "Sanjeev Kumar",
      "email": "",
      "role": "manager"
    }
    """
        And request requestBody
        When method post
        Then status 400
        And print response
        And assert responseStatus == 400
    
    #FuzzyMatcing 
        * def expectedResponseDataTypes =
        """
        getResponseBodyLogin.validateFuzzyMatchErrorResponse 
        """
        * print expectedResponseDataTypes
        * def actualResponseDataTypes = response
        * print actualResponseDataTypes
        And match actualResponseDataTypes == expectedResponseDataTypes