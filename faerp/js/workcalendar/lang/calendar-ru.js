// ** I18N

// Calendar RU language
// Translation: Sly Golovanov, http://golovanov.net, <sly@golovanov.net>
// Encoding: any
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.

// full day names
Calendar._DN = new Array
("胁芯褋泻褉械褋械薪褜械",
 "锌芯薪械写械谢褜薪懈泻",
 "胁褌芯褉薪懈泻",
 "褋褉械写邪",
 "褔械褌胁械褉谐",
 "锌褟褌薪懈褑邪",
 "褋褍斜斜芯褌邪",
 "胁芯褋泻褉械褋械薪褜械");

// Please note that the following array of short day names (and the same goes
// for short month names, _SMN) isn't absolutely necessary.  We give it here
// for exemplification on how one can customize the short day names, but if
// they are simply the first N letters of the full name you can simply say:
//
//   Calendar._SDN_len = N; // short day name length
//   Calendar._SMN_len = N; // short month name length
//
// If N = 3 then this is not needed either since we assume a value of 3 if not
// present, to be compatible with translation files that were written before
// this feature.

// short day names
Calendar._SDN = new Array
("胁褋泻",
 "锌芯薪",
 "胁褌褉",
 "褋褉写",
 "褔械褌",
 "锌褟褌",
 "褋褍斜",
 "胁褋泻");

// full month names
Calendar._MN = new Array
("褟薪胁邪褉褜",
 "褎械胁褉邪谢褜",
 "屑邪褉褌",
 "邪锌褉械谢褜",
 "屑邪泄",
 "懈褞薪褜",
 "懈褞谢褜",
 "邪胁谐褍褋褌",
 "褋械薪褌褟斜褉褜",
 "芯泻褌褟斜褉褜",
 "薪芯褟斜褉褜",
 "写械泻邪斜褉褜");

// short month names
Calendar._SMN = new Array
("褟薪胁",
 "褎械胁",
 "屑邪褉",
 "邪锌褉",
 "屑邪泄",
 "懈褞薪",
 "懈褞谢",
 "邪胁谐",
 "褋械薪",
 "芯泻褌",
 "薪芯褟",
 "写械泻");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "袨 泻邪谢械薪写邪褉械...";

Calendar._TT["ABOUT"] =
"DHTML Date/Time Selector\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"For latest version visit: http://www.dynarch.com/projects/calendar/\n" +
"Distributed under GNU LGPL.  See http://gnu.org/licenses/lgpl.html for details." +
"\n\n" +
"袣邪泻 胁褘斜褉邪褌褜 写邪褌褍:\n" +
"- 袩褉懈 锌芯屑芯褖懈 泻薪芯锌芯泻 \xab, \xbb 屑芯卸薪芯 胁褘斜褉邪褌褜 谐芯写\n" +
"- 袩褉懈 锌芯屑芯褖懈 泻薪芯锌芯泻 " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " 屑芯卸薪芯 胁褘斜褉邪褌褜 屑械褋褟褑\n" +
"- 袩芯写械褉卸懈褌械 褝褌懈 泻薪芯锌泻懈 薪邪卸邪褌褘屑懈, 褔褌芯斜褘 锌芯褟胁懈谢芯褋褜 屑械薪褞 斜褘褋褌褉芯谐芯 胁褘斜芯褉邪.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"袣邪泻 胁褘斜褉邪褌褜 胁褉械屑褟:\n" +
"- 袩褉懈 泻谢懈泻械 薪邪 褔邪褋邪褏 懈谢懈 屑懈薪褍褌邪褏 芯薪懈 褍胁械谢懈褔懈胁邪褞褌褋褟\n" +
"- 锌褉懈 泻谢懈泻械 褋 薪邪卸邪褌芯泄 泻谢邪胁懈褕械泄 Shift 芯薪懈 褍屑械薪褜褕邪褞褌褋褟\n" +
"- 械褋谢懈 薪邪卸邪褌褜 懈 写胁懈谐邪褌褜 屑褘褕泻芯泄 胁谢械胁芯/胁锌褉邪胁芯, 芯薪懈 斜褍写褍褌 屑械薪褟褌褜褋褟 斜褘褋褌褉械械.";

Calendar._TT["PREV_YEAR"] = "袧邪 谐芯写 薪邪蟹邪写 (褍写械褉卸懈胁邪褌褜 写谢褟 屑械薪褞)";
Calendar._TT["PREV_MONTH"] = "袧邪 屑械褋褟褑 薪邪蟹邪写 (褍写械褉卸懈胁邪褌褜 写谢褟 屑械薪褞)";
Calendar._TT["GO_TODAY"] = "小械谐芯写薪褟";
Calendar._TT["NEXT_MONTH"] = "袧邪 屑械褋褟褑 胁锌械褉械写 (褍写械褉卸懈胁邪褌褜 写谢褟 屑械薪褞)";
Calendar._TT["NEXT_YEAR"] = "袧邪 谐芯写 胁锌械褉械写 (褍写械褉卸懈胁邪褌褜 写谢褟 屑械薪褞)";
Calendar._TT["SEL_DATE"] = "袙褘斜械褉懈褌械 写邪褌褍";
Calendar._TT["DRAG_TO_MOVE"] = "袩械褉械褌邪褋泻懈胁邪泄褌械 屑褘褕泻芯泄";
Calendar._TT["PART_TODAY"] = " (褋械谐芯写薪褟)";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "袩械褉胁褘泄 写械薪褜 薪械写械谢懈 斜褍写械褌 %s";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = "袟邪泻褉褘褌褜";
Calendar._TT["TODAY"] = "小械谐芯写薪褟";
Calendar._TT["TIME_PART"] = "(Shift-)泻谢懈泻 懈谢懈 薪邪卸邪褌褜 懈 写胁懈谐邪褌褜";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%e %b, %a";

Calendar._TT["WK"] = "薪械写";
Calendar._TT["TIME"] = "袙褉械屑褟:";
