锘�// ** I18N
Calendar._DN = new Array
("螝蠀蟻喂伪魏萎",
 "螖蔚蠀蟿苇蟻伪",
 "韦蟻委蟿畏",
 "韦蔚蟿维蟻蟿畏",
 "螤苇渭蟺蟿畏",
 "螤伪蟻伪蟽魏蔚蠀萎",
 "危维尾尾伪蟿慰",
 "螝蠀蟻喂伪魏萎");

Calendar._SDN = new Array
("螝蠀",
 "螖蔚",
 "T蟻",
 "韦蔚",
 "螤蔚",
 "螤伪",
 "危伪",
 "螝蠀");

Calendar._MN = new Array
("螜伪谓慰蠀维蟻喂慰蟼",
 "桅蔚尾蟻慰蠀维蟻喂慰蟼",
 "螠维蟻蟿喂慰蟼",
 "螒蟺蟻委位喂慰蟼",
 "螠维蠆慰蟼",
 "螜慰蠉谓喂慰蟼",
 "螜慰蠉位喂慰蟼",
 "螒蠉纬慰蠀蟽蟿慰蟼",
 "危蔚蟺蟿苇渭尾蟻喂慰蟼",
 "螣魏蟿蠋尾蟻喂慰蟼",
 "螡慰苇渭尾蟻喂慰蟼",
 "螖蔚魏苇渭尾蟻喂慰蟼");

Calendar._SMN = new Array
("螜伪谓",
 "桅蔚尾",
 "螠伪蟻",
 "螒蟺蟻",
 "螠伪喂",
 "螜慰蠀谓",
 "螜慰蠀位",
 "螒蠀纬",
 "危蔚蟺",
 "螣魏蟿",
 "螡慰蔚",
 "螖蔚魏");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "螕喂伪 蟿慰 畏渭蔚蟻慰位蠈纬喂慰";

Calendar._TT["ABOUT"] =
"螘蟺喂位慰纬苇伪蟼 畏渭蔚蟻慰渭畏谓委伪蟼/蠋蟻伪蟼 蟽蔚 DHTML\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"螕喂伪 蟿蔚位蔚蠀蟿伪委伪 苇魏未慰蟽畏: http://www.dynarch.com/projects/calendar/\n" +
"Distributed under GNU LGPL.  See http://gnu.org/licenses/lgpl.html for details." +
"\n\n" +
"螘蟺喂位慰纬萎 畏渭蔚蟻慰渭畏谓委伪蟼:\n" +
"- 围蟻畏蟽喂渭慰蟺慰喂蔚委蟽蟿蔚 蟿伪 魏慰蠀渭蟺喂维 \xab, \xbb 纬喂伪 蔚蟺喂位慰纬萎 苇蟿慰蠀蟼\n" +
"- 围蟻畏蟽喂渭慰蟺慰喂蔚委蟽蟿蔚 蟿伪 魏慰蠀渭蟺喂维 " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " 纬喂伪 蔚蟺喂位慰纬萎 渭萎谓伪\n" +
"- 螝蟻伪蟿萎蟽蟿蔚 魏慰蠀渭蟺委 蟺慰谓蟿喂魏慰蠉 蟺伪蟿畏渭苇谓慰 蟽蟿伪 蟺伪蟻伪蟺维谓蠅 魏慰蠀渭蟺喂维 纬喂伪 蟺喂慰 纬蟻萎纬慰蟻畏 蔚蟺喂位慰纬萎.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"螘蟺喂位慰纬萎 蠋蟻伪蟼:\n" +
"- 螝维谓蟿蔚 魏位喂魏 蟽蔚 苇谓伪 伪蟺蠈 蟿伪 渭苇蟻畏 蟿畏蟼 蠋蟻伪蟼 纬喂伪 伪蠉尉畏蟽畏\n" +
"- 萎 Shift-魏位喂魏 纬喂伪 渭蔚委蠅蟽畏\n" +
"- 萎 魏位喂魏 魏伪喂 渭蔚蟿伪魏委谓畏蟽畏 纬喂伪 蟺喂慰 纬蟻萎纬慰蟻畏 蔚蟺喂位慰纬萎.";
Calendar._TT["TOGGLE"] = "螠蟺维蟻伪 蟺蟻蠋蟿畏蟼 畏渭苇蟻伪蟼 蟿畏蟼 蔚尾未慰渭维未伪蟼";
Calendar._TT["PREV_YEAR"] = "螤蟻慰畏纬. 苇蟿慰蟼 (魏蟻伪蟿萎蟽蟿蔚 纬喂伪 蟿慰 渭蔚谓慰蠉)";
Calendar._TT["PREV_MONTH"] = "螤蟻慰畏纬. 渭萎谓伪蟼 (魏蟻伪蟿萎蟽蟿蔚 纬喂伪 蟿慰 渭蔚谓慰蠉)";
Calendar._TT["GO_TODAY"] = "危萎渭蔚蟻伪";
Calendar._TT["NEXT_MONTH"] = "螘蟺蠈渭蔚谓慰蟼 渭萎谓伪蟼 (魏蟻伪蟿萎蟽蟿蔚 纬喂伪 蟿慰 渭蔚谓慰蠉)";
Calendar._TT["NEXT_YEAR"] = "螘蟺蠈渭蔚谓慰 苇蟿慰蟼 (魏蟻伪蟿萎蟽蟿蔚 纬喂伪 蟿慰 渭蔚谓慰蠉)";
Calendar._TT["SEL_DATE"] = "螘蟺喂位苇尉蟿蔚 畏渭蔚蟻慰渭畏谓委伪";
Calendar._TT["DRAG_TO_MOVE"] = "危蠉蟻蟿蔚 纬喂伪 谓伪 渭蔚蟿伪魏喂谓萎蟽蔚蟿蔚";
Calendar._TT["PART_TODAY"] = " (蟽萎渭蔚蟻伪)";
Calendar._TT["MON_FIRST"] = "螘渭蠁维谓喂蟽畏 螖蔚蠀蟿苇蟻伪蟼 蟺蟻蠋蟿伪";
Calendar._TT["SUN_FIRST"] = "螘渭蠁维谓喂蟽畏 螝蠀蟻喂伪魏萎蟼 蟺蟻蠋蟿伪";
Calendar._TT["CLOSE"] = "螝位蔚委蟽喂渭慰";
Calendar._TT["TODAY"] = "危萎渭蔚蟻伪";
Calendar._TT["TIME_PART"] = "(Shift-)魏位喂魏 萎 渭蔚蟿伪魏委谓畏蟽畏 纬喂伪 伪位位伪纬萎";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "dd-mm-y";
Calendar._TT["TT_DATE_FORMAT"] = "D, d M";

Calendar._TT["WK"] = "蔚尾未";

