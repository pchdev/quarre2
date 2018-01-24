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
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d("ACTIVITY", "destroy");
    }
}
