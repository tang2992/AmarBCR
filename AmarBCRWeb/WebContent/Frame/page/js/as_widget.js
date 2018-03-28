


var Layout = {
		_map : {},






		getRegionName : function(areaName){
			if(this._map[areaName]) return this._map[areaName];
			if(self != parent && parent.Layout){
				return parent.Layout.getRegionName(areaName);
			}
			return areaName;
		},





		getFrame : function(areaName){
			areaName = this.getRegionName(areaName);
			if(frames[areaName]) return frames[areaName];
			var win = self;
			while(win != win.parent){
				if(win.parent.frames[areaName])
					return win.parent.frames[areaName];
			}
		},








		initRegionName : function(areaName, upTarget, defaultRegionName){
			if(defaultRegionName) return this._map[areaName] = defaultRegionName;
			if(typeof(upTarget)=="undefined" || upTarget=="_self")  return this._map[areaName] = areaName + "_self";
			else 	return this._map[areaName] = areaName + "_"+upTarget;
		}
};




var AsLink = {






		setShortcut : function(key, fun, doc){
			doc = doc || document;
			if(!key || typeof fun != "function") return;
			var keys = key.split("+");
			var shift = false, ctrl = false, alt = false, code = null;
			for(var i = 0; i < keys.length; i++){
				if(keys[i]=="Shift")
					shift = true;
				else if(keys[i]=="Ctrl")
					ctrl = true;
				else if(keys[i]=="Alt")
					alt = true;
				else{
					if(!code){
						code = this.getKeyCode(keys[i]);
						if(!code) return; // ²»´æÔÚµÄ¿ì½Ý¼ü
						else break; // Ö»Ò»¸ö¿ì½Ý×ÖÄ¸
					}
				}
			}
			//alert(shift + " " + ctrl + " " + alt + " " + code);
			$(doc).bind("keydown", function(e){
				if(!shift && !ctrl && !alt && !code) return;
				if(shift && !e.shiftKey) return;
				if(!shift && e.shiftKey) return;
				if(ctrl && !e.ctrlKey) return;
				if(!ctrl && e.ctrlKey) return;
				if(alt && !e.altKey) return;
				if(!alt && e.altKey) return;
				if(code && e.keyCode != code) return;
				fun();
				return false;
			});
		},
		/*
		 * ÔÊÐíµÄ¿ì½Ý¼ü¶ÔÓ¦±àÂë£¬JSON¶ÔÏó
		 */
		keyCode : {
			//¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
			"ESC":27, "F1":112,"F2":113,"F3":114,"F4":115," F5":116,"F6":117,"F7":118,"F8":119," F9":120,"F10":121,"F11":122,"F12":123, "PRINT":21,"SCROLL LOCK":145,"PAUSE":19,
			//¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
			"~":192,"1":49,"2":50,"3":51,"4":52,"5":53,"6":54,"7":55,"8":56,"9":57,"0":48,"_":173,"=":61,                "BACKSPACE":8, "INSERT":45, "HOME":36, "PAGE UP":   33, "NUM LOCK":144,"DIV":111,"MUL":106,"SUB": 109,
			"TAB":9,"Q":81,"W":87,"E":69,"R":82,"T":84,"Y":89,"U":85,"I":73,"O":79,"P":80,"[":219,"]":221,                  "ENTER":13, "DELETE":46, "END": 35, "PAGE DOWN": 34, "M7":      103,"M8": 104,"M9": 105,"PLUS":107,
			"CAPS LOCK":20,"A":65,"S":83,"D":68,"F":70,"G":71,"H":72,"J":74,"K":75,"L":76,";":59,"'":222,"\\":220,                                                               "M4":      100,"M5": 101,"M6": 102,
			/*"SHIFT":16,*/"Z":90,"X":88,"C":67,"V":86,"B":66,"N":78,"M":77,",":188,".":190,"/":191,					/*"SHIFT":16,*/               "UP":  38,                 "M1":       97,"M2":  98,"M3":  99,"ENTER":13,
			/*"CTRL":17,*/"WIN":91,/*"ALT":18,*/                    "SPACE":32,          /*"ALT":18,*/"WIN":91,"MENU":93,/*"CTRL":17,*/ "LEFT":37,    "DOWN":40,    "RIGHT": 39, "M0":                 96,"DEL":110
			//¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
		},






		getKeyCode : function(char){
			return this.keyCode[char.toUpperCase()];
		},





		stopEvent : function(e){
			if(!e) return;
			if(e.stopPropagation)
				e.stopPropagation();
			else e.cancelBubble=true;
		},
		moveBoxOnDown : function(e, box){
			var x0 = e.clientX;
			var y0 = e.clientY;
			var position = $(box).position();
			$(document).bind("mousemove", move).bind("mouseup", up);
			function move(e){
				$(box).css({
					"top" : position.top + e.clientY - y0,
					"left" : position.left + e.clientX - x0
				});
			}
			function up(e){
				$(document).unbind("mousemove", move).unbind("mouseup", up);
			}
		},
		opacityBoxOnOver : function(box){
			$(box).removeClass("list_search_nohover").mouseleave(function(){
				$(box).addClass("list_search_nohover");
			});
		}
};

var AsButton = {
		unable : function(sIdOrText){
			if(!sIdOrText || typeof sIdOrText != "string") return;
			var btn = this.getBtn(sIdOrText);
			if(!btn) return;
			$(btn).addClass("unable");
		},
		able : function(sIdOrText){
			if(!sIdOrText || typeof sIdOrText != "string") return;
			var btn = this.getBtn(sIdOrText);
			if(!btn) return;
			$(btn).removeClass("unable");
		},
		getBtn : function(sIdOrText){
			if(/^B[0-9]{1,}$/.test(sIdOrText)){
				return document.getElementById(sIdOrText);
			}else {
				var buttons = $("a.inline_button");
				for(var i = 0; i < buttons.length; i++){
					if($(".btn_text", buttons[i]).text() != sIdOrText) continue;
					return buttons[i];
				}
			}
			return null;
		},
		run : function(btn, fun, e){
			AsLink.stopEvent(e);
			btn = $(btn);
			if(btn.hasClass('unable')) return;
			btn.addClass('unable');
			try{
				fun();
			}finally{
				btn.removeClass('unable');
			}
		}
};




var AsForm = {
		/*
		 * ¶¨ÒåÐÐÄÚÑùÊ½
		 */
		CSS : {
			FlatSelect : {"position":"absolute","border":"solid #aaa","border-width":"0 1px 1px","overflow-y":"auto","background":"#fff","padding-bottom":"2px"},
			FlatSelectA : {"display":"block","width":"100%","height":"20px","line-height":"20px","white-space":"nowrap","overflow-x":"hidden","border-bottom":"1px dotted #ccc","font-size":"12px","text-decoration":"none"},
			FlatSelectHoverA : {"background-color":"#316ac5","color":"#fff"},
			FlatSelectLeaveA : {"background-color":"","color":"#333"}
		},









		FlatSelect : function(input, data, maxheight, changeFun, doc){
			if(!data) data = {};
			if(!doc) doc = document;
			var select = $(input, doc);
			if(!select.is("input")) return;
			
			var flatSelect = select.data("FlatSelect"); // »ñÈ¡Êý¾Ý»º´æ
			var input, slide;
			if(!flatSelect){
				input = select.clone().val("").removeAttr("id").removeAttr("name").attr("onchange", "").bind("change", search).insertBefore(select).show();
				slide = $("<div></div>", doc).appendTo($("body", doc)).css(AsForm.CSS.FlatSelect).hide();
				select.hide();
				// Ìî³äÊý¾Ý»º´æ£¬°üÀ¨ÏÔÊ¾text±íµ¥¡¢ÏÂÀ­Ãæ°å¡¢ÉèÖÃÕæÊµÖµ·½·¨
				select.data("FlatSelect", {"input":input,"slide":slide,"setValue":set});
			}else{
				input = flatSelect["input"].unbind(".FlatSelect");
				slide = flatSelect["slide"].unbind(".FlatSelect").empty();
			}
			var change = select.attr("onchange");
			
			for(var o in data){
				appendA(o);
			}
			var curA = null;
			var flag = false;
			slide.bind("mousedown.FlatSelect", function(){
				flag = true;
			});
			input.bind("focus.FlatSelect", focus).bind("blur.FlatSelect", function(){
				if(select.prop("readonly")) return;
				if(flag) return;
				var val = input.val();
				if(!val){
					set();
					return;
				}
				setVal(val);
			}).bind("keydown.FlatSelect", function(e){
				if(select.prop("readonly")) return;
				if(slide.is("hidden")) return;
				if(e.keyCode==40){ // °´¼ýÍ·ÏÂ
					nextA();
					return;
				}
				if(e.keyCode==38){ // °´¼ýÍ·ÉÏ
					prevA();
					return;
				}
				if(e.keyCode==13){ // »Ø³µ
					$(curA).click();
					return;
				}
				if(e.keyCode==27) return false; // ESC·ÀÖ¹ÎÄ±¾ÄÚÈÝ»ØÍË
			}).bind("keyup.FlatSelect", function(e){
				if(e.keyCode==40||e.keyCode==38||e.keyCode==13||e.keyCode==27) return;
				focus();
			}).bind("dblclick.FlatSelect", function(){
				if(select.prop("readonly")) return;
				set();
				focus();
			});
			
			var val = select.val();
			if(!flatSelect) select.val("");
			set(val);
			
			function focus(){
				if(select.prop("readonly")) return;
				input.removeProp("readonly");
				
				var offset = input.offset();
				
				slide.css({
					"left" : offset.left,
					"top" : $("body", doc).scrollTop() + offset.top + input.height()+7,
					"width" : input.width()+7
				}).show();
				search();
				flag = false;
			}
			
			function search(){
				var val = input.val();
				var as = $("a", slide);
				var first = true;
				if(!val){
					as.show();
					setCurA(as[0]);
				}else as.each(function(){
					if($(this).text().indexOf(val) < 0) $(this).hide();
					else{
						$(this).show();
						if(first){
							setCurA(this);
							first = false;
						}
					}
				});
				slide.height("auto");
				if(!isNaN(maxheight) && slide.height() > maxheight) slide.height(maxheight);
			}
			
			function prevA(){
				var a = null;
				if(!curA){
					a = $("a:visible:last", slide)[0];
				}else{
					var temp = $(curA).prev();
					while(temp.length>0){
						if(temp.is(":visible")) break;
						temp = temp.prev();
					}
					a = temp[0];
				}
				if(!a) return;
				setCurA(a);
			}
			
			function nextA(){
				var a = null;
				if(!curA){
					a = $("a:visible:first", slide)[0];
				}else{
					var temp = $(curA).next();
					while(temp.length>0){
						if(temp.is(":visible")) break;
						temp = temp.next();
					}
					a = temp[0];
				}
				if(!a) return;
				setCurA(a);
			}
			
			function setCurA(a){
				$(curA).css(AsForm.CSS.FlatSelectLeaveA);
				curA = a;
				$(curA).css(AsForm.CSS.FlatSelectHoverA);
				if(curA && !isNaN(maxheight)){
					var top = $(curA).position().top;
					if(top+21 > maxheight) slide.scrollTop(slide.scrollTop()+top+21-maxheight);
					else if(top < 0) slide.scrollTop(slide.scrollTop()+top);
				}
			}
			
			function setVal(val){
				if(!val) return;
				for(var o in data){
					if(data[o]==val){
						set(o);
						return;
					}
				}
				set();
			}
			
			function set(key){
				if(!key) key = "";
				var val = data[key];
				if(!val){
					key = "";
					val = "";
				}
				var oldKey = select.val();
				select.val(key);
				input.val(val);
				slide.hide();
				//if(!window.div) window.div = $("<div style='position:absolute;left:20px;top:20px;'></div>").appendTo("body");
				//window.div.append("|"+oldKey+"|"+key+"|<br>");
				if(oldKey != key){
					if(typeof changeFun == "function") changeFun(key);
					if(change) eval(change.replace("this.value", "\""+key+"\""));
				}
			}
			
			function appendA(key){
				$("<a title=\""+data[key]+"\" ><span>&nbsp;&nbsp;"+data[key]+"</span></a>", doc).appendTo(slide).css(AsForm.CSS.FlatSelectA).css(AsForm.CSS.FlatSelectLeaveA).click(function(){
					set(key);
				}).mouseover(function(){
					setCurA(this);
				});
			}
		}
};






$.fn.wizard = function(model, defId){
	var wizard = this;
	var curItem = null;
	var curSpan = null;
	model.sort(function(item1, item2){
		if(item1["sort"] > item2["sort"]) return 1;
		if(item1["sort"] < item2["sort"]) return -1;
		return 0;
	});
	if(typeof defId != "string" && model.length > 0) defId = model[0]["id"];
	
	for(var i = 0; i < model.length; i++){
		append(model[i]);
	}
	function append(item){
		var span = $("<span class=\"wizard_dom_cell\" ><span class=\"wizard_dom_panel\">"+item["name"]+"</span><span class=\"wizard_dom_span wizard_dom_arrow\"></span></span>").appendTo(wizard).click(click);
		
		function click(){
			if(curSpan == span) return;
			if(typeof WizardCellOnClick == "function" && WizardCellOnClick(curItem, item) != true) return;
			if(curSpan){
				curSpan.removeClass("wizard_dom_select").prev().find(".wizard_dom_span").removeClass("wizard_dom_before_arrow");
				var parent = curSpan.parent();
				curSpan.prev().insertBefore(parent);
				curSpan.insertBefore(parent);
				parent.remove();
			}
			curSpan = span;
			curItem = item;
			$(curSpan).addClass("wizard_dom_select").prev().find(".wizard_dom_span").addClass("wizard_dom_before_arrow");
			$("<span></span>").insertAfter(curSpan).append(curSpan.prev()).append(curSpan);
		};
		if(item["id"] == defId) click();
	}
};