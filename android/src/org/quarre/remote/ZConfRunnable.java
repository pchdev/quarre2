package org.quarre.remote;

import org.qtproject.qt5.android.bindings.QtActivity;
import android.app.Activity;
import android.content.Context;
import android.net.nsd.NsdServiceInfo;
import android.net.nsd.NsdManager;
import android.net.nsd.NsdManager.RegistrationListener;
import android.util.Log;

public class ZConfRunnable implements Runnable
{
    private Activity m_activity;
    private Context m_context;
    public ZConfRunnable(Activity activity, Context ctx)
    {
        m_activity = activity;
        m_context = ctx;
    }

    private NsdManager.RegistrationListener m_reglistener;
    private NsdManager m_nsdmanager;

    @Override
    public void run() {
        // called on Android UI Thread
        this.registerService("quarre-remote", "_oscjson._tcp", 5678);
    }

    public static int port;
    public static String service_name;
    public static String service_type;

    public void registerService(String name, String type, int port)
    {
        NsdServiceInfo service_info = new NsdServiceInfo();
        service_info.setServiceName(name);
        service_info.setServiceType(type);
        service_info.setPort(port);

        m_nsdmanager = (NsdManager) m_context.getSystemService(Context.NSD_SERVICE);
        m_reglistener = new NsdManager.RegistrationListener() {

            @Override
            public void onServiceRegistered(NsdServiceInfo NsdServiceInfo) {

            }

            @Override
            public void onRegistrationFailed(NsdServiceInfo serviceInfo, int errorCode) {

            }

            @Override
            public void onServiceUnregistered(NsdServiceInfo arg0) {

            }

            @Override
            public void onUnregistrationFailed(NsdServiceInfo serviceInfo, int errorCode) {

            }

        };

        m_nsdmanager.registerService(service_info, NsdManager.PROTOCOL_DNS_SD, m_reglistener);

    }
}
