# MIT License
#
# Copyright (c) 2020-2022 Macaroni Studios AB
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

class_name _GotmBlob
#warnings-disable


static func get_implementation(id = null):
	var config := _Gotm.get_config()
	if _LocalStore.fetch(id) || !_Gotm.has_global_api():
		return _GotmBlobLocal
	return _GotmStore


static func fetch(blob_or_id):
	var id = _coerce_id(blob_or_id)
	var data = yield(get_implementation(id).fetch(id), "completed")
	return _format(data, _Gotm.create_instance("GotmBlob"))

static func fetch_data(blob_or_id):
	var id = _coerce_id(blob_or_id)
	if !id:
		yield(_GotmUtility.get_tree(), "idle_frame")
		return
	return yield(get_implementation(id).fetch(_Gotm.get_global().storageApiEndpoint + "/" + id), "completed")

static func _coerce_id(resource_or_id):
	return _GotmUtility.coerce_resource_id(resource_or_id, "blobs")

static func _format(data, blob):
	if !data || !blob:
		return
	blob.id = data.path
	blob.size = data.size
	blob.is_local = !!_LocalStore.fetch(data.path)
	return blob
