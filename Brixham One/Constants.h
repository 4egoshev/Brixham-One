//
//  Constants.h
//  Brixham One
//
//  Created by Александр Чегошев on 05.09.17.
//  Copyright © 2017 Александр Чегошев. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

typedef enum {
    SingleChooseType = 0,
    MultiChooseType
}ListType;

typedef  enum {
    SettingsType = 0,
    ViewType
}SaveType;

typedef enum {
    NameType = 0,
    SiteType
}ContentType;

//Router
typedef enum {
    LoginRequest = 0,
    SitesRequest,
    RanksForPeriodRequest,
    RanksRequest
} RequestType;

#define DAY_AGO -86400

#define header_height 65

//TableView
#define SECOND_SECTION 1

#define FIRST_ROW 0
#define SECOND_ROW 1
#define THIRD_ROW 2
#define FOUTH_ROW 3

//NSUserDefaults
#define NAME @"Name"
#define SITE @"Site"
#define NAME_LIST @"NameList"
#define SITE_LIST @"SiteList"
#define NAME_SINGLE_SELECTION_INDEX @"NameSingleSelectedIndex"
#define SITE_SINGLE_SELECTION_INDEX @"SiteSingleSelectedIndex"
#define NAME_MULTI_SELECTION_INDEX @"NameMultiSelectedIndex"
#define SITE_MULTI_SELECTION_INDEX @"SiteMultiSelectedIndex"
#define NAME_SELECTION_INDEX_FOR_LIST @"NameSelectedIndexForList"
#define SITE_SELECTION_INDEX_FOR_LIST @"SiteSelectedIndexForList"

#define DATE @"DateData"

#endif
