// ** I18N

// Calendar EN language
// Author: Idan Sofer, <idan@idanso.dyndns.org>
// Encoding: UTF-8
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.

// full day names
Calendar._DN = new Array
("专讗砖讜谉",
 "砖谞讬",
 "砖诇讬砖讬",
 "专讘讬注讬",
 "讞诪讬砖讬",
 "砖讬砖讬",
 "砖讘转",
 "专讗砖讜谉");

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
("讗",
 "讘",
 "讙",
 "讚",
 "讛",
 "讜",
 "砖",
 "讗");

// full month names
Calendar._MN = new Array
("讬谞讜讗专",
 "驻讘专讜讗专",
 "诪专抓",
 "讗驻专讬诇",
 "诪讗讬",
 "讬讜谞讬",
 "讬讜诇讬",
 "讗讜讙讜住讟",
 "住驻讟诪讘专",
 "讗讜拽讟讜讘专",
 "谞讜讘诪讘专",
 "讚爪诪讘专");

// short month names
Calendar._SMN = new Array
("讬谞讗",
 "驻讘专",
 "诪专抓",
 "讗驻专",
 "诪讗讬",
 "讬讜谞",
 "讬讜诇",
 "讗讜讙",
 "住驻讟",
 "讗讜拽",
 "谞讜讘",
 "讚爪诪");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "讗讜讚讜转 讛砖谞转讜谉";

Calendar._TT["ABOUT"] =
"讘讞专谉 转讗专讬讱/砖注讛 DHTML\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"讛讙讬专住讗 讛讗讞专讜谞讛 讝诪讬谞讛 讘: http://www.dynarch.com/projects/calendar/\n" +
"诪讜驻抓 转讞转 讝讬讻讬讜谉 讛 GNU LGPL.  注讬讬谉 讘 http://gnu.org/licenses/lgpl.html 诇驻专讟讬诐 谞讜住驻讬诐." +
"\n\n" +
讘讞讬专转 转讗专讬讱:\n" +
"- 讛砖转诪砖 讘讻驻转讜专讬诐 \xab, \xbb 诇讘讞讬专转 砖谞讛\n" +
"- 讛砖转诪砖 讘讻驻转讜专讬诐 " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " 诇讘讞讬专转 讞讜讚砖\n" +
"- 讛讞讝拽 讛注讻讘专 诇讞讜抓 诪注诇 讛讻驻转讜专讬诐 讛诪讜讝讻专讬诐 诇注讬诇 诇讘讞讬专讛 诪讛讬专讛 讬讜转专.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"讘讞讬专转 讝诪谉:\n" +
"- 诇讞抓 注诇 讻诇 讗讞讚 诪讞诇拽讬 讛讝诪谉 讻讚讬 诇讛讜住讬祝\n" +
"- 讗讜 shift 讘砖讬诇讜讘 注诐 诇讞讬爪讛 讻讚讬 诇讛讞住讬专\n" +
"- 讗讜 诇讞抓 讜讙专讜专 诇驻注讜诇讛 诪讛讬专讛 讬讜转专.";

Calendar._TT["PREV_YEAR"] = "砖谞讛 拽讜讚诪转 - 讛讞讝拽 诇拽讘诇转 转驻专讬讟";
Calendar._TT["PREV_MONTH"] = "讞讜讚砖 拽讜讚诐 - 讛讞讝拽 诇拽讘诇转 转驻专讬讟";
Calendar._TT["GO_TODAY"] = "注讘讜专 诇讛讬讜诐";
Calendar._TT["NEXT_MONTH"] = "讞讜讚砖 讛讘讗 - 讛讞讝拽 诇转驻专讬讟";
Calendar._TT["NEXT_YEAR"] = "砖谞讛 讛讘讗讛 - 讛讞讝拽 诇转驻专讬讟";
Calendar._TT["SEL_DATE"] = "讘讞专 转讗专讬讱";
Calendar._TT["DRAG_TO_MOVE"] = "讙专讜专 诇讛讝讝讛";
Calendar._TT["PART_TODAY"] = " )讛讬讜诐(";

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = "讛爪讙 %s 拽讜讚诐";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "6";

Calendar._TT["CLOSE"] = "住讙讜专";
Calendar._TT["TODAY"] = "讛讬讜诐";
Calendar._TT["TIME_PART"] = "(砖讬驻讟-)诇讞抓 讜讙专讜专 讻讚讬 诇砖谞讜转 注专讱";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%a, %b %e";

Calendar._TT["WK"] = "wk";
Calendar._TT["TIME"] = "砖注讛::";
