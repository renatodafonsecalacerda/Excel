function jqOn(expr,events,selector,data,handler){return $(expr).on(events,selector,data,handler);}
function jqToggleClass(expr,className)
{return $(expr).toggleClass(className);}
function jqToggle(expr,showOrHide)
{$(expr).toggle(showOrHide);}
function jqHide(expr)
{$(expr).hide();}
toggleBlocks=function(toggleThatThing,thisWasClicked,clickableItemType,toggleableItemType,clickOutsideToClose){toggleAction=function(){var toggleThatThingL=toggleThatThing;var thisWasClickedL=thisWasClicked;var clickableItemTypeL=clickableItemType;var toggleableItemTypeL=toggleableItemType;var clickOutsideToCloseL=clickOutsideToClose;tellMe=function(locationLogged){console.log(locationLogged+'|||'+toggleThatThingL+'|||'+thisWasClickedL+'|||'+clickableItemTypeL+'|||'+toggleableItemTypeL+'|||'+clickOutsideToCloseL);};startInvisibleClose=function(){if(!$('#invisibleClose')[0]){$('#uberContainer').append('<div id="invisibleClose" class="hidden"></div>');};};addInvisibleClose=function(){$('#invisibleClose').removeClass('hidden');};removeInvisibleClose=function(){$('#invisibleClose').removeClass('hidden');$('#invisibleClose').addClass('hidden');};if(clickOutsideToCloseL=='true'){startInvisibleClose();};$(thisWasClickedL).on('click',function(event){if(clickOutsideToCloseL=='true'){removeInvisibleClose();addInvisibleClose();};if($(thisWasClickedL).hasClass('selected')){$(clickableItemTypeL).removeClass('selected');$(toggleableItemTypeL).removeClass('showing');}else{$(clickableItemTypeL).removeClass('selected');$(thisWasClickedL).addClass('selected');$(toggleableItemTypeL).removeClass('showing');$(toggleThatThingL).addClass('showing');if($(toggleThatThingL).is('#headerLogin')){$('.headerLogin input[name="loginName"]').focus();};};event.preventDefault();});if(clickOutsideToCloseL=='true'){$('#invisibleClose').on('click',function(){removeInvisibleClose();$(clickableItemTypeL).removeClass('selected');$(toggleableItemTypeL).removeClass('showing');});};innerToggleButtonsCreate=function(){if($(toggleThatThing).has('.closeThatToggle').length<1){$('<span class="closeThatToggle"><span>close</span></span>').appendTo(toggleThatThing);}};innerToggleButtonsStart=function(){$(toggleableItemTypeL).on('click','.closeThatToggle span',function(){$(clickableItemTypeL).removeClass('selected');$(toggleableItemTypeL).removeClass('showing');});};innerToggleButtonsCreate();innerToggleButtonsStart();};toggleAction();};
function addLoadingWidget(targetExpr)
{$(targetExpr).prepend('<div class="dataLoading"></div>');}
function jqAsyncPost(targetExpr,url,json,callback)
{addLoadingWidget(targetExpr);$(targetExpr).load(url,json,callback);}
function jqClearTextField(expr,defaultValue)
{if(!defaultValue||$(expr).val()==defaultValue)
{$(expr).val('');}}
function createInputElement(type,id,name,classes,parentExpr,callback)
{var element=$(document.createElement("input")),parent=$(parentExpr?parentExpr:"body");element.attr({"type":type,"id":id,"name":name,"class":classes}).appendTo(parent);if(callback)
callback();return element;}
function jqGetParent(expr)
{return $(expr).parent();}
function jqGetProperty(expr,name)
{if((typeof name)=="string")
{return $(expr).prop(name);}}
function jqGetValue(expr){return $(expr).val();}
function jqFocus(expr)
{return $(expr).focus();}
function is(expr,value)
{return $(expr).is(value);}
function jqOff(expr,events,selector,handler){return $(expr).off(events,selector,handler);}
function jqOne(expr,events,selector,data,handler){return $(expr).one(events,selector,data,handler);}
function jqRemoveClass(expr,className)
{if(className!=null)
return $(expr).removeClass(className);else
return $(expr).removeClass();}
function jqRemove(expr)
{$(expr).remove();}
function replaceInput(expr,type,id,name,value,className,maxLength)
{var element=$(expr);var newElement=$(document.createElement("input"));newElement.attr({"type":type,"id":id,"name":name,"class":className,"value":value,"maxLength":maxLength});element.replaceWith(newElement);}
function submitForm(formId)
{document.getElementById(formId).submit();}
function jqTrigger(expr,event)
{$(expr).trigger(event);}
function showRecaptcha(element,publicKey,themeString)
{Recaptcha.create(publicKey,element,{theme:themeString});}
$(document).ready(function(e){function windowScrollEvent(){var scroll=0;if($("#header").position().top>0){scroll=$("#header").position().top;}
if($(window).scrollTop()>scroll){$('#header').addClass('fixed');}
else{$('#header').removeClass('fixed');}}
window.onload=function(){if(location.hash)
{$(window).off('scroll',':not([id^="contentFeed"])');scrollTo(0,$(location.hash).offset().top);windowScrollEvent();scrollTo(0,$(location.hash).offset().top-(($("#header .searchAccountToolsWrapper").length>0)?60:133));setTimeout(function(){$(window).on('scroll',windowScrollEvent);},2000);}
else
{$(window).on('scroll',windowScrollEvent);}}
$(document).ready(function(){$('a').on("click",function(e){$(window).off('scroll',':not([id^="contentFeed"])');var href=$(this).attr("href");if(href&&href.indexOf("#")==0&&href.length>1)
{setTimeout(function(){var offset=133;if($("#header .searchAccountToolsWrapper").length>0){if($("#header").hasClass("fixed"))
offset=60;else
offset=105;}
scrollTo(0,$(href).offset().top);windowScrollEvent();$('html, body').animate({scrollTop:$(href).offset().top-offset},'fast');return false;},50);}
setTimeout(function(){$(window).on('scroll',windowScrollEvent);},100);});});});
function jqBind(expr,type,data,fn){return jqOn(expr,type,null,data,fn);}
function setCookie(name,value,days,domain)
{var expiresString="";if(days)
{var date=new Date();date.setTime(date.getTime()+(days*24*60*60*1000));expiresString="; expires="+date.toGMTString();}
var domainString="";if(domain)
{domainString="; domain="+domain;}
document.cookie=name+"="+value+expiresString+domainString+"; path=/";}
moveFromPrependTo=function(moveFrom,moveTo){if($(moveFrom)[0]){$(moveFrom).prependTo(moveTo);};};
function jqSubmit(formExpr)
{$(formExpr).submit();}
baUpgradeCtaMove=function(){if($('.baUpBar')[0]){$('.baUpBar').prependTo('#wrapper2');};$(function(){$('.baUpBar .first-view').slideDown(500);});};
function isKeyCode(event,key)
{var code=(event.keyCode?event.keyCode:event.which);if(code==key)
{return true;}}
function readCookie(name)
{var nameEQ=name+"=";var ca=document.cookie.split(';');for(var i=0;i<ca.length;i++)
{var c=ca[i];while(c.charAt(0)==' ')
{c=c.substring(1,c.length);}
if(c.indexOf(nameEQ)==0)
{return c.substring(nameEQ.length,c.length);}}
return null;}
function selectElementById(id)
{var element=document.getElementById(id);if(element.tagName=="TEXTAREA"||(element.tagName=="INPUT"&&element.type=="text"))
{element.select();return;}else if(window.getSelection)
{var selection=window.getSelection();var range=document.createRange();range.selectNodeContents(element);selection.removeAllRanges();selection.addRange(range);}else if(document.selection)
{var range=document.body.createTextRange();document.selection.empty();range.moveToElementText(element);range.select();}else
{alert("This feature is not supported by your browser.");}}
function jqAddClass(expr,className)
{return $(expr).addClass(className);}
function jqAddToFormJson(formExpr,json)
{var formJson=$(formExpr).serializeArray();if(json.constructor==Array)
for(var o in json)
if(json[o].name!==undefined&&json[o].value!==undefined)
formJson.push(json[o]);return formJson;}
function jqAsyncPostForm(targetExpr,url,formExpr,callback)
{addLoadingWidget(targetExpr);$(targetExpr).load(url,$(formExpr).serializeArray(),callback);}
function jqData(expr,name,value)
{if(value==undefined||value==null)
{return $(expr).data(name);}
else
{return $(expr).data(name,value);}}
function jqDialog(expr,params,optionName,optionValue)
{if(params=='option'&&optionValue)
{return $(expr).dialog(params,optionName,optionValue);}
else if(params=='option'&&optionName)
{return $(expr).dialog(params,optionName);}
else if(params)
{return $(expr).dialog(params);}
else
{return $(expr).dialog();}}
function jqGetChildren(expr,filterExpr)
{if(filterExpr)
return $(expr).children(filterExpr);else
return $(expr).children();}
function jqHasClass(expr,className)
{return $(expr).hasClass(className);}
function jqIsVisible(expr){return $(expr).is(':visible');}
function jqLive(expr,type,fn){return jqOn(window.document,type,expr,null,fn);}
function jqNot(expr,selector)
{return $(expr).not(selector);}
function jqPost(url,data,callback,type)
{return $.post(url,data,callback,type);}
function jqSetAttribute(expr,name,value)
{if((typeof name)=="string")
{return $(expr).attr(name,value);}}
function jqSetText(expr,str){$(expr).text(str);}
function jqShow(expr)
{$(expr).show();}
function jqTabs(tabsExpr,contentsExpr,selectedIndex)
{tabsExpr=$(tabsExpr);contentsExpr=$(contentsExpr);tabsExpr.each(function(i)
{var tab=$(this);tab.click(function(e){tabsExpr.removeClass("selected");tab.addClass("selected");contentsExpr.hide();contentsExpr.eq(i).show();return false;});});if(selectedIndex!==undefined)
{tabsExpr.eq(selectedIndex).click();}
else
{tabsExpr.eq(0).click();}
return tabsExpr;}
function jqWordcount(expr,setExpr)
{var body=$(expr).val().replace(/\[b\]/g,'').replace(/\[\/b\]/g,'').replace(/\[i\]/g,'').replace(/\[\/i\]/g,'').replace(/\[u\]/g,'').replace(/\[\/u\]/g,'').replace(/\[bullet\]/g,'').replace(/\[\/bullet\]/g,'').replace(/\[subtitle\]/g,'').replace(/\[\/subtitle\]/g,'').replace(/\[indent\]/g,'').replace(/\[\/indent\]/g,'').replace(/\[quote\]/g,'').replace(/\[\/quote\]/g,'').replace(/\[code\]/g,'').replace(/\[\/code\]/g,'').replace(/\[step=[^\]]*\]/g,'').replace(/\[\/step\]/g,'').replace(/\[url=[^\]]*\]/g,'').replace(/\[\/url\]/g,'').replace(/\[embed=[^\]]*\]/g,'').replace(/\s+/g,' ').replace(/(^[\s\xA0]+|[\s\xA0]+$)/g,'').split(' ');var count=body.length;if(body=="")
{count=0;}
$(setExpr).html(count);}
function jqAppendHtml(expr,html)
{return $(expr).append(html);}
function jqPostForm(url,formExpr,callback,type)
{return $.post(url,$(formExpr).serializeArray(),callback,type);}
function jqSetHtml(expr,html)
{return $(expr).html(html);}
function jqAsyncLoad(expr,url,data,callback)
{addLoadingWidget(expr);if(callback)
return $(expr).load(url,data,callback);else if(data)
return $(expr).load(url,data);else
return $(expr).load(url);}
function expandTextarea(expr)
{var $textArea=$(expr);var textAreaHeight=$textArea.height();var textAreaScrollHeight=$textArea.prop("scrollHeight");if(textAreaScrollHeight>textAreaHeight)
{$textArea.height(textAreaScrollHeight);}}
/**
 * @license Rangy Text Inputs, a cross-browser textarea and text input library plug-in for jQuery.
 *
 * Part of Rangy, a cross-browser JavaScript range and selection library
 * http://code.google.com/p/rangy/
 *
 * Depends on jQuery 1.0 or later.
 *
 * Copyright 2010, Tim Down
 * Licensed under the MIT license.
 * Version: 0.1.205
 * Build date: 5 November 2010
 */
(function($){var UNDEF="undefined";var getSelection,setSelection,deleteSelectedText,deleteText,insertText;var replaceSelectedText,surroundSelectedText,extractSelectedText,collapseSelection;function isHostMethod(object,property){var t=typeof object[property];return t==="function"||(!!(t=="object"&&object[property]))||t=="unknown";}
function isHostProperty(object,property){return typeof(object[property])!=UNDEF;}
function isHostObject(object,property){return!!(typeof(object[property])=="object"&&object[property]);}
function fail(reason){if(window.console&&window.console.log){window.console.log("TextInputs module for Rangy not supported in your browser. Reason: "+reason);}}
function adjustOffsets(el,start,end){if(start<0){start+=el.value.length;}
if(typeof end==UNDEF){end=start;}
if(end<0){end+=el.value.length;}
return{start:start,end:end};}
function makeSelection(el,start,end){return{start:start,end:end,length:end-start,text:el.value.slice(start,end)};}
function getBody(){return isHostObject(document,"body")?document.body:document.getElementsByTagName("body")[0];}
$(document).ready(function(){var testTextArea=document.createElement("textarea");getBody().appendChild(testTextArea);if(isHostProperty(testTextArea,"selectionStart")&&isHostProperty(testTextArea,"selectionEnd")){getSelection=function(el){var start=el.selectionStart,end=el.selectionEnd;return makeSelection(el,start,end);};setSelection=function(el,startOffset,endOffset){var offsets=adjustOffsets(el,startOffset,endOffset);el.selectionStart=offsets.start;el.selectionEnd=offsets.end;};collapseSelection=function(el,toStart){if(toStart){el.selectionEnd=el.selectionStart;}else{el.selectionStart=el.selectionEnd;}};}else if(isHostMethod(testTextArea,"createTextRange")&&isHostObject(document,"selection")&&isHostMethod(document.selection,"createRange")){getSelection=function(el){var start=0,end=0,normalizedValue,textInputRange,len,endRange;var range=document.selection.createRange();if(range&&range.parentElement()==el){len=el.value.length;normalizedValue=el.value.replace(/\r\n/g,"\n");textInputRange=el.createTextRange();textInputRange.moveToBookmark(range.getBookmark());endRange=el.createTextRange();endRange.collapse(false);if(textInputRange.compareEndPoints("StartToEnd",endRange)>-1){start=end=len;}else{start=-textInputRange.moveStart("character",-len);start+=normalizedValue.slice(0,start).split("\n").length-1;if(textInputRange.compareEndPoints("EndToEnd",endRange)>-1){end=len;}else{end=-textInputRange.moveEnd("character",-len);end+=normalizedValue.slice(0,end).split("\n").length-1;}}}
return makeSelection(el,start,end);};var offsetToRangeCharacterMove=function(el,offset){return offset-(el.value.slice(0,offset).split("\r\n").length-1);};setSelection=function(el,startOffset,endOffset){var offsets=adjustOffsets(el,startOffset,endOffset);var range=el.createTextRange();var startCharMove=offsetToRangeCharacterMove(el,offsets.start);range.collapse(true);if(offsets.start==offsets.end){range.move("character",startCharMove);}else{range.moveEnd("character",offsetToRangeCharacterMove(el,offsets.end));range.moveStart("character",startCharMove);}
range.select();};collapseSelection=function(el,toStart){var range=document.selection.createRange();range.collapse(toStart);range.select();};}else{getBody().removeChild(testTextArea);fail("No means of finding text input caret position");return;}
getBody().removeChild(testTextArea);deleteText=function(el,start,end,moveSelection){var val;if(start!=end){val=el.value;el.value=val.slice(0,start)+val.slice(end);}
if(moveSelection){setSelection(el,start,start);}};deleteSelectedText=function(el){var sel=getSelection(el);deleteText(el,sel.start,sel.end,true);};extractSelectedText=function(el){var sel=getSelection(el),val;if(sel.start!=sel.end){val=el.value;el.value=val.slice(0,sel.start)+val.slice(sel.end);}
setSelection(el,sel.start,sel.start);return sel.text;};insertText=function(el,text,index,moveSelection){var val=el.value,caretIndex;el.value=val.slice(0,index)+text+val.slice(index);if(moveSelection){caretIndex=index+text.length;setSelection(el,caretIndex,caretIndex);}};replaceSelectedText=function(el,text){var sel=getSelection(el),val=el.value;el.value=val.slice(0,sel.start)+text+val.slice(sel.end);var caretIndex=sel.start+text.length;setSelection(el,caretIndex,caretIndex);};surroundSelectedText=function(el,before,after){var sel=getSelection(el),val=el.value;el.value=val.slice(0,sel.start)+before+sel.text+after+val.slice(sel.end);var startIndex=sel.start+before.length;var endIndex=startIndex+sel.length;setSelection(el,startIndex,endIndex);};function jQuerify(func,returnThis){return function(){var el=this.jquery?this[0]:this;var nodeName=el.nodeName.toLowerCase();if(el.nodeType==1&&(nodeName=="textarea"||(nodeName=="input"&&el.type=="text"))){var args=[el].concat(Array.prototype.slice.call(arguments));var result=func.apply(this,args);if(!returnThis){return result;}}
if(returnThis){return this;}};}
$.fn.extend({getSelection:jQuerify(getSelection,false),setSelection:jQuerify(setSelection,true),collapseSelection:jQuerify(collapseSelection,true),deleteSelectedText:jQuerify(deleteSelectedText,true),deleteText:jQuerify(deleteText,true),extractSelectedText:jQuerify(extractSelectedText,false),insertText:jQuerify(insertText,true),replaceSelectedText:jQuerify(replaceSelectedText,true),surroundSelectedText:jQuerify(surroundSelectedText,true)});});})(jQuery);
function getSelectedText(expr)
{var obj=$(expr);var selectedText="";var dataAttrStart='tagSelectionStart';var dataAttrEnd='tagSelectionEnd';obj.focus();var start,end;if(document.selection&&document.selection.createRange)
{start=jqData(expr,dataAttrStart);end=jqData(expr,dataAttrEnd);obj.setSelection(start,end);selectedText=obj.getSelection().text;}
else if(typeof(obj)!=="undefined")
{selectedText=obj.getSelection().text;}
return selectedText;}
function insertPseudoTag(expr,pTag,cTag,text)
{var obj=$(expr);var dataAttrStart='tagSelectionStart';var dataAttrEnd='tagSelectionEnd';if(pTag!==undefined&&pTag!=null)
{pTag='['+pTag+']';}
else
{pTag='';}
if(cTag!==undefined&&cTag!=null)
{cTag='[/'+cTag+']';}
else
{cTag='';}
obj.focus();var selection=obj.getSelection();var start=selection.start;var end=selection.end;if(document.selection&&document.selection.createRange){start=jqData(expr,dataAttrStart);end=jqData(expr,dataAttrEnd);}
if(end-start>0)
{obj.setSelection(start,end);if(text===undefined)
text=obj.getSelection().text;start+=pTag.length;end=start+text.length;obj.replaceSelectedText(pTag+text+cTag);obj.setSelection(start,end);jqData(expr,dataAttrStart,start);jqData(expr,dataAttrEnd,end);}
else
{var newtext='';if(text!==undefined)
{newtext=pTag+text+cTag;}
else
{newtext=pTag+cTag;}
obj.insertText(newtext,start);start+=pTag.length;obj.setSelection(start,start);jqData(expr,dataAttrStart,start);}
obj.focus();var columns=obj.prop('cols');var selectionRow=(start-(start%columns))/columns;var lineHeight=obj.prop('clientHeight')/obj.prop('rows');obj.scrollTop(lineHeight*selectionRow);}
function jqObject(expr,context)
{return $(expr,context);}
function readConsolidatedCookie(prefix,name)
{var ca=document.cookie.split(';');for(var i=0;i<ca.length;i++)
{var c=ca[i];while(c.charAt(0)==' ')
{c=c.substring(1,c.length);}
if(c.indexOf(prefix)==0)
{var nameEQ=name+"=";if(c.indexOf(nameEQ)!=-1)
{var cc=c.split('&');for(var j=0;j<cc.length;j++)
{var sc=cc[j];if(sc.indexOf(nameEQ)!=-1)
{var value=sc.substring(sc.indexOf(nameEQ)+nameEQ.length);if(value=="true")
{return true;}
else if(value=="false")
{return false;}
return value;}}}}}
return null;}
function removeEmbedTag(expr,elementId,embedType)
{var textArea=$(expr);if(textArea!=null)
{var txt="\\[embed="+embedType+" "+elementId+"\\]";var regx=new RegExp(txt,"gi");textArea.val(textArea.val().replace(regx," "));}}
function jqSetValue(expr,str){$(expr).val(str);}
function toggleInputExpansion(inputExpr,toggleExpr,expandedClass,collapsedClass)
{var $inputExpr=$(inputExpr),$toggleExpr=$(toggleExpr),height=$inputExpr.height();$inputExpr.height($toggleExpr.hasClass(collapsedClass)?height*3:height/3);$toggleExpr.toggleClass(expandedClass);$toggleExpr.toggleClass(collapsedClass);}
function jqLimitText(expr,limit)
{var value=$(expr).val();if(value.length>limit)
{$(expr).val(value.substring(0,limit));}}
function jqGetSiblings(expr,filterExpr)
{return $(expr).siblings(filterExpr);}
/*!
 * slidr v0.5.0 - A Javascript library for adding slide effects.
 * bchanx.com/slidr
 * MIT licensed
 *
 * Copyright (c) 2014 Brian Chan (bchanx.com)
 */
(function(root,factory){if(typeof exports==='object')module['exports']=factory();else if(typeof define==='function'&&define['amd'])define(factory);else root['slidr']=factory();}(this,function(){'use strict';function lookup(obj,keys){var result=obj;for(var k in keys){if(!result||!result.hasOwnProperty(keys[k]))return null;result=result[keys[k]];}
return(result===obj)?null:result;}
function extend(){var newobj={};for(var i=0,arg;arg=arguments[i];i++)for(var a in arg)newobj[a]=arg[a];return newobj;}
function contains(a,b){return(a.contains)?a.contains(b):(a.compareDocumentPosition)?a.compareDocumentPosition(b)&16:0;}
function tagName(el){return(el.tagName)?el.tagName.toLowerCase():null;}
function indexOf(list,val){if(Array.prototype.indexOf)return list.indexOf(val);for(var i=0,len=list.length;i<len;i++)if(list[i]===val)return i;return-1;}
function trim(str){return("".trim)?str.trim():str.replace(/^\s+|\s+$/g,'');}
function createEl(tag,props){var el=document.createElement(tag);for(var p in props)el[p]=props[p];return el;}
function classname(el,type){var clsnames=trim(el.className);clsnames=(clsnames)?clsnames.split(/\s+/):[];for(var a=2,cls,idx;cls=arguments[a];a++){idx=indexOf(clsnames,cls);if(type==='add'&&idx<0)clsnames.push(cls);if(type==='rm'&&idx>=0)clsnames.splice(idx,1);}
el.className=clsnames.join(' ');return el;}
function normalize(str){return str.replace(/[\s'"]/gi,'').split('').sort().join('');}
function setattr(el,name,value){if(el&&el.setAttribute)el.setAttribute(name,value);return el;}
function getattr(el,name){return(el&&el.getAttribute)?el.getAttribute(name):null;}
function css(el,prop){if(typeof prop==='string'){var view=(document.defaultView)?document.defaultView.getComputedStyle(el):el.currentStyle;var style=view[browser.fix(prop)];if(!style&&prop==='opacity')style=(view.filter)?view.filter.split('=')[1].replace(')',''):'1';if(style){var val=style.slice(0,-2);return(style.slice(-2)==='px'&&!isNaN(parseInt(val))&&val.search('px')<=0)?parseInt(val):style;}
return'none';}
for(var p in prop)
{try
{if(browser.fix(p))
el.style[browser.fix(p)]=prop[p];}
catch(_)
{}}
return el;}
function bind(el,ev,callback,optUnbind){if(typeof(ev)==='string')ev=[ev];for(var i=0,e,isAnimation;e=ev[i];i++){isAnimation=indexOf(browser.animations,e)>0;e=(e==='click'&&'ontouchstart' in window)?'touchend':(el.attachEvent&&!isAnimation)?'on'+e:e;(el.attachEvent&&!isAnimation)?(optUnbind?el.detachEvent(e,callback):el.attachEvent(e,callback)):(optUnbind?el.removeEventListener(e,callback):el.addEventListener(e,callback));}}
function unbind(el,ev,callback){bind(el,ev,callback,true);}
function borderbox(el){return css(el,'box-sizing')==='border-box';}
var browser={prefixes:['webkit','Moz','ms','O'],cache:{},keyframes:{},isIE:function(){if(browser.supports('filter')&&!browser.supports('opacity'))browser.isIE=function(){return true;};else browser.isIE=function(){return false;};return browser.isIE();},styleEl:document.getElementsByTagName('html')[0]['style'],styleSheet:(function(){var el=createEl('style',{'type':'text/css'});document.getElementsByTagName('head')[0].appendChild(el);return el.sheet||el.styleSheet;}()),cssRules:function(){browser.cssRules=function(){return browser.styleSheet.cssRules||browser.styleSheet.rules;};return browser.cssRules();},insertRule:function(rule){if(browser.styleSheet.insertRule){browser.insertRule=function(r){browser.styleSheet.insertRule(r,browser.cssRules().length);};}else{browser.insertRule=function(r){var split=r.split(' {');if(split.length===2){var left=split[0];var right=trim(split[1].replace(/;?\s?}$/g,''));if(left&&right)browser.styleSheet.addRule(left,right);}}}
browser.insertRule(rule);},addCSSRule:function(name,rule,optSafe){name=normalize(name);for(var r=0,cssRule,cssName;cssRule=browser.cssRules()[r];r++){cssName=normalize((cssRule.name||cssRule.selectorText||cssRule.cssText.split(' {')[0]||''));if(cssName===name){if(!!optSafe||(normalize(cssRule.cssText)===normalize(rule)))return;browser.styleSheet.deleteRule(r);break;}}
browser.insertRule(rule);},createRule:function(name,props){var rule=[name,'{'];for(var p in props)if(browser.fix(p,true))rule.push(browser.fix(p,true)+':'+props[p]+';');rule.push('}');return rule.join(' ');},createStyle:function(name,props,optSafe){browser.addCSSRule(name,browser.createRule(name,props),optSafe);},prefix:function(prop){return(prop.split('-').length===3)?'-'+prop.split('-')[1]+'-':'';},createKeyframe:function(name,rules){var animation=browser.fix('animation',true);if(animation&&!browser.keyframes[name]){var rule=['@'+browser.prefix(animation)+'keyframes '+name+' {'];for(var r in rules)rule.push(browser.createRule(r+'%',rules[r]));rule.push('}');browser.addCSSRule(name,rule.join(' '));browser.keyframes[name]=true;}},fix:function(prop,forCSS){if(!(prop in browser.cache)){var parts=prop.split('-');for(var i=0,p;p=parts[i];i++)parts[i]=p[0].toUpperCase()+p.toLowerCase().slice(1);var domprop=parts.join('');domprop=domprop[0].toLowerCase()+domprop.slice(1);if(browser.styleEl[domprop]!==undefined){browser.cache[prop]={css:prop,dom:domprop};}else{domprop=parts.join('');for(i=0;i<browser.prefixes.length;i++){if(browser.styleEl[browser.prefixes[i]+domprop]!==undefined){browser.cache[prop]={css:'-'+browser.prefixes[i].toLowerCase()+'-'+prop,dom:browser.prefixes[i]+domprop};}}}
if(!browser.cache[prop])browser.cache[prop]=null;}
return(browser.cache[prop]!==null)?(forCSS)?browser.cache[prop].css:browser.cache[prop].dom:null;},supports:function(){for(var i=0,prop;prop=arguments[i];i++)if(!browser.fix(prop))return false;return true;},add:{'fade':function(name,oStart,oEnd){browser.createKeyframe(name,{'0':{'opacity':oStart,'visibility':'visible'},'100':{'opacity':oEnd,'visibility':'hidden'}});},'linear':function(name,type,tStart,tEnd,oStart,oEnd){browser.createKeyframe(name,{'0':{'transform':'translate'+tStart[0]+'(0%)','opacity':(type==='in'?'0':oStart),'visibility':'visible'},'1':{'transform':'translate'+tStart+'px)','opacity':oStart},'99':{'transform':'translate'+tEnd+'px)','opacity':oEnd},'100':{'transform':'translate'+tEnd[0]+'(0%)','opacity':(type==='out'?'0':oEnd),'visibility':'hidden'}});},'cube':function(name,rStart,rEnd,tZ,oStart,oEnd){browser.createKeyframe(name,{'0':{'transform':'rotate'+rStart+'0deg) translateZ('+tZ+'px)','opacity':oStart,'visibility':'visible'},'100':{'transform':'rotate'+rEnd+'0deg) translateZ('+tZ+'px)','opacity':oEnd,'visibility':'hidden'}});}},classnames:function(cls){return{main:cls,maincss:'aside[id*="-'+cls+'"]',nav:'slidr-'+cls,navcss:'aside[id*="-'+cls+'"] .slidr-'+cls,data:'data-slidr-'+cls,id:function(_,css){return css?'aside[id="'+_.id+'-'+cls+'"]':_.id+'-'+cls;}}},sanitize:function(e){e=e||window.event;if(!e.target)e.target=e.srcElement;if(!e.currentTarget)e.currentTarget=e.srcElement;if(!e.which&&e.keyCode)e.which=e.keyCode;return e;},stop:function(e){e=e||window.event;e.cancelBubble=true;e.returnValue=false;if(e.stopPropagation)e.stopPropagation();if(e.preventDefault)e.preventDefault();return false;},animations:['animationend','webkitAnimationEnd','oanimationend','MSAnimationEnd']};var transition={available:['cube','fade','linear','none'],validate:function(_,trans){trans=trans||_.settings['transition'];return(indexOf(transition.available,trans)<0||!fx.supported[trans])?'none':trans;},get:function(_,el,type,dir){return lookup(_.trans,[el,(type==='in')?slides.opposite(dir):dir]);},set:function(_,el,dir,trans){trans=transition.validate(_,trans);if(!_.trans[el])_.trans[el]={};_.trans[el][dir]=trans;return trans;},apply:function(_,el,type,dir,trans){breadcrumbs.update(_,el,type);fx.animate(_,el,trans,type,dir);}};var callback={cache:{},hash:function(meta){return[meta['id'],meta['in']['slidr'],meta['in']['trans'],meta['in']['dir'],meta['out']['slidr'],meta['out']['trans'],meta['out']['dir']].join('-');},meta:function(_,outs,ins,outdir,indir,outtrans,intrans){return{'id':_.id,'in':{'el':slides.get(_,ins).el,'slidr':ins,'trans':intrans,'dir':indir},'out':{'el':slides.get(_,outs).el,'slidr':outs,'trans':outtrans,'dir':slides.opposite(outdir)}};},before:function(_,meta){var hash=callback.hash(meta);if(!callback.cache[hash])callback.cache[hash]={};if(!callback.cache[hash].before){callback.cache[hash].before=true;var cb=_.settings['before'];if(typeof cb==='function')cb(meta);}},after:function(_,meta){var hash=callback.hash(meta);if(!callback.cache[hash].after){callback.cache[hash].after=true;var cb=_.settings['after'];if(typeof cb==='function')callback.bindonce(cb,meta);}},bindonce:function(cb,meta){if(browser.supports('animation')&&meta['in']['trans']!=='none'){var newCallback=function(e){if(browser.keyframes[e.animationName]){cb(meta);unbind(meta['in']['el'],browser.animations,newCallback);callback.reset(meta);}};bind(meta['in']['el'],browser.animations,newCallback);}else{cb(meta);callback.reset(meta);}},reset:function(meta){var hash=callback.hash(meta);callback.cache[hash].before=false;callback.cache[hash].after=false;}};var slides={directions:['left','up','top','right','down','bottom'],isdir:function(next){return indexOf(slides.directions,next)>=0;},opposite:function(dir){var length=slides.directions.length;return slides.isdir(dir)?slides.directions[(indexOf(slides.directions,dir)+length/2)%length]:null;},get:function(_){var args=[];for(var i=1,a;(a=arguments[i++])!==undefined;args.push(a)){};return lookup(_.slides,args);},display:function(_){if(!_.displayed&&slides.get(_,_.start)){_.current=_.start;breadcrumbs.create(_);controls.create(_);fx.init(_,_.current,'fade');fx.animate(_,_.current,'fade','in');_.displayed=true;actions.controls(_,_.settings['controls']);if(!!_.settings['breadcrumbs'])actions.breadcrumbs(_);}},slide:function(_,next){return slides.isdir(next)?slides.go(_,slides.get(_,_.current,next),next,next):slides.jump(_,next);},jump:function(_,el){if(el&&el!==_.current&&slides.get(_,el)){var cur=_.crumbs[_.current];var next=_.crumbs[el];var hdir=(cur.x<next.x)?'right':(cur.x>next.x)?'left':null;var vdir=(cur.y<next.y)?'up':(cur.y>next.y)?'down':null;var outdir=(transition.get(_,_.current,'out',hdir))?hdir:(transition.get(_,_.current,'out',vdir))?vdir:null;var indir=(transition.get(_,el,'in',hdir))?hdir:(transition.get(_,el,'in',vdir))?vdir:null;slides.go(_,el,outdir,indir,(outdir)?null:'fade',(indir)?null:'fade');}},go:function(_,el,outdir,indir,opt_outtrans,opt_intrans){if(_.current&&el){var intrans=opt_intrans||transition.get(_,el,'in',indir);var outtrans=opt_outtrans||transition.get(_,_.current,'out',outdir);var meta=callback.meta(_,_.current,el,outdir,indir,outtrans,intrans);callback.before(_,meta);transition.apply(_,el,'in',indir,intrans);transition.apply(_,_.current,'out',outdir,outtrans);callback.after(_,meta);_.current=el;controls.update(_);return true;}
return false;},find:function(_,opt_asList){var valid=(opt_asList)?[]:{};for(var i=0,slide,name;slide=_.slidr.childNodes[i];i++){name=getattr(slide,'data-slidr');if(name){if(opt_asList&&indexOf(valid,name)<0)valid.push(name);else if(!(name in valid))valid[name]=slide;}}
return valid;},validate:function(_,ids,trans,valid,prev,next){if(!ids||ids.constructor!==Array)return false;for(var i=0,current,newPrev,newNext,oldPrev,oldNext,prevPrev,oldPrevTrans,oldNextTrans;current=ids[i];i++){if(!(current in valid))return false;if(slides.get(_,current)){newPrev=ids[i-1]||null;newNext=ids[i+1]||null;oldPrev=slides.get(_,current,prev);oldNext=slides.get(_,current,next);prevPrev=slides.get(_,newNext,prev);oldPrevTrans=transition.get(_,current,'out',prev);oldNextTrans=transition.get(_,current,'out',next);if((oldNext&&newNext&&oldNext!=newNext)||(oldPrev&&newPrev&&oldPrev!=newPrev)||(prevPrev&&prevPrev!=current)||(newPrev&&oldPrevTrans&&oldPrevTrans!=trans)||(newNext&&oldNextTrans&&oldNextTrans!=trans)){return false;}}}
return true;},add:function(_,ids,trans,valid,prev,next){for(var i=0,current;current=ids[i];i++){_.slides[current]=_.slides[current]||{};var s=slides.get(_,current);s.el=valid[current];if(ids[i-1]){s[prev]=ids[i-1];transition.set(_,current,prev,trans);}
if(ids[i+1]){s[next]=ids[i+1];transition.set(_,current,next,trans);}
fx.init(_,current,trans);_.start=(!_.start)?current:_.start;}
if(_.started)(!_.displayed)?slides.display(_):breadcrumbs.create(_);return true;}};var controls={cls:browser.classnames('control'),types:['border','corner','none'],valid:function(ctrl){return indexOf(controls.types,ctrl)>=0;},create:function(_){if(_.slidr&&!_.controls){_.controls=css(classname(createEl('aside',{'id':controls.cls.id(_)}),'add','disabled'),{'opacity':'0','filter':'alpha(opacity=0)','z-index':'0','visibility':'hidden','pointer-events':'none'});for(var n in _.nav){_.nav[n]=setattr(classname(createEl('div'),'add',controls.cls.nav,n),controls.cls.data,n);_.controls.appendChild(_.nav[n]);}
controls.css(_);_.slidr.appendChild(_.controls);bind(_.controls,'click',controls.onclick(_));}},css:function(_){browser.createStyle(controls.cls.maincss,{'position':'absolute','bottom':css(_.slidr,'padding-bottom')+'px','right':css(_.slidr,'padding-right')+'px','padding':'10px','box-sizing':'border-box','width':'75px','height':'75px','transform':'translateZ(9998px)'},true);browser.createStyle(controls.cls.maincss+'.disabled',{'transform':'translateZ(0px) !important'},true);browser.createStyle(controls.cls.maincss+'.breadcrumbs',{'left':css(_.slidr,'padding-left')+'px','right':'auto'},true);browser.createStyle(controls.cls.maincss+'.border',{'bottom':'0','right':'0','left':'0','width':'100%','height':'100%'},true);browser.createStyle(controls.cls.navcss,{'position':'absolute','pointer-events':'auto','cursor':'pointer','transition':'opacity 0.2s linear'},true);var disabled={'opacity':'0.05','cursor':'auto'};if(browser.isIE())disabled['display']='none';browser.createStyle(controls.cls.navcss+'.disabled',disabled,true);var n,horizontal,pos,dir,ctrl,after,border,borderpad;for(n in _.nav){horizontal=(n==='left'||n==='right');pos=(n==='up')?'top':(n==='down')?'bottom':n;dir=horizontal?'top':'left';ctrl={'width':horizontal?'22px':'16px','height':horizontal?'16px':'22px','tap-highlight-color':'rgba(0, 0, 0, 0)','touch-callout':'none','user-select':'none'};ctrl[pos]='0';ctrl[dir]='50%';ctrl['margin-'+dir]='-8px';browser.createStyle(controls.cls.navcss+'.'+n,ctrl,true);after={'width':'0','height':'0','content':'""','position':'absolute','border':'8px solid transparent'};after['border-'+slides.opposite(pos)+'-width']='12px';after['border-'+pos+'-width']='10px';after['border-'+slides.opposite(pos)+'-color']=_.settings['theme'];after[pos]='0';after[dir]='50%';after['margin-'+dir]='-8px';browser.createStyle(controls.cls.id(_,true)+' .'+controls.cls.nav+'.'+n+':after',after,true);border={};border[horizontal?'height':'width']='100%';border[dir]='0';border['margin-'+dir]='0';browser.createStyle(controls.cls.maincss+'.border .'+controls.cls.nav+'.'+n,border,true);borderpad={};borderpad[pos]=css(_.slidr,'padding-'+pos)+'px';browser.createStyle(controls.cls.id(_,true)+'.border .'+controls.cls.nav+'.'+n,borderpad,true);}},onclick:function(_){return function handler(e){actions.slide(_,getattr(browser.sanitize(e).target,controls.cls.data));};},update:function(_){for(var n in _.nav)classname(_.nav[n],actions.canSlide(_,n)?'rm':'add','disabled');}};var breadcrumbs={cls:browser.classnames('breadcrumbs'),init:function(_){if(_.slidr&&!_.breadcrumbs){_.breadcrumbs=css(classname(createEl('aside',{'id':breadcrumbs.cls.id(_)}),'add','disabled'),{'opacity':'0','filter':'alpha(opacity=0)','z-index':'0','pointer-events':'none','visibility':'hidden'});breadcrumbs.css(_);_.slidr.appendChild(_.breadcrumbs);bind(_.breadcrumbs,'click',breadcrumbs.onclick(_));}},css:function(_){browser.createStyle(breadcrumbs.cls.maincss,{'position':'absolute','bottom':css(_.slidr,'padding-bottom')+'px','right':css(_.slidr,'padding-right')+'px','padding':'10px','box-sizing':'border-box','transform':'translateZ(9999px)'},true);browser.createStyle(breadcrumbs.cls.maincss+'.disabled',{'transform':'translateZ(0px) !important'},true);browser.createStyle(breadcrumbs.cls.navcss,{'padding':'0','font-size':'0','line-height':'0'},true);browser.createStyle(breadcrumbs.cls.navcss+' li',{'width':'10px','height':'10px','display':'inline-block','margin':'3px','tap-highlight-color':'rgba(0, 0, 0, 0)','touch-callout':'none','user-select':'none'},true);browser.createStyle(breadcrumbs.cls.id(_,true)+' .'+breadcrumbs.cls.nav+' li.normal',{'border-radius':'100%','border':'1px '+_.settings['theme']+' solid','cursor':'pointer','pointer-events':'auto'},true);browser.createStyle(breadcrumbs.cls.id(_,true)+' .'+breadcrumbs.cls.nav+' li.active',{'width':'12px','height':'12px','margin':'2px','background-color':_.settings['theme']},true);},onclick:function(_){return function handler(e){actions.slide(_,getattr(browser.sanitize(e).target,breadcrumbs.cls.data));};},offsets:{'right':{x:1,y:0},'up':{x:0,y:1},'left':{x:-1,y:0},'down':{x:0,y:-1}},find:function(_,crumbs,bounds,el,x,y){if(el){if(!crumbs[el]){crumbs[el]={x:x,y:y};if(x<bounds.x.min)bounds.x.min=x;if(x>bounds.x.max)bounds.x.max=x;if(y<bounds.y.min)bounds.y.min=y;if(y>bounds.y.max)bounds.y.max=y;}
el=slides.get(_,el);for(var o in breadcrumbs.offsets){if(el[o]&&!crumbs[el[o]]){breadcrumbs.find(_,crumbs,bounds,el[o],x+breadcrumbs.offsets[o].x,y+breadcrumbs.offsets[o].y);}}}},update:function(_,el,type){classname(_.crumbs[el].el,type==='in'?'add':'rm','active');},create:function(_){breadcrumbs.init(_);if(_.breadcrumbs){var crumbs={};var bounds={x:{min:0,max:0},y:{min:0,max:0}};breadcrumbs.find(_,crumbs,bounds,_.start,0,0);bounds.x.modifier=0-bounds.x.min;bounds.y.modifier=0-bounds.y.min;var crumbsMap={};for(var el in crumbs){crumbs[el].x+=bounds.x.modifier;crumbs[el].y+=bounds.y.modifier;crumbsMap[crumbs[el].x+','+crumbs[el].y]=el;}
var rows=bounds.y.max-bounds.y.min+1;var columns=bounds.x.max-bounds.x.min+1;while(_.breadcrumbs.firstChild)_.breadcrumbs.removeChild(_.breadcrumbs.firstChild);var ul=classname(createEl('ul'),'add',breadcrumbs.cls.nav);var li=createEl('li');for(var r=rows-1,ulclone;r>=0;r--){ulclone=ul.cloneNode(false);for(var c=0,liclone,element;c<columns;c++){liclone=li.cloneNode(false);element=crumbsMap[c+','+r];if(element){classname(liclone,'add','normal',element===_.current?'active':null);setattr(liclone,breadcrumbs.cls.data,element);crumbs[element].el=liclone;}
ulclone.appendChild(liclone);};_.breadcrumbs.appendChild(ulclone);}
_.crumbs=crumbs;}}};var fx={init:function(_,el,trans){var s=slides.get(_,el);if(!s.initialized){var display=css(s.el,'display');var init={'display':(display==='none')?'block':display,'visibility':'hidden','position':'absolute','opacity':'0','filter':'alpha(opacity=0)','z-index':'0','pointer-events':'none','backface-visibility':'hidden','transform-style':'preserve-3d'}
if(browser.isIE())init=extend(init,{'display':'none','visibility':'visible'});s.initialized=true;css(s.el,init);}},supported:{'none':true,'fade':browser.supports('animation','opacity'),'linear':browser.supports('animation','opacity','transform'),'cube':browser.supports('animation','backface-visibility','opacity','transform','transform-style')},animation:{'fade':(function(){browser.add['fade']('slidr-fade-in','0','1');browser.add['fade']('slidr-fade-out','1','0');})(),'linear':{'in':{'left':function(name,w,o){browser.add['linear'](name,'in','X(-'+w,'X(0',o,'1');},'right':function(name,w,o){browser.add['linear'](name,'in','X('+w,'X(0',o,'1');},'up':function(name,h,o){browser.add['linear'](name,'in','Y(-'+h,'Y(0',o,'1');},'down':function(name,h,o){browser.add['linear'](name,'in','Y('+h,'Y(0',o,'1');}},'out':{'left':function(name,w,o){browser.add['linear'](name,'out','X(0','X('+w,'1',o);},'right':function(name,w,o){browser.add['linear'](name,'out','X(0','X(-'+w,'1',o);},'up':function(name,h,o){browser.add['linear'](name,'out','Y(0','Y('+h,'1',o);},'down':function(name,h,o){browser.add['linear'](name,'out','Y(0','Y(-'+h,'1',o);}}},'cube':{'in':{'left':function(name,w,o){browser.add['cube'](name,'Y(-9','Y(',w/2,o,'1');},'right':function(name,w,o){browser.add['cube'](name,'Y(9','Y(',w/2,o,'1');},'up':function(name,h,o){browser.add['cube'](name,'X(9','X(',h/2,o,'1');},'down':function(name,h,o){browser.add['cube'](name,'X(-9','X(',h/2,o,'1');}},'out':{'left':function(name,w,o){browser.add['cube'](name,'Y(','Y(9',w/2,'1',o);},'right':function(name,w,o){browser.add['cube'](name,'Y(','Y(-9',w/2,'1',o);},'up':function(name,h,o){browser.add['cube'](name,'X(','X(-9',h/2,'1',o);},'down':function(name,h,o){browser.add['cube'](name,'X(','X(9',h/2,'1',o);}}}},name:function(_,target,trans,type,dir){var parts=['slidr',trans,type];if((trans==='linear'||trans==='cube')&&dir){parts.push(dir);var opacity=(!!_.settings['fade'])?'0':'1';if(opacity==='0')parts.push('fade');var prop=(dir==='up'||dir==='down')?'h':'w';var s=(prop==='h')?size.getHeight(target):size.getWidth(target);parts.push(prop,s);var keyframe=lookup(fx.animation,[trans,type,dir]);if(keyframe)keyframe(parts.join('-'),s,opacity);}
return parts.join('-');},animate:function(_,el,trans,type,dir,opt_target,opt_z,opt_pointer){var anim={'opacity':(type==='in')?'1':'0','filter':'alpha(opacity='+(type==='in'?'100':'0')+')','z-index':opt_z||(type==='in'?'1':'0'),'visibility':(type==='in')?'visible':'hidden','pointer-events':opt_pointer||(type==='in'?'auto':'none')};if(browser.isIE())anim=extend(anim,{'display':(type==='in')?'block':'none','visibility':'visible'});var target=opt_target||slides.get(_,el).el;var timing=_.settings['timing'][trans];if(fx.supported[trans]&&timing){var name=fx.name(_,target,trans,type,dir);anim['animation']=(trans==='none')?'none':[name,timing].join(' ');}
css(target,anim);if(slides.get(_,el)&&browser.supports('transform'))fx.fixTranslateZ(_,target,type);},fixTranslateZ:function(_,el,opt_type){var asides=el.getElementsByTagName('aside');if(asides.length){for(var i=0,aside,p,toggle,visibility;aside=asides[i];i++){if(!!aside.getAttribute('id')){p=aside.parentNode;while(!getattr(p,'data-slidr')&&tagName(p)!=='body')p=p.parentNode;if(tagName(p)==='body')p=_.slidr;visibility=css(p,'visibility');toggle=(opt_type==='out'||!opt_type&&visibility==='hidden')?'add':(visibility==='visible')?'rm':null;if(toggle)classname(aside,toggle,'disabled');}}}}};var size={active:{},autoResize:function(_){size.active[_.id]={src:_,w:0,h:0,d:size.dynamic(_)};},dynamic:function(_){var clone=css(_.slidr.cloneNode(false),{'position':'absolute','opacity':'0','filter':'alpha(opacity=0)'});var probe=css(createEl('div'),{'width':'42px','height':'42px'});clone.appendChild(probe);_.slidr.parentNode.insertBefore(clone,_.slidr);var originalWidth=(borderbox(clone)?size.extraWidth(_.slidr):0)+42;var originalHeight=(borderbox(clone)?size.extraHeight(_.slidr):0)+42;var cloneWidth=css(clone,'width');var cloneHeight=css(clone,'height');var minWidth=css(clone,'min-width');var minHeight=css(clone,'min-height');var dynamic={width:cloneWidth==='auto'||cloneWidth===originalWidth||minWidth!==0&&minWidth!='auto',height:cloneHeight==='auto'||cloneHeight===originalHeight||minHeight!==0&&minHeight!='auto'};_.slidr.parentNode.removeChild(clone);return dynamic;},sum:function(){for(var i=0,s=0,arg;arg=arguments[i];i++)s+=arg;return isNaN(s)?0:s;},widthMargin:function(el){return size.sum(Math.max(0,css(el,'margin-left')),Math.max(0,css(el,'margin-right')));},heightMargin:function(el){return size.sum(Math.max(0,css(el,'margin-top')),Math.max(0,css(el,'margin-bottom')));},widthPad:function(el){return size.sum(css(el,'padding-left'),css(el,'padding-right'));},heightPad:function(el){return size.sum(css(el,'padding-top'),css(el,'padding-bottom'));},widthBorder:function(el){return size.sum(css(el,'border-left-width'),css(el,'border-right-width'));},heightBorder:function(el){return size.sum(css(el,'border-top-width'),css(el,'border-bottom-width'));},extraWidth:function(el){return size.sum(size.widthPad(el),size.widthBorder(el));},extraHeight:function(el){return size.sum(size.heightPad(el),size.heightBorder(el));},getWidth:function(el){var w=css(el,'width');if(browser.isIE()&&w==='auto'&&el.clientWidth)w=el.clientWidth;if(w!=='auto')w+=(size.widthMargin(el)+(borderbox(el)?0:size.extraWidth(el)));return w;},getHeight:function(el){var h=css(el,'height');if(browser.isIE()&&h==='auto'&&el.clientHeight)h=el.clientHeight;if(h!=='auto')h+=(size.heightMargin(el)+(borderbox(el)?0:size.extraHeight(el)));return h;},setWidth:function(el,w){var prop=w;if(w!=='auto'&&w!=='')prop=(w+(borderbox(el)?size.extraWidth(el):0))+'px';css(el,{width:prop});return w;},setHeight:function(el,h){var prop=h;if(h!=='auto'&&h!=='')prop=(h+(borderbox(el)?size.extraHeight(el):0))+'px';css(el,{height:prop});return h;}};var nav={mouse:{over:[],isOver:function(id){return indexOf(nav.mouse.over,id)>=0;},add:function(id){if(!nav.mouse.isOver(id))nav.mouse.over.push(id);},remove:function(id){if(nav.mouse.isOver(id))nav.mouse.over.splice(indexOf(nav.mouse.over,id),1);},current:function(){var c=nav.mouse.over[nav.mouse.over.length-1];for(var i=0,l=nav.mouse.over.length,m=nav.mouse.over[i];i<l;i++)if(contains(c,m))c=m;return c;},track:function(el){bind(el,'mouseenter',function(e){nav.mouse.add(browser.sanitize(e).currentTarget.id);});bind(el,'mouseleave',function(e){nav.mouse.remove(browser.sanitize(e).currentTarget.id);});}},keyboard:(function(){bind(document,'keydown',function(e){e=browser.sanitize(e);if(nav.mouse.current()&&e.which<=40&&e.which>=37){var c=INSTANCES[nav.mouse.current()];var dir=null;if(e.which===40&&c['canSlide']('down')){dir='down';}
else if(e.which===39&&c['canSlide']('right')){dir='right';}
else if(e.which===38&&c['canSlide']('up')){dir='up';}
else if(e.which===37&&c['canSlide']('left')){dir='left';}
if(dir)c['slide'](dir)&&browser.stop(e);}});})(),touch:function(_){var start={};var delta={};bind(_.slidr,'touchstart',function(e){e=browser.sanitize(e);start={x:e.touches[0].pageX,y:e.touches[0].pageY,time:+new Date};delta={x:0,y:0,duration:0};});bind(_.slidr,'touchmove',function(e){e=browser.sanitize(e);if(e.touches.length>1||e.scale&&e.scale!==1)return;delta.x=e.touches[0].pageX-start.x;delta.y=e.touches[0].pageY-start.y;delta.duration=+new Date-start.time;if(delta.duration>100&&(Math.abs(delta.x)+Math.abs(delta.y))/delta.duration<0.25)return;browser.stop(e);});bind(_.slidr,'touchend',function(e){e=browser.sanitize(e);if(Number(+new Date-start.time)<250){var dx=Math.abs(delta.x);var dy=Math.abs(delta.y);var validH=dx>20;var validV=dy>20;var dirH=delta.x<0?'right':'left';var dirV=delta.y<0?'down':'up';var dir=(validH&&validV?(dx>dy?dirH:dirV):(validH?dirH:(validV?dirV:null)));if(dir)actions.slide(_,dir);browser.stop(e);}});}};var actions={start:function(_,opt_start){if(!_.started&&_.slidr){var display=css(_.slidr,'display');var position=css(_.slidr,'position');var opacity=css(_.slidr,'opacity');css(_.slidr,{'visibility':'visible','opacity':opacity,'filter':'alpha(opacity='+opacity*100+')','display':(display==='inline-block'||display==='inline')?'inline-block':'block','position':(position==='static')?'relative':position,'overflow':(!!_.settings['overflow'])?css(_.slidr,'overflow'):'hidden','transition':'height 0.05s ease-out, width 0.05s ease-out','tap-highlight-color':'rgba(0, 0, 0, 0)','touch-callout':'none'});if(!_.start)actions.add(_,_.settings['direction'],slides.find(_,true),_.settings['transition']);if(slides.get(_,opt_start))_.start=opt_start;slides.display(_);size.autoResize(_);fx.fixTranslateZ(_,_.slidr);if(_.settings['keyboard'])nav.mouse.track(_.slidr);if(_.settings['touch'])nav.touch(_);_.started=true;controls.update(_);}},canSlide:function(_,next){return _.started&&next&&(slides.isdir(next)?!!slides.get(_,_.current,next):!!slides.get(_,next));},slide:function(_,next){if(actions.canSlide(_,next))slides.slide(_,next);},add:function(_,direction,ids,opt_transition,opt_overwrite){if(_.slidr){var trans=transition.validate(_,opt_transition);var valid=slides.find(_);var prev=(direction==='horizontal'||direction==='h')?'left':'up';var next=(direction==='horizontal'||direction==='h')?'right':'down';if(!slides.validate(_,ids,trans,valid,prev,next)&&!opt_overwrite){}else{slides.add(_,ids,trans,valid,prev,next);}}},auto:function(_,msec,direction){if(_.started&&slides.isdir(direction)){actions.stop(_);_.auto.msec=msec;_.auto.direction=direction;_.auto.id=setInterval(function(){if(!(_.settings['pause']&&nav.mouse.isOver(_.id)))slides.slide(_,direction);},msec);}},stop:function(_){if(_.started&&_.auto.id){clearInterval(_.auto.id);_.auto.id=null;}},breadcrumbs:function(_){if(_.breadcrumbs&&_.displayed){var type=css(_.breadcrumbs,'opacity')==='0'?'in':'out';fx.animate(_,null,'fade',type,null,_.breadcrumbs,'3','none');if(_.controls)classname(_.controls,type==='in'?'add':'rm','breadcrumbs');}},controls:function(_,opt_scheme){if(_.controls&&_.displayed){if(!controls.valid(opt_scheme))opt_scheme=null;var hidden=css(_.controls,'visibility')==='hidden';var type=(opt_scheme&&opt_scheme!=='none')?'in':'out';if(type==='out'&&hidden)return;if(opt_scheme==='border')classname(_.controls,'add','border');else if(opt_scheme==='corner')classname(_.controls,'rm','border');fx.animate(_,null,'fade',type,null,_.controls,'2','none');}}};var Slidr=function(id,el,settings){var _={id:id,slidr:el,breadcrumbs:null,controls:null,settings:settings,started:false,displayed:false,start:null,current:null,auto:{id:null,msec:5000,direction:'right'},slides:{},trans:{},crumbs:{},nav:{'up':null,'down':null,'left':null,'right':null}};var api={'start':function(opt_start){actions.start(_,opt_start);return this;},'canSlide':function(next){return actions.canSlide(_,next);},'slide':function(next){actions.slide(_,next);return this;},'add':function(direction,ids,opt_transition,opt_overwrite){actions.add(_,direction,ids,opt_transition,opt_overwrite);return this;},'auto':function(opt_msec,opt_direction,opt_start){actions.start(_,opt_start);actions.auto(_,opt_msec||_.auto.msec,opt_direction||_.auto.direction);return this;},'stop':function(){actions.stop(_);return this;},'timing':function(transition,opt_timing){if(!!transition&&transition.constructor===Object){_.settings['timing']=extend(_.settings['timing'],transition);}else if(typeof(transition)==='string'&&typeof(opt_timing)==='string'){_.settings['timing'][transition]=opt_timing;}
return this;},'breadcrumbs':function(){actions.breadcrumbs(_);return this;},'controls':function(opt_scheme){actions.controls(_,opt_scheme);return this;}};return api;};var TIMER=setInterval((function watch(){var _,cur,index,el,width,height;for(index in size.active){cur=size.active[index];_=cur.src;if(!browser.isIE()&&!contains(document,_.slidr)){delete size.active[index];delete INSTANCES[_.id];}else if(css(_.slidr,'visibility')==='hidden'){size.active[index].w=size.setWidth(_.slidr,0);size.active[index].h=size.setHeight(_.slidr,0);}else if(slides.get(_,_.current)){el=slides.get(_,_.current).el;width=size.getWidth(el);height=size.getHeight(el);if(cur.d.width&&cur.w!=width)size.active[index].w=size.setWidth(_.slidr,width);if(cur.d.height&&cur.h!=height)size.active[index].h=size.setHeight(_.slidr,height);}}
return watch;})(),250);var VERSION='0.5.0';var INSTANCES={};var NOOP=function(){};var DEFAULTS={'after':NOOP,'before':NOOP,'breadcrumbs':false,'controls':'border','direction':'horizontal','fade':true,'keyboard':false,'overflow':false,'pause':false,'theme':'#fff','timing':{},'touch':false,'transition':'linear'};var TIMING={'none':'none','fade':'0.4s ease-out','linear':'0.6s ease-out','cube':'1s cubic-bezier(0.15, 0.9, 0.25, 1)'};return{'version':function(){return VERSION;},'transitions':function(){return transition.available.slice(0);},'create':function(id,opt_settings){var el=document.getElementById(id);if(!el){return;}
var settings=extend(DEFAULTS,opt_settings||{});settings['timing']=extend(TIMING,settings['timing']);INSTANCES[id]=INSTANCES[id]||new Slidr(id,el,settings);return INSTANCES[id];}};}));
slidrInitialize=function(runSlidrAtLocation){startSlidr=function(){if(document.getElementById(runSlidrAtLocation)){slidr.create(runSlidrAtLocation,{breadcrumbs:true,direction:'horizontal'}).start();};};startSlidr();};
function submitSortForm(formExpr,selectBoxExpr,orderByParamName,directionParamName)
{var selectValue=$(selectBoxExpr).val();var selectValueArray=selectValue.split('_');if(selectValueArray.length==2)
{$(formExpr).append('<input type="hidden" name="'+orderByParamName+'" value="'+selectValueArray[0]+'" />');$(formExpr).append('<input type="hidden" name="'+directionParamName+'" value="'+selectValueArray[1]+'" />');}
$(formExpr).submit();}
function getSortUrl(selectBoxExpr,currentUrl,orderByParamName,directionParamName)
{var selectValue=$(selectBoxExpr).val();var selectValueArray=selectValue.split('_');if(selectValueArray.length==2)
{currentUrl+='&'+orderByParamName+'='+selectValueArray[0];currentUrl+='&'+directionParamName+'='+selectValueArray[1];}
return currentUrl;}
/*!
 * jScroll - jQuery Plugin for Infinite Scrolling / Auto-Paging - v2.2.4
 * http://jscroll.com/
 *
 * Copyright 2011-2013, Philip Klauzinski
 * http://klauzinski.com/
 * Dual licensed under the MIT and GPL Version 2 licenses.
 * http://jscroll.com/#license
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl-2.0.html
 *
 * @author Philip Klauzinski
 * @requires jQuery v1.4.3+
 */
(function($){$.jscroll={defaults:{debug:false,autoTrigger:true,autoTriggerUntil:false,loadingHtml:'<small>Loading...</small>',padding:0,nextSelector:'a:last',contentSelector:'',pagingSelector:'',callback:false,refresh:false}};var jScroll=function($e,options){var _data=$e.data('jscroll'),_userOptions=(typeof options==='function')?{callback:options}:options,_options=$.extend({},$.jscroll.defaults,_userOptions,_data||{}),_isWindow=($e.css('overflow-y')==='visible'),_$next=$e.find(_options.nextSelector).first(),_$window=$(window),_$body=$('body'),_$scroll=_isWindow?_$window:$e,_nextHref=$.trim(_$next.attr('href')+' '+_options.contentSelector);if(!_$next.attr('href'))
_nextHref='undefined';if(_nextHref!='undefined'){$e.data('jscroll',$.extend({},_data,{initialized:true,waiting:false,nextHref:_nextHref,refresh:_options.refresh}));_wrapInnerContent();_preloadImage();_setBindings();}else{_debug('warn','jScroll: nextSelector not found - destroying');_destroy();return false;}
function _preloadImage(){var src=$(_options.loadingHtml).filter('img').attr('src');if(src){var image=new Image();image.src=src;}}
function _wrapInnerContent(){if(!$e.find('.jscroll-inner').length){$e.contents().wrapAll('<div class="jscroll-inner" />');}}
function _nextWrap($next){if(_options.pagingSelector){var $parent=$next.closest(_options.pagingSelector).hide();}else{var $parent=$next.parent().not('.jscroll-inner,.jscroll-added').addClass('jscroll-next-parent').hide();if(!$parent.length){$next.wrap('<div class="jscroll-next-parent" />').parent().hide();}}}
function _destroy(){return _$scroll.unbind('.jscroll')
.removeData('jscroll')
.find('.jscroll-inner').children().unwrap()
.filter('.jscroll-added').children().unwrap();}
function _observe(){_wrapInnerContent();var $inner=$e.find('div.jscroll-inner').first(),data=$e.data('jscroll'),borderTopWidth=parseInt($e.css('borderTopWidth')),borderTopWidthInt=isNaN(borderTopWidth)?0:borderTopWidth,iContainerTop=parseInt($e.css('paddingTop'))+borderTopWidthInt,iTopHeight=_isWindow?_$scroll.scrollTop():$e.offset().top,innerTop=$inner.length?$inner.offset().top:0,iTotalHeight=Math.ceil(iTopHeight-innerTop+_$scroll.height()+iContainerTop);if(!data.waiting&&iTotalHeight+_options.padding>=$inner.outerHeight()){_debug('info','jScroll:',$inner.outerHeight()-iTotalHeight,'from bottom. Loading next request...');return _load();}}
function _checkNextHref(data){data=data||$e.data('jscroll');if(!data||!data.nextHref){_debug('warn','jScroll: nextSelector not found - destroying');_destroy();return false;}else{_setBindings();return true;}}
function _setBindings(){var $next=$e.find(_options.nextSelector).first();if(_options.autoTrigger&&(_options.autoTriggerUntil===false||_options.autoTriggerUntil>0)){_nextWrap($next);if(_$body.height()<=_$window.height()){_observe();}
_$scroll.unbind('.jscroll').bind('scroll.jscroll',function(){return _observe();});if(_options.autoTriggerUntil>0){_options.autoTriggerUntil--;}}else{_$scroll.unbind('.jscroll');$next.bind('click.jscroll',function(){_nextWrap($next);_load();return false;});}}
function _load(){var $inner=$e.find('div.jscroll-inner').first(),data=$e.data('jscroll');data.waiting=true;$inner.append('<div class="jscroll-added" />')
.children('.jscroll-added').last()
.html('<div class="jscroll-loading">'+_options.loadingHtml+'</div>');return $e.animate({scrollTop:$inner.outerHeight()},0,function(){$inner.find('div.jscroll-added').last().load(data.nextHref,function(r,status,xhr){if(status==='error'){return _destroy();}
var $next=$(this).find(_options.nextSelector).first();data.waiting=false;data.nextHref=$next.attr('href')?$.trim($next.attr('href')+' '+_options.contentSelector):false;$('.jscroll-next-parent',$e).remove();_checkNextHref();if(_options.callback){_options.callback.call(this);}
_debug('dir',data);});});}
function _debug(m){if(_options.debug&&typeof console==='object'&&(typeof m==='object'||typeof console[m]==='function')){if(typeof m==='object'){var args=[];for(var sMethod in m){if(typeof console[sMethod]==='function'){args=(m[sMethod].length)?m[sMethod]:[m[sMethod]];console[sMethod].apply(console,args);}else{console.log.apply(console,args);}}}else{console[m].apply(console,Array.prototype.slice.call(arguments,1));}}}
$.extend($e.jscroll,{destroy:_destroy});return $e;};$.fn.jscroll=function(m){return this.each(function(){var $this=$(this),data=$this.data('jscroll');if(data&&data.initialized&&data.refresh===false)return;var jscroll=new jScroll($this,m);});};})(jQuery);
function jScrollAdd(targetExpr,loadingHtml,nextSelector,contentSelector,debug,refresh)
{$(targetExpr).jscroll({debug:(debug?debug:false),loadingHtml:loadingHtml,nextSelector:nextSelector,contentSelector:contentSelector,refresh:(refresh?refresh:true)});}
function jqFilter(expr,selector)
{return $(expr).filter(selector);}
function jqSetProperty(expr,name,value)
{if((typeof name)=="string")
{return $(expr).prop(name,value);}}
popupHandlerPort=function(){jQuery.fn.centerPopup=function(){this.css("position","fixed");this.css("left",(($(window).width()-this.outerWidth())/2)+$(window).scrollLeft()+"px");return this;}
var $dialog=$(".ui-dialog");var dialogInnerPopup=function(){$(".ui-dialog-content.popup").removeClass("popup");}
dialogInnerPopup();$(window.document).ajaxComplete(function(){dialogInnerPopup();});var $popup=$(".popup:not(.ui-dialog, .ui-dialog-content, #privateQuestionPopup, #post-preview, .post-preview, .section[id='confirmation-popup'])");popupPosHandler=function(){var popupOffsetTop=175;var windowHeight=$(window).height();var yLocPopup=parseInt($popup.offset().top);var isAdComponent=$('#header .adComponent').length;resetPopup=function(){$popup.css('top',popupOffsetTop);}
if(isAdComponent>0){if(windowHeight>768||yLocPopup<280){popupOffsetTop=279;}else{popupOffsetTop=175;}
resetPopup();}else
if(isAdComponent<1){if(windowHeight>768||yLocPopup<280){popupOffsetTop=279;}
if(windowHeight<734){popupOffsetTop=175;}
resetPopup();}}
popupInit=function(){if($popup.length>0){if($('#header .adComponent').length>0){popupPosHandler();}
$popup.centerPopup();$(window).scroll(function(){popupPosHandler();});$(window).resize(function(){popupPosHandler();$popup.centerPopup();});}}
popupInit();}
bpBrickHeight=function(){bpBrickHeightReset=function(){$('form .plan-title').css('height','');$('form .plan-description').css('height','');$('form .plan-price').css('height','');$('form .plans li').css('height','');};bpTitleHeight=function(){var brickHeightSubject=$('form .plan-title');var brickHeightArray=$(brickHeightSubject).map(function(){return $(this).height();}).get();var maxHeight=Math.max.apply(Math,brickHeightArray);$(brickHeightSubject).height(maxHeight);};bpDescHeight=function(){var brickHeightSubject=$('form .plan-description');var brickHeightArray=$(brickHeightSubject).map(function(){return $(this).outerHeight();}).get();var maxHeight=Math.max.apply(Math,brickHeightArray);$(brickHeightSubject).height(maxHeight);};bpPriceHeight=function(){var brickHeightSubject=$('form .plan-price');var brickHeightArray=$(brickHeightSubject).map(function(){return $(this).height();}).get();var maxHeight=Math.max.apply(Math,brickHeightArray);$(brickHeightSubject).height(maxHeight);};bpPlanHeight=function(){var brickHeightSubject=$('form .plans li');var brickHeightArray=$(brickHeightSubject).map(function(){return $(this).height();}).get();var maxHeight=Math.max.apply(Math,brickHeightArray);$(brickHeightSubject).height(maxHeight);};bpPlanOverall=function(){bpTitleHeight();bpDescHeight();bpPriceHeight();bpPlanHeight();};bpBrickRun=function(){if($('.editProfile .offeringSubscription')[0]){}
else if($('.ui-dialog-content .offeringUpgrade')[0]){}
else if($('.memberOfferingChangeAdmin')[0]){bpBrickHeightReset();bpPlanOverall();}
else if($('.offeringSubscription')[0]){bpBrickHeightReset();bpPlanOverall();}
else if($('.lockedMemberOfferingSubscription')[0]){bpBrickHeightReset();bpPlanOverall();}
else if($('.businessAccountLeave')[0]){bpBrickHeightReset();bpPlanOverall();}
else if($('.offeringUpgrade')[0]){bpBrickHeightReset();bpPlanOverall();};};clickedPqTabs=function(){$('.productTab .tab').on('click',function(){bpBrickRun();});};bpBrickRun();clickedPqTabs();$(window.document).ajaxComplete(function(){bpBrickRun();clickedPqTabs();});$(window).resize(function(){bpBrickRun();clickedPqTabs();});};
bpPlanCount=function(){bpPlanCountDo=function(){var bpPlanLength=$('form .plans li').length;var bpPlanLengthClass='plan-count-'+bpPlanLength;$('form .plans').removeClass(bpPlanLengthClass);$('form .plans').addClass(bpPlanLengthClass);};bpPlanCountRun=function(){if($('.memberOfferingChangeAdmin')[0]){bpPlanCountDo();}
else if($('.offeringSubscription')[0]){bpPlanCountDo();}
else if($('.lockedMemberOfferingSubscription')[0]){bpPlanCountDo();}
else if($('.businessAccountLeave')[0]){bpPlanCountDo();}
else if($('.offeringUpgrade')[0]){bpPlanCountDo();};};bpPlanCountRun();$(window.document).ajaxComplete(function(){bpPlanCountRun();});};
$(document).ready(function(){$('#infoBanner').prependTo('#wrapper1');$('#infoBanner').removeClass('hidden');var topPage=$(window).scrollTop();var topHead=$('#header').offset().top;var topPostion=(topHead-topPage);$('.drawerWrapper').css('top',topPostion+60+'px');$('#infoBanner .close, .netSurvey .closeSection, .netSurvey .radio input, .netSurvey .buttons button').on('click',function(){var topPage=$(window).scrollTop();var topHead=$('#header').offset().top;var topPostion=(topHead-topPage);$('.drawerWrapper').css('top',topPostion+60+'px');});});
freeMemberPopupBottom=function(targetContainer){var fired=0;toggleFreeMemberPopupBottom=function(){if(($(window).scrollTop()>20)&&fired==0&&($("#free-member-popup .free-center").length>0)){$(targetContainer).show("slide",{direction:"down"},1000);fired=1;}};$(window).on('scroll',toggleFreeMemberPopupBottom);freeMemberPopupBottomCloseCreate=function(){if($(targetContainer).has('.closeFreeMember').length<1){$('<span class="closeFreeMember"></span>').appendTo(targetContainer);}};freeMemberButtonStart=function(){$(targetContainer).on('click','.closeFreeMember',function(){$(targetContainer).hide("slide",{direction:"down"},1000);});};freeMemberPopupBottomCloseCreate();freeMemberButtonStart();};
fileUploadLO=function(){$('div.attachments').each(function(){if($(this).children().size()<1){$('div.attachments').hide('fast');}});hideFileUploadInit=function(){$('fieldset.attachments, div.attachments').addClass('embedded-only');$('.uploaded-files ul, .file-meta ul, div.attachments, div.attachments ul').each(function(){if($(this).children().size()>0){$(this).removeClass('hidden');$(this).parents('.attachments').removeClass('hidden');}});$('.uploaded-files ul, .file-meta ul, div.attachments, div.attachments ul').each(function(){if($(this).children().size()<1){$(this).addClass('hidden');$(this).parents('.attachments').addClass('hidden');}});}
$(document).ready(function(){hideFileUploadInit();});};

