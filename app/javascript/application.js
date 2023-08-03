// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

// document.addEventListener("DOMContentLoaded", function() {
//     // Establish WebSocket connection
//     const cable = ActionCable.createConsumer();
//
//     // Subscribe to the channel
//     const channel = cable.subscriptions.create("ChatChannel", {
//         connected() {
//             console.log("Connected to the chat channel.");
//         },
//         disconnected() {
//             console.log("Disconnected from the chat channel.");
//         },
//         received(data) {
//             console.log("Received data:", data);
//             // Handle received data from the server
//         }
//     });
//
//     // Send data to the server
//     // You can call this function whenever you want to send data to the server
//     function sendDataToServer(data) {
//         channel.send(data);
//     }
//
//     // Example of sending data to the server
//     sendDataToServer({ message: "Hello, Server!" });
// });