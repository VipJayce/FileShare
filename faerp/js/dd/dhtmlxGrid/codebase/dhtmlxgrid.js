
var globalActiveDHTMLGridObject;
String.prototype._dhx_trim = function () {
	return this.replace(/&nbsp;/g, " ").replace(/(^[ \t]*)|([ \t]*$)/g, "");
};
function dhtmlxArray(ar) {
	return dhtmlXHeir((ar || new Array()), new _dhtmlxArray());
}
function _dhtmlxArray() {
	return this;
}
_dhtmlxArray.prototype._dhx_find = function (_2) {
	for (var i = 0; i < this.length; i++) {
		if (_2 == this[i]) {
			return i;
		}
	}
	return -1;
};
_dhtmlxArray.prototype._dhx_delAt = function (_4) {
	if (Number(_4) < 0 || this.length == 0) {
		return false;
	}
	for (var i = _4; i < this.length; i++) {
		this[i] = this[i + 1];
	}
	this.length--;
};
_dhtmlxArray.prototype._dhx_insertAt = function (_6, _7) {
	this[this.length] = null;
	for (var i = this.length - 1; i >= _6; i--) {
		this[i] = this[i - 1];
	}
	this[_6] = _7;
};
_dhtmlxArray.prototype._dhx_removeAt = function (_9) {
	for (var i = _9; i < this.length; i++) {
		this[i] = this[i + 1];
	}
	this.length--;
};
_dhtmlxArray.prototype._dhx_swapItems = function (_b, _c) {
	var _d = this[_b];
	this[_b] = this[_c];
	this[_c] = _d;
};
function dhtmlXGridObject(id) {
	if (_isIE) {
		try {
			document.execCommand("BackgroundImageCache", false, true);
		}
		catch (e) {
		}
	}
	if (id) {
		if (typeof (id) == "object") {
			this.entBox = id;
			this.entBox.id = "cgrid2_" + (new Date()).getTime();
		} else {
			this.entBox = document.getElementById(id);
		}
	} else {
		this.entBox = document.createElement("DIV");
		this.entBox.id = "cgrid2_" + (new Date()).getTime();
	}
	this.dhx_Event();
	this._tttag = this._tttag || "rows";
	this._cttag = this._cttag || "cell";
	this._rttag = this._rttag || "row";
	var _f = this;
	this._wcorr = 0;
	this.nm = this.entBox.nm || "grid";
	this.cell = null;
	this.row = null;
	this.editor = null;
	this._f2kE = true;
	this._dclE = true;
	this.combos = new Array(0);
	this.defVal = new Array(0);
	this.rowsAr = new Array(0);
	this.rowsCol = new dhtmlxArray(0);
	this._maskArr = new Array(0);
	this.selectedRows = new dhtmlxArray(0);
	this.rowsBuffer = new Array(new dhtmlxArray(0), new dhtmlxArray(0));
	this.loadedKidsHash = null;
	this.UserData = new Array(0);
	this.styleSheet = document.styleSheets;
	this.entBox.className += " gridbox";
	this.entBox.style.width = this.entBox.getAttribute("width") || (window.getComputedStyle ? (this.entBox.style.width || window.getComputedStyle(this.entBox, null)["width"]) : (this.entBox.currentStyle ? this.entBox.currentStyle["width"] : 0)) || "100%";
	this.entBox.style.height = this.entBox.getAttribute("height") || (window.getComputedStyle ? (this.entBox.style.height || window.getComputedStyle(this.entBox, null)["height"]) : (this.entBox.currentStyle ? this.entBox.currentStyle["height"] : 0)) || "100%";
	this.entBox.style.cursor = "default";
	this.entBox.onselectstart = function () {
		return false;
	};
	this.obj = document.createElement("TABLE");
	this.obj.cellSpacing = 0;
	this.obj.cellPadding = 0;
	this.obj.style.width = "100%";
	this.obj.style.tableLayout = "fixed";
	this.obj.className = "obj";
	this.obj._rows = function (i) {
		return this.rows[i + 1];
	};
	this.obj._rowslength = function () {
		return this.rows.length - 1;
	};
	this.hdr = document.createElement("TABLE");
	this.hdr.style.border = "1px solid gray";
	this.hdr.cellSpacing = 0;
	this.hdr.cellPadding = 0;
	if ((!_isOpera) || (_OperaRv >= 8.5)) {
		this.hdr.style.tableLayout = "fixed";
	}
	this.hdr.className = "hdr";
	this.hdr.width = "100%";
	this.xHdr = document.createElement("TABLE");
	this.xHdr.className = "xhdr";
	this.xHdr.cellPadding = 0;
	this.xHdr.cellSpacing = 0;
	var r = this.xHdr.insertRow(0);
	var c = r.insertCell(0);
	r.insertCell(1).innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	c.appendChild(this.hdr);
	this.objBuf = document.createElement("DIV");
	this.objBuf.appendChild(this.obj);
	this.entCnt = document.createElement("TABLE");
	this.entCnt.insertRow(0).insertCell(0);
	this.entCnt.insertRow(1).insertCell(0);
	this.entCnt.cellPadding = 0;
	this.entCnt.cellSpacing = 0;
	this.entCnt.width = "100%";
	this.entCnt.height = "100%";
	this.entCnt.style.tableLayout = "fixed";
	this.objBox = document.createElement("DIV");
	this.objBox.style.width = "100%";
	this.objBox.style.height = this.entBox.style.height;
	this.objBox.style.overflow = "auto";
	this.objBox.style.position = "relative";
	this.objBox.appendChild(this.objBuf);
	this.objBox.className = "objbox";
	this.hdrBox = document.createElement("DIV");
	this.hdrBox.style.width = "100%";
	if (((_isOpera) && (_OperaRv < 9))) {
		this.hdrSizeA = 25;
	} else {
		this.hdrSizeA = 200;
	}
	this.hdrBox.style.height = this.hdrSizeA + "px";
	if (_isIE) {
		this.hdrBox.style.overflowX = "hidden";
	} else {
		this.hdrBox.style.overflow = "hidden";
	}
	this.hdrBox.style.position = "relative";
	this.hdrBox.appendChild(this.xHdr);
	this.preloadImagesAr = new Array(0);
	this.sortImg = document.createElement("IMG");
	this.sortImg.style.display = "none";
	this.hdrBox.insertBefore(this.sortImg, this.xHdr);
	this.entCnt.rows[0].cells[0].vAlign = "top";
	this.entCnt.rows[0].cells[0].appendChild(this.hdrBox);
	this.entCnt.rows[1].cells[0].appendChild(this.objBox);
	this.entBox.appendChild(this.entCnt);
	this.entBox.grid = this;
	this.objBox.grid = this;
	this.hdrBox.grid = this;
	this.obj.grid = this;
	this.hdr.grid = this;
	this.cellWidthPX = new Array(0);
	this.cellWidthPC = new Array(0);
	this.cellWidthType = this.entBox.cellwidthtype || "px";
	this.delim = this.entBox.delimiter || ",";
	this._csvDelim = ",";
	this.hdrLabels = (this.entBox.hdrlabels || "").split(",");
	this.columnIds = (this.entBox.columnids || "").split(",");
	this.columnColor = (this.entBox.columncolor || "").split(",");
	this.cellType = dhtmlxArray((this.entBox.cellstype || "").split(","));
	this.cellAlign = (this.entBox.cellsalign || "").split(",");
	this.initCellWidth = (this.entBox.cellswidth || "").split(",");
	this.fldSort = (this.entBox.fieldstosort || "").split(",");
	this.imgURL = this.entBox.imagesurl || "gridCfx/";
	this.isActive = false;
	this.isEditable = true;
	this.raNoState = this.entBox.ranostate || null;
	this.chNoState = this.entBox.chnostate || null;
	this.selBasedOn = (this.entBox.selbasedon || "cell").toLowerCase();
	this.selMultiRows = this.entBox.selmultirows || false;
	this.multiLine = this.entBox.multiline || false;
	this.noHeader = this.entBox.noheader || false;
	this.dynScroll = this.entBox.dynscroll || false;
	this.dynScrollPageSize = 0;
	this.dynScrollPos = 0;
	this.xmlFileUrl = this.entBox.xmlfileurl || "";
	this.recordsNoMore = this.entBox.infinitloading || true;
	this.useImagesInHeader = false;
	this.pagingOn = false;
	this.rowsBufferOutSize = 0;
	dhtmlxEvent(window, "unload", function () {
		try {
			_f.destructor();
		}
		catch (e) {
		}
	});
	this.loadXML = function (url, _14) {
		if (this._dload) {
			this._dload = url;
			this._askRealRows(null, _14);
			return true;
		}
		if (this._xmlaR) {
			this.setXMLAutoLoading(url);
		}
		if (url.indexOf("?") != -1) {
			var s = "&";
		} else {
			var s = "?";
		}
		var obj = this;
		this.callEvent("onXLS", [this]);
		if (_14) {
			this.xmlLoader.waitCall = _14;
		}
		this.xmlLoader.loadXML(url + "" + s + "rowsLoaded=" + this.getRowsNum() + "&lastid=" + this.getRowId(this.getRowsNum() - 1));
	};
	this.setSkin = function (_17) {
		this.entBox.className = "gridbox gridbox_" + _17;
		this.enableAlterCss("ev_" + _17, "odd_" + _17, this.isTreeGrid());
		this._fixAlterCss();
		this._sizeFix = this._borderFix = 0;
		switch (_17) {
		  case "clear":
			this._topMb = document.createElement("DIV");
			this._topMb.className = "topMumba";
			this._topMb.innerHTML = "<img style='left:0px'   src='" + this.imgURL + "skinC_top_left.gif'><img style='right:0px' src='" + this.imgURL + "skinC_top_right.gif'>";
			this.entBox.appendChild(this._topMb);
			this._botMb = document.createElement("DIV");
			this._botMb.className = "bottomMumba";
			this._botMb.innerHTML = "<img style='left:0px'   src='" + this.imgURL + "skinD_bottom_left.gif'><img style='right:0px' src='" + this.imgURL + "skinD_bottom_right.gif'>";
			this.entBox.appendChild(this._botMb);
			this.entBox.style.position = "relative";
			this._gcCorr = 20;
			break;
		  case "modern":
		  case "light":
			this.forceDivInHeader = true;
			this._sizeFix = 1;
			break;
		  case "xp":
			this.forceDivInHeader = true;
			this._srdh = 22;
			this._sizeFix = 1;
			break;
		  case "mt":
			this._srdh = 22;
			this._sizeFix = 1;
			this._borderFix = (_isIE ? 1 : 0);
			break;
			break;
		  case "gray":
			if ((_isIE) && (document.compatMode != "BackCompat")) {
				this._srdh = 22;
			}
			this._sizeFix = 1;
			this._borderFix = (_isIE ? 1 : 0);
			break;
		}
		this.setSizes();
	};
	this.loadXMLString = function (str, _19) {
		if (this._dload) {
			this._dloadStr = str;
			this._askRealRows(null, _19);
			return true;
		}
		this.callEvent("onXLS", [this]);
		if (_19) {
			this.xmlLoader.waitCall = _19;
		}
		this.xmlLoader.loadXMLString(str);
	};
	this.doLoadDetails = function (obj) {
		var _1b = _f.xmlLoader.getXMLTopNode(_f._tttag);
		if (_1b.tagName != "DIV") {
			if (_f._refresh_mode) {
				_f._refreshFromXML(_f.xmlLoader);
				_f._refresh_mode = null;
			} else {
				if (!_f.xmlLoader.xmlDoc.nodeName) {
					_f.parseXML(_f.xmlLoader.xmlDoc.responseXML);
				} else {
					_f.parseXML(_f.xmlLoader.xmlDoc);
				}
			}
		}
		if (_f.pagingOn) {
			_f.createPagingBlock();
		}
	};
	this.xmlLoader = new dtmlXMLLoaderObject(this.doLoadDetails, window, true, this.no_cashe);
	if (_isIE) {
		this.preventIECashing(true);
	}
	this.dragger = new dhtmlDragAndDropObject();
	this._doOnScroll = function (e, _1d) {
		this.callEvent("onScroll", [this.objBox.scrollLeft, this.objBox.scrollTop]);
		this.doOnScroll(e, _1d);
	};
	this.doOnScroll = function (e, _1f) {
		this.hdrBox.scrollLeft = this.objBox.scrollLeft;
		if (this.ftr) {
			this.ftr.parentNode.scrollLeft = this.objBox.scrollLeft;
		}
		this.setSortImgPos(null, true);
		if (_1f) {
			return;
		}
		if (!this.pagingOn && this.objBox.scrollTop + this.hdrSizeA + this.objBox.offsetHeight > this.objBox.scrollHeight) {
			if (this._xml_ready && (this.objBox._oldScrollTop != this.objBox.scrollTop) && this.addRowsFromBuffer()) {
				this.objBox.scrollTop = this.objBox.scrollHeight - (this.hdrSizeA + 1 + this.objBox.offsetHeight);
				this.objBox._oldScrollTop = this.objBox.scrollTop;
			}
		}
		if (this._dload) {
			if (this._dLoadTimer) {
				window.clearTimeout(this._dLoadTimer);
			}
			this._dLoadTimer = window.setTimeout(function () {
				_f._askRealRows();
			}, 500);
		}
	};
	this.attachToObject = function (obj) {
		obj.appendChild(this.entBox);
		this.objBox.style.height = this.entBox.style.height;
	};
	this.init = function (fl) {
		if ((this.isTreeGrid()) && (!this._h2)) {
			this._aEx = new _dhtmlxArray();
			this._h2 = new dhtmlxHierarchy();
			if ((this._fake) && (!this._realfake)) {
				this._fake._h2 = this._h2;
			}
			this._tgc = {imgURL:null};
		}
		if (!this._hstyles) {
			return;
		}
		this.editStop();
		this.lastClicked = null;
		this.resized = null;
		this.fldSorted = this.r_fldSorted = null;
		this.gridWidth = 0;
		this.gridHeight = 0;
		this.cellWidthPX = new Array(0);
		this.cellWidthPC = new Array(0);
		if (this.hdr.rows.length > 0) {
			this.clearAll(true);
		}
		if (this.cellType._dhx_find("tree") != -1) {
			this.loadedKidsHash = new Hashtable();
			this.loadedKidsHash.put("hashOfParents", new Hashtable());
		}
		var _22 = this.hdr.insertRow(0);
		for (var i = 0; i < this.hdrLabels.length; i++) {
			_22.appendChild(document.createElement("TH"));
			_22.childNodes[i]._cellIndex = i;
			_22.childNodes[i].style.height = "0px";
		}
		if (_isIE) {
			_22.style.position = "absolute";
		} else {
			_22.style.height = "auto";
		}
		var _22 = this.hdr.insertRow(_isKHTML ? 2 : 1);
		_22._childIndexes = new Array();
		var _24 = 0;
		for (var i = 0; i < this.hdrLabels.length; i++) {
			_22._childIndexes[i] = i - _24;
			if ((this.hdrLabels[i] == this.splitSign) && (i != 0)) {
				if (_isKHTML) {
					_22.insertCell(i - _24);
				}
				_22.cells[i - _24 - 1].colSpan = (_22.cells[i - _24 - 1].colSpan || 1) + 1;
				_22.childNodes[i - _24 - 1]._cellIndex++;
				_24++;
				_22._childIndexes[i] = i - _24;
				continue;
			}
			_22.insertCell(i - _24);
			_22.childNodes[i - _24]._cellIndex = i;
			_22.childNodes[i - _24]._cellIndexS = i;
			this.setHeaderCol(i, this.hdrLabels[i]);
		}
		if (_24 == 0) {
			_22._childIndexes = null;
		}
		this._cCount = this.hdrLabels.length;
		if (_isIE) {
			window.setTimeout(function () {
				_f.setSizes();
			}, 1);
		}
		if (!this.obj.firstChild) {
			this.obj.appendChild(document.createElement("TBODY"));
		}
		var tar = this.obj.firstChild;
		if (!tar.firstChild) {
			tar.appendChild(document.createElement("TR"));
			tar = tar.firstChild;
			if (_isIE) {
				tar.style.position = "absolute";
			} else {
				tar.style.height = "auto";
			}
			for (var i = 0; i < this.hdrLabels.length; i++) {
				tar.appendChild(document.createElement("TH"));
				tar.childNodes[i].style.height = "0px";
			}
		}
		this.setColumnIds();
		this._c_order = null;
		if (this.multiLine == -1) {
			this.multiLine = true;
		}
		if (this.multiLine != true) {
			this.obj.className += " row20px";
		}
		this.sortImg.style.position = "absolute";
		this.sortImg.style.display = "none";
		this.sortImg.src = this.imgURL + "sort_desc.gif";
		this.sortImg.defLeft = 0;
		this.entCnt.rows[0].style.display = "";
		if (this.noHeader) {
			this.entCnt.rows[0].style.display = "none";
		} else {
			this.noHeader = false;
		}
		if (this._ivizcol) {
			this.setColHidden();
		}
		this.attachHeader();
		this.attachHeader(0, 0, "_aFoot");
		this.setSizes();
		if (fl) {
			this.parseXML();
		}
		this.obj.scrollTop = 0;
		if (this.dragAndDropOff) {
			this.dragger.addDragLanding(this.entBox, this);
		}
		if (this._initDrF) {
			this._initD();
		}
	};
	this.setSizes = function (fl) {
		if ((!this.hdr.rows[0])) {
			return;
		}
		if (!this.entBox.offsetWidth) {
			if (this._sizeTime) {
				window.clearTimeout(this._sizeTime);
			}
			this._sizeTime = window.setTimeout(function () {
				_f.setSizes();
			}, 250);
			return;
		}
		if (((_isFF) && (this.entBox.style.height == "100%")) || (this._fixLater)) {
			this.entBox.style.height = this.entBox.parentNode.clientHeight;
			this._fixLater = true;
		}
		if (fl && this.gridWidth == this.entBox.offsetWidth && this.gridHeight == this.entBox.offsetHeight) {
			return false;
		} else {
			if (fl) {
				this.gridWidth = this.entBox.offsetWidth;
				this.gridHeight = this.entBox.offsetHeight;
			}
		}
		if ((!this.hdrBox.offsetHeight) && (this.hdrBox.offsetHeight > 0)) {
			this.entCnt.rows[0].cells[0].height = this.hdrBox.offsetHeight + "px";
		}
		var _27 = parseInt(this.entBox.offsetWidth) - (this._gcCorr || 0);
		var _28 = parseInt(this.entBox.offsetHeight) - ((!_isIE) ? (this._sizeFix || 0) : 0);
		var _29 = (this.objBox.scrollHeight > this.objBox.offsetHeight);
		if (((!this._ahgr) && (_29)) || ((this._ahgrM) && (this._ahgrM < this.objBox.scrollHeight))) {
			_27 -= (this._scrFix || (_isFF ? 19 : 16));
		}
		var len = this.hdr.rows[0].cells.length;
		for (var i = 0; i < this._cCount; i++) {
			if (this.cellWidthType == "px" && this.cellWidthPX.length < len) {
				this.cellWidthPX[i] = this.initCellWidth[i] - this._wcorr;
			} else {
				if (this.cellWidthType == "%" && this.cellWidthPC.length < len) {
					this.cellWidthPC[i] = this.initCellWidth[i];
				}
			}
			if (this.cellWidthType == "%" && this.cellWidthPC.length != 0) {
				this.cellWidthPX[i] = parseInt(_27 * this.cellWidthPC[i] / 100);
			}
		}
		var _2c = this.entBox.offsetWidth - this.entBox.clientWidth;
		var _2d = 0;
		var _2e = new Array();
		for (var i = 0; i < this._cCount; i++) {
			if ((this.initCellWidth[i] == "*") && ((!this._hrrar) || (!this._hrrar[i]))) {
				_2e[_2e.length] = i;
			} else {
				_2d += parseInt(this.cellWidthPX[i]);
			}
		}
		if (_2e.length) {
			var ms = Math.floor((_27 - _2d - 1 - _2c) / _2e.length);
			if (ms < 0) {
				ms = 1;
			}
			for (var i = 0; i < _2e.length; i++) {
				var min = (this._drsclmW ? this._drsclmW[_2e[i]] : 0);
				this.cellWidthPX[_2e[i]] = (min ? (min > ms ? min : ms) : ms) - this._wcorr;
				_2d += ms;
			}
		}
		var _2d = 0;
		for (var i = 0; i < this._cCount; i++) {
			_2d += parseInt(this.cellWidthPX[i]);
		}
		if (_isOpera) {
			_2d -= 1;
		}
		this.chngCellWidth();
		if ((this._awdth) && (this._awdth[0])) {
			if (this.cellWidthType == "%") {
				this.cellWidthType = "px";
				this.cellWidthPC = [];
			}
			var gs = (_2d > this._awdth[1] ? this._awdth[1] : (_2d < this._awdth[2] ? this._awdth[2] : _2d));
			this.entBox.style.width = gs + (_29 ? (_isFF ? 20 : 18) : 0) + "px";
		}
		this.objBuf.style.width = _2d + "px";
		if ((this.ftr) && (!this._realfake)) {
			this.ftr.style.width = _2d + "px";
		}
		this.objBuf.childNodes[0].style.width = _2d + "px";
		this.doOnScroll(0, 1);
		this.hdr.style.border = "0px solid gray";
		var _32 = this.hdr.offsetHeight + (this._borderFix ? this._borderFix : 0);
		if (this.ftr) {
			_32 += this.ftr.offsetHeight;
		}
		if (this._ahgr) {
			if (this.objBox.scrollHeight) {
				if (_isIE) {
					var z2 = this.objBox.scrollHeight;
				} else {
					var z2 = this.objBox.childNodes[0].scrollHeight;
				}
				var _34 = ((this.objBox.offsetWidth < this.objBox.scrollWidth) ? (_isFF ? 20 : 18) : 1);
				if (this._ahgrMA) {
					z2 = this.entBox.parentNode.offsetHeight - _32 - _34 - (this._sizeFix ? this._sizeFix : 0) * 2;
				}
				if (((this._ahgrM) && ((this._ahgrF ? (z2 + _32 + _34) : z2) > this._ahgrM))) {
					_28 = this._ahgrM * 1 + (this._ahgrF ? 0 : (_32 + _34));
				} else {
					_28 = z2 + _32 + _34;
				}
				this.entBox.style.height = _28 + "px";
			}
		}
		if (this.ftr) {
			_32 -= this.ftr.offsetHeight;
		}
		var _35 = this.entCnt.rows[1].cells[0].childNodes[0];
		if (!this.noHeader) {
			_35.style.top = (_32 - this.hdrBox.offsetHeight + (_isFF ? 0 : (-_2c))) + "px";
		}
		if (this._topMb) {
			this._topMb.style.top = (_32 || 0) + "px";
			this._topMb.style.width = (_27 + 20) + "px";
		}
		if (this._botMb) {
			this._botMb.style.top = (_28 - 3) + "px";
			this._botMb.style.width = (_27 + 20) + "px";
		}
		_35.style.height = (((_28 - _32 - 1) < 0 && _isIE) ? 20 : (_28 - _32 - 1)) - (this.ftr ? this.ftr.offsetHeight : 0) + "px";
		if (this.ftr && this.entBox.offsetHeight > this.ftr.offsetHeight) {
			this.entCnt.style.height = this.entBox.offsetHeight - this.ftr.offsetHeight + "px";
		}
		if (this._dload) {
			this._dloadSize = Math.floor(parseInt(this.entBox.offsetHeight) / 20) + (_isKHTML ? 4 : 2);
		}
	};
	this.chngCellWidth = function () {
		if ((_isOpera) && (this.ftr)) {
			this.ftr.width = this.objBox.scrollWidth + "px";
		}
		var l = this._cCount;
		for (var i = 0; i < l; i++) {
			this.hdr.rows[0].cells[i].style.width = this.cellWidthPX[i] + "px";
			this.obj.rows[0].childNodes[i].style.width = this.cellWidthPX[i] + "px";
			if (this.ftr) {
				this.ftr.rows[0].cells[i].style.width = this.cellWidthPX[i] + "px";
			}
		}
	};
	this.setDelimiter = function (_38) {
		this.delim = _38;
	};
	this.setInitWidthsP = function (wp) {
		this.cellWidthType = "%";
		this.initCellWidth = wp.split(this.delim.replace(/px/gi, ""));
		this._setAutoResize();
	};
	this._setAutoResize = function () {
		var el = window;
		var _3b = this;
		if (el.addEventListener) {
			if ((_isFF) && (_FFrv < 1.8)) {
				el.addEventListener("resize", function () {
					if (!_3b.entBox) {
						return;
					}
					var z = _3b.entBox.style.width;
					_3b.entBox.style.width = "1px";
					window.setTimeout(function () {
						_3b.entBox.style.width = z;
						_3b.setSizes();
					}, 10);
				}, false);
			} else {
				el.addEventListener("resize", function () {
					if (_3b.setSizes) {
						_3b.setSizes();
					}
				}, false);
			}
		} else {
			if (el.attachEvent) {
				el.attachEvent("onresize", function () {
					if (_3b._resize_timer) {
						window.clearTimeout(_3b._resize_timer);
					}
					if (_3b.setSizes) {
						_3b._resize_timer = window.setTimeout(function () {
							_3b.setSizes();
						}, 500);
					}
				});
			}
		}
		this._setAutoResize = function () {
		};
	};
	this.setInitWidths = function (wp) {
		this.cellWidthType = "px";
		this.initCellWidth = wp.split(this.delim);
		if (_isFF) {
			for (var i = 0; i < this.initCellWidth.length; i++) {
				if (this.initCellWidth[i] != "*") {
					this.initCellWidth[i] = parseInt(this.initCellWidth[i]) - 2;
				}
			}
		}
	};
	this.enableMultiline = function (_3f) {
		this.multiLine = convertStringToBoolean(_3f);
	};
	this.enableMultiselect = function (_40) {
		this.selMultiRows = convertStringToBoolean(_40);
	};
	this.setImagePath = function (_41) {
		this.imgURL = _41;
	};
	this.changeCursorState = function (ev) {
		var el = ev.target || ev.srcElement;
		if (el.tagName != "TD") {
			el = this.getFirstParentOfType(el, "TD");
		}
		if ((el.tagName == "TD") && (this._drsclmn) && (!this._drsclmn[el._cellIndex])) {
			return;
		}
		var _44 = ev.layerX + (((!_isIE) && (ev.target.tagName == "DIV")) ? el.offsetLeft : 0);
		if ((el.offsetWidth - (ev.offsetX || (parseInt(this.getPosition(el, this.hdrBox)) - _44) * -1)) < 10) {
			el.style.cursor = "E-resize";
		} else {
			el.style.cursor = "default";
		}
		if (_isOpera) {
			this.hdrBox.scrollLeft = this.objBox.scrollLeft;
		}
	};
	this.startColResize = function (ev) {
		this.resized = null;
		var el = ev.target || ev.srcElement;
		if (el.tagName != "TD") {
			el = this.getFirstParentOfType(el, "TD");
		}
		var x = ev.clientX;
		var _48 = this.hdr.offsetWidth;
		var _49 = parseInt(el.offsetWidth);
		if (el.tagName == "TD" && el.style.cursor != "default") {
			if ((this._drsclmn) && (!this._drsclmn[el._cellIndex])) {
				return;
			}
			this.entBox.onmousemove = function (e) {
				this.grid.doColResize(e || window.event, el, _49, x, _48);
			};
			document.body.onmouseup = new Function("", "document.getElementById('" + this.entBox.id + "').grid.stopColResize()");
		}
	};
	this.stopColResize = function () {
		this.entBox.onmousemove = "";
		document.body.onmouseup = "";
		this.setSizes();
		this.doOnScroll(0, 1);
		this.callEvent("onResizeEnd", [this]);
	};
	this.doColResize = function (ev, el, _4d, x, _4f) {
		el.style.cursor = "E-resize";
		this.resized = el;
		var _50 = _4d + (ev.clientX - x);
		var _51 = _4f + (ev.clientX - x);
		if (!(this.callEvent("onResize", [el._cellIndex, _50, this]))) {
			return;
		}
		if (el.colSpan > 1) {
			var _52 = new Array();
			for (var i = 0; i < el.colSpan; i++) {
				_52[i] = Math.round(_50 * this.hdr.rows[0].childNodes[el._cellIndexS + i].offsetWidth / el.offsetWidth);
			}
			for (var i = 0; i < el.colSpan; i++) {
				this._setColumnSizeR(el._cellIndexS + i * 1, _52[i]);
			}
		} else {
			this._setColumnSizeR(el._cellIndex, _50);
		}
		this.doOnScroll(0, 1);
		if (_isOpera) {
			this.setSizes();
		}
		this.objBuf.childNodes[0].style.width = "";
	};
	this._setColumnSizeR = function (ind, _55) {
		if (_55 > (this._drsclmW ? (this._drsclmW[ind] || 10) : 10)) {
			this.obj.firstChild.firstChild.childNodes[ind].style.width = _55 + "px";
			this.hdr.rows[0].childNodes[ind].style.width = _55 + "px";
			if (this.ftr) {
				this.ftr.rows[0].childNodes[ind].style.width = _55 + "px";
			}
			if (this.cellWidthType == "px") {
				this.cellWidthPX[ind] = _55;
			} else {
				var _56 = parseInt(this.entBox.offsetWidth);
				if (this.objBox.scrollHeight > this.objBox.offsetHeight) {
					_56 -= (this._scrFix || (_isFF ? 19 : 16));
				}
				var _57 = Math.round(_55 / _56 * 100);
				this.cellWidthPC[ind] = _57;
			}
		}
	};
	this.setSortImgState = function (_58, ind, _5a, row) {
		_5a = (_5a || "asc").toLowerCase();
		if (!convertStringToBoolean(_58)) {
			this.sortImg.style.display = "none";
			return;
		}
		if (_5a == "asc") {
			this.sortImg.src = this.imgURL + "sort_asc.gif";
		} else {
			this.sortImg.src = this.imgURL + "sort_desc.gif";
		}
		this.sortImg.style.display = "";
		this.fldSorted = this.hdr.rows[0].cells[ind];
		this.r_fldSorted = this.hdr.rows[row || 1].cells[ind];
		this.setSortImgPos(ind);
	};
	this.setSortImgPos = function (ind, _5d, _5e, el) {
		if (!el) {
			if (!ind) {
				var el = this.r_fldSorted;
			} else {
				var el = this.hdr.rows[_5e || 0].cells[ind];
			}
		}
		if (el != null) {
			var pos = this.getPosition(el, this.hdrBox);
			var _61 = el.offsetWidth;
			this.sortImg.style.left = Number(pos[0] + _61 - 13) + "px";
			this.sortImg.defLeft = parseInt(this.sortImg.style.left);
			this.sortImg.style.top = Number(pos[1] + 5) + "px";
			if ((!this.useImagesInHeader) && (!_5d)) {
				this.sortImg.style.display = "inline";
			}
			this.sortImg.style.left = this.sortImg.defLeft + "px";
		}
	};
	this.setActive = function (fl) {
		if (arguments.length == 0) {
			var fl = true;
		}
		if (fl == true) {
			if (globalActiveDHTMLGridObject && (globalActiveDHTMLGridObject != this)) {
				globalActiveDHTMLGridObject.editStop();
			}
			globalActiveDHTMLGridObject = this;
			this.isActive = true;
		} else {
			this.isActive = false;
		}
	};
	this._doClick = function (ev) {
		var _64 = 0;
		var el = this.getFirstParentOfType(_isIE ? ev.srcElement : ev.target, "TD");
		var fl = true;
		if (this.selMultiRows != false) {
			if (ev.shiftKey && this.row != null) {
				_64 = 1;
			}
			if (ev.ctrlKey) {
				_64 = 2;
			}
		}
		this.doClick(el, fl, _64);
	};
	this._doContClick = function (ev) {
		var el = this.getFirstParentOfType(_isIE ? ev.srcElement : ev.target, "TD");
		if ((!el) || (typeof (el.parentNode.idd) == "undefined")) {
			return true;
		}
		if (ev.button == 2) {
			if (!this.callEvent("onRightClick", [el.parentNode.idd, el._cellIndex, ev])) {
				var z = function (e) {
					document.body.oncontextmenu = Function("return true;");
					(e || event).cancelBubble = true;
					return false;
				};
				if (_isIE) {
					ev.srcElement.oncontextmenu = z;
				} else {
					if (!_isMacOS) {
						document.body.oncontextmenu = z;
					}
				}
				return false;
			}
			if (this._ctmndx) {
				if (!(this.callEvent("onBeforeContextMenu", [el.parentNode.idd, el._cellIndex, this]))) {
					return true;
				}
				el.contextMenuId = el.parentNode.idd + "_" + el._cellIndex;
				el.contextMenu = this._ctmndx;
				el.a = this._ctmndx._contextStart;
				if (_isIE) {
					ev.srcElement.oncontextmenu = function () {
						event.cancelBubble = true;
						return false;
					};
				}
				el.a(el, ev);
				el.a = null;
			}
		} else {
			if (this._ctmndx) {
				this._ctmndx._contextEnd();
			}
		}
		return true;
	};
	this.doClick = function (el, fl, _6d, _6e) {
		var _6f = this.row ? this.row.idd : 0;
		this.setActive(true);
		if (!_6d) {
			_6d = 0;
		}
		if (this.cell != null) {
			this.cell.className = this.cell.className.replace(/cellselected/g, "");
		}
		if (el.tagName == "TD" && (this.rowsCol._dhx_find(this.rowsAr[el.parentNode.idd]) != -1 || this.rowsBuffer[0]._dhx_find(el.parentNode.idd) != -1)) {
			if (this.checkEvent("onSelectStateChanged")) {
				var _70 = this.getSelectedId();
			}
			var _71 = this.row;
			if (_6d == 0) {
				this.clearSelection();
			} else {
				if (_6d == 1) {
					var _72 = this.rowsCol._dhx_find(el.parentNode);
					var _73 = this.rowsCol._dhx_find(this.lastClicked);
					if (_72 > _73) {
						var _74 = _73;
						var end = _72;
					} else {
						var _74 = _72;
						var end = _73;
					}
					for (var i = 0; i < this.rowsCol.length; i++) {
						if ((i >= _74 && i <= end)) {
							if (this.rowsCol[i] && (!this.rowsCol[i]._sRow)) {
								if (this.rowsCol[i].className.indexOf("rowselected") == -1 && this.callEvent("onBeforeSelect", [this.rowsCol[i].idd, _6f])) {
									this.rowsCol[i].className += " rowselected";
									this.selectedRows[this.selectedRows.length] = this.rowsCol[i];
								}
							} else {
								this.clearSelection();
								return this.doClick(el, fl, 0, _6e);
							}
						}
					}
				} else {
					if (_6d == 2) {
						if (el.parentNode.className.indexOf("rowselected") != -1) {
							el.parentNode.className = el.parentNode.className.replace(/rowselected/g, "");
							this.selectedRows._dhx_removeAt(this.selectedRows._dhx_find(el.parentNode));
							var _77 = true;
						}
					}
				}
			}
			this.editStop();
			this.cell = el;
			if ((_71 == el.parentNode) && (this._chRRS)) {
				fl = false;
			}
			if (typeof (el.parentNode.idd) == "undefined") {
				return true;
			}
			this.row = el.parentNode;
			if ((!_77) && (!this.row._sRow)) {
				if (this.callEvent("onBeforeSelect", [this.row.idd, _6f])) {
					this.row.className += " rowselected";
					if (this.selectedRows._dhx_find(this.row) == -1) {
						this.selectedRows[this.selectedRows.length] = this.row;
					}
				} else {
					this.row = _71;
				}
			}
			if (this.selBasedOn == "cell") {
				if (this.cell.parentNode.className.indexOf("rowselected") != -1) {
					this.cell.className = this.cell.className.replace(/cellselected/g, "") + " cellselected";
				}
			}
			if (_6d != 1) {
				if (!this.row) {
					return;
				}
			}
			this.lastClicked = el.parentNode;
			var rid = this.row.idd;
			var cid = this.cell.cellIndex;
			if (fl) {
				setTimeout(function () {
					_f.callEvent("onRowSelect", [rid, cid]);
				}, 100);
			}
			if (this.checkEvent("onSelectStateChanged")) {
				var _7a = this.getSelectedId();
				if (_70 != _7a) {
					this.callEvent("onSelectStateChanged", [_7a]);
				}
			}
		}
		this.isActive = true;
		if (_6e !== false) {
			this.moveToVisible(this.cell);
		}
	};
	this.selectAll = function () {
		this.clearSelection();
		this.selectedRows = ([]).concat(this.rowsCol);
		if (this.selectedRows.length) {
			this.row = this.selectedRows[0];
			this.cell = this.row.cells[0];
		}
		for (var i = 0; i < this.rowsCol.length; i++) {
			this.rowsCol[i].className += " rowselected";
		}
		if ((this._fake) && (!this._realfake)) {
			this._fake.selectAll();
		}
	};
	this.selectCell = function (r, _7d, fl, _7f, _80, _81) {
		if (!fl) {
			fl = false;
		}
		if (typeof (r) != "object") {
			r = this.rowsCol[r];
		}
		if (r._childIndexes) {
			var c = r.childNodes[r._childIndexes[_7d]];
		} else {
			var c = r.childNodes[_7d];
		}
		if (_7f) {
			this.doClick(c, fl, 3, _81);
		} else {
			this.doClick(c, fl, 0, _81);
		}
		if (_80) {
			this.editCell();
		}
	};
	this.moveToVisible = function (_83, _84) {
		try {
			var _85 = _83.offsetLeft + _83.offsetWidth + 20;
			if (_85 > (this.objBox.offsetWidth + this.objBox.scrollLeft)) {
				var _86 = _85 - this.objBox.offsetWidth;
			} else {
				if (_83.offsetLeft < this.objBox.scrollLeft) {
					var _86 = _83.offsetLeft - 5;
				}
			}
			if ((_86) && (!_84)) {
				this.objBox.scrollLeft = _86;
			}
			var _85 = _83.offsetTop + _83.offsetHeight + 20;
			if (_85 > (this.objBox.offsetHeight + this.objBox.scrollTop)) {
				var _87 = _85 - this.objBox.offsetHeight;
			} else {
				if (_83.offsetTop < this.objBox.scrollTop) {
					var _87 = _83.offsetTop - 5;
				}
			}
			if (_87) {
				this.objBox.scrollTop = _87;
			}
		}
		catch (er) {
		}
	};
	this.editCell = function () {
		this.editStop();
		if ((this.isEditable != true) || (!this.cell)) {
			return false;
		}
		var c = this.cell;
		if (c.parentNode._locked) {
			return false;
		}
		this.editor = this.cells4(c);
		if (this.editor != null) {
			if (this.editor.isDisabled()) {
				this.editor = null;
				return false;
			}
			if (this.callEvent("onEditCell", [0, this.row.idd, this.cell._cellIndex]) != false) {
				this._Opera_stop = (new Date).valueOf();
				c.className += " editable";
				this.editor.edit();
				this.callEvent("onEditCell", [1, this.row.idd, this.cell._cellIndex]);
			} else {
				this.editor = null;
			}
		}
	};
	this.editStop = function () {
		if (_isOpera) {
			if (this._Opera_stop) {
				if ((this._Opera_stop * 1 + 50) > (new Date).valueOf()) {
					return;
				}
				this._Opera_stop = null;
			}
		}
		if (this.editor && this.editor != null) {
			this.cell.className = this.cell.className.replace("editable", "");
			if (this.editor.detach()) {
				this.cell.wasChanged = true;
			}
			var g = this.editor;
			this.editor = null;
			var z = this.callEvent("onEditCell", [2, this.row.idd, this.cell._cellIndex, g.getValue(), g.val]);
			if ((typeof (z) == "string") || (typeof (z) == "number")) {
				g[g.setImage ? "setLabel" : "setValue"](z);
			} else {
				if (!z) {
					g[g.setImage ? "setLabel" : "setValue"](g.val);
				}
			}
		}
	};
	this._getNextCell = function (_8b) {
		_8b = _8b || this.cell;
		arow = this.cell.parentNode;
		if (_8b.nextSibling) {
			_8b = _8b.nextSibling;
		} else {
			arow = this.rowsCol[this.rowsCol._dhx_find(arow) + 1];
			if (!arow) {
				return null;
			}
			_8b = arow.childNodes[0];
		}
		if (_8b.style.display != "none") {
			return _8b;
		}
		return this._getNextCell(_8b);
	};
	this._getPrevCell = function (_8c) {
		_8c = _8c || this.cell;
		arow = this.cell.parentNode;
		if (_8c.previousSibling) {
			_8c = _8c.previousSibling;
		} else {
			arow = this.rowsCol[this.rowsCol._dhx_find(arow) - 1];
			if (!arow) {
				return null;
			}
			_8c = arow.childNodes[arow.childNodes.length - 1];
		}
		if (_8c.style.display != "none") {
			return _8c;
		}
		return this._getPrevCell(_8c);
	};
	this._nextRow = function (ind, dir) {
		var r = this.rowsCol[ind + dir];
		if (r && r.style.display == "none") {
			return this._nextRow(ind + dir, dir);
		}
		return r;
	};
	this.doKey = function (ev) {
		if (!ev) {
			return true;
		}
		if ((ev.target || ev.srcElement).value !== window.undefined) {
			var zx = (ev.target || ev.srcElement);
			if ((!zx.parentNode) || (zx.parentNode.className.indexOf("editable") == -1)) {
				return true;
			}
		}
		if ((globalActiveDHTMLGridObject) && (this != globalActiveDHTMLGridObject)) {
			return globalActiveDHTMLGridObject.doKey(ev);
		}
		if (this.isActive == false) {
			return true;
		}
		if (this._htkebl) {
			return true;
		}
		if (!this.callEvent("onKeyPress", [ev.keyCode, ev.ctrlKey, ev.shiftKey])) {
			return false;
		}
		try {
			var _92 = this.cellType[this.cell._cellIndex];
			if (ev.keyCode == 13 && (ev.ctrlKey || ev.shiftKey)) {
				var _93 = this.rowsCol._dhx_find(this.row);
				if (window.event.ctrlKey && _93 != this.rowsCol.length - 1) {
					if (this.row.rowIndex == this.obj._rowslength() - 1 && this.dynScroll && this.dynScroll != "false") {
						this.doDynScroll("dn");
					}
					this.selectCell(this.rowsCol[_93 + 1], this.cell._cellIndex, true);
				} else {
					if (ev.shiftKey && _93 != 0) {
						if (this.row.rowIndex == 0 && this.dynScroll && this.dynScroll != "false") {
							this.doDynScroll("up");
						}
						this.selectCell(this.rowsCol[_93 - 1], this.cell._cellIndex, true);
					}
				}
				_isIE ? ev.returnValue = false : ev.preventDefault();
			}
			if (ev.keyCode == 13 && !ev.ctrlKey && !ev.shiftKey) {
				this.editStop();
				this.callEvent("onEnter", [this.row.idd, this.cell._cellIndex]);
				_isIE ? ev.returnValue = false : ev.preventDefault();
			}
			if (ev.keyCode == 9) {
				this.editStop();
				if (ev.shiftKey) {
					var z = this._getPrevCell();
				} else {
					var z = this._getNextCell();
				}
				if (!z) {
					return true;
				}
				this.selectCell(z.parentNode, z._cellIndex, (this.row != z.parentNode));
				this.editCell();
				_isIE ? ev.returnValue = false : ev.preventDefault();
			}
			if (ev.keyCode == 40 || ev.keyCode == 38) {
				if (this.editor && this.editor.combo) {
					if (ev.keyCode == 40) {
						this.editor.shiftNext();
					}
					if (ev.keyCode == 38) {
						this.editor.shiftPrev();
					}
					return false;
				} else {
					var _93 = this.row.rowIndex;
					if (ev.keyCode == 38 && _93 != 1) {
						var _95 = this._nextRow(_93 - 1, -1);
						if (_95._sRow || _95._rLoad) {
							return false;
						}
						this.selectCell(_95, this.cell._cellIndex, true);
					} else {
						if (this.pagingOn && ev.keyCode == 38 && _93 == 1 && this.currentPage != 1) {
							this.changePage(this.currentPage - 1);
							this.selectCell(this.obj.rows[this.obj.rows.length - 1], this.cell._cellIndex, true);
						} else {
							if (ev.keyCode == 40 && _93 != this.rowsCol.length && _93 != this.obj.rows.length - 1) {
								var _95 = this._nextRow(_93 - 1, 1);
								if (_95._sRow || _95._rLoad) {
									return false;
								}
								this.selectCell(_95, this.cell._cellIndex, true);
							} else {
								if (this.pagingOn && ev.keyCode == 40 && (this.row != this.rowsCol[this.rowsCol.length - 1] || this.rowsBuffer[0].length > 0 || !this.recordsNoMore)) {
									this.changePage(this.currentPage + 1);
									this.selectCell(this.obj._rows(0), this.cell._cellIndex, true);
								}
							}
						}
					}
				}
				_isIE ? ev.returnValue = false : ev.preventDefault();
			}
			if ((ev.keyCode == 113) && (this._f2kE)) {
				this.editCell();
				return false;
			}
			if (ev.keyCode == 32) {
				var c = this.cell;
				var ed = this.cells4(c);
				if (ed.changeState() != false) {
					_isIE ? ev.returnValue = false : ev.preventDefault();
				}
			}
			if (ev.keyCode == 27 && this.oe != false) {
				this.editStop();
				_isIE ? ev.returnValue = false : ev.preventDefault();
			}
			if (ev.keyCode == 33 || ev.keyCode == 34) {
				if (this.pagingOn) {
					if (ev.keyCode == 33) {
						this.changePage(this.currentPage - 1);
					} else {
						this.changePage(this.currentPage + 1);
					}
				}
				var _98 = Math.floor((this.getRowIndex(this.row.idd) || 0) + (ev.keyCode != 33 ? 1 : -1) * this.objBox.offsetHeight / (this._srdh || 20));
				if (_98 < 0) {
					_98 = 0;
				}
				if (this._dload && (!this.rowsCol[_98])) {
					this._askRealRows(_98, function () {
						try {
							_f.selectCell(_98, this.cell._cellIndex, true);
						}
						catch (e) {
						}
					});
				} else {
					if (_98 >= this.rowsCol.length) {
						_98 = this.rowsCol.length - 1;
					}
					this.selectCell(_98, this.cell._cellIndex, true);
				}
				if (_isIE) {
					ev.returnValue = false;
				} else {
					ev.preventDefault();
				}
			}
			if (!this.editor) {
				if (ev.keyCode == 37 && this.cellType._dhx_find("tree") != -1) {
					this.collapseKids(this.row);
					_isIE ? ev.returnValue = false : ev.preventDefault();
				}
				if (ev.keyCode == 39 && this.cellType._dhx_find("tree") != -1) {
					this.expandKids(this.row);
					_isIE ? ev.returnValue = false : ev.preventDefault();
				}
			}
			return true;
		}
		catch (er) {
			return true;
		}
	};
	this.getRow = function (_99) {
		if (!_99) {
			_99 = window.event.srcElement;
		}
		if (_99.tagName != "TD") {
			_99 = _99.parentElement;
		}
		r = _99.parentElement;
		if (this.cellType[_99._cellIndex] == "lk") {
			eval(this.onLink + "('" + this.getRowId(r.rowIndex) + "'," + _99._cellIndex + ")");
		}
		this.selectCell(r, _99._cellIndex, true);
	};
	this.selectRow = function (r, fl, _9c, _9d) {
		if (typeof (r) != "object") {
			r = this.rowsCol[r];
		}
		this.selectCell(r, 0, fl, _9c, false, _9d);
	};
	this.sortRows = function (col, _9f, _a0) {
		_a0 = (_a0 || "asc").toLowerCase();
		while (this.addRowsFromBuffer(true)) {
		}
		if (this.cellType._dhx_find("tree") != -1) {
			return this.sortTreeRows(col, _9f, _a0);
		}
		var _a1 = this;
		var _a2 = new Array();
		var _a3 = this.cellType[col];
		var _a4 = "getValue";
		if (_a3 == "link") {
			_a4 = "getContent";
		}
		if (_a3 == "dhxCalendar" || _a3 == "dhxCalendarA") {
			_a4 = "getDate";
		}
		for (var i = 0; i < this.rowsCol.length; i++) {
			_a2[this.rowsCol[i].idd] = this.cells3(this.rowsCol[i], col)[_a4]();
		}
		this._sortRows(col, _9f, _a0, _a2);
	};
	this._sortRows = function (col, _a7, _a8, _a9) {
		var _aa = "sort";
		if (this._sst) {
			_aa = "stablesort";
		}
		if (_a7 == "cus") {
			this.rowsCol[_aa](function (a, b) {
				return _f._customSorts[col](_a9[a.idd], _a9[b.idd], _a8, a.idd, b.idd);
			});
		} else {
			if (_a7 == "str") {
				this.rowsCol[_aa](function (a, b) {
					if (_a8 == "asc") {
						return _a9[a.idd] > _a9[b.idd] ? 1 : -1;
					} else {
						return _a9[a.idd] < _a9[b.idd] ? 1 : -1;
					}
				});
			} else {
				if (_a7 == "int") {
					this.rowsCol[_aa](function (a, b) {
						var _b1 = parseFloat(_a9[a.idd]);
						_b1 = isNaN(_b1) ? -99999999999999 : _b1;
						var _b2 = parseFloat(_a9[b.idd]);
						_b2 = isNaN(_b2) ? -99999999999999 : _b2;
						if (_a8 == "asc") {
							return _b1 - _b2;
						} else {
							return _b2 - _b1;
						}
					});
				} else {
					if (_a7 == "date") {
						this.rowsCol[_aa](function (a, b) {
							var _b5 = Date.parse(_a9[a.idd]) || (Date.parse("01/01/1900"));
							var _b6 = Date.parse(_a9[b.idd]) || (Date.parse("01/01/1900"));
							if (_a8 == "asc") {
								return _b5 - _b6;
							} else {
								return _b6 - _b5;
							}
						});
					}
				}
			}
		}
		if (this.dynScroll && this.dynScroll != "false") {
			alert("not implemented yet");
		} else {
			if (this.pagingOn) {
				this.changePage(this.currentPage);
				this.callEvent("onGridReconstructed", []);
			} else {
				if (this.rowsCol[0]) {
					var tb = this.rowsCol[0].parentNode;
				} else {
					var tb = this.obj.firstChild;
					if (tb.tagName == "TR") {
						tb = this.obj;
					}
				}
				for (var i = 0; i < this.rowsCol.length; i++) {
					if (this.rowsCol[i] != this.obj._rows(i)) {
						tb.insertBefore(this.rowsCol[i], this.obj._rows(i));
					}
				}
			}
		}
		this.callEvent("onGridReconstructed", []);
	};
	this.setXMLAutoLoading = function (_b9, _ba) {
		if (arguments.length == 0) {
			return (this._xmlaR = true);
		}
		this.recordsNoMore = false;
		this.xmlFileUrl = _b9;
		this.rowsBufferOutSize = _ba || (this.rowsBufferOutSize == 0 ? 40 : this.rowsBufferOutSize);
	};
	this.enableBuffering = function (_bb) {
		this.rowsBufferOutSize = _bb || (this.rowsBufferOutSize == 0 ? 40 : this.rowsBufferOutSize);
	};
	this.addRowsFromBuffer = function (_bc) {
		if (this.rowsBuffer[0].length == 0) {
			if (!this.recordsNoMore && !_bc) {
				if ((this.xmlFileUrl != "") && (!this._startXMLLoading)) {
					this._startXMLLoading = true;
					this.loadXML(this.xmlFileUrl);
				}
			} else {
				return false;
			}
		}
		var cnt = Math.min(this.rowsBufferOutSize, this.rowsBuffer[0].length);
		for (var i = 0; i < cnt; i++) {
			if (this.rowsBuffer[1][0].tagName == "TR") {
				this._insertRowAt(this.rowsBuffer[1][0], -1, this.pagingOn);
			} else {
				var _bf = this.rowsBuffer[1][0];
				var r = this.createRowFromXMLTag(_bf);
				this._insertRowAt(r, -1, this.pagingOn);
				this._postRowProcessing(r, _bf);
			}
			this.rowsBuffer[0]._dhx_removeAt(0);
			this.rowsBuffer[1]._dhx_removeAt(0);
		}
		return this.rowsBuffer[0].length != 0;
	};
	this.createRowFromXMLTag = function (_c1) {
		if (_c1.tagName == "TR") {
			return _c1;
		}
		var _c2 = this.cellType._dhx_find("tree");
		var rId = _c1.getAttribute("id");
		this.rowsAr[rId] = this._prepareRow(rId);
		var r = this._fillRowFromXML(this.rowsAr[rId], _c1, _c2, null);
		return r;
	};
	this.setMultiselect = function (fl) {
		this.selMultiRows = convertStringToBoolean(fl);
	};
	this.wasDblClicked = function (ev) {
		var el = this.getFirstParentOfType(_isIE ? ev.srcElement : ev.target, "TD");
		if (el) {
			var _c8 = el.parentNode.idd;
			return this.callEvent("onRowDblClicked", [_c8, el._cellIndex]);
		}
	};
	this._onHeaderClick = function (e, el) {
		var _cb = this.grid;
		el = el || _cb.getFirstParentOfType(_isIE ? event.srcElement : e.target, "TD");
		if (!(this.grid.callEvent("onHeaderClick", [el._cellIndexS, (e || window.event)]))) {
			return false;
		}
		if (this.grid.resized == null) {
			_cb.sortField(el._cellIndexS, false, el);
		}
	};
	this.deleteSelectedItem = function () {
		var num = this.selectedRows.length;
		if (num == 0) {
			return;
		}
		var _cd = this.selectedRows;
		this.selectedRows = new dhtmlxArray(0);
		for (var i = num - 1; i >= 0; i--) {
			var _cf = _cd[i];
			if (!this.deleteRow(_cf.idd, _cf)) {
				this.selectedRows[this.selectedRows.length] = _cf;
			} else {
				if (_cf == this.row) {
					var ind = i;
				}
			}
		}
		if (ind) {
			try {
				if (ind + 1 > this.rowsCol.length) {
					ind--;
				}
				this.selectCell(ind, 0, true);
			}
			catch (er) {
				this.row = null;
				this.cell = null;
			}
		}
	};
	this.getSelectedId = function () {
		var _d1 = new Array(0);
		var uni = {};
		for (var i = 0; i < this.selectedRows.length; i++) {
			var id = this.selectedRows[i].idd;
			if (uni[id]) {
				continue;
			}
			_d1[_d1.length] = id;
			uni[id] = true;
		}
		if (_d1.length == 0) {
			return null;
		} else {
			return _d1.join(this.delim);
		}
	};
	
	this.getSelectedRowId = function () {
		return this.getSelectedId();
	};
		
	this.getSelectedCellIndex = function () {
		if (this.cell != null) {
			return this.cell._cellIndex;
		} else {
			return -1;
		}
	};
	this.getColWidth = function (ind) {
		return parseInt(this.cellWidthPX[ind]) + ((_isFF) ? 2 : 0);
	};
	this.setColWidth = function (ind, _d7) {
		if (this.cellWidthType == "px") {
			this.cellWidthPX[ind] = parseInt(_d7);
		} else {
			this.cellWidthPC[ind] = parseInt(_d7);
		}
		this.setSizes();
	};
	this.getRowById = function (id) {
		var row = this.rowsAr[id];
		if (row) {
			return row;
		} else {
			if (this._dload) {
				var ind = this.rowsBuffer[0]._dhx_find(id);
				if (ind >= 0) {
					this._askRealRows(ind);
					return this.getRowById(id);
				}
			} else {
				if (this.pagingOn) {
					var ind = this.rowsBuffer[0]._dhx_find(id);
					if (ind >= 0) {
						var r = this.createRowFromXMLTag(this.rowsBuffer[1][ind]);
						this.rowsBuffer[1][ind] = r;
						return r;
					} else {
						return null;
					}
				} else {
					if (this._slowParse) {
						return this._seekAndDeploy(id);
					}
				}
			}
		}
		return null;
	};
	this.getRowByIndex = function (ind) {
		if (this.rowsCol.length <= ind) {
			if ((this.rowsCol.length + this.rowsBuffer[0].length) <= ind) {
				return null;
			} else {
				var _dd = ind - this.rowsCol.length - 1;
				var r = this.createRowFromXMLTag(this.rowsBuffer[1][_dd]);
				return r;
			}
		} else {
			return this.rowsCol[ind];
		}
	};
	this.getRowIndex = function (_df) {
		var ind = this.rowsCol._dhx_find(this.getRowById(_df));
		if (ind != -1) {
			return ind;
		} else {
			ind = this.rowsBuffer[0]._dhx_find(_df);
			if (ind != -1) {
				return ind + this.rowsCol.length;
			}
			return -1;
		}
	};
	this.getRowId = function (ind) {
		var z = this.rowsCol[parseInt(ind)];
		if (z) {
			return z.idd;
		}
		return (this.rowsBuffer[0][this._dload ? ind : (ind - this.rowsCol.length)] || null);
	};
	this.setRowId = function (ind, _e4) {
		var r = this.rowsCol[ind];
		this.changeRowId(r.idd, _e4);
	};
	this.changeRowId = function (_e6, _e7) {
		if (_e6 == _e7) {
			return;
		}
		var row = this.rowsAr[_e6];
		row.idd = _e7;
		if (this.UserData[_e6]) {
			this.UserData[_e7] = this.UserData[_e6];
			this.UserData[_e6] = null;
		}
		if (this._h2 && this._h2.get[_e6]) {
			this._h2.get[_e7] = this._h2.get[_e6];
			this._h2.get[_e7].id = _e7;
			delete this._h2.get[_e6];
		}
		this.rowsAr[_e6] = null;
		this.rowsAr[_e7] = row;
		for (var i = 0; i < row.childNodes.length; i++) {
			if (row.childNodes[i]._code) {
				row.childNodes[i]._code = this._compileSCL(row.childNodes[i]._val, row.childNodes[i]);
			}
		}
	};
	this.setColumnIds = function (ids) {
		if (ids) {
			this.columnIds = ids.split(",");
		}
		if (this.hdr.rows.length > 0) {
			if (this.hdr.rows[0].cells.length >= this.columnIds.length) {
				for (var i = 0; i < this.columnIds.length; i++) {
					this.hdr.rows[0].cells[i].column_id = this.columnIds[i];
				}
			}
		}
	};
	this.setColumnId = function (ind, id) {
		this.hdr.rows[0].cells[ind].column_id = id;
	};
	this.getColIndexById = function (id) {
		for (var i = 0; i < this.hdr.rows[0].cells.length; i++) {
			if (this.hdr.rows[0].cells[i].column_id == id) {
				return i;
			}
		}
	};
	this.getColumnId = function (cin) {
		return this.hdr.rows[0].cells[cin].column_id;
	};
	this.getHeaderCol = function (cin) {
		var z = this.hdr.rows[1];
		return z.cells[z._childIndexes ? z._childIndexes[parseInt(cin)] : cin].childNodes[0].innerHTML;
	};
	this.setRowTextBold = function (_f3) {
		this.getRowById(_f3).style.fontWeight = "bold";
	};
	this.setRowTextStyle = function (_f4, _f5) {
		var r = this.getRowById(_f4);
		for (var i = 0; i < r.childNodes.length; i++) {
			var _f8 = "";
			if ((this._hrrar) && (this._hrrar[i])) {
				_f8 = "display:none;";
			}
			if (_isIE) {
				r.childNodes[i].style.cssText = _f8 + "width:" + r.childNodes[i].style.width + ";" + _f5;
			} else {
				r.childNodes[i].style.cssText = _f8 + "width:" + r.childNodes[i].style.width + ";" + _f5;
			}
		}
	};
	this.setRowColor = function (_f9, _fa) {
		var r = this.getRowById(_f9);
		for (var i = 0; i < r.childNodes.length; i++) {
			r.childNodes[i].bgColor = _fa;
		}
	};
	this.setCellTextStyle = function (_fd, ind, _ff) {
		var r = this.getRowById(_fd);
		if (!r) {
			return;
		}
		if (ind < r.childNodes.length) {
			var pfix = "";
			if ((this._hrrar) && (this._hrrar[ind])) {
				pfix = "display:none;";
			}
			if (_isIE) {
				r.childNodes[ind].style.cssText = pfix + "width:" + r.childNodes[ind].style.width + ";" + _ff;
			} else {
				r.childNodes[ind].style.cssText = pfix + "width:" + r.childNodes[ind].style.width + ";" + _ff;
			}
		}
	};
	this.setRowTextNormal = function (_102) {
		this.getRowById(_102).style.fontWeight = "normal";
	};
	this.isItemExists = function (_103) {
		if (this.getRowById(_103) != null) {
			return true;
		} else {
			return false;
		}
	};
	this.getRowsNum = function () {
		if (this._dload) {
			return this.limit;
		}
		return this.rowsCol.length + this.rowsBuffer[0].length;
	};
	this.getColumnCount = function () {
		return this.hdr.rows[0].cells.length;
	};
	this.moveRowUp = function (_104) {
		var r = this.getRowById(_104);
		if (this.isTreeGrid()) {
			return this.moveRowUDTG(_104, -1);
		}
		var rInd = this.rowsCol._dhx_find(r);
		if ((r.previousSibling) && (rInd != 0)) {
			r.parentNode.insertBefore(r, r.previousSibling);
			this.rowsCol._dhx_swapItems(rInd, rInd - 1);
			this.setSizes();
		}
	};
	this.moveRowDown = function (_107) {
		var r = this.getRowById(_107);
		if (this.isTreeGrid()) {
			return this.moveRowUDTG(_107, 1);
		}
		var rInd = this.rowsCol._dhx_find(r);
		if (r.nextSibling) {
			this.rowsCol._dhx_swapItems(rInd, rInd + 1);
			if (r.nextSibling.nextSibling) {
				r.parentNode.insertBefore(r, r.nextSibling.nextSibling);
			} else {
				r.parentNode.appendChild(r);
			}
			this.setSizes();
		}
	};
	this.cellById = this.cells = function (_10a, col) {
		if (arguments.length == 0) {
			return this.cells4(this.cell);
		} else {
			var c = this.getRowById(_10a);
		}
		var cell = (c._childIndexes ? c.childNodes[c._childIndexes[col]] : c.childNodes[col]);
		return this.cells4(cell);
	};
	this.cellByIndex = this.cells2 = function (_10e, col) {
		var c = this.rowsCol[parseInt(_10e)];
		var cell = (c._childIndexes ? c.childNodes[c._childIndexes[col]] : c.childNodes[col]);
		return this.cells4(cell);
	};
	this.cells3 = function (row, col) {
		var cell = (row._childIndexes ? row.childNodes[row._childIndexes[col]] : row.childNodes[col]);
		return this.cells4(cell);
	};
	this.cells4 = function (cell) {
		if (!cell._cellType) {
			return eval("new eXcell_" + this.cellType[cell._cellIndex] + "(cell)");
		} else {
			return eval("new eXcell_" + cell._cellType + "(cell)");
		}
	};
	this.getCombo = function (_116) {
		if (!this.combos[_116]) {
			this.combos[_116] = new dhtmlXGridComboObject();
		}
		return this.combos[_116];
	};
	this.setUserData = function (_117, name, _119) {
		try {
			if (_117 == "") {
				_117 = "gridglobaluserdata";
			}
			if (!this.UserData[_117]) {
				this.UserData[_117] = new Hashtable();
			}
			this.UserData[_117].put(name, _119);
		}
		catch (er) {
			alert("UserData Error:" + er.description);
		}
	};
	this.getUserData = function (_11a, name) {
		this.getRowById(_11a);
		if (_11a == "") {
			_11a = "gridglobaluserdata";
		}
		var z = this.UserData[_11a];
		return (z ? z.get(name) : "");
	};
	this.setEditable = function (fl) {
		if (fl != "true" && fl != 1 && fl != true) {
			ifl = true;
		} else {
			ifl = false;
		}
		for (var j = 0; j < this.cellType.length; j++) {
			if (this.cellType[j].indexOf("ra") == 0 || this.cellType[j] == "ch") {
				for (var i = 0; i < this.rowsCol.length; i++) {
					var z = this.rowsCol[i].cells[j];
					if ((z.childNodes.length > 0) && (z.firstChild.nodeType == 1)) {
						this.rowsCol[i].cells[j].firstChild.disabled = ifl;
					}
				}
			}
		}
		this.isEditable = !ifl;
	};
	this.setSelectedRow = function (_121, _122, show, call) {
		if (!call) {
			call = false;
		}
		this.selectCell(this.getRowById(_121), 0, call, _122, false, show);
	};
	this.clearSelection = function () {
		this.editStop();
		for (var i = 0; i < this.selectedRows.length; i++) {
			var r = this.rowsAr[this.selectedRows[i].idd];
			if (r) {
				r.className = r.className.replace(/rowselected/g, "");
			}
		}
		this.selectedRows = new dhtmlxArray(0);
		this.row = null;
		if (this.cell != null) {
			this.cell.className = this.cell.className.replace(/cellselected/g, "");
			this.cell = null;
		}
	};
	this.copyRowContent = function (_127, _128) {
		var _129 = this.getRowById(_127);
		if (!this.isTreeGrid()) {
			for (i = 0; i < _129.cells.length; i++) {
				this.cells(_128, i).setValue(this.cells(_127, i).getValue());
			}
		} else {
			this._copyTreeGridRowContent(_129, _127, _128);
		}
		if (!isIE()) {
			this.getRowById(_127).cells[0].height = _129.cells[0].offsetHeight;
		}
	};
	this.setHeaderCol = function (col, _12b) {
		var z = this.hdr.rows[1];
		var col = (z._childIndexes ? z._childIndexes[col] : col);
		if (!this.useImagesInHeader) {
			var _12d = "<div class='hdrcell'>";
			if (_12b.indexOf("img:[") != -1) {
				var _12e = _12b.replace(/.*\[([^>]+)\].*/, "$1");
				_12b = _12b.substr(_12b.indexOf("]") + 1, _12b.length);
				_12d += "<img width='18px' height='18px' align='absmiddle' src='" + _12e + "' hspace='2'>";
			}
			_12d += _12b;
			_12d += "</div>";
			z.cells[col].innerHTML = _12d;
			if (this._hstyles[col]) {
				z.cells[col].style.cssText = this._hstyles[col];
			}
		} else {
			z.cells[col].style.textAlign = "left";
			z.cells[col].innerHTML = "<img src='" + this.imgURL + "" + _12b + "' onerror='this.src = \"" + this.imgURL + "imageloaderror.gif\"'>";
			var a = new Image();
			a.src = this.imgURL + "" + _12b.replace(/(\.[a-z]+)/, ".desc$1");
			this.preloadImagesAr[this.preloadImagesAr.length] = a;
			var b = new Image();
			b.src = this.imgURL + "" + _12b.replace(/(\.[a-z]+)/, ".asc$1");
			this.preloadImagesAr[this.preloadImagesAr.length] = b;
		}
	};
	this.clearAll = function (_131) {
		if (this._h2) {
			if (this._realfake) {
				this._h2 = this._fake._h2;
			} else {
				this._h2 = new dhtmlxHierarchy();
			}
		}
		this.limit = this._limitC = 0;
		this.editStop();
		if (this._dLoadTimer) {
			window.clearTimeout(this._dLoadTimer);
		}
		if (this._dload) {
			this.objBox.scrollTop = 0;
			this.limit = this._limitC || 0;
			this._initDrF = true;
		}
		var len = this.rowsCol.length;
		if (this.loadedKidsHash != null) {
			this.loadedKidsHash.clear();
			this.loadedKidsHash.put("hashOfParents", new Hashtable());
		}
		len = this.obj._rowslength();
		for (var i = len - 1; i >= 0; i--) {
			var t_r = this.obj._rows(i);
			t_r.parentNode.removeChild(t_r);
		}
		if (_131) {
			this.obj.rows[0].parentNode.removeChild(this.obj.rows[0]);
			for (var i = this.hdr.rows.length - 1; i >= 0; i--) {
				var t_r = this.hdr.rows[i];
				t_r.parentNode.removeChild(t_r);
			}
			if (this.ftr) {
				this.ftr.parentNode.removeChild(this.ftr);
				this.ftr = null;
			}
			this._aHead = this.ftr = this._aFoot = null;
		}
		this.row = null;
		this.cell = null;
		this.rowsCol = new dhtmlxArray(0);
		this.rowsAr = new Array(0);
		this.rowsBuffer = new Array(new dhtmlxArray(0), new dhtmlxArray(0));
		this.UserData = new Array(0);
		this.selectedRows = new dhtmlxArray(0);
		if (this.pagingOn) {
			this.changePage(1);
		}
		if (!this._fake) {
		}
		if (this._contextCallTimer) {
			window.clearTimeout(this._contextCallTimer);
		}
		if (this._sst) {
			this.enableStableSorting(true);
		}
		this.setSortImgState(false);
		this.setSizes();
	};
	this.sortField = function (ind, _136, r_el) {
		if (this.getRowsNum() == 0) {
			return false;
		}
		var el = this.hdr.rows[0].cells[ind];
		if (!el) {
			return;
		}
		if (this._dload) {
			return this.callEvent("onBeforeSorting", [ind, this]);
		}
		if (el.tagName == "TH" && (this.fldSort.length - 1) >= el._cellIndex && this.fldSort[el._cellIndex] != "na") {
			if ((((this.sortImg.src.indexOf("_desc.gif") == -1) && (!_136)) || ((this.sortImg.style.filter != "") && (_136))) && (this.fldSorted == el)) {
				var _139 = "des";
				this.sortImg.src = this.imgURL + "sort_desc.gif";
			} else {
				var _139 = "asc";
				this.sortImg.src = this.imgURL + "sort_asc.gif";
			}
			if (!this.callEvent("onBeforeSorting", [ind, this, _139])) {
				return;
			}
			if (this.useImagesInHeader) {
				var cel = this.hdr.rows[1].cells[el._cellIndex].firstChild;
				if (this.fldSorted != null) {
					var celT = this.hdr.rows[1].cells[this.fldSorted._cellIndex].firstChild;
					celT.src = celT.src.replace(/\.[ascde]+\./, ".");
				}
				cel.src = cel.src.replace(/(\.[a-z]+)/, "." + _139 + "$1");
			}
			this.sortRows(el._cellIndex, this.fldSort[el._cellIndex], _139);
			this.fldSorted = el;
			this.r_fldSorted = r_el;
			var c = this.hdr.rows[1];
			var c = r_el.parentNode;
			var _13d = c._childIndexes ? c._childIndexes[el._cellIndex] : el._cellIndex;
			this.setSortImgPos(false, false, false, r_el);
		}
	};
	this.setCustomSorting = function (func, col) {
		if (!this._customSorts) {
			this._customSorts = new Array();
		}
		this._customSorts[col] = (typeof (func) == "string") ? eval(func) : func;
		this.fldSort[col] = "cus";
	};
	this.enableHeaderImages = function (fl) {
		this.useImagesInHeader = fl;
	};
	this.setHeader = function (_141, _142, _143) {
		if (typeof (_141) != "object") {
			var _144 = this._eSplit(_141);
		} else {
			_144 = [].concat(_141);
		}
		var _145 = new Array(0);
		var _146 = new dhtmlxArray(0);
		var _147 = new Array(0);
		var _148 = new Array(0);
		var _149 = new Array(0);
		for (var i = 0; i < _144.length; i++) {
			_145[_145.length] = Math.round(100 / _144.length);
			_146[_146.length] = "ed";
			_147[_147.length] = "left";
			_148[_148.length] = "";
			_149[_149.length] = "na";
		}
		this.splitSign = _142 || "#cspan";
		this.hdrLabels = _144;
		this.cellWidth = _145;
		this.cellType = _146;
		this.cellAlign = _147;
		this.cellVAlign = _148;
		this.fldSort = _149;
		this._hstyles = _143 || [];
	};
	this._eSplit = function (str) {
		if (![].push) {
			return str.split(this.delim);
		}
		var a = "r" + (new Date()).valueOf();
		var z = this.delim.replace(/([\|])/g, "\\$1");
		return (str || "").replace(RegExp(z, "g"), a).replace(RegExp("\\\\" + a, "g"), this.delim).split(a);
	};
	this.getColType = function (_14e) {
		return this.cellType[_14e];
	};
	this.getColTypeById = function (_14f) {
		return this.cellType[this.getColIndexById(_14f)];
	};
	this.setColTypes = function (_150) {
		this.cellType = dhtmlxArray(_150.split(this.delim));
		this._strangeParams = new Array();
		for (var i = 0; i < this.cellType.length; i++) {
			if ((this.cellType[i].indexOf("[") != -1)) {
				var z = this.cellType[i].split(/[\[\]]+/g);
				this.cellType[i] = z[0];
				this.defVal[i] = z[1];
				if (z[1].indexOf("=") == 0) {
					this.cellType[i] = "math";
					this._strangeParams[i] = z[0];
				}
			}
		}
	};
	this.setColSorting = function (_153) {
		this.fldSort = _153.split(this.delim);
		for (var i = 0; i < this.fldSort.length; i++) {
			if (((this.fldSort[i]).length > 4) && (typeof (window[this.fldSort[i]]) == "function")) {
				if (!this._customSorts) {
					this._customSorts = new Array();
				}
				this._customSorts[i] = window[this.fldSort[i]];
				this.fldSort[i] = "cus";
			}
		}
	};
	this.setColAlign = function (_155) {
		this.cellAlign = _155.split(this.delim);
	};
	this.setColVAlign = function (_156) {
		this.cellVAlign = _156.split(this.delim);
	};
	this.setMultiLine = function (fl) {
		if (fl == true) {
			this.multiLine = -1;
		}
	};
	this.setNoHeader = function (fl) {
		if (convertStringToBoolean(fl) == true) {
			this.noHeader = true;
		}
	};
	this.showRow = function (_159) {
		if (this.pagingOn) {
			if (this.rowsAr[_159]) {
				this.changePage(Math.floor(this.getRowIndex(_159) / this.rowsBufferOutSize) + 1);
			} else {
				while ((!this.rowsAr[_159]) && (this.rowsBuffer[0].length > 0 || !this.recordsNoMore)) {
					this.changePage(this.currentPage + 1);
				}
			}
		}
		this.moveToVisible(this.getRowById(_159).cells[0], true);
	};
	this.setStyle = function (_15a, _15b, _15c, _15d) {
		this.ssModifier = [_15a, _15b, _15c, _15c, _15d];
		var _15e = ["#" + this.entBox.id + " table.hdr td", "#" + this.entBox.id + " table.obj td", "#" + this.entBox.id + " table.obj tr.rowselected td.cellselected", "#" + this.entBox.id + " table.obj td.cellselected", "#" + this.entBox.id + " table.obj tr.rowselected td"];
		for (var i = 0; i < _15e.length; i++) {
			if (this.ssModifier[i]) {
				if (_isIE) {
					this.styleSheet[0].addRule(_15e[i], this.ssModifier[i]);
				} else {
					this.styleSheet[0].insertRule(_15e[i] + " { " + this.ssModifier[i] + " } ", 0);
				}
			}
		}
	};
	this.setColumnColor = function (clr) {
		this.columnColor = clr.split(this.delim);
	};
	this.enableAlterCss = function (cssE, cssU, _163, _164) {
		if (cssE || cssU) {
			this.setOnGridReconstructedHandler(function () {
				if (!this._cssSP) {
					this._fixAlterCss();
				}
			});
		}
		this._cssSP = _163;
		this._cssSU = _164;
		this._cssEven = cssE;
		this._cssUnEven = cssU;
	};
	this._fixAlterCss = function (ind) {
		if (this._cssSP && this.isTreeGrid()) {
			return this._fixAlterCssTG(ind);
		}
		ind = ind || 0;
		var j = ind;
		for (var i = ind; i < this.rowsCol.length; i++) {
			if (!this.rowsCol[i]) {
				continue;
			}
			if (this.rowsCol[i].style.display != "none") {
				if (this.rowsCol[i].className.indexOf("rowselected") != -1) {
					if (j % 2 == 1) {
						this.rowsCol[i].className = this._cssUnEven + " rowselected" + (this.rowsCol[i]._css || "");
					} else {
						this.rowsCol[i].className = this._cssEven + " rowselected" + (this.rowsCol[i]._css || "");
					}
				} else {
					if (j % 2 == 1) {
						this.rowsCol[i].className = this._cssUnEven + (this.rowsCol[i]._css || "");
					} else {
						this.rowsCol[i].className = this._cssEven + (this.rowsCol[i]._css || "");
					}
				}
				j++;
			}
		}
	};
	this.doDynScroll = function (fl) {
		if (!this.dynScroll || this.dynScroll == "false") {
			return false;
		}
		this.setDynScrollPageSize();
		var _169 = new Array(0);
		if (fl && fl == "up") {
			this.dynScrollPos = Math.max(this.dynScrollPos - this.dynScrollPageSize, 0);
		} else {
			if (fl && fl == "dn" && this.dynScrollPos + this.dynScrollPageSize < this.rowsCol.length) {
				if (this.dynScrollPos + this.dynScrollPageSize + this.rowsBufferOutSize > this.rowsCol.length) {
					this.addRowsFromBuffer();
				}
				this.dynScrollPos += this.dynScrollPageSize;
			}
		}
		var _16a = Math.max(this.dynScrollPos - this.dynScrollPageSize, 0);
		for (var i = _16a; i < this.rowsCol.length; i++) {
			if (i >= this.dynScrollPos && i < this.dynScrollPos + this.dynScrollPageSize) {
				_169[_169.length] = this.rowsCol[i];
			}
			this.rowsCol[i].parentNode.removeChild(this.rowsCol[i]);
		}
		for (var i = 0; i < _169.length; i++) {
			this.obj.childNodes[0].appendChild(_169[i]);
			if (this.obj.offsetHeight > this.objBox.offsetHeight) {
				this.dynScrollPos -= (this.dynScrollPageSize - i);
			}
		}
		this.setSizes();
	};
	this.setDynScrollPageSize = function () {
		if (this.dynScroll && this.dynScroll != "false") {
			var _16c = 0;
			try {
				var rowH = this.obj._rows(0).scrollHeight;
			}
			catch (er) {
				var rowH = 20;
			}
			for (var i = 0; i < 1000; i++) {
				_16c = i * rowH;
				if (this.objBox.offsetHeight < _16c) {
					break;
				}
			}
			this.dynScrollPageSize = i + 2;
			this.rowsBufferOutSize = this.dynScrollPageSize * 4;
		}
	};
	this.clearChangedState = function () {
		for (var i = 0; i < this.rowsCol.length; i++) {
			var row = this.rowsCol[i];
			var cols = row.childNodes.length;
			for (var j = 0; j < cols; j++) {
				row.childNodes[j].wasChanged = false;
			}
		}
	};
	this.getChangedRows = function () {
		var res = new Array();
		this.forEachRow(function (id) {
			var row = this.rowsAr[id];
			var cols = row.childNodes.length;
			for (var j = 0; j < cols; j++) {
				if (row.childNodes[j].wasChanged) {
					res[res.length] = row.idd;
					break;
				}
			}
		});
		return res.join(this.delim);
	};
	this._sUDa = false;
	this._sAll = false;
	this.setSerializationLevel = function (_178, _179, _17a, _17b, _17c, _17d) {
		this._sUDa = _178;
		this._sAll = _179;
		this._sConfig = _17a;
		this._chAttr = _17b;
		this._onlChAttr = _17c;
		this._asCDATA = _17d;
	};
	this.setSerializableColumns = function (list) {
		if (!list) {
			this._srClmn = null;
			return;
		}
		this._srClmn = (list || "").split(",");
		for (var i = 0; i < this._srClmn.length; i++) {
			this._srClmn[i] = convertStringToBoolean(this._srClmn[i]);
		}
	};
	this._serialise = function (rCol, _181, _182) {
		this.editStop();
		var out = [];
		var i = 0;
		var j = 0;
		var leni = (this._dload) ? this.rowsBuffer[0].length : rCol.length;
		if (this.isTreeGrid()) {
			var f = function (id, f) {
				var str = [];
				var z = _f._h2.get[id];
				if (0 != id) {
					str.push(_f._serializeRow(_f.rowsAr[id], i));
				}
				for (var i = 0; i < z.childs.length; i++) {
					str.push(f(z.childs[i].id, f));
				}
				if (0 != id) {
					str.push("</row>\n");
				}
				return str.join("");
			};
			out.push(f(0, f));
		} else {
			for (i; i < leni; i++) {
				var r = rCol[i];
				var temp = this._serializeRow(r, i);
				out.push(temp);
				if ((temp != "") && r && (!r._sRow) && (!r._rLoad)) {
					out.push("</row>");
				}
			}
		}
		return [out.join(""), j + i];
	};
	this._manualXMLSerialize = function (r) {
		var out = "<row id='" + r.getAttribute("id") + "'>";
		var i = 0;
		for (var jj = 0; jj < r.childNodes.length; jj++) {
			var z = r.childNodes[jj];
			if (z.tagName != "cell") {
				continue;
			}
			if ((!this._srClmn) || (this._srClmn[i])) {
				out += "<cell>" + (z.firstChild ? z.firstChild.data : "") + "</cell>";
			}
			i++;
		}
		out += "</row>";
		return out;
	};
	this._serializeRow = function (r, i) {
		var out = [];
		if ((!r) || (r._sRow) || (r._rLoad)) {
			if (this._onlChAttr) {
				return "";
			}
			if (this.rowsBuffer[1][i]) {
				if (this.xmlSerializer) {
					out = this.xmlSerializer.serializeToString(this.rowsBuffer[1][i]);
				} else {
					out = this.rowsBuffer[1][i].xml;
				}
			}
			return out;
		}
		var _197 = "";
		if (this._sAll && this.selectedRows._dhx_find(r) != -1) {
			_197 = " selected='1'";
		}
		out.push("<row id='" + r.idd + "'" + _197 + " " + ((r.expand == "") ? "open='1'" : "") + ">");
		if (this._sUDa && this.UserData[r.idd]) {
			keysAr = this.UserData[r.idd].getKeys();
			for (var ii = 0; ii < keysAr.length; ii++) {
				out.push("<userdata name='" + keysAr[ii] + "'>" + this.UserData[r.idd].get(keysAr[ii]) + "</userdata>");
			}
		}
		var _199 = false;
		for (var jj = 0; jj < r.childNodes.length; jj++) {
			if ((!this._srClmn) || (this._srClmn[jj])) {
				var cvx = r.childNodes[jj];
				out.push("<cell");
				var zx = this.cells(r.idd, cvx._cellIndex);
				if (zx.cell) {
					zxVal = zx[this._agetm]();
				} else {
					zxVal = "";
				}
				if (zxVal === null) {
					zxVal = "";
				}
				if (this._asCDATA) {
					zxVal = "<![CDATA[" + zxVal + "]]>";
				}
				if ((this._ecspn) && (cvx.colSpan) && cvx.colSpan > 1) {
					out.push(" colspan=\"" + cvx.colSpan + "\" ");
				}
				if (zx.getSerializeAttributes) {
					out.push(" " + zx.getSerializeAttributes());
				}
				if (this._chAttr) {
					if (zx.wasChanged()) {
						out.push(" changed=\"1\"");
						_199 = true;
					}
				} else {
					if ((this._onlChAttr) && (zx.wasChanged())) {
						_199 = true;
					}
				}
				if (this._sAll) {
					out.push((this._h2 ? (" image='" + this._h2.get[r.idd].image + "'") : "") + ">" + zxVal + "</cell>");
				} else {
					out.push(">" + zxVal + "</cell>");
				}
				if ((this._ecspn) && (cvx.colSpan)) {
					cvx = cvx.colSpan - 1;
					for (var u = 0; u < cvx; u++) {
						out.push("<cell/>");
					}
				}
			}
		}
		if ((this._onlChAttr) && (!_199) && (!r._added)) {
			return "";
		}
		return out.join("");
	};
	this._serialiseConfig = function () {
		var out = "<head>";
		for (var i = 0; i < this.hdr.rows[0].cells.length; i++) {
			out += "<column width='" + this.cellWidthPX[i] + "' align='" + this.cellAlign[i] + "' type='" + this.cellType[i] + "' sort='" + this.fldSort[i] + "' color='" + this.columnColor[i] + "'" + (this.columnIds[i] ? (" id='" + this.columnIds[i] + "'") : "") + ">";
			out += this.getHeaderCol(i);
			var z = this.getCombo(i);
			if (z) {
				for (var j = 0; j < z.keys.length; j++) {
					out += "<option value='" + z.keys[j] + "'>" + z.values[j] + "</option>";
				}
			}
			out += "</column>";
		}
		return out += "</head>";
	};
	this.serialize = function () {
		if (_isFF) {
			this.xmlSerializer = new XMLSerializer();
		}
		var out = "<?xml version=\"1.0\"?><rows>";
		if (this._mathSerialization) {
			this._agetm = "getMathValue";
		} else {
			this._agetm = "getValue";
		}
		if (this._sUDa && this.UserData["gridglobaluserdata"]) {
			var _1a3 = this.UserData["gridglobaluserdata"].getKeys();
			for (var i = 0; i < _1a3.length; i++) {
				out += "<userdata name='" + _1a3[i] + "'>" + this.UserData["gridglobaluserdata"].get(_1a3[i]) + "</userdata>";
			}
		}
		if (this._sConfig) {
			out += this._serialiseConfig();
		}
		out += this._serialise(this.rowsCol)[0];
		if (!this._dload) {
			for (var i = 0; i < this.rowsBuffer[1].length; i++) {
				if (this.rowsBuffer[1][i].tagName == "TR") {
				} else {
					if (!this._onlChAttr) {
						if (this._srClmn) {
							out += this._manualXMLSerialize(this.rowsBuffer[1][i]);
						} else {
							if (!this.xmlSerializer) {
								out += this.rowsBuffer[1][i].xml;
							} else {
								out += this.xmlSerializer.serializeToString(this.rowsBuffer[1][i]);
							}
						}
					}
				}
			}
		}
		out += "</rows>";
		return out;
	};
	this.setOnRowSelectHandler = function (func, _1a6) {
		this.attachEvent("onRowSelect", func);
		this._chRRS = (!convertStringToBoolean(_1a6));
	};
	this.setOnScrollHandler = function (func) {
		this.attachEvent("onScroll", func);
	};
	this.setOnEditCellHandler = function (func) {
		this.attachEvent("onEditCell", func);
	};
	this.setOnCheckHandler = function (func) {
		this.attachEvent("onCheckbox", func);
	};
	this.setOnEnterPressedHandler = function (func) {
		this.attachEvent("onEnter", func);
	};
	this.setOnBeforeRowDeletedHandler = function (func) {
		this.attachEvent("onBeforeRowDeleted", func);
	};
	this.setOnRowAddedHandler = function (func) {
		this.attachEvent("onRowAdded", func);
	};
	this.setOnGridReconstructedHandler = function (func) {
		this.attachEvent("onGridReconstructed", func);
	};
	dhtmlXGridObject.prototype.setOnResize = function (func) {
		this.attachEvent("onResize", func);
	};
	dhtmlXGridObject.prototype.setOnBeforeSelect = function (func) {
		this.attachEvent("onBeforeSelect", func);
	};
	dhtmlXGridObject.prototype.setOnRowCreated = function (func) {
		this.attachEvent("onRowCreated", func);
	};
	dhtmlXGridObject.prototype.setOnLoadingEnd = function (func) {
		this.attachEvent("onXLE", func);
	};
	dhtmlXGridObject.prototype.setOnCellChanged = function (func) {
		this.attachEvent("onCellChanged", func);
	};
	dhtmlXGridObject.prototype.setOnLoadingStart = function (func) {
		this.attachEvent("onXLS", func);
	};
	dhtmlXGridObject.prototype.setOnColumnSort = function (func) {
		this.attachEvent("onBeforeSorting", func);
	};
	this.setOnSelectStateChanged = function (func) {
		this.attachEvent("onSelectStateChanged", func);
	};
	this.setOnRowDblClickedHandler = function (func) {
		this.attachEvent("onRowDblClicked", func);
	};
	this.setOnHeaderClickHandler = function (func) {
		this.attachEvent("onHeaderClick", func);
	};
	dhtmlXGridObject.prototype.setOnResizeEnd = function (func) {
		this.attachEvent("onResizeEnd", func);
	};
	this.getPosition = function (_1b9, _1ba) {
		if (!_1ba) {
			var _1ba = document.body;
		}
		var _1bb = _1b9;
		var _1bc = 0;
		var iTop = 0;
		while ((_1bb) && (_1bb != _1ba)) {
			_1bc += _1bb.offsetLeft - _1bb.scrollLeft;
			iTop += _1bb.offsetTop - _1bb.scrollTop;
			_1bb = _1bb.offsetParent;
		}
		if (_1ba == document.body) {
			if (_isIE) {
				if (document.documentElement.scrollTop) {
					iTop += document.documentElement.scrollTop;
				}
				if (document.documentElement.scrollLeft) {
					_1bc += document.documentElement.scrollLeft;
				}
			} else {
				if (!_isFF) {
					_1bc += document.body.offsetLeft;
					iTop += document.body.offsetTop;
				}
			}
		}
		return new Array(_1bc, iTop);
	};
	this.getFirstParentOfType = function (obj, tag) {
		while (obj.tagName != tag && obj.tagName != "BODY") {
			obj = obj.parentNode;
		}
		return obj;
	};
	this.setColumnCount = function (cnt) {
		alert("setColumnCount method deprecated");
	};
	this.showContent = function () {
		alert("showContent method deprecated");
	};
	this.objBox.onscroll = new Function("", "this.grid._doOnScroll()");
	if ((!_isOpera) || (_OperaRv > 8.5)) {
		this.hdr.onmousemove = new Function("e", "this.grid.changeCursorState(e||window.event)");
		this.hdr.onmousedown = new Function("e", "this.grid.startColResize(e||window.event)");
	}
	this.obj.onmousemove = this._drawTooltip;
	this.obj.onclick = new Function("e", "this.grid._doClick(e||window.event); if (this.grid._sclE) this.grid.editCell(e||window.event);  (e||event).cancelBubble=true; ");
	if (_isMacOS) {
		this.entBox.oncontextmenu = new Function("e", "return this.grid._doContClick(e||window.event);");
	}
	this.entBox.onmousedown = new Function("e", "return this.grid._doContClick(e||window.event);");
	this.obj.ondblclick = new Function("e", "if(!this.grid.wasDblClicked(e||window.event)){return false}; if (this.grid._dclE) this.grid.editCell(e||window.event);  (e||event).cancelBubble=true;");
	this.hdr.onclick = this._onHeaderClick;
	this.sortImg.onclick = function () {
		_f._onHeaderClick.apply({grid:_f}, [null, _f.r_fldSorted]);
	};
	this.hdr.ondblclick = this._onHeaderDblClick;
	if (!document.body._dhtmlxgrid_onkeydown) {
		dhtmlxEvent(document, "keydown", new Function("e", "if (globalActiveDHTMLGridObject) return globalActiveDHTMLGridObject.doKey(e||window.event);  return true;"));
		document.body._dhtmlxgrid_onkeydown = true;
	}
	dhtmlxEvent(document.body, "click", function () {
		if (_f.editStop) {
			_f.editStop();
		}
	});
	this.entBox.onbeforeactivate = new Function("", "this.grid.setActive(); event.cancelBubble=true;");
	this.entBox.onbeforedeactivate = new Function("", "this.grid.isActive=-1; event.cancelBubble=true;");
	this.doOnRowAdded = function (row) {
	};
	if (this.entBox.style.height.toString().indexOf("%") != -1) {
		this._setAutoResize();
	}
	return this;
}
dhtmlXGridObject.prototype.isTreeGrid = function () {
	return (this.cellType._dhx_find("tree") != -1);
};

//获取最大行号
dhtmlXGridObject.prototype.getUID = function () {
	var z = this.getRowsNum() + 1;
	while (this.rowsAr[z]) {
		z++;
	}
	return z;
};

dhtmlXGridObject.prototype.addRow = function (_1c2, text, ind) {
	var r = this._addRow(_1c2, text, ind);
	if (!this.dragContext) {
		this.callEvent("onRowAdded", [_1c2]);
	}
	this.callEvent("onRowCreated", [r.idd, r, null]);
	if (this.pagingOn) {
		this.changePage(this.currentPage);
	}
	this.setSizes();
	r._added = true;
	this.callEvent("onGridReconstructed", []);
	return r;
};
dhtmlXGridObject.prototype._prepareRow = function (_1c6) {
	var r = document.createElement("TR");
	r.idd = _1c6;
	r.grid = this;
	for (var i = 0; i < this.hdr.rows[0].cells.length; i++) {
		var c = document.createElement("TD");
		if (this._enbCid) {
			c.id = "c_" + r.idd + "_" + i;
		}
		c._cellIndex = i;
		if (this.dragAndDropOff) {
			this.dragger.addDraggableItem(c, this);
		}
		if (this.cellAlign[i]) {
			c.align = this.cellAlign[i];
		}
		c.style.verticalAlign = this.cellVAlign[i];
		c.bgColor = this.columnColor[i] || "";
		if ((this._hrrar) && (this._hrrar[i])) {
			c.style.display = "none";
		}
		r.appendChild(c);
	}
	return r;
};
dhtmlXGridObject.prototype._fillRow = function (r, text) {
	if (!this._parsing_) {
		this.editStop();
	}
	this.math_off = true;
	this.math_req = false;
	if (typeof (text) != "object") {
		text = (text || "").split(this.delim);
	}
	for (var i = 0; i < r.childNodes.length; i++) {
		if ((i < text.length) || (this.defVal[i])) {
			var val = text[i];
			if ((this.defVal[i]) && ((val == "") || (typeof (val) == "undefined"))) {
				val = this.defVal[i];
			}
			if ((this._dload) && (this.rowsAr[r.idd])) {
				var _1ce = this.cells3(r, r.childNodes[i]._cellIndex);
			} else {
				_1ce = this.cells4(r.childNodes[i]);
			}
			_1ce.setValue(val);
			_1ce = _1ce.destructor();
		} else {
			var val = "&nbsp;";
			r.childNodes[i].innerHTML = val;
			r.childNodes[i]._clearCell = true;
		}
	}
	this.math_off = false;
	if ((this.math_req) && (!this._parsing_)) {
		for (var i = 0; i < this.hdr.rows[0].cells.length; i++) {
			this._checkSCL(r.childNodes[i]);
		}
		this.math_req = false;
	}
	return r;
};
dhtmlXGridObject.prototype._insertRowAt = function (r, ind, skip) {
	if (r._skipInsert) {
		this.rowsAr[r.idd] = r;
		return r;
	}
	if ((ind < 0) || ((!ind) && (parseInt(ind) !== 0))) {
		ind = this.rowsCol.length;
	} else {
		if (ind > this.rowsCol.length) {
			ind = this.rowsCol.length;
		}
	}
	if (!skip) {
		if ((ind == (this.obj.rows.length - 1)) || (!this.rowsCol[ind])) {
			if (_isKHTML) {
				this.obj.appendChild(r);
			} else {
				this.obj.firstChild.appendChild(r);
			}
		} else {
			this.rowsCol[ind].parentNode.insertBefore(r, this.rowsCol[ind]);
		}
	}
	this.rowsAr[r.idd] = r;
	this.rowsCol._dhx_insertAt(ind, r);
	if (this._cssEven) {
		if ((this._cssSP ? this.getLevel(r.idd) : ind) % 2 == 1) {
			r.className += " " + this._cssUnEven + (this._cssSU ? (this._cssUnEven + "_" + this.getLevel(r.idd)) : "");
		} else {
			r.className += " " + this._cssEven + (this._cssSU ? (" " + this._cssEven + "_" + this.getLevel(r.idd)) : "");
		}
		if (!this._cssSP && (ind != (this.rowsCol.length - 1))) {
			this._fixAlterCss(ind + 1);
		}
	}
	this.doOnRowAdded(r);
	if ((this.math_req) && (!this._parsing_)) {
		for (var i = 0; i < this.hdr.rows[0].cells.length; i++) {
			this._checkSCL(r.childNodes[i]);
		}
		this.math_req = false;
	}
	return r;
};
dhtmlXGridObject.prototype._addRow = function (_1d3, text, ind) {
	var row = this._fillRow(this._prepareRow(_1d3), text);
	if (ind > this.rowsCol.length && ind < (this.rowsCol.length + this.rowsBuffer[0].length)) {
		var _1d7 = ind - this.rowsCol.length;
		this.rowsBuffer[0]._dhx_insertAt(_1d7, _1d3);
		this.rowsBuffer[1]._dhx_insertAt(_1d7, row);
		return row;
	}
	return this._insertRowAt(row, ind);
};
dhtmlXGridObject.prototype.setRowHidden = function (id, _1d9) {
	var f = convertStringToBoolean(_1d9);
	var row = this.getRowById(id);
	if (!row) {
		return;
	}
	if (row.expand === "") {
		this.collapseKids(row);
	}
	if ((_1d9) && (row.style.display != "none")) {
		row.style.display = "none";
		var z = this.selectedRows._dhx_find(row);
		if (z != -1) {
			row.className = row.className.replace("rowselected", "");
			for (var i = 0; i < row.childNodes.length; i++) {
				row.childNodes[i].className = row.childNodes[i].className.replace(/cellselected/g, "");
			}
			this.selectedRows._dhx_removeAt(z);
		}
		this.callEvent("onGridReconstructed", []);
	}
	if ((!_1d9) && (row.style.display == "none")) {
		row.style.display = "";
		this.callEvent("onGridReconstructed", []);
	}
	this.setSizes();
};
dhtmlXGridObject.prototype.setColumnHidden = function (ind, _1df) {
	if ((this.fldSorted) && (this.fldSorted.cellIndex == ind) && (_1df)) {
		this.sortImg.style.display = "none";
	}
	var f = convertStringToBoolean(_1df);
	if (f) {
		if (!this._hrrar) {
			this._hrrar = new Array();
		} else {
			if (this._hrrar[ind]) {
				return;
			}
		}
		this._hrrar[ind] = "display:none;";
		this._hideShowColumn(ind, "none");
	} else {
		if ((!this._hrrar) || (!this._hrrar[ind])) {
			return;
		}
		this._hrrar[ind] = "";
		this._hideShowColumn(ind, "");
	}
	if ((this.fldSorted) && (this.fldSorted.cellIndex == ind) && (!_1df)) {
		this.sortImg.style.display = "inline";
	}
};
dhtmlXGridObject.prototype.isColumnHidden = function (ind) {
	if ((this._hrrar) && (this._hrrar[ind])) {
		return true;
	}
	return false;
};
dhtmlXGridObject.prototype.setColHidden = function (list) {
	if (list) {
		this._ivizcol = list.split(",");
	}
	if (this.hdr.rows.length) {
		for (var i = 0; i < this._ivizcol.length; i++) {
			this.setColumnHidden(i, this._ivizcol[i]);
		}
	}
};
dhtmlXGridObject.prototype._fixHiddenRowsAll = function (pb, ind, prop, _1e7) {
	var z = pb.rows.length;
	for (var i = 0; i < z; i++) {
		var x = pb.rows[i].cells;
		if (x.length != this._cCount) {
			for (var j = 0; j < x.length; j++) {
				if (x[j]._cellIndex == ind) {
					x[j].style[prop] = _1e7;
					break;
				}
			}
		} else {
			x[ind].style[prop] = _1e7;
		}
	}
};
dhtmlXGridObject.prototype._hideShowColumn = function (ind, _1ed) {
	var hind = ind;
	if ((this.hdr.rows[1]._childIndexes) && (this.hdr.rows[1]._childIndexes[ind] != ind)) {
		hind = this.hdr.rows[1]._childIndexes[ind];
	}
	if (_1ed == "none") {
		this.hdr.rows[0].cells[ind]._oldWidth = this.hdr.rows[0].cells[ind].style.width;
		this.hdr.rows[0].cells[ind]._oldWidthP = this.cellWidthPC[ind];
		this.obj.rows[0].cells[ind].style.width = "0px";
		this._fixHiddenRowsAll(this.obj, ind, "display", "none");
		if (this._fixHiddenRowsAllTG) {
			this._fixHiddenRowsAllTG(ind, "none");
		}
		if ((_isOpera && _OperaRv < 9) || _isKHTML || (_isFF && _FFrv < 1.8)) {
			this._fixHiddenRowsAll(this.hdr, ind, "display", "none");
			if (this.ftr) {
				this._fixHiddenRowsAll(this.ftr.childNodes[0], ind, "display", "none");
			}
		}
		this._fixHiddenRowsAll(this.hdr, ind, "whiteSpace", "nowrap");
		if (!this.cellWidthPX.length && !this.cellWidthPC.length) {
			this.cellWidthPX = [].concat(this.initCellWidth);
		}
		if (this.cellWidthPX[ind]) {
			this.cellWidthPX[ind] = 0;
		}
		if (this.cellWidthPC[ind]) {
			this.cellWidthPC[ind] = 0;
		}
	} else {
		if (this.hdr.rows[0].cells[ind]._oldWidth) {
			var zrow = this.hdr.rows[0].cells[ind];
			if (_isOpera || _isKHTML || (_isFF && _FFrv < 1.8)) {
				this._fixHiddenRowsAll(this.hdr, ind, "display", "");
			}
			if (this.ftr) {
				this._fixHiddenRowsAll(this.ftr.childNodes[0], ind, "display", "");
			}
			this.obj.rows[0].cells[ind].style.width = this.hdr.rows[0].cells[ind]._oldWidth;
			this._fixHiddenRowsAll(this.obj, ind, "display", "");
			if (this._fixHiddenRowsAllTG) {
				this._fixHiddenRowsAllTG(ind, "");
			}
			zrow.style.width = zrow._oldWidth;
			this._fixHiddenRowsAll(this.hdr, ind, "whiteSpace", "normal");
			if (zrow._oldWidthP) {
				this.cellWidthPC[ind] = zrow._oldWidthP;
			}
			if (zrow._oldWidth) {
				this.cellWidthPX[ind] = parseInt(zrow._oldWidth);
			}
		}
	}
	this.setSizes();
	if ((!_isIE) && (!_isFF)) {
		this.obj.border = 1;
		this.obj.border = 0;
	}
};
dhtmlXGridObject.prototype.enableCollSpan = function (mode) {
	this._ecspn = convertStringToBoolean(mode);
};
dhtmlXGridObject.prototype.enableRowsHover = function (mode, _1f2) {
	this._hvrCss = _1f2;
	if (convertStringToBoolean(mode)) {
		if (!this._elmnh) {
			this.obj._honmousemove = this.obj.onmousemove;
			this.obj.onmousemove = this._setRowHover;
			if (_isIE) {
				this.obj.onmouseleave = this._unsetRowHover;
			} else {
				this.obj.onmouseout = this._unsetRowHover;
			}
			this._elmnh = true;
		}
	} else {
		if (this._elmnh) {
			this.obj.onmousemove = this.obj._honmousemove;
			if (_isIE) {
				this.obj.onmouseleave = null;
			} else {
				this.obj.onmouseout = null;
			}
			this._elmnh = false;
		}
	}
};
dhtmlXGridObject.prototype.enableEditEvents = function (_1f3, _1f4, _1f5) {
	this._sclE = convertStringToBoolean(_1f3);
	this._dclE = convertStringToBoolean(_1f4);
	this._f2kE = convertStringToBoolean(_1f5);
};
dhtmlXGridObject.prototype.enableLightMouseNavigation = function (mode) {
	if (convertStringToBoolean(mode)) {
		if (!this._elmn) {
			this.entBox._onclick = this.entBox.onclick;
			this.entBox.onclick = function () {
				return true;
			};
			this.obj.onclick = function (e) {
				var c = this.grid.getFirstParentOfType(e ? e.target : event.srcElement, "TD");
				this.grid.editStop();
				this.grid.doClick(c);
				this.grid.editCell();
				(e || event).cancelBubble = true;
			};
			this.obj._onmousemove = this.obj.onmousemove;
			this.obj.onmousemove = this._autoMoveSelect;
			this._elmn = true;
		}
	} else {
		if (this._elmn) {
			this.entBox.onclick = this.entBox._onclick;
			this.obj.onclick = function () {
				return true;
			};
			this.obj.onmousemove = this.obj._onmousemove;
			this._elmn = false;
		}
	}
};
dhtmlXGridObject.prototype._unsetRowHover = function (e, c) {
	if (c) {
		that = this;
	} else {
		that = this.grid;
	}
	if ((that._lahRw) && (that._lahRw != c)) {
		for (var i = 0; i < that._lahRw.childNodes.length; i++) {
			that._lahRw.childNodes[i].className = that._lahRw.childNodes[i].className.replace(that._hvrCss, "");
		}
		that._lahRw = null;
	}
};
dhtmlXGridObject.prototype._setRowHover = function (e) {
	var c = this.grid.getFirstParentOfType(e ? e.target : event.srcElement, "TD");
	if (c) {
		this.grid._unsetRowHover(0, c);
		c = c.parentNode;
		for (var i = 0; i < c.childNodes.length; i++) {
			c.childNodes[i].className += " " + this.grid._hvrCss;
		}
		this.grid._lahRw = c;
	}
	this._honmousemove(e);
};
dhtmlXGridObject.prototype._autoMoveSelect = function (e) {
	if (!this.grid.editor) {
		var c = this.grid.getFirstParentOfType(e ? e.target : event.srcElement, "TD");
		if (c.parentNode.idd) {
			this.grid.doClick(c, true, 0);
		}
	}
	this._onmousemove(e);
};
dhtmlXGridObject.prototype.enableDistributedParsing = function (mode, _202, time) {
	_202 = _202 || 10;
	time = time || 250;
	if (convertStringToBoolean(mode)) {
		this._ads_count = _202;
		this._ads_time = time;
	} else {
		this._ads_count = 0;
	}
};
function _contextCall(obj, name, _206, _207, tree, pId, i, n) {
	obj._contextCallTimer = window.setTimeout(function () {
		var res = obj[name](_206, _207, tree, pId, i);
		if (res != -1) {
			obj.callEvent("onXLE", [obj, obj.rowsCol.length]);
		}
	}, n);
	return this;
}
dhtmlXGridObject.prototype.destructor = function () {
	if (this._sizeTime) {
		this._sizeTime = window.clearTimeout(this._sizeTime);
	}
	var a;
	this.xmlLoader = this.xmlLoader.destructor();
	for (var i = 0; i < this.rowsCol.length; i++) {
		if (this.rowsCol[i]) {
			this.rowsCol[i].grid = null;
		}
	}
	for (i in this.rowsAr) {
		if (this.rowsAr[i]) {
			this.rowsAr[i] = null;
		}
	}
	this.rowsCol = new dhtmlxArray();
	this.rowsAr = new Array();
	this.entBox.innerHTML = "";
	this.entBox.onclick = function () {
	};
	this.entBox.onmousedown = function () {
	};
	this.entBox.onbeforeactivate = function () {
	};
	this.entBox.onbeforedeactivate = function () {
	};
	this.entBox.onbeforedeactivate = function () {
	};
	this.entBox.onselectstart = function () {
	};
	this.entBox.grid = null;
	for (a in this) {
		if ((this[a]) && (this[a].m_obj)) {
			this[a].m_obj = null;
		}
		this[a] = null;
	}
	if (this == globalActiveDHTMLGridObject) {
		globalActiveDHTMLGridObject = null;
	}
	return null;
};
dhtmlXGridObject.prototype.getSortingState = function () {
	var z = new Array();
	if (this.fldSorted) {
		z[0] = this.fldSorted._cellIndex;
		z[1] = (this.sortImg.src.indexOf("sort_desc.gif") != -1) ? "des" : "asc";
	}
	return z;
};
dhtmlXGridObject.prototype.enableAutoHeight = function (mode, _211, _212) {
	this._ahgr = convertStringToBoolean(mode);
	this._ahgrF = convertStringToBoolean(_212);
	this._ahgrM = _211 || null;
	if (_211 == "auto") {
		this._ahgrM = null;
		this._ahgrMA = true;
		this._setAutoResize();
	}
};
dhtmlXGridObject.prototype.enableAutoHeigth = dhtmlXGridObject.prototype.enableAutoHeight;
dhtmlXGridObject.prototype.enableStableSorting = function (mode) {
	this._sst = convertStringToBoolean(mode);
	this.rowsCol.stablesort = function (cmp) {
		var size = this.length - 1;
		for (var i = 0; i < this.length - 1; i++) {
			for (var j = 0; j < size; j++) {
				if (cmp(this[j], this[j + 1]) > 0) {
					var temp = this[j];
					this[j] = this[j + 1];
					this[j + 1] = temp;
				}
			}
			size--;
		}
	};
};
dhtmlXGridObject.prototype.enableKeyboardSupport = function (mode) {
	this._htkebl = !convertStringToBoolean(mode);
};
dhtmlXGridObject.prototype.enableContextMenu = function (menu) {
	this._ctmndx = menu;
};
dhtmlXGridObject.prototype.setOnBeforeContextMenu = function (func) {
	this.attachEvent("onBeforeContextMenu", func);
};
dhtmlXGridObject.prototype.setOnRightClick = function (func) {
	this.attachEvent("onRightClick", func);
};
dhtmlXGridObject.prototype.setScrollbarWidthCorrection = function (_21d) {
	this._scrFix = parseInt(_21d);
};
dhtmlXGridObject.prototype.enableTooltips = function (list) {
	this._enbTts = list.split(",");
	for (var i = 0; i < this._enbTts.length; i++) {
		this._enbTts[i] = convertStringToBoolean(this._enbTts[i]);
	}
};
dhtmlXGridObject.prototype.enableResizing = function (list) {
	this._drsclmn = list.split(",");
	for (var i = 0; i < this._drsclmn.length; i++) {
		this._drsclmn[i] = convertStringToBoolean(this._drsclmn[i]);
	}
};
dhtmlXGridObject.prototype.setColumnMinWidth = function (_222, ind) {
	if (arguments.length == 2) {
		if (!this._drsclmW) {
			this._drsclmW = new Array();
		}
		this._drsclmW[ind] = _222;
	} else {
		this._drsclmW = _222.split(",");
	}
};
dhtmlXGridObject.prototype.enableCellIds = function (mode) {
	this._enbCid = convertStringToBoolean(mode);
};
dhtmlXGridObject.prototype.lockRow = function (_225, mode) {
	var z = this.getRowById(_225);
	if (z) {
		z._locked = convertStringToBoolean(mode);
		if ((this.cell) && (this.cell.parentNode.idd == _225)) {
			this.editStop();
		}
	}
};
dhtmlXGridObject.prototype._getRowArray = function (row) {
	var text = new Array();
	for (var ii = 0; ii < row.childNodes.length; ii++) {
		var a = this.cells3(row, ii);
		if (a.cell._code) {
			text[ii] = a.cell._val;
		} else {
			text[ii] = a.getValue();
		}
	}
	return text;
};
dhtmlXGridObject.prototype.setDateFormat = function (mask) {
	this._dtmask = mask;
};
dhtmlXGridObject.prototype.setNumberFormat = function (mask, cInd, _22f, _230) {
	var _231 = mask.replace(/[^0\,\.]*/g, "");
	var pfix = _231.indexOf(".");
	if (pfix > -1) {
		pfix = _231.length - pfix - 1;
	}
	var dfix = _231.indexOf(",");
	if (dfix > -1) {
		dfix = _231.length - pfix - 2 - dfix;
	}
	_22f = _22f || ".";
	_230 = _230 || ",";
	var pref = mask.split(_231)[0];
	var _235 = mask.split(_231)[1];
	this._maskArr[cInd] = [pfix, dfix, pref, _235, _22f, _230];
};
dhtmlXGridObject.prototype._aplNFb = function (data, ind) {
	var a = this._maskArr[ind];
	if (!a) {
		return data;
	}
	var _239 = parseFloat(data.toString().replace(/[^0-9]*/g, ""));
	if (data.toString().substr(0, 1) == "-") {
		_239 = _239 * -1;
	}
	if (a[0] > 0) {
		_239 = _239 / Math.pow(10, a[0]);
	}
	return _239;
};
dhtmlXGridObject.prototype._aplNF = function (data, ind) {
	var a = this._maskArr[ind];
	if (!a) {
		return data;
	}
	var c = (parseFloat(data) < 0 ? "-" : "") + a[2];
	data = Math.abs(Math.round(parseFloat(data) * Math.pow(10, a[0] > 0 ? a[0] : 0))).toString();
	data = (data.length < a[0] ? Math.pow(10, a[0] + 1 - data.length).toString().substr(1, a[0] + 1) + data.toString() : data).split("").reverse();
	data[a[0]] = (data[a[0]] || "0") + a[4];
	if (a[1] > 0) {
		for (var j = (a[0] > 0 ? 0 : 1) + a[0] + a[1]; j < data.length; j += a[1]) {
			data[j] += a[5];
		}
	}
	return c + data.reverse().join("") + a[3];
};
dhtmlXGridObject.prototype._launchCommands = function (arr) {
	for (var i = 0; i < arr.length; i++) {
		var args = new Array();
		for (var j = 0; j < arr[i].childNodes.length; j++) {
			if (arr[i].childNodes[j].nodeType == 1) {
				args[args.length] = arr[i].childNodes[j].firstChild.data;
			}
		}
		this[arr[i].getAttribute("command")].apply(this, args);
	}
};
dhtmlXGridObject.prototype._parseHead = function (_243) {
	var _244 = this.xmlLoader.doXPath("//rows/head", _243);
	if (_244.length) {
		var _245 = this.xmlLoader.doXPath("//rows/head/column", _244[0]);
		var _246 = this.xmlLoader.doXPath("//rows/head/settings", _244[0]);
		var _247 = "setInitWidths";
		var _248 = false;
		if (_246[0]) {
			for (var s = 0; s < _246[0].childNodes.length; s++) {
				switch (_246[0].childNodes[s].tagName) {
				  case "colwidth":
					if (_246[0].childNodes[s].firstChild && _246[0].childNodes[s].firstChild.data == "%") {
						_247 = "setInitWidthsP";
					}
					break;
				  case "splitat":
					_248 = (_246[0].childNodes[s].firstChild ? _246[0].childNodes[s].firstChild.data : false);
					break;
				}
			}
		}
		this._launchCommands(this.xmlLoader.doXPath("//rows/head/beforeInit/call", _244[0]));
		if (_245.length > 0) {
			var _24a = "";
			var _24b = "";
			var _24c = "";
			var _24d = "";
			var _24e = "";
			var _24f = "";
			var _250 = "";
			var _251 = [];
			for (var i = 0; i < _245.length; i++) {
				_24a += _245[i].getAttribute("width") + ",";
				_24b += _245[i].getAttribute("type") + ",";
				_24c += (_245[i].getAttribute("align") || "left") + ",";
				_24d += _245[i].getAttribute("sort") + ",";
				_24e += (_245[i].getAttribute("color") != null ? _245[i].getAttribute("color") : "") + ",";
				_24f += (_245[i].firstChild ? _245[i].firstChild.data : "").replace(/^\s*((.|\n)*.+)\s*$/gi, "$1") + ",";
				_251[i] = _245[i].getAttribute("format");
				_250 += _245[i].getAttribute("id") + ",";
			}
			this.setHeader(_24f.substr(0, _24f.length - 1));
			this[_247](_24a.substr(0, _24a.length - 1));
			this.setColAlign(_24c.substr(0, _24c.length - 1));
			this.setColTypes(_24b.substr(0, _24b.length - 1));
			this.setColSorting(_24d.substr(0, _24d.length - 1));
			this.setColumnColor(_24e.substr(0, _24e.length - 1));
			this.setColumnIds(_250.substr(0, _250.length - 1));
			for (var i = 0; i < _245.length; i++) {
				if ((this.cellType[i].indexOf("co") == 0) || (this.cellType[i] == "clist")) {
					var _253 = this.xmlLoader.doXPath("./option", _245[i]);
					if (_253.length) {
						var _254 = new Array();
						if (this.cellType[i] == "clist") {
							for (var j = 0; j < _253.length; j++) {
								_254[_254.length] = _253[j].firstChild ? _253[j].firstChild.data : "";
							}
							this.registerCList(i, _254);
						} else {
							var _256 = this.getCombo(i);
							for (var j = 0; j < _253.length; j++) {
								_256.put(_253[j].getAttribute("value"), _253[j].firstChild ? _253[j].firstChild.data : "");
							}
						}
					}
				} else {
					if (_251[i]) {
						if ((this.cellType[i] == "calendar") || (this.fldSort[i] == "date")) {
							this.setDateFormat(_251[i], i);
						} else {
							this.setNumberFormat(_251[i], i);
						}
					}
				}
			}
			this.init();
			if ((_248) && (this.splitAt)) {
				this.splitAt(_248);
			}
		}
		this._launchCommands(this.xmlLoader.doXPath("//rows/head/afterInit/call", _244[0]));
	}
	var _257 = this.xmlLoader.doXPath("//rows/userdata", _243);
	if (_257.length > 0) {
		if (!this.UserData["gridglobaluserdata"]) {
			this.UserData["gridglobaluserdata"] = new Hashtable();
		}
		for (var j = 0; j < _257.length; j++) {
			this.UserData["gridglobaluserdata"].put(_257[j].getAttribute("name"), _257[j].firstChild ? _257[j].firstChild.data : "");
		}
	}
};
dhtmlXGridObject.prototype.parseXML = function (xml, _259) {
	this._xml_ready = true;
	var pid = null;
	var zpid = null;
	if (!xml) {
		try {
			var _25c = eval(this.entBox.id + "_xml").XMLDocument;
		}
		catch (er) {
			var _25c = this.loadXML(this.xmlFileUrl);
		}
	} else {
		if (typeof (xml) == "object") {
			var _25c = xml;
		} else {
			if (xml.indexOf(".") != -1) {
				if (this.xmlFileUrl == "") {
					this.xmlFileUrl = xml;
				}
				var _25c = this.loadXML(xml);
				return;
			} else {
				var _25c = eval(xml).XMLDocument;
			}
		}
	}
	var ar = new Array();
	var idAr = new Array();
	var _25f = this.xmlLoader.doXPath("//rows", _25c);
	if (_25f[0] && _25f[0].getAttribute("total_count")) {
		this.limit = _25f[0].getAttribute("total_count");
	}
	this._parseHead(_25c);
	var tree = this.cellType._dhx_find("tree");
	var _261 = this.xmlLoader.doXPath("//rows/row", _25c);
	if (_261.length == 0) {
		this.recordsNoMore = true;
		var top = this.xmlLoader.doXPath("//rows", _25c);
		if (!top) {
			return;
		}
		var pid = (top[0].getAttribute("parent") || 0);
		if ((tree != -1) && (this.rowsAr[pid])) {
			var _263 = this.rowsAr[pid].childNodes[tree];
			_263.innerHTML = _263.innerHTML.replace(/\/(plus)\.gif/, "/blank.gif");
		}
	} else {
		pid = (_261[0].parentNode.getAttribute("parent") || null);
		zpid = this.getRowById(pid);
		if (zpid) {
			zpid._xml_await = false;
		} else {
			pid = null;
		}
		_259 = this.getRowIndex(pid) + 1;
	}
	if (tree == -1) {
		tree = this.cellType._dhx_find("3d");
	}
	if (this._innerParse(_261, _259, tree, pid) == -1) {
		return;
	}
	if (zpid) {
		this.expandKids(zpid);
	}
	if (this.dynScroll && this.dynScroll != "false") {
		this.doDynScroll();
	}
	if (tree != -1) {
		var oCol = this.xmlLoader.doXPath("//row[@open]", _25c);
		for (var i = 0; i < oCol.length; i++) {
			this.openItem(oCol[i].getAttribute("id"));
		}
	}
	this.setSizes();
	if (_isOpera) {
		this.obj.style.border = 1;
		this.obj.style.border = 0;
	}
	this._startXMLLoading = false;
	this.callEvent("onXLE", [this, _261.length]);
};
dhtmlXGridObject.prototype._postRowProcessing = function (r, xml) {
	var rId = xml.getAttribute("id");
	var _269 = xml.getAttribute("style");
	var _26a = this.xmlLoader.doXPath("./userdata", xml);
	if (_26a.length > 0) {
		if (!this.UserData[rId]) {
			this.UserData[rId] = new Hashtable();
		}
		for (var j = 0; j < _26a.length; j++) {
			this.UserData[rId].put(_26a[j].getAttribute("name"), _26a[j].firstChild ? _26a[j].firstChild.data : "");
		}
	}
	var css1 = xml.getAttribute("class");
	if (css1) {
		r.className += (r._css = " " + css1);
	}
	var css1 = xml.getAttribute("bgColor");
	if (css1) {
		for (var i = 0; i < r.childNodes.length; i++) {
			r.childNodes[i].bgColor = css1;
		}
	}
	if (xml.getAttribute("locked")) {
		r._locked = true;
	}
	if (xml.getAttribute("selected") == true) {
		this.setSelectedRow(rId, this.selMultiRows, false, xml.getAttribute("call") == true);
	}
	if (_269) {
		this.setRowTextStyle(rId, _269);
	}
	this.callEvent("onRowCreated", [r.idd, r, xml]);
};
dhtmlXGridObject.prototype._fillRowFromXML = function (r, xml, tree, pId) {
	var _272 = this.xmlLoader.doXPath("./cell", xml);
	var _273 = new Array(0);
	for (var j = 0; j < _272.length; j++) {
		var _275 = _272[j];
		var exc = _275.getAttribute("type");
		if (_275.getAttribute("xmlcontent")) {
			_275 = _272[j];
		} else {
			if (_275.firstChild) {
				_275 = _275.firstChild.data;
			} else {
				_275 = "";
			}
		}
		if (j != tree) {
			_273[_273.length] = _275;
		} else {
			_273[_273.length] = [pId, _275, ((xml.getAttribute("xmlkids") || r._xml) ? "1" : "0"), (_272[j].getAttribute("image") || "leaf.gif")];
		}
		if (exc) {
			r.childNodes[j]._cellType = exc;
		}
	}
	if (this._c_order) {
		_273 = this._swapColumns(_273);
	}
	for (var j = 0; j < _272.length; j++) {
		var css1 = _272[j].getAttribute("class");
		if (css1) {
			r.childNodes[j].className += " " + css1;
		}
		css1 = _272[j].getAttribute("style");
		if (css1) {
			r.childNodes[j].style.textCSS += css1;
		}
		css1 = _272[j].getAttribute("title");
		if (css1) {
			r.childNodes[j].title = css1;
		}
	}
	this._fillRow(r, _273);
	if (this._ecspn) {
		r._childIndexes = new Array();
		var _278 = 0;
		var l = this.obj.rows[0].childNodes.length;
		for (var j = 0; j < l; j++) {
			r._childIndexes[j] = j - _278;
			if (!_272[j]) {
				continue;
			}
			var col = _272[j].getAttribute("colspan");
			if (col) {
				r.childNodes[j - _278].colSpan = col;
				for (var z = 1; z < col; z++) {
					r.removeChild(r.childNodes[j - _278 + 1]);
					r._childIndexes[j + z] = j - _278;
				}
				_278 += (col - 1);
				j += (col - 1);
			}
		}
		if (!_278) {
			r._childIndexes = null;
		}
	}
	if ((r.parentNode) && (r.parentNode.tagName)) {
		this._postRowProcessing(r, xml);
	}
	return r;
};
dhtmlXGridObject.prototype._innerParse = function (_27c, _27d, tree, pId, i) {
	i = i || 0;
	var imax = i + this._ads_count * 1;
	var r = null;
	var _283;
	for (var i; i < _27c.length; i++) {
		if (this._ads_count && i == imax) {
			new _contextCall(this, "_innerParse", _27c, _27d, tree, pId, i, this._ads_time);
			return -1;
		}
		if ((pId) || (i < this.rowsBufferOutSize || this.rowsBufferOutSize == 0)) {
			this._parsing_ = true;
			var rId = (_27c[i].getAttribute("id") || (this.rowsCol.length + 2));
			r = this._prepareRow(rId);
			if (tree != -1) {
				_283 = this.xmlLoader.doXPath("./row", _27c[i]);
				if ((_283.length != 0) && (this._slowParse)) {
					r._xml = _283;
				}
			}
			r = this._fillRowFromXML(r, _27c[i], tree, pId);
			if (_27d) {
				r = this._insertRowAt(r, _27d);
				_27d++;
			} else {
				r = this._insertRowAt(r);
			}
			this._postRowProcessing(r, _27c[i]);
			this._parsing_ = false;
		} else {
			var len = this.rowsBuffer[0].length;
			this.rowsBuffer[1][len] = _27c[i];
			this.rowsBuffer[0][len] = _27c[i].getAttribute("id");
		}
		if ((tree != -1) && (_283.length != 0) && (!this._slowParse)) {
			_27d = this._innerParse(_283, _27d, tree, rId);
		}
	}
	if (this.pagingOn && this.rowsBuffer[0].length > 0) {
		this.changePage(this.currentPage);
	}
	if ((r) && (this._checkSCL)) {
		for (var i = 0; i < this.hdr.rows[0].cells.length; i++) {
			this._checkSCL(r.childNodes[i]);
		}
	}
	return _27d;
};
dhtmlXGridObject.prototype.getCheckedRows = function (_286) {
	var d = new Array();
	for (var i = 0; i < this.rowsCol.length; i++) {
		if ((this.rowsCol[i]) && (!this.rowsCol[i]._sRow) && (this.cells3(this.rowsCol[i], _286).getValue() != "0")) {
			d[d.length] = this.rowsCol[i].idd;
		}
	}
	return d.join(",");
};
dhtmlXGridObject.prototype._drawTooltip = function (e) {
	var c = this.grid.getFirstParentOfType(e ? e.target : event.srcElement, "TD");
	if ((this.grid.editor) && (this.grid.editor.cell == c)) {
		return true;
	}
	var r = c.parentNode;
	var el = (e ? e.target : event.srcElement);
	if (r.idd == window.unknown) {
		return true;
	}
	if (!this.grid.callEvent("onMouseOver", [r.idd, c._cellIndex])) {
		return true;
	}
	if ((this.grid._enbTts) && (!this.grid._enbTts[c._cellIndex])) {
		if (el.title) {
			el.title = "";
		}
		return true;
	}
	var ced = this.grid.cells(r.idd, c._cellIndex);
	if (ced) {
		el.title = ced.cell.title || (ced.getTitle ? ced.getTitle() : (ced.getValue() || "").toString().replace(/<[^>]*>/gi, ""));
	}
	return true;
};
dhtmlXGridObject.prototype.enableCellWidthCorrection = function (size) {
	if (_isFF) {
		this._wcorr = parseInt(size);
	}
};
dhtmlXGridObject.prototype.getAllItemIds = function (_28f) {
	var ar = new Array(0);
	for (i = 0; i < this.rowsCol.length; i++) {
		ar[ar.length] = this.rowsCol[i].idd;
	}
	for (i = 0; i < this.rowsBuffer[0].length; i++) {
		ar[ar.length] = this.rowsBuffer[0][i];
	}
	return ar.join(_28f || ",");
};
dhtmlXGridObject.prototype.deleteRow = function (_291, node) {
	if (!node) {
		node = this.getRowById(_291);
	}
	if (!node) {
		return;
	}
	this.editStop();
	if (this.callEvent("onBeforeRowDeleted", [_291]) == false) {
		return false;
	}
	if (this.cellType._dhx_find("tree") != -1) {
		this._removeTrGrRow(node);
	} else {
		if (node.parentNode) {
			node.parentNode.removeChild(node);
		}
		var ind = this.rowsCol._dhx_find(node);
		if (ind != -1) {
			this.rowsCol._dhx_removeAt(ind);
		} else {
			ind = this.rowsBuffer[0]._dhx_find(_291);
			if (ind >= 0) {
				this.rowsBuffer[0]._dhx_removeAt(ind);
				this.rowsBuffer[1]._dhx_removeAt(ind);
			}
		}
		this.rowsAr[_291] = null;
	}
	for (var i = 0; i < this.selectedRows.length; i++) {
		if (this.selectedRows[i].idd == _291) {
			this.selectedRows._dhx_removeAt(i);
		}
	}
	this.callEvent("onGridReconstructed", []);
	if (this.pagingOn) {
		this.changePage();
	}
	this.setSizes();
	return true;
};
dhtmlXGridObject.prototype.setColspan = function (_295, _296, _297) {
	if (!this._ecspn) {
		return;
	}
	var r = this.getRowById(_295);
	if ((r._childIndexes) && (r.childNodes[r._childIndexes[_296]])) {
		var j = r._childIndexes[_296];
		var n = r.childNodes[j];
		var m = n.colSpan;
		n.colSpan = 1;
		if ((m) && (m != 1)) {
			for (var i = 1; i < m; i++) {
				var c = document.createElement("TD");
				if (n.nextSibling) {
					r.insertBefore(c, n.nextSibling);
				} else {
					r.appendChild(c);
				}
				r._childIndexes[_296 + i] = j + i;
				c._cellIndex = _296 + i;
				c.align = this.cellAlign[i];
				c.style.verticalAlign = this.cellVAlign[i];
				n = c;
				this.cells3(r, j + i).setValue("");
			}
		}
		for (var z = _296 * 1 + 1 * m; z < r._childIndexes.length; z++) {
			r._childIndexes[z] += (m - 1) * 1;
		}
	}
	if ((_297) && (_297 > 1)) {
		if (r._childIndexes) {
			var j = r._childIndexes[_296];
		} else {
			var j = _296;
			r._childIndexes = new Array();
			for (var z = 0; z < r.childNodes.length; z++) {
				r._childIndexes[z] = z;
			}
		}
		r.childNodes[j].colSpan = _297;
		for (var z = 1; z < _297; z++) {
			r._childIndexes[r.childNodes[j + 1]._cellIndex] = j;
			r.removeChild(r.childNodes[j + 1]);
		}
		var c1 = r.childNodes[r._childIndexes[_296]]._cellIndex;
		for (var z = c1 * 1 + 1 * _297; z < r._childIndexes.length; z++) {
			r._childIndexes[z] -= (_297 - 1);
		}
	}
};
dhtmlXGridObject.prototype.preventIECaching = function (mode) {
	this.no_cashe = convertStringToBoolean(mode);
	this.xmlLoader.rSeed = this.no_cashe;
};
dhtmlXGridObject.prototype.preventIECashing = dhtmlXGridObject.prototype.preventIECaching;
dhtmlXGridObject.prototype.enableColumnAutoSize = function (mode) {
	this._eCAS = convertStringToBoolean(mode);
};
dhtmlXGridObject.prototype._onHeaderDblClick = function (e) {
	var that = this.grid;
	var el = that.getFirstParentOfType(_isIE ? event.srcElement : e.target, "TD");
	if (!that._eCAS) {
		return false;
	}
	that.adjustColumnSize(el._cellIndexS);
};
dhtmlXGridObject.prototype.adjustColumnSize = function (cInd) {
	this._notresize = true;
	var m = 0;
	this._setColumnSizeR(cInd, 20);
	for (var j = 1; j < this.hdr.rows.length; j++) {
		var a = this.hdr.rows[j];
		a = a.childNodes[(a._childIndexes) ? a._childIndexes[cInd] : cInd];
		if ((a) && ((!a.colSpan) || (a.colSpan < 2))) {
			if ((a.childNodes[0]) && (a.childNodes[0].className == "hdrcell")) {
				a = a.childNodes[0];
			}
			m += a.scrollWidth;
		}
	}
	var l = this.obj._rowslength();
	for (var i = 0; i < l; i++) {
		var z = this.obj._rows(i);
		if (z._childIndexes && z._childIndexes[cInd] != cInd) {
			continue;
		}
		if (_isFF || _isOpera) {
			z = z.childNodes[cInd].textContent.length * 7;
		} else {
			z = z.childNodes[cInd].scrollWidth;
		}
		if (z > m) {
			m = z;
		}
	}
	m += 20;
	this._setColumnSizeR(cInd, m);
	this._notresize = false;
	this.setSizes();
};
dhtmlXGridObject.prototype.attachHeader = function (_2ac, _2ad, _2ae) {
	if (typeof (_2ac) == "string") {
		_2ac = this._eSplit(_2ac);
	}
	if (typeof (_2ad) == "string") {
		_2ad = _2ad.split(this.delim);
	}
	_2ae = _2ae || "_aHead";
	if (this.hdr.rows.length) {
		if (_2ac) {
			this._createHRow([_2ac, _2ad], this[(_2ae == "_aHead") ? "hdr" : "ftr"]);
		} else {
			if (this[_2ae]) {
				for (var i = 0; i < this[_2ae].length; i++) {
					this.attachHeader.apply(this, this[_2ae][i]);
				}
			}
		}
	} else {
		if (!this[_2ae]) {
			this[_2ae] = new Array();
		}
		this[_2ae][this[_2ae].length] = [_2ac, _2ad, _2ae];
	}
};
dhtmlXGridObject.prototype._createHRow = function (data, _2b1) {
	if (!_2b1) {
		this.entBox.style.position = "relative";
		var z = document.createElement("DIV");
		z.className = "ftr";
		this.entBox.appendChild(z);
		var t = document.createElement("TABLE");
		t.cellPadding = t.cellSpacing = 0;
		if (!_isIE) {
			t.width = "100%";
			t.style.paddingRight = "20px";
		}
		t.style.tableLayout = "fixed";
		z.appendChild(t);
		t.appendChild(document.createElement("TBODY"));
		this.ftr = _2b1 = t;
		var _2b4 = t.insertRow(0);
		var thl = ((this.hdrLabels.length <= 1) ? data[0].length : this.hdrLabels.length);
		for (var i = 0; i < thl; i++) {
			_2b4.appendChild(document.createElement("TH"));
			_2b4.childNodes[i]._cellIndex = i;
		}
		if (_isIE) {
			_2b4.style.position = "absolute";
		} else {
			_2b4.style.height = "auto";
		}
	}
	var st1 = data[1];
	var z = document.createElement("TR");
	_2b1.rows[0].parentNode.appendChild(z);
	for (var i = 0; i < data[0].length; i++) {
		if (data[0][i] == "#cspan") {
			var pz = z.cells[z.cells.length - 1];
			pz.colSpan = (pz.colSpan || 1) + 1;
			continue;
		}
		if ((data[0][i] == "#rspan") && (_2b1.rows.length > 1)) {
			var pind = _2b1.rows.length - 2;
			var _2ba = false;
			var pz = null;
			while (!_2ba) {
				var pz = _2b1.rows[pind];
				for (var j = 0; j < pz.cells.length; j++) {
					if (pz.cells[j]._cellIndex == i) {
						_2ba = j + 1;
						break;
					}
				}
				pind--;
			}
			pz = pz.cells[_2ba - 1];
			pz.rowSpan = (pz.rowSpan || 1) + 1;
			continue;
		}
		var w = document.createElement("TD");
		w._cellIndex = w._cellIndexS = i;
		if (this.forceDivInHeader) {
			w.innerHTML = "<div class='hdrcell'>" + data[0][i] + "</div>";
		} else {
			w.innerHTML = data[0][i];
		}
		if (st1) {
			w.style.cssText = st1[i];
		}
		z.appendChild(w);
	}
	var self = _2b1;
	if (_isKHTML) {
		if (_2b1._kTimer) {
			window.clearTimeout(_2b1._kTimer);
		}
		_2b1._kTimer = window.setTimeout(function () {
			_2b1.rows[1].style.display = "none";
			window.setTimeout(function () {
				_2b1.rows[1].style.display = "";
			}, 1);
		}, 500);
	}
};
dhtmlXGridObject.prototype.attachFooter = function (_2be, _2bf) {
	this.attachHeader(_2be, _2bf, "_aFoot");
};
dhtmlXGridObject.prototype.setCellExcellType = function (_2c0, _2c1, type) {
	this.changeCellType(this.rowsAr[_2c0], _2c1, type);
};
dhtmlXGridObject.prototype.changeCellType = function (r, ind, type) {
	type = type || this.cellType[ind];
	var z = this.cells3(r, ind);
	var v = z.getValue();
	z.cell._cellType = type;
	var z = this.cells3(r, ind);
	z.setValue(v);
};
dhtmlXGridObject.prototype.setRowExcellType = function (_2c8, type) {
	var z = this.rowsAr[_2c8];
	for (var i = 0; i < z.childNodes.length; i++) {
		this.changeCellType(z, i, type);
	}
};
dhtmlXGridObject.prototype.setColumnExcellType = function (_2cc, type) {
	for (var i = 0; i < this.rowsCol.length; i++) {
		this.changeCellType(this.rowsCol[i], _2cc, type);
	}
};
dhtmlXGridObject.prototype.findCell = function (_2cf, _2d0, _2d1) {
	var res = new Array();
	if (!this.rowsCol.length) {
		return res;
	}
	for (var i = (_2d0 || 0); i < this.cellType.length; i++) {
		var z = this.cells4(this.rowsCol[0].childNodes[i]);
		for (var j = 0; j < this.rowsCol.length; j++) {
			z.cell = this.rowsCol[j].childNodes[i];
			var val = z.getValue();
			if ((val || "").toString().indexOf(_2cf) != -1) {
				res[res.length] = [j, i];
			}
			if (_2d1 && this.rowsCol.length == j + 1) {
				this.addRowsFromBuffer();
			}
		}
		if (typeof (_2d0) != "undefined") {
			return res;
		}
	}
	return res;
};
dhtmlXGridObject.prototype.dhx_Event = function () {
	this.dhx_SeverCatcherPath = "";
	this.attachEvent = function (_2d7, _2d8, _2d9) {
		_2d9 = _2d9 || this;
		_2d7 = "ev_" + _2d7;
		if ((!this[_2d7]) || (!this[_2d7].addEvent)) {
			var z = new this.eventCatcher(_2d9);
			z.addEvent(this[_2d7]);
			this[_2d7] = z;
		}
		return (_2d7 + ":" + this[_2d7].addEvent(_2d8));
	};
	this.callEvent = function (name, arg0) {
		if (this["ev_" + name]) {
			return this["ev_" + name].apply(this, arg0);
		}
		return true;
	};
	this.checkEvent = function (name) {
		if (this["ev_" + name]) {
			return true;
		}
		return false;
	};
	this.eventCatcher = function (obj) {
		var _2df = new Array();
		var _2e0 = obj;
		var _2e1 = function (_2e2, rpc) {
			_2e2 = _2e2.split(":");
			var _2e4 = "";
			var _2e5 = "";
			var _2e6 = _2e2[1];
			if (_2e2[1] == "rpc") {
				_2e4 = "<?xml version=\"1.0\"?><methodCall><methodName>" + _2e2[2] + "</methodName><params>";
				_2e5 = "</params></methodCall>";
				_2e6 = rpc;
			}
			var z = function () {
			};
			return z;
		};
		var z = function () {
			if (_2df) {
				var res = true;
			}
			for (var i = 0; i < _2df.length; i++) {
				if (_2df[i] != null) {
					var zr = _2df[i].apply(_2e0, arguments);
					res = res && zr;
				}
			}
			return res;
		};
		z.addEvent = function (ev) {
			if (typeof (ev) != "function") {
				if (ev && ev.indexOf && ev.indexOf("server:") == 0) {
					ev = new _2e1(ev, _2e0.rpcServer);
				} else {
					ev = eval(ev);
				}
			}
			if (ev) {
				return _2df.push(ev) - 1;
			}
			return false;
		};
		z.removeEvent = function (id) {
			_2df[id] = null;
		};
		return z;
	};
	this.detachEvent = function (id) {
		if (id != false) {
			var list = id.split(":");
			this[list[0]].removeEvent(list[1]);
		}
	};
};
dhtmlXGridObject.prototype.forEachRow = function (_2f0) {
	for (a in this.rowsAr) {
		if (this.rowsAr[a] && this.rowsAr[a].tagName) {
			_2f0.apply(this, [this.rowsAr[a].idd]);
		}
	}
};
dhtmlXGridObject.prototype.forEachCell = function (_2f1, _2f2) {
	var z = this.rowsAr[_2f1];
	if (!z) {
		return;
	}
	for (var i = 0; i < this._cCount; i++) {
		_2f2(this.cells3(z, i));
	}
};
dhtmlXGridObject.prototype.enableAutoWidth = function (mode, _2f6, _2f7) {
	this._awdth = [convertStringToBoolean(mode), (_2f6 || 99999), (_2f7 || 0)];
};
dhtmlXGridObject.prototype.setOnKeyPressed = function (func) {
	this.attachEvent("onKeyPress", func);
};
dhtmlXGridObject.prototype.updateFromXML = function (url, _2fa, _2fb, _2fc) {
	this._refresh_mode = [true, _2fa, _2fb];
	if (_2fc) {
		this.xmlLoader.waitCall = _2fc;
	}
	this.callEvent("onXLS", [this]);
	this.xmlLoader.loadXML(url);
};
dhtmlXGridObject.prototype.updateFromXMl = dhtmlXGridObject.prototype.updateFromXML;
dhtmlXGridObject.prototype._refreshFromXML = function (xml) {
	if (window.eXcell_tree) {
		eXcell_tree.prototype.setValueX = eXcell_tree.prototype.setValue;
		eXcell_tree.prototype.setValue = function (_2fe) {
			if (this.grid._h2.get[this.cell.parentNode.idd]) {
				this.setValueA(_2fe[1]);
			} else {
				this.setValueX(_2fe);
			}
		};
	}
	var tree = this.cellType._dhx_find("tree");
	var pid = xml.doXPath("//rows")[0].getAttribute("parent") || 0;
	var del = {};
	if (this._refresh_mode[2]) {
		this.forEachRow(function (id) {
			del[id] = true;
		});
	}
	var rows = xml.doXPath("//row");
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		var id = row.getAttribute("id");
		del[id] = false;
		if (this._dload) {
			if (this.rowsAr[id]) {
				this._fillRowFromXML(this.rowsAr[id], row, -1);
			} else {
				var z = this.rowsBuffer[0]._dhx_find(id);
				if (z != -1) {
					this.rowsBuffer[1][z] = row;
				}
			}
		} else {
			if (this.rowsAr[id]) {
				this._fillRowFromXML(this.rowsAr[id], row, tree, pid);
			} else {
				var r = this._prepareRow(id);
				r = this._fillRowFromXML(r, row, tree, pid);
				if (tree != -1 && this._h2.get[pid].state == "minus") {
					r = this._insertRowAt(r, this.getRowIndex(pid) + this._getOpenLenght(pid, 0));
				} else {
					r = this._insertRowAt(r);
				}
			}
		}
	}
	if (this._refresh_mode[2]) {
		for (id in del) {
			if (del[id] && this.rowsAr[id]) {
				this.deleteRow(id);
			}
		}
	}
	if (window.eXcell_tree) {
		eXcell_tree.prototype.setValue = eXcell_tree.prototype.setValueX;
	}
	this.callEvent("onXLE", [this, rows.length]);
};
