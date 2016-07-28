// ** I18N

// Calendar big5-utf8 language
// Author: Gary Fu, <gary@garyfu.idv.tw>
// Encoding: utf8
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.
	
// full day names
Calendar._DN = new Array
("鏄熸湡鏃�",
 "鏄熸湡涓�",
 "鏄熸湡浜�",
 "鏄熸湡涓�",
 "鏄熸湡鍥�",
 "鏄熸湡浜�",
 "鏄熸湡鍏�",
 "鏄熸湡鏃�");

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
("鏃�",
 "涓�",
 "浜�",
 "涓�",
 "鍥�",
 "浜�",
 "鍏�",
 "鏃�");

// full month names
Calendar._MN = new Array
("涓�鏈�",
 "浜屾湀",
 "涓夋湀",
 "鍥涙湀",
 "浜旀湀",
 "鍏湀",
 "涓冩湀",
 "鍏湀",
 "涔濇湀",
 "鍗佹湀",
 "鍗佷竴鏈�",
 "鍗佷簩鏈�");

// short month names
Calendar._SMN = new Array
("涓�鏈�",
 "浜屾湀",
 "涓夋湀",
 "鍥涙湀",
 "浜旀湀",
 "鍏湀",
 "涓冩湀",
 "鍏湀",
 "涔濇湀",
 "鍗佹湀",
 "鍗佷竴鏈�",
 "鍗佷簩鏈�");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "闂滄柤";

Calendar._TT["ABOUT"] =
"DHTML Date/Time Selector\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"For latest version visit: http://www.dynarch.com/projects/calendar/\n" +
"Distributed under GNU LGPL.  See http://gnu.org/licenses/lgpl.html for details." +
"\n\n" +
"鏃ユ湡閬告搰鏂规硶:\n" +
"- 浣跨敤 \xab, \xbb 鎸夐垥鍙伕鎿囧勾浠絓n" +
"- 浣跨敤 " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " 鎸夐垥鍙伕鎿囨湀浠絓n" +
"- 鎸変綇涓婇潰鐨勬寜閳曞彲浠ュ姞蹇伕鍙�";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"鏅傞枔閬告搰鏂规硶:\n" +
"- 榛炴搳浠讳綍鐨勬檪闁撻儴浠藉彲澧炲姞鍏跺�糪n" +
"- 鍚屾檪鎸塖hift閸靛啀榛炴搳鍙笡灏戝叾鍊糪n" +
"- 榛炴搳涓︽嫋鏇冲彲鍔犲揩鏀硅畩鐨勫��";

Calendar._TT["PREV_YEAR"] = "涓婁竴骞� (鎸変綇閬稿柈)";
Calendar._TT["PREV_MONTH"] = "涓嬩竴骞� (鎸変綇閬稿柈)";
Calendar._TT["GO_TODAY"] = "鍒颁粖鏃�";
Calendar._TT["NEXT_MONTH"] = "涓婁竴鏈� (鎸変綇閬稿柈)";
Calendar._TT["NEXT_YEAR"] = "涓嬩竴鏈� (鎸変綇閬稿柈)";
Calendar._TT["SEL_DATE"] = "閬告搰鏃ユ湡";
Calendar._TT["DRAG_TO_MOVE"] = "鎷栨洺";
Calendar._TT["PART_TODAY"] = " (浠婃棩)";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "灏� %s 椤ず鍦ㄥ墠";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = "闂滈枆";
Calendar._TT["TODAY"] = "浠婃棩";
Calendar._TT["TIME_PART"] = "榛炴搳or鎷栨洺鍙敼璁婃檪闁�(鍚屾檪鎸塖hift鐐烘笡)";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%a, %b %e";

Calendar._TT["WK"] = "閫�";
Calendar._TT["TIME"] = "Time:";
