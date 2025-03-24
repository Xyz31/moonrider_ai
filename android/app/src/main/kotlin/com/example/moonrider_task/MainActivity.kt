package com.example.moonrider_task

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import android.os.Bundle
import android.widget.RemoteViews
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.emotorad/notifications"
    private val notificationChannelId = "redemption_notifications"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "showNotification" -> {
                    val title = call.argument<String>("title")
                    val body = call.argument<String>("body")
                    showNotification(title ?: "", body ?: "")
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun showNotification(title: String, body: String) {
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                notificationChannelId,
                "Redemption Notifications",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            notificationManager.createNotificationChannel(channel)
        }

        /*
        val notification = NotificationCompat.Builder(this, notificationChannelId)
            .setContentTitle(title)
            .setContentText(body)
            .setSmallIcon(R.drawable.ic_icon)
            .setAutoCancel(true)
            .setStyle(NotificationCompat.BigTextStyle().bigText(body))
            .build()

        val expandedLayout = RemoteViews(packageName , R.layout.expanded_notification)

        notification.setCustomBigContentView(expandedLayout)
        notification.setStyle(NotificationCompat.DecoratedCustomViewStyle())
        */

        val notificationLayout = RemoteViews(packageName, R.layout.expanded_notification)
        notificationLayout.setTextViewText(R.id.rewardText, title)
        

        val notification = NotificationCompat.Builder(this, notificationChannelId)
        .setContentTitle(title)
        .setSmallIcon(R.drawable.ic_icon)
        .setContent(notificationLayout)
        .setAutoCancel(true)
        .build()

        notificationManager.notify(System.currentTimeMillis().toInt(), notification)
    }
}
