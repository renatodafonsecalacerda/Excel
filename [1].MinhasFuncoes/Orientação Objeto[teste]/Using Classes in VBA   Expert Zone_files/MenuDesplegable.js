
function MenuDesplegable(that) {
	url = that.options[that.selectedIndex].value; 

	if (url) {
		// window.location = url;
		_gaq.push(['_link', url]);
	}
}

function ggTrack(item)
{
	url = item.href;
	if (url) _gaq.push(['_link', url]);
}

