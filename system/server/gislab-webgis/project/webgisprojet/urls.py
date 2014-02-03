from django.conf.urls import patterns, include, url

urlpatterns = patterns('',
	url(r'', include('webgis.viewer.urls')),
	url(r'^ball/$', include('webgis.storage.urls')),
)
