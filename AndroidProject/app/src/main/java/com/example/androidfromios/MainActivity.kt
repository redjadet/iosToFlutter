package com.example.androidfromios

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.example.androidfromios.ui.theme.AndroidFromiOSTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidFromiOSTheme {
                SamplesApp()
            }
        }
    }
}
