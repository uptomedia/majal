import 'package:grodudes/models/Category.dart';
import 'package:grodudes/models/Product.dart';

class Constants {
  // APP tabs indexes
  static const HOME_INDEX = 2;

  static String currentLocale = 'en';
  static List<Category> categoryList = [];
  static double maxPrice = 500.0;
  static double minPrice = 0.0;
  static double scale = 1.0;

  static Map<String, String> en = {
    "AF": "Afghanistan",
    "AX": "Åland Islands",
    "AL": "Albania",
    "DZ": "Algeria",
    "AS": "American Samoa",
    "AD": "Andorra",
    "AO": "Angola",
    "AI": "Anguilla",
    "AG": "Antigua and Barbuda",
    "AR": "Argentina",
    "AM": "Armenia",
    "AW": "Aruba",
    "AC": "Ascension Island",
    "AU": "Australia",
    "AT": "Austria",
    "AZ": "Azerbaijan",
    "BS": "Bahamas",
    "BH": "Bahrain",
    "BD": "Bangladesh",
    "BB": "Barbados",
    "BY": "Belarus",
    "BE": "Belgium",
    "BZ": "Belize",
    "BJ": "Benin",
    "BM": "Bermuda",
    "BT": "Bhutan",
    "BO": "Bolivia",
    "BA": "Bosnia and Herzegovina",
    "BW": "Botswana",
    "BR": "Brazil",
    "IO": "British Indian Ocean Territory",
    "VG": "British Virgin Islands",
    "BN": "Brunei",
    "BG": "Bulgaria",
    "BF": "Burkina Faso",
    "BI": "Burundi",
    "KH": "Cambodia",
    "CM": "Cameroon",
    "CA": "Canada",
    "CV": "Cape Verde",
    "BQ": "Caribbean Netherlands",
    "KY": "Cayman Islands",
    "CF": "Central African Republic",
    "TD": "Chad",
    "CL": "Chile",
    "CN": "China",
    "CX": "Christmas Island",
    "CC": "Cocos [Keeling] Islands",
    "CO": "Colombia",
    "KM": "Comoros",
    "CD": "Democratic Republic Congo",
    "CG": "Republic of Congo",
    "CK": "Cook Islands",
    "CR": "Costa Rica",
    "CI": "Côte d'Ivoire",
    "HR": "Croatia",
    "CU": "Cuba",
    "CW": "Curaçao",
    "CY": "Cyprus",
    "CZ": "Czech Republic",
    "DK": "Denmark",
    "DJ": "Djibouti",
    "DM": "Dominica",
    "DO": "Dominican Republic",
    "TL": "East Timor",
    "EC": "Ecuador",
    "EG": "Egypt",
    "SV": "El Salvador",
    "GQ": "Equatorial Guinea",
    "ER": "Eritrea",
    "EE": "Estonia",
    "ET": "Ethiopia",
    "FK": "Falkland Islands [Islas Malvinas]",
    "FO": "Faroe Islands",
    "FJ": "Fiji",
    "FI": "Finland",
    "FR": "France",
    "GF": "French Guiana",
    "PF": "French Polynesia",
    "GA": "Gabon",
    "GM": "Gambia",
    "GE": "Georgia",
    "DE": "Germany",
    "GH": "Ghana",
    "GI": "Gibraltar",
    "GR": "Greece",
    "GL": "Greenland",
    "GD": "Grenada",
    "GP": "Guadeloupe",
    "GU": "Guam",
    "GT": "Guatemala",
    "GG": "Guernsey",
    "GN": "Guinea Conakry",
    "GW": "Guinea-Bissau",
    "GY": "Guyana",
    "HT": "Haiti",
    "HM": "Heard Island and McDonald Islands",
    "HN": "Honduras",
    "HK": "Hong Kong",
    "HU": "Hungary",
    "IS": "Iceland",
    "IN": "India",
    "ID": "Indonesia",
    "IR": "Iran",
    "IQ": "Iraq",
    "IE": "Ireland",
    "IM": "Isle of Man",
    "IL": "Israel",
    "IT": "Italy",
    "JM": "Jamaica",
    "JP": "Japan",
    "JE": "Jersey",
    "JO": "Jordan",
    "KZ": "Kazakhstan",
    "KE": "Kenya",
    "KI": "Kiribati",
    "XK": "Kosovo",
    "KW": "Kuwait",
    "KG": "Kyrgyzstan",
    "LA": "Laos",
    "LV": "Latvia",
    "LB": "Lebanon",
    "LS": "Lesotho",
    "LR": "Liberia",
    "LY": "Libya",
    "LI": "Liechtenstein",
    "LT": "Lithuania",
    "LU": "Luxembourg",
    "MO": "Macau",
    "MK": "Macedonia",
    "MG": "Madagascar",
    "MW": "Malawi",
    "MY": "Malaysia",
    "MV": "Maldives",
    "ML": "Mali",
    "MT": "Malta",
    "MH": "Marshall Islands",
    "MQ": "Martinique",
    "MR": "Mauritania",
    "MU": "Mauritius",
    "YT": "Mayotte",
    "MX": "Mexico",
    "FM": "Micronesia",
    "MD": "Moldova",
    "MC": "Monaco",
    "MN": "Mongolia",
    "ME": "Montenegro",
    "MS": "Montserrat",
    "MA": "Morocco",
    "MZ": "Mozambique",
    "MM": "Myanmar [Burma]",
    "NA": "Namibia",
    "NR": "Nauru",
    "NP": "Nepal",
    "NL": "Netherlands",
    "NC": "New Caledonia",
    "NZ": "New Zealand",
    "NI": "Nicaragua",
    "NE": "Niger",
    "NG": "Nigeria",
    "NU": "Niue",
    "NF": "Norfolk Island",
    "KP": "North Korea",
    "MP": "Northern Mariana Islands",
    "NO": "Norway",
    "OM": "Oman",
    "PK": "Pakistan",
    "PW": "Palau",
    "PS": "Palestinian Territories",
    "PA": "Panama",
    "PG": "Papua New Guinea",
    "PY": "Paraguay",
    "PE": "Peru",
    "PH": "Philippines",
    "PL": "Poland",
    "PT": "Portugal",
    "PR": "Puerto Rico",
    "QA": "Qatar",
    "RE": "Réunion",
    "RO": "Romania",
    "RU": "Russia",
    "RW": "Rwanda",
    "BL": "Saint Barthélemy",
    "SH": "Saint Helena",
    "KN": "St. Kitts",
    "LC": "St. Lucia",
    "MF": "Saint Martin",
    "PM": "Saint Pierre and Miquelon",
    "VC": "St. Vincent",
    "WS": "Samoa",
    "SM": "San Marino",
    "ST": "São Tomé and Príncipe",
    "SA": "Saudi Arabia",
    "SN": "Senegal",
    "RS": "Serbia",
    "SC": "Seychelles",
    "SL": "Sierra Leone",
    "SG": "Singapore",
    "SX": "Sint Maarten",
    "SK": "Slovakia",
    "SI": "Slovenia",
    "SB": "Solomon Islands",
    "SO": "Somalia",
    "ZA": "South Africa",
    "GS": "South Georgia and the South Sandwich Islands",
    "KR": "South Korea",
    "SS": "South Sudan",
    "ES": "Spain",
    "LK": "Sri Lanka",
    "SD": "Sudan",
    "SR": "Suriname",
    "SJ": "Svalbard and Jan Mayen",
    "SZ": "Eswatini",
    "SE": "Sweden",
    "CH": "Switzerland",
    "SY": "Syria",
    "TW": "Taiwan",
    "TJ": "Tajikistan",
    "TZ": "Tanzania",
    "TH": "Thailand",
    "TG": "Togo",
    "TK": "Tokelau",
    "TO": "Tonga",
    "TT": "Trinidad/Tobago",
    "TN": "Tunisia",
    "TR": "Turkey",
    "TM": "Turkmenistan",
    "TC": "Turks and Caicos Islands",
    "TV": "Tuvalu",
    "VI": "U.S. Virgin Islands",
    "UG": "Uganda",
    "UA": "Ukraine",
    "AE": "United Arab Emirates",
    "GB": "United Kingdom",
    "US": "United States",
    "UY": "Uruguay",
    "UZ": "Uzbekistan",
    "VU": "Vanuatu",
    "VA": "Vatican City",
    "VE": "Venezuela",
    "VN": "Vietnam",
    "WF": "Wallis and Futuna",
    "WW": "Worldwide",
    "EH": "Western Sahara",
    "YE": "Yemen",
    "ZM": "Zambia",
    "ZW": "Zimbabwe",
    "search": "Search",
  };
  static Map<String, String> ar = {
    "AF": "أفغانستان",
    "AX": "جزر أولاند",
    "AL": "ألبانيا",
    "DZ": "الجزائر",
    "AS": "ساموا الأمريكية",
    "AD": "أندورا",
    "AO": "أنغولا",
    "AI": "أنغويلا",
    "AG": "أنتيغوا وبربودا",
    "AR": "الأرجنتين",
    "AM": "أرمينيا",
    "AW": "أروبا",
    "AC": "جزيرة أسنسيون",
    "AT": "أستراليا",
    "AU": "النمسا",
    "AZ": "أذربيجان",
    "BS": "باهاماس",
    "BH": "البحرين",
    "BD": "بنغلاديش",
    "BB": "بربادوس",
    "BY": "بيلاروسيا",
    "BE": "بلجيكا",
    "BZ": "بليز",
    "BJ": "بنين",
    "BM": "برمودا",
    "BT": "بوتان",
    "BO": "بوليفيا",
    "BA": "البوسنة والهرسك",
    "BW": "بوتسوانا",
    "BR": "البرازيل",
    "IO": "إقليم المحيط الهندي البريطاني",
    "VG": "جزر العذراء البريطانية",
    "BN": "بروناي",
    "BG": "بلغاريا",
    "BF": "بوركينا فاسو",
    "BI": "بوروندي",
    "KH": "كابو فيردي",
    "CM": "كمبوديا",
    "CA": "الكاميرون",
    "CV": "كندا",
    "BQ": "الجزر الكاريبية الهولندية",
    "KY": "جزر كايمان",
    "CF": "جمهورية أفريقيا الوسطى",
    "TD": "تشاد",
    "CL": "تشيلي",
    "CN": "الصين",
    "CX": "جزيرة الكريسماس",
    "CC": "جزر كوكوس",
    "CO": "كولومبيا",
    "KM": "جزر القمر",
    "CD": "جمهورية الكونغو الديمقراطية",
    "CG": "جمهورية الكونغو",
    "CK": "جزر كوك",
    "CR": "كوستاريكا",
    "CI": "ساحل العاج",
    "HR": "كرواتيا",
    "CU": "كوبا",
    "CW": "كوراساو",
    "CY": "قبرص",
    "CZ": "التشيك",
    "DK": "الدنمارك",
    "DJ": "جيبوتي",
    "DM": "دومينيكا",
    "DO": "جمهورية الدومينيكان",
    "TL": "جمهورية الكونغو الديمقراطية",
    "EC": "الاكوادور",
    "EG": "مصر",
    "SV": "السلفادور",
    "GQ": "غينيا الاستوائية",
    "ER": "إريتريا",
    "EE": "إستونيا",
    "ET": "إثيوبيا",
    "FK": "جزر فوكلاند",
    "FO": "جزر فارو",
    "FJ": "فيجي",
    "FI": "فنلندا",
    "FR": "فرنسا",
    "GF": "غويانا الفرنسية",
    "PF": "بولينزيا الفرنسية",
    "GA": "الجابون",
    "GM": "غامبيا",
    "GE": "جورجيا",
    "DE": "ألمانيا",
    "GH": "غانا",
    "GI": "جبل طارق",
    "GR": "اليونان",
    "GL": "جرينلاند",
    "GD": "غرينادا",
    "GP": "غوادلوب",
    "GU": "غوام",
    "GT": "غواتيمالا",
    "GG": "غيرنزي",
    "GN": "غينيا",
    "GW": "غينيا بيساو",
    "GY": "غيانا",
    "HT": "هايتي",
    "HM": "جزيرة هيرد وجزر ماكدونالد",
    "HN": "هندوراس",
    "HK": "هونج كونج",
    "HU": "هنجاريا",
    "IS": "آيسلندا",
    "IN": "الهند",
    "ID": "أندونيسيا",
    "IR": "إيران",
    "IQ": "العراق",
    "IE": "أيرلندا",
    "IM": "جزيرة مان",
    "IL": "إسرائيل",
    "IT": "إيطاليا",
    "JM": "جامايكا",
    "JP": "اليابان",
    "JE": "جيرسي",
    "JO": "الأردن",
    "KZ": "كازاخستان",
    "KE": "كينيا",
    "KI": "كيريباتي",
    "XK": "كوسوفو",
    "KW": "الكويت",
    "KG": "قيرغيزستان",
    "LA": "لاوس",
    "LV": "لاتفيا",
    "LB": "لبنان",
    "LS": "ليسوتو",
    "LR": "ليبيريا",
    "LY": "ليبيا",
    "LI": "ليختنشتاين",
    "LT": "ليتوانيا",
    "LU": "لوكسمبورغ",
    "MO": "ماكاو",
    "MK": "مقدونيا",
    "MG": "مدغشقر",
    "MW": "مالاوي",
    "MY": "ماليزيا",
    "MV": "المالديف",
    "ML": "مالي",
    "MT": "مالطا",
    "MH": "جزر مارشال",
    "MQ": "مارتينيك",
    "MR": "موريتانيا",
    "MU": "موريشيوس",
    "YT": "مايوت",
    "MX": "المكسيك",
    "FM": "ولايات ميكرونيسيا المتحدة",
    "MD": "مولدوفا",
    "MC": "موناكو",
    "MN": "منغوليا",
    "ME": "مونتينيغرو",
    "MS": "مونتسرات",
    "MA": "المغرب",
    "MZ": "موزمبيق",
    "MM": "ميانمار",
    "NA": "ناميبيا",
    "NR": "ناورو",
    "NP": "نيبال",
    "NL": "هولندا",
    "NC": "كاليدونيا الجديدة",
    "NZ": "نيوزيلندا",
    "NI": "نيكاراغوا",
    "NE": "النيجر",
    "NG": "نيجيريا",
    "NU": "نييوي",
    "NF": "جزيرة نورفولك",
    "KP": "كوريا الشمالية",
    "MP": "جزر ماريانا الشمالية",
    "NO": "النرويج",
    "OM": "سلطنة عمان",
    "PK": "باكستان",
    "PW": "بالاو",
    "PS": "فلسطين",
    "PA": "بنما",
    "PG": "بابوا غينيا الجديدة",
    "PY": "باراغواي",
    "PE": "بيرو",
    "PH": "الفلبين",
    "PL": "بولندا",
    "PT": "البرتغال",
    "PR": "بورتوريكو",
    "QA": "قطر",
    "RE": "ريونيون",
    "RO": "رومانيا",
    "RU": "روسيا",
    "RW": "رواندا",
    "BL": "سان بارتيلمي",
    "SH": "سانت هيلينا",
    "KN": "سانت كيتس ونيفيس",
    "LC": "سانت لوسيا",
    "MF": "سانت مارتن",
    "PM": "سان بيير وميكلون",
    "VC": "سانت فينسنت والغرينادين",
    "WS": "ساموا",
    "SM": "سان مارينو",
    "ST": "ساو تومي وبرينسيب",
    "SA": "السعودية",
    "SN": "السنغال",
    "RS": "صربيا",
    "SC": "سيشل",
    "SL": "سيراليون",
    "SG": "سنغافورة",
    "SX": "سانت مارتن",
    "SK": "سلوفاكيا",
    "SI": "سلوفينيا",
    "SB": "جزر سليمان",
    "SO": "الصومال",
    "ZA": "جنوب أفريقيا",
    "GS": "جورجيا الجنوبية وجزر ساندويتش الجنوبية",
    "KR": "كوريا الجنوبية",
    "SS": "جنوب السودان",
    "ES": "إسبانيا",
    "LK": "سريلانكا",
    "SD": "السودان",
    "SR": "سورينام",
    "SJ": "سفالبارد ويان ماين",
    "SZ": "إسواتيني",
    "SE": "السويد",
    "CH": "سويسرا",
    "SY": "سوريا",
    "TW": "تايوان",
    "TJ": "طاجيكستان",
    "TZ": "تنزانيا",
    "TH": "تايلاند",
    "TG": "توجو",
    "TK": "توكيلاو",
    "TO": "تونغا",
    "TT": "ترينيداد وتوباغو",
    "TN": "تونس",
    "TR": "تركيا",
    "TM": "تركمانستان",
    "TC": "جزر توركس وكايكوس",
    "TV": "توفالو",
    "VI": "جزر العذراء الأمريكية",
    "UG": "أوغندا",
    "UA": "أوكرانيا",
    "AE": "الإمارات العربية المتحدة",
    "GB": "المملكة المتحدة",
    "US": "الولايات المتحدة الأمريكية",
    "UY": "أوروغواي",
    "UZ": "أوزبكستان",
    "VU": "فانواتو",
    "VA": "مدينة الفاتيكان",
    "VE": "فنزويلا",
    "VN": "فيتنام",
    "WF": "واليس وفوتونا",
    "WW": "في جميع أنحاء العالم",
    "EH": "الصحراء الغربية",
    "YE": "اليمن",
    "ZM": "زامبيا",
    "ZW": "زيمبابوي",
    "search": "بحث",
  };

}

// api requests types
/// type of request : [RequestType.POST] or [RequestType.GET]
enum RequestType { GET, POST, PUT, DELETE }

// api requests types
enum ParametersType { Body, Url }
