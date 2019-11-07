package com.example.racerassist

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.StrictMode
import android.util.Log
import com.microsoft.signalr.HubConnection
import com.microsoft.signalr.HubConnectionBuilder
import kotlinx.android.synthetic.main.activity_main.*

const val race_url = "http://cotaaustin.clubspeedtiming.com/sp_center/livescore.aspx"
const val race_hub = "http://cotaaustin.clubspeedtiming.com/SP_Center/signalr"

class MainActivity : AppCompatActivity() {

    lateinit var hubConnection: HubConnection

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()
        StrictMode.setThreadPolicy(policy)

        webView.settings.javaScriptEnabled = true

        webView.loadUrl(race_url)

        hubConnection = HubConnectionBuilder.create(race_hub).build()
        hubConnection.start()
        Log.i("cvasco.signalr", hubConnection.connectionState.toString())
        //Log.i("cvasco.signalr", hubConnection)
    }
}
