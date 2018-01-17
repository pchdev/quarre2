package org.quarre.remote;

import org.qtproject.qt5.android.bindings.QtActivity;
import android.app.Activity;
import android.content.Context;
import android.net.nsd.NsdServiceInfo;
import android.net.nsd.NsdManager;
import android.net.nsd.NsdManager.RegistrationListener;
import android.net.wifi.WifiManager;
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

    private NsdManager                          m_nsdmanager;
    private NsdManager.RegistrationListener     m_reglistener;
    private NsdManager.DiscoveryListener        m_discolistener;
    private NsdManager.ResolveListener          m_resolvelistener;


    @Override
    public void run() {
        // called on Android UI Thread
        this.discoverServer("quarre-server", "_oscjson._tcp");
        //this.registerService("quarre-remote", "_oscjson._tcp", 5678);
    }

    public static int port;
    public static String service_name;
    public static String service_type;
    public static String HOST_ADDR;

    public void discoverServer(String name, String type)
    {
        m_nsdmanager = (NsdManager) m_context.getSystemService(Context.NSD_SERVICE);

        m_resolvelistener = new NsdManager.ResolveListener() {
            @Override
            public void onResolveFailed(NsdServiceInfo service, int error_code)
            {
                Log.d("ZCONF", "Resolve failed: " + error_code);
            }

            @Override
            public void onServiceResolved(NsdServiceInfo service)
            {
                Log.d("ZCONF", "Resolve succeeded");

                String host = "ws:/" + service.getHost().toString()
                                     + ":" + service.getPort();

                Log.d("ZCONF", host);
                HOST_ADDR = host;
                NativeFunctions.onServerDiscoveredNative();
            }
        };

        m_discolistener = new NsdManager.DiscoveryListener() {

            @Override
            public void onDiscoveryStarted(String regType) {
                Log.d("ZCONF", "Service discovery started");
            }
            @Override
            public void onServiceFound(NsdServiceInfo service)
            {
                if(service.getServiceName().equals("quarre-server"))
                {
                    Log.d("ZCONF", "quarrè server found!");
                    m_nsdmanager.resolveService(service, m_resolvelistener);
                }
            }
            @Override
            public void onServiceLost(NsdServiceInfo service)
            {
                Log.d("ZCONF", "Service disconnected: " + service.getServiceName());
            }
            @Override
            public void onDiscoveryStopped(String serviceType)
            {
                Log.d("ZCONF", "Discovery stopped");
            }
            @Override
            public void onStartDiscoveryFailed(String serviceType, int errorCode)
            {
                m_nsdmanager.stopServiceDiscovery(this);
            }
            @Override
            public void onStopDiscoveryFailed(String serviceType, int errorCode)
            {
                m_nsdmanager.stopServiceDiscovery(this);
            }
        };

        m_nsdmanager.discoverServices(type, NsdManager.PROTOCOL_DNS_SD, m_discolistener);
    }

    public void registerService(String name, String type, int port)
    {        
        NsdServiceInfo service_info = new NsdServiceInfo();
        service_info.setServiceName(name);
        service_info.setServiceType(type);
        service_info.setPort(port);

        m_nsdmanager = (NsdManager) m_context.getSystemService(Context.NSD_SERVICE);
        m_reglistener = new NsdManager.RegistrationListener() {

            @Override
            public void onServiceRegistered(NsdServiceInfo serviceInfo) {

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
