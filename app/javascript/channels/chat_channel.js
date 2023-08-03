import consumer from "./consumer"
const chatChannel = consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("Connected to channel");
  },
  disconnected() {},
  received(data) {
    console.log("received");
    console.log(data);

    const chatId = data.chat_id;
    const message = data.message;
    const response = data.response;

    const chatContainer = document.getElementById(`chat_${chatId}`);
    if (chatContainer) {
      const messages = chatContainer.querySelector("ul#messages");
      messages.innerHTML += `<li class="d-flex align-items-center justify-content-end text-primary">${message}</li>`;
    }
    if (chatContainer) {
      const responses = chatContainer.querySelector("#messages");
      responses.innerHTML += `<li>${response}</li>`;
    }
  },
});

const chatList = document.querySelectorAll(".chat-name");

chatList.forEach((chat) => {
  chat.addEventListener("click", (event) => {
    const chatId = event.target.getAttribute("data-chat-id");
    messageInput.setAttribute("data-chat-id", chatId);

    const chatContainers = document.querySelectorAll(".content > div");
    chatContainers.forEach((container) => {
      container.style.display = "none";
    });

    const selectedChatContainer = document.getElementById(`chat_${chatId}`);
    if (selectedChatContainer) {
      selectedChatContainer.style.display = "block";
    }
  });
});

const messageInput = document.getElementById("message_input");
messageInput.addEventListener("keydown", (event) => {
  if (event.key === "Enter") {
    const chatId = messageInput.getAttribute("data-chat-id");
    if (!chatId) {
      console.log("Please select a chat first.");
      return;
    }

    chatChannel.send({ chat_id: chatId, message: event.target.value });
    event.target.value = "";
  }
});

async function fetchExistingMessages() {
  const chatContainers = document.querySelectorAll(".content > div");
  for (const container of chatContainers) {
    const chatId = container.id.replace("chat_", "");
    const response = await fetch(`/chats/${chatId}/messages`);
    const messages = await response.json();
    const messagesList = container.querySelector("ul#messages");
    messagesList.innerHTML = ""; // Clear the existing list
    messages.forEach((message) => {
      messagesList.innerHTML += `<li data-chat-id="${chatId}">${message.content}</li>`;
    });
  }
}


window.addEventListener("DOMContentLoaded", () => {
  fetchExistingMessages();

  // Show the messages of the latest chat by default
  const latestChat = document.querySelector(".chat-name:first-child");
  if (latestChat) {
    const chatId = latestChat.getAttribute("data-chat-id");
    messageInput.setAttribute("data-chat-id", chatId);

    const chatContainers = document.querySelectorAll(".content > div");
    chatContainers.forEach((container) => {
      container.style.display = "none";
    });

    const selectedChatContainer = document.getElementById(`chat_${chatId}`);
    if (selectedChatContainer) {
      selectedChatContainer.style.display = "block";
    }
  }
});