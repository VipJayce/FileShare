// ** I18N

// Calendar EN language
// Author: Mihai Bazon, <mihai_bazon@yahoo.com>
// Translation: Yourim Yi <yyi@yourim.net>
// Encoding: EUC-KR
// lang : ko
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.

// full day names

Calendar._DN = new Array
("鞚检殧鞚�",
 "鞗旍殧鞚�",
 "頇旍殧鞚�",
 "靾橃殧鞚�",
 "氇╈殧鞚�",
 "旮堨殧鞚�",
 "韱犾殧鞚�",
 "鞚检殧鞚�");

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
("鞚�",
 "鞗�",
 "頇�",
 "靾�",
 "氇�",
 "旮�",
 "韱�",
 "鞚�");

// full month names
Calendar._MN = new Array
("1鞗�",
 "2鞗�",
 "3鞗�",
 "4鞗�",
 "5鞗�",
 "6鞗�",
 "7鞗�",
 "8鞗�",
 "9鞗�",
 "10鞗�",
 "11鞗�",
 "12鞗�");

// short month names
Calendar._SMN = new Array
("1",
 "2",
 "3",
 "4",
 "5",
 "6",
 "7",
 "8",
 "9",
 "10",
 "11",
 "12");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "calendar 鞐� 雽�頃挫劀";

Calendar._TT["ABOUT"] =
"DHTML Date/Time Selector\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"\n"+
"斓滌嫚 氩勳爠鞚� 氚涭溂鞁滊牑氅� http://www.dynarch.com/projects/calendar/ 鞐� 氚╇頃橃劯鞖擻n" +
"\n"+
"GNU LGPL 霛检澊靹检姢搿� 氚绊彫霅╇媹雼�. \n"+
"霛检澊靹检姢鞐� 雽�頃� 鞛愳劯頃� 雮挫毄鞚� http://gnu.org/licenses/lgpl.html 鞚� 鞚届溂靹胳殧." +
"\n\n" +
"雮犾 靹犿儩:\n" +
"- 鞐半弰毳� 靹犿儩頃橂牑氅� \xab, \xbb 氩勴娂鞚� 靷毄頃╇媹雼n" +
"- 雼潉 靹犿儩頃橂牑氅� " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " 氩勴娂鞚� 雸勲ゴ靹胳殧\n" +
"- 瓿勳啀 雸勲ゴ瓿� 鞛堨溂氅� 鞙� 臧掚摛鞚� 牍犽ゴ瓴� 靹犿儩頃橃嫟 靾� 鞛堨姷雼堧嫟.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"鞁滉皠 靹犿儩:\n" +
"- 毵堨毎鞀る 雸勲ゴ氅� 鞁滉皠鞚� 歃濌皜頃╇媹雼n" +
"- Shift 韨れ檧 頃粯 雸勲ゴ氅� 臧愳唽頃╇媹雼n" +
"- 雸勲ジ 靸來儨鞐愳劀 毵堨毎鞀るゼ 鞗�歆侅澊氅� 膦� 雿� 牍犽ゴ瓴� 臧掛澊 氤�頃╇媹雼�.\n";

Calendar._TT["PREV_YEAR"] = "歆�雮� 頃� (旮戈矊 雸勲ゴ氅� 氇╇)";
Calendar._TT["PREV_MONTH"] = "歆�雮� 雼� (旮戈矊 雸勲ゴ氅� 氇╇)";
Calendar._TT["GO_TODAY"] = "鞓る姌 雮犾搿�";
Calendar._TT["NEXT_MONTH"] = "雼れ潓 雼� (旮戈矊 雸勲ゴ氅� 氇╇)";
Calendar._TT["NEXT_YEAR"] = "雼れ潓 頃� (旮戈矊 雸勲ゴ氅� 氇╇)";
Calendar._TT["SEL_DATE"] = "雮犾毳� 靹犿儩頃橃劯鞖�";
Calendar._TT["DRAG_TO_MOVE"] = "毵堨毎鞀� 霌滊灅攴鸽 鞚措彊 頃橃劯鞖�";
Calendar._TT["PART_TODAY"] = " (鞓る姌)";
Calendar._TT["MON_FIRST"] = "鞗旍殧鞚检潉 頃� 欤检潣 鞁滌瀾 鞖旍澕搿�";
Calendar._TT["SUN_FIRST"] = "鞚检殧鞚检潉 頃� 欤检潣 鞁滌瀾 鞖旍澕搿�";
Calendar._TT["CLOSE"] = "雼赴";
Calendar._TT["TODAY"] = "鞓る姌";
Calendar._TT["TIME_PART"] = "(Shift-)韥措Ν 霕愲姅 霌滊灅攴� 頃橃劯鞖�";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%b/%e [%a]";

Calendar._TT["WK"] = "欤�";
