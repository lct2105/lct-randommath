var eventCallback = {
	sendpopup: function(data) {
		var UI = document.querySelector('#popup');
		var icon = '';
		UI.style.display = 'block';

		saferInnerHTML(UI.querySelector('.title span'), data.title);
		saferInnerHTML(UI.querySelector('.message'), data.message);

		UI.classList.remove('fadeInRight', 'fadeOutRight');
		UI.classList.add('fadeInRight', data.type);

		setTimeout(function(){
			UI.classList.add('fadeOutRight');
		}, data.timeout);

	}
};

window.addEventListener('message', function(event) {
	eventCallback[event.data.action](event.data);
});