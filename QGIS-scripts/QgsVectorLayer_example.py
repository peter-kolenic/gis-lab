# run this in QGIS, "Python Console", "Show Editor", "Open File"
# simple QgsVectorLayer example

uri = QgsDataSourceURI()
uri.setConnection("db.gis.lab", "5432", "gislab", "lab1", "lab")
uri.setDataSource("lab1", "Roads", "geom") # , "cityid = 2643")
display_name = 'CESTY'
vlayer = QgsVectorLayer(uri.uri(), display_name, 'postgres')

iter = vlayer.getFeatures()

for feature in iter:
    print feature.id(), feature.geometry()
