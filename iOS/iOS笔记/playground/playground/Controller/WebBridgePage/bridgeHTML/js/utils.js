var Butils = {}
Butils.getHandlerKey = function(k) {
    var o = {}
    o.p = `params_id${k}`
    o.c = `callback_id${k}`
    o.e = `eventKey_id${k}`
    return o
}

Butils.addEvent = function(type, callback) {
    document.addEventListener(type, callback)
}

Butils.removeEvent = function(type) {
    document.removeEventListener(type,()=>{

    })
}

Butils.fireEvent = function(type, data) {
    var d = {
        data: data,
        handler: type,
    }
    var e = new Event(type, d)
    e.data = d
    document.dispatchEvent(e)
}