/*
 * Copyright (c) 2008, The Caffeine-hx project contributors
 * Original author : Russell Weir
 * Contributors:
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE CAFFEINE-HX PROJECT CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE CAFFEINE-HX PROJECT CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

package protocols.couchdb;

import formats.json.JsonObject;
import formats.json.JsonArray;

/**
	A couchdb document
**/
class Document extends JsonObject {
	public var id(getId, setId) : String;
	public var revision(getRevision, setRevision) : String;

	private var database : Database;

	/**
		Create a new document.
	**/
	public function new(?def:Dynamic,?id:String) {
		super(def);
		if(id != null)
			setId(id);
	}

	/**
		Clearing a document preserves it's _id and _rev, so only the
		data is cleared.
	**/
	override public function clear() {
		var oid = id;
		var orev = revision;
		super.clear();
		id = oid;
		revision = orev;
	}

	/**
		Get the Document id, if it has been set.
	**/
	public function getId() : String { return optString("_id", null); }

	/**
		This revision of the Document
	**/
	public function getRevision() : String { return optString("_rev"); }

	/**
		Get a list of the revisions for this Document. Beware that CouchDB
		is not suitable as a revision server: old revisions can be deleted
		at any time.
	**/
 	public function getRevisions() : List<String> {
		var r = new List<String>();
		if(!has("_revisions") && database != null) {
			var d = database.openWithRevisions(getId());
			data = data.concat(d.data);
		}

		var a = getJsonArray("_revisions");
		if(a != null) {
			var l = a.length;
			for(i in 0...l) {
				r.add(a.getString(i));
			}
		}
		return r;
 	}

	/**
		Refresh from server, updating to the newest revision.
		Will not delete changes unless the database has the same key.
	**/
	public function refresh() {
		if (database!=null) {
			var d = database.open(getId());
			data = data.concat(d.data);
		}
	}

	/**
		Reloads this document entirely, overwriting all changes.
	**/
	public function reload() {
		if(database != null) {
			var d = database.open(
				getId(),
				new DocumentOptions().byRevision(getRevision()));
			this.data = d.data;
		}
	}


	public function setDatabase(d: Database) { this.database = d; }

	public function setId(id : String) { set("_id",id); return id; }

	public function setRevision(v : String) { set("_rev", v); return v; }

}
