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

#include "GooglePlacesAPI.h"

// The base URL to which Places requests will be submitted
// NOTE: JSON BY DEFAULT!
const NSString* GP_API_URI = @"https://maps.googleapis.com/maps/api/place/search/json?";

// The textual representations of the boolean values to be used in the request query string
const NSString* GP_BOOL_TRUE_VALUE = @"true";
const NSString* GP_BOOL_FALSE_VALUE = @"false";

// Symbolic constants for request parameter names
const NSString* LOCATION_QUERY_PARAM_NAME = @"location";
const NSString* RADIUS_QUERY_PARAM_NAME = @"radius";
const NSString* IS_GPS_REQUEST_QUERY_PARAM_NAME = @"sensor";
const NSString* API_KEY_QUERY_PARAM_NAME = @"key";
const NSString* PLACE_TYPES_QUERY_PARAM_NAME = @"types";
const NSString* LANGUAGE_QUERY_PARAM_NAME = @"language";
const NSString* PLACE_NAME_QUERY_PARAM_NAME = @"name";

// Delimiter used to separate multiple values in types parameter
const NSString* TYPES_SEPARATOR = @"|";

// Symbolic constants for possible values for the types parameter
const NSString* GP_TYPE_ACCOUNTING = @"accounting";
const NSString* GP_TYPE_AIRPORT = @"airport";
const NSString* GP_TYPE_AMUSEMENT_PARK = @"amusement_park";
const NSString* GP_TYPE_AQUARIUM = @"aquarium";
const NSString* GP_TYPE_ART_GALLERY = @"art_gallery";
const NSString* GP_TYPE_ATM = @"atm";
const NSString* GP_TYPE_BAKERY = @"bakery";
const NSString* GP_TYPE_BANK = @"bank";
const NSString* GP_TYPE_BAR = @"bar";
const NSString* GP_TYPE_BEAUTY_SALON = @"beauty_salon";
const NSString* GP_TYPE_BICYCLE_STORE = @"bicycle_store";
const NSString* GP_TYPE_BOOK_STORE = @"book_store";
const NSString* GP_TYPE_BOWLING_ALLEY = @"bowling_alley";
const NSString* GP_TYPE_BUS_STATION = @"bus_station";
const NSString* GP_TYPE_CAFE = @"cafe";
const NSString* GP_TYPE_CAMPGROUND = @"campground";
const NSString* GP_TYPE_CAR_DEALER = @"car_dealer";
const NSString* GP_TYPE_CAR_RENTAL = @"car_rental";
const NSString* GP_TYPE_CAR_REPAIR = @"car_repair";
const NSString* GP_TYPE_CAR_WASH = @"car_wash";
const NSString* GP_TYPE_CASINO = @"casino";
const NSString* GP_TYPE_CEMETERY = @"cemetery";
const NSString* GP_TYPE_CHURCH = @"church";
const NSString* GP_TYPE_CITY_HALL = @"city_hall";
const NSString* GP_TYPE_CLOTHING_STORE = @"clothing_store";
const NSString* GP_TYPE_CONVENIENCE_STORE = @"convenience_store";
const NSString* GP_TYPE_COURTHOUSE = @"courthouse";
const NSString* GP_TYPE_DENTIST = @"dentist";
const NSString* GP_TYPE_DEPARTMENT_STORE = @"department_store";
const NSString* GP_TYPE_DOCTOR = @"doctor";
const NSString* GP_TYPE_ELECTRICIAN = @"electrician";
const NSString* GP_TYPE_ELECTRONICS_STORE = @"electronics_store";
const NSString* GP_TYPE_EMBASSY = @"embassy";
const NSString* GP_TYPE_ESTABLISHMENT = @"establishment";
const NSString* GP_TYPE_FINANCE = @"finance";
const NSString* GP_TYPE_FIRE_STATION = @"fire_station";
const NSString* GP_TYPE_FLORIST = @"florist";
const NSString* GP_TYPE_FOOD = @"food";
const NSString* GP_TYPE_FUNERAL_HOME = @"funeral_home";
const NSString* GP_TYPE_FURNITURE_STORE = @"furniture_store";
const NSString* GP_TYPE_GAS_STATION = @"gas_station";
const NSString* GP_TYPE_GENERAL_CONTRACTOR = @"general_contractor";
const NSString* GP_TYPE_GEOCODE = @"geocode";
const NSString* GP_TYPE_GROCERY_OR_SUPERMARKET = @"grocery_or_supermarket";
const NSString* GP_TYPE_GYM = @"gym";
const NSString* GP_TYPE_HAIR_CARE = @"hair_care";
const NSString* GP_TYPE_HARDWARE_STORE = @"hardware_store";
const NSString* GP_TYPE_HEALTH = @"health";
const NSString* GP_TYPE_HINDU_TEMPLE = @"hindu_temple";
const NSString* GP_TYPE_HOME_GOODS_STORE = @"home_goods_store";
const NSString* GP_TYPE_HOSPITAL = @"hospital";
const NSString* GP_TYPE_INSURANCE_AGENCY = @"insurance_agency";
const NSString* GP_TYPE_JEWELRY_STORE = @"jewelry_store";
const NSString* GP_TYPE_LAUNDRY = @"laundry";
const NSString* GP_TYPE_LAWYER = @"lawyer";
const NSString* GP_TYPE_LIBRARY = @"library";
const NSString* GP_TYPE_LIQUOR_STORE = @"liquor_store";
const NSString* GP_TYPE_LOCAL_GOVERNMENT_OFFICE = @"local_government_office";
const NSString* GP_TYPE_LOCKSMUTG = @"locksmith";
const NSString* GP_TYPE_LODGING = @"lodging";
const NSString* GP_TYPE_MEAL_DELIVERY = @"meal_delivery";
const NSString* GP_TYPE_MEAL_TAKEAWAY = @"meal_takeaway";
const NSString* GP_TYPE_MOSQUE = @"mosque";
const NSString* GP_TYPE_MOVIE_RENTAL = @"movie_rental";
const NSString* GP_TYPE_MOVIE_THEATER = @"movie_theater";
const NSString* GP_TYPE_MOVIE_COMPANY = @"moving_company";
const NSString* GP_TYPE_MUSEUM = @"museum";
const NSString* GP_TYPE_NIGHT_CLUB = @"night_club";
const NSString* GP_TYPE_PAINTER = @"painter";
const NSString* GP_TYPE_PARK = @"park";
const NSString* GP_TYPE_PARKING = @"parking";
const NSString* GP_TYPE_PET_STORE = @"pet_store";
const NSString* GP_TYPE_PHARMACY = @"pharmacy";
const NSString* GP_TYPE_PHYSIOTHERAPIST = @"physiotherapist";
const NSString* GP_TYPE_PLACE_OF_WORSHIP = @"place_of_worship";
const NSString* GP_TYPE_PLUMBER = @"plumber";
const NSString* GP_TYPE_POLICE = @"police";
const NSString* GP_TYPE_POST_OFFICE = @"post_office";
const NSString* GP_TYPE_REAL_ESTATE_AGENCY = @"real_estate_agency";
const NSString* GP_TYPE_RESTAURANT = @"restaurant";
const NSString* GP_TYPE_ROOFING_CONTRACTOR = @"roofing_contractor";
const NSString* GP_TYPE_RV_PARK = @"rv_park";
const NSString* GP_TYPE_SCHOOL = @"school";
const NSString* GP_TYPE_SHOE_STORE = @"shoe_store";
const NSString* GP_TYPE_SHOPPING_MALL = @"shopping_mall";
const NSString* GP_TYPE_SPA = @"spa";
const NSString* GP_TYPE_STADIUM = @"stadium";
const NSString* GP_TYPE_STORAGE = @"storage";
const NSString* GP_TYPE_STORE = @"store";
const NSString* GP_TYPE_SUBWAY_STATION = @"subway_station";
const NSString* GP_TYPE_SYNAGAGOUE = @"synagogue";
const NSString* GP_TYPE_TAXI_STAND = @"taxi_stand";
const NSString* GP_TYPE_TRAIN_STATION = @"train_station";
const NSString* GP_TYPE_TRAVEL_AGENCY = @"travel_agency";
const NSString* GP_TYPE_UNIVERSITY = @"university";
const NSString* GP_TYPE_VETERINARY_CARE = @"veterinary_care";
const NSString* GP_TYPE_ZOO = @"zoo";

// Symbolic constants for possible values for the language parameter
const NSString* GP_LANG_ARABIC = @"ar";
const NSString* GP_LANG_BASQUE = @"eu";
const NSString* GP_LANG_BULGARIAN = @"bg";
const NSString* GP_LANG_BENGALI = @"bn";
const NSString* GP_LANG_CATALAN = @"ca";
const NSString* GP_LANG_CZECH = @"cs";
const NSString* GP_LANG_DANISH = @"da";
const NSString* GP_LANG_GERMAN = @"de";
const NSString* GP_LANG_GREEK = @"el";
const NSString* GP_LANG_ENGLISH = @"en";
const NSString* GP_LANG_ENGLISH_AUSTRALIAN = @"en-AU";
const NSString* GP_LANG_ENGLISH_GREAT_BRITAIN = @"en-GB";
const NSString* GP_LANG_SPANISH = @"es";
const NSString* GP_LANG_FARSI = @"fa";
const NSString* GP_LANG_FINNISH = @"fi";
const NSString* GP_LANG_FILIPINO = @"fil";
const NSString* GP_LANG_FRENCH = @"fr";
const NSString* GP_LANG_GALICIAN = @"gl";
const NSString* GP_LANG_GUJARATI = @"gu";
const NSString* GP_LANG_HINDI = @"hi";
const NSString* GP_LANG_CROATIAN = @"hr";
const NSString* GP_LANG_HUNGARIAN = @"hu";
const NSString* GP_LANG_INDONESIAN = @"id";
const NSString* GP_LANG_ITALIAN = @"it";
const NSString* GP_LANG_HEBREW = @"iw";
const NSString* GP_LANG_JAPANESE = @"ja";
const NSString* GP_LANG_KANNADA = @"kn";
const NSString* GP_LANG_KOREAN = @"ko";
const NSString* GP_LANG_LITHUANIAN = @"lt";
const NSString* GP_LANG_LATVIAN = @"lv";
const NSString* GP_LANG_MALAYALAM = @"ml";
const NSString* GP_LANG_MARATHI = @"mr";
const NSString* GP_LANG_DUTCH = @"nl";
const NSString* GP_LANG_NORWEGIAN_NYNORSK = @"nn";
const NSString* GP_LANG_NORWEGIAN = @"no";
const NSString* GP_LANG_ORIYA = @"or";
const NSString* GP_LANG_POLISH = @"pl";
const NSString* GP_LANG_PORTUGUESE = @"pt";
const NSString* GP_LANG_PORTUGUESE_BRAZIL = @"pt-BR";
const NSString* GP_LANG_PORTUGUESE_PORTUGAL = @"pt-PT";
const NSString* GP_LANG_ROMANSCH = @"rm";
const NSString* GP_LANG_ROMANIAN = @"ro";
const NSString* GP_LANG_RUSSIAN = @"ru";
const NSString* GP_LANG_SLOVAK = @"sk";
const NSString* GP_LANG_SLOVENIAN = @"sl";
const NSString* GP_LANG_SERBIAN = @"sr";
const NSString* GP_LANG_SWEDISH = @"sv";
const NSString* GP_LANG_TAGALOG = @"tl";
const NSString* GP_LANG_TAMIL = @"ta";
const NSString* GP_LANG_TELUGU = @"te";
const NSString* GP_LANG_THAI = @"th";
const NSString* GP_LANG_TURKISH = @"tr";
const NSString* GP_LANG_UKRAINIAN = @"uk";
const NSString* GP_LANG_VIETNAMESE = @"vi";
const NSString* GP_LANG_CHINESE_SIMPLIFIED = @"zh-CN";
const NSString* GP_LANG_CHINESE_TRADITIONAL = @"zh-TW";