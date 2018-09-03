var handle = window.webkit.messageHandlers;

function baseActionCallBack(content) {
	console.log(content);
}

function baseAction() {
	window.webkit.messageHandlers.baseAction.postMessage({
		uri: "baseAction.com", 
		body: 'im message',
		callback: "baseActionCallBack"
	});
};