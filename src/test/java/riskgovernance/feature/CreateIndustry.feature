@Industry
Feature: To Check the Create Industry API
Background:
    #Declarations and file read of headers/ cookies
         * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of "json" request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    #Declarations and file read of 'json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json') 
@Industry
Scenario:[TC-ID-01] To verify the Create Industry API with sending mandatory parameters and ensure the response matches the expected success structure

    * def adjectives = ['Electronic', 'Technical', 'Modern', 'Innovative', 'Advanced', 'Digital','Construction','Travel','Readymade Garments']
    * def nouns = ['Vehicle', 'Machine', 'Technology', 'Solution', 'System', 'Device','Hardware','Services' ]
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    And def requestBody = getRequestBodyLogin.validateCreateIndustry

# Generate a unique random name
    * def randomAdjectiveIndex = Math.floor(Math.random() * adjectives.length)
    * def randomNounIndex = Math.floor(Math.random() * nouns.length)
    * def randomAdjective = adjectives[randomAdjectiveIndex]
    * def randomNoun = nouns[randomNounIndex]
    * def randomName = randomAdjective + ' ' + randomNoun

# Remove the selected adjective and noun from the lists to ensure uniqueness
    * def updatedAdjectives = adjectives - randomAdjective
    * def updatedNouns = nouns - randomNoun
    * requestBody.name = randomName

# Add riskType parameter with a value of "PROVISIONAL" or "ACTUAL"
    * def riskTypes = ['PROVISIONAL', 'ACTUAL']
    * def randomRiskTypeIndex = Math.floor(Math.random() * riskTypes.length)
    * def riskType = riskTypes[randomRiskTypeIndex]
    * requestBody.riskType = riskType

 # Add risk parameter with a value of "HIGH", "MEDIUM", or "LOW"
    * def risks = ['HIGH', 'MEDIUM', 'LOW']
    * def randomRiskIndex = Math.floor(Math.random() * risks.length)
    * def risk = risks[randomRiskIndex]
    * requestBody.risk = risk

# Output the values of riskType and risk
    * print 'Risk Type: ', requestBody.riskType
    * print 'Risk: ', requestBody.risk
    And request requestBody
    When method post
    Then status 200
    And print response
# Validate the success response
    * match response.id == '#number'
    * match response.type == '#string'
@Industry
Scenario:[TC-ID-02] To verify the Create Industry API without sending mandatory parameters and ensure the response matches the expected error structure

    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    And def requestBody = getRequestBodyLogin.validateMandetoryIndustry
    And request requestBody
    When method post
    Then status 400
    And print response
# Validate the error response structure
    * def expectedResponse = getResponseBodyLogin.ErrorIndustryResponse
    * match response == expectedResponse

@Industry
Scenario:[TC-ID-03]To verify the Create Industry API for duplicate industry creation and validate the error message
# Step 1: Create an industry
    * def adjectives = ['Electronic', 'Technical', 'Modern', 'Innovative', 'Advanced', 'Digital','Construction','Travel','Readymade Garments']
    * def nouns = ['Vehicle', 'Machine', 'Technology', 'Solution', 'System', 'Device','Hardware','Services' ]
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    And def requestBody = getRequestBodyLogin.validateCreateIndustry

# Generate a unique random name
    * def randomAdjectiveIndex = Math.floor(Math.random() * adjectives.length)
    * def randomNounIndex = Math.floor(Math.random() * nouns.length)
    * def randomAdjective = adjectives[randomAdjectiveIndex]
    * def randomNoun = nouns[randomNounIndex]
    * def randomName = randomAdjective + ' ' + randomNoun

# Remove the selected adjective and noun from the lists to ensure uniqueness
    * def updatedAdjectives = adjectives - randomAdjective
    * def updatedNouns = nouns - randomNoun
    * requestBody.name = randomName

# Add riskType parameter with a value of "PROVISIONAL" or "ACTUAL"
    * def riskTypes = ['PROVISIONAL', 'ACTUAL']
    * def randomRiskTypeIndex = Math.floor(Math.random() * riskTypes.length)
    * def riskType = riskTypes[randomRiskTypeIndex]
    * requestBody.riskType = riskType

 # Add risk parameter with a value of "HIGH", "MEDIUM", or "LOW"
    * def risks = ['HIGH', 'MEDIUM', 'LOW']
    * def randomRiskIndex = Math.floor(Math.random() * risks.length)
    * def risk = risks[randomRiskIndex]
    * requestBody.risk = risk

# Output the values of riskType and risk
    * print 'Risk Type: ', requestBody.riskType
    * print 'Risk: ', requestBody.risk
    And request requestBody
    When method post
    Then status 200
    And print 'First Creation Response:', response
# Step 2: Attempt to create the same industry again to trigger duplicate error
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
    And headers getHeaders
    And request requestBody
    When method post
    Then status 409
    And print 'Duplicate Creation Response:', response

# Validate the error response structure
  * def expectedDuplicateErrorResponse = getResponseBodyLogin.DuplicateIndustryResponse
  * match response == expectedDuplicateErrorResponse
@Industry
Scenario:[TC-ID-04] To verify the Create Industry API with all parameter
    # Step 1: Create an industry
        * def adjectives = ['Beers ', 'Tractors', 'Auto Batteries ', 'Innovative', 'Small Appliances', 'Steel','Infra','Retail','Readymade Garments']
        * def nouns = ['Wines', 'Pumps', 'Coolers', 'Solution', 'System', 'Device','Hardware','Travel Services','Ecommerce','Agri Inputs' ]
        Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndustry
        And headers getHeaders
        And def requestBody = getRequestBodyLogin.validateCreateIndustry
    
    # Generate a unique random name
        * def randomAdjectiveIndex = Math.floor(Math.random() * adjectives.length)
        * def randomNounIndex = Math.floor(Math.random() * nouns.length)
        * def randomAdjective = adjectives[randomAdjectiveIndex]
        * def randomNoun = nouns[randomNounIndex]
        * def randomName = randomAdjective + ' ' + randomNoun
    
    # Remove the selected adjective and noun from the lists to ensure uniqueness
        * def updatedAdjectives = adjectives - randomAdjective
        * def updatedNouns = nouns - randomNoun
        * requestBody.name = randomName
    
    # Add riskType parameter with a value of "PROVISIONAL" or "ACTUAL"
        * def riskTypes = ['PROVISIONAL', 'ACTUAL']
        * def randomRiskTypeIndex = Math.floor(Math.random() * riskTypes.length)
        * def riskType = riskTypes[randomRiskTypeIndex]
        * requestBody.riskType = riskType
    
    # Add risk parameter with a value of "HIGH", "MEDIUM", or "LOW"
        * def risks = ['HIGH', 'MEDIUM', 'LOW']
        * def randomRiskIndex = Math.floor(Math.random() * risks.length)
        * def risk = risks[randomRiskIndex]
        * requestBody.risk = risk
    # Add active parameter with a value of "True" or "False"
        * def active = ['true', 'false']
        * def randomActiveIndex = Math.floor(Math.random() * active.length)
        * def active = active[randomActiveIndex]
        * requestBody.active = active
    # Add code parameter with a random 5-digit number
        * def randomCode = Math.floor(10000 + Math.random() * 90000).toString()
        * requestBody.code = randomCode
    
    # Output the values of riskType and risk
        * print 'Risk Type: ', requestBody.riskType
        * print 'Risk: ', requestBody.risk
        * print 'Active: ', requestBody.active
        * print 'Code: ', requestBody.code
    # Sending request
        And request requestBody
        When method post
        Then status 200
    # print the response
        And print response