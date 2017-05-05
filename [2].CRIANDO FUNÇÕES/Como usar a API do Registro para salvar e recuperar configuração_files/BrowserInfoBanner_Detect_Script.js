var BrowserDetect = {

    init: function () {

        
        if (!!navigator.userAgent.match(/Trident.*rv:11\./)) {
            this.browser = "Internet Explorer";
            this.version = 11;
        }
        else {
            this.browser = this.searchString(this.dataBrowser) || "An unknown browser";

            this.version = this.searchVersion(navigator.userAgent)
			                || this.searchVersion(navigator.appVersion)
			                || "an unknown version";


            /* Compatibility Modes */

            if (this.browser == "Internet Explorer" && navigator.userAgent.indexOf('Trident/6.0') != -1)
                this.version = 10;   /* Compatibility Mode */

            if (this.browser == "Internet Explorer" && navigator.userAgent.indexOf('Trident/5.0') != -1)
                this.version = 9;   /* Compatibility Mode */

            if (this.browser == "Internet Explorer" && navigator.userAgent.indexOf('Trident/4.0') != -1)
                this.version = 8;   /* Compatibility Mode */
        }


        this.OS = this.searchString(this.dataOS) || "an unknown OS";
        this.OSVersion = this.searchString(this.dataOSVersion) || "an unknown OSVersion";  /* We should use OSVersionName */
        this.OSVersionName = this.searchString(this.dataOSVersion) || "an unknown OSVersion";
        this.OSVersionNumber = this.searchString2(this.dataOSVersion);


        this.Name = this.browser + " " + this.version;
    },

    searchString: function (data) {
        for (var i = 0; i < data.length; i++) {
            var dataString = data[i].string;
            var dataProp = data[i].prop;
            this.versionSearchString = data[i].versionSearch || data[i].identity;
            if (dataString) {
                if (dataString.indexOf(data[i].subString) != -1)
                    return data[i].identity;
            }
            else if (dataProp)
                return data[i].identity;
        }
    },


    searchString2: function (data) {
        for (var i = 0; i < data.length; i++) {
            var dataString = data[i].string;
            var dataProp = data[i].prop;
            this.versionSearchString = data[i].versionSearch || data[i].identity;
            if (dataString) {
                if (dataString.indexOf(data[i].subString) != -1)
                    return data[i].OSVersionNumber;
            }
            else if (dataProp)
                return data[i].OSVersionNumber;
        }
    },


    searchVersion: function (dataString) {
        var index = dataString.indexOf(this.versionSearchString);
        if (index == -1) return;
        return parseFloat(dataString.substring(index + this.versionSearchString.length + 1));
    },

    dataBrowser: [
		{
		    string: navigator.userAgent,
		    subString: "Chrome",
		    identity: "Chrome"
		},
		{
		    string: navigator.userAgent,
		    subString: "OmniWeb",
		    versionSearch: "OmniWeb/",
		    identity: "OmniWeb"
		},
		{
		    string: navigator.vendor,
		    subString: "Apple",
		    identity: "Safari",
		    versionSearch: "Version"
		},
		{
		    prop: window.opera,
		    identity: "Opera"
		},
		{
		    string: navigator.vendor,
		    subString: "iCab",
		    identity: "iCab"
		},
		{
		    string: navigator.vendor,
		    subString: "KDE",
		    identity: "Konqueror"
		},
		{
		    string: navigator.userAgent,
		    subString: "Firefox",
		    identity: "Firefox"
		},
		{
		    string: navigator.vendor,
		    subString: "Camino",
		    identity: "Camino"
		},
		{		// for newer Netscapes (6+)
		    string: navigator.userAgent,
		    subString: "Netscape",
		    identity: "Netscape"
		},
		{
		    string: navigator.userAgent,
		    subString: "MSIE",
		    identity: "Internet Explorer",
		    versionSearch: "MSIE"
		},
		{
		    string: navigator.userAgent,
		    subString: "rv:",
		    identity: "Internet Explorer",
		    versionSearch: "rv:"
		},
		{
		    string: navigator.userAgent,
		    subString: "Gecko",
		    identity: "Mozilla",
		    versionSearch: "rv"
		},
		{ 		// for older Netscapes (4-)
		    string: navigator.userAgent,
		    subString: "Mozilla",
		    identity: "Netscape",
		    versionSearch: "Mozilla"
		}
    ],
    dataOS: [
		{
		    string: navigator.platform,
		    subString: "Win",
		    identity: "Windows"
		},
		{
		    string: navigator.platform,
		    subString: "Mac",
		    identity: "Mac"
		},
		{
		    string: navigator.userAgent,
		    subString: "iPhone",
		    identity: "iPhone/iPod"
		},
		{
		    string: navigator.platform,
		    subString: "Linux",
		    identity: "Linux"
		}
    ],
    dataOSVersion: [
		{
		    string: navigator.userAgent,
		    subString: "Windows 95",
		    identity: "Windows 95",
		    OSVersionNumber: 4.0
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows 98; Win 9x 4.90",
		    identity: "Windows Millennium Edition",
		    OSVersionNumber: 4.9
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows 98",
		    identity: "Windows 98",
		    OSVersionNumber: 4.10
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows NT 4.0",
		    identity: "Windows NT 4.0",
		    OSVersionNumber: 4.0
		},

		{
		    string: navigator.userAgent,
		    subString: "Windows NT 5.0",
		    identity: "Windows 2000",
		    OSVersionNumber: 5.0
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows NT 5.01",
		    identity: "Windows 2000 Service Pack 1",
		    OSVersionNumber: 5.01
		},

		{
		    string: navigator.userAgent,
		    subString: "Windows NT 5.1",
		    identity: "Windows XP",
		    OSVersionNumber: 5.1
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows NT 5.2",
		    identity: "Windows XP 64-Bit Edition",
		    OSVersionNumber: 5.2
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows NT 6.0",
		    identity: "Windows Vista",
		    OSVersionNumber: 6.0
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows NT 6.1",
		    identity: "Windows 7",
		    OSVersionNumber: 6.1
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows NT 6.2",
		    identity: "Windows 8",
		    OSVersionNumber: 6.2
		},
		{
		    string: navigator.userAgent,
		    subString: "Windows NT 6.3",
		    identity: "Windows 8.1",
		    OSVersionNumber: 6.3
		},
		{
		    string: navigator.userAgent,
		    subString: "Mac_PowerPC",
		    identity: "Mac OS 9.2",
		    OSVersionNumber: 9.2
		}
    ]

};


BrowserDetect.init();

