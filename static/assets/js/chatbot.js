const CHAT_URL  = window.window_CHAT_URL;
const CSRF_TOKEN = window.window_CSRF_TOKEN;

let chatHistory = [];   // [{role, parts:[{text}]}]
let isTyping    = false;

// Auto-grow textarea
const input = document.getElementById('chatInput');
input.addEventListener('input', () => {
  input.style.height = 'auto';
  input.style.height = Math.min(input.scrollHeight, 120) + 'px';
});
input.addEventListener('keydown', e => {
  if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMessage(); }
});

function sendQuick(btn, text) {
  // Hide quick prompts & welcome after first click
  document.getElementById('quickPrompts').style.display = 'none';
  document.getElementById('welcomeBanner').style.display = 'none';
  document.getElementById('chatInput').value = text;
  sendMessage();
}

function appendMsg(role, htmlContent) {
  const row = document.createElement('div');
  row.className = `msg-row ${role}`;

  const avatar = document.createElement('div');
  avatar.className = `msg-avatar ${role}`;
  avatar.textContent = role === 'bot' ? '⚡' : '👤';

  const bubble = document.createElement('div');
  bubble.className = 'bubble';
  bubble.innerHTML  = htmlContent;

  row.appendChild(avatar);
  row.appendChild(bubble);

  const msgs = document.getElementById('messages');
  msgs.appendChild(row);
  msgs.scrollTop = msgs.scrollHeight;
  return row;
}

function showTyping() {
  const row = document.createElement('div');
  row.className = 'msg-row bot';
  row.id = 'typingRow';
  row.innerHTML = `
    <div class="msg-avatar bot">⚡</div>
    <div class="typing-indicator">
      <div class="typing-dot"></div>
      <div class="typing-dot"></div>
      <div class="typing-dot"></div>
    </div>`;
  document.getElementById('messages').appendChild(row);
  document.getElementById('messages').scrollTop = 9999;
}

function removeTyping() {
  const t = document.getElementById('typingRow');
  if (t) t.remove();
}

function escapeHtml(str) {
  return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}

async function sendMessage() {
  const text = input.value.trim();
  if (!text || isTyping) return;

  // Hide welcome content
  document.getElementById('welcomeBanner').style.display = 'none';
  document.getElementById('quickPrompts').style.display  = 'none';

  // Show user bubble
  appendMsg('user', escapeHtml(text));

  // Clear input
  input.value = '';
  input.style.height = 'auto';

  // Disable send
  isTyping = true;
  const btn = document.getElementById('sendBtn');
  btn.disabled = true;
  btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';

  // Typing indicator
  showTyping();

  try {
    const resp = await fetch(CHAT_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRFToken': CSRF_TOKEN,
      },
      body: JSON.stringify({ message: text, history: chatHistory }),
    });

    const data = await resp.json();
    removeTyping();

    const replyText  = data.reply || "Sorry, I couldn't process that. ⚡";
    const replyHtml  = marked.parse(replyText);

    appendMsg('bot', replyHtml);

    // Update history
    chatHistory.push({ role: 'user',  parts: [{ text: text }] });
    chatHistory.push({ role: 'model', parts: [{ text: replyText }] });

    // Keep history bounded (last 20 turns)
    if (chatHistory.length > 40) chatHistory = chatHistory.slice(-40);

  } catch (err) {
    console.error('Chat error:', err);
    removeTyping();
    appendMsg('bot', `⚡ <em>Connection error. Please check your internet and try again.</em>`);
  } finally {
    isTyping = false;
    btn.disabled = false;
    btn.innerHTML = '<i class="fas fa-paper-plane"></i>';
    input.focus();
  }
}

function clearChat() {
  chatHistory = [];
  const msgs = document.getElementById('messages');
  msgs.innerHTML = `
    <div class="welcome-banner" id="welcomeBanner">
      <span class="icon">⚡</span>
      <h2>Chat Cleared! Hello Again 👋</h2>
      <p>Start a new conversation about home appliances!</p>
    </div>
    <div class="quick-prompts" id="quickPrompts">
      <button class="quick-btn" onclick="sendQuick(this,'Best AC under ₹35,000')">❄️ Best AC under ₹35k</button>
      <button class="quick-btn" onclick="sendQuick(this,'Best refrigerator under ₹20,000')">🧊 Fridge under ₹20k</button>
      <button class="quick-btn" onclick="sendQuick(this,'Compare washing machines')">🫧 Compare Washing Machines</button>
      <button class="quick-btn" onclick="sendQuick(this,'My fridge is not cooling. How to fix it?')">🔧 Fridge Not Cooling</button>
      <button class="quick-btn" onclick="sendQuick(this,'Best deals and offers available today')">🏷️ Today's Offers</button>
      <button class="quick-btn" onclick="sendQuick(this,'Show me premium TVs')">📺 Premium TVs</button>
    </div>`;
}