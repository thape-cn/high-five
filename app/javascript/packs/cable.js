import { createConsumer } from '@anycable/web'

const cable = createConsumer();

cable.subscriptions.create("LLMChannel", {
  connected: function() {
    console.log("LLMChannel connected");
  },

  disconnected: function() {
  },

  received: function(data) {
    if (data['command'] == 'reload') {
      window.location.reload();
    } else {
      const span = document.getElementById(data['id']);
      if (span && data['content'] === null) {
        span.textContent = '';
      } else if (data['content']) {
        span.textContent += data['content'];
      }
    }
  }
});
