package io.github.kjwenger;

import com.formdev.flatlaf.FlatDarkLaf;
import com.plealog.genericapp.api.EZApplicationBranding;
import com.plealog.genericapp.api.EZEnvironment;
import com.plealog.genericapp.api.EZGenericApplication;

import javax.swing.*;

public class GooPixUIStarter {

    public static void main(String[] args) {
        EZGenericApplication.initialize("GooPixUIStarter");

        // Add application branding
        EZApplicationBranding.setAppName("GooPix");
        EZApplicationBranding.setAppVersion("1.0");
        EZApplicationBranding.setCopyRight("Created by kjwenger@yahoo.com");
        EZApplicationBranding.setProviderName("kjwenger Software");

        // Add a listener to application startup cycle (see below)
        EZEnvironment.setUIStarterListener(new GooPixUIStarterListener());

        EZGenericApplication.startApplication(args);
    }

}
