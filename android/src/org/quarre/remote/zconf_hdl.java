package org.quarre.remote;

import org.qtproject.qt5.android.bindings.QtActivity;
import android.content.Context;
import android.net.nsd.NsdServiceInfo;
import android.net.nsd.NsdManager;
import android.net.nsd.NsdManager.RegistrationListener;
import android.util.Log;

public class zconf_hdl extends QtActivity
{
    public zconf_hdl() {}

    private NsdManager.RegistrationListener m_reglistener;
    private NsdManager m_nsdmanager;

    public void register_service(String name, String type, int port)
    {
        NsdServiceInfo service_info = new NsdServiceInfo();
        service_info.setServiceName(name);
        service_info.setServiceType(type);
        service_info.setPort(port);

        Context ctx = getApplicationContext();

        m_nsdmanager = (NsdManager) ctx.getSystemService(Context.NSD_SERVICE);
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
