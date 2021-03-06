function log(v) {
  return eval('('+_MemeDB_JSVIEW.scriptLog(v)+')');
}

function sum(results) {
  var rv = 0;
  for (var x = 0; x < results.length; x++) {
	rv += results[x].value;
  }
  return rv;
}

function emit(key,val) {
  //_MemeDB_retval = { 'key':key,'value':val };
  _MemeDB_retval.push([key,val]);
}

function get(id,revision,db) {
  return eval('('+_MemeDB_JSVIEW.get(id,revision,db)+')');
}

/**
 * Adds full text tokenized results of str under field name field
 * _id and _rev will not be allowed as field names
 */
function tokenize(field, str) {
  return eval('('+_MemeDB_FULLTEXT.tokenize(field, str)+')');
}

function toJSON(obj) {
  if (obj!=null && typeof obj != 'undefined') {
    return obj.toJSONString();
  }
  return null;
}
