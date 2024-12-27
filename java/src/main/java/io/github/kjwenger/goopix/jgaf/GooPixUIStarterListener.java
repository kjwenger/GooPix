package io.github.kjwenger.goopix.jgaf;

import com.plealog.genericapp.api.EZUIStarterListener;

import com.formdev.flatlaf.*;

import javax.swing.*;
import java.awt.*;

public class GooPixUIStarterListener implements EZUIStarterListener {

    @Override
    public Component getApplicationComponent() {
        // This method is called by the framework to obtain the UI main
        // component to be displayed in the main frame.

        JPanel mainPanel = new JPanel(new BorderLayout());
        JTabbedPane tabPanel = new JTabbedPane();

        tabPanel.add("GooPix", new JPanel());

        mainPanel.add(tabPanel, BorderLayout.CENTER);
        return mainPanel;
    }

    @Override
    public boolean isAboutToQuit() {
        // You can add some code to figure out if application can exit.

        // Return false to prevent application from exiting (e.g. a background
        // task is still running).
        // Return true otherwise.

        // Do not add a Quit dialogue box to ask user confirmation: the framework
        // already does that for you.
        return true;
    }

    @Override
    public void postStart() {
        // This method is called by the framework
        // just before displaying UI (main frame).
    }

    public void preStart() {
        // This method is called by the framework
        // at the very beginning of application startup.

        try {
            UIManager.setLookAndFeel(new FlatDarkLaf());
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    public void frameDisplayed() {

    }

}
