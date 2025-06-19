import { createConsumer } from '@anycable/web'

const cable = createConsumer();

cable.subscriptions.create("LLMChannel", {
  connected: function() {
    console.log("LLMChannel connected");
  },

  disconnected: function() {
  },

  received: function(data) {
    console.log(data['id'], data['field_name'], data['content']);
  }
});
