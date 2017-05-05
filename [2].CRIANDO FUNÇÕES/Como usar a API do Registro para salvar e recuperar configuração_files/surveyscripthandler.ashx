
(function(){
	// get callback configuration
	var callbackid = parseInt('0', 10) || 0;
	var callback = _ms_support_fms_surveyScriptHandlerCallback[callbackid];
	var config = callback.config;

	var version = '81';

	if (!window._ms_support_fms_loadedScriptLibraries)
	{
		window._ms_support_fms_loadedScriptLibraries = [];
	}
	function addScriptLibrary(header, async)
	{
		if (_ms_support_fms_loadedScriptLibraries[header])
		{
			return;
		}
		_ms_support_fms_loadedScriptLibraries[header] = true;
		var src = config.protocol + "//" + config.host + "/common/script/" + header + "?" + version;
		if (async)
		{
			var script = document.createElement("script");
			script.type = "text/javascript";
			script.src = src;

			(document.body || document.documentElement).appendChild(script);
		}
		else
		{
			document.write("<script type=\"text/javascript\" src=\"" + src + "\"></scr" + "ipt>");
		}
	}

	if (!window._ms_support_fms_loadedStyleSheets)
	{
		window._ms_support_fms_loadedStyleSheets = [];
	}
	function addStyleSheet(stylesheet, async)
	{
		if (_ms_support_fms_loadedStyleSheets[stylesheet])
		{
			return;
		}
		_ms_support_fms_loadedStyleSheets[stylesheet] = true;
		var href = config.protocol + "//" + config.host +"/common/css/" + stylesheet + "?" + version;
		if (document.createStyleSheet)
		{
			document.createStyleSheet(href);
		}
		else
		{
			if (async)
			{
				var link = document.createElement("link");
				link.rel = "stylesheet";
				link.type = "text/css";
				link.href = href;

				(document.getElementsByTagName("head")[0] || document.body || document.documentElement).appendChild(link);
			}
			else
			{
				document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"" + encodeURI(href) + "\" />");
			}
		}
	}

	// check reference by site/domain and load survey trigger entries by site name, region, content type, id, language and page visit history
	// Encoder is None, so this expression evalutor will produce JavaScript directly
	addStyleSheet("fx/surveytrigger.css", true);addScriptLibrary("fx/surveycookieutil.js", true);addScriptLibrary("fx/surveytrigger.js", true);function _ms_support_fms_OnLoad(){}function _ms_support_fms_OnUnload(){}function _ms_support_fms_Initialize(){var triggerEntity = {CookieDef:'ST_GN_PT-BR',Site:'GN',Region:'pt-br',IsRTL:false,Scid:"sw;pt-br;3626",Xsl:"",Path:"/common/survey.aspx",IdValue: '',EmbedSurveyPrompt: 'nothing',Expiration:90,Delay:0,Frequency:10,SurveyStyle:"popup",DisplayIntroPage:0,EmailStyle:1,EmailSurveyID:"0",ReferringURL:'http\x3a\x2f\x2fsupport.microsoft.com\x2fkb\x2f145679',Event:"onUnload",TriggerId:"15537",IntervalType:"session",Redirect:"",OptOut:0,AltStyle: '',RenderOption: '',InvitationWidth: 0,PageWidth: 0,PageHeight: 0,AnimationDuration:0.5,Parameters:[unescape(config.parameters[0]),unescape(config.parameters[1]),unescape(config.parameters[2]),unescape(config.parameters[3]),unescape(config.parameters[4]),unescape(config.parameters[5]),unescape(config.parameters[6]),unescape(config.parameters[7]),unescape(config.parameters[8]),unescape(config.parameters[9])],Theme:"",Toolbar:"",Contains:"sub-domain",Pages:[],TrackingText:'Obrigado por concordar em participar da pesquisa online da Microsoft.\u00a0Navegue pelo site support.microsoft.com como faria normalmente e depois retorne e responda as perguntas da pesquisa que aparecem nesta janela.\u00a0As perguntas aparecer\u00e3o ap\u00f3s voc\u00ea sair das p\u00e1ginas da Web sobre as quais a Microsoft deseja obter seu coment\u00e1rio.'};new MS.Support.Fms.SurveyTrigger(triggerEntity, typeof config != "undefined" ? config : null);}function _ms_support_fms_GetContent(){ return '';}function _ms_support_fms_GetCookies(){ return [];}

	var addEventHandler = window.attachEvent ? function (el, ev, fp){el.attachEvent("on" + ev, fp);} : function(el, ev, fp){el.addEventListener(ev, fp, false);};

	function OnFmsPluginTriggerRuntimeLoaded()
	{
		if (typeof (_ms_support_fms_Initialize) != "undefined")
		{
			_ms_support_fms_Initialize();
		}

		if (typeof(_ms_support_fms_OnLoad) != "undefined")
		{
			_ms_support_fms_OnLoad();
		}
	}

	if (typeof (_ms_support_fms_Initialize) != "undefined" || typeof(_ms_support_fms_OnLoad) != "undefined")
	{
		function isFmsPluginTriggerRuntimeLoaded()
		{
			return window.MS && MS.Support && MS.Support.Fms && MS.Support.Fms.SurveyTrigger && MS.Support.Fms.CookieUtil;
		}

		if (isFmsPluginTriggerRuntimeLoaded())
		{
			OnFmsPluginTriggerRuntimeLoaded();
		}
		else
		{
			var intervalHandler = 0;
			intervalHandler = window.setInterval(function (){if (isFmsPluginTriggerRuntimeLoaded()) {OnFmsPluginTriggerRuntimeLoaded();window.clearInterval(intervalHandler);}}, 20);
		}
	}

	if (_ms_support_fms_OnUnload)
	{
		addEventHandler(window, "unload", _ms_support_fms_OnUnload);
	}

	if (_ms_support_fms_GetCookies)
	{
		var cookies = _ms_support_fms_GetCookies();
		
		for (var i = 0; i < cookies.length; ++i)
		{
			var cookie = cookies[i];
			if (cookie)
			{
				_ms_support_fms_utility_setCookie(cookie[0], cookie[1], config.site.cookieDomain);
			}
		}
	}
})();

