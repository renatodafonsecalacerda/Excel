if (!window.MS) {
    window.MS = {};
}

if (!MS.Support) {
    MS.Support = {};
}

if (!MS.Support.Fms) {
    MS.Support.Fms = {};
}

if (!MS.Support.Fms.CrossDomain) {
    MS.Support.Fms.CrossDomain = function () {
        var fmsDomain = document.domain.toLowerCase();
        var anchorClicked = false;
        var blessedDomains = [];

        window.crossDomainInitialized = 1;

        function getCookie(key) {
            var value = document.cookie;
            var start = value.indexOf(" " + key + "=");
            if (start == -1) {
                start = value.indexOf(key + "=");
            }
            if (start == -1) {
                value = null;
            }
            else {
                start = value.indexOf("=", start) + 1;
                var end = value.indexOf(";", start);
                if (end == -1) {
                    end = value.length;
                }
                value = unescape(value.substring(start, end));
            }
            return value;
        }

        function setCookie(key, value, expiryDays) {
            var expiryDate = new Date();
            expiryDate.setDate(expiryDate.getDate() + expiryDays);
            document.cookie = key + "=" + escape(value) + ((expiryDays == null) ? "" : "; expires=" + expiryDate.toUTCString()) + "; path=/";
        }

        function isCookieEnabled() {
            setCookie("testcookie", "testvalue", null);

            if (getCookie("testcookie") == "testvalue")
                return true;

            return false;
        }

        function isIE8() {
            try {
                if (navigator.appName == 'Microsoft Internet Explorer') {
                    if (navigator.appVersion.indexOf("MSIE 8") != -1) {
                        return true;
                    }
                }
            } catch (e) { }
            return false;
        }

        function isIE9() {
            try {
                if (navigator.appName == 'Microsoft Internet Explorer') {
                    if (navigator.appVersion.indexOf("MSIE 9") != -1) {
                        return true;
                    }
                }
            } catch (e) { }
            return false;
        }

        function isIE10() {
            try {
                if (navigator.appName == 'Microsoft Internet Explorer') {
                    if (navigator.appVersion.indexOf("MSIE 10") != -1) {
                        return true;
                    }
                }
            } catch (e) { }
            return false;
        }

        function isChrome() {
            try {
                if (window.chrome) {
                    return true;
                }
            } catch (e) { }
            return false;
        }

        function isIE11() {
            try {
                if (navigator.userAgent.match(/Trident.*rv.*11\./)) {
                    return true;
                }
            } catch (e) { }
            return false;
        }

        function isMozillaFirefox() {
            try{
                if (navigator.userAgent.toLowerCase().indexOf('firefox') > -1)
                    return true;
            }
            catch (e) { }
            return false;
        }

        function isSafari() {
            try {
                if (navigator.userAgent.search("Safari") > -1 && navigator.userAgent.search("Chrome") < 0)
                    return true;
            }
            catch (e) { }
            return false;
        }

        function getDomainFromLocation(location) {
            var domain = $('<a>').prop('href', location).prop('hostname').toLowerCase();
            if (domain.match(/^www\./)) {
                domain = domain.substring(4);
            }
            return domain;
        }

        function isBlessedDomain(location) {
            try {
                var domain = getDomainFromLocation(location);
                if (blessedDomains.indexOf(domain) != -1) {
                    return true;
                }
            } catch (e) { }
            return false;
        }

        function isFMSDomain(location) {
            try {
                var domain = getDomainFromLocation(location);
                if (fmsDomain == domain) {
                    return true;
                }
            } catch (e) { }
            return false;
        }

        function ispostMessageSupportedBrowser() {
            if (isIE8() || isIE9() || isIE10() || isChrome() || isIE11() || isMozillaFirefox() || isSafari()) {
                return true;
            }
            return false;
        }

        function sendLocationtoChild(location) {
            if (ispostMessageSupportedBrowser()) {
                var sta = getCookie("P_STA");
                if (sta == null) {
                    sta = 0;
                }
                if (sta != 0) {
                    try {
                        if (sessionStorage.tabSessionID) {
                            popup = window.open("", "trackingWindow");
                            if (isIE8() || isIE9()) {
                                popup.postMessagePassthrough(location);
                            }
                            else {
                                popup.postMessage(location, window.location.protocol + "//" + fmsDomain);
                            }
                            if (isChrome()) {
                                if (isBlessedDomain(location) || isFMSDomain(location)) {
                                    popup.window.open("about:blank").close();
                                }
                            }
                        }
                    }
                    catch (e) {  }
                }
            }
        }

        function isSMCDomain() {
            try {
                return (window.location.host.toLowerCase() == $('<a>').prop('href', $('script[src*="/crossdomain"]').attr('src')).prop('hostname').toLowerCase()
        			|| $('<a>').prop('href', $('script[src*="/crossdomain"]').attr('src')).prop('hostname') == "");
            } catch (e) { }
            return false;
        }


        if (ispostMessageSupportedBrowser() && isCookieEnabled() && isSMCDomain() && window.blessedDomains) {

            if (window.blessedDomains && typeof (Object) != "undefined" && Object.keys) {
                blessedDomains = Object.keys(window.blessedDomains);
            }

            sendLocationtoChild(window.location.href);

            $(window.document).on("click", "a", function () {
                try {
                    if (event.ctrlKey || event.shiftKey) {
                        return;
                    }
                } catch (e) { }
                var href = this.href;
                if (!href.match(/^javascript:/)) {
                    anchorClicked = true;
                    sendLocationtoChild(href);
                }
            })

            window.onbeforeunload = function () {
                if (!anchorClicked)
                    sendLocationtoChild("CheckShowSurvey");
            }
        }
    }
}

if (!window.crossDomainInitialized) {
    new MS.Support.Fms.CrossDomain();
}
