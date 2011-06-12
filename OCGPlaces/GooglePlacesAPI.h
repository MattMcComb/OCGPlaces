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

/* The base URL to which Places requests will be submitted
 * This represents the basis of the URL request such that a request is of the form 
 * ${GP_API_URL}?param1=val1&param2=val2
 */
extern const NSString* GP_API_URI;


/*
 * Symbolic constants for the parameters that can be passed as part of the URI query 
 * string for a Places request
 * See official docs for info on particular fields - 
 * http://code.google.com/apis/maps/documentation/places/#PlaceSearchRequests
 */
extern const NSString* LOCATION_QUERY_PARAM_NAME;
extern const NSString* RADIUS_QUERY_PARAM_NAME;
extern const NSString* IS_GPS_REQUEST_QUERY_PARAM_NAME;
extern const NSString* API_KEY_QUERY_PARAM_NAME;
extern const NSString* PLACE_TYPES_QUERY_PARAM_NAME;
extern const NSString* LANGUAGE_QUERY_PARAM_NAME;
extern const NSString* PLACE_NAME_QUERY_PARAM_NAME;

// Delimeter used to separate multiple values for the types parameter in a search 
// request
extern const NSString* TYPES_SEPARATOR;

/*
 * Symbolic constants for the place types supported by Google Places
 *
 * One or more these values (separated by TYPES_SEPARATOR) is submitted to the web service 
 * to request only places of a
 * particular classification are returned
 * See official docs for info on specifying place types -
 * http://code.google.com/apis/maps/documentation/places/#PlaceSearchRequests
 */
extern const NSString* GP_TYPE_ACCOUNTING;
extern const NSString* GP_TYPE_AIRPORT;
extern const NSString* GP_TYPE_AMUSEMENT_PARK;
extern const NSString* GP_TYPE_AQUARIUM;
extern const NSString* GP_TYPE_ART_GALLERY;
extern const NSString* GP_TYPE_ATM;
extern const NSString* GP_TYPE_BAKERY;
extern const NSString* GP_TYPE_BANK;
extern const NSString* GP_TYPE_BAR;
extern const NSString* GP_TYPE_BEAUTY_SALON;
extern const NSString* GP_TYPE_BICYCLE_STORE;
extern const NSString* GP_TYPE_BOOK_STORE;
extern const NSString* GP_TYPE_BOWLING_ALLEY;
extern const NSString* GP_TYPE_BUS_STATION;
extern const NSString* GP_TYPE_CAFE;
extern const NSString* GP_TYPE_CAMPGROUND;
extern const NSString* GP_TYPE_CAR_DEALER;
extern const NSString* GP_TYPE_CAR_RENTAL;
extern const NSString* GP_TYPE_CAR_REPAIR;
extern const NSString* GP_TYPE_CAR_WASH;
extern const NSString* GP_TYPE_CASINO;
extern const NSString* GP_TYPE_CEMETERY;
extern const NSString* GP_TYPE_CHURCH;
extern const NSString* GP_TYPE_CITY_HALL;
extern const NSString* GP_TYPE_CLOTHING_STORE;
extern const NSString* GP_TYPE_CONVENIENCE_STORE;
extern const NSString* GP_TYPE_COURTHOUSE;
extern const NSString* GP_TYPE_DENTIST;
extern const NSString* GP_TYPE_DEPARTMENT_STORE;
extern const NSString* GP_TYPE_DOCTOR;
extern const NSString* GP_TYPE_ELECTRICIAN;
extern const NSString* GP_TYPE_ELECTRONICS_STORE;
extern const NSString* GP_TYPE_EMBASSY;
extern const NSString* GP_TYPE_ESTABLISHMENT;
extern const NSString* GP_TYPE_FINANCE;
extern const NSString* GP_TYPE_FIRE_STATION;
extern const NSString* GP_TYPE_FLORIST;
extern const NSString* GP_TYPE_FOOD;
extern const NSString* GP_TYPE_FUNERAL_HOME;
extern const NSString* GP_TYPE_FURNITURE_STORE;
extern const NSString* GP_TYPE_GAS_STATION;
extern const NSString* GP_TYPE_GENERAL_CONTRACTOR;
extern const NSString* GP_TYPE_GEOCODE;
extern const NSString* GP_TYPE_GROCERY_OR_SUPERMARKET;
extern const NSString* GP_TYPE_GYM;
extern const NSString* GP_TYPE_HAIR_CARE;
extern const NSString* GP_TYPE_HARDWARE_STORE;
extern const NSString* GP_TYPE_HEALTH;
extern const NSString* GP_TYPE_HINDU_TEMPLE;
extern const NSString* GP_TYPE_HOME_GOODS_STORE;
extern const NSString* GP_TYPE_HOSPITAL;
extern const NSString* GP_TYPE_INSURANCE_AGENCY;
extern const NSString* GP_TYPE_JEWELRY_STORE;
extern const NSString* GP_TYPE_LAUNDRY;
extern const NSString* GP_TYPE_LAWYER;
extern const NSString* GP_TYPE_LIBRARY;
extern const NSString* GP_TYPE_LIQUOR_STORE;
extern const NSString* GP_TYPE_LOCAL_GOVERNMENT_OFFICE;
extern const NSString* GP_TYPE_LOCKSMUTG;
extern const NSString* GP_TYPE_LODGING;
extern const NSString* GP_TYPE_MEAL_DELIVERY;
extern const NSString* GP_TYPE_MEAL_TAKEAWAY;
extern const NSString* GP_TYPE_MOSQUE;
extern const NSString* GP_TYPE_MOVIE_RENTAL;
extern const NSString* GP_TYPE_MOVIE_THEATER;
extern const NSString* GP_TYPE_MOVIE_COMPANY;
extern const NSString* GP_TYPE_MUSEUM;
extern const NSString* GP_TYPE_NIGHT_CLUB;
extern const NSString* GP_TYPE_PAINTER;
extern const NSString* GP_TYPE_PARK;
extern const NSString* GP_TYPE_PARKING;
extern const NSString* GP_TYPE_PET_STORE;
extern const NSString* GP_TYPE_PHARMACY;
extern const NSString* GP_TYPE_PHYSIOTHERAPIST;
extern const NSString* GP_TYPE_PLACE_OF_WORSHIP;
extern const NSString* GP_TYPE_PLUMBER;
extern const NSString* GP_TYPE_POLICE;
extern const NSString* GP_TYPE_POST_OFFICE;
extern const NSString* GP_TYPE_REAL_ESTATE_AGENCY;
extern const NSString* GP_TYPE_RESTAURANT;
extern const NSString* GP_TYPE_ROOFING_CONTRACTOR;
extern const NSString* GP_TYPE_RV_PARK;
extern const NSString* GP_TYPE_SCHOOL;
extern const NSString* GP_TYPE_SHOE_STORE;
extern const NSString* GP_TYPE_SHOPPING_MALL;
extern const NSString* GP_TYPE_SPA;
extern const NSString* GP_TYPE_STADIUM;
extern const NSString* GP_TYPE_STORAGE;
extern const NSString* GP_TYPE_STORE;
extern const NSString* GP_TYPE_SUBWAY_STATION;
extern const NSString* GP_TYPE_SYNAGAGOUE;
extern const NSString* GP_TYPE_TAXI_STAND;
extern const NSString* GP_TYPE_TRAIN_STATION;
extern const NSString* GP_TYPE_TRAVEL_AGENCY;
extern const NSString* GP_TYPE_UNIVERSITY;
extern const NSString* GP_TYPE_VETERINARY_CARE;
extern const NSString* GP_TYPE_ZOO;

/*
 * Symbolic constants for the languages supported by Google Places
 *
 * One of these values is supplied as the value for the language parameter to request that
 * the web service returns results in the specified language
 * See official docs for info on specifying a language -
 * http://code.google.com/apis/maps/documentation/places/#PlaceSearchRequests
 */
extern const NSString* GP_LANG_ARABIC;
extern const NSString* GP_LANG_BASQUE;
extern const NSString* GP_LANG_BULGARIAN;
extern const NSString* GP_LANG_BENGALI;
extern const NSString* GP_LANG_CATALAN;
extern const NSString* GP_LANG_CZECH;
extern const NSString* GP_LANG_DANISH;
extern const NSString* GP_LANG_GERMAN;
extern const NSString* GP_LANG_GREEK;
extern const NSString* GP_LANG_ENGLISH;
extern const NSString* GP_LANG_ENGLISH_AUSTRALIAN;
extern const NSString* GP_LANG_ENGLISH_GREAT_BRITAIN;
extern const NSString* GP_LANG_SPANISH;
extern const NSString* GP_LANG_FARSI;
extern const NSString* GP_LANG_FINNISH;
extern const NSString* GP_LANG_FILIPINO;
extern const NSString* GP_LANG_FRENCH;
extern const NSString* GP_LANG_GALICIAN;
extern const NSString* GP_LANG_GUJARATI;
extern const NSString* GP_LANG_HINDI;
extern const NSString* GP_LANG_CROATIAN;
extern const NSString* GP_LANG_HUNGARIAN;
extern const NSString* GP_LANG_INDONESIAN;
extern const NSString* GP_LANG_ITALIAN;
extern const NSString* GP_LANG_HEBREW;
extern const NSString* GP_LANG_JAPANESE;
extern const NSString* GP_LANG_KANNADA;
extern const NSString* GP_LANG_KOREAN;
extern const NSString* GP_LANG_LITHUANIAN;
extern const NSString* GP_LANG_LATVIAN;
extern const NSString* GP_LANG_MALAYALAM;
extern const NSString* GP_LANG_MARATHI;
extern const NSString* GP_LANG_DUTCH;
extern const NSString* GP_LANG_NORWEGIAN_NYNORSK;
extern const NSString* GP_LANG_NORWEGIAN;
extern const NSString* GP_LANG_ORIYA;
extern const NSString* GP_LANG_POLISH;
extern const NSString* GP_LANG_PORTUGUESE;
extern const NSString* GP_LANG_PORTUGUESE_BRAZIL;
extern const NSString* GP_LANG_PORTUGUESE_PORTUGAL;
extern const NSString* GP_LANG_ROMANSCH;
extern const NSString* GP_LANG_ROMANIAN;
extern const NSString* GP_LANG_RUSSIAN;
extern const NSString* GP_LANG_SLOVAK;
extern const NSString* GP_LANG_SLOVENIAN;
extern const NSString* GP_LANG_SERBIAN;
extern const NSString* GP_LANG_SWEDISH;
extern const NSString* GP_LANG_TAGALOG;
extern const NSString* GP_LANG_TAMIL;
extern const NSString* GP_LANG_TELUGU;
extern const NSString* GP_LANG_THAI;
extern const NSString* GP_LANG_TURKISH;
extern const NSString* GP_LANG_UKRAINIAN;
extern const NSString* GP_LANG_VIETNAMESE;
extern const NSString* GP_LANG_CHINESE_SIMPLIFIED;
extern const NSString* GP_LANG_CHINESE_TRADITIONAL;


extern const NSString* GP_BOOL_TRUE_VALUE;
extern const NSString* GP_BOOL_FALSE_VALUE;