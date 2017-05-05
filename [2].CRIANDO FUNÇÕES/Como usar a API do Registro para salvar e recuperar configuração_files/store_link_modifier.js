(function () {
    $(function () {
        $(".oneMscomFooterV3 a[href='http://www.microsoftstore.com.br/shop/pt-BR?WT.mc_id=MSCOM_HP_BR_Nav_BuyShopNow']").each(function () {
            var href = $(this).attr("href");
            href = href.substr(0, href.indexOf('?'));
            $(this).attr("href", href + "?WT.mc_id=SMCMSCOM_PTBR_NAV_BUYALL");
        });
     
    });
})();


