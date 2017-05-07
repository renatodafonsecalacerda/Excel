(function($) {
	$(window).load(function() {
		$('.masonry-container').masonry( {
			columnWidth: '.col-4',
			itemSelector: '.post-wrap'
		});
	});
})(jQuery);
