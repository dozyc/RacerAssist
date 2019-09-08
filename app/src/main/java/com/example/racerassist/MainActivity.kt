package com.example.racerassist

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.StrictMode
import kotlinx.android.synthetic.main.activity_main.*

val race_url = "http://cotaaustin.clubspeedtiming.com/sp_center/livescore.aspx"

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()
        //StrictMode.setThreadPolicy(policy)

        webView.settings.javaScriptEnabled = true

        webView.loadUrl(race_url)
    }
}
