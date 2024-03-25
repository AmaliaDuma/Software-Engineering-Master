package amalia.sd.cloud;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ConversionApp extends JFrame {
    private JButton sendButton;
    private JButton send2Button;

    private JTextArea inputTextArea;
    private JTextArea resultTextArea;

    private JTextArea input2TextArea;
    private JTextArea result2TextArea;
    private JRadioButton jsonRadioButton;
    private JRadioButton xmlRadioButton;

    public ConversionApp() {
        setTitle("JSON/XML Converter");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Radio buttons for selecting JSON or XML
        jsonRadioButton = new JRadioButton("JSON");
        xmlRadioButton = new JRadioButton("XML");
        ButtonGroup group = new ButtonGroup();
        group.add(jsonRadioButton);
        group.add(xmlRadioButton);

        // Text area for input
        inputTextArea = new JTextArea();
        inputTextArea.setLineWrap(true);
        JScrollPane inputScrollPane = new JScrollPane(inputTextArea);

        input2TextArea = new JTextArea();
        input2TextArea.setLineWrap(true);
        JScrollPane input2ScrollPane = new JScrollPane(input2TextArea);

        // Text area for result
        resultTextArea = new JTextArea();
        resultTextArea.setEditable(false);
        resultTextArea.setLineWrap(true);
        JScrollPane resultScrollPane = new JScrollPane(resultTextArea);

        result2TextArea = new JTextArea();
        result2TextArea.setEditable(false);
        result2TextArea.setLineWrap(true);
        JScrollPane result2ScrollPane = new JScrollPane(result2TextArea);

        // Send button
        sendButton = new JButton("Convert");
        sendButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String input = inputTextArea.getText();
                String result = callCloudFunction(input, false);
                resultTextArea.setText(result);
            }
        });

        send2Button = new JButton("Get class");
        send2Button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String input = input2TextArea.getText();
                String result = callCloudFunction(input, true);
                result2TextArea.setText(result);
            }
        });

        // Panel layout
        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        panel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10)); // Add some padding

        // Add radio buttons
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.gridwidth = 2;
        gbc.anchor = GridBagConstraints.WEST;
        panel.add(jsonRadioButton, gbc);
        gbc.gridy++;
        panel.add(xmlRadioButton, gbc);

        // Add inputScrollPane
        gbc.gridy++;
        gbc.gridx = 0;
        gbc.gridwidth = 1;
        gbc.weightx = 1;
        gbc.weighty = 1;
        gbc.fill = GridBagConstraints.BOTH;
        panel.add(inputScrollPane, gbc);

        // Add resultScrollPane
        gbc.gridx = 1;
        panel.add(resultScrollPane, gbc);

        // Add sendButton
        gbc.gridy++;
        gbc.gridx = 0;
        gbc.gridwidth = 2;
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.anchor = GridBagConstraints.CENTER;
        panel.add(sendButton, gbc);

        gbc.gridy++;
        gbc.gridx = 0;
        gbc.gridwidth = 2;
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.anchor = GridBagConstraints.CENTER;
        JLabel label = new JLabel("JSON to Java class");
        panel.add(label, gbc);

        // Add inputScrollPane
        gbc.gridy++;
        gbc.gridx = 0;
        gbc.gridwidth = 1;
        gbc.weightx = 1;
        gbc.weighty = 1;
        gbc.fill = GridBagConstraints.BOTH;
        panel.add(input2ScrollPane, gbc);

        // Add resultScrollPane
        gbc.gridx = 1;
        panel.add(result2ScrollPane, gbc);

        gbc.gridy++;
        gbc.gridx = 0;
        gbc.gridwidth = 2;
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.anchor = GridBagConstraints.CENTER;
        panel.add(send2Button, gbc);

        // Add panel to the frame
        add(panel);

        setVisible(true);
    }

    private String callCloudFunction(String input, boolean isClass) {
        try {
            String functionUrl = "https://europe-west1-balmy-chain-410018.cloudfunctions.net/SD_Proiect";

            String formatParam = "";
            if (isClass) {
                formatParam = "format=class";
            } else {
                if (jsonRadioButton.isSelected()) {
                    formatParam = "format=json";
                } else if (xmlRadioButton.isSelected()) {
                    formatParam = "format=xml";
                }
            }


            // Append format parameter to function URL
            if (!formatParam.isEmpty()) {
                functionUrl += "?" + formatParam;
            }

            URL url = new URL(functionUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "text/plain");
            conn.setDoOutput(true);

            // Write input data to the connection
            conn.getOutputStream().write(input.getBytes());

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode() + conn.getResponseMessage());
            }

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            StringBuilder response = new StringBuilder();
            String output;
            while ((output = br.readLine()) != null) {
                response.append(output);
            }

            conn.disconnect();

            return response.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return "Failed to call cloud function.";
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new ConversionApp();
            }
        });
    }
}
