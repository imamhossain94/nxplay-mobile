package com.newagedevs.nx_play

import android.os.Build
import android.os.Bundle
import androidx.annotation.RequiresApi
import app.meedu.player.MeeduPlayerFlutterActivity

//import com.pusher.client.Pusher;
//import com.pusher.client.PusherOptions;
//import com.pusher.client.channel.Channel;
//import com.pusher.client.channel.PusherEvent;
//import com.pusher.client.channel.SubscriptionEventListener;
//import com.pusher.client.connection.ConnectionEventListener;
//import com.pusher.client.connection.ConnectionState;
//import com.pusher.client.connection.ConnectionStateChange;
class MainActivity : MeeduPlayerFlutterActivity() {
    //NotificationManager notificationManager;
    @RequiresApi(api = Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //setContentView(R.layout.activity_main);


//        notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
//        createNotificationChannel();
//
//        PusherOptions options = new PusherOptions();
//        options.setCluster("ap2");
//
//        Pusher pusher = new Pusher("9b1a18309547ba6fa4d1", options);
//
//        pusher.connect(new ConnectionEventListener() {
//            @Override
//            public void onConnectionStateChange(ConnectionStateChange change) {
//                Log.i("Pusher", "State changed from " + change.getPreviousState() +
//                        " to " + change.getCurrentState());
//            }
//
//            @Override
//            public void onError(String message, String code, Exception e) {
//                Log.i("Pusher", "There was a problem connecting! " +
//                        "\ncode: " + code +
//                        "\nmessage: " + message +
//                        "\nException: " + e
//                );
//            }
//        }, ConnectionState.ALL);
//
//        Channel channel = pusher.subscribe("my-channel");
//
//        channel.bind("my-event", new SubscriptionEventListener() {
//            @Override
//            public void onEvent(PusherEvent event) {
//                Log.i("Pusher", "Received event with data: " + event.toString());
//
//                //
//
//                getActivity().runOnUiThread(new Runnable() {
//                    @RequiresApi(api = Build.VERSION_CODES.O)
//                    public void run() {
//                        Toast.makeText(getActivity(), event.getData(), Toast.LENGTH_LONG).show();
//                        //notifyThis(event.toString(), event.toString());
//                        sendNotification("Test Message", event.getData());
//
//
//                    }
//                });
//
//
//
//            }
//        });
    } //    @RequiresApi(api = Build.VERSION_CODES.O)
    //    protected void createNotificationChannel() {
    //
    //        int importance = NotificationManager.IMPORTANCE_LOW;
    //        NotificationChannel channel = new NotificationChannel("com.newagedevs.nx_play", "NotifyDemo News", importance);
    //
    //        channel.setDescription("Example News Channel");
    //        channel.enableLights(true);
    //        channel.setLightColor(Color.RED);
    //        channel.enableVibration(true);
    //        channel.setVibrationPattern(
    //                new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});
    //        notificationManager.createNotificationChannel(channel);
    //    }
    //
    //    @RequiresApi(api = Build.VERSION_CODES.O)
    //    protected void sendNotification(String title, String message) {
    //
    //        int notificationID = 101;
    //
    //        String channelID = "com.newagedevs.nx_play";
    //
    //        Notification notification = new Notification.Builder(getActivity(),
    //                        channelID)
    //                        .setContentTitle(title)
    //                        .setContentText(message)
    //                        .setSmallIcon(R.drawable.app_icon)
    //                        .setChannelId(channelID)
    //                        .build();
    //
    //        notificationManager.notify(notificationID, notification);
    //    }
    //    @Override
    //    protected void onCreate(Bundle savedInstanceState) {
    //        super.onCreate(savedInstanceState);
    //
    //        GeneratedPluginRegistrant.registerWith(this.getFlutterEngine());
    //    }
    //    @Override
    //    protected void onCreate(@Nullable Bundle savedInstanceState) {
    //        super.onCreate(savedInstanceState);
    //       // GeneratedPluginRegistrant.registerWith(this);
    //
    ////        try {
    ////            PackageInfo info = getPackageManager().getPackageInfo("com.newagedevs.nx_play", PackageManager.GET_SIGNATURES);
    ////            for (Signature signature : info.signatures) {
    ////                MessageDigest md = MessageDigest.getInstance("SHA");
    ////                md.update(signature.toByteArray());
    ////                Log.d("KeyHash:", Base64.encodeToString(md.digest(), Base64.DEFAULT));
    ////                System.out.println("KeyHash:" + Base64.encodeToString(md.digest(), Base64.DEFAULT));
    ////            }
    ////        }
    ////        catch (PackageManager.NameNotFoundException | NoSuchAlgorithmException e) {
    ////            System.out.println("-----------------------------------------------------------------------------");
    ////        }
    //
    //    }
}