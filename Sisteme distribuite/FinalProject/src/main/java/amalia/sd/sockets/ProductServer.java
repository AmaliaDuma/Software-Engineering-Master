package amalia.sd.sockets;

import java.io.*;
import java.net.*;
import java.util.HashSet;
import java.util.Set;

public class ProductServer {
    private static final Set<InetSocketAddress> subscribers = new HashSet<>();
    private static final Set<String> availableProducts = new HashSet<>(Set.of("Product1", "Product2", "Product3", "Product4",
            "Product5"));

    public static void main(String[] args) {
        try {
            int udpPort = 9000;
            DatagramSocket udpServerSocket = new DatagramSocket(udpPort);
            new UDPSubscriptionThread(udpServerSocket).start();

            // TCP Server for product browsing and purchasing
            int tcpPort = 9001;
            ServerSocket tcpServerSocket = new ServerSocket(tcpPort);
            System.out.println("TCP Server is running...");

            while (true) {
                Socket tcpSocket = tcpServerSocket.accept();
                // Separate thread to handle client request
                new TCPClientHandler(tcpSocket).start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    static class UDPSubscriptionThread extends Thread {
        private final DatagramSocket udpSocket;

        public UDPSubscriptionThread(DatagramSocket socket) {
            this.udpSocket = socket;
        }

        public void run() {
            try {
                byte[] receiveData = new byte[1024];
                while (true) {
                    DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
                    udpSocket.receive(receivePacket);

                    InetSocketAddress clientAddress = new InetSocketAddress(receivePacket.getAddress(), receivePacket.getPort());
                    subscribers.add(clientAddress);

                    System.out.println("New subscriber: " + clientAddress);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    static class TCPClientHandler extends Thread {
        private final Socket tcpSocket;

        public
        TCPClientHandler(Socket socket) {
            this.tcpSocket = socket;
        }

        public void run() {
            try {
                // Create input and output streams for the socket
                BufferedReader in = new BufferedReader(new InputStreamReader(tcpSocket.getInputStream()));
                PrintWriter out = new PrintWriter(tcpSocket.getOutputStream(), true);

                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    if (inputLine.equalsIgnoreCase("all")) {
                        // Send available products to the client
                        out.println(String.join(",", availableProducts));
                    }
                    else if(inputLine.contains("buy")) {
                        String product = inputLine.split(" ")[1];
                        if (!availableProducts.contains(product)) {
                            out.println("Product [" + product + "] not found.");
                        } else {
                            availableProducts.remove(product);
                            out.println("Purchase successful!");

                            // Send notification to clients
                            for (InetSocketAddress subscriber : subscribers) {
                                DatagramSocket udpSendSocket = new DatagramSocket();
                                String message = "Product '" + product + "' has been purchased!";
                                byte[] sendData = message.getBytes();
                                DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, subscriber.getAddress(), subscriber.getPort());
                                udpSendSocket.send(sendPacket);
                                udpSendSocket.close();
                            }
                        }
                    }
                    else if (inputLine.equalsIgnoreCase("exit")) {
                        break;
                    }
                    else {
                        out.println("Invalid command");
                    }
                }
                tcpSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

