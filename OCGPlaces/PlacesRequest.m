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

#import "PlacesRequest.h"
#import "GooglePlacesAPI.h"

@implementation PlacesRequest

@synthesize location = _location;
@synthesize searchRadius = _searchRadius;
@synthesize apiKey = _apiKey;
@synthesize isGPSRequest = _isGPSRequest;
@synthesize placeTypes = _placeTypes;
@synthesize language = _language;
@synthesize name = _name;

- (void)dealloc {
	[self setApiKey: nil];
	[_apiKey release];
	_apiKey = nil;
	[_location release];
	_location = nil;
	[_placeTypes release];
	_placeTypes = nil;
    [_name release];
    _name = nil;
    [_language release];
    _language = nil;
	[super dealloc];
}

- (id)initWithLocation:(CLLocation*)aLocation radiusOfSearch:(NSUInteger)theSearchRadius isGPSRequest:(BOOL)isAGPSRequest andAPIKey:(NSString *)theAPIKey {
	if ( (self = [super init]) ) {
		_location = [aLocation retain];
		_apiKey = [theAPIKey retain];
		_searchRadius = theSearchRadius;
		_isGPSRequest = isAGPSRequest;
		_placeTypes = [[NSMutableArray alloc] init];
        _language = nil;
        _name = nil;
	}
	return self;
}

- (NSString*)searchRadiusAsString {
	return [NSString stringWithFormat:@"%i", [self searchRadius]];
}

- (NSString*)isGPSRequestAsString {
	return [NSString stringWithFormat:@"%@", 
            ([self isGPSRequest] == TRUE) ? GP_BOOL_TRUE_VALUE: GP_BOOL_FALSE_VALUE];
}

- (NSString*)locationFormattedAsQueryParam {
	CLLocationCoordinate2D coordinate = [[self location] coordinate];
	return [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
}

- (NSString*)placeTypesFormattedAsQueryParam {
	NSMutableString *typesQueryParam = [[NSMutableString alloc] init];
	bool isFirstTypeOfPlace = TRUE;
	for (NSString *typeOfPlace in[self placeTypes]) {
		if (!isFirstTypeOfPlace) {
			[typesQueryParam appendString:(NSString*)TYPES_SEPARATOR];
		}
		else {
			isFirstTypeOfPlace = FALSE;
		};
		[typesQueryParam appendFormat:@"%@", typeOfPlace];
	}
	[typesQueryParam autorelease];
	return typesQueryParam;
}

- (NSString *)queryParameterWithName:(const NSString*)name andValue:(NSString*)value {
	return [NSString stringWithFormat:@"%@=%@", name, value];
}

- (void)appendQueryArgumentToPath:(NSMutableString*)path 
                         withName:(const NSString*)name andValue:(NSString*)value {
	NSString *lastCharacterInPath = [path substringFromIndex: [path length] - 1];
	if (![lastCharacterInPath isEqualToString:@"?"]) {
		[path appendString:@"&"];
	}
	[path appendString: [self queryParameterWithName:name andValue:value]];
}

- (void)addPlaceTypeToFind:(const NSString*)placeType {
	[[self placeTypes] addObject:placeType];
}

- (void)removePlaceTypeToFind: (const NSString *) placeType {
	[[self placeTypes] removeObject:placeType];
}

- (void)urlEncodeRequest:(NSMutableString*)request {
	NSUInteger indexOfQueryString = [request rangeOfString:@"?"].location + 1;
	NSUInteger lengthOfQueryString = [request length] - indexOfQueryString;
	NSString *queryString = [request substringFromIndex: indexOfQueryString];
	NSRange queryStringRange = NSRangeFromString([NSString stringWithFormat: 
                                                  @"{location=%i;length=%i}", 
                                                  indexOfQueryString, 
                                                  lengthOfQueryString]);
	NSString *urlEncodedQueryString = 
    (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
                                                        (CFStringRef)queryString,
                                                        NULL, 
                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                        NSASCIIStringEncoding);
	[request replaceCharactersInRange:queryStringRange withString:urlEncodedQueryString];
}

- (NSURLRequest *)asHttpRequest {
	NSMutableString *urlForGetRequest = [[NSMutableString alloc] initWithString:(NSString*)GP_API_URI];

	[self appendQueryArgumentToPath: urlForGetRequest withName:LOCATION_QUERY_PARAM_NAME andValue:[self locationFormattedAsQueryParam]];
	[self appendQueryArgumentToPath:urlForGetRequest withName:RADIUS_QUERY_PARAM_NAME andValue:[self searchRadiusAsString]];
	[self appendQueryArgumentToPath:urlForGetRequest withName:IS_GPS_REQUEST_QUERY_PARAM_NAME andValue:[self isGPSRequestAsString]];
	if ([[self placeTypes] count] > 0) {
		[self appendQueryArgumentToPath: urlForGetRequest withName:PLACE_TYPES_QUERY_PARAM_NAME andValue:[self placeTypesFormattedAsQueryParam]];
	}
    if ([self language] != nil) {
        [self appendQueryArgumentToPath:urlForGetRequest withName:LANGUAGE_QUERY_PARAM_NAME andValue:(NSString*)[self language]];
    }
    if ([self name] != nil) {
        [self appendQueryArgumentToPath:urlForGetRequest withName:PLACE_NAME_QUERY_PARAM_NAME andValue:[self name]];
    }
	[self appendQueryArgumentToPath:urlForGetRequest withName:API_KEY_QUERY_PARAM_NAME andValue:[self apiKey]];

	[self urlEncodeRequest: urlForGetRequest];
	[urlForGetRequest autorelease];
	NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: urlForGetRequest]];

	return urlRequest;
}

@end