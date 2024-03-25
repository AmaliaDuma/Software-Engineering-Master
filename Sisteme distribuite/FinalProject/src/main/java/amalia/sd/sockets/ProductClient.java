package amalia.sd.sockets;

import java.io.*;
import java.net.*;
import java.util.Random;

public class ProductClient {
    private static final String serverAddress = "127.0.0.1";

    public static void main(String[] args) {
        try {
            Random random = new Random();
            int udpPort = random.nextInt(9999);
            // UDP thread that will listen for notifications from server
            new UDPClientThread(udpPort).start();

            // TCP thread that will handle the communication with the server
            new TCPClientThread().start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    static class UDPClientThread extends Thread {
        private final DatagramSocket udpSocket;

        public UDPClientThread(int port) {
            try {
                this.udpSocket = new DatagramSocket(port);
            } catch (Exception e) {
                throw new RuntimeException("UDP socket could not be created due to: " + e.getMessage());
            }
        }

        public void run() {
            try {
                String message = ""; byte[] sendData = message.getBytes();
                int udpPort = 9000;
                DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, InetAddress.getByName(serverAddress), udpPort);
                udpSocket.send(sendPacket);

                while (true) {
                    byte[] buffer = new byte[1024];
                    DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                    udpSocket.receive(packet);

                    message = new String(packet.getData(), 0, packet.getLength());
                    if (message.equalsIgnoreCase("exit")) {
                        udpSocket.close();
                        break;
                    } else {
                        System.out.println("[Server]: " + message);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    static class TCPClientThread extends Thread {
        private final Socket tcpSocket;
        private final int tcpServerPort = 9001;

        public TCPClientThread() {
            try {
                this.tcpSocket = new Socket(serverAddress, tcpServerPort);
            } catch (Exception e) {
                throw new RuntimeException("TCP socket could not be created due to: " + e.getMessage());
            }
        }

        public void run() {
            try {
                // Create input and output streams for the socket
                BufferedReader in = new BufferedReader(new InputStreamReader(tcpSocket.getInputStream()));
                PrintWriter out = new PrintWriter(tcpSocket.getOutputStream(), true);

                // Create a BufferedReader to read user input from the console
                BufferedReader consoleInput = new BufferedReader(new InputStreamReader(System.in));

                String userInput;
                while (true) {
                    System.out.println("Enter a message: \n 'all' - see all products \n 'buy' + name of the product you want to buy \n 'exit' ");
                    userInput = consoleInput.readLine();

                    // Send the user's input to the server
                    out.println(userInput);

                    if (userInput.equalsIgnoreCase("exit")) { break; }

                    String serverResponse = in.readLine();
                    System.out.println("[Server]: " + serverResponse);

                }
                // Close the socket
                tcpSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

