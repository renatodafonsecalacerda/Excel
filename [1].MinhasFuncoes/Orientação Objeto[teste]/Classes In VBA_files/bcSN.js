if(!window._rfiPagePre){window._rfiPagePre="ppre";window._rfiAServer="a.rfihub.com";}
var rfiPageIdMacro="__rfiPgid";var rfiPublisherToClickUrl="__rfiPtc";var rfiPixelServer="p.rfihub.com";var adInstanceId="";var bidderUrl=window._rfiAServer;var attachIframe=false;var adReq=null;var adIframeObj=null;var adHtmlText=null;var rfiAdIframeName="";var rfiScriptId="__rfi_script_";if(!window.rfiAdServeFromBidder)
{function rfiAddListener(obj,type,handler){if(obj.addEventListener){obj.addEventListener(type,handler,false);}else if(obj.attachEvent){obj.attachEvent('on'+type,handler);}else{rfiFireAdb(rfiEscape("Not able to register "+type+"handlers"),10,301);}}
function rfiRemoveListener(obj,type,handler){if(obj.removeEventListener){obj.removeEventListener(type,handler,false);}else if(obj.detachEvent){obj.detachEvent('on'+type,handler);}else{rfiFireAdb(rfiEscape("Not able to deregister "+type+"handlers"),10,301);}}
function rfiIsIE(){return new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})").exec(navigator.userAgent)!=null;}
function rfiOnLoad(){try{attachIframe&&rfiAddIframe(adIframeObj,false)&&rfiPaintIframe(adIframeObj,adHtmlText);}catch(err){rfiFireAdb(rfiEscape("attachIfame failed. "+err.message),10,201);}finally{attachIframe=false;adHtmlText=adIframeObj=null;}}
function rfiFindFlashVersion()
{try
{var i,n=navigator,pins=n.plugins;var val="";if(pins&&pins.length)
{for(i=0;i<pins.length;i++)
if(pins[i].name.indexOf('Shockwave Flash')!=-1)
{val=pins[i].description.split('Shockwave Flash ')[1].split(" ")[0];break;}}
else
{var suff=new Array(".7","");for(i=0;i<suff.length;i++)
{try
{var movie=new ActiveXObject("ShockwaveFlash.ShockwaveFlash"+suff[i]);var arr=movie.GetVariable("$version").split(" ")[1].split(",");val=arr[0]+"."+arr[1];break;}
catch(e)
{}}}
return val;}
catch(e)
{return"";}}
function rfiDef(o)
{return o!==null&&o!==undefined;}
function rfiEscape(s)
{return s===null||s===undefined?"":encodeURIComponent?encodeURIComponent(s):escape(s);}
function rfiParamValue(val,defaultVal)
{return typeof val==='undefined'||val===null?defaultVal:val;}
function rfiIsSecureRequest()
{return adReq==null||typeof adReq.isSecureBidRequest==='undefined'?false:adReq.isSecureBidRequest===true||adReq.isSecureBidRequest==="true";}
function rfiIsSecure()
{var p=document.location.protocol;return rfiIsSecureRequest()||(p&&p==="https:");}
function rfiURLPrefix()
{return rfiIsSecure()?"https://":"http://";}
function rfiUpdateAdParams(adStr,adParams,bm)
{var adStrUpdated=adStr;var isSec=!!adParams.isSec;var clickRedirect=rfiEscape(adReq.clickRedirect)==="true";var clickPrefix=clickRedirect?adReq.clickPrefix:"";var regex=new RegExp(rfiPageIdMacro,"g");adStrUpdated=adStrUpdated.replace(regex,rfiEscape(window._rfiPageID));if(!!bm.rmm){adStrUpdated=adStrUpdated.replace(/__rfiElp/g,rfiParamValue(adParams.elp,""));}
if(!!bm.ptc){regex=new RegExp(rfiPublisherToClickUrl,"g");adStrUpdated=adStrUpdated.replace(regex,bm.eptc?rfiEscape(clickPrefix):clickPrefix);}
if(rfiIsSecure()&&isSec){regex=new RegExp("http://","g");adStrUpdated=adStrUpdated.replace(regex,"https://");}
return adStrUpdated;}
function rfiConstructAd(ad,backupAd,adExtras,adParams,bm,impUrl)
{try{var noAdc=!!adParams.noAdc;var isEx=!!adParams.isEx;var isPre=!!adParams.isPre||rfiIsIE();var isFl=!!adParams.isFl;var adHtmlWithTags="";var addHeaders=!isEx;var isA=adReq.placement==="audit";if(isA){isFl&&rfiFindFlashVersion().length<=0&&(adParams.aelp=decodeURIComponent(adParams.aelp));ad=rfiSetDef(ad,adParams);backupAd=rfiSetDef(backupAd,adParams);adExtras=rfiSetDef(adExtras,adParams);adInstanceId="0";}
adHtmlWithTags+=(addHeaders&&isPre)?"<!DOCTYPE html PUBLIC \"\">":"";adHtmlWithTags+=addHeaders?"<html>":"";adHtmlWithTags+=(addHeaders&&isPre)?"<head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\"/></head>":"";adHtmlWithTags+=addHeaders?"<body>":"";adHtmlWithTags+=noAdc?"<span id=\"__rfi\" style=\"height:0px; width:0px\">":"<div style=\"position:relative;margin:0;marginLeft:0;marginRight:0;marginTop:0;marginBottom:0;padding:0;paddingLeft:0;paddingRight:0;paddingTop:0;paddingBottom:0"+"; width:"+
adReq.width+"px; height:"+
adReq.height+"px; float:none\">"+"<span id=\"__rfi"+
adInstanceId+"\" style=\"height:"+
adReq.height+"px; width:"+
adReq.width+"px; display:block\">";if(isFl&&rfiFindFlashVersion().length<=0){adHtmlWithTags+=rfiDebugAdStr(3);adHtmlWithTags+=backupAd;adHtmlWithTags+=rfiDebugAdStr(4);}else{bm.eptc=isFl;adHtmlWithTags+=rfiDebugAdStr(1);adHtmlWithTags+=ad;adHtmlWithTags+=rfiDebugAdStr(2);}
adHtmlWithTags+=noAdc?"</span>":"</span></div>";adHtmlWithTags+=rfiDebugAdStr(5);adHtmlWithTags+=adExtras;adHtmlWithTags+=isA?"":"<scr"+"ipt type=\"text/javascript\""+"src=\""+impUrl+"\""+">\x3c/script>";adHtmlWithTags+=rfiDebugAdStr(6);adHtmlWithTags+=addHeaders?"</body></html>":"";return rfiUpdateAdParams(adHtmlWithTags,adParams,bm);}catch(err){rfiFireAdb(rfiEscape("rfiConstructAd "+err.message),10,201);return"";}}
function rfiSetDef(k,v)
{k=k.replace(/\${tacticId}/g,0);k=k.replace(/\${rfiTvid}/g,0);k=k.replace(/\${rfiCid}/g,0);k=k.replace(/\${rfiCvid}/g,0);k=k.replace(/\${rfiLid}/g,0);k=k.replace(/\${rfiLvid}/g,0);k=k.replace(/\${rfiFid}/g,0);k=k.replace(/\${rfiFvid}/g,0);k=k.replace(/\${rfiPid}/g,"audit");k=k.replace(/\${rfiAid}/g,0);k=k.replace(/\${rfiElp}/g,rfiParamValue(v.aelp,""));k=k.replace(/__rfiElp/g,rfiParamValue(v.aelp,""));k=k.replace(/\${rfi_dc_dynamiccreativeids}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativelabels}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativelandingurls}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativeprices}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativeimageurls}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativeimagehash}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativecategorylabels}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativecategorylandingurls}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativeidspsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativelabelspsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativedescriptionspsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativelandingurlspsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativepricespsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativeimageurlspsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativeimagehashpsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativecategorylabelspsv}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativecategorylandingurlspsv}/g,"[]");k=k.replace(/\${rfi_dc_dc_additional_params}/g,"[]");k=k.replace(/\${rfi_dc_dynamiccreativeparams}/g,"");return k;}
function rfiCreateAdIframe()
{var adIframe;try{adIframe=document.createElement('iframe');adIframe.width=adReq.width+"px";adIframe.height=adReq.height+"px";adIframe.frameBorder=0;adIframe.vspace=0;adIframe.hspace=0;adIframe.scrolling='no';adIframe.marginHeight=0;adIframe.marginWidth=0;adIframe.style.padding=0;adIframe.style.margin=0;adIframe.src='about:blank';adIframe.name=adIframe.id=rfiAdIframeName="rfi_"+adInstanceId+Math.random();var onload=function(){var info={};var infoStr="";var doc;try{doc=adIframe.contentWindow?adIframe.contentWindow.document:adIframe.contentDocument;}catch(err){rfiFireAdb(rfiEscape("doc access failed. "+err.message),13,201);return;}
var text="";try{text=doc.body.innerHTML;}catch(err){rfiFireAdb(rfiEscape("innerHTML access failed. "+err.message),13,201);}
info['htmlLen']=text.length;infoStr="{\"htmlLen\":"+info['htmlLen']+"}";rfiFireAdb(rfiEscape(infoStr),13,50);try{var w=adIframe.contentWindow;info['domain']=doc.domain;info['WinDocRef']=w.document.referrer;info['DocRef']=doc.referrer;info['WinParentLocHref']=w.parent.location.href;info['WinLocHref']=w.location.href;info['WinLocStr']=w.location.toString();info['WinParentLocStr']=w.parent.location.toString();}catch(err){}
infoStr=typeof JSON!=='object'||typeof JSON.stringify!=='function'?"{\"htmlLen\":"+info['htmlLen']+"}":JSON.stringify(info);rfiFireAdb(rfiEscape(infoStr),13,1);try{var dv=text.indexOf("callback=__dvredirect_callback");dv!=-1&&text.substr(dv,text.length).indexOf("http://a.rfihub.com/sej")!=-1&&rfiFireAdb(rfiEscape("doubleverify showing default ad"),13,201);}catch(err){rfiFireAdb(rfiEscape("innerHTML parse failed. "+err.message),13,201);}};var onerror=function(error){rfiFireAdb(rfiEscape("iframe load error. "+error.message),14,201);};rfiAddListener(adIframe,'load',onload);rfiAddListener(adIframe,'error',onerror);}catch(err){rfiFireAdb(rfiEscape("iframe create error "+err.message),10,201);adIframe=null;}finally{return adIframe;}}
function rfiAddIframe(adIframe,isFirstAttempt)
{var inHead=false;var s=null;try{s=document.getElementById(rfiScriptId+adInstanceId);inHead=s.parentNode.tagName.toLowerCase()==="head";}catch(err){inHead=true;}
try{if(!inHead){s.parentNode.insertBefore(adIframe,s);return!0;}}catch(err){rfiFireAdb(rfiEscape("add iframe before script node failed. error "+err.message+" adding to body"),14,101);}
try{if(!!document.body||!isFirstAttempt){document.body.appendChild(adIframe);return!0;}else{adIframeObj=adIframe;attachIframe=true;}}catch(err){rfiFireAdb(rfiEscape("add iframe to DOM failed. error "+err.message),14,201);}
return!1;}
function rfiPaintIframe(adIframe,adHtml)
{rfiIsIE()?rfiPaintIframeForIE(adIframe,adHtml):rfiPaintIframeForNonIE(adIframe,adHtml);}
function rfiPaintIframeForIEByLocationReplace(adIframe,adHtml)
{try{var fr=window.frames[adIframe.name];fr.rfiAdContents=adHtml;fr.location.replace("javascript:window.rfiAdContents");}catch(err){rfiFireAdb(rfiEscape("iframe load error for IE (location replace). "+err.message),14,101);return!1;}
return!0;}
function rfiPaintIframeForIE(adIframe,adHtml)
{var doc;try{doc=!!(adIframe.contentWindow?adIframe.contentWindow.document:adIframe.contentDocument);}catch(err){rfiFireAdb(rfiEscape("iframe doc access error for IE. "+err.message),14,101);doc=!1;}
if(!doc||!rfiPaintIframeForIEByLocationReplace(adIframe,adHtml)){var label;rfiFireAdb(rfiEscape("iframe load failed for IE. doc is not defined. attempting URI"),14,101);try{label="rfiAdContent"+adInstanceId;window[label]=adHtml;ad='var rfiAdContent = window.parent["'+label+'"];window.parent["'+label+'"] = null;document.write(rfiAdContent);';ad='document.domain = "'+document.domain+'";'+ad+'document.close();';adIframe.src='javascript:\'<script type="text/javascript">'+ad+"\x3c/script>'";}catch(err){window[label]=null;rfiFireAdb(rfiEscape("iframe load error for IE (javascript URI). "+err.message),14,201);}}}
function rfiIfrPaint(i,h)
{var d=i.contentWindow?i.contentWindow.document:i.contentDocument;d.open("text/html","replace");d.write(h);d.close();}
function rfiPaintIframeForNonIE(adIframe,adHtml)
{try{rfiIfrPaint(adIframe,adHtml);}catch(err){rfiFireAdb(rfiEscape("iframe load error for non-IE. setting doc.domain and reattempting. "+err.message),14,101);adIframe.src="javascript:var d=document.open();d.domain='"+document.domain+"';void(0);";try{rfiIfrPaint(adIframe,adHtml);}catch(err2){rfiFireAdb(rfiEscape("iframe load error for non-IE. "+err2.message),14,201);}}}
function rfiShowAdInIframe(ad,backupAd,adExtras,adParams,bm,impUrl)
{adHtmlText=rfiConstructAd(ad,backupAd,adExtras,adParams,bm,impUrl);rfiFireAdb(rfiEscape("adHtml:"+adHtmlText),10,1);var adIframe=rfiCreateAdIframe();!!adIframe&&rfiAddIframe(adIframe,true)&&rfiPaintIframe(adIframe,adHtmlText);}
function rfiShowAd(ad,backupAd,adExtras,adParams,bm,impUrl)
{var adHtml=rfiConstructAd(ad,backupAd,adExtras,adParams,bm,impUrl);document.writeln(adHtml);}
function rfiOverridePageUrl(p,url,siteVal)
{return p.publisher===345&&url.indexOf("custom_macro")!=-1&&siteVal!==""&&siteVal.indexOf("REFERRAL_URL_ENC")==-1;}
function rfiImpressionCall(url)
{try{rfiFireAdb("",15,0);document.writeln("<scr"+"ipt type=\"text/javascript\""+"src=\""+url+"\""+">\x3c/script>");}catch(err){rfiFireAdb(rfiEscape(err.message),16,201);}}
function rfiAdServeFromBidder(p,adRequestData,ad,backupAd,adExtras,adParams,bm)
{var i,a;var fEsc=rfiEscape;if(!p||!p.publisher)
{return;}
if(!window._rfiPagePre)
{return;}
if(!window._rfiPageID)
{window._rfiPageID=window._rfiPagePre+(new Date().getTime()%1000000000)+Math.floor(Math.random()*10000);}
var url=location&&location.href?location.href:"";var aStr="";var numAds=0;var flash=rfiFindFlashVersion();var ref=document&&document.referrer?document.referrer:"";var overridePageUrl=false;var clientTime=new Date().getTime();var rStr=(clientTime%1000000000)+""+Math.random();var suffix="&ra="+rStr+"&rb="+fEsc(p.publisher)+"&ca="+fEsc(p.conversionID)+"&rc="+fEsc(flash)+"&ua="+fEsc(p.userID)+"&ub="+fEsc(p.ageRange)+"&uc="+fEsc(p.gender)+"&ud="+fEsc(adRequestData?adRequestData.userTags:null)+"&ue="+fEsc(p.userTagsFromUser)+"&pa="+fEsc(window._rfiPageID)+"&pb="+fEsc(p.pageCategory)+"&pc="+fEsc(adRequestData?adRequestData.pageTags:null)+"&pd="+fEsc(p.pageTagsFromUser)+"&pg="+fEsc(p.clientSideAdContext)+"&ct="+clientTime+"&di="+fEsc(adRequestData?adRequestData.deviceId:null)+"&app="+fEsc(adRequestData?adRequestData.isApp:null)+"";var dd=document;if(adRequestData)
{if(typeof adRequestData.placement=="string"&&(adRequestData.placement.indexOf("placementId")>=0||adRequestData.placement.replace(" ","").length==0)){adRequestData.placement="audit";}
if(adRequestData.width>0&&adRequestData.height>0&&adRequestData.width<=1000&&adRequestData.height<=1000&&(adRequestData.placement==="audit"||adRequestData.placement>0))
{var newWinStr=adRequestData.landInNewWindow?"&newWin=1":"";var placementStr="&re="+fEsc(adRequestData.placement+"");var deviceIdStr="&di="+fEsc(adRequestData.deviceId+"");var appStr="&app="+fEsc(adRequestData.isApp+"");var siteIDStr=adRequestData.externalSiteID===null||adRequestData.externalSiteID===undefined?"":("&ug="+fEsc(adRequestData.externalSiteID));var isPreviewStr="&pv="+(adRequestData.isPreview?adRequestData.isPreview:"0");var firePixels="&px="+(rfiParamValue(adRequestData.firePixels,false)?"1":"0");var bidData=(adRequestData.bidData===null||adRequestData.bidData===undefined)?"":adRequestData.bidData;var bidDataArray=bidData.split(";");var bidDataStr="";var publisherStr="&rb="+fEsc(p.publisher);var beaconBidder=null;var scoreMicroClicks;var bidTimeStamp;var isSej=null;var priceStr="";var siteUrl="";if(bidDataArray.length===7){var j=0;var paramAndValue;for(j=0;j<6;j++){paramAndValue=bidDataArray[j].split("=");if(paramAndValue.length===2){if(paramAndValue[0]==="creativeOptimization"){bidDataStr+="&co=";paramPairs=paramAndValue[1].split(",");var k=0;var pairNameAndValue;for(k=0;k<paramPairs.length;k++){pairNameAndValue=paramPairs[k].split(":");if(pairNameAndValue.length===2){if(pairNameAndValue[0]==="url")
bidderUrl=pairNameAndValue[1];else if(pairNameAndValue[0]==="bB")
beaconBidder=pairNameAndValue[1];else if(pairNameAndValue[0]==="bt")
bidTimeStamp=pairNameAndValue[1];else if(pairNameAndValue[0]==="sej")
isSej=pairNameAndValue[1];}}}
else if(paramAndValue[0]==="price"){bidDataStr+="&ep=";priceStr="&ep="+fEsc(paramAndValue[1]);}else if(paramAndValue[0]==="requestId"){bidDataStr+="&ri=";adInstanceId=paramAndValue[1]==""?""+Math.random():paramAndValue[1];}else if(paramAndValue[0]==="site"){siteUrl=fEsc(paramAndValue[1]);overridePageUrl=rfiOverridePageUrl(p,url,siteUrl);continue;}else if(paramAndValue[0]==="adId")
bidDataStr+="&ai=";else if(paramAndValue[0]==="tacticId")
bidDataStr+="&rt=";else
continue;bidDataStr+=fEsc(paramAndValue[1]);}}}
rfiAdb("",17,50,"",bidderUrl);rfiAdb("",18,50,"",window._rfiAServer);var bidderUrlRfiHubNet=bidderUrl.replace("rfihub.com","rfihub.net");if(adRequestData.placement!=="audit"&&beaconBidder==="true"){rfiAdb("",12,0,priceStr+publisherStr,bidderUrl);var img=new Image(1,1);img.src=rfiURLPrefix()+bidderUrlRfiHubNet+"/bn/bk.gif?bt="+bidTimeStamp+bidDataStr+placementStr+publisherStr+deviceIdStr+appStr+"&ver=3";}
rfiFireAdb("",9,0);var isInIframe=window.self!=window.top;var truncatables="&pe="+(overridePageUrl?"rs":fEsc(url))+"&pf="+fEsc(ref);var impUrl="";if(adRequestData.placement!=="audit"&&beaconBidder==="true"){var isBtoaNotSupported=typeof btoa!='function'?"true":"false";var ish="";try{ish="&ish="+(document.getElementById(rfiScriptId+adInstanceId).parentNode.tagName.toLowerCase()==="head"?"1":"0");}catch(err){ish="";}
impUrl=rfiURLPrefix(adRequestData)+window._rfiAServer+"/bn/imp.js?bt="+bidTimeStamp+"&aeh=1"+"&w="+adRequestData.width+"&h="
+adRequestData.height+bidDataStr+newWinStr+firePixels+placementStr+siteIDStr+isPreviewStr+suffix
+"&rs="+siteUrl+truncatables+"&ns="+isBtoaNotSupported+"&if="+(isInIframe?"1":"0")+ish+"&ver=8";impUrl=impUrl.length>=4096?impUrl.substr(0,4095):impUrl;}
if(isSej==="true"){rfiShowAd(ad,backupAd,adExtras,adParams,bm,impUrl);}else{rfiShowAdInIframe(ad,backupAd,adExtras,adParams,bm,impUrl);}
rfiFireAdb("",11,0);}}}
function rfiAdb(msg,pos,lev,p,url)
{var fire=lev>=201||lev>=parseInt(adReq.dl);if(fire){var img=new Image(1,1);var t=new Date().getTime();var ra=(t%1000000000)+""+Math.random();img.src=rfiURLPrefix(adReq)+url+"/adb.gif?"+"ms="+msg+"&po="+pos+"&lev="+lev+"&ri="+adInstanceId+p+"&ra="+ra;}}
function rfiFireAdb(msg,pos,lev)
{rfiAdb(msg,pos,lev,"",bidderUrl);}
function rfiDebugAdStr(pos)
{var currentTime=new Date().getTime();var rStr=(currentTime%1000000000)+""+Math.random();return 0>=parseInt(adReq.dl)?"<img style='display:none' border=0 width=0 height=0 src='"+
rfiURLPrefix(adReq)+bidderUrl+"/adb.gif?ri="+
adInstanceId+"&po="+pos+"&ra="+rStr+"'>":"";}}
try{if(typeof rfiPub==='undefined'||typeof rfiAdReq==='undefined'||typeof rfiAd==='undefined'||typeof rfiBackupAd==='undefined'||typeof rfiAdExtras==='undefined'||typeof rfiAdParams==='undefined'||typeof rfiMBM==='undefined'){rfiAdb("missing param",0,301,"",window._rfiAServer);}else{adReq=rfiAdReq;rfiAddListener(window,'load',rfiOnLoad);rfiAdServeFromBidder(rfiPub,rfiAdReq,rfiAd,rfiBackupAd,rfiAdExtras,rfiAdParams,rfiMBM);}}catch(err){try{rfiFireAdb(rfiEscape(err.message),0,201);}catch(err){}}