package org.quarre.remote;
import org.qtproject.qt5.android.bindings.QtActivity;
import android.content.Context;

public class QuarreActivity extends QtActivity {

    public void registerZConfHdl() {
        runOnUiThread(new ZConfRunnable(this, getApplicationContext()));
    }

}
