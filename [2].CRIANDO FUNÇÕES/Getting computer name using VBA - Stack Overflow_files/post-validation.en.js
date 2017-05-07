StackExchange.postValidation=function(){function e(e,t,n,i){var a=e.find('input[type="submit"]:visible'),o=a.length&&a.is(":enabled");o&&a.attr("disabled",!0),s(e,i),r(e,t,n,i),l(e),u(e),d(e);var h=function(){1!=t||e.find(C).length?(c(e),o&&a.attr("disabled",!1)):setTimeout(h,250)};h()}function t(t,i,s,r,c){e(t,i,r,s);var l,u=function(e){if(e.success)if(c)c(e);else{var n=window.location.href.split("#")[0],a=e.redirectTo.split("#")[0];0==a.indexOf("/")&&(a=window.location.protocol+"//"+window.location.hostname+a),l=!0,window.location=e.redirectTo,n.toLowerCase()==a.toLowerCase()&&window.location.reload(!0)}else e.captchaHtml?StackExchange.captcha.init(e.captchaHtml,u):e.errors?f(e.errors,t,i,s,e.warnings):t.find('input[type="submit"]:visible').parent().showErrorMessage(e.message)};t.submit(function(){if(t.find("#answer-from-ask").is(":checked"))return!0;var e=t.find(E);if("[Edit removed during grace period]"==$.trim(e.val()))return m(e,["Comment reserved for system use. Please use an appropriate comment."],h()),!1;if(o(),StackExchange.navPrevention&&StackExchange.navPrevention.stop(),t.find('input[type="submit"]:visible').parent().addSpinner(),StackExchange.helpers.disableSubmitButton(t),StackExchange.options.site.enableNewTagCreationWarning){var i=t.find(C).parent().find("input#tagnames"),r=i.prop("defaultValue");if(i.val()!==r)return $.ajax({"type":"GET","url":"/posts/new-tags-warning","dataType":"json","data":{"tags":i.val()},"success":function(e){n(e,t,l,s,u)}}),!1}return setTimeout(function(){a(t,s,l,u)},0),!1})}function n(e,t,n,o,s){if(e.showWarning){var r=$(e.html);r.bind("popupClose",function(){i(t,n)}),r.find(".popup-actions-cancel, .popup-close a").click(function(){StackExchange.helpers.closePopups(".popup"),i(t,n)}),r.find(".cancel-post").click(function(e){return StackExchange.helpers.closePopups(".popup"),e.preventDefault(),!1}),r.find(".submit-post").click(function(e){return StackExchange.helpers.closePopups(".popup"),a(t,o,n,s),e.preventDefault(),!1}),r.insertBefore(t.find('input[type="submit"]:visible')),StackExchange.helpers.bindMovablePopups(),r.show()}else a(t,o,n,s)}function i(e,t){StackExchange.helpers.removeSpinner(),t||StackExchange.helpers.enableSubmitButton(e)}function a(e,t,n,a){$.ajax({"type":"POST","dataType":"json","data":e.serialize(),"url":e.attr("action"),"success":a,"error":function(){var n;switch(t){case"question":n="An error occurred submitting the question.";break;case"answer":n="An error occurred submitting the answer.";break;case"edit":n="An error occurred submitting the edit.";break;case"tags":n="An error occurred submitting the tags.";break;case"post":default:n="An error occurred submitting the post."}e.find('input[type="submit"]:visible').parent().showErrorMessage(n)},"complete":function(){i(e,n)}})}function o(){for(var e=0;e<M.length;e++)clearTimeout(M[e]);M=[]}function s(e,t){var n=e.find(k);n.length&&n.blur(function(){M.push(setTimeout(function(){var i=n.val(),a=$.trim(i);if(0==a.length)return w(e,n),void 0;var o=n.data("min-length");if(o&&a.length<o)return m(n,[function(e){return 1==e.minLength?"Title must be at least "+e.minLength+" character.":"Title must be at least "+e.minLength+" characters."}({"minLength":o})],h()),void 0;var s=n.data("max-length");return s&&a.length>s?(m(n,[function(e){return 1==e.maxLength?"Title cannot be longer than "+e.maxLength+" character.":"Title cannot be longer than "+e.maxLength+" characters."}({"maxLength":s})],h()),void 0):($.ajax({"type":"POST","url":"/posts/validate-title","data":{"title":i},"success":function(i){i.success?w(e,n):m(n,i.errors.Title,h()),"edit"!=t&&g(e,n,i.warnings.Title)},"error":function(){w(e,n)}}),void 0)},A))})}function r(e,t,n,i){var a=e.find(S);a.length&&a.blur(function(){M.push(setTimeout(function(){var o=a.val(),s=$.trim(o);if(0==s.length)return w(e,a),void 0;if(5==t){var r=a.data("min-length");return r&&s.length<r?m(a,[function(e){return"Wiki Body must be at least "+e.minLength+" characters. You entered "+e.actual+"."}({"minLength":r,"actual":s.length})],h()):w(e,a),void 0}(1==t||2==t)&&$.ajax({"type":"POST","url":"/posts/validate-body","data":{"body":o,"oldBody":a.prop("defaultValue"),"isQuestion":1==t,"isSuggestedEdit":n},"success":function(t){t.success?w(e,a):m(a,t.errors.Body,h()),"edit"!=i&&g(e,a,t.warnings.Body)},"error":function(){w(e,a)}})},A))})}function c(e){var t=e.find(C);if(t.length){var n=t.parent().find("input#tagnames");n.blur(function(){M.push(setTimeout(function(){var i=n.val(),a=$.trim(i);return 0==a.length?(w(e,t),void 0):($.ajax({"type":"POST","url":"/posts/validate-tags","data":{"tags":i,"oldTags":n.prop("defaultValue")},"success":function(n){n.success?w(e,t):m(t,n.errors.Tags,h())},"error":function(){w(e,t)}}),void 0)},A))})}}function l(e){var t=e.find(E);t.length&&t.blur(function(){M.push(setTimeout(function(){var n=t.val(),i=$.trim(n);if(0==i.length)return w(e,t),void 0;var a=t.data("min-length");if(a&&i.length<a)return m(t,[function(e){return 1==e.minLength?"Your edit summary must be at least "+e.minLength+" character.":"Your edit summary must be at least "+e.minLength+" characters."}({"minLength":a})],h()),void 0;var o=t.data("max-length");return o&&i.length>o?(m(t,[function(e){return 1==e.maxLength?"Your edit summary cannot be longer than "+e.maxLength+" character.":"Your edit summary cannot be longer than "+e.maxLength+" characters."}({"maxLength":o})],h()),void 0):(w(e,t),void 0)},A))})}function u(e){var t=e.find(T);t.length&&t.blur(function(){M.push(setTimeout(function(){var n=t.val(),i=$.trim(n);if(0==i.length)return w(e,t),void 0;var a=t.data("min-length");if(a&&i.length<a)return m(t,[function(e){return"Wiki Excerpt must be at least "+e.minLength+" characters; you entered "+e.actual+"."}({"minLength":a,"actual":i.length})],h()),void 0;var o=t.data("max-length");return o&&i.length>o?(m(t,[function(e){return"Wiki Excerpt cannot be longer than "+e.maxLength+" characters; you entered "+e.actual+"."}({"maxLength":o,"actual":i.length})],h()),void 0):(w(e,t),void 0)},A))})}function d(e){var t=e.find(I);t.length&&t.blur(function(){M.push(setTimeout(function(){var n=t.val(),i=$.trim(n);return 0==i.length?(w(e,t),void 0):/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,20}$/i.test(n)?(w(e,t),void 0):(m(t,["This email does not appear to be valid."],p()),void 0)},A))})}function h(){var e=$("#sidebar, .sidebar").first().width()||270;return{"position":{"my":"left top","at":"right center"},"css":{"max-width":e,"min-width":e},"closeOthers":!1}}function p(){var e=$("#sidebar, .sidebar").first().width()||270;return{"position":{"my":"left top","at":"right center"},"css":{"min-width":e},"closeOthers":!1}}function f(e,t,n,i,a){if(e){var o=function(){var n=0,o=t.find(k),s=t.find(S);m(o,e.Title,h())?n++:w(t,o),a&&g(t,o,a.Title),m(s,e.Body,h())?n++:w(t,s),a&&g(t,s,a.Body),m(t.find(C),e.Tags,h())?n++:w(t,t.find(C)),m(t.find(E),e.EditComment,h())?n++:w(t,t.find(E)),m(t.find(T),e.Excerpt,h())?n++:w(t,t.find(T)),m(t.find(I),e.Email,p())?n++:w(t,t.find(I));var r=t.find(".general-error"),c=e.General&&e.General.length>0;if(c||n>0){if(!r.length){var l=t.find('input[type="submit"]:visible');l.before('<div class="general-error-container"><div class="general-error"></div><br class="cbt" /></div>'),r=t.find(".general-error")}if(c)m(r,e.General,{"position":"inline","css":{"float":"left","margin-bottom":"10px"},"closeOthers":!1,"dismissable":!1});else{w(t,r);var u;switch(i){case"question":u=function(e){return 1==e.specificErrorCount?"Your question couldn't be submitted. Please see the error above.":"Your question couldn't be submitted. Please see the errors above."}({"specificErrorCount":n});break;case"answer":u=function(e){return 1==e.specificErrorCount?"Your answer couldn't be submitted. Please see the error above.":"Your answer couldn't be submitted. Please see the errors above."}({"specificErrorCount":n});break;case"edit":u=function(e){return 1==e.specificErrorCount?"Your edit couldn't be submitted. Please see the error above.":"Your edit couldn't be submitted. Please see the errors above."}({"specificErrorCount":n});break;case"tags":u=function(e){return 1==e.specificErrorCount?"Your tags couldn't be submitted. Please see the error above.":"Your tags couldn't be submitted. Please see the errors above."}({"specificErrorCount":n});break;case"post":default:u=function(e){return 1==e.specificErrorCount?"Your post couldn't be submitted. Please see the error above.":"Your post couldn't be submitted. Please see the errors above."}({"specificErrorCount":n})}r.text(u)}}else t.find(".general-error-container").remove();var d;y()&&($("#sidebar").animate({"opacity":.4},500),d=setInterval(function(){y()||($("#sidebar").animate({"opacity":1},500),clearInterval(d))},500));var f;t.find(".validation-error").each(function(){var e=$(this).offset().top;(!f||f>e)&&(f=e)});var v=function(){for(var e=0;3>e;e++)t.find(".message").animate({"left":"+=5px"},100).animate({"left":"-=5px"},100)};if(f){var b=$(".review-bar").length;f=Math.max(0,f-(b?125:30)),$("html, body").animate({"scrollTop":f},v)}else v()},s=function(){1!=n||t.find(C).length?o():setTimeout(s,250)};s()}}function g(e,t,n){var i=h();if(i.type="warning",!n||0==n.length)return b(e,t),!1;var a=t.data("error-popup"),o=0;return a&&(o=a.height()+5),v(t,n,i,o)}function m(e,t,n){return n.type="error",v(e,t,n)}function v(e,t,n,i){var a,s=n.type;if(!(t&&0!=t.length&&e.length&&$("html").has(e).length))return!1;if(a=1==t.length?t[0]:"<ul><li>"+t.join("</li><li>")+"</li></ul>",a&&a.length>0){var r=e.data(s+"-popup");if(r&&r.is(":visible")){var c=e.data(s+"-message");if(c==a)return r.animateOffsetTop(i||0),!0;r.fadeOutAndRemove()}i>0&&(n.position.offsetTop=i);var l=StackExchange.helpers.showMessage(e,a,n);return l.find("a").attr("target","_blank"),l.click(o),e.addClass("validation-"+s).data(s+"-popup",l).data(s+"-message",a),!0}return!1}function b(e,t){x("warning",e,t)}function w(e,t){x("error",e,t)}function x(e,t,n){if(!n||0==n.length)return!1;var i=n.data(e+"-popup");return i&&i.is(":visible")&&i.fadeOutAndRemove(),n.removeClass("validation-"+e),n.removeData(e+"-popup"),n.removeData(e+"-message"),t.find(".validation-"+e).length||t.find(".general-"+e+"-container").remove(),!0}function y(){var e=!1,t=$("#sidebar, .sidebar").first();if(!t.length)return!1;var n=t.offset().left;return $(".message").each(function(){var t=$(this);return t.offset().left+t.outerWidth()>n?(e=!0,!1):void 0}),e}var k="input#title",S="textarea.wmd-input:first",C=".tag-editor",E="input[id^=edit-comment]",T="textarea#excerpt",I="input#m-address",M=[],A=250;return{"initOnBlur":e,"initOnBlurAndSubmit":t,"showErrorsAfterSubmission":f,"getSidebarPopupOptions":h}}();