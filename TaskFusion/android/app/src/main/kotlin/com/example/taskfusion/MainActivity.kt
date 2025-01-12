package com.example.taskfusion
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.media.MediaScannerConnection


class MainActivity: FlutterActivity() {
    private val CHANNEL = "media_scanner"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "scanFile") {
                val filePath = call.argument<String>("filePath")
                if (filePath != null) {
                    scanFile(filePath)
                    result.success(true)
                } else {
                    result.error("INVALID_FILE_PATH", "File path is null", null)
                }
            }
        }
    }

    private fun scanFile(filePath: String) {
        MediaScannerConnection.scanFile(
            applicationContext, arrayOf(filePath), null, null
        )
    }
}
