package org.quarre.remote;
import org.qtproject.qt5.android.bindings.QtActivity;
import android.content.Context;
import android.util.Log;
import java.net.Socket;
import java.io.DataOutputStream;
import java.io.IOException;
import android.util.Log;
import android.os.AsyncTask;
import org.json.JSONObject;

public class QuarreActivity extends QtActivity {

    public void registerZConfHdl() {
        runOnUiThread(new ZConfRunnable(this, getApplicationContext()));
    }

    @Override
    protected void onStop() {
        super.onStop();
        Log.d("ACTIVITY", "stopping");
//        QuarreQuit quit = new QuarreQuit();
  //      quit.execute();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d("ACTIVITY", "destroy");
    }

private class QuarreQuit extends AsyncTask<Void, Void, Void> {

    @Override
    protected Void doInBackground(Void... params) {
        try
        {
            Log.d("SOCKET", ZConfRunnable.IP);
            Socket socket = new Socket(ZConfRunnable.IP, ZConfRunnable.PORT);
            DataOutputStream DOS = new DataOutputStream(socket.getOutputStream());
            String quitmsg = "{\"/user/" + ZConfRunnable.USER_ID + "/connected\": false}";
            Log.d("SOCKET", quitmsg);
            DOS.writeUTF(quitmsg);
            socket.close();
        }
        catch ( IOException e) {
            Log.d("SOCKET", "error");
        }

        return null;
    }

}

}
