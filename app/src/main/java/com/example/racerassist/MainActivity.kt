package com.example.racerassist

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.StrictMode
import android.util.Log
import android.webkit.JavascriptInterface
import com.microsoft.signalr.HubConnection
import com.microsoft.signalr.HubConnectionBuilder
import kotlinx.android.synthetic.main.activity_main.*
import androidx.appcompat.app.AlertDialog
import android.webkit.WebView
import android.webkit.WebViewClient

const val race_url = "http://cotaaustin.clubspeedtiming.com/sp_center/livescore.aspx"
const val race_hub = "http://cotaaustin.clubspeedtiming.com/SP_Center/signalr"

class MainActivity : AppCompatActivity() {

    lateinit var hubConnection: HubConnection


    /* zomg Android Studio auto-converted this from Java code copied from
     * https://stackoverflow.com/a/8201246
     */
    internal inner class MyJavaScriptInterface(private val ctx: Context) {

        @JavascriptInterface
        fun showHTML(html: String) {
            AlertDialog.Builder(ctx).setTitle("HTML").setMessage(html)
                .setPositiveButton(android.R.string.ok, null)
                .setCancelable(false).create().show()
        }

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()
        StrictMode.setThreadPolicy(policy)

        webView.settings.javaScriptEnabled = true
        webView.addJavascriptInterface(
            MyJavaScriptInterface(this), "HtmlViewer")

        webView.webViewClient = (object : WebViewClient() {
            override fun onPageFinished(view: WebView, url: String) {
                webView.loadUrl("javascript:window.HtmlViewer.showHTML" +
                        "('<html>'+document.getElementsByTagName('html')[0].innerHTML+'</html>');")
            }
        })


        webView.loadUrl(race_url)

        hubConnection = HubConnectionBuilder.create(race_hub).build()
        hubConnection.start()
        Log.i("dozyc.signalr", hubConnection.connectionState.toString())
        Log.i("dozyc.html", "TODO: get html in this log...")
        //Log.i("dozyc.signalr", hubConnection)
    }
}
