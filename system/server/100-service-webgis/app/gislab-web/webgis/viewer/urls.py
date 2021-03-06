from django.conf.urls import patterns, url

urlpatterns = patterns("webgis.viewer.views",
	url(r"^$", "page", name="page"),
	url("^owsrequest/$", "ows_request", name="owsrequest"),
	url("^tile/(?P<project_hash>[^/]+)/(?P<publish>\d+)/(?P<layers_hash>[^/]+)/(?P<z>\d+)/(?P<x>\d+)/(?P<y>\d+)\.(?P<format>\w+)$", "tile", name="tile"),
)
