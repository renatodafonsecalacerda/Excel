/*
# ------------------------------------------------------------------------
# JA Google Translate plugin for Joomla 1.6.x
# ------------------------------------------------------------------------
# Copyright (C) 2004-2009 J.O.O.M Solutions Co., Ltd. All Rights Reserved.
# @license - Copyrighted Commercial Software
# Author: J.O.O.M Solutions Co., Ltd
# Websites:  http://www.joomlart.com -  http://www.joomlancers.com
# This file may not be redistributed in whole or significant part.
# ------------------------------------------------------------------------
*/
google.load("language", "1");


/**
 * Extend from method evalScripts of Mootools
 */
function JAEvalScripts (text) {
	var script, scripts;
	
	scripts = [];
	var regexp = /<script[^>]*>([\s\S]*?)<\/script>/gi;
	while ((script = regexp.exec(text))) 
		scripts.push(script[1]);
	
	scripts = scripts.join('\n');
	//prompt('test', scripts);
	if (scripts) (window.execScript) ? window.execScript(scripts) : window.setTimeout(scripts, 0);
}

window.addEvent('domready', function() {
    $('ja-translate-popup').addEvent('mouseleave', function() {
    	var curId = this.getProperty('rel');
    	this.setStyle('display', 'none');
		this.setProperty('rel', '');
    	oJaTranslate.savePopupContent(curId);
    });
});
/**
 * JAGoogleTranslate
 * Refer: http://code.google.com/apis/ajaxlanguage/documentation/reference.html
 */
JAGoogleTranslate = new Class({
	initialize: function (pageLanguage, autoDetect) {
		this.autoDetect = autoDetect;
		this.pageLanguage = pageLanguage;
		this.lang = pageLanguage;
		//google character limit
		this.limitChar = 1000;
		 
		this.dContent = 'ja-translate-content-';
		this.dBackup = 'ja-translate-backup-';
		this.dBackupJs = 'ja-translate-js-';
		this.dLoading = 'ja-translate-loading-';
		this.dLanguages = 'ja-translate-languages-';
		this.openLang = true;
	},
	
	translateTitle: function(Id) {
		var contentId = this.dContent + Id;
		var backupTitle = 'ja-backup-title-' + Id;
		
		//
		var newTitle = $(contentId).getElements('span.ja-translate-title')[0].innerHTML;
		var oldTitle = $(backupTitle).innerHTML;
		
		var aTitles = $$('.contentheading a');
		
		if(aTitles.length < 1) {
			aTitles = $$('.contentheading');
		}
		if(aTitles.length > 0) {
			//aTitles[Id].setHTML(title);
			for(var i=0; i< aTitles.length; i++) {
				if(aTitles[i].innerHTML.trim() == oldTitle.trim()) {
					aTitles[i].innerHTML = newTitle;
					$(backupTitle).innerHTML = newTitle;
				}
			}
		}
	},
	
	translate: function(Id, toLang) {
		this.toggleLanguages(Id);
		if(!google) {
			alert('Could not load data from google!.');
			return false;
		}
		
		this.showLoading(Id);
		
		var contentId = this.dContent + Id;
		var loadingId = this.dLoading + Id;
		var backupId = this.dBackup + Id;
		var backupJsId = this.dBackupJs + Id;
		var backupTitle = 'ja-backup-title-' + Id;
		
		var content = this.getContent(Id);
		if(this.lang == toLang) {
			content = content.replace(/_jabak/gi, '');
			$(contentId).set('html','');
			$(contentId).adopt(new Element('div').set('html', content));
			
			JAEvalScripts($(backupJsId).innerHTML);
							
			//update title
			this.translateTitle(Id);
			//hide loading			
			this.hideLoading(Id);
			
		} else {
			var len = content.length;
			
			var count = 0;//count part of content after split to translate
			var start = 0;
			var end;
			var limit;
			var request = '';
			var aResponse = new Array();
			var sResponse = '';
			
			while(start < len) {
				
				end = this.getSafePos(content, start, this.limitChar);
				
				if(end > len) {
					end = len;
				}
				limit = end - start;
				request = content.substr(start, limit);
				
				//if can not translate this segment => display original content
				aResponse[count] = request;
				
				//important: markup number for segment
				request = count + '___' + request + ' ';
				
				google.language.translate(request, this.lang, toLang, function(result) {
					
					if (result.translation) {
						var trans = result.translation;
						var aRep = trans.split('___', 2);
						var no = aRep[0];
						no = no.toInt();
						
						var sCut = aRep[0] + '___';
						aResponse[no] = trans.substr(sCut.length, trans.length - sCut.length);
						
						
						
						if(trans.match(/end_of_jatranslate/i)) {
							
							sResponse = aResponse.join('');
							
							sResponse = sResponse.replace(/_jabak/gi, '');
							$(contentId).set('html', '');
							
							$(contentId).adopt(new Element('div').set('html', sResponse));
							//prompt('sResponse', sResponse);
							
							JAEvalScripts($(backupJsId).innerHTML);
							
							//update title
							var oTrans = new JAGoogleTranslate('en', 1);
							oTrans.translateTitle(Id);
							//hide loading
							$(loadingId).setStyles({'display': 'none'});
							
						}
					}
				});
				start = end;
				count++;
			}
		}
		
		return false;
	},
	
	/**
	 * Get safe position to cut content that don't make break tags and sentence
	 */
	getSafePos: function(content, begin, limit) {
		var end = begin + limit;
		var len = content.length;
		
		if(len > end) {
			//find lastest open tags
			var lastestOpen = content.lastIndexOf('<', end);
			var lastestClose = content.lastIndexOf('>', end);
			
			//fix break tag
			if((lastestOpen > -1) && (lastestClose < lastestOpen)) {
				end = lastestOpen;
			}
			//fix break sentence
			var lastPoint = content.lastIndexOf('.', end);
			if((lastPoint > -1) && (lastestClose < lastPoint)) {
				end = lastPoint;
			}
		} else {
			end = len;
		}
		
		return end;
	},
	
	getContent: function(Id) {
		var backupId = this.dBackup + Id;
		
		this.lang = this.pageLanguage;
		if(this.autoDetect) {
			var lang = $(backupId).getProperty('lang');
			if(lang != '' && lang != null) {
				this.lang = lang;
			}
		}
		//always translate from original content
		return $(backupId).innerHTML;
	},
	
	saveOriginalContent: function(Id) {
		var backupId = this.dBackup + Id;
		var backupJsId = this.dBackupJs + Id;
		
		var content = $(this.dContent + Id).innerHTML;
		//extract and save scripts
		$(backupJsId).innerHTML = 'Fix IE Bug. Dont remove this line.';
		content = content.replace(/<script[^>]*>([\s\S]*?)<\/script>/gi, function(s) {
						$(backupJsId).innerHTML = $(backupJsId).innerHTML + s; 
						return '';
					});
		
		//remove break line
		//content = content.replace(/(\n|\r|\t)/gi, '');
		//remove html comment block
		content = content.replace(/<!--([\s\S]*?)-->/gi, '');
		//change id to resolve conflict
		content = content.replace(/id\s*=\s*"([^"]*?)"/gi, 'id="$1_jabak"');
		content = content.replace(/id\s*=\s*'([^']*?)'/gi, "id='$1_jabak'");
		content = content + '<!--end_of_jatranslate-->';
		
		$(backupId).innerHTML = $(backupId).innerHTML + content;
		
		this.detectLanguage(Id);
	},
	
	detectLanguage: function(Id) {
		var backupId = this.dBackup + Id;
		var langPrefix = 'ja-lang-' + Id;
		var content = $(backupId).innerHTML;
		var len = content.length;
		var start = 0;
		
		var end = this.getSafePos(content, start, 500);
		if(end > len) {
			end = len;
		}
		limit = end - start;
		var text = content.substr(start, limit);
		
		google.language.detect(text, function(result) {
			if (!result.error) {
				var langCode = result.language;
				$(backupId).setProperty('lang', langCode);
				
				if($(langPrefix + '-' +langCode)) {
					//markup on languages list
					$(langPrefix + '-' +langCode).addClass('original');
				}
			}
		});
	},
	
	showLoading: function(Id) {
		$(this.dLoading + Id).setStyles({'display': 'block'});
	},
	
	hideLoading: function(Id) {
		$(this.dLoading + Id).setStyles({'display': 'none'});
	},
	
	toggleLanguages: function(Id) {
		var popupId = 'ja-translate-popup';
		var display = $(popupId).getStyle('display');
		var curId = $(popupId).getProperty('rel');
		
		//save content of other block
		if(curId != '' && curId != null && curId != Id && display == 'block') {
			this.savePopupContent(curId);
			display = 'none';
		}
		
		if(display == 'none') {
			var aParam = $('ja-translate-' + Id).getCoordinates();
			
			var styles = {'display': 'block', 'top': aParam.top + 20, 'left': aParam.left};
		
			$(popupId).setStyles(styles);
			$(popupId).setProperty('rel', Id)
			var aContent = $$('#ja-translate-languages-' + Id + ' div.languages');
			aContent[0].inject(popupId);
		} else {
			$(popupId).setStyle('display', 'none');
			$(popupId).setProperty('rel', '');
			this.savePopupContent(Id);
		}
		
		return false;
	},
	
	savePopupContent: function(Id) {
		var popupId = 'ja-translate-popup';
		var aContent = $$('#' + popupId + ' div.languages');
		if(aContent.length > 0) {
			for(var i=0; i< aContent.length; i++) {
				aContent[i].inject('ja-translate-languages-' + Id);
			}
		}
	}
});