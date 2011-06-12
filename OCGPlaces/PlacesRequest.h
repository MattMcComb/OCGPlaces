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

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PlacesRequest : NSObject {
    CLLocation* _location;
    NSUInteger _searchRadius;
    BOOL _isGPSRequest;
    NSString* _apiKey;
    NSMutableArray* _placeTypes;
    NSString* _language;
    NSString* _name;
}

/**
 * The location for which nearby places will be queried (required)
 */
@property(nonatomic, retain) CLLocation* location;


/**
 * The radius in meters from the search location to query for results (required) 
 */
@property(nonatomic, assign) NSUInteger searchRadius;


/**
 * Whether or not the location was determined using a sensor/GPS device (required)
 */
@property(nonatomic, assign) BOOL isGPSRequest;


/**
 * The Google Places API key associated with this request/application (required) 
 */
@property(nonatomic, retain) NSString* apiKey;


/**
 * The type(s) of places to return in the places search results (optional) 
 * See GP_TYPE_ constants in GooglePlacesAPI.h for valid options
 */
@property(nonatomic, readonly) NSMutableArray* placeTypes;


/**
 * The language in which the response to the request will be returned (optional) 
 * See GP_LANG_ constants in GooglePlacesAPI.h for valid options
 */
@property(nonatomic, retain) const NSString* language;


/**
 * A full or partial name to match against the names of potential results 
 */
@property(nonatomic, retain) NSString* name;

// Designated initializer
- (id)initWithLocation:(CLLocation*)location radiusOfSearch:(NSUInteger)searchRadius 
          isGPSRequest:(BOOL)isUsingSensor andAPIKey:(NSString*)apiKey;

/**
 * Creates an NSURLRequest representation of this PlacesRequest.  The URL to be retrieved
 * will be of the form ${GP_API_URI}?param1=val1&param2=val2..paramn=valn where each 
 * parameter represents a value set on this request
 * 
 * NB: The returned URL is already URL encoded
 * 
 * @return a URL Encoded NSURLRequest for the Google Places web service with a query string 
 * containing parameters for each field set in the request
 *
 */
- (NSURLRequest*)asHttpRequest;

/**
 * Adds a place type to be searched for
 * NB: Valid place types are defined as contants with the GP_TYPE_ in GooglePlacesAPI.h
 *
 * @param placeType the place type to add to the list of types being searched for
 */
- (void)addPlaceTypeToFind:(const NSString*)placeType;

/**
 * Adds a place type to be searched for
 * NB: Valid place types are defined as contants with the GP_TYPE_ in GooglePlacesAPI.h
 *
 * @param placeType the place type to remove from the list of types being searched for
 */
- (void)removePlaceTypeToFind:(const NSString*)placeType;

@end
