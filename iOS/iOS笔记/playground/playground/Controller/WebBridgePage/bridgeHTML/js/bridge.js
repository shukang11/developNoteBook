// 常量
var CONSTANT = {
    ONINIT: "ONINIT"
}

var Bridge = {};

addEventListener(CONSTANT.ONINIT, function() {
    log("asdfasdfas")
    alert("hh")
})

__uniqueIndex = 0;
Bridge.nativeCall = function(scheme, params, callback) {
  params = params ? decodeURI(JSON.stringify(params)) : "";

  const k = `${__uniqueIndex++}`;
  const handlerKey = Butils.getHandlerKey(k);

  _paramsStore.saveParams(handlerKey.p, params);
  if (callback !== null && callback != undefined) {
    _callbackStore.saveCallback(handlerKey.c, callback);
    Butils.addEvent(handlerKey.e, e => {
      const { data, handler } = e.data;
      Butils.removeEvent(handler);
      callback.call(this, data);
    });
  }

  // 发送协议请求
  send(`${scheme}?handler=${k}`);
};

var send = function(scheme) {
  setTimeout(() => {
    // create iframe & set src
    const iframe = document.createElement("iframe");
    iframe.src = scheme;
    iframe.style.display = "none";
    document.body.appendChild(iframe);

    setTimeout(() => {
      iframe.parentNode.removeChild(iframe);
    }, 300);
  }, 0);
  return this;
};

Bridge.postMessage = function(e) {
  // 客户端携带handler 和 data 调用postMessage
  const { handler, data } = e;

  const evName = Butils.getHandlerKey(handler).e;
  Butils.fireEvent(evName, data);
  return this;
};
