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
Scenario:[TC-CCE-01] To verify the Create Industry API

    * def adjectives = ['Electronic', 'Technical', 'Modern', 'Innovative', 'Advanced', 'Digital','Construction','Travel','Readymade Garments']
    * def nouns = ['Vehicle', 'Machine', 'Technology', 'Solution', 'System', 'Device','Hardware','Services' ]
    Given url getUrl.mintifiBaseUrl + getUrl.typeCreateIndutry
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
    * def riskType = ['PROVISIONAL', 'ACTUAL'][Math.floor(Math.random() * 2)]
    * requestBody.riskType = riskType

# Add risk parameter with a value of "HIGH", "MEDIUM", or "LOW"
    * def risk = ['HIGH', 'MEDIUM', 'LOW'][Math.floor(Math.random() * 3)]
    * requestBody.risk = risk

# Output the values of riskType and risk
    * print 'Risk Type: ', requestBody.riskType
    * print 'Risk: ', requestBody.risk

    And request requestBody
    When method post
    Then status 200
    And print response