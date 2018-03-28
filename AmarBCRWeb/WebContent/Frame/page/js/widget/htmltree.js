











































































function HtmlTree(vessel, model){
	/* 修复Array.indexOf方法 */
	if(!Array.indexOf) Array.prototype.indexOf = function(e, i){
		if(isNaN(i)) i = 0;
		if(i < 0) return this.indexOf(e, i+this.length);
		for(; i < this.length; i++){
			if(this[i] == e) return i;
		}
		return -1;
	};
	
	var tree = this;
	// 暴露方法
	tree.NodeOnClick = HtmlNode.UDF;
	tree.NodeOnDblclick = HtmlNode.UDF;
	tree.NodeOnCheck = HtmlNode.UDF;
	tree.NodeOnUncheck = HtmlNode.UDF;
	tree.NodeOnMove = HtmlNode.UDF;
	tree.EvalFunsAsk = HtmlNode.UDF;
	
	// 内部变量
	var funs = new Array();
	var css = HtmlNode.UDF;
	var clickNode = HtmlNode.UDF;
	var moveNode = HtmlNode.UDF;
	var root = HtmlNode.UDF;
	var DIS_CHECK = 0;
	var CHECK = 1;
	var CHECKED = 2;
	var HALF_CHECKED = 3;
	
	/*
	 * 阻止冒泡
	 * @param e
	 */
	function stopEvent(e){
		if(e.stopPropagation) e.stopPropagation();
		else e.cancelBubble=true;
	}
	
	/*
	 * 方法嫁接，将对象obj2的方法名为name的方法嫁接到对象obj1上去
	 * @param obj1
	 * @param obj2
	 * @param name
	 */
	function graftFun(obj1, obj2, name){
		if(typeof obj2[name] != "function") return;
		obj1[name] = function(){
			return obj2[name].apply(obj2, arguments);
		};
	}
	
	/*
	 * 执行预留事件
	 * @param en 预留事件集合编号
	 * @param fnum 执行多少次询问
	 * @param efuns 已执行事件
	 */
	function evalfuns(en, fnum, efuns){
		if(funs[en].length == 0) return;
		if(!efuns) efuns = new Array();
		var sleep = 0;
		if(typeof tree.EvalFunsAsk == "function" && (!fnum || efuns.length % fnum == 0)){
			fnum = tree.EvalFunsAsk(funs[en], efuns);
			sleep = 1;
		}
		if(isNaN(fnum) || fnum <= 0) return;
		
		funs[en][0]();
		efuns.push(funs[en][0]);
		funs[en].splice(0, 1); // 执行完清理
		if(sleep == 0){
			evalfuns(en, fnum, efuns);
			return;
		}
		setTimeout(function(){
			evalfuns(en, fnum, efuns);
		}, sleep);
	}
	
	/*
	 * 画节点
	 * @param obj ul or li
	 * @param HtmlNode
	 * @param direction
	 */
	function drawNode(obj, node, direction){
		var icon = node.getIcon(true);
		var li = $("<li></li>", vessel.ownerDocument);
		if(direction==true) li.insertBefore(obj);
		else if(direction==false) li.insertAfter(obj);
		else li.appendTo(obj);
		if(node.getData()["Beclick"]) icon += " click";
		var span = $("<span class=\"node "+icon+"\" title=\""+node.getTips()+"\" ><span>"+node.getText()+"</span><span>"+model["AppendHtml"]+"</span></span>", vessel.ownerDocument).appendTo(li).click(function(e){
			node.click(e);
		}).dblclick(function(){
			if(typeof tree.NodeOnDblclick != "function") return;
			tree.NodeOnDblclick(node);
		}).mousedown(function(e){
			if(typeof tree.NodeOnMove != "function") return;
			node.time = setTimeout(function(){
				node.mark("move");
				moveNode = node;
				moveNode.clientY = e.clientY; // 记录下鼠标纵向位置
			}, 500);
		}).mouseover(function(e){
			if(!moveNode || isNaN(moveNode.clientY) || node == moveNode || typeof tree.NodeOnMove != "function") return;
			if(e.clientY > moveNode.clientY){
				$(node._dom).removeClass("over_up").addClass("over_down");
				var down = node.getDown();
				if(down) $(down._dom).removeClass("over_down").addClass("over_up");
			}else{
				$(node._dom).removeClass("over_down").addClass("over_up");
				var up = node.getUp();
				if(up && up != node.getParent()) $(up._dom).removeClass("over_up").addClass("over_down");
			}
			moveNode.clientY = e.clientY;
		}).mouseleave(function(){
			if(!moveNode || node == moveNode || typeof tree.NodeOnMove != "function") return;
			$(node._dom).removeClass("over_down").removeClass("over_up");
			var up = node.getUp();
			if(up) $(up._dom).removeClass("over_down").removeClass("over_up");
			var down = node.getDown();
			if(down) $(down._dom).removeClass("over_up").removeClass("over_down");
		}).mouseup(function(){
			if(typeof tree.NodeOnMove != "function") return;
			clearTimeout(node.time);
			if(!moveNode) return;
			node.insert(moveNode, $(node.getDom()).hasClass("over_up"));
			$(node._dom).removeClass("over_down").removeClass("over_up");
			setTimeout(function(){
				moveNode.unmark("move");
				moveNode = null;
			}, 500);
			delete node.time;
			delete moveNode.time;
			delete moveNode.clientY;
		});
		
		if(node.isMultiselect()){
			var cls = "";
			switch(node.getData()["Check"]){
			case CHECKED : cls = " check"; break;
			case HALF_CHECKED : cls = " halfcheck"; break;
			}
			$("<span class=\"index checkbox"+cls+"\">&nbsp;</span>", vessel.ownerDocument).prependTo(span).click(function(e){
				stopEvent(e);
				if(node.isChecked()){
					node.uncheck();
				}else{
					node.check();
				}
			});
		}
		span.prepend("<span class=\"index icon\">&nbsp;</span>");
		var arrow = "";
		if(node.getChildren().length > 0) arrow = " arrow";
		$("<a class=\"index"+arrow+"\" href=\"javascript:void(0)\" onclick=\"return false;\" hidefocus>&nbsp;</a>", vessel.ownerDocument).prependTo(span).click(function(e){
			if(node.getChildren().length == 0) return;
			stopEvent(e);
			if(span.next().is(":visible")){
				node.collapse();
			}else{
				node.expand();
			}
		});
		for(var i = 0; i < node.getLeave(); i++){
			span.prepend("<span class=\"index\">&nbsp;</span>");
		}
		node._setDom(li[0]);
	}
	
	/*
	 * 处理check半选状态
	 */
	function park(data, init){
		var n1 = 0; // 已选
		var n2 = 0; // 半选
		var n3 = 0; // 未选
		for(var i = 0; i < data["Storys"].length; i++){
			if(init) park(data["Storys"][i], true);
			switch(data["Storys"][i]["CK"]){
			case CHECKED : n1++; break;
			case HALF_CHECKED : n2++; break;
			default : n3++; break;
			}
		}
		var check = DIS_CHECK;
		if(data["Storys"].length == 0) check = data["Check"];
		else if(n1 == data["Storys"].length) check = CHECKED;
		else if(n3 == data["Storys"].length) check = CHECK;
		else check = HALF_CHECKED;
		data["CK"] = check;
		if(data["Check"] >= CHECK && data["Check"] <= HALF_CHECKED) data["Check"] = check;
	}
	
	/*
	 * 整理节点数据的check选中与否状态
	 */
	function parkNode(node, flag){
		if(!node) return;
		node.getData()["CK"] = flag ? CHECKED : CHECK;
		if(node.isMultiselect()) node.getData()["Check"] = node.getData()["CK"];
		for(var i = 0; i < node.getChildren().length; i++){
			parkNode(node.getChildren()[i], flag);
		}
	}
	
	/*
	 * 整理父节点数据的check选中与否状态
	 */
	function parkParent(node){
		if(!node) return;
		park(node.getData());
		parkParent(node.getParent());
	}
	
	/*
	 * 整理节点选中与否状态
	 */
	function parkCheck(node, flag){
		if(!node) return;
		var parent = node.getParent();
		while(parent){
			if(parent.getDom()){
				var checkbox = $(">span .checkbox", parent.getDom()).removeClass("halfcheck").removeClass("check");
				if(parent.isHalfChecked()) checkbox.addClass("halfcheck");
				else if(parent.isChecked()) checkbox.addClass("check");
			}
			parent = parent.getParent();
		}
		if(typeof flag == "boolean" && node._dom){
			var checkbox = $(".checkbox", node._dom);
			if(flag) checkbox.removeClass("halfcheck").addClass("check");
			else checkbox.removeClass("check").removeClass("halfcheck");
		}
	}
	





	this.getRoot = function(){
		return root;
	};
	





	this.getClick = function(){
		return clickNode;
	};
	






	this.nearCss = function(cls, flag){
		if(flag) css.before(cls);
		else css.after(cls);
	};
	





	this.getEvalFunsAsk = function(){
		return function(funs, efuns, num){
			if(isNaN(num)) num = 50;
			if(efuns.length == 0 && funs.length < num) return num;
			var msg;
			if(efuns.length == 0) msg = "此次操作有"+funs.length+"个事件需要执行，是否执行？";
			else msg = "此次操作还剩"+funs.length+"个事件需要执行(已执行"+efuns.length+"个)，是否继续执行？";
			if(confirm(msg)) return num;
		};
	};
	
	/*
	 * 节点对象
	 * @param data
	 * @param parent
	 * @returns
	 */
	function HtmlNode(data, parent){
		
		var children = new Array();
		this._dom = null;
		var _leave = -1;
		
		/* 内部方法
		 * * * * * *
		 * 设置节点依附文档
		 */
		this._setDom = function(dom){
			dom.node = this;
			this._dom = dom;
		};
		
		/* 内部方法
		 * * * * * *
		 * 设置节点所处级别
		 */
		this._setLeave = function(leave){
			if(this._dom){
				var span = $(">span", this._dom);
				if(leave > _leave) for(var i = 0; i < leave - _leave; i++){
					span.prepend("<span class=\"index\">&nbsp;</span>");
				}else span.find(".index:lt("+(_leave-leave)+")").remove();
			}
			for(var i = 0; i < this.getChildren().length; i++){
				this.getChildren()[i]._setLeave(leave+1);
			}
			_leave = leave;
			return this;
		};
		
		/* 内部方法
		 * * * * * *
		 * 设置父节点
		 */
		this._setParent = function(nParent){
			parent = nParent;
		};
		
		/* 内部方法
		 * * * * * *
		 * 勾画子节点
		 */
		this._drawChildren = function(){
			var dom = this.getDom();
			var ul = $(">ul", dom);
			if(ul.length == 0){
				ul = $("<ul></ul>", vessel.ownerDocument).appendTo(dom);
				for(var i = 0; i < children.length; i++){
					drawNode(ul, children[i]);
				}
			}
			return ul;
		};
		
		/* 内部方法
		 * * * * * *
		 * 初始化当前节点
		 */
		this._init = function(en){
			var flag = isNaN(en);
			if(flag){
				en = funs.length;
				funs.push(new Array());
			}
			for(var i = 0; i < data["Storys"].length; i++){
				children.push(new HtmlNode(data["Storys"][i], this, en)._setLeave(_leave+1)._init(en));
			}
			var node = this;
			if(data["Beclick"]){
				data["Beclick"] = false;
				funs[en].push(function(){node.click();});
			}
			if(data["Expand"]) funs[en].push(function(){node.expand();});
			if(flag){
				if(this == tree.getRoot()) setTimeout(function(){
					evalfuns(en);
				}, 500); else evalfuns(en);
			}
			
			return this;
		};
		





		this.getData = function(){
			return data;
		};
		





		this.getText = function(){
			if(this == tree.getRoot()) return data["Name"];
			return data["Text"];
		};
		





		this.setText = function(text){
			if(this == tree.getRoot()){
				data["Name"] = text;
			}else{
				data["Text"] = text;
				if(this._dom)
					$(">span span:last").prev().html(text);
			}
		};
		





		this.getTips = function(){
			return data["Tips"];
		};
		






		this.getIcon = function(flag){
			var icon = this.getChildren().length > 0 ? "folder" : "page";
			if(data["Icon"]){
				if(data["Icon"]=="folder"){
					icon = "folder";
				}else if(data["Icon"]!="page"){
					if(flag) icon += " "+data["Icon"];
					else icon = data["Icon"];
				}
			}
			return icon;
		};
		
		/*
		 * 获取真实属性键值
		 */
		this._getAttrKey = function(attrKey){
			if(typeof attrKey != "string") return;
			var data = this.getData();
			if(!data) return;
			if(data["Attributes"][attrKey]) return attrKey;
			attrKey = attrKey.toUpperCase();
			for(var o in data["Attributes"]){
				if(attrKey == o.toUpperCase()){
					return o;
				}
			}
		};
		






		this.setAttribute = function(attrKey, attrValue){
			if(this == tree.getRoot()){
				this.setText(attrValue);
				return;
			}
			attrKey = this._getAttrKey(attrKey);
			this.getData()[attrKey] = attrValue;
		};
		






		this.removeAttribute = function(attrKey){
			if(this == tree.getRoot()) return;
			attrKey = this._getAttrKey(attrKey);
			if(!attrKey) return;
			var attrValue = this.getData()[attrKey];
			delete this.getData()[attrKey];
			return attrValue;
		};
		






		this.getAttribute = function(sKey){
			if(this == tree.getRoot()) return this.getText();
			return this.getData()["Attributes"][this._getAttrKey(sKey)];
		};
		





		this.getParent = function(){
			return parent;
		};
		








		this.getNode = function(attrKey, obj){
			if(typeof obj == "undefined"){
				obj = attrKey;
				attrKey = HtmlNode.UDF;
			}
			if(this._dom == obj) return this;
			var flag = true;
			try{flag = $(this._dom).find(obj).length != 1;}catch(e){};
			if(flag){
				if(typeof attrKey != "string" && typeof obj != "string") return; // 不指定属相键值取text，text必须是字符串
				
				function _getNode(node){
					var attrValue = typeof attrKey != "string" ? node.getText() : node.getAttribute(attrKey);
					if(obj == attrValue) return node;
					for(var i = 0; i < node.getChildren().length; i++){
						var gNode = _getNode(node.getChildren()[i]);
						if(gNode) return gNode;
					}
				}
				return _getNode(this);
			}
			
			if(!obj) return;
			obj = $(obj)[0];
			while(obj){
				if(obj == this._dom) return this;
				if($(obj).is("span.node")) return obj.parentNode.node;
				obj = obj.parentNode;
			}
			return;
		};
		





		this.getChildren = function(){
			return children;
		};
		







		this.getIndexNode = function(index, onlyLeaf){
			var nodes = this.getNodes();
			var n = 0;
			for(var i = 0; i < nodes.length; i++){
				if(onlyLeaf && nodes[i].getChildren().length > 0) continue;
				if(index == n) return nodes[i];
				n++;
			}
		};
		








		this.getNodes = function(attrKey, text){
			if(typeof text == "undefined"){
				text = attrKey;
				attrKey = HtmlNode.UDF;
			}
			
			var nodes = new Array();
			if(!text) text = "";
			var aText = text.split(" ");
			
			function _getNodes(node){
				a:for(var i = 0; i < node.getChildren().length; i++){
					if(text){
						var attrValue;
						if(!attrKey) attrValue = node.getChildren()[i].getData()["Text"];
						else attrValue = node.getChildren()[i].getAttribute(attrKey);
						attrValue = ""+attrValue; // 必须为字符串
						
						for(var j = 0; j < aText.length; j++){
							if(attrValue.indexOf(aText[j]) < 0){
								_getNodes(node.getChildren()[i]);
								continue a;
							}
						}
					}
					nodes.push(node.getChildren()[i]);
					_getNodes(node.getChildren()[i]);
				}
			}
			_getNodes(this);
			
			return nodes;
		};
		





		this.getMultiNodes = function(){
			var nodes = this.getNodes();
			var multiNodes = new Array();
			for(var i = 0; i < nodes.length; i++){
				if(nodes[i].isMultiselect())
					multiNodes.push(nodes[i]);
			}
			return multiNodes;
		};
		







		this.getChecked = function(flag, excludes){
			var nodes = this.getMultiNodes(this);
			//alert(nodes.length);
			var checkeds = new Array();
			for(var i = 0; i < nodes.length; i++){
				if(excludes && excludes.indexOf(nodes[i]) >= 0) continue;
				if(nodes[i].isChecked() || (flag && nodes[i].isHalfChecked())){
					checkeds.push(nodes[i]);
				}
			}
			return checkeds;
		};
		







		this.getTopChecked = function(flag, excludes){
			var checkeds = new Array();
			var thiz = this;
			function _getTopChecked(node){
				if(excludes && excludes.indexOf(node)) return;
				if(node != thiz && node.isChecked() || (flag && node.isHalfChecked())){
					checkeds.push(node);
					return;
				}
				for(var i = 0; i < node.getChildren().length; i++){
					_getTopChecked(node.getChildren()[i]);
				}
			}
			_getTopChecked(this);
			return checkeds;
		};
		







		this.getUnchecked = function(flag, excludes){
			var nodes = this.getMultiNodes(this);
			//alert(nodes.length);
			var uncheckeds = new Array();
			for(var i = 0; i < nodes.length; i++){
				if(excludes && excludes.indexOf(nodes[i]) >= 0) continue;
				if(nodes[i].isChecked()) continue;
				if(!flag && nodes[i].isHalfChecked()) continue;
				uncheckeds.push(nodes[i]);
			}
			return uncheckeds;
		};
		





		this.getLeave = function(){
			return _leave;
		};
		





		this.getDom = function(){
			if(!this._dom) this.getParent()._drawChildren();
			return this._dom;
		};
		





		this.getUp = function(){
			if(this == tree.getRoot()) return;
			var li = $(this.getDom()).prev();
			if(li.length == 0){
				li = $(this.getDom()).parent().parent();
				if(li.length == 0 || !li.is("li")) return;
			}else{
				do{
					var ul = li.find(">ul:visible");
					if(ul.length == 0) break;
					li = ul.find(">li:last");
				}while(true);
			}
			return li[0].node;
		};
		





		this.getDown = function(){
			if(this == tree.getRoot()) return;
			var li = $(this.getDom());
			var ul = li.find(">ul:visible");
			if(ul.length == 1){
				li = ul.find(">li:first");
			}else{
				do{
					var temp = li.next();
					if(temp.length == 1){
						li = temp;
						break;
					}
					li = li.parent().parent();
					if(!li.is("li")) return;
				}while(true);
			}
			return li[0].node;
		};
		





		this.expand = function(flag){
			if(!this._dom || !$(">ul", this._dom).is(":visible")){
				if(this.getParent() && !this.getParent().expand()) return false;
				this._drawChildren().show().prev().addClass("expand");
			}
			
			if(flag){
				funs.push(new Array());
				function _expand(node){
					// 节点打开判断
					var flag = node._dom && $(">ul", node._dom).is(":visible");
					for(var i = 0; i < node.getChildren().length; i++){
						var child = node.getChildren()[i];
						if(child.getChildren().length == 0){
							if(flag) continue;
							funs[funs.length-1].push(function(){
								node.expand();
							});
							flag = true;
						}else{
							_expand(child);
						}
					}
				}
				$(">ul ul", this.getDom()).show().prev().addClass("expand");
				_expand(this);
				//alert(funs[funs.length-1].length);
				evalfuns(funs.length-1);
			}
			
			return true;
		};
		





		this.collapse = function(flag){
			if(!this._dom) return;
			$(!flag ? ">ul" : this == tree.getRoot() ? ">ul ul" : "ul", this._dom).hide().prev().removeClass("expand");
		};
		




		this.toggle = function(){
			if(this._dom && $(">ul", this._dom).is(":visible")){
				this.collapse();
			}else{
				this.expand();
			}
		};
		





		this.click = function(e){
			if(!this.focus()) return false; // 未聚焦到，没办法点击
			if(typeof tree.NodeOnClick == "function" && tree.NodeOnClick(this, e) == false) return false; // 外置事件返回false不做点击
			if(clickNode) clickNode.unclick();
			clickNode = this;
			data["Beclick"] = true;
			$(">span", this.getDom()).addClass("click");
		};
		




		this.unclick = function(){
			if(this == tree.getRoot()) return;
			data["Beclick"] = false;
			$(">span", this.getDom()).removeClass("click");
		};






		this.isMultiselect = function(){
			return !isNaN(data["Check"]) && data["Check"] >= CHECK && data["Check"] <= HALF_CHECKED;
		};
		





		this.isChecked = function(){
			return data["Check"] == CHECKED;
		};






		this.isHalfChecked = function(){
			return data["Check"] == HALF_CHECKED;
		};
		






		this.isHigher = function(node){
			if(!node) return false;
			var parent = node.getParent();
			while(parent){
				if(this == parent) return true;
				parent = parent.getParent();
			};
			return false;
		};
		




		this.check = function(){
			// 勾选前未勾选的节点
			var checkeds = this.getUnchecked(true);
			//alert(checkeds.length);

			// 预备变量
			parent = this.getParent();
			var includeSelf = this != tree.getRoot() && !this.isChecked();
			var includeParent = false;
			if(this != tree.getRoot())
				includeParent = !this.getParent().isChecked();
			
			// 勾选过程
			parkNode(this, true);
			parkParent(parent);
			parkCheck(this, true);
			
			// 当前勾选的节点
			if(includeSelf) checkeds.unshift(this);
			if(includeParent) while(parent && parent != tree.getRoot() && parent.isChecked()){
				checkeds.unshift(parent);
				parent = parent.getParent();
			}
			
			// 触发勾选外置事件
			if(typeof tree.NodeOnCheck == "function")
				tree.NodeOnCheck(checkeds);
		};
		




		this.uncheck = function(_flag){
			// 勾选前已勾选节点
			var discheckeds = null;
			
			if(!_flag){
				discheckeds = this.getChecked(false);
				if(this != tree.getRoot() && this.isChecked())
					discheckeds.unshift(this);
				var parent = this.getParent();
				while(parent && parent != tree.getRoot() && parent.isChecked()){
					discheckeds.unshift(parent);
					parent = parent.getParent();
				}
			}
			
			// 勾选过程
			parkNode(this, false);
			parkParent(this.getParent());
			parkCheck(this, false);
			
			// 触发去除勾选外置事件
			if(!_flag && typeof tree.NodeOnUncheck == "function")
				tree.NodeOnUncheck(discheckeds);
		};
		






		this.mark = function(cls, flag){
			if(this == tree.getRoot()) return;
			if(cls == "click"){
				this.click();
				return;
			}
			if(flag) this.focus();
			$(">span", this.getDom()).addClass(cls);
		};
		





		this.unmark = function(cls){
			if(this == tree.getRoot()) return;
			if(cls == "click"){
				this.unclick();
				return;
			}
			$(">span", this.getDom()).removeClass(cls);
			return this;
		};
		




		this.focus = function(){
			if(!this.getParent() || !this.getParent().expand()) return false;
			$(">span >a:first", this.getDom()).focus();
			return true;
		};
		






		this.insert = function(node, direction, _inner){
			if(node == tree.getRoot() || this == node) return;
			if(this == tree.getRoot()) direction = HtmlNode.UDF;
			
			var parent = (direction==true||direction==false)?this.getParent():this;
			var children = parent.getChildren();
			var index = direction==true ? children.indexOf(this) : direction==false ? children.indexOf(this)+1 : children.length;
			
			var oparent = node.getParent();
			var ochildren = oparent.getChildren();
			var oindex = ochildren.indexOf(node);
			
			//alert(index +" "+ oindex);
			if(parent == oparent && index == oindex) return;
			if(!_inner && typeof tree.NodeOnMove == "function" && tree.NodeOnMove(node, parent, index) == false)
				return;
			
			// 如果node是当前节点的上级，那么要先将node的子节点移到node的前面去
			if(node.isHigher(this) && node.getChildren().length > 0){
				var flag = node.isChecked();
				while(node.getChildren().length > 0){
					node.insert(node.getChildren()[0], true, true);
				}
				$(node._dom).find(">span").removeClass("folder").addClass("page").find(".icon").prev().removeClass("arrow").removeClass("expand");
				if(!flag) node.uncheck(true);
			}
			
			parent = (direction==true||direction==false)?this.getParent():this;
			children = parent.getChildren();
			index = direction==true ? children.indexOf(this) : direction==false ? children.indexOf(this)+1 : children.length;
			oparent = node.getParent();
			ochildren = oparent.getChildren();
			oindex = ochildren.indexOf(node);
			
			if(ochildren.length == 1 && oparent._dom)
				$(oparent._dom).find(">span").removeClass("folder").addClass("page").find(".icon").prev().removeClass("arrow").removeClass("expand");
			if(children.length == 0 && parent._dom)
				$(parent._dom).find(">span").removeClass("page").addClass("folder").find(".icon").prev().addClass("arrow");
			
			ochildren.splice(oindex, 1);
			oparent.getData()["Storys"].splice(oindex, 1);
			parkParent(oparent);
			parkCheck(node);
			
			children.splice(index, 0, node);
			parent.getData()["Storys"].splice(index, 0, node.getData());
			node._setParent(parent);
			node._setLeave(parent.getLeave()+1);
			parkParent(parent);
			parkCheck(node);
			
			if(parent._dom){
				var ul = $(">ul", parent._dom);
				if(ul.length == 1){
					if(node._dom){
						if(direction==true) $(this._dom).before(node._dom);
						else if(direction==false) $(this._dom).after(node._dom);
						else{
							ul.append(node._dom);
						}
					}else{
						drawNode((direction==true||direction==false)?this._dom:ul[0], node, direction);
					}
					return;
				}
			}
			if(node._dom){
				$(node._dom).remove();
				delete node._dom;
			}
		};
		







		this.add = function(data, direction){
			park(data, true);
			if(this==tree.getRoot()) direction = HtmlNode.UDF; // undefined
			var parent = (direction==true||direction==false)?this.getParent():this;
			var node = new HtmlNode(data, parent)._setLeave(parent.getLeave()+1)._init();
			var children = parent.getChildren();
			var index = direction==true ? children.indexOf(this) : direction==false ? children.indexOf(this)+1 : children.length;
			children.splice(index, 0, node);
			parent.getData()["Storys"].splice(index, 0, data);
			
			if(parent._dom){
				var $dom = $(parent._dom);
				if(children.length == 1) $dom.find(">span").removeClass("page").addClass("folder").find(".icon").prev().addClass("arrow");
				var obj = $dom.find(">ul");
				if(obj.length == 1){
					if(direction==true||direction==false)
						obj = this._dom;
					drawNode(obj, node, direction);
				}
			}
			return node;
		};
		





		this.remove = function(holdChildren){
			if(this == tree.getRoot()){
				if(holdChildren) return;
				while(this.getChildren().length > 0){
					this.getChildren()[0].remove();
				}
				return;
			}
			
			var parent = this.getParent();
			var children = parent.getChildren();
			var index = children.indexOf(this);
			if(holdChildren){
				while(this.getChildren().length > 0){
					this.insert(this.getChildren()[0], true, true);
				}
			}
			
			children.splice(index, 1);
			parent.getData()["Storys"].splice(index, 1);
			parkParent(parent);
			if(children.length > 0){
				parkCheck(children[0]);
			}else{
				parkCheck(parent, parent.getData()["Check"]==CHECKED);
				$(parent.getDom()).find(">span").removeClass("folder").addClass("page").find(".icon").prev().removeClass("arrow");
			}
			if(this._dom) $(this._dom).remove();
			if(clickNode==this) clickNode = HtmlNode.UDF;
		};
	}
	
	tree.EvalFunsAsk = tree.getEvalFunsAsk();
	park(model, true);
	root = new HtmlNode(model);
	// 将根节点下的方法转嫁到树图对象上来
	for(var o in root){
		if(o.indexOf("_") >= 0) continue;
		graftFun(this, root, o);
	}
	
	$(vessel).empty().addClass("htmltree").bind("selectstart", function(){return false;});
	root._setDom(vessel);
	root._init();
	root.expand();
	
	var sScript = "/Frame/page/js/widget/htmltree.js";
	var sCss = "/Frame/page/resources/css/widget/htmltree.css";
	var head = $("head", vessel.ownerDocument);
	var tempCss = $("link[href*='"+sCss+"']", head);
	if(tempCss.length == 0)
		css = $("<link rel=\"stylesheet\" type=\"text/css\" href=\""+$("script[src*='"+sScript+"']")[0].src.replace(sScript, sCss)+"\" >").appendTo(head);
	else css = $(tempCss[0]);
}