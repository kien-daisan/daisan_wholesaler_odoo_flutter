package com.webkul.flutter_project_structure


import android.app.Activity
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.webkul.flutter_project_structure.arcore.activities.ArActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import webkul.opencart.mobikul.mlkit.CameraSearchActivity

class MainActivity : FlutterFragmentActivity() {
    private val EVENTS = "com.oddo.flutter/channel"
    var methodChannelResult: MethodChannel.Result? = null
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            EVENTS
        ).setMethodCallHandler { call, result ->
            methodChannelResult = result;
            if (call.method == "initialLink") {
                val initialUrl = initialLink()
                if (initialUrl != null) {
                    result.success(initialLink())
                } else {
                    result.error("UNAVAILABLE", "No deep link found", null)
                }
            } else if (call.method == "imageSearch") {
                startImageFinding()
            } else if (call.method == "textSearch") {
                startTextFinding()
            } else if (call.method == "showAr") {
                if (call.hasArgument("url")) {
                    Log.d("qdaasdas", call.argument("url") ?: "No Name")
                }
                showArActivity(call.argument("name"), call.argument("url"))

            }
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 101 && resultCode == Activity.RESULT_OK) {
            methodChannelResult?.success(data?.getStringExtra(CameraSearchActivity.CAMERA_SEARCH_HELPER))
        }
    }

    fun initialLink(): String? {
        val uri = intent.data
        Log.d("adasdasda", uri.toString())
        return if (uri != null) {
            uri.toString();
        } else {
            null
        }
    }

    private fun startImageFinding() {
        val intent = Intent(this, CameraSearchActivity::class.java)
        intent.putExtra(
            CameraSearchActivity.CAMERA_SELECTED_MODEL,
            CameraSearchActivity.IMAGE_LABELING
        )
        startActivityForResult(intent, 101)
    }

    private fun startTextFinding() {
        val intent = Intent(this, CameraSearchActivity::class.java)
        intent.putExtra(
            CameraSearchActivity.CAMERA_SELECTED_MODEL,
            CameraSearchActivity.TEXT_RECOGNITION
        )
        startActivityForResult(intent, 101)
    }

    private fun showArActivity(name: String?, url: String?) {
        Log.d("sdaasdas", "${name}----${url}")
        val intent = Intent(this, ArActivity::class.java)
        intent.putExtra("name", name)
        intent.putExtra("link", url)
        startActivity(intent)
    }


}

