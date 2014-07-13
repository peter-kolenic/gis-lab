# run this in QGIS, "Python Console", "Show Editor", "Open File"
# simple QgsVectorLayer example for apparently PyQT object lifetime
# related crashing - created QgsVectorLayer is (probably) released

def accept():
	ret = 0
	try:
		#QApplication.setOverrideCursor(QCursor(Qt.WaitCursor))
		#outputLayer = qgis.core.QgsVectorLayer(
		#	u'dbname=\'gislab\' host=db.gis.lab port=5432 user=\'lab1\' password=\'lab\' sslmode=disable table="lab1"."Roads2" (geom) sql=',
		#	"",
		#	'postgres')
		# outputLayer.startEditing()
		fiter = qgis.core.QgsVectorLayer(
				u'dbname=\'gislab\' host=db.gis.lab port=5432 user=\'lab1\' password=\'lab\' sslmode=disable table="lab1"."Roads" (geom) sql=',
				"",
				'postgres').getFeatures()
		for feature in fiter:
			print feature
	except Exception as e:
		print "EEEE"
		ret = -1
		errMsg = unicode( e )
	finally:
		pass
		#QApplication.restoreOverrideCursor()
	return ret
accept()
