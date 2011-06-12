// Copyright (c) 2011, Matthew McComb
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software
//    must display the following acknowledgement:
//    This product includes software developed by the <organization>.
// 4. Neither the name of the <organization> nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE

#import "PlacesRequestTest.h"
#import "PlacesRequest.h"
#import "GooglePlacesAPI.h"

@implementation PlacesRequestTest

- (NSString*)assertionMessageForIncorrectQueryParam:(NSString*)parameterName withExpectedValue:(NSString*)expectedValue andActualValue:(NSString*)actualValue {
    NSString* failureMessage = [NSString stringWithFormat:@"Expected %@ request header to be %@ but %@ was returned", parameterName, expectedValue, actualValue];
    return failureMessage;
}

- (void)assertQueryParamInURL:(NSURL*)url parameterName:(NSString*)name expectedParameterValue:(NSString*)value {
    NSString* queryString = [[[url absoluteString] componentsSeparatedByString:@"?"] objectAtIndex:1];
    queryString = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, 
                                                                                          (CFStringRef)queryString, 
                                                                                          (CFStringRef)@"",
                                                                                          NSASCIIStringEncoding);        
    
    NSArray* queryParameters = [queryString componentsSeparatedByString:@"&"];
    for (NSString* queryParameter in queryParameters) {
        if ([queryParameter rangeOfString:name].location == 0) {
            NSString* valueOfQueryParameter = [[queryParameter componentsSeparatedByString:@"="] objectAtIndex:1];
            NSString* assertionMessageForIncorrectParamValue = [self assertionMessageForIncorrectQueryParam:name withExpectedValue:value andActualValue:valueOfQueryParameter];
            STAssertTrue([valueOfQueryParameter isEqual:value], assertionMessageForIncorrectParamValue);
            return;
        }
    }
    STFail(@"The query string did not contain a %@ parameter", name);
}

- (void)assertQueryParamNotInURL:(NSURL*)url parameterName:(NSString*)name {
    NSString* queryString = [[[url absoluteString] componentsSeparatedByString:@"?"] objectAtIndex:1];
    NSArray* queryParameters = [queryString componentsSeparatedByString:@"&"];
    for (NSString* queryParameter in queryParameters) {
        if ([queryParameter rangeOfString:name].location == 0) {
            STFail(@"Query string contained an unexpected parameter: %@", name);
        }
    }    
}

/* ******************************************************************************** *
 *                           Required Field Mapping Tests                           *
 * ******************************************************************************** */

- (void)testThatLocationQueryParameterIsAddedToHttpRequest {
    CLLocation* EXPECTED_LOCATION = [[CLLocation alloc] initWithLatitude:1.00000 longitude:1.000000];
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:EXPECTED_LOCATION radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@""];
    NSURLRequest* httpRequest = [request asHttpRequest];
    CLLocationCoordinate2D coordsForExpectedLocation = [EXPECTED_LOCATION coordinate];
    NSString* expectedLocationFormattedAsQueryStringParameter = [NSString stringWithFormat:@"%f,%f", coordsForExpectedLocation.longitude, coordsForExpectedLocation.latitude];
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)LOCATION_QUERY_PARAM_NAME expectedParameterValue:expectedLocationFormattedAsQueryStringParameter];
}

- (void)testThatAPIKeyQueryParameterIsAddedToHttpRequest {
    NSString* EXPECTED_API_KEY = @"i323204ss";
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:EXPECTED_API_KEY];
    NSURLRequest* httpRequest = [request asHttpRequest];    
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)API_KEY_QUERY_PARAM_NAME expectedParameterValue:EXPECTED_API_KEY];
}

- (void)testThatGPSSensorQueryParameterIsAddedToHttpRequest {
    BOOL EXPECTED_GPS_SETTING = TRUE;
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:EXPECTED_GPS_SETTING andAPIKey:@""];
    NSURLRequest* httpRequest = [request asHttpRequest];
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)IS_GPS_REQUEST_QUERY_PARAM_NAME expectedParameterValue:(NSString*)GP_BOOL_TRUE_VALUE];
}

- (void)testThatSearchRadiusQueryParameterIsAddedToHttpRequest {
    const NSUInteger EXPECTED_SEARCH_RADIUS = 100;
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:EXPECTED_SEARCH_RADIUS isGPSRequest:FALSE andAPIKey:@""];
    NSURLRequest* httpRequest = [request asHttpRequest];    
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)RADIUS_QUERY_PARAM_NAME expectedParameterValue:[NSString stringWithFormat:@"%i", EXPECTED_SEARCH_RADIUS]];
}


/* ******************************************************************************** *
 *                            Place Types Mapping Tests                             *
 * ******************************************************************************** */

- (void)testThatPlaceTypesQueryParameterIsNotAddedIfNoTypesAreSpecified {
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@"ASJ932912NX"];
    NSURLRequest* httpRequest = [request asHttpRequest];      
    [self assertQueryParamNotInURL:[httpRequest URL] parameterName:(NSString*)PLACE_TYPES_QUERY_PARAM_NAME];
}

- (void)testThatPlaceTypesQueryParameterIsAddedToHttpRequest {
    const NSString* EXPECTED_TYPE = GP_TYPE_ZOO;
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@"ASJ932912NX"];
    [request addPlaceTypeToFind:GP_TYPE_ZOO];
    NSURLRequest* httpRequest = [request asHttpRequest];    
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)PLACE_TYPES_QUERY_PARAM_NAME expectedParameterValue:(NSString*)EXPECTED_TYPE];    
}

- (void)testThatMultiplePlaceTypesAreAddedToHttpRequest {
    const NSString* EXPECTED_TYPE_LIST = [NSString stringWithFormat:@"%@%@%@", GP_TYPE_ATM, TYPES_SEPARATOR, 
                                          GP_TYPE_BANK];
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@"ASJ932912NX"];
    [request addPlaceTypeToFind:GP_TYPE_ATM];
    [request addPlaceTypeToFind:GP_TYPE_BANK];
    NSURLRequest* httpRequest = [request asHttpRequest];    
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)PLACE_TYPES_QUERY_PARAM_NAME expectedParameterValue:(NSString*)EXPECTED_TYPE_LIST];     
}


/* ******************************************************************************** *
 *                             Language Mapping Tests                               *
 * ******************************************************************************** */

- (void)testThatLanguageQueryParameterIsNotAddedIfNoLangaugeIsSpecified {
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@"ASJ932912NX"];
    NSURLRequest* httpRequest = [request asHttpRequest];      
    [self assertQueryParamNotInURL:[httpRequest URL] parameterName:(NSString*)LANGUAGE_QUERY_PARAM_NAME];   
}

- (void)testThatLanguageIsAddedToHttpRequestIfSet {
    const NSString* EXPECTED_LANGUAGE = @"ENG";
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@"ASJ932912NX"];
    [request setLanguage:EXPECTED_LANGUAGE];
    NSURLRequest* httpRequest = [request asHttpRequest];      
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)LANGUAGE_QUERY_PARAM_NAME expectedParameterValue:(NSString*)EXPECTED_LANGUAGE];
}


/* ******************************************************************************** *
 *                             Place Name Mapping Tests                             *
 * ******************************************************************************** */

- (void)testThatPlaceNameQueryParameterIsNotAddedIfNoLangaugeIsSpecified {
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@"ASJ932912NX"];
    NSURLRequest* httpRequest = [request asHttpRequest];      
    [self assertQueryParamNotInURL:[httpRequest URL] parameterName:(NSString*)PLACE_NAME_QUERY_PARAM_NAME];     
}

- (void)testThatPlaceNameIsAddedToHttpRequestIfSet {
    const NSString* EXPECTED_PLACE_NAME = @"White Hart Lane";
    PlacesRequest* request = [[PlacesRequest alloc] initWithLocation:nil radiusOfSearch:0 isGPSRequest:FALSE andAPIKey:@"ASJ932912NX"];
    [request setName:(NSString*)EXPECTED_PLACE_NAME];
    NSURLRequest* httpRequest = [request asHttpRequest];      
    [self assertQueryParamInURL:[httpRequest URL] parameterName:(NSString*)PLACE_NAME_QUERY_PARAM_NAME expectedParameterValue:(NSString*)EXPECTED_PLACE_NAME];    
}

@end
