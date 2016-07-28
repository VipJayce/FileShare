锘�// ** I18N

// Calendar PL language
// Author: Dariusz Pietrzak, <eyck@ghost.anime.pl>
// Author: Janusz Piwowarski, <jpiw@go2.pl>
// Encoding: utf-8
// Distributed under the same terms as the calendar itself.

Calendar._DN = new Array
("Niedziela",
 "Poniedzia艂ek",
 "Wtorek",
 "艢roda",
 "Czwartek",
 "Pi膮tek",
 "Sobota",
 "Niedziela");
Calendar._SDN = new Array
("Nie",
 "Pn",
 "Wt",
 "艢r",
 "Cz",
 "Pt",
 "So",
 "Nie");
Calendar._MN = new Array
("Stycze艅",
 "Luty",
 "Marzec",
 "Kwiecie艅",
 "Maj",
 "Czerwiec",
 "Lipiec",
 "Sierpie艅",
 "Wrzesie艅",
 "Pa藕dziernik",
 "Listopad",
 "Grudzie艅");
Calendar._SMN = new Array
("Sty",
 "Lut",
 "Mar",
 "Kwi",
 "Maj",
 "Cze",
 "Lip",
 "Sie",
 "Wrz",
 "Pa藕",
 "Lis",
 "Gru");

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = "O kalendarzu";

Calendar._TT["ABOUT"] =
"DHTML Date/Time Selector\n" +
"(c) dynarch.com 2002-2005 / Author: Mihai Bazon\n" + // don't translate this this ;-)
"Aby pobra膰 najnowsz膮 wersj臋, odwied藕: http://www.dynarch.com/projects/calendar/\n" +
"Dost臋pny na licencji GNU LGPL. Zobacz szczeg贸艂y na http://gnu.org/licenses/lgpl.html." +
"\n\n" +
"Wyb贸r daty:\n" +
"- U偶yj przycisk贸w \xab, \xbb by wybra膰 rok\n" +
"- U偶yj przycisk贸w " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " by wybra膰 miesi膮c\n" +
"- Przytrzymaj klawisz myszy nad jednym z powy偶szych przycisk贸w dla szybszego wyboru.";
Calendar._TT["ABOUT_TIME"] = "\n\n" +
"Wyb贸r czasu:\n" +
"- Kliknij na jednym z p贸l czasu by zwi臋kszy膰 jego warto艣膰\n" +
"- lub kliknij trzymaj膮c Shift by zmiejszy膰 jego warto艣膰\n" +
"- lub kliknij i przeci膮gnij dla szybszego wyboru.";

//Calendar._TT["TOGGLE"] = "Zmie艅 pierwszy dzie艅 tygodnia";
Calendar._TT["PREV_YEAR"] = "Poprzedni rok (przytrzymaj dla menu)";
Calendar._TT["PREV_MONTH"] = "Poprzedni miesi膮c (przytrzymaj dla menu)";
Calendar._TT["GO_TODAY"] = "Id藕 do dzisiaj";
Calendar._TT["NEXT_MONTH"] = "Nast臋pny miesi膮c (przytrzymaj dla menu)";
Calendar._TT["NEXT_YEAR"] = "Nast臋pny rok (przytrzymaj dla menu)";
Calendar._TT["SEL_DATE"] = "Wybierz dat臋";
Calendar._TT["DRAG_TO_MOVE"] = "Przeci膮gnij by przesun膮膰";
Calendar._TT["PART_TODAY"] = " (dzisiaj)";
Calendar._TT["MON_FIRST"] = "Wy艣wietl poniedzia艂ek jako pierwszy";
Calendar._TT["SUN_FIRST"] = "Wy艣wietl niedziel臋 jako pierwsz膮";
Calendar._TT["CLOSE"] = "Zamknij";
Calendar._TT["TODAY"] = "Dzisiaj";
Calendar._TT["TIME_PART"] = "(Shift-)Kliknij lub przeci膮gnij by zmieni膰 warto艣膰";

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%Y-%m-%d";
Calendar._TT["TT_DATE_FORMAT"] = "%e %B, %A";

Calendar._TT["WK"] = "ty";
