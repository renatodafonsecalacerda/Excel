function Browseinfobanner() {

    BrowserDetect.init();

    /* win81 - ie11, e10, ie9 and lower, other browsers */

    if (BrowserDetect.OS == "Windows" && (BrowserDetect.OSVersion == "Windows 8.1")) {
        if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 11) {
            return 'ie11_win81';
        } else if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 10) {
            return 'ie10_win81';
        } else if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version <= 9) {
            return 'ie9_lower_win81';
        } else if (BrowserDetect.browser != "Internet Explorer") {
            return '3rd_win81';
        };
    };

    /* win8 - ie11, ie10, ie9 and lower, other browsers */

    if (BrowserDetect.OS == "Windows" && (BrowserDetect.OSVersion == "Windows 8")) {
        if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 11) {
            return 'ie11_win8';
        } else if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 10) {
            return 'ie10_win8';
        } else if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version <= 9) {
            return 'ie9_lower_win8';
        } else if (BrowserDetect.browser != "Internet Explorer") {
            return '3rd_win8';
        };
    };

    /* win7 - ie11, ie10, ie9, ie8, ie7 and other browsers */

    if (BrowserDetect.OS == "Windows" && (BrowserDetect.OSVersion == "Windows 7")) {
        if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 11) {
            return 'ie11_win7';
        } else if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 10) {
            return 'ie10_win7';
        } else if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version <= 9) {
            return 'ie9_lower_win7';
        } else if (BrowserDetect.browser != "Internet Explorer") {
            return '3rd_win7';
        };
    };

    /* vista - ie9, ie8, ie7 and other browsers */

    if (BrowserDetect.OS == "Windows" && (BrowserDetect.OSVersion == "Windows Vista")) {
        if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 9) {
            return 'ie9_vista';
        } else if ((BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version <= 8) || (BrowserDetect.browser != "Internet Explorer")) {
            return 'ie8_lower_3rd_vista';
        };
    };

    /* windowsXP - ie8, ie7 and lower */

    if (BrowserDetect.OS == "Windows" && (BrowserDetect.OSVersion == "Windows XP Professional")) {
        if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 8) {
            return 'ie8_winxp';
        } else if ((BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version <= 7) || (BrowserDetect.browser != "Internet Explorer")) {
            return 'ie7_lower_3rd_winxp';
        };
    };

    /* other windows - ie8, ie7 and lower, other browsers */

    if (BrowserDetect.OS == "Windows" && (BrowserDetect.OSVersion != "Windows XP Professional" && BrowserDetect.OSVersion != "Windows Vista" && BrowserDetect.OSVersion != "Windows 7" && BrowserDetect.OSVersion != "Windows 8")) {
        if (BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version == 8) {
            return 'ie8_other_win';
        } else if ((BrowserDetect.browser == "Internet Explorer" && BrowserDetect.version <= 7) || (BrowserDetect.browser != "Internet Explorer")) {
            return 'ie7_lower_3rd_other_win';
        };
    };

    /* non windows - linux, etc.*/

    if ((BrowserDetect.OS != "Windows") && (BrowserDetect.OS != "Mac")) {
        return 'non_win';
    };

    /* mac */

    if (BrowserDetect.OS == "Mac") {
        return 'mac_os';
    };
}



function banner_init(SliderId, Configuration) {

    var infobanner = Browseinfobanner();
    var SliderContent = null;

    switch (infobanner) {
        case 'ie11_win81':
            SliderContent = Configuration.rightnav_ie11_win81;
            break;

        case 'ie10_win81':
            SliderContent = Configuration.rightnav_ie10_win81;
            break;

        case 'ie9_lower_win81':
            SliderContent = Configuration.rightnav_ie9_lower_win81;
            break;

        case '3rd_win81':
            SliderContent = Configuration.rightnav_3rd_win81;
            break;

        case 'ie11_win8':
            SliderContent = Configuration.rightnav_ie11_win8;
            break;

        case 'ie10_win8':
            SliderContent = Configuration.rightnav_ie10_win8;
            break;

        case 'ie9_lower_win8':
            SliderContent = Configuration.rightnav_ie9_lower_win8;
            break;

        case '3rd_win8':
            SliderContent = Configuration.rightnav_3rd_win8;
            break;

        case 'ie11_win7':
            SliderContent = Configuration.rightnav_ie11_win7;
            break;

        case 'ie10_win7':
            SliderContent = Configuration.rightnav_ie10_win7;
            break;

        case 'ie9_lower_win7':
            SliderContent = Configuration.rightnav_ie9_lower_win7;
            break;

        case '3rd_win7':
            SliderContent = Configuration.rightnav_3rd_win7;
            break;

        case 'ie9_vista':
            SliderContent = Configuration.rightnav_ie9_vista;
            break;

        case 'ie8_lower_3rd_vista':
            SliderContent = Configuration.rightnav_ie8_lower_3rd_vista;
            break;

        case 'ie8_winxp':
            SliderContent = Configuration.rightnav_ie8_winxp;
            break;

        case 'ie7_lower_3rd_winxp':
            SliderContent = Configuration.rightnav_ie7_lower_3rd_winxp;
            break;

        case 'ie8_other_win':
            SliderContent = Configuration.rightnav_ie8_other_win;
            break;

        case 'ie7_lower_3rd_other_win':
            SliderContent = Configuration.rightnav_ie7_lower_3rd_other_win;
            break;

        case 'non_win':
            SliderContent = Configuration.rightnav_non_win;
            break;

        case 'mac_os':
            SliderContent = Configuration.rightnav_mac;
            break;
    }


    if (SliderContent != null) {

        $('#' + SliderId).append('<ul>' + SliderContent + '</ul>');

        /* if only one slide, make the image static */

        if ($('#' + SliderId + ' ul li').length < 2) {
            $('#' + SliderId).Slider({ auto: false, continuous: true, nextText: "", prevText: "" });
        } else {
            $('#' + SliderId).Slider({ auto: true, continuous: true, nextText: "", nextId: SliderId + "next", prevText: "", prevId: SliderId + "prev", pause: 5000 });
        }
    }

}

