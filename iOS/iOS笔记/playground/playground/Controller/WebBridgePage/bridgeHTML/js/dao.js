// store
var _paramsStore = {
  paramspool: {},

  saveParams: function(key, params) {
    this.paramspool[key] = params;
  },
  getParams: function(key) {
    return this.paramspool[key];
  }
};

var _callbackStore = {
  callbackpool: {},

  saveCallback: function(key, callback) {
    this.callbackpool[key] = callback;
  },
  getCallback: function(key) {
    return this.callbackpool[key];
  }
};

var _listenerStore = {
  listenerpool: {},

  saveListener: function(key, listener) {
    this.listenerpool[key] = listener;
  },
  getListener: function(key) {
    return this.listenerpool[key];
  },
  removeListener: function(key) {
    delete this.listenerpool.key;
  }
};

var __Native_getParams = function(rid) {
  var handle = Butils.getHandlerKey(rid);
  return _paramsStore.getParams(handle.p);
};
